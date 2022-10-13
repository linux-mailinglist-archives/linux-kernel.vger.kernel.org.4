Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8604E5FD1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiJMAot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiJMAny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:43:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17D6110B02
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D92EB81CC6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B5C433D7;
        Thu, 13 Oct 2022 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665621211;
        bh=fB7Kglt4Ac9Gyls0KjANZ0nVBsi+/j+BM9SrKkjf97M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MzjI2WKh8S3kvmoWjHCkRlXV6CHDclSmdjzkFkbWWsuzbRmZmY6ikJ6G9cbONXJJp
         z7zeUzGyxmPWOSVuJpupmu/vyp2Ogbm5j733f6SEkFbAd94ITUOiYzcx8BczVNijre
         ezIOnBaLwDRrx4HHExdmvPgPPioTDf0Jd36uPVXIID4mXRQ7hXXOoTCt94rSM8Zh/8
         VKVOR/M2hx2j8k0d+rhg8+qBO2Rkm2Dn0HDviUU+QMuG1HYEec2D4usmvzMYtZya6h
         2S4Ov1QAIYQka3hORic6POnJFQ8DlZMa4Bf5req98SJtT0vCgBudLb0nxG6GUfBs98
         pG14jD6QO7UVA==
Date:   Wed, 12 Oct 2022 17:33:29 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/virtio: Handle PCI devices which Host controller is
 described in DT
In-Reply-To: <f98f9f44-20e9-af8d-8970-9f6241c8dc44@epam.com>
Message-ID: <alpine.DEB.2.22.394.2210121733240.3690179@ubuntu-linux-20-04-desktop>
References: <20221006174804.2003029-1-olekstysh@gmail.com> <alpine.DEB.2.22.394.2210061747590.3690179@ubuntu-linux-20-04-desktop> <f98f9f44-20e9-af8d-8970-9f6241c8dc44@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-166717883-1665618677=:3690179"
Content-ID: <alpine.DEB.2.22.394.2210121651510.3690179@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-166717883-1665618677=:3690179
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2210121651511.3690179@ubuntu-linux-20-04-desktop>

On Wed, 12 Oct 2022, Oleksandr Tyshchenko wrote:
> > On Thu, 6 Oct 2022, Oleksandr Tyshchenko wrote:
> >> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> >>
> >> Use the same "xen-grant-dma" device concept (based on generic IOMMU
> >> device-tree bindings) for the PCI devices behind device-tree based
> >> PCI Host controller.
> >>
> >> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> >> ---
> >> Slightly RFC. This is needed to support Xen grant mappings for virtio-pci devices
> >> on Arm at some point in the future. The Xen toolstack side is not published yet.
> >> Here, for PCI devices we use the same way to pass backend domid to the guest as for
> >> platform devices.
> >>
> >> Depends on Juergen's series:
> >> https://urldefense.com/v3/__https://lore.kernel.org/xen-devel/20221006071500.15689-1-jgross@suse.com/__;!!GF_29dbcQIUBPA!waOk2Goc7qlhNo5-csRObryil_GzMF_e61EJR501oJ08cH2dnJulsZXWlelBDTBqa63TVoUcWQTB5NecJ1p4xFNgh2_EuA$  [lore[.]kernel[.]org]
> >> ---
> >>   drivers/xen/grant-dma-ops.c | 51 +++++++++++++++++++++++++++++--------
> >>   1 file changed, 41 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> >> index ff9be3aff87e..79d13122ec08 100644
> >> --- a/drivers/xen/grant-dma-ops.c
> >> +++ b/drivers/xen/grant-dma-ops.c
> >> @@ -10,6 +10,7 @@
> >>   #include <linux/module.h>
> >>   #include <linux/dma-map-ops.h>
> >>   #include <linux/of.h>
> >> +#include <linux/pci.h>
> >>   #include <linux/pfn.h>
> >>   #include <linux/xarray.h>
> >>   #include <linux/virtio_anchor.h>
> >> @@ -273,12 +274,28 @@ static const struct dma_map_ops xen_grant_dma_ops = {
> >>   	.dma_supported = xen_grant_dma_supported,
> >>   };
> >>   
> >> -static bool xen_is_dt_grant_dma_device(struct device *dev)
> >> +static struct device_node *xen_dt_get_node(struct device *dev)
> >> +{
> >> +	if (dev_is_pci(dev)) {
> >> +		struct pci_dev *pdev = to_pci_dev(dev);
> >> +		struct pci_bus *bus = pdev->bus;
> >> +
> >> +		/* Walk up to the root bus to look for PCI Host controller */
> >> +		while (!pci_is_root_bus(bus))
> >> +			bus = bus->parent;
> >> +
> >> +		return of_node_get(bus->bridge->parent->of_node);
> >> +	}
> > Is it possible to have multiple virtio devices under a single virtio-pci
> > root complex?
> 
> yes
> 
> 
> > What if virtio-net has the backend in dom0 and
> > virtio-block has the backend in dom1?
> >
> > Or each virtio PCI device shows up under a different PCI root complex?
> 
> 
> Good questions. To be honest, it is not 100% clear to me yet how it is 
> supposed to be. But let's guess...
> 
> I think that having a PCI Host bridge per virtio-pci device is overkill.
> 
> So, I see two options here:
> 1. We provide PCI Host bridge per backends domain to the guest, so each 
> PCI Host bridge covers only virtio-pci devices whose backends are 
> running within *the same* domain.
> With that we would be able to use property at PCI Host bridge level.
> 
> 2. We provide only a single PCI Host bridge to the guest, so that single 
> PCI Host bridge covers all virtio-pci devices assigned to this guest.
> No matter where the corresponding backends are running (the 
> virtio-devices under that PCI Host bridge can have the backends in 
> different domains).
> With that we wouldn’t be able to use property at PCI Host bridge level. 
> And we need a more flexible option(s) to be able distinguish between 
> virtio-pci devices.
> 
> Taking into account that for virtio-pci on Arm we need to emulate a 
> specific PCI Host bridge in Xen to intercept the guest PCI config space 
> accesses
> (detect what PCI device is targeted) and forward them to the appropriate 
> backend (IOREQ Server),
> it feels to me that we likely need to go with the second option here 
> (one PCI host bridge per guest), I may mistake,
> but I don’t think that we want to emulate several PCI Host bridges for a 
> single guest (more code, more resources, etc).
> 
> 
> 
> >
> > If we can have multiple virtio PCI devices under a single PCI root
> > complex, then I think it would be better to check for a per-device
> > property, rather than a single property at the PCI root complex level.
> 
> Completely agree.
> 
> 
> >
> > The first thing that comes to mind is to describe each PCI device under
> > the root complex in device tree. Although it is uncommon (usually only
> > the PCI root complex is described in device tree), it is possible to
> > also describe in device tree all the individual PCI devices under the
> > root complex.
> >
> > Given that the domU device tree is generated by Xen and/or the Xen
> > toolstack, it would be easy to arrange for it to happen.
> 
> Technically yes. If we decide to provide only a single PCI Host bridge 
> to the guest, we will have have to deal with the virtio-pci devices with 
> various backend_domid,
> so we can consider using more flexible property 
> “iommu-map”/”iommu-map-mask” specially introduced for such purposes:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iommu.txt
> I think, with that we would be able to describe, i.e that virtio-pci 
> device A connects to stream_id (backend_domid) X and virtio-pci device B 
> to stream_id Y,
> and virtio-pci device C to nothing (so is not required to use grants), 
> unless I missed something.
> 
> I have looked at it and I don’t see at the moment why the idea wouldn’t 
> work, but I haven’t experimented with that yet in such context.

I think it would work too
 

> > That would solve the issue as far as I can tell, but I worry it might
> > not be a good idea because if we rely on the per-device device tree node
> > to be present then it becomes harder to implement virtio hotplug
> > (Virtio hotplug is important to add dom0less support.)
> >
> > Let's say that we create a dom0less domU with an emulated PCI root
> > complex without any devices under it, then after Dom0 is fully booted,
> > we add a virtio-net emulated device. How do we tell the guest what is
> > the backend domain id?
> >
> > Device tree and other firmware tables are not relevant anymore.
> >
> > We could reuse a PCI config space register to expose the backend id.
> > However this solution requires a backend change (QEMU) to expose the
> > backend id via an emulated register for each emulated device.
> >
> > To avoid having to introduce a special config space register in all
> > emulated PCI devices (virtio-net, virtio-block, etc) I wonder if we
> > could add a special PCI config space register at the emulated PCI Root
> > Complex level.
> >
> > Basically the workflow would be as follow:
> >
> > - Linux recognizes the PCI Root Complex as a Xen PCI Root Complex
> > - Linux writes to special PCI config space register of the Xen PCI Root
> >    Complex the PCI device id (basically the BDF)
> > - The Xen PCI Root Complex emulated by Xen answers by writing back to
> >    the same location the backend id (domid of the backend)
> > - Linux reads back the same PCI config space register of the Xen PCI
> >    Root Complex and learn the relevant domid
> >
> > What do you think?
> 
> 
> I think the idea sounds indeed interesting and would probably work, but 
> would require guest modifications other than just in drivers/xen (and 
> likely the specification changes as well).
> Which ideally of course should be avoided.
> Also I was thinking it would be nice not to diverge much between 
> communicating the backend_domid for platform and PCI devices on Arm with 
> device tree.
>
> If we managed to re-use generic IOMMU device-tree bindings for 
> virtio-mmio, we would likely be able to re-use PCI-IOMMU device-tree 
> bindings for virtio-pci,
> at least for boot PCI devices (which are known at the domain creation time).
> The more, the bindings is already present: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml

I think using a special config space register in the root complex would
not be terrible in terms of guest changes because it is easy to
introduce a new root complex driver in Linux and other OSes. The root
complex would still be ECAM compatible so the regular ECAM driver would
still work. A new driver would only be necessary if you want to be able
to access the special config space register.

That said, for sure the fewer changes to the guest the better and I like
the existing xen,grant-dma binding.


> Regarding the hotplug devices, yes it is a valid use-case which should 
> be also supported with virtio-pci, I assume the Xenstore could be 
> re-used for that purpose if it would be available.
> The Xenstore is available with the usual Dom0 and toolstack, is it 
> available with dom0less?

Xenstore is available for dom0less if we have a dom0 running with
xenstored as one of the dom0less domains. We currently rely on it for
Xen PV drivers with dom0less.  After dom0 is fully booted, we use "xl
network-attach" to create a vif interface dynamically in the domU.

That is why I was thinking of using virtio hotplug to solve the same
problem with virtio, I was imagining that after dom0 is fully booted we
would do "xl virtio-attach" and create a new virtio interface in the
domU. But I cannot see an easy way to make virtio hotplug work together
with the xen,grant-dma bindings. I think it would be better if we find a
way to make it work without xenstore (because xenstore would be a
safety-certification dependency).

Maybe we need to think outside the box and find another solution that
doesn't rely on hotplug.

For instance, let's say that we expose the virtio devices in device tree
in a dom0less configuration too but with status = "disabled". When dom0
(or backend domain) is up and running it can signal that it is ready.
Maybe if we had a special Xen-specific PCI Root Complex driver in the
guest, it could wait for the Xen signal and then continue PCI probing at
that point honoring xen,grant-dma bindings if present in device tree
even if the devices had status = "disabled" initially.

It looks like that would require many guest changes unfortunately.


As an alternative I wonder, given that Xen emulates the PCI root
complex, if we can reuse one of the PCI link up/down delays for this
instead, like "pcie_wait_for_link". It looks like the wait time is in
millisec while we would need potentially several seconds here but it
might be possible?

Other ideas?
--8323329-166717883-1665618677=:3690179--
