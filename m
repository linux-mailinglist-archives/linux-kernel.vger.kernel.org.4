Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515DD6C778E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjCXGAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjCXGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F8272C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679637594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vt1J17FUEsFz1bQOp6BzRT5G+PK9gWtwL+MNcCXC+I8=;
        b=DbG1ANvCgNs+1I6ytVXRiWXhhIwxinzLvPT24B20Tr/h/mBXVKy6ujL8G/KZgA8/DJNUTK
        bZsgaQYFREgX7Q3mlhzXr4MqVips6vIfmycyxbhabS61JYU6bX7L/+G22xRekwJ9RVYISf
        akRT9swgAxRjdv4UOujEmMXpa2lS5OY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-JjT0p0y_OKaaTT7EWsDS7g-1; Fri, 24 Mar 2023 01:59:52 -0400
X-MC-Unique: JjT0p0y_OKaaTT7EWsDS7g-1
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so1555212edj.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679637591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt1J17FUEsFz1bQOp6BzRT5G+PK9gWtwL+MNcCXC+I8=;
        b=KUZiKxayvDHND40kOtacHJOSjwxUbTPUpSE7zFxEBttPykL7ezCEzOZPp9HW8PnWlS
         4DyNn4VCczExgSGKSgqzfRzA/IxvAV2KEKJhl91XkS5BMlZLDes/4URbP5HoywsuDZ1d
         mpZ8LyeTYYiSV4+fAghmx0jfICRM8I9LGPdPgCRLCkFFouqmeR7fB2MClNbZpFSEoBaR
         rS4YoNNPtrDEa4nbuLA/ujoKz9AmBln3Jl3taYjNpTLl80Not4lqPWyK4YEMcJu/U/iV
         Sev1JXsYw/c17OBjPDh+oDTtO/AYF9xUQ2ivue0DoMiStuEOWsltnjVXz30dj5UmkSOR
         GMfQ==
X-Gm-Message-State: AAQBX9dWIyAvcp8rEsk65YnkGJ7+W38yGkfgAVMmTQfOyYloNvl4f6d0
        n1QLc6NkE21ZLpCwFtUGHQy494TtYrg616n274722ZL1nIZfwfH5HtUlAdAljuzoMgKvrwv1plg
        iuaLdzF/ESBWTfkxlrvKF9Tfy
X-Received: by 2002:aa7:c547:0:b0:4f9:ed17:3bec with SMTP id s7-20020aa7c547000000b004f9ed173becmr1975076edr.20.1679637591414;
        Thu, 23 Mar 2023 22:59:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y9MxlyAuE5jXcAqgE+Rz2mYEFwxEIstOcZTAZDAO6WUG2qcJgTq7hr9YRQ/bj1u1Np+JzcFw==
X-Received: by 2002:aa7:c547:0:b0:4f9:ed17:3bec with SMTP id s7-20020aa7c547000000b004f9ed173becmr1975053edr.20.1679637591106;
        Thu, 23 Mar 2023 22:59:51 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b00501d2f10d19sm5720060edb.20.2023.03.23.22.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:59:50 -0700 (PDT)
Date:   Fri, 24 Mar 2023 01:59:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
Message-ID: <20230324013805-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:41:12AM +0800, Jason Wang wrote:
> On Thu, Mar 23, 2023 at 4:01 PM 黄杰 <huangjie.albert@bytedance.com> wrote:
> >
> > Jason Wang <jasowang@redhat.com> 于2023年3月22日周三 10:37写道：
> > >
> > > On Tue, Mar 21, 2023 at 5:00 PM Albert Huang
> > > <huangjie.albert@bytedance.com> wrote:
> > > >
> > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > >
> > > > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > >
> > > > if we disable the napi_tx. when we triger a tx interrupt, the
> > >
> > > typo should be "trigger"
> > >
> >
> > OK, thanks for this. I will correct it in the next version
> >
> > > > vq->event_triggered will be set to true. It will no longer be
> > > > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > > > or virtqueue_enable_cb_prepare
> > > >
> > > > if we disable the napi_tx, It will only be called when the tx ring
> > > > buffer is relatively small:
> > > > virtio_net->start_xmit:
> > > >         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > >                 netif_stop_subqueue(dev, qnum);
> > > >                 if (!use_napi &&
> > > >                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > >                         /* More just got used, free them then recheck. */
> > > >                         free_old_xmit_skbs(sq, false);
> > > >                         if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > >                                 netif_start_subqueue(dev, qnum);
> > > >                                 virtqueue_disable_cb(sq->vq);
> > > >                         }
> > >
> > > The code example here is out of date, make sure your tree has this:
> >
> > also, I will correct it in the next version，this is from kernel 5.15.
> >
> > >
> > > commit d71ebe8114b4bf622804b810f5e274069060a174
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Tue Jan 17 11:47:07 2023 +0800
> > >
> > >     virtio-net: correctly enable callback during start_xmit
> > >
> > > >                 }
> > > >         }
> > > > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> > >
> > > Can you please post how to test with the performance numbers?
> > >
> >
> > iperf3 tcp stream:
> > vm1 -----------------> vm2
> > vm2 just receive tcp data stream from vm1, and send the ack to vm1,
> > there are so
> > many tx interruptions  in vm2.
> >
> > but without event_triggered there are just a few tx interruptions.
> >
> > > >
> > > > if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> > > > or vq->packed.vring.driver->off_wrap
> > > >
> > > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 307e139cb11d..f486cccadbeb 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > >         /* If we expect an interrupt for the next entry, tell host
> > > >          * by writing event index and flush out the write before
> > > >          * the read in the next get_buf call. */
> > > > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> > > > +                       && (vq->event_triggered == false))
> > >
> > > I'm not sure this can work, when event_triggered is true it means
> > > we've got an interrupt, in this case if we want another interrupt for
> > > the next entry, we should update used_event otherwise we will lose
> > > that interrupt?
> > >
> > > Thanks
> >
> > Normally, if we receive an interrupt, we should disable the interrupt
> > in the interrupt callback handler.
> 
> So the problem is:
> 
> 1) event_triggered was set to true in vring_interrupt()
>
> 2) after this nothing will happen for virtqueue_disable_cb() so
> VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> then it tries to publish new event

Oh. Good point! I think when I wrote up
8d622d21d248 ("virtio: fix up virtio_disable_cb")
I missed this corner case.



> This makes me think about whether or not we really need
> event_triggered. The assumption in the virtqueue_disable_cb() seems
> wrong:
> 
> /* If device triggered an event already it won't trigger one again:
>  * no need to disable.
>  */
> if (vq->event_triggered)
>                 return;
> 
> This is wrong if there's no event index support.


I don't get it.  how does this get triggered?

You are talking about device without event index?
Here's code from vring_interrupt():

        /* Just a hint for performance: so it's ok that this can be racy! */
        if (vq->event)
                vq->event_triggered = true;




> And the
> event_triggered is somehow duplicated with the
> VRING_AVAIL_F_NO_INTERRUPT in the case of event index. The correct fix
> might be:
> 
> 1) remove event_triggered
> 2) set VRING_AVAIL_F_NO_INTERRUPT in avail_flags_shadow in
> vring_interrrupt if event index is supported
> 
> ?
> 
> Thanks

I am not sure all this is right and I'd rather we focused
performance/correctness and cleanups separately.




> 
> > But because of the introduction of event_triggered, here,
> > virtqueue_get_buf_ctx_split  cannot be recognized
> > that the interrupt has been turned off.
> >
> > if we want  another interrupt for the next entry, We should probably
> > call virtqueue_enable_cb？
> >
> > Thanks
> >
> > >
> > > >                 virtio_store_mb(vq->weak_barriers,
> > > >                                 &vring_used_event(&vq->split.vring),
> > > >                                 cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > > > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > >          * by writing event index and flush out the write before
> > > >          * the read in the next get_buf call.
> > > >          */
> > > > -       if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > > > +       if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> > > > +                       && (vq->event_triggered == false))
> > > >                 virtio_store_mb(vq->weak_barriers,
> > > >                                 &vq->packed.vring.driver->off_wrap,
> > > >                                 cpu_to_le16(vq->last_used_idx));
> > > > --
> > > > 2.31.1
> > > >
> > >
> >

