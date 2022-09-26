Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAB5EA174
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiIZKvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiIZKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:48:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB157224
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BCA6B8055F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBAC433D6;
        Mon, 26 Sep 2022 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664187963;
        bh=9BJ3gXvsGKqQO5mz+vKIVuQ3OD5zMoZjpAMsuoEiXcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+XWeqRfDb1/hPlgDiS/6jg57qhX1tMjioQ5aMd/5mtKC4BgM1zBVEIdIdv62BBot
         Q5elEz5saav+mpp/mOMfJ5cSXCacZJgjQp5Rek55ULhobwBBbTUmWhtcP9TQHSIJvI
         L/BHivR+HL/U+yjZthqSBPudgcNr473hj2WmP23t1PttBoBcyjkBzBnHxn8EfDa6MO
         W5p2IzIKBhyI2/tCjo38w/sjG8vogAUxqRZfC2MyWW+9qqW5nLYmAY5BUkMx2z7Kaa
         7+P0OOM7HKzfJdQ0J9I4pa/q+SjUs3HRX2mm9uTdtl8TERa603Gc6vFGo52sALGs4T
         aAZnQfqyjXJ0w==
Received: by pali.im (Postfix)
        id EA1338A3; Mon, 26 Sep 2022 12:26:00 +0200 (CEST)
Date:   Mon, 26 Sep 2022 12:26:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] powerpc/85xx: p2020: Move all P2020 machine
 descriptions to p2020.c
Message-ID: <20220926102600.ir7wcns3gxa23d2n@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-4-pali@kernel.org>
 <bf01338b-b0a1-1fef-f29d-c864b9bc49a8@csgroup.eu>
 <20220926095305.gfwgf66ypah53cjx@pali>
 <9ccf2f96-ddee-e4ce-da4e-ccad5103aef5@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ccf2f96-ddee-e4ce-da4e-ccad5103aef5@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2022 10:17:26 Christophe Leroy wrote:
> Le 26/09/2022 à 11:53, Pali Rohár a écrit :
> > On Monday 26 September 2022 09:48:02 Christophe Leroy wrote:
> >> Le 19/08/2022 à 21:15, Pali Rohár a écrit :
> >>> This moves machine descriptions and all related code for all P2020 boards
> >>> into new p2020.c source file. This is preparation for code deduplication
> >>> and providing one unified machine description for all P2020 boards.
> >>
> >> I'm having hard time to review this patch.
> >>
> >> It looks like you are doing much more than just moving machine
> >> descriptions and related code into p2020.c
> >>
> >> Apparently p2020.c has a lot of code that doesn't seem be move from
> >> somewhere else.
> >>
> >> Maybe there is a need to tidy up in order to ease reviewing.
> > 
> > This is probably harder to read due to how git format-patch generated
> > this email. The important is:
> > 
> >   copy from arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >   copy to arch/powerpc/platforms/85xx/p2020.c
> > 
> > Which means that git thinks that my newly introduced file p2020.c is
> > similar to old file mpc85xx_ds.c and generated diff in format which do:
> > 
> >   1. copy mpc85xx_ds.c to p2020.c
> >   2. apply diff on newly introduced file p2020.c
> > 
> > Code is really moved from mpc85xx_ds.c and mpc85xx_rdb.c files into file
> > p2020.c.
> > 
> > File p2020.c is new in this patch.
> 
> Well, I didn't really look in how the patch was generated, I imported 
> your series and mainly reviewed it in git directly.
> 
> For this patch I have the following diff stat:
> 
> $ git show --stat e2d8c39e2e32855658d1c5f042a7ce88952f488a
> commit e2d8c39e2e32855658d1c5f042a7ce88952f488a
> Author: Pali Rohár <pali@kernel.org>
> Date:   Fri Aug 19 21:15:53 2022 +0200
> 
>      powerpc/85xx: p2020: Move all P2020 machine descriptions to p2020.c
> 
>      This moves machine descriptions and all related code for all P2020 
> boards
>      into new p2020.c source file. This is preparation for code 
> deduplication
>      and providing one unified machine description for all P2020 boards.
> 
>      Signed-off-by: Pali Rohár <pali@kernel.org>
> 
>   arch/powerpc/platforms/85xx/Makefile      |   2 ++
>   arch/powerpc/platforms/85xx/mpc85xx_ds.c  |  23 --------------
>   arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  44 --------------------------
>   arch/powerpc/platforms/85xx/p2020.c       | 273 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 275 insertions(+), 67 deletions(-)
> 
> 
> So there is a lot more code added than deleted.
> 
> If it was really a code move as described in the commit message, I would 
> have approximately the same number of inserts as number of deletions.

I see... The reason is that helper ds/rdb functions are copies (not
moved) because they are needed still in ds/rdb boards. And in later
patches in this patch series are then p2020 helper function cleaned and
simplified.

So as I see basically this change moves p2020 machine descriptions from
ds/rdb files into p2020.c, plus copy helper functions.

Not sure what should be the best case how to do it. I did not wanted to
introduce regression in the code, so I rather did not touched non-p2020
code in ds/rdb files.

> 
> > 
> >>>
> >>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>> ---
> >>>    arch/powerpc/platforms/85xx/Makefile          |   2 +
> >>>    arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  23 ---
> >>>    arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  44 ------
> >>>    .../platforms/85xx/{mpc85xx_ds.c => p2020.c}  | 134 ++++++++++++------
> >>>    4 files changed, 91 insertions(+), 112 deletions(-)
> >>>    copy arch/powerpc/platforms/85xx/{mpc85xx_ds.c => p2020.c} (65%)
> >>>
> >>> diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
> >>> index 260fbad7967b..1ad261b4eeb6 100644
> >>> --- a/arch/powerpc/platforms/85xx/Makefile
> >>> +++ b/arch/powerpc/platforms/85xx/Makefile
> >>> @@ -23,6 +23,8 @@ obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
> >>>    obj-$(CONFIG_P1022_DS)    += p1022_ds.o
> >>>    obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
> >>>    obj-$(CONFIG_P1023_RDB)   += p1023_rdb.o
> >>> +obj-$(CONFIG_MPC85xx_DS)  += p2020.o
> >>> +obj-$(CONFIG_MPC85xx_RDB) += p2020.o
> >>>    obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
> >>>    obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
> >>>    obj-$(CONFIG_FB_FSL_DIU)	+= t1042rdb_diu.o
> >>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>> index 9a6d637ef54a..05aac997b5ed 100644
> >>> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>> @@ -168,7 +168,6 @@ static int __init mpc8544_ds_probe(void)
> >>>    
> >>>    machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
> >>>    machine_arch_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
> >>> -machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
> >>>    
> >>>    /*
> >>>     * Called very early, device-tree isn't unflattened
> >>> @@ -178,14 +177,6 @@ static int __init mpc8572_ds_probe(void)
> >>>    	return !!of_machine_is_compatible("fsl,MPC8572DS");
> >>>    }
> >>>    
> >>> -/*
> >>> - * Called very early, device-tree isn't unflattened
> >>> - */
> >>> -static int __init p2020_ds_probe(void)
> >>> -{
> >>> -	return !!of_machine_is_compatible("fsl,P2020DS");
> >>> -}
> >>> -
> >>>    define_machine(mpc8544_ds) {
> >>>    	.name			= "MPC8544 DS",
> >>>    	.probe			= mpc8544_ds_probe,
> >>> @@ -213,17 +204,3 @@ define_machine(mpc8572_ds) {
> >>>    	.calibrate_decr		= generic_calibrate_decr,
> >>>    	.progress		= udbg_progress,
> >>>    };
> >>> -
> >>> -define_machine(p2020_ds) {
> >>> -	.name			= "P2020 DS",
> >>> -	.probe			= p2020_ds_probe,
> >>> -	.setup_arch		= mpc85xx_ds_setup_arch,
> >>> -	.init_IRQ		= mpc85xx_ds_pic_init,
> >>> -#ifdef CONFIG_PCI
> >>> -	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> >>> -	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
> >>> -#endif
> >>> -	.get_irq		= mpic_get_irq,
> >>> -	.calibrate_decr		= generic_calibrate_decr,
> >>> -	.progress		= udbg_progress,
> >>> -};
> >>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> >>> index b6129c148fea..05f1ed635735 100644
> >>> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> >>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> >>> @@ -108,8 +108,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
> >>>    	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
> >>>    }
> >>>    
> >>> -machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
> >>> -machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
> >>>    machine_arch_initcall(p1020_mbg_pc, mpc85xx_common_publish_devices);
> >>>    machine_arch_initcall(p1020_rdb, mpc85xx_common_publish_devices);
> >>>    machine_arch_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
> >>> @@ -122,13 +120,6 @@ machine_arch_initcall(p1024_rdb, mpc85xx_common_publish_devices);
> >>>    /*
> >>>     * Called very early, device-tree isn't unflattened
> >>>     */
> >>> -static int __init p2020_rdb_probe(void)
> >>> -{
> >>> -	if (of_machine_is_compatible("fsl,P2020RDB"))
> >>> -		return 1;
> >>> -	return 0;
> >>> -}
> >>> -
> >>>    static int __init p1020_rdb_probe(void)
> >>>    {
> >>>    	if (of_machine_is_compatible("fsl,P1020RDB"))
> >>> @@ -153,13 +144,6 @@ static int __init p1021_rdb_pc_probe(void)
> >>>    	return 0;
> >>>    }
> >>>    
> >>> -static int __init p2020_rdb_pc_probe(void)
> >>> -{
> >>> -	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
> >>> -		return 1;
> >>> -	return 0;
> >>> -}
> >>> -
> >>>    static int __init p1025_rdb_probe(void)
> >>>    {
> >>>    	return of_machine_is_compatible("fsl,P1025RDB");
> >>> @@ -180,20 +164,6 @@ static int __init p1024_rdb_probe(void)
> >>>    	return of_machine_is_compatible("fsl,P1024RDB");
> >>>    }
> >>>    
> >>> -define_machine(p2020_rdb) {
> >>> -	.name			= "P2020 RDB",
> >>> -	.probe			= p2020_rdb_probe,
> >>> -	.setup_arch		= mpc85xx_rdb_setup_arch,
> >>> -	.init_IRQ		= mpc85xx_rdb_pic_init,
> >>> -#ifdef CONFIG_PCI
> >>> -	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> >>> -	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
> >>> -#endif
> >>> -	.get_irq		= mpic_get_irq,
> >>> -	.calibrate_decr		= generic_calibrate_decr,
> >>> -	.progress		= udbg_progress,
> >>> -};
> >>> -
> >>>    define_machine(p1020_rdb) {
> >>>    	.name			= "P1020 RDB",
> >>>    	.probe			= p1020_rdb_probe,
> >>> @@ -222,20 +192,6 @@ define_machine(p1021_rdb_pc) {
> >>>    	.progress		= udbg_progress,
> >>>    };
> >>>    
> >>> -define_machine(p2020_rdb_pc) {
> >>> -	.name			= "P2020RDB-PC",
> >>> -	.probe			= p2020_rdb_pc_probe,
> >>> -	.setup_arch		= mpc85xx_rdb_setup_arch,
> >>> -	.init_IRQ		= mpc85xx_rdb_pic_init,
> >>> -#ifdef CONFIG_PCI
> >>> -	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> >>> -	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
> >>> -#endif
> >>> -	.get_irq		= mpic_get_irq,
> >>> -	.calibrate_decr		= generic_calibrate_decr,
> >>> -	.progress		= udbg_progress,
> >>> -};
> >>> -
> >>>    define_machine(p1025_rdb) {
> >>>    	.name			= "P1025 RDB",
> >>>    	.probe			= p1025_rdb_probe,
> >>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/p2020.c
> >>> similarity index 65%
> >>> copy from arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>> copy to arch/powerpc/platforms/85xx/p2020.c
> >>> index 9a6d637ef54a..d65d4c88ac47 100644
> >>> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> >>> +++ b/arch/powerpc/platforms/85xx/p2020.c
> >>> @@ -1,11 +1,9 @@
> >>>    // SPDX-License-Identifier: GPL-2.0-or-later
> >>>    /*
> >>> - * MPC85xx DS Board Setup
> >>> + * Freescale P2020 board Setup
> >>>     *
> >>> - * Author Xianghua Xiao (x.xiao@freescale.com)
> >>> - * Roy Zang <tie-fei.zang@freescale.com>
> >>> - * 	- Add PCI/PCI Exprees support
> >>> - * Copyright 2007 Freescale Semiconductor Inc.
> >>> + * Copyright 2007,2009,2012-2013 Freescale Semiconductor Inc.
> >>> + * Copyright 2022 Pali Rohár <pali@kernel.org>
> >>>     */
> >>>    
> >>>    #include <linux/stddef.h>
> >>> @@ -17,6 +15,7 @@
> >>>    #include <linux/interrupt.h>
> >>>    #include <linux/of_irq.h>
> >>>    #include <linux/of_platform.h>
> >>> +#include <linux/fsl/guts.h>
> >>>    
> >>>    #include <asm/time.h>
> >>>    #include <asm/machdep.h>
> >>> @@ -27,6 +26,8 @@
> >>>    #include <asm/i8259.h>
> >>>    #include <asm/swiotlb.h>
> >>>    
> >>> +#include <soc/fsl/qe/qe.h>
> >>> +
> >>>    #include <sysdev/fsl_soc.h>
> >>>    #include <sysdev/fsl_pci.h>
> >>>    #include "smp.h"
> >>> @@ -41,6 +42,8 @@
> >>>    #define DBG(fmt, args...)
> >>>    #endif
> >>>    
> >>> +#ifdef CONFIG_MPC85xx_DS
> >>> +
> >>>    #ifdef CONFIG_PPC_I8259
> >>>    static void mpc85xx_8259_cascade(struct irq_desc *desc)
> >>>    {
> >>> @@ -62,18 +65,11 @@ static void __init mpc85xx_ds_pic_init(void)
> >>>    	struct device_node *cascade_node = NULL;
> >>>    	int cascade_irq;
> >>>    #endif
> >>> -	if (of_machine_is_compatible("fsl,MPC8572DS-CAMP")) {
> >>> -		mpic = mpic_alloc(NULL, 0,
> >>> -			MPIC_NO_RESET |
> >>> -			MPIC_BIG_ENDIAN |
> >>> -			MPIC_SINGLE_DEST_CPU,
> >>> -			0, 256, " OpenPIC  ");
> >>> -	} else {
> >>> -		mpic = mpic_alloc(NULL, 0,
> >>> -			  MPIC_BIG_ENDIAN |
> >>> -			  MPIC_SINGLE_DEST_CPU,
> >>> -			0, 256, " OpenPIC  ");
> >>> -	}
> >>> +
> >>> +	mpic = mpic_alloc(NULL, 0,
> >>> +		  MPIC_BIG_ENDIAN |
> >>> +		  MPIC_SINGLE_DEST_CPU,
> >>> +		0, 256, " OpenPIC  ");
> >>>    
> >>>    	BUG_ON(mpic == NULL);
> >>>    	mpic_init(mpic);
> >>> @@ -142,9 +138,27 @@ static void __init mpc85xx_ds_uli_init(void)
> >>>    #endif
> >>>    }
> >>>    
> >>> +#endif /* CONFIG_MPC85xx_DS */
> >>> +
> >>> +#ifdef CONFIG_MPC85xx_RDB
> >>> +static void __init mpc85xx_rdb_pic_init(void)
> >>> +{
> >>> +	struct mpic *mpic;
> >>> +
> >>> +	mpic = mpic_alloc(NULL, 0,
> >>> +	  MPIC_BIG_ENDIAN |
> >>> +	  MPIC_SINGLE_DEST_CPU,
> >>> +	  0, 256, " OpenPIC  ");
> >>> +
> >>> +	BUG_ON(mpic == NULL);
> >>> +	mpic_init(mpic);
> >>> +}
> >>> +#endif /* CONFIG_MPC85xx_RDB */
> >>> +
> >>>    /*
> >>>     * Setup the architecture
> >>>     */
> >>> +#ifdef CONFIG_MPC85xx_DS
> >>>    static void __init mpc85xx_ds_setup_arch(void)
> >>>    {
> >>>    	if (ppc_md.progress)
> >>> @@ -157,38 +171,65 @@ static void __init mpc85xx_ds_setup_arch(void)
> >>>    
> >>>    	printk("MPC85xx DS board from Freescale Semiconductor\n");
> >>>    }
> >>> +#endif /* CONFIG_MPC85xx_DS */
> >>>    
> >>> -/*
> >>> - * Called very early, device-tree isn't unflattened
> >>> - */
> >>> -static int __init mpc8544_ds_probe(void)
> >>> +#ifdef CONFIG_MPC85xx_RDB
> >>> +static void __init mpc85xx_rdb_setup_arch(void)
> >>>    {
> >>> -	return !!of_machine_is_compatible("MPC8544DS");
> >>> +	if (ppc_md.progress)
> >>> +		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
> >>> +
> >>> +	mpc85xx_smp_init();
> >>> +
> >>> +	fsl_pci_assign_primary();
> >>> +
> >>> +#ifdef CONFIG_QUICC_ENGINE
> >>> +	mpc85xx_qe_par_io_init();
> >>> +#endif	/* CONFIG_QUICC_ENGINE */
> >>> +
> >>> +	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
> >>>    }
> >>> +#endif /* CONFIG_MPC85xx_RDB */
> >>>    
> >>> -machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
> >>> -machine_arch_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
> >>> +#ifdef CONFIG_MPC85xx_DS
> >>>    machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
> >>> +#endif /* CONFIG_MPC85xx_DS */
> >>>    
> >>> -/*
> >>> - * Called very early, device-tree isn't unflattened
> >>> - */
> >>> -static int __init mpc8572_ds_probe(void)
> >>> -{
> >>> -	return !!of_machine_is_compatible("fsl,MPC8572DS");
> >>> -}
> >>> +#ifdef CONFIG_MPC85xx_RDB
> >>> +machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
> >>> +machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
> >>> +#endif /* CONFIG_MPC85xx_RDB */
> >>>    
> >>>    /*
> >>>     * Called very early, device-tree isn't unflattened
> >>>     */
> >>> +#ifdef CONFIG_MPC85xx_DS
> >>>    static int __init p2020_ds_probe(void)
> >>>    {
> >>>    	return !!of_machine_is_compatible("fsl,P2020DS");
> >>>    }
> >>> +#endif /* CONFIG_MPC85xx_DS */
> >>> +
> >>> +#ifdef CONFIG_MPC85xx_RDB
> >>> +static int __init p2020_rdb_probe(void)
> >>> +{
> >>> +	if (of_machine_is_compatible("fsl,P2020RDB"))
> >>> +		return 1;
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int __init p2020_rdb_pc_probe(void)
> >>> +{
> >>> +	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
> >>> +		return 1;
> >>> +	return 0;
> >>> +}
> >>> +#endif /* CONFIG_MPC85xx_RDB */
> >>>    
> >>> -define_machine(mpc8544_ds) {
> >>> -	.name			= "MPC8544 DS",
> >>> -	.probe			= mpc8544_ds_probe,
> >>> +#ifdef CONFIG_MPC85xx_DS
> >>> +define_machine(p2020_ds) {
> >>> +	.name			= "P2020 DS",
> >>> +	.probe			= p2020_ds_probe,
> >>>    	.setup_arch		= mpc85xx_ds_setup_arch,
> >>>    	.init_IRQ		= mpc85xx_ds_pic_init,
> >>>    #ifdef CONFIG_PCI
> >>> @@ -199,12 +240,14 @@ define_machine(mpc8544_ds) {
> >>>    	.calibrate_decr		= generic_calibrate_decr,
> >>>    	.progress		= udbg_progress,
> >>>    };
> >>> -
> >>> -define_machine(mpc8572_ds) {
> >>> -	.name			= "MPC8572 DS",
> >>> -	.probe			= mpc8572_ds_probe,
> >>> -	.setup_arch		= mpc85xx_ds_setup_arch,
> >>> -	.init_IRQ		= mpc85xx_ds_pic_init,
> >>> +#endif /* CONFIG_MPC85xx_DS */
> >>> +
> >>> +#ifdef CONFIG_MPC85xx_RDB
> >>> +define_machine(p2020_rdb) {
> >>> +	.name			= "P2020 RDB",
> >>> +	.probe			= p2020_rdb_probe,
> >>> +	.setup_arch		= mpc85xx_rdb_setup_arch,
> >>> +	.init_IRQ		= mpc85xx_rdb_pic_init,
> >>>    #ifdef CONFIG_PCI
> >>>    	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> >>>    	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
> >>> @@ -214,11 +257,11 @@ define_machine(mpc8572_ds) {
> >>>    	.progress		= udbg_progress,
> >>>    };
> >>>    
> >>> -define_machine(p2020_ds) {
> >>> -	.name			= "P2020 DS",
> >>> -	.probe			= p2020_ds_probe,
> >>> -	.setup_arch		= mpc85xx_ds_setup_arch,
> >>> -	.init_IRQ		= mpc85xx_ds_pic_init,
> >>> +define_machine(p2020_rdb_pc) {
> >>> +	.name			= "P2020RDB-PC",
> >>> +	.probe			= p2020_rdb_pc_probe,
> >>> +	.setup_arch		= mpc85xx_rdb_setup_arch,
> >>> +	.init_IRQ		= mpc85xx_rdb_pic_init,
> >>>    #ifdef CONFIG_PCI
> >>>    	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> >>>    	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
> >>> @@ -227,3 +270,4 @@ define_machine(p2020_ds) {
> >>>    	.calibrate_decr		= generic_calibrate_decr,
> >>>    	.progress		= udbg_progress,
> >>>    };
> >>> +#endif /* CONFIG_MPC85xx_RDB */
