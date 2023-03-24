Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED16C7762
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCXFcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCXFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220199
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679635878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2a1xvUOUTDa8qNXVZtHHs2/wy9h/5BrtN8IXVy3fEQ=;
        b=Khec35JNVB66AkW4liSV3eU8cK1K/3AgeSUmZ874Qt6pjbStXQIyzUh9WSJpj507wnLuP0
        mftPRBmZBXhJ5YHW1/laWnpgWQF2Rxs52kKMs+QRDVs2X5jATdfkigTrbcJDykBNlziJHi
        BtwtKwBblf+O4EnFV/ZeKGB46610J1Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-GA3osftmOI-ZawtPsMlxQQ-1; Fri, 24 Mar 2023 01:31:17 -0400
X-MC-Unique: GA3osftmOI-ZawtPsMlxQQ-1
Received: by mail-wm1-f71.google.com with SMTP id o37-20020a05600c512500b003edd119ec9eso500683wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679635876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2a1xvUOUTDa8qNXVZtHHs2/wy9h/5BrtN8IXVy3fEQ=;
        b=RyDAP9t3d5Gn57STYqctO15Af/ulOpZQgvMKGcv0hZ61TJVE8D2mhigW6DCDs++Iuz
         3OD+Xa9QgW5d0MynWM33dFXD2OZ15zepvOBCPU45n8e3SijFCvcE4sv3h+73E9c/mXl0
         m6U9+0PwjWgG+dICE/Iy39eL4xp1kg6WjqcmBG/oiVAS1ii016+EnAt4OQ32uOucgUxw
         3v5B9LvfTFMpoTDwBwxXd2DpLwMu5i1+GD4MgNWuKbvaBtc/d4I9HUR5JdK0NhWQWDyX
         JNUP17HoZqaGvj/SDNZGyjNd9urI3B18GjGbxZJWT5Yz3wi/0PtzyLfdj5OQAsvrvEB7
         J3Pw==
X-Gm-Message-State: AAQBX9dmhFVOw17ACJ5YcwF6T5IKYxA9uy1ivboYbfWT3CfMPtpP9AF1
        vbrHwsDh/tbGFvPTuAqObLswGtgX69CnW1JcYY5kpWDTIo8AZh3Sps4PQYgjYFT/PHwHVzdkkn7
        m0ozLZpUftGbUf4lXOJsLIfM1ES9BE6U9
X-Received: by 2002:a5d:6b8b:0:b0:2ce:ad08:ca4 with SMTP id n11-20020a5d6b8b000000b002cead080ca4mr989243wrx.35.1679635875954;
        Thu, 23 Mar 2023 22:31:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350b3Mx7v295xk69JlKaVftSlan8v8qU7rb+a8DZjWnx7PlsPog3Ko+6oMYE2zmGyg7YJu5D+BQ==
X-Received: by 2002:a5d:6b8b:0:b0:2ce:ad08:ca4 with SMTP id n11-20020a5d6b8b000000b002cead080ca4mr989228wrx.35.1679635875586;
        Thu, 23 Mar 2023 22:31:15 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm17502567wri.98.2023.03.23.22.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:31:14 -0700 (PDT)
Date:   Fri, 24 Mar 2023 01:31:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Viktor Prutyanov <viktor@daynix.com>, cohuck@redhat.com,
        pasic@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH v5] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230324011454-mutt-send-email-mst@kernel.org>
References: <20230323085551.2346411-1-viktor@daynix.com>
 <CACGkMEsTpdES6Gzsx7eobJsac8a1V0dqfRm3vExrd1e+TJ_bVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsTpdES6Gzsx7eobJsac8a1V0dqfRm3vExrd1e+TJ_bVg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:09:19AM +0800, Jason Wang wrote:
> On Thu, Mar 23, 2023 at 4:56 PM Viktor Prutyanov <viktor@daynix.com> wrote:
> >
> > According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> > indicates that the driver passes extra data along with the queue
> > notifications.
> >
> > In a split queue case, the extra data is 16-bit available index. In a
> > packed queue case, the extra data is 1-bit wrap counter and 15-bit
> > available index.
> >
> > Add support for this feature for MMIO, channel I/O and modern PCI
> > transports.
> >
> > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > ---
> >  v5: replace ternary operator with if-else
> >  v4: remove VP_NOTIFY macro and legacy PCI support, add
> >     virtio_ccw_kvm_notify_with_data to virtio_ccw
> >  v3: support feature in virtio_ccw, remove VM_NOTIFY, use avail_idx_shadow,
> >     remove byte swap, rename to vring_notification_data
> >  v2: reject the feature in virtio_ccw, replace __le32 with u32
> >
> >  Tested with disabled VIRTIO_F_NOTIFICATION_DATA on qemu-system-s390x
> >  (virtio-blk-ccw), qemu-system-riscv64 (virtio-blk-device,
> >  virtio-rng-device), qemu-system-x86_64 (virtio-blk-pci, virtio-net-pci)
> >  to make sure nothing is broken.
> >  Tested with enabled VIRTIO_F_NOTIFICATION_DATA on 64-bit RISC-V Linux
> >  and my hardware implementation of virtio-rng with MMIO.
> >
> >  drivers/s390/virtio/virtio_ccw.c   | 22 +++++++++++++++++++---
> >  drivers/virtio/virtio_mmio.c       | 18 +++++++++++++++++-
> >  drivers/virtio/virtio_pci_modern.c | 17 ++++++++++++++++-
> >  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
> >  include/linux/virtio_ring.h        |  2 ++
> >  include/uapi/linux/virtio_config.h |  6 ++++++
> >  6 files changed, 77 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 954fc31b4bc7..9a9c5d34454c 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -391,7 +391,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
> >         ccw_device_dma_free(vcdev->cdev, thinint_area, sizeof(*thinint_area));
> >  }
> >
> > -static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> > +static inline bool virtio_ccw_do_kvm_notify(struct virtqueue *vq, u32 data)
> >  {
> >         struct virtio_ccw_vq_info *info = vq->priv;
> >         struct virtio_ccw_device *vcdev;
> > @@ -402,12 +402,22 @@ static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> >         BUILD_BUG_ON(sizeof(struct subchannel_id) != sizeof(unsigned int));
> >         info->cookie = kvm_hypercall3(KVM_S390_VIRTIO_CCW_NOTIFY,
> >                                       *((unsigned int *)&schid),
> > -                                     vq->index, info->cookie);
> > +                                     data, info->cookie);
> >         if (info->cookie < 0)
> >                 return false;
> >         return true;
> >  }
> >
> > +static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> > +{
> > +       return virtio_ccw_do_kvm_notify(vq, vq->index);
> > +}
> > +
> > +static bool virtio_ccw_kvm_notify_with_data(struct virtqueue *vq)
> > +{
> > +       return virtio_ccw_do_kvm_notify(vq, vring_notification_data(vq));
> > +}
> > +
> >  static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
> >                                    struct ccw1 *ccw, int index)
> >  {
> > @@ -501,6 +511,12 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
> >         u64 queue;
> >         unsigned long flags;
> >         bool may_reduce;
> > +       bool (*notify)(struct virtqueue *vq);
> > +
> > +       if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA))
> > +               notify = virtio_ccw_kvm_notify_with_data;
> > +       else
> > +               notify = virtio_ccw_kvm_notify;
> >
> >         /* Allocate queue. */
> >         info = kzalloc(sizeof(struct virtio_ccw_vq_info), GFP_KERNEL);
> > @@ -524,7 +540,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
> >         may_reduce = vcdev->revision > 0;
> >         vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
> >                                     vdev, true, may_reduce, ctx,
> > -                                   virtio_ccw_kvm_notify, callback, name);
> > +                                   notify, callback, name);
> >
> >         if (!vq) {
> >                 /* For now, we fail if we can't get the requested size. */
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 3ff746e3f24a..7e87f745f68d 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -285,6 +285,16 @@ static bool vm_notify(struct virtqueue *vq)
> >         return true;
> >  }
> >
> > +static bool vm_notify_with_data(struct virtqueue *vq)
> > +{
> > +       struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> > +       u32 data = vring_notification_data(vq);
> > +
> > +       writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> > +
> > +       return true;
> > +}
> > +
> >  /* Notify all virtqueues on an interrupt. */
> >  static irqreturn_t vm_interrupt(int irq, void *opaque)
> >  {
> > @@ -368,6 +378,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
> >         unsigned long flags;
> >         unsigned int num;
> >         int err;
> > +       bool (*notify)(struct virtqueue *vq);
> > +
> > +       if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA))
> > +               notify = vm_notify_with_data;
> > +       else
> > +               notify = vm_notify;
> >
> >         if (!name)
> >                 return NULL;
> > @@ -397,7 +413,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
> >
> >         /* Create the vring */
> >         vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
> > -                                true, true, ctx, vm_notify, callback, name);
> > +                                true, true, ctx, notify, callback, name);
> >         if (!vq) {
> >                 err = -ENOMEM;
> >                 goto error_new_virtqueue;
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 9e496e288cfa..3bfc368b279e 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -288,6 +288,15 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> >         return vp_modern_config_vector(&vp_dev->mdev, vector);
> >  }
> >
> > +static bool vp_notify_with_data(struct virtqueue *vq)
> > +{
> > +       u32 data = vring_notification_data(vq);
> > +
> > +       iowrite32(data, (void __iomem *)vq->priv);
> > +
> > +       return true;
> > +}
> > +
> >  static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >                                   struct virtio_pci_vq_info *info,
> >                                   unsigned int index,
> > @@ -301,6 +310,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >         struct virtqueue *vq;
> >         u16 num;
> >         int err;
> > +       bool (*notify)(struct virtqueue *vq);
> > +
> > +       if (__virtio_test_bit(&vp_dev->vdev, VIRTIO_F_NOTIFICATION_DATA))
> > +               notify = vp_notify_with_data;
> > +       else
> > +               notify = vp_notify;
> >
> >         if (index >= vp_modern_get_num_queues(mdev))
> >                 return ERR_PTR(-EINVAL);
> > @@ -321,7 +336,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >         vq = vring_create_virtqueue(index, num,
> >                                     SMP_CACHE_BYTES, &vp_dev->vdev,
> >                                     true, true, ctx,
> > -                                   vp_notify, callback, name);
> > +                                   notify, callback, name);
> >         if (!vq)
> >                 return ERR_PTR(-ENOMEM);
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 4c3bb0ddeb9b..837875cc3190 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2752,6 +2752,21 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
> >
> > +u32 vring_notification_data(struct virtqueue *_vq)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +       u16 next;
> > +
> > +       if (vq->packed_ring)
> > +               next = (vq->packed.next_avail_idx & ~(1 << 15)) |
> > +                       vq->packed.avail_wrap_counter << 15;
> 
> Nit: We have VRING_PACKED_EVENT_F_WRAP_CTR which could be used for
> replacing 15 here.
> 
> And we have many places for packing them into u16, it might be better
> to introduce a helper.

Not sure about a helper, I'd leave that for a future cleanup.

However I would use

& (-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))

that's more robust - works for any value of VRING_PACKED_EVENT_F_WRAP_CTR
giving low bits 0 to VRING_PACKED_EVENT_F_WRAP_CTR,
and will keep working if someone copypasted it and changed
counter to a value different from 15.


> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thanks
> 
> > +       else
> > +               next = vq->split.avail_idx_shadow;
> > +
> > +       return next << 16 | _vq->index;
> > +}
> > +EXPORT_SYMBOL_GPL(vring_notification_data);
> > +
> >  /* Manipulates transport-specific feature bits. */
> >  void vring_transport_features(struct virtio_device *vdev)
> >  {
> > @@ -2771,6 +2786,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >                         break;
> >                 case VIRTIO_F_ORDER_PLATFORM:
> >                         break;
> > +               case VIRTIO_F_NOTIFICATION_DATA:
> > +                       break;
> >                 default:
> >                         /* We don't understand this bit. */
> >                         __virtio_clear_bit(vdev, i);
> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index 8b95b69ef694..2550c9170f4f 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -117,4 +117,6 @@ void vring_del_virtqueue(struct virtqueue *vq);
> >  void vring_transport_features(struct virtio_device *vdev);
> >
> >  irqreturn_t vring_interrupt(int irq, void *_vq);
> > +
> > +u32 vring_notification_data(struct virtqueue *_vq);
> >  #endif /* _LINUX_VIRTIO_RING_H */
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 3c05162bc988..2c712c654165 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -99,6 +99,12 @@
> >   */
> >  #define VIRTIO_F_SR_IOV                        37
> >
> > +/*
> > + * This feature indicates that the driver passes extra data (besides
> > + * identifying the virtqueue) in its device notifications.
> > + */
> > +#define VIRTIO_F_NOTIFICATION_DATA     38
> > +
> >  /*
> >   * This feature indicates that the driver can reset a queue individually.
> >   */
> > --
> > 2.35.1
> >

