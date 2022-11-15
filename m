Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3161628FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiKOCYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKOCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:24:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC15FB6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668478992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8X+hvUnHXS8YWKl8k6NvPdkhqFVz1x2osPmmn8HPX4=;
        b=JMoxbvRuhis/7Y5dnY9OqH2fBqAqdRqgugjaokK1VJpF+omemXuyEZkxW/wKxWda9VGaWY
        As6BX8A+Jaq+EwtGe2rXTOwhZE0vjFTbLAxaWVu4Ei3k/JmWelCfyxPZ9fd0L3u1eW8gE1
        +YzxAO0HX16uZ95k5Bhj2D7IN9vVbDY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-7HLVfEJANpubkCZgu0_5Ag-1; Mon, 14 Nov 2022 21:23:11 -0500
X-MC-Unique: 7HLVfEJANpubkCZgu0_5Ag-1
Received: by mail-oo1-f69.google.com with SMTP id e10-20020a4a91ca000000b0047f7bf95662so4585035ooh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8X+hvUnHXS8YWKl8k6NvPdkhqFVz1x2osPmmn8HPX4=;
        b=I2gSkQaiZ4Byzfit4hgf41Un9XrMQKsOhvxJd2CHEHT/58KEG7YSXGmQ5D0rVIkSym
         7D+DADqryGr9zxcvbzeuddMKc9p9K8J72G96MmVMRVsgR/FTOxox7eVUCMmg3NoHOgf5
         wHrm7E/vwKiV2kU2c6OgZMVOqLs3BITb+lArf3WH7Bm4e0aAtO8trGR5GM+7FWOlxo5Z
         jmJeUxKkr86lo3qzEF25NGltSyRImz2xV61bgIvHzjLqL3Tq5GYhQNfsA6E7k+FIYmt3
         fPsV88qNC2SK81qo2R8RjNZ1DRigH5sBqZ1OfL7Tbl3Lb2huoF62d2fqVUx2GomzLk23
         ZPNA==
X-Gm-Message-State: ANoB5pkCeHyKEFlEf9FIWT1wBEp50SQnmaFUf9FT75OalDjMIybx1MYT
        pQyi5xK25YrWNougtlwCmze2RrxXpjB6t92+DcZHYsah2R7DA8nTUEWNXLzq0AOwk85BV/LLzUl
        LXcoNzlqhjO5KIXK21+HLFEsBo6iuBIS00K/las7J
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id t11-20020a056870638b00b0013207b329acmr12251oap.35.1668478989675;
        Mon, 14 Nov 2022 18:23:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6xVaVuMN9y9IRwf6pS1lrJBEo8UmArhIuge19rMjFdYwuO70qiAQRZDIclVzAa54/59V8dUDR/uhLq4DvS3u4=
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id
 t11-20020a056870638b00b0013207b329acmr12223oap.35.1668478989317; Mon, 14 Nov
 2022 18:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20221111153555.1295-1-longpeng2@huawei.com> <CACGkMEuZp4GskMjAvGcNNRTmrmgzg1e4ufzJDekBBQ5BE9Nk=Q@mail.gmail.com>
 <babf64e9-0849-c8f9-7551-668b1b4e43eb@huawei.com>
In-Reply-To: <babf64e9-0849-c8f9-7551-668b1b4e43eb@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Nov 2022 10:22:58 +0800
Message-ID: <CACGkMEs57qKAoBzQeQyAJHyxvfY=4kqCTK-zgwSiWcOavhYt4w@mail.gmail.com>
Subject: Re: [RFC] vdpa: clear the device when opening/releasing it
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        linux-kernel@vger.kernel.org, xiehong@huawei.com, parav@nvidia.com,
        kvm@vger.kernel.org, lingshan.zhu@intel.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:58 PM Longpeng (Mike, Cloud Infrastructure
Service Product Dept.) <longpeng2@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/11/14 12:02, Jason Wang =E5=86=99=E9=81=93:
> > On Fri, Nov 11, 2022 at 11:36 PM Longpeng(Mike) <longpeng2@huawei.com> =
wrote:
> >>
> >> From: Longpeng <longpeng2@huawei.com>
> >>
> >> We should do some deeply cleanup when opening or releasing the device,
> >> e.g trigger FLR if it is PCIe device.
> >
> > Why is this needed? We're resetting at the virtio level instead of the
> > transport level.
> >
> Some existing virtio hardware needs to trigger FLR to clean some
> internal private states.

If those internal private states are virtio specific, it needs to be
cleaned upon virtio/vdpa reset instead of FLR. Otherwise it's a layer
violation.

> Otherwise, the internal logic would be confused
> when we reassign the function to another VM.
>
> The vendor driver can decide whether the device should do deep cleanup
> if we provide more information about the context. The driver can ignore
> the parameter if the device does not need to reset at the transport level=
.

Driver won't need to care about the transport specific stuff as it's
hidden below the vDPA bus.

Thanks

>
> > Thanks
> >
> >>
> >> Signed-off-by: Longpeng <longpeng2@huawei.com>
> >> ---
> >>   drivers/vdpa/alibaba/eni_vdpa.c    | 2 +-
> >>   drivers/vdpa/ifcvf/ifcvf_main.c    | 2 +-
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 2 +-
> >>   drivers/vdpa/vdpa_sim/vdpa_sim.c   | 2 +-
> >>   drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
> >>   drivers/vdpa/virtio_pci/vp_vdpa.c  | 2 +-
> >>   drivers/vhost/vdpa.c               | 4 ++--
> >>   drivers/virtio/virtio_vdpa.c       | 2 +-
> >>   include/linux/vdpa.h               | 7 ++++---
> >>   9 files changed, 13 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/en=
i_vdpa.c
> >> index 5a09a09cca70..07215b174dd6 100644
> >> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> >> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> >> @@ -226,7 +226,7 @@ static void eni_vdpa_set_status(struct vdpa_device=
 *vdpa, u8 status)
> >>                  eni_vdpa_free_irq(eni_vdpa);
> >>   }
> >>
> >> -static int eni_vdpa_reset(struct vdpa_device *vdpa)
> >> +static int eni_vdpa_reset(struct vdpa_device *vdpa, bool clear)
> >>   {
> >>          struct eni_vdpa *eni_vdpa =3D vdpa_to_eni(vdpa);
> >>          struct virtio_pci_legacy_device *ldev =3D &eni_vdpa->ldev;
> >> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcv=
f_main.c
> >> index f9c0044c6442..b9a6ac18f358 100644
> >> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> >> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> >> @@ -496,7 +496,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_devi=
ce *vdpa_dev, u8 status)
> >>          ifcvf_set_status(vf, status);
> >>   }
> >>
> >> -static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
> >> +static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev, bool clear)
> >>   {
> >>          struct ifcvf_adapter *adapter;
> >>          struct ifcvf_hw *vf;
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net=
/mlx5_vnet.c
> >> index 90913365def4..6f06f9c464a3 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -2560,7 +2560,7 @@ static void init_group_to_asid_map(struct mlx5_v=
dpa_dev *mvdev)
> >>                  mvdev->group2asid[i] =3D 0;
> >>   }
> >>
> >> -static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >> +static int mlx5_vdpa_reset(struct vdpa_device *vdev, bool clear)
> >>   {
> >>          struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> >>          struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim.c
> >> index b071f0d842fb..7438a89ce939 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> @@ -504,7 +504,7 @@ static void vdpasim_set_status(struct vdpa_device =
*vdpa, u8 status)
> >>          spin_unlock(&vdpasim->lock);
> >>   }
> >>
> >> -static int vdpasim_reset(struct vdpa_device *vdpa)
> >> +static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
> >>   {
> >>          struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_us=
er/vduse_dev.c
> >> index 35dceee3ed56..e5fee28233c0 100644
> >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >> @@ -691,7 +691,7 @@ static void vduse_vdpa_set_config(struct vdpa_devi=
ce *vdpa, unsigned int offset,
> >>          /* Now we only support read-only configuration space */
> >>   }
> >>
> >> -static int vduse_vdpa_reset(struct vdpa_device *vdpa)
> >> +static int vduse_vdpa_reset(struct vdpa_device *vdpa, bool clear)
> >>   {
> >>          struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >>          int ret =3D vduse_dev_set_status(dev, 0);
> >> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_p=
ci/vp_vdpa.c
> >> index d35fac5cde11..3db25b622a57 100644
> >> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> >> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> >> @@ -226,7 +226,7 @@ static void vp_vdpa_set_status(struct vdpa_device =
*vdpa, u8 status)
> >>          vp_modern_set_status(mdev, status);
> >>   }
> >>
> >> -static int vp_vdpa_reset(struct vdpa_device *vdpa)
> >> +static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
> >>   {
> >>          struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> >>          struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_=
vdpa);
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index 166044642fd5..fdda08cd7e7a 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -212,7 +212,7 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
> >>
> >>          v->in_batch =3D 0;
> >>
> >> -       return vdpa_reset(vdpa);
> >> +       return vdpa_reset(vdpa, true);
> >>   }
> >>
> >>   static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user=
 *argp)
> >> @@ -269,7 +269,7 @@ static long vhost_vdpa_set_status(struct vhost_vdp=
a *v, u8 __user *statusp)
> >>                          vhost_vdpa_unsetup_vq_irq(v, i);
> >>
> >>          if (status =3D=3D 0) {
> >> -               ret =3D vdpa_reset(vdpa);
> >> +               ret =3D vdpa_reset(vdpa, false);
> >>                  if (ret)
> >>                          return ret;
> >>          } else
> >> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa=
.c
> >> index 9670cc79371d..8f6ae689547e 100644
> >> --- a/drivers/virtio/virtio_vdpa.c
> >> +++ b/drivers/virtio/virtio_vdpa.c
> >> @@ -99,7 +99,7 @@ static void virtio_vdpa_reset(struct virtio_device *=
vdev)
> >>   {
> >>          struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> >>
> >> -       vdpa_reset(vdpa);
> >> +       vdpa_reset(vdpa, false);
> >>   }
> >>
> >>   static bool virtio_vdpa_notify(struct virtqueue *vq)
> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >> index 6d0f5e4e82c2..a0b917743b66 100644
> >> --- a/include/linux/vdpa.h
> >> +++ b/include/linux/vdpa.h
> >> @@ -218,6 +218,7 @@ struct vdpa_map_file {
> >>    *                             @status: virtio device status
> >>    * @reset:                     Reset device
> >>    *                             @vdev: vdpa device
> >> + *                             @clear: need device/function level cle=
ar or not, e.g pcie_flr.
> >>    *                             Returns integer: success (0) or error=
 (< 0)
> >>    * @suspend:                   Suspend or resume the device (optiona=
l)
> >>    *                             @vdev: vdpa device
> >> @@ -322,7 +323,7 @@ struct vdpa_config_ops {
> >>          u32 (*get_vendor_id)(struct vdpa_device *vdev);
> >>          u8 (*get_status)(struct vdpa_device *vdev);
> >>          void (*set_status)(struct vdpa_device *vdev, u8 status);
> >> -       int (*reset)(struct vdpa_device *vdev);
> >> +       int (*reset)(struct vdpa_device *vdev, bool clear);
> >>          int (*suspend)(struct vdpa_device *vdev);
> >>          size_t (*get_config_size)(struct vdpa_device *vdev);
> >>          void (*get_config)(struct vdpa_device *vdev, unsigned int off=
set,
> >> @@ -427,14 +428,14 @@ static inline struct device *vdpa_get_dma_dev(st=
ruct vdpa_device *vdev)
> >>          return vdev->dma_dev;
> >>   }
> >>
> >> -static inline int vdpa_reset(struct vdpa_device *vdev)
> >> +static inline int vdpa_reset(struct vdpa_device *vdev, bool clear)
> >>   {
> >>          const struct vdpa_config_ops *ops =3D vdev->config;
> >>          int ret;
> >>
> >>          down_write(&vdev->cf_lock);
> >>          vdev->features_valid =3D false;
> >> -       ret =3D ops->reset(vdev);
> >> +       ret =3D ops->reset(vdev, clear);
> >>          up_write(&vdev->cf_lock);
> >>          return ret;
> >>   }
> >> --
> >> 2.23.0
> >>
> >
> > .
>

