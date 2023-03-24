Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5C6C7800
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjCXGdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjCXGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136519F39
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679639573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpoTUd8gexKD/LUwfjlQ6Nm5sxxfq01/bpYgncpDATA=;
        b=M90f06tfWw9xkcjIbDElS685Hb3ZUCg92gRF1uoTbgD9QCe1TFLGzqz72Y4Ts7vpfq6D+k
        V7XlGEZk+m53ntq1YK91dTNGulsan31X3ZZyqANSR92tY/otTv90F41flTMnXdPgW7OnfC
        ikGyaqWMql+SC8OCO0KmA8jOkpyzdSs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-N3QNaJm9P7-4H5GLoMOydw-1; Fri, 24 Mar 2023 02:32:52 -0400
X-MC-Unique: N3QNaJm9P7-4H5GLoMOydw-1
Received: by mail-ot1-f71.google.com with SMTP id a16-20020a9d3e10000000b0069fba0320c3so357371otd.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpoTUd8gexKD/LUwfjlQ6Nm5sxxfq01/bpYgncpDATA=;
        b=jKDRZd8Dq4NFIyQDH+lTLLyWHmqy75fkTljQTAi+tXLpZ3uomb2Fx7BfXGJGsrcLjC
         uFvUVJ+J7/1te8S8OGqZWwm8Mc2HuViJimgqFfc4aRm4tCbjk08qpJKlIuGY4lt8p4I1
         nSv0kd375NzClhP7Uc+PCtrzg4mbmigG8ohOfSnfKdj8vLUWJhpj/uDuyupyvDaj/woi
         RcmOpMLPudDfKtUIJn6WesNkM2Cf4u6scfvqrT7+XWxVVESmzB3QaEHlRnaoeLhoSS2W
         s3TpSOx5lvAYDTLFy6Wa7TxOaZh0fXfxXTc8zK0rkVQam3IrZDAUabCUgYtWdxHqWmab
         eXcQ==
X-Gm-Message-State: AO0yUKXF2Un4PN9/gntSnn9Q8lRj217BNodapeUkQZN5qTq34ce8LO01
        C7vlpNt6EN1JpIiMkVrzS+UpBSsPjtiZMSh1UZWhQSafi4xSnYqEAqXFPG5XrFRwGtKZZTDF6Wt
        I1+m0ynJRga4tTtBdizN6RssOEuAlTG47wSbhtzWC
X-Received: by 2002:a9d:6acc:0:b0:69b:1bd:7f9e with SMTP id m12-20020a9d6acc000000b0069b01bd7f9emr677554otq.2.1679639571668;
        Thu, 23 Mar 2023 23:32:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFJp+rrnSyF9Y9mDMmNwT4uiiNpuMwxyABPCR8hjBwQYQPmeMliyEZOME3iFyeMvWPGdC3TGi46/NYXdoNrhs=
X-Received: by 2002:a9d:6acc:0:b0:69b:1bd:7f9e with SMTP id
 m12-20020a9d6acc000000b0069b01bd7f9emr677552otq.2.1679639571415; Thu, 23 Mar
 2023 23:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com> <20230324013805-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230324013805-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 24 Mar 2023 14:32:40 +0800
Message-ID: <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
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

On Fri, Mar 24, 2023 at 1:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 24, 2023 at 11:41:12AM +0800, Jason Wang wrote:
> > On Thu, Mar 23, 2023 at 4:01=E2=80=AFPM =E9=BB=84=E6=9D=B0 <huangjie.al=
bert@bytedance.com> wrote:
> > >
> > > Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=89 10:37=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Tue, Mar 21, 2023 at 5:00=E2=80=AFPM Albert Huang
> > > > <huangjie.albert@bytedance.com> wrote:
> > > > >
> > > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > >
> > > > > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > >
> > > > > if we disable the napi_tx. when we triger a tx interrupt, the
> > > >
> > > > typo should be "trigger"
> > > >
> > >
> > > OK, thanks for this. I will correct it in the next version
> > >
> > > > > vq->event_triggered will be set to true. It will no longer be
> > > > > set to false. Unless we explicitly call virtqueue_enable_cb_delay=
ed
> > > > > or virtqueue_enable_cb_prepare
> > > > >
> > > > > if we disable the napi_tx, It will only be called when the tx rin=
g
> > > > > buffer is relatively small:
> > > > > virtio_net->start_xmit:
> > > > >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > >                 netif_stop_subqueue(dev, qnum);
> > > > >                 if (!use_napi &&
> > > > >                     unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
)) {
> > > > >                         /* More just got used, free them then rec=
heck. */
> > > > >                         free_old_xmit_skbs(sq, false);
> > > > >                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS=
) {
> > > > >                                 netif_start_subqueue(dev, qnum);
> > > > >                                 virtqueue_disable_cb(sq->vq);
> > > > >                         }
> > > >
> > > > The code example here is out of date, make sure your tree has this:
> > >
> > > also, I will correct it in the next version=EF=BC=8Cthis is from kern=
el 5.15.
> > >
> > > >
> > > > commit d71ebe8114b4bf622804b810f5e274069060a174
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Tue Jan 17 11:47:07 2023 +0800
> > > >
> > > >     virtio-net: correctly enable callback during start_xmit
> > > >
> > > > >                 }
> > > > >         }
> > > > > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTER=
RUPT or
> > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->of=
f_wrap
> > > > > every time we call virtqueue_get_buf_ctx.This will bring more int=
erruptions.
> > > >
> > > > Can you please post how to test with the performance numbers?
> > > >
> > >
> > > iperf3 tcp stream:
> > > vm1 -----------------> vm2
> > > vm2 just receive tcp data stream from vm1, and send the ack to vm1,
> > > there are so
> > > many tx interruptions  in vm2.
> > >
> > > but without event_triggered there are just a few tx interruptions.
> > >
> > > > >
> > > > > if event_triggered is set to true, do not update vring_used_event=
(&vq->split.vring)
> > > > > or vq->packed.vring.driver->off_wrap
> > > > >
> > > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 307e139cb11d..f486cccadbeb 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(stru=
ct virtqueue *_vq,
> > > > >         /* If we expect an interrupt for the next entry, tell hos=
t
> > > > >          * by writing event index and flush out the write before
> > > > >          * the read in the next get_buf call. */
> > > > > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INT=
ERRUPT))
> > > > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INT=
ERRUPT)
> > > > > +                       && (vq->event_triggered =3D=3D false))
> > > >
> > > > I'm not sure this can work, when event_triggered is true it means
> > > > we've got an interrupt, in this case if we want another interrupt f=
or
> > > > the next entry, we should update used_event otherwise we will lose
> > > > that interrupt?
> > > >
> > > > Thanks
> > >
> > > Normally, if we receive an interrupt, we should disable the interrupt
> > > in the interrupt callback handler.
> >
> > So the problem is:
> >
> > 1) event_triggered was set to true in vring_interrupt()
> >
> > 2) after this nothing will happen for virtqueue_disable_cb() so
> > VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > then it tries to publish new event
>
> Oh. Good point! I think when I wrote up
> 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> I missed this corner case.
>
>
>
> > This makes me think about whether or not we really need
> > event_triggered. The assumption in the virtqueue_disable_cb() seems
> > wrong:
> >
> > /* If device triggered an event already it won't trigger one again:
> >  * no need to disable.
> >  */
> > if (vq->event_triggered)
> >                 return;
> >
> > This is wrong if there's no event index support.
>
>
> I don't get it.  how does this get triggered?
>
> You are talking about device without event index?
> Here's code from vring_interrupt():
>
>         /* Just a hint for performance: so it's ok that this can be racy!=
 */
>         if (vq->event)
>                 vq->event_triggered =3D true;

But we have the following in virtqueue_disable_cb():

        /* If device triggered an event already it won't trigger one again:
         * no need to disable.
         */
        if (vq->event_triggered)
                return;

        if (vq->packed_ring)
                virtqueue_disable_cb_packed(_vq);
        else
                virtqueue_disable_cb_split(_vq);

This means, without an event index, we don't set avail flags. So the
interrupt is not disabled actually in this case.

Thanks

>
>
>
>
> > And the
> > event_triggered is somehow duplicated with the
> > VRING_AVAIL_F_NO_INTERRUPT in the case of event index. The correct fix
> > might be:
> >
> > 1) remove event_triggered
> > 2) set VRING_AVAIL_F_NO_INTERRUPT in avail_flags_shadow in
> > vring_interrrupt if event index is supported
> >
> > ?
> >
> > Thanks
>
> I am not sure all this is right and I'd rather we focused
> performance/correctness and cleanups separately.
>
>
>
>
> >
> > > But because of the introduction of event_triggered, here,
> > > virtqueue_get_buf_ctx_split  cannot be recognized
> > > that the interrupt has been turned off.
> > >
> > > if we want  another interrupt for the next entry, We should probably
> > > call virtqueue_enable_cb=EF=BC=9F
> > >
> > > Thanks
> > >
> > > >
> > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > >                                 &vring_used_event(&vq->split.vrin=
g),
> > > > >                                 cpu_to_virtio16(_vq->vdev, vq->la=
st_used_idx));
> > > > > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(s=
truct virtqueue *_vq,
> > > > >          * by writing event index and flush out the write before
> > > > >          * the read in the next get_buf call.
> > > > >          */
> > > > > -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVE=
NT_FLAG_DESC)
> > > > > +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVE=
NT_FLAG_DESC
> > > > > +                       && (vq->event_triggered =3D=3D false))
> > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > >                                 &vq->packed.vring.driver->off_wra=
p,
> > > > >                                 cpu_to_le16(vq->last_used_idx));
> > > > > --
> > > > > 2.31.1
> > > > >
> > > >
> > >
>

