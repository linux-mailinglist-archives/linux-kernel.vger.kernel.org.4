Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB56154ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKAW0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKAW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:26:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE7DF93
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C93FB81DA0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B274DC433C1;
        Tue,  1 Nov 2022 22:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667341567;
        bh=bH391DK6mDhlfk/m9c9qaAOR1+HEqjYW4XKMtEK5zKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXfVmQc8UrEuZM0HilitmRJturD7H7r9yQzekwIkMDc6cUWPlu5EV9ozQDqEP6lkd
         /4eefv4pttplO2R6vVTBoTcE2rqf0KY3sm4oOa6DyDDS3FKV7O6YySYI/JkWXw90uk
         MqE1CnzjyZDSU8fKkaQGCzRzJYgZnL2m8zSCN873FDu2en+0tibCmxo2KU//vb/F0X
         WS7fBwtJ3wDrPXYfmQUcxmfGb4fA3EeeRVAYhBhmpSgS1OHGTfAePN8X1rV5id3TiY
         171/iY4Ezrf/HtSqck4qz6ZL1d1phbJK8Sm3Z4SDYsK+d+t2uyxjR9WD+zE9di68j6
         y5fgZWBrBzJFg==
Received: by pali.im (Postfix)
        id C50EA7F8; Tue,  1 Nov 2022 23:26:03 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:26:03 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/pci: Allow to disable filling deprecated
 pci-OF-bus-map
Message-ID: <20221101222603.h3nlrp6xuhrnkmht@pali>
References: <20220817163927.24453-1-pali@kernel.org>
 <20221009112555.spnwid27r4rwi67q@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009112555.spnwid27r4rwi67q@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! Gentle reminder...

On Sunday 09 October 2022 13:25:55 Pali Rohár wrote:
> Hello! Any comments on this? It would be nice to take these two patches
> (or at least patch 2) to finally enable PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> by default where possible.
> 
> Per following comment there can be an issue with early powermac so seems
> that PPC_PCI_OF_BUS_MAP_FILL still has to be by default enabled (which
> implies that PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT is disabled) on powermac:
> https://lore.kernel.org/linuxppc-dev/575f239205e8635add81c9f902b7d9db7beb83ea.camel@kernel.crashing.org/
> 
> On Wednesday 17 August 2022 18:39:26 Pali Rohár wrote:
> > Creating or filling pci-OF-bus-map property in the device-tree is
> > deprecated since May 2006 [1]. Allow to disable filling this property by
> > unsetting config option CONFIG_PPC_PCI_OF_BUS_MAP_FILL for remaining chrp
> > and powermac code.
> > 
> > Disabling of pci-OF-bus-map property allows to enable new option
> > CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT also for chrp and powermac.
> > 
> > [1] - https://lore.kernel.org/linuxppc-dev/1148016268.13249.14.camel@localhost.localdomain/
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/powerpc/Kconfig         | 12 +++++++++++-
> >  arch/powerpc/kernel/pci_32.c |  6 ++++++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 5881441f7672..df2696c406ad 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -373,9 +373,19 @@ config PPC_DCR
> >  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
> >  	default y
> >  
> > +config PPC_PCI_OF_BUS_MAP_FILL
> > +	bool "Fill pci-OF-bus-map property in the device-tree"
> > +	depends on PPC32
> > +	depends on PPC_PMAC || PPC_CHRP
> > +	default y
> > +	help
> > +	  This option creates and fills pci-OF-bus-map property in the
> > +	  device-tree which is deprecated and is needed only for old
> > +	  platforms.
> > +
> >  config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> >  	depends on PPC32
> > -	depends on !PPC_PMAC && !PPC_CHRP
> > +	depends on !PPC_PCI_OF_BUS_MAP_FILL
> >  	bool "Assign PCI bus numbers from zero individually for each PCI domain"
> >  	help
> >  	  By default on PPC32 were PCI bus numbers unique across all PCI domains.
> > diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> > index 433965bf37b4..ffc4e1928c80 100644
> > --- a/arch/powerpc/kernel/pci_32.c
> > +++ b/arch/powerpc/kernel/pci_32.c
> > @@ -64,6 +64,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixu
> >  
> >  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> >  
> > +#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
> > +
> >  static u8* pci_to_OF_bus_map;
> >  static int pci_bus_count;
> >  
> > @@ -223,6 +225,8 @@ pci_create_OF_bus_map(void)
> >  }
> >  #endif
> >  
> > +#endif /* CONFIG_PPC_PCI_OF_BUS_MAP_FILL */
> > +
> >  #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP) */
> >  
> >  void pcibios_setup_phb_io_space(struct pci_controller *hose)
> > @@ -264,6 +268,7 @@ static int __init pcibios_init(void)
> >  	}
> >  
> >  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
> > +#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
> >  	pci_bus_count = next_busno;
> >  
> >  	/* OpenFirmware based machines need a map of OF bus
> > @@ -272,6 +277,7 @@ static int __init pcibios_init(void)
> >  	 */
> >  	if (pci_assign_all_buses)
> >  		pcibios_make_OF_bus_map();
> > +#endif
> >  #endif
> >  
> >  	/* Call common code to handle resource allocation */
> > -- 
> > 2.20.1
> > 
