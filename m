Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF35EAD04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIZQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIZQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F113DFD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B637C60EB3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2279C433D7;
        Mon, 26 Sep 2022 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664206801;
        bh=jIcb5daet5kGSuxWvbwSe3MVMh+FF012cin0rfSzRQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C92xsykG6Tpu3Vok/h7HInPhm1iJNg5+5HttGpEYss7rVBWZjqI7SabQDa/hQw1Hn
         wz1e+I8euq2Zs3Qnd7Ng9I7w840CiRBhRzJBk+qjp5+VPaqfPnOk5EObdQ2rUM2SYw
         vxuoZqSxxdltZfM8JZgZzysOQLK6OtMfmGn730kVYuwypeJJUM3xCnZTQ0NM9SQKVy
         qPMZbw9D6niSPXB6uoGLFH7F2aLlsMsHD6st2BJ21GShzEUwvl5iYFX5rsHlPzU8Av
         hVWxRdQkEgUevHGsJ3oBxOPkU9WcsMgIQCI0IQ4ndJc+VpgPAmZDBM127eoluhMnlp
         8jpKytWt7HpXQ==
Date:   Mon, 26 Sep 2022 08:39:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: mainline build failure for x86_64 and arm64 with clang
Message-ID: <YzHHz0S8/Nq1QivU@dev-arch.thelio-3990X>
References: <YzFo/+uF1jJ7gMIN@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzFo/+uF1jJ7gMIN@debian>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Mon, Sep 26, 2022 at 09:55:27AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> Yesterday I updated my clang to:
> clang version 16.0.0 (https://github.com/llvm/llvm-project.git bcb1397bda667e75200ae0be9a65fd17dd0763d4)
> 
> And with that I see new build failures of mainline.
> 
> I am not copying all the errors but others look similar to these.
> From x86_64 almodconfig:
> 
> In file included from scripts/mod/devicetable-offsets.c:3:
> In file included from ./include/linux/mod_devicetable.h:13:
> In file included from ./include/linux/uuid.h:12:
> In file included from ./include/linux/string.h:253:
> ./include/linux/fortify-string.h:159:10: error: ISO C does not allow indirection on operand of type 'void *' [-Werror,-Wvoid-ptr-dereference]
>         q_len = strlen(q);
>                 ^~~~~~~~~
> 
> From x86_64 defconfig:
> 
> In file included from arch/x86/kernel/asm-offsets.c:9:
> In file included from ./include/linux/crypto.h:20:
> In file included from ./include/linux/slab.h:15:
> In file included from ./include/linux/gfp.h:7:
> In file included from ./include/linux/mmzone.h:8:
> In file included from ./include/linux/spinlock.h:55:
> In file included from ./include/linux/preempt.h:78:
> In file included from ./arch/x86/include/asm/preempt.h:7:
> In file included from ./include/linux/thread_info.h:60:
> In file included from ./arch/x86/include/asm/thread_info.h:53:
> In file included from ./arch/x86/include/asm/cpufeature.h:5:
> In file included from ./arch/x86/include/asm/processor.h:22:
> In file included from ./arch/x86/include/asm/msr.h:11:
> In file included from ./arch/x86/include/asm/cpumask.h:5:
> In file included from ./include/linux/cpumask.h:12:
> In file included from ./include/linux/bitmap.h:9:
> ./include/linux/find.h:119:31: error: ISO C does not allow indirection on operand of type 'void *' [-Werror,-Wvoid-ptr-dereference]
>                 unsigned long val = *addr & GENMASK(size - 1, 0);
>                                             ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:38:3: note: expanded from macro 'GENMASK'
>         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>          ^~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bits.h:25:3: note: expanded from macro 'GENMASK_INPUT_CHECK'
>                 __is_constexpr((l) > (h)), (l) > (h), 0)))
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/const.h:12:25: note: expanded from macro '__is_constexpr'
>         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
>                                ^
> ./include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> 
> 
> From arm64 allmodconfig:
> 
> In file included from scripts/mod/devicetable-offsets.c:3:
> In file included from ./include/linux/mod_devicetable.h:13:
> In file included from ./include/linux/uuid.h:12:
> In file included from ./include/linux/string.h:253:
> ./include/linux/fortify-string.h:159:10: error: ISO C does not allow indirection on operand of type 'void *' [-Werror,-Wvoid-ptr-dereference]
>         q_len = strlen(q);
>                 ^~~~~~~~~
> ./include/linux/fortify-string.h:131:24: note: expanded from macro 'strlen'
>         __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/const.h:12:25: note: expanded from macro '__is_constexpr'
>         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I dont know if its some regression introduced in clang, or really a kernel issue.
> 
> I will go back to my previous clang version (329b972d416a) for now untill I know more.

Thanks for testing and the report! I noticed this over the weekend, it
comes from a new warning in clang:

https://github.com/llvm/llvm-project/commit/e07ead85a368173a56e96a21d6841aa497ad80f8

It was brought up on GitHub as well:

https://github.com/ClangBuiltLinux/linux/issues/1720

I have reported this to the clang developers upstream to see if there is
any way that the diagnostic could be improved:

https://reviews.llvm.org/D134461#3815298

Otherwise, we will just have to disable it, which I will send a patch
for later if the warning is not going to be adjusted in any way.

If you wanted to continue testing with upstream LLVM, you can either
just revert that commit or explicitly disable -Wvoid-ptr-dereference in
the main Makefile like so, which is ultimately what I will send if I
need to.

Cheers,
Nathan

diff --git a/Makefile b/Makefile
index 647a42a1f800..0bf60134f13c 100644
--- a/Makefile
+++ b/Makefile
@@ -967,6 +967,9 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 # Another good warning that we'll want to enable eventually
 KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 
+# New warning from clang that is quite noisy due to '__is_constexpr'
+KBUILD_CFLAGS += $(call cc-disable-warning, void-ptr-dereference)
+
 # Enabled with W=2, disabled by default as noisy
 ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += -Wno-maybe-uninitialized
