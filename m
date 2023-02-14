Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B25696330
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBNMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBNMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:12:29 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB00252B7;
        Tue, 14 Feb 2023 04:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1676376748;
  x=1707912748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW+fYZVBMkIdds32xQMOF1cT/AnskpifFhDC6xuX7MA=;
  b=WIw63gB/NZPdWEgep9/mJC/jbnhmgEsc9CtHAFy1PZFT4LMkVPT/LWKa
   dqNfw5OcqS89NUi0XxJKPkOQs82XgZjJT3tUcc3zcVrZlKBK7kVxmfBVs
   MYTG++qzEVUeLvAs4p3Y+6Yyf4Jf94YHjcZo0ondlFEQkXhRy/CJxReDT
   kx1RPwn6RwPb04cIUq7rVfKyrMZ+/CDYqE7s9SSthdD3s+DredBWEKdna
   HFqkme1v2ppMuHgL62YttokRIP5G6hoTCmBc608mGn3+u0jN7yHr2BQZw
   SwCj4/srnOdJDjOQsUKSgWVTFLeOywDUTRUT9e1H1OS5c2U/0VYQETXHg
   Q==;
Date:   Tue, 14 Feb 2023 13:12:25 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "robh@kernel.org" <robh@kernel.org>, <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] virt-pci: add platform bus support
Message-ID: <Y+t6qXBxLqf/+eQM@axis.com>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
 <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 06:54:49PM +0100, Johannes Berg wrote:
> On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
> > My first approach to getting platform drivers working on UML was by
> > adding a minimal PCI-to-platform bridge driver, which worked without
> > modifications to virt-pci, but that got shot down:
> > 
> >  https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
> 
> Reading through that ... OK that isn't fun either :-)
> 
> Sounds like there's a use case for something else though, but the PCI
> IDs issue also makes that thorny.

Yes, Greg was initially totally opposed to the idea of putting platform
devices under PCI devices, but in his latest email he seemed to
allow it in some cases.  It's still unclear if he'd be OK with a
"virtual PCI-to-platform bridge" though.  And yes, adding platform
devices support like in this patch removes one layer and also eliminates
the disadvantage of having to wait for user space to specify a PCI ID
for the bridge device.

> > @@ -48,6 +51,7 @@ struct um_pci_device_reg {
> >  
> >  static struct pci_host_bridge *bridge;
> >  static DEFINE_MUTEX(um_pci_mtx);
> > +static struct um_pci_device *um_pci_platform_device;
> >  static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
> >  static struct fwnode_handle *um_pci_fwnode;
> >  static struct irq_domain *um_pci_inner_domain;
> > @@ -480,6 +484,9 @@ static void um_pci_handle_irq_message(struct virtqueue *vq,
> >  	struct virtio_device *vdev = vq->vdev;
> >  	struct um_pci_device *dev = vdev->priv;
> >  
> > +	if (!dev->irq)
> > +		return;
> > 
> 
> Does that mean platform devices don't have interrupts, or does that mean
> not all of them must have interrupts?

They don't have interrupts via this driver.  There isn't any standard
way for platform devices to handle interrupts since it it all depends on
what interrupt-parent is specified in the devicetree and how that is
implemented.

In my case, I have a separate virtio-gpio and use that as the
interrupt-parent like in the devicetree at the end of this email.  I
actually also did that when I used the platform-on-PCI solution since I
already use virtio-gpio as the interrupt controller for devices on other
busses like I2C and SPI and just reusing that was easier than
implementing MSI support in my virt-pci device.

> I'll note that this also would allow the device to send an MSI which
> feels a bit wrong? But I guess it doesn't really matter.

We could avoid setting up the IRQ/MSI virtqueue when we know we're
dealing with platform devices.

> So let me ask this: Conceptually, wouldn't the "right" way to handle
> this be a new virtio device and protocol and everything, with a new
> driver to handle it? I realise that would likely lead to quite a bit of
> code duplication, for now I just want to understand the concept here a
> bit better.

Yes, that could be a way to do it.  Or there could perhaps be some
feature bits indicating that only MMIO read/write/memset are allowed.

> Such a driver would then define its own messages, requiring (I guess)
> the equivalents of
>  * VIRTIO_PCIDEV_OP_INT,
>  * VIRTIO_PCIDEV_OP_MMIO_READ,
>  * VIRTIO_PCIDEV_OP_MMIO_WRITE, and
>  * (maybe) VIRTIO_PCIDEV_OP_MMIO_MEMSET,
> 
> but not
>  * VIRTIO_PCIDEV_OP_CFG_READ,
>  * VIRTIO_PCIDEV_OP_CFG_WRITE,
>  * VIRTIO_PCIDEV_OP_MSI and
>  * VIRTIO_PCIDEV_OP_PME,
> 
> right?

Yes, just the MMIO* stuff would be enough.

> How much code would we actually duplicate? Most of virt-pci is dedicated
> to the mess of PCI MSI domains, bridges, etc.

Probably not a huge amount, I can try to cook up a patch if you'd like.
But, besides the code duplication, I'm not sure if adding another new
virtio driver without a specification would be OK?

> The limitation to a single device feels odd, and the fact that you have

The limitation to a single device here is not a problem since one can
use simple-bus to instantiate any number of platform devices via the
devicetree.  The devicetree at the end of this email shows how that
looks like.

> to put it into DT under the PCI also seems odd. OTOH, the platform
> device has to be _somewhere_ right?

With this patch, it's not put under PCI in the devicetree, see the
example below.

> I guess I'm not really sure how to use it, but I suppose that's OK too
> :)

With a devicetree like the one below, using it shouldn't be all that
different from using the normal virt-pci except that the register ranges
and IRQ information are in the devicetree rather than coming via the
config space implementation in the virtio device.

With everything hooked up and with the backend code I have in roadtest,
this allows tests like this one which exercises some SoC's DMA
controller (the simplest one I could find in the tree):
 https://github.com/vwax/linux/commit/337e03bb3c1796c96ab8f397ff36e9b543f2c6d5

Here's the devicetree example I mentioned above:

 / {
     #address-cells = <2>;
     #size-cells = <2>;
 
     virtio@0 {
         compatible = "virtio,uml";
         socket-path = ".roadtest/roadtest-work/0/gpio.sock";
         virtio-device-id = <0x29>;
 
         gpio: gpio {
             compatible = "virtio,device29";
 
             gpio-controller;
             #gpio-cells = <2>;
 
             interrupt-controller;
             #interrupt-cells = <2>;
         };
     };
 
     virtio@2 {
         compatible = "virtio,uml";
         socket-path = ".roadtest/roadtest-work/0/platform.sock";
         virtio-device-id = <1234>;
         ranges;
 
         platform: bus@0,0 {
                 compatible = "virtio,device4d2", "simple-bus";
                 reg = <0x00000 0x10000000 0x0 0x10000>;
                 interrupt-parent = <&gpio>;
		 // Could use range translation here to avoid absolute
		 // addresses in reg properties
                 ranges;
         };
     };
 
 };
 
 &platform {
     foo@10001000 {
             compatible = "some-platform-device-complatible";
             reg = <0x00000 0x10001000 0 0x1000>;
             interrupts = <2 4>;
     };

     bar@10002000 {
             compatible = "another-platform-device-complatible";
             reg = <0x00000 0x10002000 0 0x1000>;
             interrupts = <3 4>;
     };
 };

