Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14EE69CB94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjBTNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjBTNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:07:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ED191B541
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:07:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A5415BF;
        Mon, 20 Feb 2023 05:08:02 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655A03F881;
        Mon, 20 Feb 2023 05:07:18 -0800 (PST)
Date:   Mon, 20 Feb 2023 13:07:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     syzbot <syzbot+f8ac312e31226e23302b@syzkaller.appspotmail.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org, ardb@kernel.org
Subject: Re: [syzbot] upstream-arm64 build error
Message-ID: <Y/Nwfrb42e6MRrAi@FVFF77S0Q05N>
References: <00000000000028ea4105f4e2ef54@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000028ea4105f4e2ef54@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:39:55AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2d3827b3f393 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=160f19d7480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5c7f0c5a0c5dbdb
> dashboard link: https://syzkaller.appspot.com/bug?extid=f8ac312e31226e23302b
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f8ac312e31226e23302b@syzkaller.appspotmail.com
> 
> failed to run ["make" "-j" "64" "ARCH=arm64" "CROSS_COMPILE=aarch64-linux-gnu-" "CC=clang" "Image.gz"]: exit status 2

For the benefit of others, the actual error from the console log is:

  LD      .tmp_vmlinux.kallsyms1
  aarch64-linux-gnu-ld: ID map text too big or misaligned
  make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
  make: *** [Makefile:1264: vmlinux] Error 2

... and I see the same on for-next/core with my usual fuzzing configs applied
atop, building with GCC 12.1.0.

That "ID map text too big or misalignes" error is from an assertion in arm64's
vmlinux.lds.S, and if I hack that out, the kernel builds and the idmap text
section is 4K aligned and ~2900 bytes in size.

My config worked on v6.2-rc3, and bisecting led me to commit:

  3dcf60bbfd284e5e ("arm64: head: Clean the ID map and the HYP text to the PoC if needed")

... which plays with sections a bit, but doesn't do anything obviously wrong.

I think the error is misleading, and what's actually happening here is that the
size of the .idmap.text section hasn't been determined at the point the
assertion is tested.

With my config, the Image size is ~242MiB, and I think what's happening is that
some branches from .idmap.text to .text are (possibly) out-of-range, but the
linker doesn't know the final position of the sections yet and hasn't placed
PLTs, and doesn't know the final size of the sections.

I don't know much about the linker, so that's conjecture, but the below diff
got rid of the build error for me.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 212d93aca5e61..13d6f1018eaa1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -99,7 +99,8 @@ SYM_CODE_START(primary_entry)
        cbz     x19, 0f
        adrp    x0, __idmap_text_start
        adr_l   x1, __idmap_text_end
-       bl      dcache_clean_poc
+       adr_l   x2, dcache_clean_poc
+       blr     x2
 0:     mov     x0, x19
        bl      init_kernel_el                  // w0=cpu_boot_mode
        mov     x20, x0
@@ -566,7 +567,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
        cbz     x0, 0f
        adrp    x0, __hyp_idmap_text_start
        adr_l   x1, __hyp_text_end
-       bl      dcache_clean_poc
+       adr_l   x2, dcache_clean_poc
+       blr     x2
 0:
        mov_q   x0, HCR_HOST_NVHE_FLAGS
        msr     hcr_el2, x0
