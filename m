Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3933E6CEF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjC2QfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjC2QfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37771FD2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680107672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J21PjNbB3wL39SRNMr0khHWXn9DhT2jbOucYrVV7PnY=;
        b=HvT4Blyhg8Jv8sehLgJUiG5ZQxDjZoFOtkuSznTUfXvwB+6AIV/xPEdp9B/YuQrtPWfmih
        saQmG74zyjcpTeN2cv80c1Ujv5L4j0EIlgJwiZDI2luv0NDVr8OkYadv2g6vBF5a7apA0L
        qidV4qBwb7xaMzU7+3+1L4u3DZ9qtB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-nGbpOsBxMV-RlKpPTUcLtA-1; Wed, 29 Mar 2023 12:34:31 -0400
X-MC-Unique: nGbpOsBxMV-RlKpPTUcLtA-1
Received: by mail-wm1-f71.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so8393835wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J21PjNbB3wL39SRNMr0khHWXn9DhT2jbOucYrVV7PnY=;
        b=IxwmpCJ1pSKQhpP2gargrMpuRnGmr8LzNOa+xXSMcTAc3dG6QylIGShvy4QFtA2CU6
         a8fesOlFQ/HF2HC8XBNolcksPRPcdwnI+TyswPDNHh1jJKxuNra/E7wMGCwxQDAnSydu
         iJEBBDoGwmSwqr+LYOebHNoTHNdcLz/no359VHVWVk2lgs2KLM2UvgP4/NLkugW2kgFZ
         5UpFRy/Nt16SDebdhZwXgpSA4DDsgosGKI1DaVv++ubBzbaarZkt7FexYLcyVwUSo+UK
         9p3mIePfcUuRFgzm7hKnbcror1yMGaci9NLlMbqv7JkxRqfB8p5stGxDE/n23t4Evjv9
         k9ZQ==
X-Gm-Message-State: AAQBX9diQltrjN7vYi6HEdp5XNyoyGHOlTY07eDmEFchX4dfKU36AhAN
        CqW01JjKe4+vRrhPgDYltXPDh5d4Irn9X7eBEbmGt71f52DM3WX+eSDoAHDQiUsV28W5mEiNRPV
        4na270KAmb95+iMQqD4Ec3vflL7zDzeCD
X-Received: by 2002:a05:600c:ac7:b0:3f0:3377:c15f with SMTP id c7-20020a05600c0ac700b003f03377c15fmr2693wmr.12.1680107670276;
        Wed, 29 Mar 2023 09:34:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJ+NqZ/9bbHJvcsdBSHlSULP/gNwRxDfKmQ4njSdZkyZVmGjK66paMtbAdF6uVk3QhwvsCrQ==
X-Received: by 2002:a05:600c:ac7:b0:3f0:3377:c15f with SMTP id c7-20020a05600c0ac700b003f03377c15fmr2677wmr.12.1680107669983;
        Wed, 29 Mar 2023 09:34:29 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bcb92000000b003ee58e8c971sm2723105wmi.14.2023.03.29.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:34:29 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:34:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329122852-mutt-send-email-mst@kernel.org>
References: <20230329102300.61000-1-huangjie.albert@bytedance.com>
 <1680090301.6450636-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680090301.6450636-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:45:01PM +0800, Xuan Zhuo wrote:
> On Wed, 29 Mar 2023 18:23:00 +0800, Albert Huang <huangjie.albert@bytedance.com> wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> > the vq->event_triggered will be set to true. It will no longer be set to
> > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > virtqueue_enable_cb_prepare.
> >
> > If we disable the napi_tx, it will only be called when the tx ring
> > buffer is relatively small.
> >
> > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
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
> > update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to vq
> > when we call virtqueue_disable_cb even the event_triggered is set to true.
> >
> > Tested with iperf:
> > iperf3 tcp stream:
> > vm1 -----------------> vm2
> > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > there are many tx interrupts in vm2.
> > but without event_triggered there are just a few tx interrupts.
> >
> > v2->v3:
> > -update the interrupt disable flag even with the event_triggered is set,
> > -instead of checking whether event_triggered is set in
> > -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
> > -not called virtqueue_{enable/disable}_cb to miss notifications.
> >
> > v3->v4:
> > -remove change for
> > -"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
> > -in virtqueue_disable_cb_packed
> >
> > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> 
> Hi Michael,
> 
> I want to know what the purpose of this patch("virtio: fix up virtio_disable_cb")
> is. I re-review this patch. I didn't understand what the purpose of this
> patches. Does it reduce one write to vring_used_event(&vq->split.vring) ?
> 
> Thanks.

Are you asking why I applied 8d622d21d248 ("virtio: fix up
virtio_disable_cb")?

It was a prerequisite to fixing interrupt storms we saw in the field previously.

See Message-ID: <20210413011508-mutt-send-email-mst@kernel.org>
for the bug report and Message-ID: <20210413054733.36363-1-mst@redhat.com>
for the original patchset fixing it.


> 
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cbeeea1b0439..ec7ab8e04846 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> >
> >  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> >  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> > +
> > +		/*
> > +		 * If device triggered an event already it won't trigger one again:
> > +		 * no need to disable.
> > +		 */
> > +		if (vq->event_triggered)
> > +			return;
> > +
> >  		if (vq->event)
> >  			/* TODO: this is a hack. Figure out a cleaner value to write. */
> >  			vring_used_event(&vq->split.vring) = 0x0;
> > @@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> >
> >  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
> >  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> > +
> > +		/*
> > +		 * If device triggered an event already it won't trigger one again:
> > +		 * no need to disable.
> > +		 */
> > +		if (vq->event_triggered)
> > +			return;
> > +
> >  		vq->packed.vring.driver->flags =
> >  			cpu_to_le16(vq->packed.event_flags_shadow);
> >  	}
> > @@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -	/* If device triggered an event already it won't trigger one again:
> > -	 * no need to disable.
> > -	 */
> > -	if (vq->event_triggered)
> > -		return;
> > -
> >  	if (vq->packed_ring)
> >  		virtqueue_disable_cb_packed(_vq);
> >  	else
> > --
> > 2.20.1
> >

