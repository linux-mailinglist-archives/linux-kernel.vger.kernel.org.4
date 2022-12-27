Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84EF65672A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 04:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiL0Dsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 22:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiL0Dsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:48:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F98C2702
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672112867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1hZLNXBMRorOqtx9oPycEFZQJRnhLcRbVQCtG3oSBs=;
        b=fu0glbpfN/6+Ocz6gmjQwwabNj4699dk3HZLSPNxfT85BAKAljecTSa819HdVqRoHtjZC6
        ir2HBLL9wy/Ft4+D3SX8OJdkDGgQsE15bFYSKTd7fKFBB27Sjv2Wh6x2lJLU6ucclQtA81
        PR1go2App7oJeU89xHn90xi+uOR5uH0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-j-rINIRtNbaAUDxp4ZpCHw-1; Mon, 26 Dec 2022 22:47:46 -0500
X-MC-Unique: j-rINIRtNbaAUDxp4ZpCHw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1437fb9949bso5770736fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1hZLNXBMRorOqtx9oPycEFZQJRnhLcRbVQCtG3oSBs=;
        b=q4/T9NMuwi357Qz4NYHIKaH0rZV3xy6bNZRUPjRQOn/218VcVeqcUnWVFZmbx0mRvc
         tYpPja7XQXeIW3cSrhMqchv6spDL6Hr30n7/nkY4vyRAo59U5UJJGJ8yBplUSAjfpRg+
         51kifDVzHewtUL+9m1w8MLeeS/IsQ3TAeMAJevfc9OkRy0M86Gi9ZLfbGgvVJnNj1Ahj
         g+s81oM00mm2V1QeLxpo9bh6p3xbl4/kTD+oZsLw65GDrgy97zQzxqyyDgb4YGBiZ54W
         sh6039K1wXUd+mcr3c4r8tu5TT/71hikkw+kb99iX3RlhuAFiuBhLSe7DOAuShhIrCLG
         mtRg==
X-Gm-Message-State: AFqh2kraIlkIILWkLXUHugtLZrDzJjh2aB2MKWxHF7qO+rKw2QsOIkjb
        Tr7SYuue2ZUCtlzMyPEbSr6nmtGQFD2aY+VvoNVFfVsNH4bM9JpjaLnvU8OEPDRzQqvP0dWFk+U
        BPocPunRls25NMGfMvLOeC5v/QS9J4V+jkjvxqgrC
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id lm23-20020a0568703d9700b00144b22a38d3mr1321677oab.280.1672112865596;
        Mon, 26 Dec 2022 19:47:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuBQ4cEkt4jn/adSCLJl1vc6Exv4RmhhMEQtw3ZaT4aCCWDhZtot/2yJeEX77WcRCiDwyeeL1Gf55fW+jYaRlA=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr1321670oab.280.1672112865324; Mon, 26
 Dec 2022 19:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com> <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221226183348-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Dec 2022 11:47:34 +0800
Message-ID: <CACGkMEsJYn=4mC-+QKnkHi+zjZsRL+m+mdyuLemPhsZDi_hcEw@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 7:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 26, 2022 at 03:49:07PM +0800, Jason Wang wrote:
> > This patch introduces a per virtqueue waitqueue to allow driver to
> > sleep and wait for more used. Two new helpers are introduced to allow
> > driver to sleep and wake up.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - check virtqueue_is_broken() as well
> > - use more_used() instead of virtqueue_get_buf() to allow caller to
> >   get buffers afterwards
> > ---
> >  drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  3 +++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 5cfb2fa8abee..9c83eb945493 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/kmsan.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/wait.h>
> >  #include <xen/xen.h>
> >
> >  #ifdef DEBUG
> > @@ -60,6 +61,7 @@
> >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> >               /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
> >               WRITE_ONCE((_vq)->broken, true);                       \
> > +             wake_up_interruptible(&(_vq)->wq);                     \
> >       } while (0)
> >  #define START_USE(vq)
> >  #define END_USE(vq)
> > @@ -203,6 +205,9 @@ struct vring_virtqueue {
> >       /* DMA, allocation, and size information */
> >       bool we_own_ring;
> >
> > +     /* Wait for buffer to be used */
> > +     wait_queue_head_t wq;
> > +
> >  #ifdef DEBUG
> >       /* They're supposed to lock for us. */
> >       unsigned int in_use;
> > @@ -2024,6 +2029,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers = false;
> >
> > +     init_waitqueue_head(&vq->wq);
> > +
> >       err = vring_alloc_state_extra_packed(&vring_packed);
> >       if (err)
> >               goto err_state_extra;
> > @@ -2517,6 +2524,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers = false;
> >
> > +     init_waitqueue_head(&vq->wq);
> > +
> >       err = vring_alloc_state_extra_split(vring_split);
> >       if (err) {
> >               kfree(vq);
> > @@ -2654,6 +2663,8 @@ static void vring_free(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > +     wake_up_interruptible(&vq->wq);
> > +
> >       if (vq->we_own_ring) {
> >               if (vq->packed_ring) {
> >                       vring_free_queue(vq->vq.vdev,
> > @@ -2863,4 +2874,22 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >
> > +int virtqueue_wait_for_used(struct virtqueue *_vq)
> > +{
> > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +     /* TODO: Tweak the timeout. */
> > +     return wait_event_interruptible_timeout(vq->wq,
> > +            virtqueue_is_broken(_vq) || more_used(vq), HZ);
>
> There's no good timeout. Let's not even go there, if device goes
> bad it should set the need reset bit.

The problem is that we can't depend on the device. If it takes too
long for the device to respond to cvq, there's a high possibility that
the device is buggy or even malicious. We can have a higher timeout
here and it should be still better than waiting forever (the cvq
commands need to be serialized so it needs to hold a lock anyway
(RTNL) ).

Thanks

>
>
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_wait_for_used);
> > +
> > +void virtqueue_wake_up(struct virtqueue *_vq)
> > +{
> > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +     wake_up_interruptible(&vq->wq);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_wake_up);
> > +
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index dcab9c7e8784..2eb62c774895 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -72,6 +72,9 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
> >  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> >                           void **ctx);
> >
> > +int virtqueue_wait_for_used(struct virtqueue *vq);
> > +void virtqueue_wake_up(struct virtqueue *vq);
> > +
> >  void virtqueue_disable_cb(struct virtqueue *vq);
> >
> >  bool virtqueue_enable_cb(struct virtqueue *vq);
> > --
> > 2.25.1
>

