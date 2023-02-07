Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380FA68D4BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBGKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjBGKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:48:16 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1F18A9B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:48:11 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id cz15so6173851vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ru0W1u7S0jk2HX+hhCvFQCrMqxoVwfc1t+bHXy90Hs=;
        b=vvI4aOQ0hrLh273+yBCr6nNkZLJeeKE+hvIJX4ZkAL14HlspmMlWVJURN9t+gKLGUK
         zTdst6aYeMhJ5IQLeFUk0n6DIyQVSRIQa7o9YB115lJe5WosT4rw3L20pxfBWGsL0BaV
         OmD5qnoX2PNG2vSGqc1CInX6Cxy+Ndkzjkj7zM98//B3H176tnOS4g3A2n0ue5u9GNZJ
         UmFP0BPAdTuq5IajxxjHSt5e/W+Y127Wrjgs5xvJNBoVJezWifO/W11AXWHga9zSedCL
         SrhpmkHyoTpzxs2SWNSSYdl5WwywFrOGSYPpJp15hGFXcPHSqiWbJb4acF3/Abq5PSU/
         MUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ru0W1u7S0jk2HX+hhCvFQCrMqxoVwfc1t+bHXy90Hs=;
        b=XRoG7VbJ432zg8cj5FA13yoBDuvUuQf1X3rxmqf3SEAUWnecppkNkMARodlvDuvHlO
         mmYG91LUhn8K+Yv9+2fwZaoUJhGsUh/9CHsrI9an48LGWgZZJOPRAI28AdYkyoink6uA
         wNveruLQOxi1iBFy8+8NnFVb2XEapkFBWVueZHVA8f+hKJH6ZOTY9H4Fs/NvJQfYaMjr
         DGasfTbFai4MyPqOzMikNVTVSLuZ2xI0VzIx9L6c7eP0tZJMndd4ecrnvoL3vRerH2JP
         MiG7lBJg1jRu09gi2bq2dTigcOsWPMOVC1S1P/Gc+l230IRM1DTNXv35XY9DbjL8zAKp
         uAPQ==
X-Gm-Message-State: AO0yUKV2kH7iQb3yScH4Y57Eb5kbP0bI8EIqYRYS+rtpEpNwnGLZ/sUL
        A5m6lASYDdxl4OG/JaLCzaOFnWdewXp/TVtusAARlw==
X-Google-Smtp-Source: AK7set+hnJ9SoCPi4cgH1rFEEe5KH703fs+bcaKw5RXgjwoNHjCF+9yMoz9rjazPPItR1ksMcjS5Eg4uXtxXnSI7jxA=
X-Received: by 2002:a67:f44e:0:b0:40e:14c9:1fa4 with SMTP id
 r14-20020a67f44e000000b0040e14c91fa4mr578970vsn.84.1675766890125; Tue, 07 Feb
 2023 02:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203052114-mutt-send-email-mst@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 19:47:59 +0900
Message-ID: <CANXvt5rqNVzFYDNR313jzn1dAjCPUuNtD=e8wFUzTvkwTkw7ew@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP function driver
 to provide virtio net device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=E5=B9=B42=E6=9C=883=E6=97=A5(=E9=87=91) 19:22 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Fri, Feb 03, 2023 at 07:04:18PM +0900, Shunsuke Mie wrote:
> > Add a new endpoint(EP) function driver to provide virtio-net device. Th=
is
> > function not only shows virtio-net device for PCIe host system, but als=
o
> > provides virtio-net device to EP side(local) system. Virtualy those net=
work
> > devices are connected, so we can use to communicate over IP like a simp=
le
> > NIC.
> >
> > Architecture overview is following:
> >
> > to Host       |                       to Endpoint
> > network stack |                 network stack
> >       |       |                       |
> > +-----------+ |       +-----------+   +-----------+
> > |virtio-net | |       |virtio-net |   |virtio-net |
> > |driver     | |       |EP function|---|driver     |
> > +-----------+ |       +-----------+   +-----------+
> >       |       |             |
> > +-----------+ | +-----------+
> > |PCIeC      | | |PCIeC      |
> > |Rootcomplex|-|-|Endpoint   |
> > +-----------+ | +-----------+
> >   Host side   |          Endpoint side
> >
> > This driver uses PCIe EP framework to show virtio-net (pci) device Host
> > side, and generate virtual virtio-net device and register to EP side.
> > A communication date
>
> data?
>
> > is diractly
>
> directly?
Sorry, I have to revise this comment.
> > transported between virtqueue level
> > with each other using PCIe embedded DMA controller.
> >
> > by a limitation of the hardware and Linux EP framework, this function
> > follows a virtio legacy specification.
>
> what exactly is the limitation and why does it force legacy?
Modern virtio pci device have to provide a virtio pci capability,
Designware's PCIe controller is equipped to several boards. There is
no                                        functionality in the
controller to implement custom pci capability at
least. And the PCI EP framework is not supported either.

Those explanations have to be located on the cover letter. I'll add these.
> > This function driver has beed tested on S4 Rcar (r8a779fa-spider) board=
 but
> > just use the PCIe EP framework and depends on the PCIe EDMA.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> >  drivers/pci/endpoint/functions/Makefile       |   1 +
> >  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
> >  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
> >  6 files changed, 1440 insertions(+)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
> >
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpo=
int/functions/Kconfig
> > index 9fd560886871..f88d8baaf689 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -37,3 +37,15 @@ config PCI_EPF_VNTB
> >         between PCI Root Port and PCIe Endpoint.
> >
> >         If in doubt, say "N" to disable Endpoint NTB driver.
> > +
> > +config PCI_EPF_VNET
> > +     tristate "PCI Endpoint virtio-net driver"
> > +     depends on PCI_ENDPOINT
> > +     select PCI_ENDPOINT_VIRTIO
> > +     select VHOST_RING
> > +     select VHOST_IOMEM
> > +     help
> > +       PCIe Endpoint virtio-net function implementation. This module e=
nables to
> > +       show the virtio-net as pci device to PCIe Host side, and, anoth=
er
> > +       virtio-net device show to local machine. Those devices can comm=
unicate
> > +       each other.
> > diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endp=
oint/functions/Makefile
> > index 5c13001deaba..74cc4c330c62 100644
> > --- a/drivers/pci/endpoint/functions/Makefile
> > +++ b/drivers/pci/endpoint/functions/Makefile
> > @@ -6,3 +6,4 @@
> >  obj-$(CONFIG_PCI_EPF_TEST)           +=3D pci-epf-test.o
> >  obj-$(CONFIG_PCI_EPF_NTB)            +=3D pci-epf-ntb.o
> >  obj-$(CONFIG_PCI_EPF_VNTB)           +=3D pci-epf-vntb.o
> > +obj-$(CONFIG_PCI_EPF_VNET)           +=3D pci-epf-vnet.o pci-epf-vnet-=
rc.o pci-epf-vnet-ep.o
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vnet-ep.c b/drivers=
/pci/endpoint/functions/pci-epf-vnet-ep.c
> > new file mode 100644
> > index 000000000000..93b7e00e8d06
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions work for Endpoint side(local) using EPF framework
> > + */
> > +#include <linux/pci-epc.h>
> > +#include <linux/virtio_pci.h>
> > +#include <linux/virtio_net.h>
> > +#include <linux/virtio_ring.h>
> > +
> > +#include "pci-epf-vnet.h"
> > +
> > +static inline struct epf_vnet *vdev_to_vnet(struct virtio_device *vdev=
)
> > +{
> > +     return container_of(vdev, struct epf_vnet, ep.vdev);
> > +}
> > +
> > +static void epf_vnet_ep_set_status(struct epf_vnet *vnet, u16 status)
> > +{
> > +     vnet->ep.net_config_status |=3D status;
> > +}
> > +
> > +static void epf_vnet_ep_clear_status(struct epf_vnet *vnet, u16 status=
)
> > +{
> > +     vnet->ep.net_config_status &=3D ~status;
> > +}
> > +
> > +static void epf_vnet_ep_raise_config_irq(struct epf_vnet *vnet)
> > +{
> > +     virtio_config_changed(&vnet->ep.vdev);
> > +}
> > +
> > +void epf_vnet_ep_announce_linkup(struct epf_vnet *vnet)
> > +{
> > +     epf_vnet_ep_set_status(vnet,
> > +                            VIRTIO_NET_S_LINK_UP | VIRTIO_NET_S_ANNOUN=
CE);
> > +     epf_vnet_ep_raise_config_irq(vnet);
> > +}
> > +
> > +void epf_vnet_ep_notify(struct epf_vnet *vnet, struct virtqueue *vq)
> > +{
> > +     vring_interrupt(0, vq);
> > +}
> > +
> > +static int epf_vnet_ep_process_ctrlq_entry(struct epf_vnet *vnet)
> > +{
> > +     struct vringh *vrh =3D &vnet->ep.ctlvrh;
> > +     struct vringh_kiov *wiov =3D &vnet->ep.ctl_riov;
> > +     struct vringh_kiov *riov =3D &vnet->ep.ctl_wiov;
> > +     struct virtio_net_ctrl_hdr *hdr;
> > +     virtio_net_ctrl_ack *ack;
> > +     int err;
> > +     u16 head;
> > +     size_t len;
> > +
> > +     err =3D vringh_getdesc(vrh, riov, wiov, &head);
> > +     if (err <=3D 0)
> > +             goto done;
> > +
> > +     len =3D vringh_kiov_length(riov);
> > +     if (len < sizeof(*hdr)) {
> > +             pr_debug("Command is too short: %ld\n", len);
> > +             err =3D -EIO;
> > +             goto done;
> > +     }
> > +
> > +     if (vringh_kiov_length(wiov) < sizeof(*ack)) {
> > +             pr_debug("Space for ack is not enough\n");
> > +             err =3D -EIO;
> > +             goto done;
> > +     }
> > +
> > +     hdr =3D phys_to_virt((unsigned long)riov->iov[riov->i].iov_base);
> > +     ack =3D phys_to_virt((unsigned long)wiov->iov[wiov->i].iov_base);
> > +
> > +     switch (hdr->class) {
> > +     case VIRTIO_NET_CTRL_ANNOUNCE:
> > +             if (hdr->cmd !=3D VIRTIO_NET_CTRL_ANNOUNCE_ACK) {
> > +                     pr_debug("Invalid command: announce: %d\n", hdr->=
cmd);
> > +                     goto done;
> > +             }
> > +
> > +             epf_vnet_ep_clear_status(vnet, VIRTIO_NET_S_ANNOUNCE);
> > +             *ack =3D VIRTIO_NET_OK;
> > +             break;
> > +     default:
> > +             pr_debug("Found not supported class: %d\n", hdr->class);
> > +             err =3D -EIO;
> > +     }
> > +
> > +done:
> > +     vringh_complete(vrh, head, len);
> > +     return err;
> > +}
> > +
> > +static u64 epf_vnet_ep_vdev_get_features(struct virtio_device *vdev)
> > +{
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vdev);
> > +
> > +     return vnet->virtio_features;
> > +}
> > +
> > +static int epf_vnet_ep_vdev_finalize_features(struct virtio_device *vd=
ev)
> > +{
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vdev);
> > +
> > +     if (vdev->features !=3D vnet->virtio_features)
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static void epf_vnet_ep_vdev_get_config(struct virtio_device *vdev,
> > +                                     unsigned int offset, void *buf,
> > +                                     unsigned int len)
> > +{
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vdev);
> > +     const unsigned int mac_len =3D sizeof(vnet->vnet_cfg.mac);
> > +     const unsigned int status_len =3D sizeof(vnet->vnet_cfg.status);
> > +     unsigned int copy_len;
> > +
> > +     switch (offset) {
> > +     case offsetof(struct virtio_net_config, mac):
> > +             /* This PCIe EP function doesn't provide a VIRTIO_NET_F_M=
AC feature, so just
> > +              * clear the buffer.
> > +              */
> > +             copy_len =3D len >=3D mac_len ? mac_len : len;
> > +             memset(buf, 0x00, copy_len);
> > +             len -=3D copy_len;
> > +             buf +=3D copy_len;
> > +             fallthrough;
> > +     case offsetof(struct virtio_net_config, status):
> > +             copy_len =3D len >=3D status_len ? status_len : len;
> > +             memcpy(buf, &vnet->ep.net_config_status, copy_len);
> > +             len -=3D copy_len;
> > +             buf +=3D copy_len;
> > +             fallthrough;
> > +     default:
> > +             if (offset > sizeof(vnet->vnet_cfg)) {
> > +                     memset(buf, 0x00, len);
> > +                     break;
> > +             }
> > +             memcpy(buf, (void *)&vnet->vnet_cfg + offset, len);
> > +     }
> > +}
> > +
> > +static void epf_vnet_ep_vdev_set_config(struct virtio_device *vdev,
> > +                                     unsigned int offset, const void *=
buf,
> > +                                     unsigned int len)
> > +{
> > +     /* Do nothing, because all of virtio net config space is readonly=
. */
> > +}
> > +
> > +static u8 epf_vnet_ep_vdev_get_status(struct virtio_device *vdev)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void epf_vnet_ep_vdev_set_status(struct virtio_device *vdev, u8=
 status)
> > +{
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vdev);
> > +
> > +     if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> > +             epf_vnet_init_complete(vnet, EPF_VNET_INIT_COMPLETE_EP);
> > +}
> > +
> > +static void epf_vnet_ep_vdev_reset(struct virtio_device *vdev)
> > +{
> > +     pr_debug("doesn't support yet");
> > +}
> > +
> > +static bool epf_vnet_ep_vdev_vq_notify(struct virtqueue *vq)
> > +{
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vq->vdev);
> > +     struct vringh *tx_vrh =3D &vnet->ep.txvrh;
> > +     struct vringh *rx_vrh =3D &vnet->rc.rxvrh->vrh;
> > +     struct vringh_kiov *tx_iov =3D &vnet->ep.tx_iov;
> > +     struct vringh_kiov *rx_iov =3D &vnet->rc.rx_iov;
> > +     int err;
> > +
> > +     /* Support only one queue pair */
> > +     switch (vq->index) {
> > +     case 0: // rx queue
> > +             break;
> > +     case 1: // tx queue
> > +             while ((err =3D epf_vnet_transfer(vnet, tx_vrh, rx_vrh, t=
x_iov,
> > +                                             rx_iov, DMA_MEM_TO_DEV)) =
> 0)
> > +                     ;
> > +             if (err < 0)
> > +                     pr_debug("Failed to transmit: EP -> Host: %d\n", =
err);
> > +             break;
> > +     case 2: // control queue
> > +             epf_vnet_ep_process_ctrlq_entry(vnet);
> > +             break;
> > +     default:
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static int epf_vnet_ep_vdev_find_vqs(struct virtio_device *vdev,
> > +                                  unsigned int nvqs, struct virtqueue =
*vqs[],
> > +                                  vq_callback_t *callback[],
> > +                                  const char *const names[], const boo=
l *ctx,
> > +                                  struct irq_affinity *desc)
> > +{
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vdev);
> > +     const size_t vq_size =3D epf_vnet_get_vq_size();
> > +     int i;
> > +     int err;
> > +     int qidx;
> > +
> > +     for (qidx =3D 0, i =3D 0; i < nvqs; i++) {
> > +             struct virtqueue *vq;
> > +             struct vring *vring;
> > +             struct vringh *vrh;
> > +
> > +             if (!names[i]) {
> > +                     vqs[i] =3D NULL;
> > +                     continue;
> > +             }
> > +
> > +             vq =3D vring_create_virtqueue(qidx++, vq_size,
> > +                                         VIRTIO_PCI_VRING_ALIGN, vdev,=
 true,
> > +                                         false, ctx ? ctx[i] : false,
> > +                                         epf_vnet_ep_vdev_vq_notify,
> > +                                         callback[i], names[i]);
> > +             if (!vq) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_del_vqs;
> > +             }
> > +
> > +             vqs[i] =3D vq;
> > +             vring =3D virtqueue_get_vring(vq);
> > +
> > +             switch (i) {
> > +             case 0: // rx
> > +                     vrh =3D &vnet->ep.rxvrh;
> > +                     vnet->ep.rxvq =3D vq;
> > +                     break;
> > +             case 1: // tx
> > +                     vrh =3D &vnet->ep.txvrh;
> > +                     vnet->ep.txvq =3D vq;
> > +                     break;
> > +             case 2: // control
> > +                     vrh =3D &vnet->ep.ctlvrh;
> > +                     vnet->ep.ctlvq =3D vq;
> > +                     break;
> > +             default:
> > +                     err =3D -EIO;
> > +                     goto err_del_vqs;
> > +             }
> > +
> > +             err =3D vringh_init_kern(vrh, vnet->virtio_features, vq_s=
ize,
> > +                                    true, GFP_KERNEL, vring->desc,
> > +                                    vring->avail, vring->used);
> > +             if (err) {
> > +                     pr_err("failed to init vringh for vring %d\n", i)=
;
> > +                     goto err_del_vqs;
> > +             }
> > +     }
> > +
> > +     err =3D epf_vnet_init_kiov(&vnet->ep.tx_iov, vq_size);
> > +     if (err)
> > +             goto err_free_kiov;
> > +     err =3D epf_vnet_init_kiov(&vnet->ep.rx_iov, vq_size);
> > +     if (err)
> > +             goto err_free_kiov;
> > +     err =3D epf_vnet_init_kiov(&vnet->ep.ctl_riov, vq_size);
> > +     if (err)
> > +             goto err_free_kiov;
> > +     err =3D epf_vnet_init_kiov(&vnet->ep.ctl_wiov, vq_size);
> > +     if (err)
> > +             goto err_free_kiov;
> > +
> > +     return 0;
> > +
> > +err_free_kiov:
> > +     epf_vnet_deinit_kiov(&vnet->ep.tx_iov);
> > +     epf_vnet_deinit_kiov(&vnet->ep.rx_iov);
> > +     epf_vnet_deinit_kiov(&vnet->ep.ctl_riov);
> > +     epf_vnet_deinit_kiov(&vnet->ep.ctl_wiov);
> > +
> > +err_del_vqs:
> > +     for (; i >=3D 0; i--) {
> > +             if (!names[i])
> > +                     continue;
> > +
> > +             if (!vqs[i])
> > +                     continue;
> > +
> > +             vring_del_virtqueue(vqs[i]);
> > +     }
> > +     return err;
> > +}
> > +
> > +static void epf_vnet_ep_vdev_del_vqs(struct virtio_device *vdev)
> > +{
> > +     struct virtqueue *vq, *n;
> > +     struct epf_vnet *vnet =3D vdev_to_vnet(vdev);
> > +
> > +     list_for_each_entry_safe(vq, n, &vdev->vqs, list)
> > +             vring_del_virtqueue(vq);
> > +
> > +     epf_vnet_deinit_kiov(&vnet->ep.tx_iov);
> > +     epf_vnet_deinit_kiov(&vnet->ep.rx_iov);
> > +     epf_vnet_deinit_kiov(&vnet->ep.ctl_riov);
> > +     epf_vnet_deinit_kiov(&vnet->ep.ctl_wiov);
> > +}
> > +
> > +static const struct virtio_config_ops epf_vnet_ep_vdev_config_ops =3D =
{
> > +     .get_features =3D epf_vnet_ep_vdev_get_features,
> > +     .finalize_features =3D epf_vnet_ep_vdev_finalize_features,
> > +     .get =3D epf_vnet_ep_vdev_get_config,
> > +     .set =3D epf_vnet_ep_vdev_set_config,
> > +     .get_status =3D epf_vnet_ep_vdev_get_status,
> > +     .set_status =3D epf_vnet_ep_vdev_set_status,
> > +     .reset =3D epf_vnet_ep_vdev_reset,
> > +     .find_vqs =3D epf_vnet_ep_vdev_find_vqs,
> > +     .del_vqs =3D epf_vnet_ep_vdev_del_vqs,
> > +};
> > +
> > +void epf_vnet_ep_cleanup(struct epf_vnet *vnet)
> > +{
> > +     unregister_virtio_device(&vnet->ep.vdev);
> > +}
> > +
> > +int epf_vnet_ep_setup(struct epf_vnet *vnet)
> > +{
> > +     int err;
> > +     struct virtio_device *vdev =3D &vnet->ep.vdev;
> > +
> > +     vdev->dev.parent =3D vnet->epf->epc->dev.parent;
> > +     vdev->config =3D &epf_vnet_ep_vdev_config_ops;
> > +     vdev->id.vendor =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> > +     vdev->id.device =3D VIRTIO_ID_NET;
> > +
> > +     err =3D register_virtio_device(vdev);
> > +     if (err)
> > +             return err;
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vnet-rc.c b/drivers=
/pci/endpoint/functions/pci-epf-vnet-rc.c
> > new file mode 100644
> > index 000000000000..2ca0245a9134
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
> > @@ -0,0 +1,635 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions work for PCie Host side(remote) using EPF framework.
> > + */
> > +#include <linux/pci-epf.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/pci_ids.h>
> > +#include <linux/sched.h>
> > +#include <linux/virtio_pci.h>
> > +
> > +#include "pci-epf-vnet.h"
> > +
> > +#define VIRTIO_NET_LEGACY_CFG_BAR BAR_0
> > +
> > +/* Returns an out side of the valid queue index. */
> > +static inline u16 epf_vnet_rc_get_number_of_queues(struct epf_vnet *vn=
et)
> > +
> > +{
> > +     /* number of queue pairs and control queue */
> > +     return vnet->vnet_cfg.max_virtqueue_pairs * 2 + 1;
> > +}
> > +
> > +static void epf_vnet_rc_memcpy_config(struct epf_vnet *vnet, size_t of=
fset,
> > +                                   void *buf, size_t len)
> > +{
> > +     void __iomem *base =3D vnet->rc.cfg_base + offset;
> > +
> > +     memcpy_toio(base, buf, len);
> > +}
> > +
> > +static void epf_vnet_rc_set_config8(struct epf_vnet *vnet, size_t offs=
et,
> > +                                 u8 config)
> > +{
> > +     void __iomem *base =3D vnet->rc.cfg_base + offset;
> > +
> > +     iowrite8(ioread8(base) | config, base);
> > +}
> > +
> > +static void epf_vnet_rc_set_config16(struct epf_vnet *vnet, size_t off=
set,
> > +                                  u16 config)
> > +{
> > +     void __iomem *base =3D vnet->rc.cfg_base + offset;
> > +
> > +     iowrite16(ioread16(base) | config, base);
> > +}
> > +
> > +static void epf_vnet_rc_clear_config16(struct epf_vnet *vnet, size_t o=
ffset,
> > +                                    u16 config)
> > +{
> > +     void __iomem *base =3D vnet->rc.cfg_base + offset;
> > +
> > +     iowrite16(ioread16(base) & ~config, base);
> > +}
> > +
> > +static void epf_vnet_rc_set_config32(struct epf_vnet *vnet, size_t off=
set,
> > +                                  u32 config)
> > +{
> > +     void __iomem *base =3D vnet->rc.cfg_base + offset;
> > +
> > +     iowrite32(ioread32(base) | config, base);
> > +}
> > +
> > +static void epf_vnet_rc_raise_config_irq(struct epf_vnet *vnet)
> > +{
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_ISR, VIRTIO_PCI_ISR_CON=
FIG);
> > +     queue_work(vnet->rc.irq_wq, &vnet->rc.raise_irq_work);
> > +}
> > +
> > +void epf_vnet_rc_announce_linkup(struct epf_vnet *vnet)
> > +{
> > +     epf_vnet_rc_set_config16(vnet,
> > +                              VIRTIO_PCI_CONFIG_OFF(false) +
> > +                                      offsetof(struct virtio_net_confi=
g,
> > +                                               status),
> > +                              VIRTIO_NET_S_LINK_UP | VIRTIO_NET_S_ANNO=
UNCE);
> > +     epf_vnet_rc_raise_config_irq(vnet);
> > +}
> > +
> > +/*
> > + * For the PCIe host, this driver shows legacy virtio-net device. Beca=
use,
> > + * virtio structure pci capabilities is mandatory for modern virtio de=
vice,
> > + * but there is no PCIe EP hardware that can be configured with any pc=
i
> > + * capabilities and Linux PCIe EP framework doesn't support it.
> > + */
> > +static struct pci_epf_header epf_vnet_pci_header =3D {
> > +     .vendorid =3D PCI_VENDOR_ID_REDHAT_QUMRANET,
> > +     .deviceid =3D VIRTIO_TRANS_ID_NET,
> > +     .subsys_vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET,
> > +     .subsys_id =3D VIRTIO_ID_NET,
> > +     .revid =3D 0,
> > +     .baseclass_code =3D PCI_BASE_CLASS_NETWORK,
> > +     .interrupt_pin =3D PCI_INTERRUPT_PIN,
> > +};
> > +
> > +static void epf_vnet_rc_setup_configs(struct epf_vnet *vnet,
> > +                                   void __iomem *cfg_base)
> > +{
> > +     u16 default_qindex =3D epf_vnet_rc_get_number_of_queues(vnet);
> > +
> > +     epf_vnet_rc_set_config32(vnet, VIRTIO_PCI_HOST_FEATURES,
> > +                              vnet->virtio_features);
> > +
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_ISR, VIRTIO_PCI_ISR_QUE=
UE);
> > +     /*
> > +      * Initialize the queue notify and selector to outside of the app=
ropriate
> > +      * virtqueue index. It is used to detect change with polling. The=
re is no
> > +      * other ways to detect host side driver updateing those values
> > +      */
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_NOTIFY, default_q=
index);
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_SEL, default_qind=
ex);
> > +     /* This pfn is also set to 0 for the polling as well */
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_PFN, 0);
> > +
> > +     epf_vnet_rc_set_config16(vnet, VIRTIO_PCI_QUEUE_NUM,
> > +                              epf_vnet_get_vq_size());
> > +     epf_vnet_rc_set_config8(vnet, VIRTIO_PCI_STATUS, 0);
> > +     epf_vnet_rc_memcpy_config(vnet, VIRTIO_PCI_CONFIG_OFF(false),
> > +                               &vnet->vnet_cfg, sizeof(vnet->vnet_cfg)=
);
> > +}
> > +
> > +static void epf_vnet_cleanup_bar(struct epf_vnet *vnet)
> > +{
> > +     struct pci_epf *epf =3D vnet->epf;
> > +
> > +     pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
> > +                       &epf->bar[VIRTIO_NET_LEGACY_CFG_BAR]);
> > +     pci_epf_free_space(epf, vnet->rc.cfg_base, VIRTIO_NET_LEGACY_CFG_=
BAR,
> > +                        PRIMARY_INTERFACE);
> > +}
> > +
> > +static int epf_vnet_setup_bar(struct epf_vnet *vnet)
> > +{
> > +     int err;
> > +     size_t cfg_bar_size =3D
> > +             VIRTIO_PCI_CONFIG_OFF(false) + sizeof(struct virtio_net_c=
onfig);
> > +     struct pci_epf *epf =3D vnet->epf;
> > +     const struct pci_epc_features *features;
> > +     struct pci_epf_bar *config_bar =3D &epf->bar[VIRTIO_NET_LEGACY_CF=
G_BAR];
> > +
> > +     features =3D pci_epc_get_features(epf->epc, epf->func_no, epf->vf=
unc_no);
> > +     if (!features) {
> > +             pr_debug("Failed to get PCI EPC features\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (features->reserved_bar & BIT(VIRTIO_NET_LEGACY_CFG_BAR)) {
> > +             pr_debug("Cannot use the PCI BAR for legacy virtio pci\n"=
);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (features->bar_fixed_size[VIRTIO_NET_LEGACY_CFG_BAR]) {
> > +             if (cfg_bar_size >
> > +                 features->bar_fixed_size[VIRTIO_NET_LEGACY_CFG_BAR]) =
{
> > +                     pr_debug("PCI BAR size is not enough\n");
> > +                     return -ENOMEM;
> > +             }
> > +     }
> > +
> > +     config_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
> > +
> > +     vnet->rc.cfg_base =3D pci_epf_alloc_space(epf, cfg_bar_size,
> > +                                             VIRTIO_NET_LEGACY_CFG_BAR=
,
> > +                                             features->align,
> > +                                             PRIMARY_INTERFACE);
> > +     if (!vnet->rc.cfg_base) {
> > +             pr_debug("Failed to allocate virtio-net config memory\n")=
;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     epf_vnet_rc_setup_configs(vnet, vnet->rc.cfg_base);
> > +
> > +     err =3D pci_epc_set_bar(epf->epc, epf->func_no, epf->vfunc_no,
> > +                           config_bar);
> > +     if (err) {
> > +             pr_debug("Failed to set PCI BAR");
> > +             goto err_free_space;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_free_space:
> > +     pci_epf_free_space(epf, vnet->rc.cfg_base, VIRTIO_NET_LEGACY_CFG_=
BAR,
> > +                        PRIMARY_INTERFACE);
> > +     return err;
> > +}
> > +
> > +static int epf_vnet_rc_negotiate_configs(struct epf_vnet *vnet, u32 *t=
xpfn,
> > +                                      u32 *rxpfn, u32 *ctlpfn)
> > +{
> > +     const u16 nqueues =3D epf_vnet_rc_get_number_of_queues(vnet);
> > +     const u16 default_sel =3D nqueues;
> > +     u32 __iomem *queue_pfn =3D vnet->rc.cfg_base + VIRTIO_PCI_QUEUE_P=
FN;
> > +     u16 __iomem *queue_sel =3D vnet->rc.cfg_base + VIRTIO_PCI_QUEUE_S=
EL;
> > +     u8 __iomem *pci_status =3D vnet->rc.cfg_base + VIRTIO_PCI_STATUS;
> > +     u32 pfn;
> > +     u16 sel;
> > +     struct {
> > +             u32 pfn;
> > +             u16 sel;
> > +     } tmp[3] =3D {};
> > +     int tmp_index =3D 0;
> > +
> > +     *rxpfn =3D *txpfn =3D *ctlpfn =3D 0;
> > +
> > +     /* To avoid to miss a getting the pfn and selector for virtqueue =
wrote by
> > +      * host driver, we need to implement fast polling with saving.
> > +      *
> > +      * This implementation suspects that the host driver writes pfn o=
nly once
> > +      * for each queues
> > +      */
> > +     while (tmp_index < nqueues) {
> > +             pfn =3D ioread32(queue_pfn);
> > +             if (pfn =3D=3D 0)
> > +                     continue;
> > +
> > +             iowrite32(0, queue_pfn);
> > +
> > +             sel =3D ioread16(queue_sel);
> > +             if (sel =3D=3D default_sel)
> > +                     continue;
> > +
> > +             tmp[tmp_index].pfn =3D pfn;
> > +             tmp[tmp_index].sel =3D sel;
> > +             tmp_index++;
> > +     }
> > +
> > +     while (!((ioread8(pci_status) & VIRTIO_CONFIG_S_DRIVER_OK)))
> > +             ;
> > +
> > +     for (int i =3D 0; i < nqueues; ++i) {
> > +             switch (tmp[i].sel) {
> > +             case 0:
> > +                     *rxpfn =3D tmp[i].pfn;
> > +                     break;
> > +             case 1:
> > +                     *txpfn =3D tmp[i].pfn;
> > +                     break;
> > +             case 2:
> > +                     *ctlpfn =3D tmp[i].pfn;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!*rxpfn || !*txpfn || !*ctlpfn)
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static int epf_vnet_rc_monitor_notify(void *data)
> > +{
> > +     struct epf_vnet *vnet =3D data;
> > +     u16 __iomem *queue_notify =3D vnet->rc.cfg_base + VIRTIO_PCI_QUEU=
E_NOTIFY;
> > +     const u16 notify_default =3D epf_vnet_rc_get_number_of_queues(vne=
t);
> > +
> > +     epf_vnet_init_complete(vnet, EPF_VNET_INIT_COMPLETE_RC);
> > +
> > +     /* Poll to detect a change of the queue_notify register. Sometime=
s this
> > +      * polling misses the change, so try to check each virtqueues
> > +      * everytime.
> > +      */
> > +     while (true) {
> > +             while (ioread16(queue_notify) =3D=3D notify_default)
> > +                     ;
> > +             iowrite16(notify_default, queue_notify);
> > +
> > +             queue_work(vnet->rc.tx_wq, &vnet->rc.tx_work);
> > +             queue_work(vnet->rc.ctl_wq, &vnet->rc.ctl_work);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int epf_vnet_rc_spawn_notify_monitor(struct epf_vnet *vnet)
> > +{
> > +     vnet->rc.notify_monitor_task =3D
> > +             kthread_create(epf_vnet_rc_monitor_notify, vnet,
> > +                            "pci-epf-vnet/cfg_negotiator");
> > +     if (IS_ERR(vnet->rc.notify_monitor_task))
> > +             return PTR_ERR(vnet->rc.notify_monitor_task);
> > +
> > +     /* Change the thread priority to high for polling. */
> > +     sched_set_fifo(vnet->rc.notify_monitor_task);
> > +     wake_up_process(vnet->rc.notify_monitor_task);
> > +
> > +     return 0;
> > +}
> > +
> > +static int epf_vnet_rc_device_setup(void *data)
> > +{
> > +     struct epf_vnet *vnet =3D data;
> > +     struct pci_epf *epf =3D vnet->epf;
> > +     u32 txpfn, rxpfn, ctlpfn;
> > +     const size_t vq_size =3D epf_vnet_get_vq_size();
> > +     int err;
> > +
> > +     err =3D epf_vnet_rc_negotiate_configs(vnet, &txpfn, &rxpfn, &ctlp=
fn);
> > +     if (err) {
> > +             pr_debug("Failed to negatiate configs with driver\n");
> > +             return err;
> > +     }
> > +
> > +     /* Polling phase is finished. This thread backs to normal priorit=
y. */
> > +     sched_set_normal(vnet->rc.device_setup_task, 19);
> > +
> > +     vnet->rc.txvrh =3D pci_epf_virtio_alloc_vringh(epf, vnet->virtio_=
features,
> > +                                                  txpfn, vq_size);
> > +     if (IS_ERR(vnet->rc.txvrh)) {
> > +             pr_debug("Failed to setup virtqueue for tx\n");
> > +             return PTR_ERR(vnet->rc.txvrh);
> > +     }
> > +
> > +     err =3D epf_vnet_init_kiov(&vnet->rc.tx_iov, vq_size);
> > +     if (err)
> > +             goto err_free_epf_tx_vringh;
> > +
> > +     vnet->rc.rxvrh =3D pci_epf_virtio_alloc_vringh(epf, vnet->virtio_=
features,
> > +                                                  rxpfn, vq_size);
> > +     if (IS_ERR(vnet->rc.rxvrh)) {
> > +             pr_debug("Failed to setup virtqueue for rx\n");
> > +             err =3D PTR_ERR(vnet->rc.rxvrh);
> > +             goto err_deinit_tx_kiov;
> > +     }
> > +
> > +     err =3D epf_vnet_init_kiov(&vnet->rc.rx_iov, vq_size);
> > +     if (err)
> > +             goto err_free_epf_rx_vringh;
> > +
> > +     vnet->rc.ctlvrh =3D pci_epf_virtio_alloc_vringh(
> > +             epf, vnet->virtio_features, ctlpfn, vq_size);
> > +     if (IS_ERR(vnet->rc.ctlvrh)) {
> > +             pr_err("failed to setup virtqueue\n");
> > +             err =3D PTR_ERR(vnet->rc.ctlvrh);
> > +             goto err_deinit_rx_kiov;
> > +     }
> > +
> > +     err =3D epf_vnet_init_kiov(&vnet->rc.ctl_riov, vq_size);
> > +     if (err)
> > +             goto err_free_epf_ctl_vringh;
> > +
> > +     err =3D epf_vnet_init_kiov(&vnet->rc.ctl_wiov, vq_size);
> > +     if (err)
> > +             goto err_deinit_ctl_riov;
> > +
> > +     err =3D epf_vnet_rc_spawn_notify_monitor(vnet);
> > +     if (err) {
> > +             pr_debug("Failed to create notify monitor thread\n");
> > +             goto err_deinit_ctl_wiov;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_deinit_ctl_wiov:
> > +     epf_vnet_deinit_kiov(&vnet->rc.ctl_wiov);
> > +err_deinit_ctl_riov:
> > +     epf_vnet_deinit_kiov(&vnet->rc.ctl_riov);
> > +err_free_epf_ctl_vringh:
> > +     pci_epf_virtio_free_vringh(epf, vnet->rc.ctlvrh);
> > +err_deinit_rx_kiov:
> > +     epf_vnet_deinit_kiov(&vnet->rc.rx_iov);
> > +err_free_epf_rx_vringh:
> > +     pci_epf_virtio_free_vringh(epf, vnet->rc.rxvrh);
> > +err_deinit_tx_kiov:
> > +     epf_vnet_deinit_kiov(&vnet->rc.tx_iov);
> > +err_free_epf_tx_vringh:
> > +     pci_epf_virtio_free_vringh(epf, vnet->rc.txvrh);
> > +
> > +     return err;
> > +}
> > +
> > +static int epf_vnet_rc_spawn_device_setup_task(struct epf_vnet *vnet)
> > +{
> > +     vnet->rc.device_setup_task =3D kthread_create(
> > +             epf_vnet_rc_device_setup, vnet, "pci-epf-vnet/cfg_negotia=
tor");
> > +     if (IS_ERR(vnet->rc.device_setup_task))
> > +             return PTR_ERR(vnet->rc.device_setup_task);
> > +
> > +     /* Change the thread priority to high for the polling. */
> > +     sched_set_fifo(vnet->rc.device_setup_task);
> > +     wake_up_process(vnet->rc.device_setup_task);
> > +
> > +     return 0;
> > +}
> > +
> > +static void epf_vnet_rc_tx_handler(struct work_struct *work)
> > +{
> > +     struct epf_vnet *vnet =3D container_of(work, struct epf_vnet, rc.=
tx_work);
> > +     struct vringh *tx_vrh =3D &vnet->rc.txvrh->vrh;
> > +     struct vringh *rx_vrh =3D &vnet->ep.rxvrh;
> > +     struct vringh_kiov *tx_iov =3D &vnet->rc.tx_iov;
> > +     struct vringh_kiov *rx_iov =3D &vnet->ep.rx_iov;
> > +
> > +     while (epf_vnet_transfer(vnet, tx_vrh, rx_vrh, tx_iov, rx_iov,
> > +                              DMA_DEV_TO_MEM) > 0)
> > +             ;
> > +}
> > +
> > +static void epf_vnet_rc_raise_irq_handler(struct work_struct *work)
> > +{
> > +     struct epf_vnet *vnet =3D
> > +             container_of(work, struct epf_vnet, rc.raise_irq_work);
> > +     struct pci_epf *epf =3D vnet->epf;
> > +
> > +     pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> > +                       PCI_EPC_IRQ_LEGACY, 0);
> > +}
> > +
> > +struct epf_vnet_rc_meminfo {
> > +     void __iomem *addr, *virt;
> > +     phys_addr_t phys;
> > +     size_t len;
> > +};
> > +
> > +/* Util function to access PCIe host side memory from local CPU.  */
> > +static struct epf_vnet_rc_meminfo *
> > +epf_vnet_rc_epc_mmap(struct pci_epf *epf, phys_addr_t pci_addr, size_t=
 len)
> > +{
> > +     int err;
> > +     phys_addr_t aaddr, phys_addr;
> > +     size_t asize, offset;
> > +     void __iomem *virt_addr;
> > +     struct epf_vnet_rc_meminfo *meminfo;
> > +
> > +     err =3D pci_epc_mem_align(epf->epc, pci_addr, len, &aaddr, &asize=
);
> > +     if (err) {
> > +             pr_debug("Failed to get EPC align: %d\n", err);
> > +             return NULL;
> > +     }
> > +
> > +     offset =3D pci_addr - aaddr;
> > +
> > +     virt_addr =3D pci_epc_mem_alloc_addr(epf->epc, &phys_addr, asize)=
;
> > +     if (!virt_addr) {
> > +             pr_debug("Failed to allocate epc memory\n");
> > +             return NULL;
> > +     }
> > +
> > +     err =3D pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no, p=
hys_addr,
> > +                            aaddr, asize);
> > +     if (err) {
> > +             pr_debug("Failed to map epc memory\n");
> > +             goto err_epc_free_addr;
> > +     }
> > +
> > +     meminfo =3D kmalloc(sizeof(*meminfo), GFP_KERNEL);
> > +     if (!meminfo)
> > +             goto err_epc_unmap_addr;
> > +
> > +     meminfo->virt =3D virt_addr;
> > +     meminfo->phys =3D phys_addr;
> > +     meminfo->len =3D len;
> > +     meminfo->addr =3D virt_addr + offset;
> > +
> > +     return meminfo;
> > +
> > +err_epc_unmap_addr:
> > +     pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no,
> > +                        meminfo->phys);
> > +err_epc_free_addr:
> > +     pci_epc_mem_free_addr(epf->epc, meminfo->phys, meminfo->virt,
> > +                           meminfo->len);
> > +
> > +     return NULL;
> > +}
> > +
> > +static void epf_vnet_rc_epc_munmap(struct pci_epf *epf,
> > +                                struct epf_vnet_rc_meminfo *meminfo)
> > +{
> > +     pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no,
> > +                        meminfo->phys);
> > +     pci_epc_mem_free_addr(epf->epc, meminfo->phys, meminfo->virt,
> > +                           meminfo->len);
> > +     kfree(meminfo);
> > +}
> > +
> > +static int epf_vnet_rc_process_ctrlq_entry(struct epf_vnet *vnet)
> > +{
> > +     struct vringh_kiov *riov =3D &vnet->rc.ctl_riov;
> > +     struct vringh_kiov *wiov =3D &vnet->rc.ctl_wiov;
> > +     struct vringh *vrh =3D &vnet->rc.ctlvrh->vrh;
> > +     struct pci_epf *epf =3D vnet->epf;
> > +     struct epf_vnet_rc_meminfo *rmem, *wmem;
> > +     struct virtio_net_ctrl_hdr *hdr;
> > +     int err;
> > +     u16 head;
> > +     size_t total_len;
> > +     u8 class, cmd;
> > +
> > +     err =3D vringh_getdesc(vrh, riov, wiov, &head);
> > +     if (err <=3D 0)
> > +             return err;
> > +
> > +     total_len =3D vringh_kiov_length(riov);
> > +
> > +     rmem =3D epf_vnet_rc_epc_mmap(epf, (u64)riov->iov[riov->i].iov_ba=
se,
> > +                                 riov->iov[riov->i].iov_len);
> > +     if (!rmem) {
> > +             err =3D -ENOMEM;
> > +             goto err_abandon_descs;
> > +     }
> > +
> > +     wmem =3D epf_vnet_rc_epc_mmap(epf, (u64)wiov->iov[wiov->i].iov_ba=
se,
> > +                                 wiov->iov[wiov->i].iov_len);
> > +     if (!wmem) {
> > +             err =3D -ENOMEM;
> > +             goto err_epc_unmap_rmem;
> > +     }
> > +
> > +     hdr =3D rmem->addr;
> > +     class =3D ioread8(&hdr->class);
> > +     cmd =3D ioread8(&hdr->cmd);
> > +     switch (ioread8(&hdr->class)) {
> > +     case VIRTIO_NET_CTRL_ANNOUNCE:
> > +             if (cmd !=3D VIRTIO_NET_CTRL_ANNOUNCE_ACK) {
> > +                     pr_err("Found invalid command: announce: %d\n", c=
md);
> > +                     break;
> > +             }
> > +             epf_vnet_rc_clear_config16(
> > +                     vnet,
> > +                     VIRTIO_PCI_CONFIG_OFF(false) +
> > +                             offsetof(struct virtio_net_config, status=
),
> > +                     VIRTIO_NET_S_ANNOUNCE);
> > +             epf_vnet_rc_clear_config16(vnet, VIRTIO_PCI_ISR,
> > +                                        VIRTIO_PCI_ISR_CONFIG);
> > +
> > +             iowrite8(VIRTIO_NET_OK, wmem->addr);
> > +             break;
> > +     default:
> > +             pr_err("Found unsupported class in control queue: %d\n", =
class);
> > +             break;
> > +     }
> > +
> > +     epf_vnet_rc_epc_munmap(epf, rmem);
> > +     epf_vnet_rc_epc_munmap(epf, wmem);
> > +     vringh_complete(vrh, head, total_len);
> > +
> > +     return 1;
> > +
> > +err_epc_unmap_rmem:
> > +     epf_vnet_rc_epc_munmap(epf, rmem);
> > +err_abandon_descs:
> > +     vringh_abandon(vrh, head);
> > +
> > +     return err;
> > +}
> > +
> > +static void epf_vnet_rc_process_ctrlq_entries(struct work_struct *work=
)
> > +{
> > +     struct epf_vnet *vnet =3D
> > +             container_of(work, struct epf_vnet, rc.ctl_work);
> > +
> > +     while (epf_vnet_rc_process_ctrlq_entry(vnet) > 0)
> > +             ;
> > +}
> > +
> > +void epf_vnet_rc_notify(struct epf_vnet *vnet)
> > +{
> > +     queue_work(vnet->rc.irq_wq, &vnet->rc.raise_irq_work);
> > +}
> > +
> > +void epf_vnet_rc_cleanup(struct epf_vnet *vnet)
> > +{
> > +     epf_vnet_cleanup_bar(vnet);
> > +     destroy_workqueue(vnet->rc.tx_wq);
> > +     destroy_workqueue(vnet->rc.irq_wq);
> > +     destroy_workqueue(vnet->rc.ctl_wq);
> > +
> > +     kthread_stop(vnet->rc.device_setup_task);
> > +}
> > +
> > +int epf_vnet_rc_setup(struct epf_vnet *vnet)
> > +{
> > +     int err;
> > +     struct pci_epf *epf =3D vnet->epf;
> > +
> > +     err =3D pci_epc_write_header(epf->epc, epf->func_no, epf->vfunc_n=
o,
> > +                                &epf_vnet_pci_header);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D epf_vnet_setup_bar(vnet);
> > +     if (err)
> > +             return err;
> > +
> > +     vnet->rc.tx_wq =3D
> > +             alloc_workqueue("pci-epf-vnet/tx-wq",
> > +                             WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND,=
 0);
> > +     if (!vnet->rc.tx_wq) {
> > +             pr_debug(
> > +                     "Failed to allocate workqueue for rc -> ep transm=
ission\n");
> > +             err =3D -ENOMEM;
> > +             goto err_cleanup_bar;
> > +     }
> > +
> > +     INIT_WORK(&vnet->rc.tx_work, epf_vnet_rc_tx_handler);
> > +
> > +     vnet->rc.irq_wq =3D
> > +             alloc_workqueue("pci-epf-vnet/irq-wq",
> > +                             WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND,=
 0);
> > +     if (!vnet->rc.irq_wq) {
> > +             pr_debug("Failed to allocate workqueue for irq\n");
> > +             err =3D -ENOMEM;
> > +             goto err_destory_tx_wq;
> > +     }
> > +
> > +     INIT_WORK(&vnet->rc.raise_irq_work, epf_vnet_rc_raise_irq_handler=
);
> > +
> > +     vnet->rc.ctl_wq =3D
> > +             alloc_workqueue("pci-epf-vnet/ctl-wq",
> > +                             WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND,=
 0);
> > +     if (!vnet->rc.ctl_wq) {
> > +             pr_err("Failed to allocate work queue for control queue p=
rocessing\n");
> > +             err =3D -ENOMEM;
> > +             goto err_destory_irq_wq;
> > +     }
> > +
> > +     INIT_WORK(&vnet->rc.ctl_work, epf_vnet_rc_process_ctrlq_entries);
> > +
> > +     err =3D epf_vnet_rc_spawn_device_setup_task(vnet);
> > +     if (err)
> > +             goto err_destory_ctl_wq;
> > +
> > +     return 0;
> > +
> > +err_cleanup_bar:
> > +     epf_vnet_cleanup_bar(vnet);
> > +err_destory_tx_wq:
> > +     destroy_workqueue(vnet->rc.tx_wq);
> > +err_destory_irq_wq:
> > +     destroy_workqueue(vnet->rc.irq_wq);
> > +err_destory_ctl_wq:
> > +     destroy_workqueue(vnet->rc.ctl_wq);
> > +
> > +     return err;
> > +}
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vnet.c b/drivers/pc=
i/endpoint/functions/pci-epf-vnet.c
> > new file mode 100644
> > index 000000000000..e48ad8067796
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vnet.c
> > @@ -0,0 +1,387 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCI Endpoint function driver to impliment virtio-net device.
> > + */
> > +#include <linux/module.h>
> > +#include <linux/pci-epf.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/vringh.h>
> > +#include <linux/dmaengine.h>
> > +
> > +#include "pci-epf-vnet.h"
> > +
> > +static int virtio_queue_size =3D 0x100;
> > +module_param(virtio_queue_size, int, 0444);
> > +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
> > +
> > +int epf_vnet_get_vq_size(void)
> > +{
> > +     return virtio_queue_size;
> > +}
> > +
> > +int epf_vnet_init_kiov(struct vringh_kiov *kiov, const size_t vq_size)
> > +{
> > +     struct kvec *kvec;
> > +
> > +     kvec =3D kmalloc_array(vq_size, sizeof(*kvec), GFP_KERNEL);
> > +     if (!kvec)
> > +             return -ENOMEM;
> > +
> > +     vringh_kiov_init(kiov, kvec, vq_size);
> > +
> > +     return 0;
> > +}
> > +
> > +void epf_vnet_deinit_kiov(struct vringh_kiov *kiov)
> > +{
> > +     kfree(kiov->iov);
> > +}
> > +
> > +void epf_vnet_init_complete(struct epf_vnet *vnet, u8 from)
> > +{
> > +     vnet->init_complete |=3D from;
> > +
> > +     if (!(vnet->init_complete & EPF_VNET_INIT_COMPLETE_EP))
> > +             return;
> > +
> > +     if (!(vnet->init_complete & EPF_VNET_INIT_COMPLETE_RC))
> > +             return;
> > +
> > +     epf_vnet_ep_announce_linkup(vnet);
> > +     epf_vnet_rc_announce_linkup(vnet);
> > +}
> > +
> > +struct epf_dma_filter_param {
> > +     struct device *dev;
> > +     u32 dma_mask;
> > +};
> > +
> > +static bool epf_virtnet_dma_filter(struct dma_chan *chan, void *param)
> > +{
> > +     struct epf_dma_filter_param *fparam =3D param;
> > +     struct dma_slave_caps caps;
> > +
> > +     memset(&caps, 0, sizeof(caps));
> > +     dma_get_slave_caps(chan, &caps);
> > +
> > +     return chan->device->dev =3D=3D fparam->dev &&
> > +            (fparam->dma_mask & caps.directions);
> > +}
> > +
> > +static int epf_vnet_init_edma(struct epf_vnet *vnet, struct device *dm=
a_dev)
> > +{
> > +     struct epf_dma_filter_param param;
> > +     dma_cap_mask_t mask;
> > +     int err;
> > +
> > +     dma_cap_zero(mask);
> > +     dma_cap_set(DMA_SLAVE, mask);
> > +
> > +     param.dev =3D dma_dev;
> > +     param.dma_mask =3D BIT(DMA_MEM_TO_DEV);
> > +     vnet->lr_dma_chan =3D
> > +             dma_request_channel(mask, epf_virtnet_dma_filter, &param)=
;
> > +     if (!vnet->lr_dma_chan)
> > +             return -EOPNOTSUPP;
> > +
> > +     param.dma_mask =3D BIT(DMA_DEV_TO_MEM);
> > +     vnet->rl_dma_chan =3D
> > +             dma_request_channel(mask, epf_virtnet_dma_filter, &param)=
;
> > +     if (!vnet->rl_dma_chan) {
> > +             err =3D -EOPNOTSUPP;
> > +             goto err_release_channel;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_release_channel:
> > +     dma_release_channel(vnet->lr_dma_chan);
> > +
> > +     return err;
> > +}
> > +
> > +static void epf_vnet_deinit_edma(struct epf_vnet *vnet)
> > +{
> > +     dma_release_channel(vnet->lr_dma_chan);
> > +     dma_release_channel(vnet->rl_dma_chan);
> > +}
> > +
> > +static int epf_vnet_dma_single(struct epf_vnet *vnet, phys_addr_t pci,
> > +                            dma_addr_t dma, size_t len,
> > +                            void (*callback)(void *), void *param,
> > +                            enum dma_transfer_direction dir)
> > +{
> > +     struct dma_async_tx_descriptor *desc;
> > +     int err;
> > +     struct dma_chan *chan;
> > +     struct dma_slave_config sconf;
> > +     dma_cookie_t cookie;
> > +     unsigned long flags =3D 0;
> > +
> > +     if (dir =3D=3D DMA_MEM_TO_DEV) {
> > +             sconf.dst_addr =3D pci;
> > +             chan =3D vnet->lr_dma_chan;
> > +     } else {
> > +             sconf.src_addr =3D pci;
> > +             chan =3D vnet->rl_dma_chan;
> > +     }
> > +
> > +     err =3D dmaengine_slave_config(chan, &sconf);
> > +     if (unlikely(err))
> > +             return err;
> > +
> > +     if (callback)
> > +             flags =3D DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
> > +
> > +     desc =3D dmaengine_prep_slave_single(chan, dma, len, dir, flags);
> > +     if (unlikely(!desc))
> > +             return -EIO;
> > +
> > +     desc->callback =3D callback;
> > +     desc->callback_param =3D param;
> > +
> > +     cookie =3D dmaengine_submit(desc);
> > +     err =3D dma_submit_error(cookie);
> > +     if (unlikely(err))
> > +             return err;
> > +
> > +     dma_async_issue_pending(chan);
> > +
> > +     return 0;
> > +}
> > +
> > +struct epf_vnet_dma_callback_param {
> > +     struct epf_vnet *vnet;
> > +     struct vringh *tx_vrh, *rx_vrh;
> > +     struct virtqueue *vq;
> > +     size_t total_len;
> > +     u16 tx_head, rx_head;
> > +};
> > +
> > +static void epf_vnet_dma_callback(void *p)
> > +{
> > +     struct epf_vnet_dma_callback_param *param =3D p;
> > +     struct epf_vnet *vnet =3D param->vnet;
> > +
> > +     vringh_complete(param->tx_vrh, param->tx_head, param->total_len);
> > +     vringh_complete(param->rx_vrh, param->rx_head, param->total_len);
> > +
> > +     epf_vnet_rc_notify(vnet);
> > +     epf_vnet_ep_notify(vnet, param->vq);
> > +
> > +     kfree(param);
> > +}
> > +
> > +/**
> > + * epf_vnet_transfer() - transfer data between tx vring to rx vring us=
ing edma
> > + * @vnet: epf virtio net device to do dma
> > + * @tx_vrh: vringh related to source tx vring
> > + * @rx_vrh: vringh related to target rx vring
> > + * @tx_iov: buffer to use tx
> > + * @rx_iov: buffer to use rx
> > + * @dir: a direction of DMA. local to remote or local from remote
> > + *
> > + * This function returns 0, 1 or error number. The 0 indicates there i=
s not
> > + * data to send. The 1 indicates a request to DMA is succeeded. Other =
error
> > + * numbers shows error, however, ENOSPC means there is no buffer on ta=
rget
> > + * vring, so should retry to call later.
> > + */
> > +int epf_vnet_transfer(struct epf_vnet *vnet, struct vringh *tx_vrh,
> > +                   struct vringh *rx_vrh, struct vringh_kiov *tx_iov,
> > +                   struct vringh_kiov *rx_iov,
> > +                   enum dma_transfer_direction dir)
> > +{
> > +     int err;
> > +     u16 tx_head, rx_head;
> > +     size_t total_tx_len;
> > +     struct epf_vnet_dma_callback_param *cb_param;
> > +     struct vringh_kiov *liov, *riov;
> > +
> > +     err =3D vringh_getdesc(tx_vrh, tx_iov, NULL, &tx_head);
> > +     if (err <=3D 0)
> > +             return err;
> > +
> > +     total_tx_len =3D vringh_kiov_length(tx_iov);
> > +
> > +     err =3D vringh_getdesc(rx_vrh, NULL, rx_iov, &rx_head);
> > +     if (err < 0) {
> > +             goto err_tx_complete;
> > +     } else if (!err) {
> > +             /* There is not space on a vring of destination to transm=
it data, so
> > +              * rollback tx vringh
> > +              */
> > +             vringh_abandon(tx_vrh, tx_head);
> > +             return -ENOSPC;
> > +     }
> > +
> > +     cb_param =3D kmalloc(sizeof(*cb_param), GFP_KERNEL);
> > +     if (!cb_param) {
> > +             err =3D -ENOMEM;
> > +             goto err_rx_complete;
> > +     }
> > +
> > +     cb_param->tx_vrh =3D tx_vrh;
> > +     cb_param->rx_vrh =3D rx_vrh;
> > +     cb_param->tx_head =3D tx_head;
> > +     cb_param->rx_head =3D rx_head;
> > +     cb_param->total_len =3D total_tx_len;
> > +     cb_param->vnet =3D vnet;
> > +
> > +     switch (dir) {
> > +     case DMA_MEM_TO_DEV:
> > +             liov =3D tx_iov;
> > +             riov =3D rx_iov;
> > +             cb_param->vq =3D vnet->ep.txvq;
> > +             break;
> > +     case DMA_DEV_TO_MEM:
> > +             liov =3D rx_iov;
> > +             riov =3D tx_iov;
> > +             cb_param->vq =3D vnet->ep.rxvq;
> > +             break;
> > +     default:
> > +             err =3D -EINVAL;
> > +             goto err_free_param;
> > +     }
> > +
> > +     for (; tx_iov->i < tx_iov->used; tx_iov->i++, rx_iov->i++) {
> > +             size_t len;
> > +             u64 lbase, rbase;
> > +             void (*callback)(void *) =3D NULL;
> > +
> > +             lbase =3D (u64)liov->iov[liov->i].iov_base;
> > +             rbase =3D (u64)riov->iov[riov->i].iov_base;
> > +             len =3D tx_iov->iov[tx_iov->i].iov_len;
> > +
> > +             if (tx_iov->i + 1 =3D=3D tx_iov->used)
> > +                     callback =3D epf_vnet_dma_callback;
> > +
> > +             err =3D epf_vnet_dma_single(vnet, rbase, lbase, len, call=
back,
> > +                                       cb_param, dir);
> > +             if (err)
> > +                     goto err_free_param;
> > +     }
> > +
> > +     return 1;
> > +
> > +err_free_param:
> > +     kfree(cb_param);
> > +err_rx_complete:
> > +     vringh_complete(rx_vrh, rx_head, vringh_kiov_length(rx_iov));
> > +err_tx_complete:
> > +     vringh_complete(tx_vrh, tx_head, total_tx_len);
> > +
> > +     return err;
> > +}
> > +
> > +static int epf_vnet_bind(struct pci_epf *epf)
> > +{
> > +     int err;
> > +     struct epf_vnet *vnet =3D epf_get_drvdata(epf);
> > +
> > +     err =3D epf_vnet_init_edma(vnet, epf->epc->dev.parent);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D epf_vnet_rc_setup(vnet);
> > +     if (err)
> > +             goto err_free_edma;
> > +
> > +     err =3D epf_vnet_ep_setup(vnet);
> > +     if (err)
> > +             goto err_cleanup_rc;
> > +
> > +     return 0;
> > +
> > +err_free_edma:
> > +     epf_vnet_deinit_edma(vnet);
> > +err_cleanup_rc:
> > +     epf_vnet_rc_cleanup(vnet);
> > +
> > +     return err;
> > +}
> > +
> > +static void epf_vnet_unbind(struct pci_epf *epf)
> > +{
> > +     struct epf_vnet *vnet =3D epf_get_drvdata(epf);
> > +
> > +     epf_vnet_deinit_edma(vnet);
> > +     epf_vnet_rc_cleanup(vnet);
> > +     epf_vnet_ep_cleanup(vnet);
> > +}
> > +
> > +static struct pci_epf_ops epf_vnet_ops =3D {
> > +     .bind =3D epf_vnet_bind,
> > +     .unbind =3D epf_vnet_unbind,
> > +};
> > +
> > +static const struct pci_epf_device_id epf_vnet_ids[] =3D {
> > +     { .name =3D "pci_epf_vnet" },
> > +     {}
> > +};
> > +
> > +static void epf_vnet_virtio_init(struct epf_vnet *vnet)
> > +{
> > +     vnet->virtio_features =3D
> > +             BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_STATUS) |
> > +             /* Following features are to skip any of checking and off=
loading, Like a
> > +              * transmission between virtual machines on same system. =
Details are on
> > +              * section 5.1.5 in virtio specification.
> > +              */
> > +             BIT(VIRTIO_NET_F_GUEST_CSUM) | BIT(VIRTIO_NET_F_GUEST_TSO=
4) |
> > +             BIT(VIRTIO_NET_F_GUEST_TSO6) | BIT(VIRTIO_NET_F_GUEST_ECN=
) |
> > +             BIT(VIRTIO_NET_F_GUEST_UFO) |
> > +             // The control queue is just used for linkup announcement=
.
> > +             BIT(VIRTIO_NET_F_CTRL_VQ);
> > +
> > +     vnet->vnet_cfg.max_virtqueue_pairs =3D 1;
> > +     vnet->vnet_cfg.status =3D 0;
> > +     vnet->vnet_cfg.mtu =3D PAGE_SIZE;
> > +}
> > +
> > +static int epf_vnet_probe(struct pci_epf *epf)
> > +{
> > +     struct epf_vnet *vnet;
> > +
> > +     vnet =3D devm_kzalloc(&epf->dev, sizeof(*vnet), GFP_KERNEL);
> > +     if (!vnet)
> > +             return -ENOMEM;
> > +
> > +     epf_set_drvdata(epf, vnet);
> > +     vnet->epf =3D epf;
> > +
> > +     epf_vnet_virtio_init(vnet);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct pci_epf_driver epf_vnet_drv =3D {
> > +     .driver.name =3D "pci_epf_vnet",
> > +     .ops =3D &epf_vnet_ops,
> > +     .id_table =3D epf_vnet_ids,
> > +     .probe =3D epf_vnet_probe,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int __init epf_vnet_init(void)
> > +{
> > +     int err;
> > +
> > +     err =3D pci_epf_register_driver(&epf_vnet_drv);
> > +     if (err) {
> > +             pr_err("Failed to register epf vnet driver\n");
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +module_init(epf_vnet_init);
> > +
> > +static void epf_vnet_exit(void)
> > +{
> > +     pci_epf_unregister_driver(&epf_vnet_drv);
> > +}
> > +module_exit(epf_vnet_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Shunsuke Mie <mie@igel.co.jp>");
> > +MODULE_DESCRIPTION("PCI endpoint function acts as virtio net device");
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vnet.h b/drivers/pc=
i/endpoint/functions/pci-epf-vnet.h
> > new file mode 100644
> > index 000000000000..1e0f90c95578
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vnet.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _PCI_EPF_VNET_H
> > +#define _PCI_EPF_VNET_H
> > +
> > +#include <linux/pci-epf.h>
> > +#include <linux/pci-epf-virtio.h>
> > +#include <linux/virtio_net.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/virtio.h>
> > +
> > +struct epf_vnet {
> > +     //TODO Should this variable be placed here?
> > +     struct pci_epf *epf;
> > +     struct virtio_net_config vnet_cfg;
> > +     u64 virtio_features;
> > +
> > +     // dma channels for local to remote(lr) and remote to local(rl)
> > +     struct dma_chan *lr_dma_chan, *rl_dma_chan;
> > +
> > +     struct {
> > +             void __iomem *cfg_base;
> > +             struct task_struct *device_setup_task;
> > +             struct task_struct *notify_monitor_task;
> > +             struct workqueue_struct *tx_wq, *irq_wq, *ctl_wq;
> > +             struct work_struct tx_work, raise_irq_work, ctl_work;
> > +             struct pci_epf_vringh *txvrh, *rxvrh, *ctlvrh;
> > +             struct vringh_kiov tx_iov, rx_iov, ctl_riov, ctl_wiov;
> > +     } rc;
> > +
> > +     struct {
> > +             struct virtqueue *rxvq, *txvq, *ctlvq;
> > +             struct vringh txvrh, rxvrh, ctlvrh;
> > +             struct vringh_kiov tx_iov, rx_iov, ctl_riov, ctl_wiov;
> > +             struct virtio_device vdev;
> > +             u16 net_config_status;
> > +     } ep;
> > +
> > +#define EPF_VNET_INIT_COMPLETE_EP BIT(0)
> > +#define EPF_VNET_INIT_COMPLETE_RC BIT(1)
> > +     u8 init_complete;
> > +};
> > +
> > +int epf_vnet_rc_setup(struct epf_vnet *vnet);
> > +void epf_vnet_rc_cleanup(struct epf_vnet *vnet);
> > +int epf_vnet_ep_setup(struct epf_vnet *vnet);
> > +void epf_vnet_ep_cleanup(struct epf_vnet *vnet);
> > +
> > +int epf_vnet_get_vq_size(void);
> > +int epf_vnet_init_kiov(struct vringh_kiov *kiov, const size_t vq_size)=
;
> > +void epf_vnet_deinit_kiov(struct vringh_kiov *kiov);
> > +int epf_vnet_transfer(struct epf_vnet *vnet, struct vringh *tx_vrh,
> > +                   struct vringh *rx_vrh, struct vringh_kiov *tx_iov,
> > +                   struct vringh_kiov *rx_iov,
> > +                   enum dma_transfer_direction dir);
> > +void epf_vnet_rc_notify(struct epf_vnet *vnet);
> > +void epf_vnet_ep_notify(struct epf_vnet *vnet, struct virtqueue *vq);
> > +
> > +void epf_vnet_init_complete(struct epf_vnet *vnet, u8 from);
> > +void epf_vnet_ep_announce_linkup(struct epf_vnet *vnet);
> > +void epf_vnet_rc_announce_linkup(struct epf_vnet *vnet);
> > +
> > +#endif // _PCI_EPF_VNET_H
> > --
> > 2.25.1
>
Best,
Shunsuke
