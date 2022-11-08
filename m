Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384D621F68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKHWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:40:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1560355
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A279061791
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 22:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21345C433D6;
        Tue,  8 Nov 2022 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667947211;
        bh=tgOlQ7e91htQ+a0QF8fCuYAypa3x198TePZ2cKxzH/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwMvOENdAiS7yqx1Q1o1AvcIotHXZqmVWMC2kd12DYiB/ZX5cWdSHi5yxgVTrRQxi
         /W/ZauUiwuZoRQS/6RI2nmNiE1H7El9+wF5eFQzBkO1R6trY9NYG1BFqXFrwjWgr7r
         gOR1vET7JJFu4ZhrWQUdJNXtvgVdONf7EszSygol+2FRjt3tya/XqkpOrTrPzkwGeJ
         yROIR+Uth6f2TrMaJe2/LIL0qs6458thQh6YzrmKb+eYL3ybvhEQuN1dgODnToK5Bo
         1nCyvtYFeiEOSfk98LPHtZP1diapa/bBX90X6Si3BFbQeIxo0evL3kLWY2+rfDiZ+/
         IdZUEIiNbA73g==
Date:   Tue, 8 Nov 2022 15:40:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     guoj17@chinatelecom.cn
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        huyd12@chinatelecom.cn
Subject: Re: [PATCH] locking: fix kernel/locking/ inline asm error
Message-ID: <Y2rayPgDfL2NYcjQ@dev-arch.thelio-3990X>
References: <20221108060126.2505-1-guoj17@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108060126.2505-1-guoj17@chinatelecom.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:01:26PM +0800, guoj17@chinatelecom.cn wrote:
> From: Guo Jin <guoj17@chinatelecom.cn>
> 
> When compiling linux 6.1.0-rc3 configured with CONFIG_64BIT=y
> and CONFIG_PARAVIRT_SPINLOCKS=y on x86_64 using LLVM 11.0,
> an error: "<inline asm> error: changed section flags for
> .spinlock.text, expected:: 0x6" occurred.
> 
> The reason is the .spinlock.text in kernel/locking/qspinlock.o
> is used many times, but its flags are omitted in subsequent use.
> 
> LLVM 11.0 assembler didn't permit to
> leave out flags in subsequent uses of the same sections.
> 
> So this patch adds the corresponding flags to avoid above error.
> 
> Signed-off-by: Guo Jin <guoj17@chinatelecom.cn>

Right, my reverse bisect tells me that this error was fixed by [1] in
LLVM, which landed in 12.0.0 and was backported to LLVM 11.0.1 [2].

We could bump the minimum supported version of LLVM for building the
kernel to 11.0.1 over this, just to avoid further issues like this down
the road, as the kernel will always be adding new sections for various
things. That change would not appear to be disruptive, as all the major
distros either have 11.0.1 or newer or older than the current minimum of
11.0.0, so they need to get clang from elsewhere already.

archlinux:latest: clang version 14.0.6

debian:oldoldstable-slim: clang version 3.8.1-24 (tags/RELEASE_381/final)
debian:oldstable-slim: clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
debian:stable-slim: Debian clang version 11.0.1-2
debian:testing-slim: Debian clang version 14.0.6-2
debian:unstable-slim: Debian clang version 14.0.6-7

fedora:35: clang version 13.0.1 (Fedora 13.0.1-1.fc35)
fedora:latest: clang version 14.0.5 (Fedora 14.0.5-1.fc36)
fedora:rawhide: clang version 15.0.4 (Fedora 15.0.4-1.fc38)

opensuse/leap:15: clang version 13.0.1
opensuse/leap:latest: clang version 13.0.1
opensuse/tumbleweed:latest: clang version 15.0.3

ubuntu:bionic: clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
ubuntu:focal: clang version 10.0.0-4ubuntu1
ubuntu:latest: Ubuntu clang version 14.0.0-1ubuntu1
ubuntu:kinetic: Ubuntu clang version 15.0.2-1
ubuntu:rolling: Ubuntu clang version 15.0.2-1
ubuntu:devel: Ubuntu clang version 15.0.2-1

At the same time, you are clearly using LLVM 11.0.0, so I think this is a
reasonable fix in the immediate term.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://github.com/llvm/llvm-project/commit/1deff4009e0ae661b03682901bf6932297ce7ea1
[2]: https://github.com/llvm/llvm-project/commit/700baa009dc685a0adc5f94d258be4ae24742471

> ---
>  arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
> index 60ece592b220..dbb38a6b4dfb 100644
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -37,7 +37,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
>   *   rsi = lockval           (second argument)
>   *   rdx = internal variable (set to 0)
>   */
> -asm    (".pushsection .spinlock.text;"
> +asm    (".pushsection .spinlock.text, \"ax\";"
>  	".globl " PV_UNLOCK ";"
>  	".type " PV_UNLOCK ", @function;"
>  	".align 4,0x90;"
> -- 
> 2.25.1
> 
