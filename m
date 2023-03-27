Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48446CA44B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjC0MoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0MoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A43583
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679921013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okew6DGjoVJwf2XramfWu6hiLwNPjgMAsie77LgA37k=;
        b=G8phJLBKC2DZq9v/hM8HFFkXodiEz4v9bWzTJ/ftNjFKmvXN2qPElUWpIFyQ0MrptenbON
        qFO7xarvxVLEJ2lNvkogPkm1OQFGRLQNJzHkEeR7w3GzoCORnL8Iz4QkhVdzSbTBUzG++B
        hafhTDD+rQQ1B6yAXtLOYjYjj5LC6s0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-I3xFbgGEOk6GEH1XNHi1ZA-1; Mon, 27 Mar 2023 08:43:32 -0400
X-MC-Unique: I3xFbgGEOk6GEH1XNHi1ZA-1
Received: by mail-wr1-f71.google.com with SMTP id s28-20020adfa29c000000b002d92bb99383so743407wra.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okew6DGjoVJwf2XramfWu6hiLwNPjgMAsie77LgA37k=;
        b=LLMwSslAfkJb3QPpD+1BtENEQ7sVw279EWdlegdE9ERJCAnftP0MTnXXH5aYb6w/F4
         8/HetcEVK4n7WJtH/XkOZkUHI+Ph5bqbXU7hRmogpx0vPjcHWGQhl2/RPlihrwe85EDD
         wP1+m5ZeIFOCLaEGPVTgFiGyCZIE1Tcei78rbVqK7YWbqaO1H9dJ/ebv37kYQPKl9IOj
         rj4mG5QfIr2kmzV0gJbykWnTA2qJSuS62XFh7Qle2183qAV4lJivc2U1V57dIAuhQNWe
         X6lHC0/6Wko+c8UTi+LQ0N/AES5MQLQNGJVbAaC8LkzS5LC6QvIChUGOICcADkkoyQLA
         WtBQ==
X-Gm-Message-State: AAQBX9dUtQURp/DWBfuSwdPi3crdpFJQGTBix/Ay7N7q16m+5u5+PxPG
        ZgH78YULlZGz33kSw1fvywjBRgx2D8fJlkmaRMFVzyKRJ9cx2ZuUeapH6wWZloLgPKKBEcZM53N
        eCVMdQ8lyY36d3Nd3NU4vwgkE
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id u5-20020a7bc045000000b003ef6fee8057mr1516951wmc.25.1679921011575;
        Mon, 27 Mar 2023 05:43:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8/SyqswJ4jRTerw8oSEMPhEZEW1SwIMQQ5198eUS5XRuV+yjc/mQikzsTZrLWNyeSaRuqQQ==
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id u5-20020a7bc045000000b003ef6fee8057mr1516940wmc.25.1679921011227;
        Mon, 27 Mar 2023 05:43:31 -0700 (PDT)
Received: from redhat.com ([2.52.153.142])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c384b00b003edf2ae2432sm8703889wmr.7.2023.03.27.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:43:30 -0700 (PDT)
Date:   Mon, 27 Mar 2023 08:43:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_ring: don't update event idx on get_buf
Message-ID: <20230327084248-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325105633.58592-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is the below same as what I posted or different? how?

On Sat, Mar 25, 2023 at 06:56:33PM +0800, Albert Huang wrote:
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
> every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix, if event_triggered is set to true, do not update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>

what is this exactly?

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..1c36fa477966 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
> -- 
> 2.37.0 (Apple Git-136)

