Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56115694E78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBMRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBMRzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:55:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740F1AD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=U7puvbqVcgnomvSY81yMDf+QEHoaE+NYATxfT1qZ+ro=;
        t=1676310899; x=1677520499; b=YO/fOlvaHhVXuzC8pnOGOyAMk6SLQTgPXVDdMK4HtJAtnQU
        yJPbCnLL9wrtN24vJ8pBzqZG3Al47RauUx72h5HNe1JzOCrO5xU4SuVRXKCCxJh8jjmJD+E7Rq0AL
        HByPo3YgZxtjv/svcIWVH20qbCTBejtiEGa4qv6BZ1CqnmEnji0nCJVYTMQFm5FcQGpasXsF+n3Xu
        KvYDp2c/pHPfyqcMFk/4CHfXK40wPasbunJeXQb2WQPDro8QZqPStgmNBKKS2nMNzR4/czh3ZKYc7
        96E4iBtvrFALZR9XVeFt+RJ9fuJm6hcZRw6Br/nghGHy2BEniGaTZaxCifIqb0sA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRd2Q-00BHzu-0A;
        Mon, 13 Feb 2023 18:54:50 +0100
Message-ID: <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
Subject: Re: [PATCH] virt-pci: add platform bus support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     robh@kernel.org, devicetree@lists.infradead.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Date:   Mon, 13 Feb 2023 18:54:49 +0100
In-Reply-To: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
> This driver registers PCI busses, but the underlying virtio protocol
> could just as easily be used to provide a platform bus instead.  If the
> virtio device node in the devicetree indicates that it's compatible with
> simple-bus, register platform devices instead of handling it as a PCI
> bus.
>=20
> Only one platform bus is allowed and the logic MMIO region for the
> platform bus is placed at an arbitrarily-chosen address away from the
> PCI region.

So ... hm. I'm not sure I _like_ this so much. It feels decidedly
strange to put it this way.

But it looks like Richard already applied it, so I suppose look at this
as kind of a retroactive information gathering. :)


> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> My first approach to getting platform drivers working on UML was by
> adding a minimal PCI-to-platform bridge driver, which worked without
> modifications to virt-pci, but that got shot down:
>=20
>  https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@a=
xis.com/

Reading through that ... OK that isn't fun either :-)

Sounds like there's a use case for something else though, but the PCI
IDs issue also makes that thorny.

> @@ -48,6 +51,7 @@ struct um_pci_device_reg {
> =20
>  static struct pci_host_bridge *bridge;
>  static DEFINE_MUTEX(um_pci_mtx);
> +static struct um_pci_device *um_pci_platform_device;
>  static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
>  static struct fwnode_handle *um_pci_fwnode;
>  static struct irq_domain *um_pci_inner_domain;
> @@ -480,6 +484,9 @@ static void um_pci_handle_irq_message(struct virtqueu=
e *vq,
>  	struct virtio_device *vdev =3D vq->vdev;
>  	struct um_pci_device *dev =3D vdev->priv;
> =20
> +	if (!dev->irq)
> +		return;
>=20

Does that mean platform devices don't have interrupts, or does that mean
not all of them must have interrupts?

I'll note that this also would allow the device to send an MSI which
feels a bit wrong? But I guess it doesn't really matter.


So let me ask this: Conceptually, wouldn't the "right" way to handle
this be a new virtio device and protocol and everything, with a new
driver to handle it? I realise that would likely lead to quite a bit of
code duplication, for now I just want to understand the concept here a
bit better.

Such a driver would then define its own messages, requiring (I guess)
the equivalents of
 * VIRTIO_PCIDEV_OP_INT,
 * VIRTIO_PCIDEV_OP_MMIO_READ,
 * VIRTIO_PCIDEV_OP_MMIO_WRITE, and
 * (maybe) VIRTIO_PCIDEV_OP_MMIO_MEMSET,

but not
 * VIRTIO_PCIDEV_OP_CFG_READ,
 * VIRTIO_PCIDEV_OP_CFG_WRITE,
 * VIRTIO_PCIDEV_OP_MSI and
 * VIRTIO_PCIDEV_OP_PME,

right?

How much code would we actually duplicate? Most of virt-pci is dedicated
to the mess of PCI MSI domains, bridges, etc.

The limitation to a single device feels odd, and the fact that you have
to put it into DT under the PCI also seems odd. OTOH, the platform
device has to be _somewhere_ right?

I guess I'm not really sure how to use it, but I suppose that's OK too
:)

Thanks,
johannes
