Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1905C6CD708
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjC2JyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjC2JyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:54:08 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1199448C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:53:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VewN.CU_1680083580;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VewN.CU_1680083580)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 17:53:01 +0800
Message-ID: <1680083360.7413719-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [External] Re: [PATCH v3] virtio_ring: interrupt disable flag updated to vq even with event_triggered is set
Date:   Wed, 29 Mar 2023 17:49:20 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     =?utf-8?b?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
References: <20230329072841.45304-1-huangjie.albert@bytedance.com>
 <1680082024.6148505-2-xuanzhuo@linux.alibaba.com>
 <CABKxMyNXm4W+-yECstbnqy6U4_GYoOtfZ7h6+v3URzmVaJLOBQ@mail.gmail.com>
In-Reply-To: <CABKxMyNXm4W+-yECstbnqy6U4_GYoOtfZ7h6+v3URzmVaJLOBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 17:33:23 +0800, =3D?utf-8?b?6buE5p2w?=3D <huangjie.albe=
rt@bytedance.com> wrote:
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=89 17:27=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, 29 Mar 2023 15:28:41 +0800, Albert Huang <huangjie.albert@byted=
ance.com> wrote:
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > in virtio_net, if we disable the napi_tx, when we triger a tx interru=
pt,
> > > the vq->event_triggered will be set to true. It will no longer be set=
 to
> > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > virtqueue_enable_cb_prepare.
> > >
> > > If we disable the napi_tx, it will only be called when the tx ring
> > > buffer is relatively small.
> > >
> > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUP=
T or
> > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wr=
ap
> > > every time we call virtqueue_get_buf_ctx.This bring more interruption=
s.
> > >
> > > To summarize:
> > > 1) event_triggered was set to true in vring_interrupt()
> > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > >    then it tries to publish new event
> > >
> > > To fix:
> > > update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE =
to vq
> > > when we call virtqueue_disable_cb even the event_triggered is set to =
true.
> > >
> > > Tested with iperf:
> > > iperf3 tcp stream:
> > > vm1 -----------------> vm2
> > > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > > there are many tx interrupts in vm2.
> > > but without event_triggered there are just a few tx interrupts.
> > >
> > > v2->v3:
> > > -update the interrupt disable flag even with the event_triggered is s=
et,
> > > -instead of checking whether event_triggered is set in
> > > -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which =
have
> > > -not called virtqueue_{enable/disable}_cb to miss notifications.
> > >
> > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 307e139cb11d..ad74463a48ee 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -812,6 +812,14 @@ static void virtqueue_disable_cb_split(struct vi=
rtqueue *_vq)
> > >
> > >       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT=
)) {
> > >               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTE=
RRUPT;
> > > +
> > > +             /*
> > > +              * If device triggered an event already it won't trigge=
r one again:
> > > +              * no need to disable.
> > > +              */
> > > +             if (vq->event_triggered)
> > > +                     return;
> > > +
> > >               if (vq->event)
> > >                       /* TODO: this is a hack. Figure out a cleaner v=
alue to write. */
> > >                       vring_used_event(&vq->split.vring) =3D 0x0;
> > > @@ -1544,8 +1552,16 @@ static void virtqueue_disable_cb_packed(struct=
 virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >
> > > -     if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_=
DISABLE) {
> > > +     if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_D=
ISABLE)) {
> >
> > This seems to be another problem.
> >
> > Thanks.
> >
>
> Here, we are only making this change to maintain consistency with
> virtqueue_disable_cb_split.
> Is there any concern with doing so?

I'm not sure why the use_flags_shadow use "!=3D" to judge, but it seems
that all places are used like this. So we'd better keep the original. If it=
 is
necessary to modify it here, I think a separate commit should be posted.
Even if it is just to keep it consistent with split.


Thanks.



>
> Thanks.
>
> >
> > >               vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FL=
AG_DISABLE;
> > > +
> > > +             /*
> > > +              * If device triggered an event already it won't trigge=
r one again:
> > > +              * no need to disable.
> > > +              */
> > > +             if (vq->event_triggered)
> > > +                     return;
> > > +
> > >               vq->packed.vring.driver->flags =3D
> > >                       cpu_to_le16(vq->packed.event_flags_shadow);
> > >       }
> > > @@ -2063,12 +2079,6 @@ void virtqueue_disable_cb(struct virtqueue *_v=
q)
> > >  {
> > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >
> > > -     /* If device triggered an event already it won't trigger one ag=
ain:
> > > -      * no need to disable.
> > > -      */
> > > -     if (vq->event_triggered)
> > > -             return;
> > > -
> > >       if (vq->packed_ring)
> > >               virtqueue_disable_cb_packed(_vq);
> > >       else
> > > --
> > > 2.31.1
> > >
