Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE35BD99D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiITBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiITBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5506651406
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663638382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dNim4t6D3u1EwkeGcilMNCdWN9K4ooOqRZJUBMK5sfw=;
        b=TmBfDkzB5jRkoaINqRZNoDDmbVwhO0iv9nAWlazNrE9wY+45UvXZ+ZX7FHZlE1/a5bSu5o
        ErhjoahlM9g5VdLRlR6jGGJ36bl6ZOBec1iVwt9P2wPKYf2uxfxfiLDdpr88EEgY6oIN9f
        QoHqMvdZeeLkbA6p0ehPhU8wKJ6nyGI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-HX0dBLVgNAC_wmdqdPSfWQ-1; Mon, 19 Sep 2022 21:46:20 -0400
X-MC-Unique: HX0dBLVgNAC_wmdqdPSfWQ-1
Received: by mail-vs1-f69.google.com with SMTP id i29-20020a05610220dd00b00398c850a99eso313366vsr.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dNim4t6D3u1EwkeGcilMNCdWN9K4ooOqRZJUBMK5sfw=;
        b=QhqFIak5XqvGsolLhXPQqzb2DdpOnorMjk4q90JZM9y2qQtd6SoKHrNFAZSfEMr7KC
         V50doT7Na7x8Lf1HlDOm5bYYCftl6j+YnPiI6nt32Ea45YGg/HWPGpZESj3wBzeH66yH
         wA+4K7kbi5VkERWzEpoADNEJ2OUEHk760zQlmdk4Lky7G5XNmgl5nMH0EDXbHdmBJGiI
         7MTSRph+QD02+LfE48lQ3uI1lpZHlACu/WG22etePP578C0YTOEkJe+ZpG/VFxwlo8kL
         j5exFLlDI+cN7aJEk/ea8lo/LkhNPw6QAigKlLPkpkMvckE0WgN7qdw8TvwulRXzMyah
         6g3Q==
X-Gm-Message-State: ACrzQf3Qgv43VMKTRdxm2kJ0zrzqbTp850BaD1Kp8DAXS/V3ezrcxVWn
        bc2HLywAp+9PiA2DQ+vog8gD9qFs3bevtnjfLgJh8XfAE2IIH49c/L+9qI6YitRDYksnZWydT0F
        iLAEGz89NlIMOX6kwnuHGXz7YxP66wu5XmlbCvyiX
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id j1-20020a056102134100b00398889e7f28mr7895721vsl.21.1663638378561;
        Mon, 19 Sep 2022 18:46:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JBb7Mo2xytvr3fAEMap8eoE5rMUKQpFtpDBJku09gWoXRFMGIOXN7RsLeq1N74DEtjIIGtJP0zYUmbEs6kzI=
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr7895714vsl.21.1663638378361; Mon, 19 Sep
 2022 18:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220915085048.12840-1-jasowang@redhat.com> <20220915085048.12840-4-jasowang@redhat.com>
 <DM8PR12MB54006A97A99515542260B5D6AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54006A97A99515542260B5D6AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Sep 2022 09:46:07 +0800
Message-ID: <CACGkMEtfLGjHgFV7bgWrjWoFZyiTQMf9oDBGi5L=diQ5mtNRnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vp_vdpa: support feature provisioning
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 3:05 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, 15 September 2022 11:51
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH 3/3] vp_vdpa: support feature provisioning
> >
> > This patch allows the device features to be provisioned via
> > netlink. This is done by:
> >
> > 1) validating the provisioned features to be a subset of the parent
> >    features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index 04522077735b..4b28e0c95ba2 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/virtio_ring.h>
> >  #include <linux/virtio_pci.h>
> >  #include <linux/virtio_pci_modern.h>
> > +#include <uapi/linux/vdpa.h>
> >
> >  #define VP_VDPA_QUEUE_MAX 256
> >  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> > @@ -35,6 +36,7 @@ struct vp_vdpa {
> >       struct virtio_pci_modern_device *mdev;
> >       struct vp_vring *vring;
> >       struct vdpa_callback config_cb;
> > +     u64 device_features;
> >       char msix_name[VP_VDPA_NAME_SIZE];
> >       int config_irq;
> >       int queues;
> > @@ -66,9 +68,9 @@ static struct virtio_pci_modern_device
> > *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
> >
> >  static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> >  {
> > -     struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > +     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> >
> > -     return vp_modern_get_features(mdev);
> > +     return vp_vdpa->device_features;
> >  }
>
> Unrelated to this patch. Maybe put in another patch?

Actually not, since we don't want to report the features that are
supported by the device, but the features that are provisioned via
netlink:

> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (add_config->device_features & ~device_features)
> > +                     return -EINVAL;
> > +             device_features &= add_config->device_features;
> > +     }
> > +     vp_vdpa->device_features = device_features;

Thanks

>
> >
> >  static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64
> > features)
> > @@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> >       struct pci_dev *pdev = mdev->pci_dev;
> >       struct device *dev = &pdev->dev;
> >       struct vp_vdpa *vp_vdpa = NULL;
> > +     u64 device_features;
> >       int ret, i;
> >
> >       vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > @@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> >       vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> >       vp_vdpa->mdev = mdev;
> >
> > +     device_features = vp_modern_get_features(mdev);
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (add_config->device_features & ~device_features)
> > +                     return -EINVAL;
> > +             device_features &= add_config->device_features;
> > +     }
> > +     vp_vdpa->device_features = device_features;
> > +
> >       ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors,
> > pdev);
> >       if (ret) {
> >               dev_err(&pdev->dev,
> > @@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const
> > struct pci_device_id *id)
> >       mgtdev->id_table = mdev_id;
> >       mgtdev->max_supported_vqs =
> > vp_modern_get_num_queues(mdev);
> >       mgtdev->supported_features = vp_modern_get_features(mdev);
> > +     mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
> >       pci_set_master(pdev);
> >       pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> >
> > --
> > 2.25.1
>

