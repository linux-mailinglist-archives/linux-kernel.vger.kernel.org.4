Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508246C7822
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCXGsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCXGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC98C166E1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679640436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XNmu5CmDZ7k3yDStIxC4a29sf65AEJZAMfYF5TnXU3Q=;
        b=Hp4MvYxwCfwMx/7eQT4Z4tBagMtLXFtaK+7IrC2g52ZDLp49V0/60K2gwbHUH4N7dHGc0V
        Rv/AtWlCYJRb1TTpY9PEl0gYq/z05Oyey9tJO31rUhOgUsRtnDlkBZ31ns7ELVTCiTsRaG
        20GKTRw8gcBaAtdNLpqvoAKJPdM3v04=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-aE8B626VN5iss_GEZSxxLw-1; Fri, 24 Mar 2023 02:47:14 -0400
X-MC-Unique: aE8B626VN5iss_GEZSxxLw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-17e3d37b3e6so486359fac.22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNmu5CmDZ7k3yDStIxC4a29sf65AEJZAMfYF5TnXU3Q=;
        b=CaxbU+LXT8IaObSaup9Zgvx0Xz5RL78GcJ8XMnpIUTKy31Bi+kEY00ZD/+KfRBDrem
         5cnWoEyYLV8GFUqlDPGkgA62hQn4YsA5QNvaB5VQbsPdq3umwWTrvKo3rj3Yfax8qrlR
         Sqz7wrKeDeJVBN3xc/2J9pgEV6fcQN2h09OWCCbcFZUDUEWtI15gPysTGJKkDuTPc0yg
         sqHrxnrIpUlxbwCHixvcCbkizjU/ds4VnLCFkuIbgUKtC/vIrgzIhtH+5naSMAPcccfv
         k0f96UiVMRjGZkQ7IcwxLUxuDtKGqdA0MB4WXtOhR+b/GteaJCJWG/a05xMaAz12/UJ4
         77eQ==
X-Gm-Message-State: AO0yUKW4NnHw+zXoab9nFm39OEBpie0+VKUsO2hYf4rDi0JkoN0Lm0rp
        wbdUU5r0RMjb/eRGEk7Nja93jUJ48SAJ9z03FzmdJxtqyX3shHJzO16PZ7EUKMRNYPkJPa9wBfx
        G7t47nenmjbVyOnC/rb15MFZolUAZcujF7RnDMa2CtzJWtoQHhgc6PDe6
X-Received: by 2002:a9d:63c5:0:b0:698:f988:7c30 with SMTP id e5-20020a9d63c5000000b00698f9887c30mr722392otl.2.1679640433731;
        Thu, 23 Mar 2023 23:47:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set/leJb1db7f/y53oXWSECnmjPFjEFyiqfwIwXVddjYP9JIfWtcHcE+Z9LZ3fUErGk6jzAvHOtS1mNk6QcMH7Ag=
X-Received: by 2002:a9d:63c5:0:b0:698:f988:7c30 with SMTP id
 e5-20020a9d63c5000000b00698f9887c30mr722387otl.2.1679640433431; Thu, 23 Mar
 2023 23:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
 <20230324013805-mutt-send-email-mst@kernel.org> <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
 <20230324024155-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230324024155-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 24 Mar 2023 14:47:02 +0800
Message-ID: <CACGkMEtBYVUrKFaMJYJrkrF3y2eu7r6ige6z+uRbHY_jotq80Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 24, 2023 at 02:32:40PM +0800, Jason Wang wrote:
> > On Fri, Mar 24, 2023 at 1:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Mar 24, 2023 at 11:41:12AM +0800, Jason Wang wrote:
> > > > On Thu, Mar 23, 2023 at 4:01=E2=80=AFPM =E9=BB=84=E6=9D=B0 <huangji=
e.albert@bytedance.com> wrote:
> > > > >
> > > > > Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=88=
22=E6=97=A5=E5=91=A8=E4=B8=89 10:37=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Tue, Mar 21, 2023 at 5:00=E2=80=AFPM Albert Huang
> > > > > > <huangjie.albert@bytedance.com> wrote:
> > > > > > >
> > > > > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > > > >
> > > > > > > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > > >
> > > > > > > if we disable the napi_tx. when we triger a tx interrupt, the
> > > > > >
> > > > > > typo should be "trigger"
> > > > > >
> > > > >
> > > > > OK, thanks for this. I will correct it in the next version
> > > > >
> > > > > > > vq->event_triggered will be set to true. It will no longer be
> > > > > > > set to false. Unless we explicitly call virtqueue_enable_cb_d=
elayed
> > > > > > > or virtqueue_enable_cb_prepare
> > > > > > >
> > > > > > > if we disable the napi_tx, It will only be called when the tx=
 ring
> > > > > > > buffer is relatively small:
> > > > > > > virtio_net->start_xmit:
> > > > > > >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > > > >                 netif_stop_subqueue(dev, qnum);
> > > > > > >                 if (!use_napi &&
> > > > > > >                     unlikely(!virtqueue_enable_cb_delayed(sq-=
>vq))) {
> > > > > > >                         /* More just got used, free them then=
 recheck. */
> > > > > > >                         free_old_xmit_skbs(sq, false);
> > > > > > >                         if (sq->vq->num_free >=3D 2+MAX_SKB_F=
RAGS) {
> > > > > > >                                 netif_start_subqueue(dev, qnu=
m);
> > > > > > >                                 virtqueue_disable_cb(sq->vq);
> > > > > > >                         }
> > > > > >
> > > > > > The code example here is out of date, make sure your tree has t=
his:
> > > > >
> > > > > also, I will correct it in the next version=EF=BC=8Cthis is from =
kernel 5.15.
> > > > >
> > > > > >
> > > > > > commit d71ebe8114b4bf622804b810f5e274069060a174
> > > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > > Date:   Tue Jan 17 11:47:07 2023 +0800
> > > > > >
> > > > > >     virtio-net: correctly enable callback during start_xmit
> > > > > >
> > > > > > >                 }
> > > > > > >         }
> > > > > > > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_I=
NTERRUPT or
> > > > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver=
->off_wrap
> > > > > > > every time we call virtqueue_get_buf_ctx.This will bring more=
 interruptions.
> > > > > >
> > > > > > Can you please post how to test with the performance numbers?
> > > > > >
> > > > >
> > > > > iperf3 tcp stream:
> > > > > vm1 -----------------> vm2
> > > > > vm2 just receive tcp data stream from vm1, and send the ack to vm=
1,
> > > > > there are so
> > > > > many tx interruptions  in vm2.
> > > > >
> > > > > but without event_triggered there are just a few tx interruptions=
.
> > > > >
> > > > > > >
> > > > > > > if event_triggered is set to true, do not update vring_used_e=
vent(&vq->split.vring)
> > > > > > > or vq->packed.vring.driver->off_wrap
> > > > > > >
> > > > > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com=
>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/vi=
rtio_ring.c
> > > > > > > index 307e139cb11d..f486cccadbeb 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(=
struct virtqueue *_vq,
> > > > > > >         /* If we expect an interrupt for the next entry, tell=
 host
> > > > > > >          * by writing event index and flush out the write bef=
ore
> > > > > > >          * the read in the next get_buf call. */
> > > > > > > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO=
_INTERRUPT))
> > > > > > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO=
_INTERRUPT)
> > > > > > > +                       && (vq->event_triggered =3D=3D false)=
)
> > > > > >
> > > > > > I'm not sure this can work, when event_triggered is true it mea=
ns
> > > > > > we've got an interrupt, in this case if we want another interru=
pt for
> > > > > > the next entry, we should update used_event otherwise we will l=
ose
> > > > > > that interrupt?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Normally, if we receive an interrupt, we should disable the inter=
rupt
> > > > > in the interrupt callback handler.
> > > >
> > > > So the problem is:
> > > >
> > > > 1) event_triggered was set to true in vring_interrupt()
> > > >
> > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > > VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > > then it tries to publish new event
> > >
> > > Oh. Good point! I think when I wrote up
> > > 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > I missed this corner case.
> > >
> > >
> > >
> > > > This makes me think about whether or not we really need
> > > > event_triggered. The assumption in the virtqueue_disable_cb() seems
> > > > wrong:
> > > >
> > > > /* If device triggered an event already it won't trigger one again:
> > > >  * no need to disable.
> > > >  */
> > > > if (vq->event_triggered)
> > > >                 return;
> > > >
> > > > This is wrong if there's no event index support.
> > >
> > >
> > > I don't get it.  how does this get triggered?
> > >
> > > You are talking about device without event index?
> > > Here's code from vring_interrupt():
> > >
> > >         /* Just a hint for performance: so it's ok that this can be r=
acy! */
> > >         if (vq->event)
> > >                 vq->event_triggered =3D true;
> >
> > But we have the following in virtqueue_disable_cb():
> >
> >         /* If device triggered an event already it won't trigger one ag=
ain:
> >          * no need to disable.
> >          */
> >         if (vq->event_triggered)
> >                 return;
> >
> >         if (vq->packed_ring)
> >                 virtqueue_disable_cb_packed(_vq);
> >         else
> >                 virtqueue_disable_cb_split(_vq);
> >
> > This means, without an event index, we don't set avail flags. So the
> > interrupt is not disabled actually in this case.
> >
> > Thanks
>
> Only if event_triggered is true, which without event index it never is.

I'm not sure I will get here. I meant for example the commit
suppresses the effort of skb_xmit_done():

static void skb_xmit_done(struct virtqueue *vq)
{
        struct virtnet_info *vi =3D vq->vdev->priv;
        struct napi_struct *napi =3D &vi->sq[vq2txq(vq)].napi;

        /* Suppress further interrupts. */
        virtqueue_disable_cb(vq);

The virtqueue_disable_cb() doesn't disable further interrupts when the
event index is not there.

Thanks

>
> > >
> > >
> > >
> > >
> > > > And the
> > > > event_triggered is somehow duplicated with the
> > > > VRING_AVAIL_F_NO_INTERRUPT in the case of event index. The correct =
fix
> > > > might be:
> > > >
> > > > 1) remove event_triggered
> > > > 2) set VRING_AVAIL_F_NO_INTERRUPT in avail_flags_shadow in
> > > > vring_interrrupt if event index is supported
> > > >
> > > > ?
> > > >
> > > > Thanks
> > >
> > > I am not sure all this is right and I'd rather we focused
> > > performance/correctness and cleanups separately.
> > >
> > >
> > >
> > >
> > > >
> > > > > But because of the introduction of event_triggered, here,
> > > > > virtqueue_get_buf_ctx_split  cannot be recognized
> > > > > that the interrupt has been turned off.
> > > > >
> > > > > if we want  another interrupt for the next entry, We should proba=
bly
> > > > > call virtqueue_enable_cb=EF=BC=9F
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > > > >                                 &vring_used_event(&vq->split.=
vring),
> > > > > > >                                 cpu_to_virtio16(_vq->vdev, vq=
->last_used_idx));
> > > > > > > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_pack=
ed(struct virtqueue *_vq,
> > > > > > >          * by writing event index and flush out the write bef=
ore
> > > > > > >          * the read in the next get_buf call.
> > > > > > >          */
> > > > > > > -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED=
_EVENT_FLAG_DESC)
> > > > > > > +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED=
_EVENT_FLAG_DESC
> > > > > > > +                       && (vq->event_triggered =3D=3D false)=
)
> > > > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > > > >                                 &vq->packed.vring.driver->off=
_wrap,
> > > > > > >                                 cpu_to_le16(vq->last_used_idx=
));
> > > > > > > --
> > > > > > > 2.31.1
> > > > > > >
> > > > > >
> > > > >
> > >
>

