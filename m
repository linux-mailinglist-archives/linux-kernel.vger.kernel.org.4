Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0FC6C7652
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCXDm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCXDmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0928E58
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679629286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swlWlggXJj2hbT0VucgzYRhl+ET3HPvPizdMvN3gXts=;
        b=aZQ4w2QY4rGYrlyInUZlWtlzwuroe3NZ4c8PNfJMDwmCG8qFMPipHdX/3ilmrOhdepqsdJ
        96Am1lzktdkPYme4U2fBXb+FjYTQy3JiDeJDM1ham45/si1iTb3+w2T/9ue7P7kYmAPYKv
        u44cuT89WjoGqsxLeR0uENXhxhHWU00=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-5vtCYY6UNg6ombMT1ePLqQ-1; Thu, 23 Mar 2023 23:41:24 -0400
X-MC-Unique: 5vtCYY6UNg6ombMT1ePLqQ-1
Received: by mail-oo1-f72.google.com with SMTP id z30-20020a4a9861000000b0053714e6f1b7so299167ooi.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679629284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swlWlggXJj2hbT0VucgzYRhl+ET3HPvPizdMvN3gXts=;
        b=neLxTAWrv/r6fkXgZh0DADs5YxTkcbUeSIXaI3rsRf8FknbSjME4WVufGt/qOgOUt1
         5inOzsxwZKKeabGu39BU3ysCKEt41PQwRaavmnMKZRMmSojAoRUDEpMqH2Lq/B72Mz57
         z+Gem81zQ4+8qAo4FBf5wzG6uK5juZdpW+9cF/UnPcab+iyBNI8g4xEBqaP8hPKf92K3
         jLYORA+lDeFHrg0AUU+HKu88iLfjAtalhEpv1hshmvoNIZ2eCZpaJBBRN8AivJ8O/V3p
         wQjs9uDT16lFlUwLpIIaZQ0sgTqEy/xOXnz+RSZc09diy5rMTcUIQEnlyyYK0HeW3KxT
         Vnug==
X-Gm-Message-State: AAQBX9e3u/f7z+wZXO5DVsQyPsId2xMbGcGylvKxHF/BD+kzZAFAummt
        pFHsfG5IuX/B4KMt917NTmMOHak1ZfdED8zSItfkGOBxgv58opU6IKeVg1L0JdtxGbkLPpdVyLy
        BzLL5XUPpqwqNNbpfZuqdfe3B1XL/DOWbOOOVBZ2QgsMC9TjeddBhsXNj
X-Received: by 2002:a05:6870:10d4:b0:17e:255e:b1 with SMTP id 20-20020a05687010d400b0017e255e00b1mr521140oar.9.1679629283843;
        Thu, 23 Mar 2023 20:41:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set/QtGSvTUkrhlTrdohi2qzwnqwBehxRYbFDLU7APMXwPEOiBCg665bDT5xmcEYMDDj/Ouy/KGDODj6Tc7kqUYI=
X-Received: by 2002:a05:6870:10d4:b0:17e:255e:b1 with SMTP id
 20-20020a05687010d400b0017e255e00b1mr521139oar.9.1679629283610; Thu, 23 Mar
 2023 20:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com> <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
In-Reply-To: <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 24 Mar 2023 11:41:12 +0800
Message-ID: <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
To:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 4:01=E2=80=AFPM =E9=BB=84=E6=9D=B0 <huangjie.albert=
@bytedance.com> wrote:
>
> Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 10:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Mar 21, 2023 at 5:00=E2=80=AFPM Albert Huang
> > <huangjie.albert@bytedance.com> wrote:
> > >
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > >
> > > if we disable the napi_tx. when we triger a tx interrupt, the
> >
> > typo should be "trigger"
> >
>
> OK, thanks for this. I will correct it in the next version
>
> > > vq->event_triggered will be set to true. It will no longer be
> > > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > > or virtqueue_enable_cb_prepare
> > >
> > > if we disable the napi_tx, It will only be called when the tx ring
> > > buffer is relatively small:
> > > virtio_net->start_xmit:
> > >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > >                 netif_stop_subqueue(dev, qnum);
> > >                 if (!use_napi &&
> > >                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > >                         /* More just got used, free them then recheck=
. */
> > >                         free_old_xmit_skbs(sq, false);
> > >                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> > >                                 netif_start_subqueue(dev, qnum);
> > >                                 virtqueue_disable_cb(sq->vq);
> > >                         }
> >
> > The code example here is out of date, make sure your tree has this:
>
> also, I will correct it in the next version=EF=BC=8Cthis is from kernel 5=
.15.
>
> >
> > commit d71ebe8114b4bf622804b810f5e274069060a174
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Tue Jan 17 11:47:07 2023 +0800
> >
> >     virtio-net: correctly enable callback during start_xmit
> >
> > >                 }
> > >         }
> > > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT=
 or
> > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wr=
ap
> > > every time we call virtqueue_get_buf_ctx.This will bring more interru=
ptions.
> >
> > Can you please post how to test with the performance numbers?
> >
>
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receive tcp data stream from vm1, and send the ack to vm1,
> there are so
> many tx interruptions  in vm2.
>
> but without event_triggered there are just a few tx interruptions.
>
> > >
> > > if event_triggered is set to true, do not update vring_used_event(&vq=
->split.vring)
> > > or vq->packed.vring.driver->off_wrap
> > >
> > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 307e139cb11d..f486cccadbeb 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct v=
irtqueue *_vq,
> > >         /* If we expect an interrupt for the next entry, tell host
> > >          * by writing event index and flush out the write before
> > >          * the read in the next get_buf call. */
> > > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRU=
PT))
> > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRU=
PT)
> > > +                       && (vq->event_triggered =3D=3D false))
> >
> > I'm not sure this can work, when event_triggered is true it means
> > we've got an interrupt, in this case if we want another interrupt for
> > the next entry, we should update used_event otherwise we will lose
> > that interrupt?
> >
> > Thanks
>
> Normally, if we receive an interrupt, we should disable the interrupt
> in the interrupt callback handler.

So the problem is:

1) event_triggered was set to true in vring_interrupt()
2) after this nothing will happen for virtqueue_disable_cb() so
VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
then it tries to publish new event

This makes me think about whether or not we really need
event_triggered. The assumption in the virtqueue_disable_cb() seems
wrong:

/* If device triggered an event already it won't trigger one again:
 * no need to disable.
 */
if (vq->event_triggered)
                return;

This is wrong if there's no event index support. And the
event_triggered is somehow duplicated with the
VRING_AVAIL_F_NO_INTERRUPT in the case of event index. The correct fix
might be:

1) remove event_triggered
2) set VRING_AVAIL_F_NO_INTERRUPT in avail_flags_shadow in
vring_interrrupt if event index is supported

?

Thanks


> But because of the introduction of event_triggered, here,
> virtqueue_get_buf_ctx_split  cannot be recognized
> that the interrupt has been turned off.
>
> if we want  another interrupt for the next entry, We should probably
> call virtqueue_enable_cb=EF=BC=9F
>
> Thanks
>
> >
> > >                 virtio_store_mb(vq->weak_barriers,
> > >                                 &vring_used_event(&vq->split.vring),
> > >                                 cpu_to_virtio16(_vq->vdev, vq->last_u=
sed_idx));
> > > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >          * by writing event index and flush out the write before
> > >          * the read in the next get_buf call.
> > >          */
> > > -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_F=
LAG_DESC)
> > > +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_F=
LAG_DESC
> > > +                       && (vq->event_triggered =3D=3D false))
> > >                 virtio_store_mb(vq->weak_barriers,
> > >                                 &vq->packed.vring.driver->off_wrap,
> > >                                 cpu_to_le16(vq->last_used_idx));
> > > --
> > > 2.31.1
> > >
> >
>

