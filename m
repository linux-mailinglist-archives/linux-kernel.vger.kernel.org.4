Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154B46C6114
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCWHrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCWHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:47:05 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4A2A9BE;
        Thu, 23 Mar 2023 00:46:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VeTgHVB_1679557611;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VeTgHVB_1679557611)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 15:46:52 +0800
Message-ID: <1679557537.9112334-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Date:   Thu, 23 Mar 2023 15:45:37 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com, jasowang@redhat.com,
        Viktor Prutyanov <viktor@daynix.com>
References: <20230322141031.2211141-1-viktor@daynix.com>
 <1679534465.5760474-1-xuanzhuo@linux.alibaba.com>
 <CAPv0NP5gusfkyvX4qhMMiXsTZpckammmc5R7M=e9USi3C=1QAQ@mail.gmail.com>
 <20230323032320-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230323032320-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 03:25:25 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Thu, Mar 23, 2023 at 10:18:56AM +0300, Viktor Prutyanov wrote:
> > On Thu, Mar 23, 2023 at 4:22=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 22 Mar 2023 17:10:31 +0300, Viktor Prutyanov <viktor@daynix.c=
om> wrote:
> > > > According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> > > > indicates that the driver passes extra data along with the queue
> > > > notifications.
> > > >
> > > > In a split queue case, the extra data is 16-bit available index. In=
 a
> > > > packed queue case, the extra data is 1-bit wrap counter and 15-bit
> > > > available index.
> > > >
> > > > Add support for this feature for MMIO, channel I/O and modern PCI
> > > > transports.
> > > >
> > > > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > > > ---
> > > >  v4: remove VP_NOTIFY macro and legacy PCI support, add
> > > >     virtio_ccw_kvm_notify_with_data to virtio_ccw
> > > >  v3: support feature in virtio_ccw, remove VM_NOTIFY, use avail_idx=
_shadow,
> > > >     remove byte swap, rename to vring_notification_data
> > > >  v2: reject the feature in virtio_ccw, replace __le32 with u32
> > > >
> > > >  Tested with disabled VIRTIO_F_NOTIFICATION_DATA on qemu-system-s39=
0x
> > > >  (virtio-blk-ccw), qemu-system-riscv64 (virtio-blk-device,
> > > >  virtio-rng-device), qemu-system-x86_64 (virtio-blk-pci, virtio-net=
-pci)
> > > >  to make sure nothing is broken.
> > > >  Tested with enabled VIRTIO_F_NOTIFICATION_DATA on 64-bit RISC-V Li=
nux
> > > >  and my hardware implementation of virtio-rng.
> > > >
> > > >  drivers/s390/virtio/virtio_ccw.c   | 19 ++++++++++++++++---
> > > >  drivers/virtio/virtio_mmio.c       | 14 +++++++++++++-
> > > >  drivers/virtio/virtio_pci_modern.c | 13 ++++++++++++-
> > > >  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
> > > >  include/linux/virtio_ring.h        |  2 ++
> > > >  include/uapi/linux/virtio_config.h |  6 ++++++
> > > >  6 files changed, 66 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio=
/virtio_ccw.c
> > > > index 954fc31b4bc7..3619676effb8 100644
> > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > @@ -391,7 +391,7 @@ static void virtio_ccw_drop_indicator(struct vi=
rtio_ccw_device *vcdev,
> > > >       ccw_device_dma_free(vcdev->cdev, thinint_area, sizeof(*thinin=
t_area));
> > > >  }
> > > >
> > > > -static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> > > > +static inline bool virtio_ccw_do_kvm_notify(struct virtqueue *vq, =
u32 data)
> > > >  {
> > > >       struct virtio_ccw_vq_info *info =3D vq->priv;
> > > >       struct virtio_ccw_device *vcdev;
> > > > @@ -402,12 +402,22 @@ static bool virtio_ccw_kvm_notify(struct virt=
queue *vq)
> > > >       BUILD_BUG_ON(sizeof(struct subchannel_id) !=3D sizeof(unsigne=
d int));
> > > >       info->cookie =3D kvm_hypercall3(KVM_S390_VIRTIO_CCW_NOTIFY,
> > > >                                     *((unsigned int *)&schid),
> > > > -                                   vq->index, info->cookie);
> > > > +                                   data, info->cookie);
> > > >       if (info->cookie < 0)
> > > >               return false;
> > > >       return true;
> > > >  }
> > > >
> > > > +static bool virtio_ccw_kvm_notify(struct virtqueue *vq)
> > > > +{
> > > > +     return virtio_ccw_do_kvm_notify(vq, vq->index);
> > > > +}
> > > > +
> > > > +static bool virtio_ccw_kvm_notify_with_data(struct virtqueue *vq)
> > > > +{
> > > > +     return virtio_ccw_do_kvm_notify(vq, vring_notification_data(v=
q));
> > > > +}
> > > > +
> > > >  static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
> > > >                                  struct ccw1 *ccw, int index)
> > > >  {
> > > > @@ -501,6 +511,9 @@ static struct virtqueue *virtio_ccw_setup_vq(st=
ruct virtio_device *vdev,
> > > >       u64 queue;
> > > >       unsigned long flags;
> > > >       bool may_reduce;
> > > > +     bool (*notify)(struct virtqueue *vq) =3D __virtio_test_bit(vd=
ev,
> > > > +             VIRTIO_F_NOTIFICATION_DATA) ?
> > > > +             virtio_ccw_kvm_notify_with_data : virtio_ccw_kvm_noti=
fy;
> > > >
> > > >       /* Allocate queue. */
> > > >       info =3D kzalloc(sizeof(struct virtio_ccw_vq_info), GFP_KERNE=
L);
> > > > @@ -524,7 +537,7 @@ static struct virtqueue *virtio_ccw_setup_vq(st=
ruct virtio_device *vdev,
> > > >       may_reduce =3D vcdev->revision > 0;
> > > >       vq =3D vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RI=
NG_ALIGN,
> > > >                                   vdev, true, may_reduce, ctx,
> > > > -                                 virtio_ccw_kvm_notify, callback, =
name);
> > > > +                                 notify, callback, name);
> > > >
> > > >       if (!vq) {
> > > >               /* For now, we fail if we can't get the requested siz=
e. */
> > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_m=
mio.c
> > > > index 3ff746e3f24a..7c16e622c33d 100644
> > > > --- a/drivers/virtio/virtio_mmio.c
> > > > +++ b/drivers/virtio/virtio_mmio.cv
> > > > @@ -285,6 +285,16 @@ static bool vm_notify(struct virtqueue *vq)
> > > >       return true;
> > > >  }
> > > >
> > > > +static bool vm_notify_with_data(struct virtqueue *vq)
> > > > +{
> > > > +     struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(v=
q->vdev);
> > > > +     u32 data =3D vring_notification_data(vq);
> > > > +
> > > > +     writel(data, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > >  /* Notify all virtqueues on an interrupt. */
> > > >  static irqreturn_t vm_interrupt(int irq, void *opaque)
> > > >  {
> > > > @@ -368,6 +378,8 @@ static struct virtqueue *vm_setup_vq(struct vir=
tio_device *vdev, unsigned int in
> > > >       unsigned long flags;
> > > >       unsigned int num;
> > > >       int err;
> > > > +     bool (*notify)(struct virtqueue *vq) =3D __virtio_test_bit(vd=
ev,
> > > > +             VIRTIO_F_NOTIFICATION_DATA) ? vm_notify_with_data : v=
m_notify;
> > >
> > >
> > > Can we optimize this line?
> >
> > What kind of optimization do you mean?
>
> In fact speed does not matter here but it is not very readable.
> Use of "?" was justified if you put this inside the call to vring_create_=
virtqueue
> (which I still feel would be best).
> But if you use a variable, just use plain if:
>
> 	bool (*notify)(struct virtqueue *vq);
>
> 	if (__virtio_test_bit(vdev,VIRTIO_F_NOTIFICATION_DATA))
> 			vq =3D vm_notify_with_data;
> 	else
> 			vq =3D vm_notify;


Yes, I mean this, I don't mean performance. It refers to the form of code. =
It
should be that my expression is inaccurate.


Thanks.

>
>
> > >
> > > Thanks.
> > >
> > > >
> > > >       if (!name)
> > > >               return NULL;
> > > > @@ -397,7 +409,7 @@ static struct virtqueue *vm_setup_vq(struct vir=
tio_device *vdev, unsigned int in
> > > >
> > > >       /* Create the vring */
> > > >       vq =3D vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_A=
LIGN, vdev,
> > > > -                              true, true, ctx, vm_notify, callback=
, name);
> > > > +                              true, true, ctx, notify, callback, n=
ame);
> > > >       if (!vq) {
> > > >               err =3D -ENOMEM;
> > > >               goto error_new_virtqueue;
> > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/vi=
rtio_pci_modern.c
> > > > index 9e496e288cfa..9cc56f463dba 100644
> > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > @@ -288,6 +288,15 @@ static u16 vp_config_vector(struct virtio_pci_=
device *vp_dev, u16 vector)
> > > >       return vp_modern_config_vector(&vp_dev->mdev, vector);
> > > >  }
> > > >
> > > > +static bool vp_notify_with_data(struct virtqueue *vq)
> > > > +{
> > > > +     u32 data =3D vring_notification_data(vq);
> > > > +
> > > > +     iowrite32(data, (void __iomem *)vq->priv);
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > >  static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> > > >                                 struct virtio_pci_vq_info *info,
> > > >                                 unsigned int index,
> > > > @@ -301,6 +310,8 @@ static struct virtqueue *setup_vq(struct virtio=
_pci_device *vp_dev,
> > > >       struct virtqueue *vq;
> > > >       u16 num;
> > > >       int err;
> > > > +     bool (*notify)(struct virtqueue *vq) =3D __virtio_test_bit(&v=
p_dev->vdev,
> > > > +             VIRTIO_F_NOTIFICATION_DATA) ? vp_notify_with_data : v=
p_notify;
> > > >
> > > >       if (index >=3D vp_modern_get_num_queues(mdev))
> > > >               return ERR_PTR(-EINVAL);
> > > > @@ -321,7 +332,7 @@ static struct virtqueue *setup_vq(struct virtio=
_pci_device *vp_dev,
> > > >       vq =3D vring_create_virtqueue(index, num,
> > > >                                   SMP_CACHE_BYTES, &vp_dev->vdev,
> > > >                                   true, true, ctx,
> > > > -                                 vp_notify, callback, name);
> > > > +                                 notify, callback, name);
> > > >       if (!vq)
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 4c3bb0ddeb9b..837875cc3190 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -2752,6 +2752,21 @@ void vring_del_virtqueue(struct virtqueue *_=
vq)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
> > > >
> > > > +u32 vring_notification_data(struct virtqueue *_vq)
> > > > +{
> > > > +     struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > +     u16 next;
> > > > +
> > > > +     if (vq->packed_ring)
> > > > +             next =3D (vq->packed.next_avail_idx & ~(1 << 15)) |
> > > > +                     vq->packed.avail_wrap_counter << 15;
> > > > +     else
> > > > +             next =3D vq->split.avail_idx_shadow;
> > > > +
> > > > +     return next << 16 | _vq->index;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(vring_notification_data);
> > > > +
> > > >  /* Manipulates transport-specific feature bits. */
> > > >  void vring_transport_features(struct virtio_device *vdev)
> > > >  {
> > > > @@ -2771,6 +2786,8 @@ void vring_transport_features(struct virtio_d=
evice *vdev)
> > > >                       break;
> > > >               case VIRTIO_F_ORDER_PLATFORM:
> > > >                       break;
> > > > +             case VIRTIO_F_NOTIFICATION_DATA:
> > > > +                     break;
> > > >               default:
> > > >                       /* We don't understand this bit. */
> > > >                       __virtio_clear_bit(vdev, i);
> > > > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_rin=
g.h
> > > > index 8b95b69ef694..2550c9170f4f 100644
> > > > --- a/include/linux/virtio_ring.h
> > > > +++ b/include/linux/virtio_ring.h
> > > > @@ -117,4 +117,6 @@ void vring_del_virtqueue(struct virtqueue *vq);
> > > >  void vring_transport_features(struct virtio_device *vdev);
> > > >
> > > >  irqreturn_t vring_interrupt(int irq, void *_vq);
> > > > +
> > > > +u32 vring_notification_data(struct virtqueue *_vq);
> > > >  #endif /* _LINUX_VIRTIO_RING_H */
> > > > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linu=
x/virtio_config.h
> > > > index 3c05162bc988..2c712c654165 100644
> > > > --- a/include/uapi/linux/virtio_config.h
> > > > +++ b/include/uapi/linux/virtio_config.h
> > > > @@ -99,6 +99,12 @@
> > > >   */
> > > >  #define VIRTIO_F_SR_IOV                      37
> > > >
> > > > +/*
> > > > + * This feature indicates that the driver passes extra data (besid=
es
> > > > + * identifying the virtqueue) in its device notifications.
> > > > + */
> > > > +#define VIRTIO_F_NOTIFICATION_DATA   38
> > > > +
> > > >  /*
> > > >   * This feature indicates that the driver can reset a queue indivi=
dually.
> > > >   */
> > > > --
> > > > 2.35.1
> > > >
>
