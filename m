Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7296C613E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCWICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:02:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DAD2BED2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:01:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y20so26622657lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679558489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpETsmFSwFRBVInD7wt0EV3nl18YqZV+4aljq7l8MP8=;
        b=V7/RXvCQo0hf4SBjZd/o2ZZetEwEiR6/zMCDipAFRSwz1d4WHAlkuSKYKeWf3cRKF1
         IflGK7jB2U7aXUkIzG60oAc5MlnrAGkAOHh/SbSE8XzKjLZiFerLE10ESZ6DalL4WRPD
         LBURsp+3F0T1JBMxWhz5/lWu/6ld1v83KzIE+7p4mXtP0ah/g6LCALOrDbQgtLVuj4br
         lQJO+5H7vTVGPH1Pdp+zsfUsCQggKsuZRrJjuEkXpx8ScSfiwExKpVRYu3Epu8RVpSDa
         2SDKL4guHuAviotwP3Ii7B0TqHlk17cQ+nJCn43ahdqLYkG6z5wJJgAXKQD2aRF4k2HK
         j0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpETsmFSwFRBVInD7wt0EV3nl18YqZV+4aljq7l8MP8=;
        b=fO9Qo0swK6/6zH5XsLfBnOm3fY4EZVcX9pVE+dLjVqnPnqR/e/ANkr0hZMxukUfiF3
         u4Hb1VYLJjbaugPJg66YKj+vMGRZMZa3zN50/Q22Ctd7b9cD169/vdF8Rdm+fTWYLx3e
         MUnsj5k+kUetWw1LLAz93QkUPaxR9vi8i1dHCgoKLPpr8mK8gRU0z5ril2bqce6sNqXk
         Y7EBMVTFNA6BGNyIk8WbrVuktnCqE2IKcz4PyNMqtg2Rdm6TeKtnai68DO8zBENraPaG
         tHLRQEd6YWOJzOQk2EclDXrXSjFkDi2+Jl/ipLGPGUSzPzqRmzkeGZa3bVI1DNGqkDb4
         PXFg==
X-Gm-Message-State: AO0yUKX/jyhC3bbE0MJ1IwxZb2RBb+/z0LluZTaYuTdc47GKnIjlrjW+
        uFFwbk/ONcKHoCuaSYXJVCDXsm9D5o8bYlZ53eU4TQ==
X-Google-Smtp-Source: AK7set+Xr0NsXmaYYijwXJuEI6oTWmqpsJNebdDlY9+GzM5wFjb3n+jK6yofTaC5dvHtfAzIYAhNv+QuLHHUqL/rNNg=
X-Received: by 2002:ac2:46d4:0:b0:4ea:fc8f:7852 with SMTP id
 p20-20020ac246d4000000b004eafc8f7852mr355695lfo.12.1679558489232; Thu, 23 Mar
 2023 01:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com> <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
In-Reply-To: <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 23 Mar 2023 16:01:17 +0800
Message-ID: <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 10:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 21, 2023 at 5:00=E2=80=AFPM Albert Huang
> <huangjie.albert@bytedance.com> wrote:
> >
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> >
> > if we disable the napi_tx. when we triger a tx interrupt, the
>
> typo should be "trigger"
>

OK, thanks for this. I will correct it in the next version

> > vq->event_triggered will be set to true. It will no longer be
> > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > or virtqueue_enable_cb_prepare
> >
> > if we disable the napi_tx, It will only be called when the tx ring
> > buffer is relatively small:
> > virtio_net->start_xmit:
> >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> >                 netif_stop_subqueue(dev, qnum);
> >                 if (!use_napi &&
> >                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> >                         /* More just got used, free them then recheck. =
*/
> >                         free_old_xmit_skbs(sq, false);
> >                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> >                                 netif_start_subqueue(dev, qnum);
> >                                 virtqueue_disable_cb(sq->vq);
> >                         }
>
> The code example here is out of date, make sure your tree has this:

also, I will correct it in the next version=EF=BC=8Cthis is from kernel 5.1=
5.

>
> commit d71ebe8114b4bf622804b810f5e274069060a174
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Tue Jan 17 11:47:07 2023 +0800
>
>     virtio-net: correctly enable callback during start_xmit
>
> >                 }
> >         }
> > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT o=
r
> > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > every time we call virtqueue_get_buf_ctx.This will bring more interrupt=
ions.
>
> Can you please post how to test with the performance numbers?
>

iperf3 tcp stream:
vm1 -----------------> vm2
vm2 just receive tcp data stream from vm1, and send the ack to vm1,
there are so
many tx interruptions  in vm2.

but without event_triggered there are just a few tx interruptions.

> >
> > if event_triggered is set to true, do not update vring_used_event(&vq->=
split.vring)
> > or vq->packed.vring.driver->off_wrap
> >
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 307e139cb11d..f486cccadbeb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct vir=
tqueue *_vq,
> >         /* If we expect an interrupt for the next entry, tell host
> >          * by writing event index and flush out the write before
> >          * the read in the next get_buf call. */
> > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT=
))
> > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT=
)
> > +                       && (vq->event_triggered =3D=3D false))
>
> I'm not sure this can work, when event_triggered is true it means
> we've got an interrupt, in this case if we want another interrupt for
> the next entry, we should update used_event otherwise we will lose
> that interrupt?
>
> Thanks

Normally, if we receive an interrupt, we should disable the interrupt
in the interrupt callback handler.
But because of the introduction of event_triggered, here,
virtqueue_get_buf_ctx_split  cannot be recognized
that the interrupt has been turned off.

if we want  another interrupt for the next entry, We should probably
call virtqueue_enable_cb=EF=BC=9F

Thanks

>
> >                 virtio_store_mb(vq->weak_barriers,
> >                                 &vring_used_event(&vq->split.vring),
> >                                 cpu_to_virtio16(_vq->vdev, vq->last_use=
d_idx));
> > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >          * by writing event index and flush out the write before
> >          * the read in the next get_buf call.
> >          */
> > -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLA=
G_DESC)
> > +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLA=
G_DESC
> > +                       && (vq->event_triggered =3D=3D false))
> >                 virtio_store_mb(vq->weak_barriers,
> >                                 &vq->packed.vring.driver->off_wrap,
> >                                 cpu_to_le16(vq->last_used_idx));
> > --
> > 2.31.1
> >
>
