Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169D6C7AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCXJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCXJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC14136FB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679648765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+GqAWmz15rP7oViR7OeAok2f70x1pUo5xW0EoL4Usg=;
        b=TOpLJMiFX+Lg0OC7HuCkF9Bz/OjfIYqDhkafqc9LVSBZmtIyuXtUKV/UEKdXjBCzVBOd81
        C2hGcvwXvqjmy2Pt9Y94Ws8XTGfCEqPM8q32OrWa2gZYlTFwUWwIr80pa/Lc9HsQZpBL4J
        wa3s6kGIpQVJtAzyZkLbs11TLzhE5hw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-46fVMd5wN1e6CNJ8x4S6Zw-1; Fri, 24 Mar 2023 05:06:03 -0400
X-MC-Unique: 46fVMd5wN1e6CNJ8x4S6Zw-1
Received: by mail-wm1-f70.google.com with SMTP id u6-20020a05600c19c600b003ed7cb98a8dso527630wmq.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679648762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+GqAWmz15rP7oViR7OeAok2f70x1pUo5xW0EoL4Usg=;
        b=BC2TmUfvhe1lT3+YOnwKZemys+lfsI+Vk2vEEw3v12ekZM8aVeRVZpitOkBIKk94ch
         43YRZPZ8x20MJ9SXb/qNaSM7yxz7sA8yUae/X9xpaJQpR1osMbtd3ewQV9W32jT2Ww16
         bn8XYnopaJTE2KIe0qfaJE5Bfu9O62gCmfONVkBCZ6XTgYtAdl1Z/UpCB988Ufvd+Ygn
         nbHjSLnDOEsevl2W9hU/4ubecJbYdQdhRZcZZF7Wm4gpNpcEX8ogxmopNV9fT+3xPfPH
         ixXHZFOVFa0WyjVutETvdS3E8nvvvqEHqbhAfuycTjw9ACCM/y8BXbSa/SBrI7SWQYlX
         eyig==
X-Gm-Message-State: AO0yUKWchijuLjLbmhUYJC73XRl/oSFf/tghXXoVF6Md+Q/ORKjdH0AE
        yx7uSUdTy1TAsmFMXMFDGCuoI4P6kqyhqm54Xi1YLp9iQmiceDhS5j0Y38kvZs7UnoRL5Jf+Kp/
        I7Tm9COcEEuWFitB287nOKsbP
X-Received: by 2002:a1c:4b13:0:b0:3ed:33a1:ba8e with SMTP id y19-20020a1c4b13000000b003ed33a1ba8emr1829894wma.1.1679648762355;
        Fri, 24 Mar 2023 02:06:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set+tRNl1cyqajon+Q3sDihZIdsLxHbeZ/aojwtRsQlg0XR4tPIAi4yaR5/T6R667BcDUr6RZPw==
X-Received: by 2002:a1c:4b13:0:b0:3ed:33a1:ba8e with SMTP id y19-20020a1c4b13000000b003ed33a1ba8emr1829875wma.1.1679648761970;
        Fri, 24 Mar 2023 02:06:01 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b002cfed482e9asm17997062wro.61.2023.03.24.02.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:06:01 -0700 (PDT)
Date:   Fri, 24 Mar 2023 05:05:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
Message-ID: <20230324050424-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
 <20230324013805-mutt-send-email-mst@kernel.org>
 <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
 <20230324024155-mutt-send-email-mst@kernel.org>
 <CACGkMEtBYVUrKFaMJYJrkrF3y2eu7r6ige6z+uRbHY_jotq80Q@mail.gmail.com>
 <20230324025937-mutt-send-email-mst@kernel.org>
 <CACGkMEtYAjR-Mc_K_8R1Ad7A+FmqJyK-w1z53FWBC0c2ZKHOmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtYAjR-Mc_K_8R1Ad7A+FmqJyK-w1z53FWBC0c2ZKHOmw@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 03:37:04PM +0800, Jason Wang wrote:
> On Fri, Mar 24, 2023 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 02:47:02PM +0800, Jason Wang wrote:
> > > On Fri, Mar 24, 2023 at 2:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Mar 24, 2023 at 02:32:40PM +0800, Jason Wang wrote:
> > > > > On Fri, Mar 24, 2023 at 1:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 24, 2023 at 11:41:12AM +0800, Jason Wang wrote:
> > > > > > > On Thu, Mar 23, 2023 at 4:01 PM 黄杰 <huangjie.albert@bytedance.com> wrote:
> > > > > > > >
> > > > > > > > Jason Wang <jasowang@redhat.com> 于2023年3月22日周三 10:37写道：
> > > > > > > > >
> > > > > > > > > On Tue, Mar 21, 2023 at 5:00 PM Albert Huang
> > > > > > > > > <huangjie.albert@bytedance.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > > > > > > >
> > > > > > > > > > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > > > > > >
> > > > > > > > > > if we disable the napi_tx. when we triger a tx interrupt, the
> > > > > > > > >
> > > > > > > > > typo should be "trigger"
> > > > > > > > >
> > > > > > > >
> > > > > > > > OK, thanks for this. I will correct it in the next version
> > > > > > > >
> > > > > > > > > > vq->event_triggered will be set to true. It will no longer be
> > > > > > > > > > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > > > > > > > > > or virtqueue_enable_cb_prepare
> > > > > > > > > >
> > > > > > > > > > if we disable the napi_tx, It will only be called when the tx ring
> > > > > > > > > > buffer is relatively small:
> > > > > > > > > > virtio_net->start_xmit:
> > > > > > > > > >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > > > > > > >                 netif_stop_subqueue(dev, qnum);
> > > > > > > > > >                 if (!use_napi &&
> > > > > > > > > >                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > > > > > > > >                         /* More just got used, free them then recheck. */
> > > > > > > > > >                         free_old_xmit_skbs(sq, false);
> > > > > > > > > >                         if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > > > > > > > >                                 netif_start_subqueue(dev, qnum);
> > > > > > > > > >                                 virtqueue_disable_cb(sq->vq);
> > > > > > > > > >                         }
> > > > > > > > >
> > > > > > > > > The code example here is out of date, make sure your tree has this:
> > > > > > > >
> > > > > > > > also, I will correct it in the next version，this is from kernel 5.15.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > commit d71ebe8114b4bf622804b810f5e274069060a174
> > > > > > > > > Author: Jason Wang <jasowang@redhat.com>
> > > > > > > > > Date:   Tue Jan 17 11:47:07 2023 +0800
> > > > > > > > >
> > > > > > > > >     virtio-net: correctly enable callback during start_xmit
> > > > > > > > >
> > > > > > > > > >                 }
> > > > > > > > > >         }
> > > > > > > > > > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > > > > > > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > > > > > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > > > > > > > every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> > > > > > > > >
> > > > > > > > > Can you please post how to test with the performance numbers?
> > > > > > > > >
> > > > > > > >
> > > > > > > > iperf3 tcp stream:
> > > > > > > > vm1 -----------------> vm2
> > > > > > > > vm2 just receive tcp data stream from vm1, and send the ack to vm1,
> > > > > > > > there are so
> > > > > > > > many tx interruptions  in vm2.
> > > > > > > >
> > > > > > > > but without event_triggered there are just a few tx interruptions.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> > > > > > > > > > or vq->packed.vring.driver->off_wrap
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > > index 307e139cb11d..f486cccadbeb 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > > > > > > > >         /* If we expect an interrupt for the next entry, tell host
> > > > > > > > > >          * by writing event index and flush out the write before
> > > > > > > > > >          * the read in the next get_buf call. */
> > > > > > > > > > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > > > > > > > > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> > > > > > > > > > +                       && (vq->event_triggered == false))
> > > > > > > > >
> > > > > > > > > I'm not sure this can work, when event_triggered is true it means
> > > > > > > > > we've got an interrupt, in this case if we want another interrupt for
> > > > > > > > > the next entry, we should update used_event otherwise we will lose
> > > > > > > > > that interrupt?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > Normally, if we receive an interrupt, we should disable the interrupt
> > > > > > > > in the interrupt callback handler.
> > > > > > >
> > > > > > > So the problem is:
> > > > > > >
> > > > > > > 1) event_triggered was set to true in vring_interrupt()
> > > > > > >
> > > > > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > > > > > VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > > > > > then it tries to publish new event
> > > > > >
> > > > > > Oh. Good point! I think when I wrote up
> > > > > > 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > > I missed this corner case.
> > > > > >
> > > > > >
> > > > > >
> > > > > > > This makes me think about whether or not we really need
> > > > > > > event_triggered. The assumption in the virtqueue_disable_cb() seems
> > > > > > > wrong:
> > > > > > >
> > > > > > > /* If device triggered an event already it won't trigger one again:
> > > > > > >  * no need to disable.
> > > > > > >  */
> > > > > > > if (vq->event_triggered)
> > > > > > >                 return;
> > > > > > >
> > > > > > > This is wrong if there's no event index support.
> > > > > >
> > > > > >
> > > > > > I don't get it.  how does this get triggered?
> > > > > >
> > > > > > You are talking about device without event index?
> > > > > > Here's code from vring_interrupt():
> > > > > >
> > > > > >         /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > >         if (vq->event)
> > > > > >                 vq->event_triggered = true;
> > > > >
> > > > > But we have the following in virtqueue_disable_cb():
> > > > >
> > > > >         /* If device triggered an event already it won't trigger one again:
> > > > >          * no need to disable.
> > > > >          */
> > > > >         if (vq->event_triggered)
> > > > >                 return;
> > > > >
> > > > >         if (vq->packed_ring)
> > > > >                 virtqueue_disable_cb_packed(_vq);
> > > > >         else
> > > > >                 virtqueue_disable_cb_split(_vq);
> > > > >
> > > > > This means, without an event index, we don't set avail flags. So the
> > > > > interrupt is not disabled actually in this case.
> > > > >
> > > > > Thanks
> > > >
> > > > Only if event_triggered is true, which without event index it never is.
> > >
> > > I'm not sure I will get here. I meant for example the commit
> > > suppresses the effort of skb_xmit_done():
> > >
> > > static void skb_xmit_done(struct virtqueue *vq)
> > > {
> > >         struct virtnet_info *vi = vq->vdev->priv;
> > >         struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> > >
> > >         /* Suppress further interrupts. */
> > >         virtqueue_disable_cb(vq);
> > >
> > > The virtqueue_disable_cb() doesn't disable further interrupts when the
> > > event index is not there.
> > >
> > > Thanks
> >
> > Check what can set event_triggered, you will see.
> 
> Set to truth by vring_interrupt()

vring_interrupt only sets it to true if vq->event is true


> Set to false by virtqueue_init(), virtqueue_enable_cb_prepare(),
> virtqueue_enable_cb_delayed()
> 
> Assuming NAPI TX is enabled and the device doesn't support event index.
> 
> 1) driver sends packets 1-10
> 2) the start_xmit() for the last packet will call
> virtqueue_enable_cb_delayed() which set event_triggered = false
> 3) 1st packet were sent, vring_interrupt set event_triggered = true
> 4) skb_xmit_done() won't disable virtqueue_disable_cb() in this case
> 5) so we will get the interrupts for 2nd to 10th packet
> 
> Anything I missed here?

3 does not happen if event index is off.

> Note the comment said it's used for event index:
> 
>         /* Hint for event idx: already triggered no need to disable. */
>         bool event_triggered;
> 
> I guess what you meant is that if we don't publish a new event, we
> will get at most 1 interrupt for everything $queue_size used buffers.
> But this is not the case without event index. Btw, it may supress the
> effort of:
> 
> vring_used_event(&vq->split.vring) = 0x0;
> 
> Thanks


Because it's not necessary then.

> >
> >
> >
> > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > And the
> > > > > > > event_triggered is somehow duplicated with the
> > > > > > > VRING_AVAIL_F_NO_INTERRUPT in the case of event index. The correct fix
> > > > > > > might be:
> > > > > > >
> > > > > > > 1) remove event_triggered
> > > > > > > 2) set VRING_AVAIL_F_NO_INTERRUPT in avail_flags_shadow in
> > > > > > > vring_interrrupt if event index is supported
> > > > > > >
> > > > > > > ?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > I am not sure all this is right and I'd rather we focused
> > > > > > performance/correctness and cleanups separately.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > But because of the introduction of event_triggered, here,
> > > > > > > > virtqueue_get_buf_ctx_split  cannot be recognized
> > > > > > > > that the interrupt has been turned off.
> > > > > > > >
> > > > > > > > if we want  another interrupt for the next entry, We should probably
> > > > > > > > call virtqueue_enable_cb？
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > > > > > > >                                 &vring_used_event(&vq->split.vring),
> > > > > > > > > >                                 cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > > > > > > > > > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > > > > > > >          * by writing event index and flush out the write before
> > > > > > > > > >          * the read in the next get_buf call.
> > > > > > > > > >          */
> > > > > > > > > > -       if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > > > > > > > > > +       if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> > > > > > > > > > +                       && (vq->event_triggered == false))
> > > > > > > > > >                 virtio_store_mb(vq->weak_barriers,
> > > > > > > > > >                                 &vq->packed.vring.driver->off_wrap,
> > > > > > > > > >                                 cpu_to_le16(vq->last_used_idx));
> > > > > > > > > > --
> > > > > > > > > > 2.31.1
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

