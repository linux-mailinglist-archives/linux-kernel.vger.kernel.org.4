Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEC67F7FA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjA1NYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjA1NYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:24:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B5241C9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:24:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 949EAB80908
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2376C433D2;
        Sat, 28 Jan 2023 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674912243;
        bh=YfyKsO6haWsi/LF+CJ3b5FtI//NxMN3d8XVq+Y+nd4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f97DMQd2384++5Szhw2+n2LBFPcbePH3a3Tr5Q5hb8kmKroGiEv8xNf1OtBQGqpi2
         /QG2I2/ao1xYE/IwIlTF7ZjYpYxk2Wp0d/5R+iK+zpKX1TyTzxAgI2QXUJBQd+p67R
         trLcSdzU8o3YMBttJmqwQGR2VivWwnn4Kx54sCmLURXrot7bZ5BvliFObrDBOAl8sA
         PgQfTPnPIQrk41rquLcJ3helTb3SZHhOgKn0sI7dSzJto04PNuwyJgxiQ8PTTHYMji
         HDXcFj9o0Ods+YaLGgba9yZatqIegwveXNdUna2Vj0cOnOvvJplfFL6FdNAChhlsl/
         9kHsa8aN1LzFA==
Received: by pali.im (Postfix)
        id E4BAB639; Sat, 28 Jan 2023 14:23:59 +0100 (CET)
Date:   Sat, 28 Jan 2023 14:23:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/pci: Allow to disable filling deprecated
 pci-OF-bus-map
Message-ID: <20230128132359.fvziv2ayrjwfqv6f@pali>
References: <20220817163927.24453-1-pali@kernel.org>
 <20221009112555.spnwid27r4rwi67q@pali>
 <20221101222603.h3nlrp6xuhrnkmht@pali>
 <20221126162345.a4uuyefmtavfqa6g@pali>
 <20221216181206.tfzd2qalkking6sj@pali>
 <20230122112118.qhezbsmoeggbkqfs@pali>
 <87r0vhzhls.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0vhzhls.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2023 21:59:43 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > PING? It is more than 5 months since this patch series is there and it
> > still has not received any comment.
> 
> There was some related discussion in another thread.
> 
> I planned to pick it up last merge window, but it breaks the
> pmac32_defconfig build when CONFIG_PPC_PCI_OF_BUS_MAP_FILL=n:
> 
>   ld: arch/powerpc/platforms/powermac/feature.o: in function `core99_ata100_enable':
>   feature.c:(.text+0xcd0): undefined reference to `pci_device_from_OF_node'
>   ld: arch/powerpc/platforms/powermac/pci.o: in function `pmac_pci_init':
>   pci.c:(.init.text+0x5d4): undefined reference to `pci_device_from_OF_node'
>   ld: pci.c:(.init.text+0x660): undefined reference to `pci_device_from_OF_node'
> 
> So I dropped it, and haven't had time to work out a fix.

I think I see where is the issue. Function pci_device_from_OF_node()
needs to be always provided. I will send fix for this in v2.

> cheers
> 
> > On Friday 16 December 2022 19:12:06 Pali Rohár wrote:
> >> PING?
> >> 
> >> On Saturday 26 November 2022 17:23:45 Pali Rohár wrote:
> >> > PING?
> >> > 
> >> > On Tuesday 01 November 2022 23:26:03 Pali Rohár wrote:
> >> > > Hello! Gentle reminder...
> >> > > 
> >> > > On Sunday 09 October 2022 13:25:55 Pali Rohár wrote:
> >> > > > Hello! Any comments on this? It would be nice to take these two patches
> >> > > > (or at least patch 2) to finally enable PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> >> > > > by default where possible.
> >> > > > 
> >> > > > Per following comment there can be an issue with early powermac so seems
> >> > > > that PPC_PCI_OF_BUS_MAP_FILL still has to be by default enabled (which
> >> > > > implies that PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT is disabled) on powermac:
> >> > > > https://lore.kernel.org/linuxppc-dev/575f239205e8635add81c9f902b7d9db7beb83ea.camel@kernel.crashing.org/
> >> > > > 
> >> > > > On Wednesday 17 August 2022 18:39:26 Pali Rohár wrote:
> >> > > > > Creating or filling pci-OF-bus-map property in the device-tree is
> >> > > > > deprecated since May 2006 [1]. Allow to disable filling this property by
> >> > > > > unsetting config option CONFIG_PPC_PCI_OF_BUS_MAP_FILL for remaining chrp
> >> > > > > and powermac code.
> >> > > > > 
> >> > > > > Disabling of pci-OF-bus-map property allows to enable new option
> >> > > > > CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT also for chrp and powermac.
> >> > > > > 
> >> > > > > [1] - https://lore.kernel.org/linuxppc-dev/1148016268.13249.14.camel@localhost.localdomain/
> >> > > > > 
> >> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> >> > > > > ---
> >> > > > >  arch/powerpc/Kconfig         | 12 +++++++++++-
> >> > > > >  arch/powerpc/kernel/pci_32.c |  6 ++++++
> >> > > > >  2 files changed, 17 insertions(+), 1 deletion(-)
> >> > > > > 
> >> > > > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> > > > > index 5881441f7672..df2696c406ad 100644
> >> > > > > --- a/arch/powerpc/Kconfig
> >> > > > > +++ b/arch/powerpc/Kconfig
> >> > > > > @@ -373,9 +373,19 @@ config PPC_DCR
> >> > > > >  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
> >> > > > >  	default y
> >> > > > >  
> >> > > > > +config PPC_PCI_OF_BUS_MAP_FILL
> >> > > > > +	bool "Fill pci-OF-bus-map property in the device-tree"
> >> > > > > +	depends on PPC32
> >> > > > > +	depends on PPC_PMAC || PPC_CHRP
> >> > > > > +	default y
> >> > > > > +	help
> >> > > > > +	  This option creates and fills pci-OF-bus-map property in the
> >> > > > > +	  device-tree which is deprecated and is needed only for old
> >> > > > > +	  platforms.
> >> > > > > +
> >> > > > >  config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> >> > > > >  	depends on PPC32
> >> > > > > -	depends on !PPC_PMAC && !PPC_CHRP
> >> > > > > +	depends on !PPC_PCI_OF_BUS_MAP_FILL
> >> > > > >  	bool "Assign PCI bus numbers from zero individually for each PCI domain"
> >> > > > >  	help
> >> > > > >  	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
> >> > > > > diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> >> > > > > index 433965bf37b4..ffc4e1928c80 100644
> >> > > > > --- a/arch/powerpc/kernel/pci_32.c
> >> > > > > +++ b/arch/powerpc/kernel/pci_32.c
> >> > > > > @@ -64,6 +64,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixu
> >> > > > >  
> >> > > > >  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> >> > > > >  
> >> > > > > +#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
> >> > > > > +
> >> > > > >  static u8* pci_to_OF_bus_map;
> >> > > > >  static int pci_bus_count;
> >> > > > >  
> >> > > > > @@ -223,6 +225,8 @@ pci_create_OF_bus_map(void)
> >> > > > >  }
> >> > > > >  #endif
> >> > > > >  
> >> > > > > +#endif /* CONFIG_PPC_PCI_OF_BUS_MAP_FILL */
> >> > > > > +
> >> > > > >  #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP) */
> >> > > > >  
> >> > > > >  void pcibios_setup_phb_io_space(struct pci_controller *hose)
> >> > > > > @@ -264,6 +268,7 @@ static int __init pcibios_init(void)
> >> > > > >  	}
> >> > > > >  
> >> > > > >  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> >> > > > > +#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
> >> > > > >  	pci_bus_count = next_busno;
> >> > > > >  
> >> > > > >  	/* OpenFirmware based machines need a map of OF bus
> >> > > > > @@ -272,6 +277,7 @@ static int __init pcibios_init(void)
> >> > > > >  	 */
> >> > > > >  	if (pci_assign_all_buses)
> >> > > > >  		pcibios_make_OF_bus_map();
> >> > > > > +#endif
> >> > > > >  #endif
> >> > > > >  
> >> > > > >  	/* Call common code to handle resource allocation */
> >> > > > > -- 
> >> > > > > 2.20.1
> >> > > > > 
