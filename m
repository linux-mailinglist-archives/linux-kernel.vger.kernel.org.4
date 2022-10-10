Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34735FA29A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJJRRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJJRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D6976542
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665422257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EAkHWJV5i1XmoybWMpHm1PpCVGOwPrjFpBbuDSPlj3U=;
        b=MkyM8Xuh+aZoGppES/A5FEvlBI7k3UrqmIg4LU8ZE5ZHLlT+wTvvPXU5P3/QlMDj3Q8TUt
        0fhlw8la5A6YS5fT7DQ1LLO7VfbfM8DwO8iTu+rIUkm1OvkfiOCYJNzjgWOX3ZHRt589VF
        4I36S00p0RXR2KB5FVcgqQ0trkkDIFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-HNUrfeAgPCOzd_tYeuvymg-1; Mon, 10 Oct 2022 13:17:36 -0400
X-MC-Unique: HNUrfeAgPCOzd_tYeuvymg-1
Received: by mail-wm1-f72.google.com with SMTP id b7-20020a05600c4e0700b003bde2d860d1so7266082wmq.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAkHWJV5i1XmoybWMpHm1PpCVGOwPrjFpBbuDSPlj3U=;
        b=6b51ZeGKTxGhw6b+W3X/H8wep8eUdz/4zfIDIIPxz77ueBEc1Lozl6mgD6DAWly6Le
         gVV9ukwl4uZo5hmfKZqoWxnR+zCet7ezQaQFr3ecw+bdx4TIvWB0tQopt+Zj3L7E11X/
         x8kG9IRVMmEM49C78yySDNy0RAfRd+gzqJxF200qDm2hZGwQzl406kQKxQ4cpk1kdhe6
         juAJxdOrXTPOXiyIYVrElWCuH2wmO0J0fgGoXkpYfwgjM9M+4BX13tP2lLrw8MLUH1dB
         Iehqf+DQObHsKYTRJeRkFb0njychQiMjXI4KyuJkgDZauRyUsglkwkMIQFgPvhCYx10C
         tUgg==
X-Gm-Message-State: ACrzQf09hCSK9y7FEw0EOoVHw0xyFgOIA/I1LExiEvhnkLGR5m9jnvLN
        u/cv1Ez/2YLThkykR/aAlda58Gsikoxlz8P3wAPA2h3qkDaPq7oKJyUZplCuS+64VfwjR7BBk03
        EG+gvh8ZC1047ncwERuyQ9LkS
X-Received: by 2002:a5d:47a6:0:b0:22e:7c73:feb2 with SMTP id 6-20020a5d47a6000000b0022e7c73feb2mr12117208wrb.715.1665422255074;
        Mon, 10 Oct 2022 10:17:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4pMbOL5Iwp6GXNIfNT4x8U3HJ5wmOn8CEMD/qC/+mMgXvo1QpQIRtd9FSIb027UG14KZk1NQ==
X-Received: by 2002:a5d:47a6:0:b0:22e:7c73:feb2 with SMTP id 6-20020a5d47a6000000b0022e7c73feb2mr12117196wrb.715.1665422254860;
        Mon, 10 Oct 2022 10:17:34 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c151500b003c6b9749505sm2344218wmg.30.2022.10.10.10.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:17:34 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:17:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: split: Operators use unified style
Message-ID: <20221007091431-mutt-send-email-mst@kernel.org>
References: <20220926022202.1516-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926022202.1516-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 10:22:02PM -0400, Deming Wang wrote:
> The operators of vring_alloc_queue_split should use the unified style.Add
> space for the '|' ,make it be looked more pretty.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Thanks for the patch!
Since this is about cosmetics let's make the patch look good:

Pls tweak the commit log. Space after . and , no space before ,
unified style -> kernel coding style
make it be looked more pretty -> make it prettier.


> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..7510163565b7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1074,7 +1074,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	if (!queue) {
>  		/* Try to get a single page. You are my only hope! */
>  		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> -					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
> +					  &dma_addr, GFP_KERNEL | __GFP_ZERO);
>  	}
>  	if (!queue)
>  		return -ENOMEM;
> -- 
> 2.27.0

