Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64252705928
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjEPUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820EB55AF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684270495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Og0TjupE/ZMtNNnlGmkzvRqoScVtlzRc45CzTiUu08g=;
        b=gCA2+XPWDn/L8QOcMfzSvu2hWWgxEhJHmJI6jqBcghvANY4hozJ+tR366QnqyaGlOhL4qE
        A3kJzEQvaFX6kMSHBy/8boBOVoJwkbPIAySJDzoEKNCBwzwmn2taDw7/BH3ARvHry5aEk3
        d5srN31dXOP5vt5wGtXrFpSKeYZQu2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-WexRuwg8MrWxnbbO3sgJGQ-1; Tue, 16 May 2023 16:54:47 -0400
X-MC-Unique: WexRuwg8MrWxnbbO3sgJGQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42ceb4a4fso123425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270484; x=1686862484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og0TjupE/ZMtNNnlGmkzvRqoScVtlzRc45CzTiUu08g=;
        b=l145XP/EWssAcW8Rz1/+ZQh1ejE8oC4UmqIMXCBk5LiQif+SFgN9kLfskkpX04xUxq
         /F1LOFndodpg7Ov+xiqMDPHu1rd4BhOvjzmU8usgITJGoRx5m/zAdeOAHsdsvLsgFfq6
         3AnOIAvsJsRVuBvq/Vna7hFE7XQ0apxR3x/GPsQyaIpH8E93Y41jq8zyHRtFHwx4bckx
         yC43U7yCGTEaZY+RiPvi5p3SW12B5dXzbaAAtMr1tfYT4Z/+csESPjmAhXW80tcVyvLa
         qw8x9TTHTfExntm1uBSRH00AkyayffaZVsvINQubBc/dop4Vadf0Hft3u67hwu7Ww2Fi
         GKCQ==
X-Gm-Message-State: AC+VfDwAM1H9Xx6VM5/zxGQQiPH0Fbsyjm3sD5eh2I7tGsIZEh9rDgvf
        GdVR/TGlh+D8FPTf3eIyXIAs2+iBGaJyBZDPQRhLxj7V1txAohyHXv43/Sq9ANjZbFALfi/4Vzj
        Hbrdc54mpQOAFXdtUb+Gqafnv
X-Received: by 2002:a7b:cb07:0:b0:3f1:7972:429d with SMTP id u7-20020a7bcb07000000b003f17972429dmr26839738wmj.18.1684270484100;
        Tue, 16 May 2023 13:54:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R9yvm854iVUUvoFgNHJv8grGlJ3OJzuwdg8sZzvpw6ibRSkIes59tngjTxXgLwdoqcq163A==
X-Received: by 2002:a7b:cb07:0:b0:3f1:7972:429d with SMTP id u7-20020a7bcb07000000b003f17972429dmr26839725wmj.18.1684270483729;
        Tue, 16 May 2023 13:54:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:3448:6dd9:9d1c:f4ae:94f0])
        by smtp.gmail.com with ESMTPSA id x7-20020a1c7c07000000b003f182a10106sm77032wmc.8.2023.05.16.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:54:43 -0700 (PDT)
Date:   Tue, 16 May 2023 16:54:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy
 waiting for cvq command
Message-ID: <20230516165043-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413064027.13267-3-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:40:27PM +0800, Jason Wang wrote:
> We used to busy waiting on the cvq command this tends to be
> problematic since there no way for to schedule another process which
> may serve for the control virtqueue. This might be the case when the
> control virtqueue is emulated by software. This patch switches to use
> completion to allow the CPU to sleep instead of busy waiting for the
> cvq command.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - use completion for simplicity
> - don't try to harden the CVQ command which requires more thought
> Changes since RFC:
> - break the device when timeout
> - get buffer manually since the virtio core check more_used() instead
> ---
>  drivers/net/virtio_net.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2e56bbf86894..d3eb8fd6c9dc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/completion.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -295,6 +296,8 @@ struct virtnet_info {
>  
>  	/* failover when STANDBY feature enabled */
>  	struct failover *failover;
> +
> +	struct completion completion;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -1709,6 +1712,13 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>  	return !oom;
>  }
>  
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +	struct virtnet_info *vi = cvq->vdev->priv;
> +
> +	complete(&vi->completion);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>  	struct virtnet_info *vi = rvq->vdev->priv;
> @@ -2169,12 +2179,8 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	if (unlikely(!virtqueue_kick(vi->cvq)))
>  		return vi->ctrl->status == VIRTIO_NET_OK;
>  
> -	/* Spin for a response, the kick causes an ioport write, trapping
> -	 * into the hypervisor, so the request should be handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> -		cpu_relax();
> +	wait_for_completion(&vi->completion);
> +	virtqueue_get_buf(vi->cvq, &tmp);
>  
>  	return vi->ctrl->status == VIRTIO_NET_OK;

This seems to break surprise removal and other
situations where vq gets broken since callbacks
aren't usually invoked then.


>  }
> @@ -3672,7 +3678,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>

There is a cost to this, in that we are burning an extra MSI vector
for the slow path cvq. if device has 3 vectors, suddenly we can't
allocate vectors for rx and tx, big problem.

So I'm afraid we need to pass a new flag that will share
the config changed interrupt and cvq.


  
> @@ -4122,6 +4128,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	init_completion(&vi->completion);
>  	enable_rx_mode_work(vi);
>  
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> -- 
> 2.25.1

