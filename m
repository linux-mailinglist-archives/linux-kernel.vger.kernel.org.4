Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9E5E9A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIZHOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiIZHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0163B858
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664176459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXiARgUsG+PUWi1cWxOlhUBb4oeulSL8cu/tM+c0DoA=;
        b=LejZambmcayVEdoNCfTLyJRQ1ucGe4y72w+/iHFBCHybTzUhTNZyF1m4wEpG3ruSrKagSB
        DV2IiLlOHYbFHFJknla7L3Z2gG+IgWCMXGvdrJJkLE/8eKM6vudZF5Iw5dsg4+D0rvZq9I
        GAisbp8qqAaGOGfPbSqwimC13zh+sPU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-31-FUFn7ifqNk29tcQyEMGjWw-1; Mon, 26 Sep 2022 03:14:17 -0400
X-MC-Unique: FUFn7ifqNk29tcQyEMGjWw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-12777f2df6aso2012660fac.14
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XXiARgUsG+PUWi1cWxOlhUBb4oeulSL8cu/tM+c0DoA=;
        b=KtRZmDcu6pdy1MiLuszCi984rdNqsirEq6ewjSJE5pS9cM4SxAAHZ8q4R44L9WKB2G
         HamalshlOyyHTBkJOIL9U5MUJikhi/hXYihza58q0j9SAtupQQIEzGqy4EP8Sk1reNFm
         Ul7DJycBS0nYXCVIxDoWYOhm33uQg/0q5Xf9yybcP1D4ItYGs+hqSC8meQRv4Xlj1nJv
         OuKJUJWTrmTnk16y/6vqJebq1UzsNUZDkTiCW2N05ERRLnuxwy7hZ+JfgzHh2pxoR1Re
         AkXfc5SApPvgo/jrshvio8YIxUnGPyGvvNtDkv+jl7b6dX8EOBVgx2CE1W8AxKratPaF
         FIuQ==
X-Gm-Message-State: ACrzQf3A2yO2lU8PRFKdCzcgNuB8/SwXJi2coh0hNJQM3s42Ack0tJLq
        moJjqM3GstQjUhiG4onEDhbwEEqTAsBVPOXkXRZUhiW09N80nZHTnUyOE/ynKuxS7M8/14wPbqU
        m1JCFEYgzw3CbCr9zTxa505zJvOx5N0gj3vSNPWE8
X-Received: by 2002:a4a:1101:0:b0:476:7b37:e379 with SMTP id 1-20020a4a1101000000b004767b37e379mr24026ooc.57.1664176456205;
        Mon, 26 Sep 2022 00:14:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TUJ30sHwYR/Es/rIpBdbt2i7FD4cKNj6nawhekXj4N+TplLFWJjSMoJbr8rSvo64GUcjqZEfHt/vc3cVbDKo=
X-Received: by 2002:a4a:1101:0:b0:476:7b37:e379 with SMTP id
 1-20020a4a1101000000b004767b37e379mr24011ooc.57.1664176455971; Mon, 26 Sep
 2022 00:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-4-jasowang@redhat.com>
 <649cf77d-849b-1ed1-e804-3abab9e339d1@oracle.com>
In-Reply-To: <649cf77d-849b-1ed1-e804-3abab9e339d1@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Sep 2022 15:14:05 +0800
Message-ID: <CACGkMEvHNdp1MCt4VLVGFnC-CEqgpur+uwXiRz1d6ke30L-iJg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vp_vdpa: support feature provisioning
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        eperezma <eperezma@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Gautam Dawar <gdawar@xilinx.com>, Cindy Lu <lulu@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 4:11 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 9/21/2022 7:43 PM, Jason Wang wrote:
> > This patch allows the device features to be provisioned via
> > netlink. This is done by:
> >
> > 1) validating the provisioned features to be a subset of the parent
> >     features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > For example:
> >
> > # vdpa mgmtdev show
> > pci/0000:02:00.0:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
> >    GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_ECN HOST_UFO
> >    MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN CTRL_RX_EXTRA
> >    GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
> >    VERSION_1 ACCESS_PLATFORM
> >
> > 1) provision vDPA device with all features that are supported by the virtio-pci
> >
> > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0
> > # vdpa dev config show
> > dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> >    negotiated_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC
> >    GUEST_TSO4 GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6
> >    HOST_ECN HOST_UFO MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN
> >    GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
> >    VERSION_1 ACCESS_PLATFORM
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
> > # dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
> >    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index 04522077735b..4b28e0c95ba2 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/virtio_ring.h>
> >   #include <linux/virtio_pci.h>
> >   #include <linux/virtio_pci_modern.h>
> > +#include <uapi/linux/vdpa.h>
> >
> >   #define VP_VDPA_QUEUE_MAX 256
> >   #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> > @@ -35,6 +36,7 @@ struct vp_vdpa {
> >       struct virtio_pci_modern_device *mdev;
> >       struct vp_vring *vring;
> >       struct vdpa_callback config_cb;
> > +     u64 device_features;
> >       char msix_name[VP_VDPA_NAME_SIZE];
> >       int config_irq;
> >       int queues;
> > @@ -66,9 +68,9 @@ static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
> >
> >   static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> >   {
> > -     struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > +     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> >
> > -     return vp_modern_get_features(mdev);
> > +     return vp_vdpa->device_features;
> >   }
> >
> >   static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> > @@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >       struct pci_dev *pdev = mdev->pci_dev;
> >       struct device *dev = &pdev->dev;
> >       struct vp_vdpa *vp_vdpa = NULL;
> > +     u64 device_features;
> >       int ret, i;
> >
> >       vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > @@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >       vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> >       vp_vdpa->mdev = mdev;
> >
> > +     device_features = vp_modern_get_features(mdev);
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (add_config->device_features & ~device_features)
> > +                     return -EINVAL;
> Should use "goto err" rather than direct return. Also, would be the best
> to tell user the reason why device creation is failing. In the other
> places of the same function, dev_err() or dev_warn() is used.

Right, let me fix this.

Thanks

>
> -Siwei
>
> > +             device_features &= add_config->device_features;
> > +     }
> > +     vp_vdpa->device_features = device_features;
> > +
> >       ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> >       if (ret) {
> >               dev_err(&pdev->dev,
> > @@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >       mgtdev->id_table = mdev_id;
> >       mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
> >       mgtdev->supported_features = vp_modern_get_features(mdev);
> > +     mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
> >       pci_set_master(pdev);
> >       pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> >
>

