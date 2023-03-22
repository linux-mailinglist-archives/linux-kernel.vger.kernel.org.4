Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13F66C583D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCVU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCVU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D41E9FD;
        Wed, 22 Mar 2023 13:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B783622B4;
        Wed, 22 Mar 2023 20:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA438C433EF;
        Wed, 22 Mar 2023 20:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679518624;
        bh=jId+0Y3hmLSu0ioRI2ENH6CbrYsoF1q/LR2HtwNEepw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ncZw5hoXPrMfeDNOcbMJAmbs8A+5VexW7XWGaJf9Do2S1sXWO8n4d0EY3XTf8Wq/w
         n5lezahI+vKIR4oJAIVKFZqKf2z2utaBKpUiFn9fGu3QKuqKAn/ZQcByoilKsQN5PE
         ad9+9kxT84GfdGxwrsMM3f0oD2AsYC+3nLChgRJF7ev1Idgg66KkX5ocvfHZ4DF6vR
         V6TSz1w2l23ylUwO8T4p6OXTa1YeBhvlHCNFKjHjaa/6ap9/PekA6vkneNe0Tl6FeT
         gins/zJ/POtpraMuR8vURTWXW7RhRPkeMeRpsthRLSHEEHtdV5cQyj0IyV7oezdDpB
         hu58AyZb8SgCg==
Date:   Wed, 22 Mar 2023 15:57:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     ville.syrjala@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] PCI/ASPM: pci_enable_link_state: Add
 argument to acquire bus lock
Message-ID: <20230322205702.GA2493123@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322204459.GA2492596@bhelgaas>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:45:01PM -0500, Bjorn Helgaas wrote:
> Hi David,
> 
> On Tue, Mar 21, 2023 at 04:38:49PM -0700, David E. Box wrote:
> > The VMD driver calls pci_enabled_link_state as a callback from
> > pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a lockdep
> > warning. Add an argument to pci_enable_link_state to set whether the lock
> > should be acquired. In the VMD driver, set the argument to false since the
> > lock will already be obtained by pci_bus_walk.
> > 
> > Reported-by: Ville Syrj�l� <ville.syrjala@linux.intel.com>
> > Fixes: de82f60f9c86 ("PCI/ASPM: Add pci_enable_link_state()")
> 
> This means "if your kernel includes de82f60f9c86, you probably want to
> backport this fix to it."  But that's not the case here.  This patch
> is not fixing an issue with de82f60f9c86, so I don't think there's a
> reason to include a "Fixes" line.

Oops, sorry, forgot to engage brain before hitting "send".

I think the "Fixes" line should reference f492edb40b54 ("PCI: vmd: Add
quirk to configure PCIe ASPM and LTR") instead, since that's where the
locking problem started.

> This patch is adding functionality that is only needed by some other
> patch, and it should be part of a series that also includes the patch
> that uses it to make sure they go together.

And I see that the use *is* included in this patch.  But I don't
really like this pattern:

  vmd_probe
    vmd_enable_domain
      vmd->bus = pci_create_root_bus(...);
      pci_scan_child_bus(vmd->bus);
      pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);

because pci_walk_bus() makes locking complicated (as this issue shows)
and it doesn't work for hot-added devices (I don't know if that's an
issue for VMD, but the pattern gets copied to places where it *is*).

Normally vmd_pm_enable_quirk() would be done by making it an actual
DECLARE_PCI_FIXUP_HEADER() or DECLARE_PCI_FIXUP_FINAL(), so it would
be called automatically by the PCI core when a new device is
enumerated.  Would that work here?  If it would, I don't think you'd
need to add the extra flag to pci_enable_link_state().

> > Link: https://lore.kernel.org/linux-pci/ZBjko%2FifunIwsK2v@intel.com/
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 2 +-
> >  drivers/pci/pcie/aspm.c      | 9 ++++++---
> >  include/linux/pci.h          | 5 +++--
> >  3 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 990630ec57c6..45aa35744eae 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -737,7 +737,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> >  	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> >  		return 0;
> >  
> > -	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> > +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL, false);
> >  
> >  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> >  	if (!pos)
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 66d7514ca111..5b5a600bb864 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1147,8 +1147,9 @@ EXPORT_SYMBOL(pci_disable_link_state);
> >   *
> >   * @pdev: PCI device
> >   * @state: Mask of ASPM link states to enable
> > + * @sem: Boolean to acquire/release pci_bus_sem
> >   */
> > -int pci_enable_link_state(struct pci_dev *pdev, int state)
> > +int pci_enable_link_state(struct pci_dev *pdev, int state, bool sem)
> >  {
> >  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> >  
> > @@ -1165,7 +1166,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  		return -EPERM;
> >  	}
> >  
> > -	down_read(&pci_bus_sem);
> > +	if (sem)
> > +		down_read(&pci_bus_sem);
> >  	mutex_lock(&aspm_lock);
> >  	link->aspm_default = 0;
> >  	if (state & PCIE_LINK_STATE_L0S)
> > @@ -1186,7 +1188,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> >  	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> >  	mutex_unlock(&aspm_lock);
> > -	up_read(&pci_bus_sem);
> > +	if (sem)
> > +		up_read(&pci_bus_sem);
> >  
> >  	return 0;
> >  }
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index fafd8020c6d7..a6f9f24b39fd 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1707,7 +1707,7 @@ extern bool pcie_ports_native;
> >  #ifdef CONFIG_PCIEASPM
> >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> > +int pci_enable_link_state(struct pci_dev *pdev, int state, bool sem);
> >  void pcie_no_aspm(void);
> >  bool pcie_aspm_support_enabled(void);
> >  bool pcie_aspm_enabled(struct pci_dev *pdev);
> > @@ -1716,7 +1716,8 @@ static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
> >  { return 0; }
> >  static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
> >  { return 0; }
> > -static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
> > +static inline int
> > +pci_enable_link_state(struct pci_dev *pdev, int state, bool sem)
> >  { return 0; }
> >  static inline void pcie_no_aspm(void) { }
> >  static inline bool pcie_aspm_support_enabled(void) { return false; }
> > -- 
> > 2.34.1
> > 
