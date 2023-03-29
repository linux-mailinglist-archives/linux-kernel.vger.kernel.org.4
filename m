Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC66CEF91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC2Qhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Qhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD79E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680107808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldMAeFakoVxongrnXNG07Qemx9ue6UmllaaxOMmybkQ=;
        b=cVI51QotQMAOPNVLuZiOThk8TSBmCRchz5J/ED5AZZF3kItdNiVI+h7eCdVaMIQDck+OUB
        MY/2GHIGjK9eaGXbkc80UHV1l4csrUSMFdZenCsKQ1cTnHRPj7fepRnNchId5OS8kErOZd
        tUL6QJipt4nOYKxALP1dljyQF+bArEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-8StVgzusNfKMn6vZWc-NYg-1; Wed, 29 Mar 2023 12:36:47 -0400
X-MC-Unique: 8StVgzusNfKMn6vZWc-NYg-1
Received: by mail-wm1-f69.google.com with SMTP id i4-20020a05600c354400b003ef649aa8c7so6787774wmq.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldMAeFakoVxongrnXNG07Qemx9ue6UmllaaxOMmybkQ=;
        b=WLK/sCGGCwvBEkqTa8VfLHHQQJeTb4/qQVeySpgkL9ehDOvNCWVxLQ3jRWpdlEkCPQ
         C3avDgOk4dXUj5h4MrkkP51/2ZfJprCTRSmtyPWvLNU7FMBIxdAIY0IYpCqPIh6xXZDt
         jShLnp2aqjebFJSAkB2EiHInpYfXLtxBEP5aQGztpeboL5TtwtBF2dSjxFFDvtCS/bj/
         suJdhZ+jp5rlGDi+gU6Jnbl7k1pDD4Zq72oR2Gtb1SAsQj2b41m0pStGwOMtru9sNSvl
         D27H7Tf+AuO2MiiSXlLXPyufCMPYjz49cD6sGNGLtChKsbzjSYIcJsDj6+hoV5I9Txv7
         yKDg==
X-Gm-Message-State: AAQBX9ejFeNNeSJ8KPa+M2l2eJSlB2g1WDdFxKMwrV4bxSDtlRFFDci0
        qjCwvrv4XECHRSSiGKDlZ9lOvMu81fA6VDq9AJoDMkcb4X0qBaF0+z72ZRU51Ko8Rc36zM13AJR
        SQrqWgDoZgDBQp/Lo+QueVk+5
X-Received: by 2002:adf:decf:0:b0:2cf:f30f:cc04 with SMTP id i15-20020adfdecf000000b002cff30fcc04mr14240678wrn.27.1680107805854;
        Wed, 29 Mar 2023 09:36:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z5BstaP0SIWlL7B+yT9cBx93Rz7ef9lbximjW91GJq3IF02TSPgsvVmlwSCFY8rhw/kJXS8w==
X-Received: by 2002:adf:decf:0:b0:2cf:f30f:cc04 with SMTP id i15-20020adfdecf000000b002cff30fcc04mr14240665wrn.27.1680107805520;
        Wed, 29 Mar 2023 09:36:45 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d4b07000000b002c56af32e8csm30386163wrq.35.2023.03.29.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:36:45 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:36:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329123444-mutt-send-email-mst@kernel.org>
References: <20230329102300.61000-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329102300.61000-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:23:00PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This bring more interruptions.
> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix:
> update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to vq
> when we call virtqueue_disable_cb even the event_triggered is set to true.
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> v2->v3:
> -update the interrupt disable flag even with the event_triggered is set,
> -instead of checking whether event_triggered is set in
> -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
> -not called virtqueue_{enable/disable}_cb to miss notifications.
> 
> v3->v4:
> -remove change for
> -"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
> -in virtqueue_disable_cb_packed
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Patch is ok so I rewrote the commit log and applied.
Please do not add signed-off-by tags by others -
read up what this tag means.
I also rewrote your Signed-off-by to have your name
formatted same as in email - hope that is ok.


> ---
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..ec7ab8e04846 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>  
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		if (vq->event)
>  			/* TODO: this is a hack. Figure out a cleaner value to write. */
>  			vring_used_event(&vq->split.vring) = 0x0;
> @@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		vq->packed.vring.driver->flags =
>  			cpu_to_le16(vq->packed.event_flags_shadow);
>  	}
> @@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	/* If device triggered an event already it won't trigger one again:
> -	 * no need to disable.
> -	 */
> -	if (vq->event_triggered)
> -		return;
> -
>  	if (vq->packed_ring)
>  		virtqueue_disable_cb_packed(_vq);
>  	else
> -- 
> 2.20.1

