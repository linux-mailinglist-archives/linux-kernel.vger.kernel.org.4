Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC26713811
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 08:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjE1G0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 02:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1G0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 02:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1963D8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685255128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHipMSXfUIdhSOH+8qGLOxioNKl7RNvsZumZazeEfOg=;
        b=Yde5E0i+AZLcpf8okGjZ6nJA8bCQFxUMxuXr/yir8ByT8M1jharWyAxmlyZlS051t3mala
        p2fIVL5HXAM63DrMWtrbeQGGQ7DmyxvdROnPUnvy06l7/9ud27GkHKLAkndwpsCe/kQBiC
        eQiMtJH7QDNaDyJggAB0VBsh0/XYukY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-82QQWJo3NmS0TKLiQ42rMw-1; Sun, 28 May 2023 02:25:27 -0400
X-MC-Unique: 82QQWJo3NmS0TKLiQ42rMw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f60f085cd2so8364195e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685255126; x=1687847126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHipMSXfUIdhSOH+8qGLOxioNKl7RNvsZumZazeEfOg=;
        b=MUdj3RdggbwJLjs3uhZ3qjj22LSOOJN7dpM2SllFvqO+OTNCWJpgcBske+6z86QX/D
         clIaqJSELMyoJyWSKR/TKRX4JCH7p2U8px0pK36lPbYlzJtcwvDw90SwBGbjEN+idUMK
         UJwziDjHKCA9BjBrtkIMhcY0v7s2UNTWYFIti7yncclliOtttelUKf6IHITnej0Jyoku
         0Difi5bKhseLderCV5XIyjj6cJTY0WRBvGfEeaFihB+ap3+XdgLes/neoN/eW8EUxPo0
         KDW3uGs0J9eWWYbQWdLHgnmiPe+YElTKABAmXejWULJ5REMuCGNXqzBT9F3cbDHeAVeN
         LJRQ==
X-Gm-Message-State: AC+VfDyS3qTyxy3gaH9/NzdxFb4jvaA1pNX2I5KO5hexWvqnAIBk7V+Y
        0WO+JKoE+UC0M19GCalo1uBp06yIhTTaj2e3HLUswHxd3oo8jC5kN0D5xN3G057BygeUztR1MzP
        G1UYdSpd8fkb5criyj7Xtb7Js
X-Received: by 2002:a5d:6690:0:b0:30a:e542:c5c9 with SMTP id l16-20020a5d6690000000b0030ae542c5c9mr3915870wru.24.1685255126196;
        Sat, 27 May 2023 23:25:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zXf8FKRnuiMacq3JFo2VMQNt26z0deMI/xaaBhsgbJfThXFXDGW6PlXgF+aQ6SUOij8zjog==
X-Received: by 2002:a5d:6690:0:b0:30a:e542:c5c9 with SMTP id l16-20020a5d6690000000b0030ae542c5c9mr3915862wru.24.1685255125858;
        Sat, 27 May 2023 23:25:25 -0700 (PDT)
Received: from redhat.com ([2.52.146.27])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d514a000000b00307b5376b2csm9843188wrt.90.2023.05.27.23.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 23:25:25 -0700 (PDT)
Date:   Sun, 28 May 2023 02:25:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 3/5] virtio_net: Add page pool fragmentation
 support
Message-ID: <20230528022057-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-3-liangchen.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526054621.18371-3-liangchen.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 01:46:19PM +0800, Liang Chen wrote:
> To further enhance performance, implement page pool fragmentation
> support and introduce a module parameter to enable or disable it.
> 
> In single-core vm testing environments, there is an additional performance
> gain observed in the normal path compared to the one packet per page
> approach.
>   Upstream codebase: 47.5 Gbits/sec
>   Upstream codebase with page pool: 50.2 Gbits/sec
>   Upstream codebase with page pool fragmentation support: 52.3 Gbits/sec
> 
> There is also some performance gain for XDP cpumap.
>   Upstream codebase: 1.38 Gbits/sec
>   Upstream codebase with page pool: 9.74 Gbits/sec
>   Upstream codebase with page pool fragmentation: 10.3 Gbits/sec
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

I think it's called fragmenting not fragmentation.


> ---
>  drivers/net/virtio_net.c | 72 ++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 99c0ca0c1781..ac40b8c66c59 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -32,7 +32,9 @@ module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>  
>  static bool page_pool_enabled;
> +static bool page_pool_frag;
>  module_param(page_pool_enabled, bool, 0400);
> +module_param(page_pool_frag, bool, 0400);
>  
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)

So here again same questions.

-when is this a net perf gain when does it have no effect?
-can be on by default
- can we get rid of the extra modes?


> @@ -909,23 +911,32 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  				       struct page *p,
>  				       int offset,
>  				       int page_off,
> -				       unsigned int *len)
> +				       unsigned int *len,
> +					   unsigned int *pp_frag_offset)
>  {
>  	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  	struct page *page;
> +	unsigned int pp_frag_offset_val;
>  
>  	if (page_off + *len + tailroom > PAGE_SIZE)
>  		return NULL;
>  
>  	if (rq->page_pool)
> -		page = page_pool_dev_alloc_pages(rq->page_pool);
> +		if (rq->page_pool->p.flags & PP_FLAG_PAGE_FRAG)
> +			page = page_pool_dev_alloc_frag(rq->page_pool, pp_frag_offset,
> +							PAGE_SIZE);
> +		else
> +			page = page_pool_dev_alloc_pages(rq->page_pool);
>  	else
>  		page = alloc_page(GFP_ATOMIC);
>  
>  	if (!page)
>  		return NULL;
>  
> -	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
> +	pp_frag_offset_val = pp_frag_offset ? *pp_frag_offset : 0;
> +
> +	memcpy(page_address(page) + page_off + pp_frag_offset_val,
> +	       page_address(p) + offset, *len);
>  	page_off += *len;
>  
>  	while (--*num_buf) {
> @@ -948,7 +959,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  			goto err_buf;
>  		}
>  
> -		memcpy(page_address(page) + page_off,
> +		memcpy(page_address(page) + page_off + pp_frag_offset_val,
>  		       page_address(p) + off, buflen);
>  		page_off += buflen;
>  		virtnet_put_page(rq, p);
> @@ -1029,7 +1040,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		xdp_page = xdp_linearize_page(rq, &num_buf, page,
>  					      offset, header_offset,
> -					      &tlen);
> +					      &tlen, NULL);
>  		if (!xdp_page)
>  			goto err_xdp;
>  
> @@ -1323,6 +1334,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>  	struct page *xdp_page;
>  	unsigned int xdp_room;
> +	unsigned int page_frag_offset = 0;
>  
>  	/* Transient failure which in theory could occur if
>  	 * in-flight packets from before XDP was enabled reach
> @@ -1356,7 +1368,8 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  		xdp_page = xdp_linearize_page(rq, num_buf,
>  					      *page, offset,
>  					      VIRTIO_XDP_HEADROOM,
> -					      len);
> +					      len,
> +						  &page_frag_offset);
>  		if (!xdp_page)
>  			return NULL;
>  	} else {
> @@ -1366,14 +1379,19 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  			return NULL;
>  
>  		if (rq->page_pool)
> -			xdp_page = page_pool_dev_alloc_pages(rq->page_pool);
> +			if (rq->page_pool->p.flags & PP_FLAG_PAGE_FRAG)
> +				xdp_page = page_pool_dev_alloc_frag(rq->page_pool,
> +								    &page_frag_offset, PAGE_SIZE);
> +			else
> +				xdp_page = page_pool_dev_alloc_pages(rq->page_pool);
>  		else
>  			xdp_page = alloc_page(GFP_ATOMIC);
> +
>  		if (!xdp_page)
>  			return NULL;
>  
> -		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
> -		       page_address(*page) + offset, *len);
> +		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM +
> +				page_frag_offset, page_address(*page) + offset, *len);
>  	}
>  
>  	*frame_sz = PAGE_SIZE;
> @@ -1382,7 +1400,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  
>  	*page = xdp_page;
>  
> -	return page_address(*page) + VIRTIO_XDP_HEADROOM;
> +	return page_address(*page) + VIRTIO_XDP_HEADROOM + page_frag_offset;
>  }
>  
>  static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
> @@ -1762,6 +1780,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	void *ctx;
>  	int err;
>  	unsigned int len, hole;
> +	unsigned int pp_frag_offset;
>  
>  	/* Extra tailroom is needed to satisfy XDP's assumption. This
>  	 * means rx frags coalescing won't work, but consider we've
> @@ -1769,13 +1788,29 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  	if (rq->page_pool) {
> -		struct page *page;
> +		if (rq->page_pool->p.flags & PP_FLAG_PAGE_FRAG) {
> +			if (unlikely(!page_pool_dev_alloc_frag(rq->page_pool,
> +							       &pp_frag_offset, len + room)))
> +				return -ENOMEM;
> +			buf = (char *)page_address(rq->page_pool->frag_page) +
> +				pp_frag_offset;
> +			buf += headroom; /* advance address leaving hole at front of pkt */
> +			hole = (PAGE_SIZE << rq->page_pool->p.order)
> +				- rq->page_pool->frag_offset;
> +			if (hole < len + room) {
> +				if (!headroom)
> +					len += hole;
> +				rq->page_pool->frag_offset += hole;
> +			}
> +		} else {
> +			struct page *page;
>  
> -		page = page_pool_dev_alloc_pages(rq->page_pool);
> -		if (unlikely(!page))
> -			return -ENOMEM;
> -		buf = (char *)page_address(page);
> -		buf += headroom; /* advance address leaving hole at front of pkt */
> +			page = page_pool_dev_alloc_pages(rq->page_pool);
> +			if (unlikely(!page))
> +				return -ENOMEM;
> +			buf = (char *)page_address(page);
> +			buf += headroom; /* advance address leaving hole at front of pkt */
> +		}
>  	} else {
>  		if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>  			return -ENOMEM;
> @@ -3800,13 +3835,16 @@ static void virtnet_alloc_page_pool(struct receive_queue *rq)
>  	struct virtio_device *vdev = rq->vq->vdev;
>  
>  	struct page_pool_params pp_params = {
> -		.order = 0,
> +		.order = page_pool_frag ? SKB_FRAG_PAGE_ORDER : 0,
>  		.pool_size = rq->vq->num_max,
>  		.nid = dev_to_node(vdev->dev.parent),
>  		.dev = vdev->dev.parent,
>  		.offset = 0,
>  	};
>  
> +	if (page_pool_frag)
> +		pp_params.flags |= PP_FLAG_PAGE_FRAG;
> +
>  	rq->page_pool = page_pool_create(&pp_params);
>  	if (IS_ERR(rq->page_pool)) {
>  		dev_warn(&vdev->dev, "page pool creation failed: %ld\n",
> -- 
> 2.31.1

