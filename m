Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635A63972F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiKZQYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKZQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:24:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AF193E8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58D10CE1842
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 16:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5E8C433C1;
        Sat, 26 Nov 2022 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669479828;
        bh=qKqx4Tr3JhjXXIAJyvO8uCkqIauGraZIS4qb2SsQx4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYf+UI0ezWSP6CzcSK3T4oTdNiEwtaR6toqDDnt+pbazrlYC9uQDV3Ck715V65AbD
         z6fC3XZ9XKoOcSm+YdcLNx+hZ4+E+T/YTrMqtTiv5QgT2CQsRtuMhHtP455sPcQ3wI
         FcCaZ/K5ZnJDTksrnZtbAntwr+xkkcOt4AKrx9pdzvucwtGi7jFP8uKsZMONVRAG9i
         egjCDyHfDdHuVcaEWYmQtRkd86T0Y0dh9eFNgMYwZRi9TP9dydjYVPb2l8KO122AwS
         lOXaY++X7LGDmJUhUiwt/tNIT33amuSRv8l+J5MfIPuWoUC+XO4N8DJeN4SPE7Zl1s
         pUfQ7HFfb4XJQ==
Received: by pali.im (Postfix)
        id 9D86C7B2; Sat, 26 Nov 2022 17:23:45 +0100 (CET)
Date:   Sat, 26 Nov 2022 17:23:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/pci: Allow to disable filling deprecated
 pci-OF-bus-map
Message-ID: <20221126162345.a4uuyefmtavfqa6g@pali>
References: <20220817163927.24453-1-pali@kernel.org>
 <20221009112555.spnwid27r4rwi67q@pali>
 <20221101222603.h3nlrp6xuhrnkmht@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101222603.h3nlrp6xuhrnkmht@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Tuesday 01 November 2022 23:26:03 Pali Rohár wrote:
> Hello! Gentle reminder...
> 
> On Sunday 09 October 2022 13:25:55 Pali Rohár wrote:
> > Hello! Any comments on this? It would be nice to take these two patches
> > (or at least patch 2) to finally enable PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> > by default where possible.
> > 
> > Per following comment there can be an issue with early powermac so seems
> > that PPC_PCI_OF_BUS_MAP_FILL still has to be by default enabled (which
> > implies that PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT is disabled) on powermac:
> > https://lore.kernel.org/linuxppc-dev/575f239205e8635add81c9f902b7d9db7beb83ea.camel@kernel.crashing.org/
> > 
> > On Wednesday 17 August 2022 18:39:26 Pali Rohár wrote:
> > > Creating or filling pci-OF-bus-map property in the device-tree is
> > > deprecated since May 2006 [1]. Allow to disable filling this property by
> > > unsetting config option CONFIG_PPC_PCI_OF_BUS_MAP_FILL for remaining chrp
> > > and powermac code.
> > > 
> > > Disabling of pci-OF-bus-map property allows to enable new option
> > > CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT also for chrp and powermac.
> > > 
> > > [1] - https://lore.kernel.org/linuxppc-dev/1148016268.13249.14.camel@localhost.localdomain/
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  arch/powerpc/Kconfig         | 12 +++++++++++-
> > >  arch/powerpc/kernel/pci_32.c |  6 ++++++
> > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index 5881441f7672..df2696c406ad 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -373,9 +373,19 @@ config PPC_DCR
> > >  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
> > >  	default y
> > >  
> > > +config PPC_PCI_OF_BUS_MAP_FILL
> > > +	bool "Fill pci-OF-bus-map property in the device-tree"
> > > +	depends on PPC32
> > > +	depends on PPC_PMAC || PPC_CHRP
> > > +	default y
> > > +	help
> > > +	  This option creates and fills pci-OF-bus-map property in the
> > > +	  device-tree which is deprecated and is needed only for old
> > > +	  platforms.
> > > +
> > >  config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> > >  	depends on PPC32
> > > -	depends on !PPC_PMAC && !PPC_CHRP
> > > +	depends on !PPC_PCI_OF_BUS_MAP_FILL
> > >  	bool "Assign PCI bus numbers from zero individually for each PCI domain"
> > >  	help
> > >  	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
> > > diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> > > index 433965bf37b4..ffc4e1928c80 100644
> > > --- a/arch/powerpc/kernel/pci_32.c
> > > +++ b/arch/powerpc/kernel/pci_32.c
> > > @@ -64,6 +64,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixu
> > >  
> > >  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> > >  
> > > +#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
> > > +
> > >  static u8* pci_to_OF_bus_map;
> > >  static int pci_bus_count;
> > >  
> > > @@ -223,6 +225,8 @@ pci_create_OF_bus_map(void)
> > >  }
> > >  #endif
> > >  
> > > +#endif /* CONFIG_PPC_PCI_OF_BUS_MAP_FILL */
> > > +
> > >  #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP) */
> > >  
> > >  void pcibios_setup_phb_io_space(struct pci_controller *hose)
> > > @@ -264,6 +268,7 @@ static int __init pcibios_init(void)
> > >  	}
> > >  
> > >  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> > > +#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
> > >  	pci_bus_count = next_busno;
> > >  
> > >  	/* OpenFirmware based machines need a map of OF bus
> > > @@ -272,6 +277,7 @@ static int __init pcibios_init(void)
> > >  	 */
> > >  	if (pci_assign_all_buses)
> > >  		pcibios_make_OF_bus_map();
> > > +#endif
> > >  #endif
> > >  
> > >  	/* Call common code to handle resource allocation */
> > > -- 
> > > 2.20.1
> > > 
