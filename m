Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D46C358F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjCUPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCUPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:23:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0BB515F8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:22:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s20so8690451ljp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1679412162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4fhcs89c2i1SaCaKQE+ZquDyMtoplogwGVHOlrqnDo=;
        b=RvPcpPqJhBpBGEmvgCug6eQ1kMSP7zi/8kv9taohu4ygJN80LSTLTRpuIpdDY1TjAL
         igRcrXOOFhrW2LjO0cvpohQgVHphr99fU5pjvG7Oqur1maKTrIjpj9b7sAsu4Two6tqp
         XF28TSnJrLcp/bV/S/INuZ27Wx37xbfXvsQhdnaFS0EdETIKeXRsZe8h8LlTARTIG/Wv
         PipnAwUEPn8AI/UInlYhOD3/uO8Gf1uIN1kIfCPvvIFByv8hdmoYUzFR18ocZrigPuwB
         eEavjKq+yQj2NZDgnL6CQSuM7Zed1LNX5T/Bv8GsfJEotYtndf880UGzRZzxzye+m8rU
         dJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4fhcs89c2i1SaCaKQE+ZquDyMtoplogwGVHOlrqnDo=;
        b=sNLjY/HEh2gIvA/CXQ73gET3EjJdAFk9rXzg1roKjMPMREabZYK+40YT+YKUdbVh3m
         F6RrZxV93r54+HHGgUkmuJ1Vdhtv0wKEsMAquTZXFxOLjdBcPJNJD3+pfc9roCXlgDPo
         372LPlNy6FGp85zy/Nc1Yg7T1ofyZQ/3JdleKse5AdUx2r8UGnbYo7Mz+n8lNKieKVSV
         r2GUZPY64SwRtWhCfXBXr03GlaKrVgmm9XmokgkrbLVgXEBUo4qdVrcgN5UXw2ZcspXU
         kwAhzCWZv5zUUB/zrZqyYcCbzVl+3foLdE+enDtsN4JHdJ3rLiyF7gJ4/Z3ZymOSpyw3
         +kyg==
X-Gm-Message-State: AO0yUKWmsUUpA/oweG6983wWeKRS8K0xOsNPvt6avuCQyYLYp9VOiAQw
        pVDUmJARD+G6Hsjl5E/detJy+ReqSl/arR5YC+qPpA==
X-Google-Smtp-Source: AK7set/pB3EswDTWrcfNX8zIafnSwam2eDPPjtzIwc33i0qCcLfPhDJhKEUQBtsB8Av+cLTDT9UQoeDdLo2eHTx3Res=
X-Received: by 2002:a2e:8482:0:b0:298:7c9e:505 with SMTP id
 b2-20020a2e8482000000b002987c9e0505mr977894ljh.8.1679412161781; Tue, 21 Mar
 2023 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230321134410.2097163-1-viktor@daynix.com> <87h6uem9qc.fsf@redhat.com>
In-Reply-To: <87h6uem9qc.fsf@redhat.com>
From:   Viktor Prutyanov <viktor@daynix.com>
Date:   Tue, 21 Mar 2023 18:22:31 +0300
Message-ID: <CAPv0NP6Ep4-B7cMc285E3d3vYjgwO7O1pq5sG3OYYAoZd3EAYQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 5:59=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
> On Tue, Mar 21 2023, Viktor Prutyanov <viktor@daynix.com> wrote:
>
> > According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> > indicates that the driver passes extra data along with the queue
> > notifications.
> >
> > In a split queue case, the extra data is 16-bit available index. In a
> > packed queue case, the extra data is 1-bit wrap counter and 15-bit
> > available index.
> >
> > Add support for this feature for MMIO, PCI and channel I/O transports.
> >
> > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > ---
> >  v3: support feature in virtio_ccw, remove VM_NOTIFY, use avail_idx_sha=
dow,
> >     remove byte swap, rename to vring_notification_data
> >  v2: reject the feature in virtio_ccw, replace __le32 with u32
> >
> >  drivers/s390/virtio/virtio_ccw.c   |  4 +++-
> >  drivers/virtio/virtio_mmio.c       | 14 +++++++++++++-
> >  drivers/virtio/virtio_pci_common.c | 10 ++++++++++
> >  drivers/virtio/virtio_pci_common.h |  4 ++++
> >  drivers/virtio/virtio_pci_legacy.c |  2 +-
> >  drivers/virtio/virtio_pci_modern.c |  2 +-
> >  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
> >  include/linux/virtio_ring.h        |  2 ++
> >  include/uapi/linux/virtio_config.h |  6 ++++++
> >  9 files changed, 57 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/vir=
tio_ccw.c
> > index 954fc31b4bc7..c33172c5b8d5 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -396,13 +396,15 @@ static bool virtio_ccw_kvm_notify(struct virtqueu=
e *vq)
> >       struct virtio_ccw_vq_info *info =3D vq->priv;
> >       struct virtio_ccw_device *vcdev;
> >       struct subchannel_id schid;
> > +     u32 data =3D __virtio_test_bit(vq->vdev, VIRTIO_F_NOTIFICATION_DA=
TA) ?
> > +                     vring_notification_data(vq) : vq->index;
> >
> >       vcdev =3D to_vc_device(info->vq->vdev);
> >       ccw_device_get_schid(vcdev->cdev, &schid);
> >       BUILD_BUG_ON(sizeof(struct subchannel_id) !=3D sizeof(unsigned in=
t));
> >       info->cookie =3D kvm_hypercall3(KVM_S390_VIRTIO_CCW_NOTIFY,
> >                                     *((unsigned int *)&schid),
> > -                                   vq->index, info->cookie);
> > +                                   data, info->cookie);
> >       if (info->cookie < 0)
> >               return false;
> >       return true;
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> > index 3ff746e3f24a..7c16e622c33d 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -285,6 +285,16 @@ static bool vm_notify(struct virtqueue *vq)
> >       return true;
> >  }
> >
> > +static bool vm_notify_with_data(struct virtqueue *vq)
> > +{
> > +     struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->v=
dev);
> > +     u32 data =3D vring_notification_data(vq);
> > +
> > +     writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
>
> Can't you simply use the same method as for ccw, i.e. use one callback
> function that simply writes one value or the other?

The idea is to eliminate the conditional branch induced by feature bit
testing from the notification function. Probably, this can be done in
the same way in ccw.

>
> > +
> > +     return true;
> > +}
> > +
> >  /* Notify all virtqueues on an interrupt. */
> >  static irqreturn_t vm_interrupt(int irq, void *opaque)
> >  {
> > @@ -368,6 +378,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_=
device *vdev, unsigned int in
> >       unsigned long flags;
> >       unsigned int num;
> >       int err;
> > +     bool (*notify)(struct virtqueue *vq) =3D __virtio_test_bit(vdev,
> > +             VIRTIO_F_NOTIFICATION_DATA) ? vm_notify_with_data : vm_no=
tify;
> >
> >       if (!name)
> >               return NULL;
> > @@ -397,7 +409,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_=
device *vdev, unsigned int in
> >
> >       /* Create the vring */
> >       vq =3D vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN=
, vdev,
> > -                              true, true, ctx, vm_notify, callback, na=
me);
> > +                              true, true, ctx, notify, callback, name)=
;
> >       if (!vq) {
> >               err =3D -ENOMEM;
> >               goto error_new_virtqueue;
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index a6c86f916dbd..e915c22f2384 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -43,6 +43,16 @@ bool vp_notify(struct virtqueue *vq)
> >       /* we write the queue's selector into the notification register t=
o
> >        * signal the other end */
> >       iowrite16(vq->index, (void __iomem *)vq->priv);
> > +
> > +     return true;
> > +}
> > +
> > +bool vp_notify_with_data(struct virtqueue *vq)
> > +{
> > +     u32 data =3D vring_notification_data(vq);
> > +
> > +     iowrite32(data, (void __iomem *)vq->priv);
>
> Same for pci.
>
> > +
> >       return true;
> >  }
> >
>
