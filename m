Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CDF6CD1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjC2Fna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjC2Fn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C799C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680068560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fxm8qRZte/FTaGyF5RaotQwgYQ+JMEbj0EH5BzdfLDU=;
        b=K3NmSW7vaA9yy3knX92J/5EYGRp/NgGxBAosa+m4J1lyn/D7A9YPBMDD5SEfWdjYkw+IKS
        k+kODPztAUD+EwWxBOc+gL6tAhTzRGRLhhq3gbLX+SjPkKZRd19wMHqyLCLdcmYH/N8VWd
        otaPqcJpTvNNF7kD7aRy5TQAtjOb8xY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-bIRNkn-DOh-KvDhnXg31MQ-1; Wed, 29 Mar 2023 01:42:38 -0400
X-MC-Unique: bIRNkn-DOh-KvDhnXg31MQ-1
Received: by mail-wm1-f71.google.com with SMTP id k1-20020a05600c1c8100b003ee6dbceb81so7560422wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680068557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxm8qRZte/FTaGyF5RaotQwgYQ+JMEbj0EH5BzdfLDU=;
        b=wbRVQqPxZ6johgaVcy6uzeL9O6/cvA3mRapemmwgWpyr5/3g0tIdT9uY7WkL2gOorx
         hUV6T3Dqw3LK5quXGhWE+GyQj4IuZV9fSOBLDc7xQmRdj+HgO695qj408VAZLzyOssJ+
         H/waBZx4ka713gMIJ0Mb3CgAm1eLSFkuBz0GqEGdW0h21ZFkGFLwYAmnet/R18UzKFaD
         XwNTv2CWHmtNct/bRO9+w9X+2TTaSWSaxXhRUA0RoLmbEE8DclCb++eTDSm4XhOz0Tn9
         mHPzDBwj3Yujcrgkr+z2mR0ZP/OqgWsZlkMjRanQhM0pynXa54Rxo+sloCRYAQn65jgd
         w0zQ==
X-Gm-Message-State: AAQBX9dFRh3dlUgVZXR1KyO7xWES/m8mKXCQDGLxQTlIPe5jlJvr/FfM
        Vkl6+rxtlKoPkL6JyXR1T+t/b0zPCZXpyV68fzR3MeVNWd3qL18Jd4bpkKBBPV6TGKtUoa2Hruz
        3NRyFRsU3VtOR8XTpbCeENRze
X-Received: by 2002:adf:e90c:0:b0:2cf:eeae:88c3 with SMTP id f12-20020adfe90c000000b002cfeeae88c3mr14980752wrm.32.1680068557480;
        Tue, 28 Mar 2023 22:42:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350YX1BcLbWkoq8DoA9CqaJNgzwsN1t/seldtwaG8EyIJMgkXoQZImhX+zijkO/qOncCrFsq11w==
X-Received: by 2002:adf:e90c:0:b0:2cf:eeae:88c3 with SMTP id f12-20020adfe90c000000b002cfeeae88c3mr14980744wrm.32.1680068557142;
        Tue, 28 Mar 2023 22:42:37 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b002dfca33ba36sm7714042wru.8.2023.03.28.22.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:42:36 -0700 (PDT)
Date:   Wed, 29 Mar 2023 01:42:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
Message-ID: <20230329013722-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:39:59AM +0800, Jason Wang wrote:
> On Tue, Mar 28, 2023 at 11:09 AM 黄杰 <huangjie.albert@bytedance.com> wrote:
> >
> > Jason Wang <jasowang@redhat.com> 于2023年3月28日周二 10:59写道：
> > >
> > > On Tue, Mar 28, 2023 at 10:13 AM Dominique Martinet
> > > <asmadeus@codewreck.org> wrote:
> > > >
> > > > Hi Michael, Albert,
> > > >
> > > > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > > > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> > > > > the vq->event_triggered will be set to true. It will no longer be set to
> > > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > > virtqueue_enable_cb_prepare.
> > > >
> > > > This patch (commited as 35395770f803 ("virtio_ring: don't update event
> > > > idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> > > > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org
> > > >
> > > > I've just hit had a look at recent patches[1] and reverted this to test
> > > > and I can mount again, so I'm pretty sure this is the culprit, but I
> > > > didn't look at the content at all yet so cannot advise further.
> > > > It might very well be that we need some extra handling for 9p
> > > > specifically that can be added separately if required.
> > > >
> > > > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virtio/
> > > >
> > > >
> > > > This can be reproduced with a simple mount, run qemu with some -virtfs
> > > > argument and `mount -t 9p -o debug=65535 tag mountpoint` will hang after
> > > > these messages:
> > > > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > > > 9pnet: -- p9_virtio_request (83): virtio request kicked
> > > >
> > > > So I suspect we're just not getting a callback.
> > >
> > > I think so. The patch assumes the driver will call
> > > virtqueue_disable/enable_cb() which is not the case of the 9p driver.
> > >
> > > So after the first interrupt, event_triggered will be set to true forever.
> > >
> > > Thanks
> > >
> >
> > Hi: Wang
> >
> > Yes,  This patch assumes that all virtio-related drivers will call
> > virtqueue_disable/enable_cb().
> > Thank you for raising this issue.
> >
> > It seems that napi_tx is only related to virtue_net. I'm thinking if
> > we need to refactor
> > napi_tx instead of implementing it inside virtio_ring.
> 
> We can hear from others.
> 
> I think it's better not to workaround virtio_ring issues in a specific
> driver. It might just add more hacks. We should correctly set
> VRING_AVAIL_F_NO_INTERRUPT,
> 
> Do you think the following might work (not even a compile test)?


ok but:

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 41144b5246a8..12f4efb6dc54 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -852,16 +852,16 @@ static void virtqueue_disable_cb_split(struct
> virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
> -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> -               vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -               if (vq->event)
> -                       /* TODO: this is a hack. Figure out a cleaner
> value to write. */
> -                       vring_used_event(&vq->split.vring) = 0x0;
> -               else
> -                       vq->split.vring.avail->flags =
> -                               cpu_to_virtio16(_vq->vdev,
> -                                               vq->split.avail_flags_shadow);
> -       }
> +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +               vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +
> +       if (vq->event && !vq->event_triggered)
> +               /* TODO: this is a hack. Figure out a cleaner value to write. */
> +               vring_used_event(&vq->split.vring) = 0x0;
> +       else
> +               vq->split.vring.avail->flags =
> +                       cpu_to_virtio16(_vq->vdev,
> +                                       vq->split.avail_flags_shadow);
>  }
> 
>  static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
> @@ -1697,8 +1697,10 @@ static void virtqueue_disable_cb_packed(struct
> virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
> -       if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
> +       if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DISABLE))
>                 vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> +
> +       if (vq->event_triggered)

I don't get this one. if event_triggered why do you still want to
write into driver flags? it won't trigger again anytime soon.

>                 vq->packed.vring.driver->flags =
>                         cpu_to_le16(vq->packed.event_flags_shadow);
>         }
> @@ -2330,12 +2332,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
> -       /* If device triggered an event already it won't trigger one again:
> -        * no need to disable.
> -        */
> -       if (vq->event_triggered)
> -               return;
> -
>         if (vq->packed_ring)
>                 virtqueue_disable_cb_packed(_vq);
>         else
> 
> Thanks

I think I prefer Huang Albert's other patch - are you ok with it?

> >
> > Thanks
> >
> > > >
> > > >
> > > > I'll have a closer look after work, but any advice meanwhile will be
> > > > appreciated!
> > > > (I'm sure Luis would also like a temporary drop from -next until
> > > > this is figured out, but I'll leave this up to you)
> > > >
> > > >
> > > > >
> > > > > If we disable the napi_tx, it will only be called when the tx ring
> > > > > buffer is relatively small.
> > > > >
> > > > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > > every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> > > > >
> > > > > To summarize:
> > > > > 1) event_triggered was set to true in vring_interrupt()
> > > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > > >    then it tries to publish new event
> > > > >
> > > > > To fix, if event_triggered is set to true, do not update
> > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > >
> > > > > Tested with iperf:
> > > > > iperf3 tcp stream:
> > > > > vm1 -----------------> vm2
> > > > > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > > > > there are many tx interrupts in vm2.
> > > > > but without event_triggered there are just a few tx interrupts.
> > > > >
> > > > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index cbeeea1b0439..1c36fa477966 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > > >       /* If we expect an interrupt for the next entry, tell host
> > > > >        * by writing event index and flush out the write before
> > > > >        * the read in the next get_buf call. */
> > > > > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > > > > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> > > > > +                  !vq->event_triggered))
> > > > >               virtio_store_mb(vq->weak_barriers,
> > > > >                               &vring_used_event(&vq->split.vring),
> > > > >                               cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > > > > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > >        * by writing event index and flush out the write before
> > > > >        * the read in the next get_buf call.
> > > > >        */
> > > > > -     if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > > > > +     if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> > > > > +                  !vq->event_triggered))
> > > > >               virtio_store_mb(vq->weak_barriers,
> > > > >                               &vq->packed.vring.driver->off_wrap,
> > > > >                               cpu_to_le16(vq->last_used_idx));
> > > >
> > >
> >

