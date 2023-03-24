Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC80B6C7816
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCXGnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCXGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F423A56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679640151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmdb6j6ItYOZ/8VqzMFnrYnH4ti/eMeg7F+hPFB/9iw=;
        b=K9CNhPUOzYZkW6+ORpC5B9UOq8bjCH6mIejUmMWT70DEKOgPHUJ8e1GejvgV28soGFplT9
        ZK2pFUrbEuXTLpml7ncnJO5z6ZbBnpiINeUBb1P0p3OeVR5YSXrJzKjgWr5lalvMc4A15n
        kjgrtxW9L0dM+3KSzH/OGOqlkB732X8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-dZetWTFAOuyxRFuq06Ayvw-1; Fri, 24 Mar 2023 02:42:30 -0400
X-MC-Unique: dZetWTFAOuyxRFuq06Ayvw-1
Received: by mail-wm1-f72.google.com with SMTP id p10-20020a05600c358a00b003edf7d484d4so366312wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmdb6j6ItYOZ/8VqzMFnrYnH4ti/eMeg7F+hPFB/9iw=;
        b=OaGVd9kXt+5TK3LEU6B4nZ8pDZ4PMrm6rJtd3CHdjIMxzhPQM6VsjTSmEmSt0/zWRW
         UG683JdIA5SPQkLR6ZJOHPtVWueU2pjBewCfJ0/3s/6PvjTN45cRbDZoFaLmPBkrziKI
         P+104YL/NWdFVuobHPX6nW/bJkfZCVZemjWJrqcBmfqJ4/w/ikL9lDrrjH5Z8t1HY33M
         yIUkId9J2TZyI5EtX4dyasMe7ATpvXRv1h+nVK3CVkNblbrha1xclc+At9aWmHoD411p
         v2Ibhplkubs6IYM9dPQI46Q7PoWE7X/6gr5iOkmf3YJ5bET9JdqDG9lleHhYE6duBOX6
         LZEQ==
X-Gm-Message-State: AO0yUKXcMWyfvDHfOb3yq2mmqRc6l/xdGgj7xK86XtuQHSgdG7XJpn1I
        goDOrtc3qJh8sOjXEjibYLCUniAkljReC8wSfW/uKy3vQjGtvVcRs9qjsSr0MMlwiXwg2frFzd1
        GO/rXa/lJ6PMvnSrEjseWEtxU
X-Received: by 2002:a7b:c8c3:0:b0:3ed:f5b5:37fc with SMTP id f3-20020a7bc8c3000000b003edf5b537fcmr1561238wml.1.1679640149479;
        Thu, 23 Mar 2023 23:42:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set8qEkJsxwBH6JavY2EvJWIrGXnnEjIkZNbHFxl/rDprhEPzTouh1Y39uZ3gHFMz6zhoHicYng==
X-Received: by 2002:a7b:c8c3:0:b0:3ed:f5b5:37fc with SMTP id f3-20020a7bc8c3000000b003edf5b537fcmr1561230wml.1.1679640149160;
        Thu, 23 Mar 2023 23:42:29 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c378e00b003ed2276cd0dsm3910041wmr.38.2023.03.23.23.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:42:28 -0700 (PDT)
Date:   Fri, 24 Mar 2023 02:42:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
Message-ID: <20230324024155-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
 <20230324013805-mutt-send-email-mst@kernel.org>
 <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:32:40PM +0800, Jason Wang wrote:
> On Fri, Mar 24, 2023 at 1:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 11:41:12AM +0800, Jason Wang wrote:
> > > On Thu, Mar 23, 2023 at 4:01 PM 黄杰 <huangjie.albert@bytedance.com> wrote:
> > > >
> > > > Jason Wang <jasowang@redhat.com> 于2023年3月22日周三 10:37写道：
> > > > >
> > > > > On Tue, Mar 21, 2023 at 5:00 PM Albert Huang
> > > > > <huangjie.albert@bytedance.com> wrote:
> > > > > >
> > > > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > > >
> > > > > > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > >
> > > > > > if we disable the napi_tx. when we triger a tx interrupt, the
> > > > >
> > > > > typo should be "trigger"
> > > > >
> > > >
> > > > OK, thanks for this. I will correct it in the next version
> > > >
> > > > > > vq->event_triggered will be set to true. It will no longer be
> > > > > > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > > > > > or virtqueue_enable_cb_prepare
> > > > > >
> > > > > > if we disable the napi_tx, It will only be called when the tx ring
> > > > > > buffer is relatively small:
> > > > > > virtio_net->start_xmit:
> > > > > >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > > >                 netif_stop_subqueue(dev, qnum);
> > > > > >                 if (!use_napi &&
> > > > > >                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > > > >                         /* More just got used, free them then recheck. */
> > > > > >                         free_old_xmit_skbs(sq, false);
> > > > > >                         if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > > > >                                 netif_start_subqueue(dev, qnum);
> > > > > >                                 virtqueue_disable_cb(sq->vq);
> > > > > >                         }
> > > > >
> > > > > The code example here is out of date, make sure your tree has this:
> > > >
> > > > also, I will correct it in the next version，this is from kernel 5.15.
> > > >
> > > > >
> > > > > commit d71ebe8114b4bf622804b810f5e274069060a174
> > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > Date:   Tue Jan 17 11:47:07 2023 +0800
> > > > >
> > > > >     virtio-net: correctly enable callback during start_xmit
> > > > >
> > > > > >                 }
> > > > > >         }
> > > > > > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > > > every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> > > > >
> > > > > Can you please post how to test with the performance numbers?
> > > > >
> > > >
> > > > iperf3 tcp stream:
> > > > vm1 -----------------> vm2
> > > > vm2 just receive tcp data stream from vm1, and send the ack to vm1,
> > > > there are so
> > > > many tx interruptions  in vm2.
> > > >
> > > > but without event_triggered there are just a few tx interruptions.
> > > >
> > > > > >
> > > > > > if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> > > > > > or vq->packed.vring.driver->off_wrap
> > > > > >
> > > > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 307e139cb11d..f486cccadbeb 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > > > >         /* If we expect an interrupt for the next entry, tell host
> > > > > >          * by writing event index and flush out the write before
> > > > > >          * the read in the next get_buf call. */
> > > > > > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > > > > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> > > > > > +                       && (vq->event_triggered == false))
> > > > >
> > > > > I'm not sure this can work, when event_triggered is true it means
> > > > > we've got an interrupt, in this case if we want another interrupt for
> > > > > the next entry, we should update used_event otherwise we will lose
> > > > > that interrupt?
> > > > >
> > > > > Thanks
> > > >
> > > > Normally, if we receive an interrupt, we should disable the interrupt
> > > > in the interrupt callback handler.
> > >
> > > So the problem is:
> > >
> > > 1) event_triggered was set to true in vring_interrupt()
> > >
> > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > then it tries to publish new event
> >
> > Oh. Good point! I think when I wrote up
> > 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > I missed this corner case.
> >
> >
> >
> > > This makes me think about whether or not we really need
> > > event_triggered. The assumption in the virtqueue_disable_cb() seems
> > > wrong:
> > >
> > > /* If device triggered an event already it won't trigger one again:
> > >  * no need to disable.
> > >  */
> > > if (vq->event_triggered)
> > >                 return;
> > >
> > > This is wrong if there's no event index support.
> >
> >
> > I don't get it.  how does this get triggered?
> >
> > You are talking about device without event index?
> > Here's code from vring_interrupt():
> >
> >         /* Just a hint for performance: so it's ok that this can be racy! */
> >         if (vq->event)
> >                 vq->event_triggered = true;
> 
> But we have the following in virtqueue_disable_cb():
> 
>         /* If device triggered an event already it won't trigger one again:
>          * no need to disable.
>          */
>         if (vq->event_triggered)
>                 return;
> 
>         if (vq->packed_ring)
>                 virtqueue_disable_cb_packed(_vq);
>         else
>                 virtqueue_disable_cb_split(_vq);
> 
> This means, without an event index, we don't set avail flags. So the
> interrupt is not disabled actually in this case.
> 
> Thanks

Only if event_triggered is true, which without event index it never is.

> >
> >
> >
> >
> > > And the
> > > event_triggered is somehow duplicated with the
> > > VRING_AVAIL_F_NO_INTERRUPT in the case of event index. The correct fix
> > > might be:
> > >
> > > 1) remove event_triggered
> > > 2) set VRING_AVAIL_F_NO_INTERRUPT in avail_flags_shadow in
> > > vring_interrrupt if event index is supported
> > >
> > > ?
> > >
> > > Thanks
> >
> > I am not sure all this is right and I'd rather we focused
> > performance/correctness and cleanups separately.
> >
> >
> >
> >
> > >
> > > > But because of the introduction of event_triggered, here,
> > > > virtqueue_get_buf_ctx_split  cannot be recognized
> > > > that the interrupt has been turned off.
> > > >
> > > > if we want  another interrupt for the next entry, We should probably
> > > > call virtqueue_enable_cb？
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > > >                                 &vring_used_event(&vq->split.vring),
> > > > > >                                 cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > > > > > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > > >          * by writing event index and flush out the write before
> > > > > >          * the read in the next get_buf call.
> > > > > >          */
> > > > > > -       if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > > > > > +       if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> > > > > > +                       && (vq->event_triggered == false))
> > > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > > >                                 &vq->packed.vring.driver->off_wrap,
> > > > > >                                 cpu_to_le16(vq->last_used_idx));
> > > > > > --
> > > > > > 2.31.1
> > > > > >
> > > > >
> > > >
> >

