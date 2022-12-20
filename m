Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E46527AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiLTUOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiLTUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:14:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BFD1E72E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:14:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFD76156F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3168DC433EF;
        Tue, 20 Dec 2022 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671567273;
        bh=g4z01Qkq/i8TPjXgNA6oMbzywGrH9WcNfZMzaDUNKl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvQtM0Bs6zKmE4yGkY/9LVBdLl7Ozoj2M25NmMtsVqd9062l5eceZWw4P9CCeznCh
         A+I/BV1ev1LjBtf7Xp27QTUL5+iK7WK3IHRP9fvJG1GebxpHmDlsudqUV2ct/YFB3t
         aucS0rOIvg/+Y8Hqsu5gYTS4m392lKpU0JkEGKZGhuDrQkMPLsVw3+M8gyLcoxFsEQ
         C1ifXDpZ7s4TczCUE4O7D7a1XPgncAWf+fyS+pBjgxHr4Fm1VSCc1IotfNNQMnKvDb
         wrx0n19UmoVwyzrMV7jUQQOxBNo/svKh7XHyIAJLj9JS2xCS3ctmr09d4+rVcLDsHq
         MmFxb4d5D5Ufg==
Received: by pali.im (Postfix)
        id 82E4C963; Tue, 20 Dec 2022 21:14:30 +0100 (CET)
Date:   Tue, 20 Dec 2022 21:14:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] powerpc: Pass correct CPU reference to assembler
Message-ID: <20221220201430.xopin6ezcdk5f66k@pali>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <758ad54128fa9dd2fdedc4c511592111cbded900.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <758ad54128fa9dd2fdedc4c511592111cbded900.1671475543.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2022 19:45:57 Christophe Leroy wrote:
> Jan-Benedict reported issue with building ppc64e_defconfig
> with mainline GCC work:
> 
>   powerpc64-linux-gcc -Wp,-MMD,arch/powerpc/kernel/vdso/.gettimeofday-64.o.d -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -I ./arch/powerpc -DHAVE_AS_ATHIGH=1 -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64 -Wl,-a64 -mabi=elfv1 -Wa,-me500 -Wa,-me500mc -mabi=elfv1 -mbig-endian    -Wl,-soname=linux-vdso64.so.1 -D__VDSO64__ -s -c -o arch/powerpc/kernel/vdso/gettimeofday-64.o arch/powerpc/kernel/vdso/gettimeofday.S
> 	arch/powerpc/kernel/vdso/gettimeofday.S: Assembler messages:
> 	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `stdu'
> 	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `stdu'
> 	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `std'
> 	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `std'
> 	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `ld'
> 	arch/powerpc/kernel/vdso/gettimeofday.S:72: Error: unrecognized opcode: `ld'
> 	...
> 	make[1]: *** [arch/powerpc/kernel/vdso/Makefile:76: arch/powerpc/kernel/vdso/gettimeofday-64.o] Error 1
> 	make: *** [arch/powerpc/Makefile:387: vdso_prepare] Error 2
> 
> This is due to assembler being called with -me500mc which is
> a 32 bits target.
> 
> The problem comes from the fact that CONFIG_PPC_E500MC is selected for
> both the e500mc (32 bits) and the e5500 (64 bits), and therefore the
> following makefile rule is wrong:
> 
>   cpu-as-$(CONFIG_PPC_E500MC)    += $(call as-option,-Wa$(comma)-me500mc)
> 
> Today we have CONFIG_TARGET_CPU which provides the identification of the
> expected CPU, it is used for GCC. Once GCC knows the target CPU, it adds
> the correct CPU option to assembler, no need to add it explicitely.
> 
> With that change (And also commit 825eada7717c ("powerpc/64: Set
> default CPU in Kconfig")), it now is:
> 
>   powerpc64-linux-gcc -Wp,-MMD,arch/powerpc/kernel/vdso/.gettimeofday-64.o.d -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -I ./arch/powerpc -DHAVE_AS_ATHIGH=1 -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64 -Wl,-a64 -mabi=elfv1 -mcpu=e500mc64 -mabi=elfv1 -mbig-endian    -Wl,-soname=linux-vdso64.so.1 -D__VDSO64__ -s -c -o arch/powerpc/kernel/vdso/gettimeofday-64.o arch/powerpc/kernel/vdso/gettimeofday.S
> 
> Reported-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> v3: Remove -Wa,-mXXX completery as there are additional mismatches between -mcpu and -Wa-m (eg: 8540 vs e500). When given the proper -mcpu=, GCC gives the correct option to assembler.
> 
> v2: When target cpu is powerpc, the option to be used is -mppc
> 
> Commit 825eada7717c is in powerpc/next-test branch. Make sure the SHA doesn't change when it goes into powerpc/next
> ---
>  arch/powerpc/Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index bf5f0a998273..0f9f291895cb 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -201,18 +201,14 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  # often slow when they are implemented at all
>  KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
>  
> -cpu-as-$(CONFIG_40x)		+= -Wa,-m405
> -cpu-as-$(CONFIG_44x)		+= -Wa,-m440
>  cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
> -cpu-as-$(CONFIG_PPC_E500)		+= -Wa,-me500
>  
>  # When using '-many -mpower4' gas will first try and find a matching power4
>  # mnemonic and failing that it will allow any valid mnemonic that GAS knows
>  # about. GCC will pass -many to GAS when assembling, clang does not.
>  # LLVM IAS doesn't understand either flag: https://github.com/ClangBuiltLinux/linux/issues/675
>  # but LLVM IAS only supports ISA >= 2.06 for Book3S 64 anyway...
> -cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-mpower4) $(call as-option,-Wa$(comma)-many)
> -cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
> +cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)
>  
>  KBUILD_AFLAGS += $(cpu-as-y)
>  KBUILD_CFLAGS += $(cpu-as-y)
> -- 
> 2.38.1
> 
