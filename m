Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38552649560
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiLKRcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 12:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 12:32:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E121A6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 09:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 084ACB80884
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 17:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA8BC433D2;
        Sun, 11 Dec 2022 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670779955;
        bh=GnbGX190nbIDyCV6ahpz9IvylT61XXWwj1Tl9mATvhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XuECyXjLx7Kf3xopKJxhflv4u5vHeeC/5ZppSVAuUeWqNWUTnQ7EYQuWPAI05WHCh
         YbqmP2/01hV32axzaNdAG+7WErfMB3VYX0AdsVJ/qoPKiZX1CyEXYI/bT2WJuJX/5i
         4wqv3U/z1MdfKhUgtDWK7AnerdmWXoBdL9YbW7zbsh9pNin4yu7moBjToALfpk4xA/
         W4gbU4oZL2VqRSlz0e3dhpaJjzTByx+4EoVhdtLi+I21PMLUi39BBbbblMkFB0cMT1
         kq3D/qvwQwO/+f3L2tpAJEX2yu/rUICjRNmLommTJ9iceSmczjtt8/CXM+b05PwkXI
         +JomN1cjQhLSg==
Received: by pali.im (Postfix)
        id 73B5C872; Sun, 11 Dec 2022 18:32:32 +0100 (CET)
Date:   Sun, 11 Dec 2022 18:32:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 5/5] powerpc/64e: Fix build failure with GCC 12
 (unrecognized opcode: `wrteei')
Message-ID: <20221211173232.7hvgnadyr7wrdm2f@pali>
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
 <77255a5a957967723b84d0356d9e5fb21569f4e8.1657549153.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77255a5a957967723b84d0356d9e5fb21569f4e8.1657549153.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2022 16:19:33 Christophe Leroy wrote:
> With GCC 12, corenet64_smp_defconfig leads to the following build errors:
> 
>   CC      arch/powerpc/kernel/irq.o
> {standard input}: Assembler messages:
> {standard input}:3616: Error: unrecognized opcode: `wrteei'
> {standard input}:5689: Error: unrecognized opcode: `wrteei'
>   CC      arch/powerpc/kernel/pmc.o
> {standard input}: Assembler messages:
> {standard input}:42: Error: unrecognized opcode: `mfpmr'
> {standard input}:53: Error: unrecognized opcode: `mtpmr'
>   CC      arch/powerpc/kernel/io.o
> {standard input}: Assembler messages:
> {standard input}:376: Error: unrecognized opcode: `mbar'
> ...
>   CC      arch/powerpc/mm/nohash/book3e_hugetlbpage.o
> {standard input}: Assembler messages:
> {standard input}:291: Error: unrecognized opcode: `tlbsx'
> {standard input}:482: Error: unrecognized opcode: `tlbwe'
> {standard input}:608: Error: unrecognized opcode: `lbarx'
> {standard input}:608: Error: unrecognized opcode: `stbcx.'
> 
> -mpcu=powerpc64 cannot be used anymore for book3e, it must be a booke CPU.
> 
> But then we get:
> 
>   CC      arch/powerpc/lib/xor_vmx.o
> cc1: error: AltiVec not supported in this target
> 
> Altivec is not supported with -mcpu=e5500 so don't allow selection
> of altivec when e5500 is selected.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Makefile                  | 8 +-------
>  arch/powerpc/platforms/Kconfig.cputype | 8 ++++----
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index d54e1fe03551..02742facf895 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -168,13 +168,7 @@ endif
>  CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
>  AFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
>  
> -# Altivec option not allowed with e500mc64 in GCC.
> -ifdef CONFIG_ALTIVEC
> -E5500_CPU := -mcpu=powerpc64
> -else
> -E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
> -endif
> -CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
> +CFLAGS-$(CONFIG_E5500_CPU) += $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
>  CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))

Hello! I think that there is an issue. After removal of E5500_CPU
variable few line above, it cannot be used in CFLAGS-$(CONFIG_E6500_CPU)
assignment, because it is empty.

>  
>  asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 3cc8452b8660..5185d942b455 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -126,12 +126,12 @@ choice
>  
>  config GENERIC_CPU
>  	bool "Generic (POWER4 and above)"
> -	depends on PPC64 && !CPU_LITTLE_ENDIAN
> -	select PPC_64S_HASH_MMU if PPC_BOOK3S_64
> +	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
> +	select PPC_64S_HASH_MMU
>  
>  config GENERIC_CPU
>  	bool "Generic (POWER8 and above)"
> -	depends on PPC64 && CPU_LITTLE_ENDIAN
> +	depends on PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select PPC_64S_HASH_MMU
>  
> @@ -358,7 +358,7 @@ config PHYS_64BIT
>  
>  config ALTIVEC
>  	bool "AltiVec Support"
> -	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
> +	depends on PPC_BOOK3S || (PPC_E500MC && PPC64 && !E5500_CPU)
>  	select PPC_FPU
>  	help
>  	  This option enables kernel support for the Altivec extensions to the
> -- 
> 2.36.1
> 
