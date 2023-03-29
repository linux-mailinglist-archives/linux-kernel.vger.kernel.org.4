Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09E6CD681
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjC2Jdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2Jdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:33:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A212B35A1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:33:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so15381242ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680082414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGuZ1y3FrA6+NgyiJY24mmYRhAKFamd9VjafKrtxjHg=;
        b=gN+0frDySbh1pMbKrf+crr/tnSx5IU894/yUX38RSa8b4VlBgf+5Y6J33K1BNtcSq6
         8ydXljLttPMhEBoE8E5KNunFQLfd/0GZWkAa88n6zQO2jpE1JeyM95jWQX9fCFhvZu9b
         1jwsbWCoepERm9LXOp3XdPGlQ9XR3Db1TxL6w56HCPUNOtkymjNsZEaZ/vLyGf8qmt1n
         h+8Gc9GnSXPn6wtnq7rfCZxcomAjUVe17DWyLxWLTTsqFYKz16xcleVRarugB0dYyrCL
         qjwauB6mwuaaQX+MGXyoYtslVpAt2Oxp4YGWDM9OvQYYX9xDx1Hd1fVAk35HtEdn8aNS
         eHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGuZ1y3FrA6+NgyiJY24mmYRhAKFamd9VjafKrtxjHg=;
        b=BJAAWYD65E/Quu+TVq3AgOve0an5R667xYvAh8P1qhopJg2BUTQjZUBJZcQpxTlxXa
         ONkFl9hjzOZlbDcLd48Nap4oEyxGNIKIq22bWOTTjLyt4vVXDBapZ5lW7W+kFsSfFZuJ
         3kbNgtYOkcoSC+ICxYf65vmTnOCEhaPnaQwupAIjL7jV04qwsBxn53z2+MbAweTHxQXh
         Ljk+p6yHAlTY562/DoKQt50k0bEaCr4LLDQxV+IL7i/GrCuQ0dsMYe7Du5yPtzYjYNq3
         CkgEZ6kgZPmKNJS49RhyxjJHBV6kAiRskcy2D0JORch44UiBqeVy5mqM9d1WqIXVqyj4
         /WqQ==
X-Gm-Message-State: AAQBX9ddPN9tZWL48YQuzC+hyHwbpSjcUlxc72uF/KchDV68g093BY4U
        EhuHJWRR53GDYeB3ap/zH7rp31uizJdslrAY/L1d5Q==
X-Google-Smtp-Source: AKy350a4OqeNVWEC7KCqVwMv+uaDZIM43dKNnSS3aJhl/JyjdOEqnF83nYGJQVxW5lzxwTWBpr3dlUBn5QEQ0nfhWkI=
X-Received: by 2002:a2e:9949:0:b0:2a0:f395:cc44 with SMTP id
 r9-20020a2e9949000000b002a0f395cc44mr5658285ljj.8.1680082414672; Wed, 29 Mar
 2023 02:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230329072841.45304-1-huangjie.albert@bytedance.com> <1680082024.6148505-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1680082024.6148505-2-xuanzhuo@linux.alibaba.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Wed, 29 Mar 2023 17:33:23 +0800
Message-ID: <CABKxMyNXm4W+-yECstbnqy6U4_GYoOtfZ7h6+v3URzmVaJLOBQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] virtio_ring: interrupt disable flag
 updated to vq even with event_triggered is set
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
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

Xuan Zhuo <xuanzhuo@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=89 17:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 29 Mar 2023 15:28:41 +0800, Albert Huang <huangjie.albert@bytedan=
ce.com> wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt=
,
> > the vq->event_triggered will be set to true. It will no longer be set t=
o
> > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > virtqueue_enable_cb_prepare.
> >
> > If we disable the napi_tx, it will only be called when the tx ring
> > buffer is relatively small.
> >
> > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT =
or
> > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > every time we call virtqueue_get_buf_ctx.This bring more interruptions.
> >
> > To summarize:
> > 1) event_triggered was set to true in vring_interrupt()
> > 2) after this nothing will happen for virtqueue_disable_cb() so
> >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> >    then it tries to publish new event
> >
> > To fix:
> > update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to=
 vq
> > when we call virtqueue_disable_cb even the event_triggered is set to tr=
ue.
> >
> > Tested with iperf:
> > iperf3 tcp stream:
> > vm1 -----------------> vm2
> > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > there are many tx interrupts in vm2.
> > but without event_triggered there are just a few tx interrupts.
> >
> > v2->v3:
> > -update the interrupt disable flag even with the event_triggered is set=
,
> > -instead of checking whether event_triggered is set in
> > -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which ha=
ve
> > -not called virtqueue_{enable/disable}_cb to miss notifications.
> >
> > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 307e139cb11d..ad74463a48ee 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -812,6 +812,14 @@ static void virtqueue_disable_cb_split(struct virt=
queue *_vq)
> >
> >       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
> >               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERR=
UPT;
> > +
> > +             /*
> > +              * If device triggered an event already it won't trigger =
one again:
> > +              * no need to disable.
> > +              */
> > +             if (vq->event_triggered)
> > +                     return;
> > +
> >               if (vq->event)
> >                       /* TODO: this is a hack. Figure out a cleaner val=
ue to write. */
> >                       vring_used_event(&vq->split.vring) =3D 0x0;
> > @@ -1544,8 +1552,16 @@ static void virtqueue_disable_cb_packed(struct v=
irtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DI=
SABLE) {
> > +     if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DIS=
ABLE)) {
>
> This seems to be another problem.
>
> Thanks.
>

Here, we are only making this change to maintain consistency with
virtqueue_disable_cb_split.
Is there any concern with doing so?

Thanks.

>
> >               vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG=
_DISABLE;
> > +
> > +             /*
> > +              * If device triggered an event already it won't trigger =
one again:
> > +              * no need to disable.
> > +              */
> > +             if (vq->event_triggered)
> > +                     return;
> > +
> >               vq->packed.vring.driver->flags =3D
> >                       cpu_to_le16(vq->packed.event_flags_shadow);
> >       }
> > @@ -2063,12 +2079,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     /* If device triggered an event already it won't trigger one agai=
n:
> > -      * no need to disable.
> > -      */
> > -     if (vq->event_triggered)
> > -             return;
> > -
> >       if (vq->packed_ring)
> >               virtqueue_disable_cb_packed(_vq);
> >       else
> > --
> > 2.31.1
> >
