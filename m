Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9E6CD780
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjC2KTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjC2KTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:19:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F81BFD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:19:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e21so15511801ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680085145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eweV4TnS9stV78S3cDTU8uMJIS8vYyxA7lqn0JWsz0=;
        b=DDjTT0mvS5sH6IEZc0dsnrGDSDZUaUjQkUVtTEba9Hv9lvqmgavZObV9nBfLHeZg/q
         jMC2yuQ0sbv58fnIypy78ynDGrHuDv+2uDKgA6YFtfeuCDdiOvKcAziBBjRT/BN80E5S
         l3aelE9NwHXsAFrCsRYQg6HU/dLG9FSzVfCTthKVSEh20W9FpCWgpBbxmH2ms6PIXmXb
         7xUojVhsfYox+9kq+8V1jOeQuNf4+zjjDhghd2Cl0bhC5w8vWdbEjMXXzspueNCjbY/R
         ZmklyhN+WhYmNAGN/VNt8+B8DeWwhlcaEfirgHz8/+3w0SoKD7XAJ2NmTj484hFJMAyB
         L5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680085145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eweV4TnS9stV78S3cDTU8uMJIS8vYyxA7lqn0JWsz0=;
        b=FcPXT//+m0pGY6NqvHL/JjLBV45VbmNThXD+6BDjb8pLqELh0MuvZqwU1yFGbAs/1o
         zdaoHgw5bfInKwrioIyiSWWwocjn4pSEjASG6MwG76H+h089VvbgG4nyUJtIAPVIYsGw
         GPMAzRHwLkAspPM3WeQGgyvW38KOt114zPovFaNTqdBjqm7VEPz3BbsEa933jIkcPC1w
         ibFcG+FjM8Ss4JjV+hK/v0ReyQ08NhPTm+aceNY5shvBZnUndb0TLK/AdCBqpEZ6csGn
         l6PblH2bKb1FXUKkI0E2bqF3p2rkLMLux0Lahivun3BZArDD0QMc/u9T1zUgV9gbDcGH
         QFVQ==
X-Gm-Message-State: AAQBX9eVbd2R69m3sZq8jr2NTP5KR5AgbazcwzqnvT4Q/Im9iMWBtQYV
        khlzSONlzlJ7aA8xmKNTcqZdXXPJGGf3HFhO4UUHGw==
X-Google-Smtp-Source: AKy350b2tXnVnXKOzKAV8fHwSuhfH8oW0FtMTOvR2USRSakuAPYAUIyt7/Y4O+Nf+Xy4riS/CVEMtwV82vZmLPGcVvA=
X-Received: by 2002:a2e:bc1e:0:b0:299:6e0e:3a1b with SMTP id
 b30-20020a2ebc1e000000b002996e0e3a1bmr915441ljf.4.1680085145476; Wed, 29 Mar
 2023 03:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230329072841.45304-1-huangjie.albert@bytedance.com>
 <1680082024.6148505-2-xuanzhuo@linux.alibaba.com> <CABKxMyNXm4W+-yECstbnqy6U4_GYoOtfZ7h6+v3URzmVaJLOBQ@mail.gmail.com>
 <1680083360.7413719-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1680083360.7413719-1-xuanzhuo@linux.alibaba.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Wed, 29 Mar 2023 18:18:53 +0800
Message-ID: <CABKxMyNiX+MQcQD7JkGf=r7pRgVsPJuKXdOowGjzFPvdUbY4Mg@mail.gmail.com>
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
=E6=97=A5=E5=91=A8=E4=B8=89 17:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 29 Mar 2023 17:33:23 +0800, =3D?utf-8?b?6buE5p2w?=3D <huangjie.al=
bert@bytedance.com> wrote:
> > Xuan Zhuo <xuanzhuo@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=89 17:27=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, 29 Mar 2023 15:28:41 +0800, Albert Huang <huangjie.albert@byt=
edance.com> wrote:
> > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > >
> > > > in virtio_net, if we disable the napi_tx, when we triger a tx inter=
rupt,
> > > > the vq->event_triggered will be set to true. It will no longer be s=
et to
> > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > virtqueue_enable_cb_prepare.
> > > >
> > > > If we disable the napi_tx, it will only be called when the tx ring
> > > > buffer is relatively small.
> > > >
> > > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERR=
UPT or
> > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_=
wrap
> > > > every time we call virtqueue_get_buf_ctx.This bring more interrupti=
ons.
> > > >
> > > > To summarize:
> > > > 1) event_triggered was set to true in vring_interrupt()
> > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > >    then it tries to publish new event
> > > >
> > > > To fix:
> > > > update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABL=
E to vq
> > > > when we call virtqueue_disable_cb even the event_triggered is set t=
o true.
> > > >
> > > > Tested with iperf:
> > > > iperf3 tcp stream:
> > > > vm1 -----------------> vm2
> > > > vm2 just receives tcp data stream from vm1, and sends the ack to vm=
1,
> > > > there are many tx interrupts in vm2.
> > > > but without event_triggered there are just a few tx interrupts.
> > > >
> > > > v2->v3:
> > > > -update the interrupt disable flag even with the event_triggered is=
 set,
> > > > -instead of checking whether event_triggered is set in
> > > > -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  whic=
h have
> > > > -not called virtqueue_{enable/disable}_cb to miss notifications.
> > > >
> > > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 24 +++++++++++++++++-------
> > > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 307e139cb11d..ad74463a48ee 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -812,6 +812,14 @@ static void virtqueue_disable_cb_split(struct =
virtqueue *_vq)
> > > >
> > > >       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRU=
PT)) {
> > > >               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_IN=
TERRUPT;
> > > > +
> > > > +             /*
> > > > +              * If device triggered an event already it won't trig=
ger one again:
> > > > +              * no need to disable.
> > > > +              */
> > > > +             if (vq->event_triggered)
> > > > +                     return;
> > > > +
> > > >               if (vq->event)
> > > >                       /* TODO: this is a hack. Figure out a cleaner=
 value to write. */
> > > >                       vring_used_event(&vq->split.vring) =3D 0x0;
> > > > @@ -1544,8 +1552,16 @@ static void virtqueue_disable_cb_packed(stru=
ct virtqueue *_vq)
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLA=
G_DISABLE) {
> > > > +     if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG=
_DISABLE)) {
> > >
> > > This seems to be another problem.
> > >
> > > Thanks.
> > >
> >
> > Here, we are only making this change to maintain consistency with
> > virtqueue_disable_cb_split.
> > Is there any concern with doing so?
>
> I'm not sure why the use_flags_shadow use "!=3D" to judge, but it seems
> that all places are used like this. So we'd better keep the original. If =
it is
> necessary to modify it here, I think a separate commit should be posted.
> Even if it is just to keep it consistent with split.
>

Let's create a separate commit for this change, and I'll modify the
current commit.
However, the original judgment method in this location was problematic

Thanks.

>
> Thanks.
>
>
>
> >
> > Thanks.
> >
> > >
> > > >               vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_=
FLAG_DISABLE;
> > > > +
> > > > +             /*
> > > > +              * If device triggered an event already it won't trig=
ger one again:
> > > > +              * no need to disable.
> > > > +              */
> > > > +             if (vq->event_triggered)
> > > > +                     return;
> > > > +
> > > >               vq->packed.vring.driver->flags =3D
> > > >                       cpu_to_le16(vq->packed.event_flags_shadow);
> > > >       }
> > > > @@ -2063,12 +2079,6 @@ void virtqueue_disable_cb(struct virtqueue *=
_vq)
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     /* If device triggered an event already it won't trigger one =
again:
> > > > -      * no need to disable.
> > > > -      */
> > > > -     if (vq->event_triggered)
> > > > -             return;
> > > > -
> > > >       if (vq->packed_ring)
> > > >               virtqueue_disable_cb_packed(_vq);
> > > >       else
> > > > --
> > > > 2.31.1
> > > >
