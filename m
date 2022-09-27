Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807E5ECE84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiI0Uaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiI0UaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527B52E40
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664310610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ONZGrKrq1sS5sx+hAdgkduCJ7jSA1Bg21aVIwPpM/M=;
        b=G3eldnUfNbLH+zCaZz9seRsPpQsMCNPVdyrTOOAdOuk+M7EvUOBphooDwEgsTEqN9EFhXk
        s4DHD8o846qN/2ytjMq60Lvigh8fjfBrEjx1qNtZv07COAOnKfae1hsyaZVcM7bPrHtIny
        4oth5LcbsvcKhi1Cb7Em3RHBOuyZv/Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-i_erefvhM2mEugcL21dlvQ-1; Tue, 27 Sep 2022 16:30:09 -0400
X-MC-Unique: i_erefvhM2mEugcL21dlvQ-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso6037043wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3ONZGrKrq1sS5sx+hAdgkduCJ7jSA1Bg21aVIwPpM/M=;
        b=AsxIXamYlEIPBx5AKBOVXiUYD8KzKf5oV0PuavQdT916gCBmC/b7nHXif0dIq+unGc
         /TD2fo5qEnL79K8VAuXzcIiCbmDUUcctK94KiBRUeM/AWixhtK/Sz25tT1QQDg8lLUQH
         MDzlVfRY6030y5vLluyBbksW5lBw2Qxn64EC4/THTeIDSWTA4W9ld9YFR57HPkRujnEM
         OSSRSehidrtRgAT7j1J3XQuBEFIdXu33KIkjlFds8uIZUq5EbFetCWTXM7ZTppfqHl1V
         UaWOjsMJw1CFfoxpJqOF3yJQregaf+LYvz0dKUgLAfRWzGJsyO+6qw4Jp6uasZDN7cBP
         MH2w==
X-Gm-Message-State: ACrzQf03IOznmq2de/eHXWVFlfYyDDLVwsHoHXRCIZ/ox9OcDNeq6jBa
        tIOsLx2QvrLausdv58ibLLrC4ufZe1z1duksieby3oBoYewMov4jSibzTgaRR5rbdo7o44jKtE9
        7pfzLoQMZNa23WhMYPZAlqzN0
X-Received: by 2002:adf:f543:0:b0:228:c692:127a with SMTP id j3-20020adff543000000b00228c692127amr18847102wrp.246.1664310606561;
        Tue, 27 Sep 2022 13:30:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM549zwnW5nDlpn3BeNyNzKinHd2eWShJ3HLCvV+21vbyOBZA6EZF6qJ/GBWosJuGDJpvq7SCQ==
X-Received: by 2002:adf:f543:0:b0:228:c692:127a with SMTP id j3-20020adff543000000b00228c692127amr18847092wrp.246.1664310606357;
        Tue, 27 Sep 2022 13:30:06 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id iw5-20020a05600c54c500b003b5054c6f87sm2612262wmb.21.2022.09.27.13.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:30:05 -0700 (PDT)
Date:   Tue, 27 Sep 2022 16:30:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq() call
Message-ID: <20220927162745-mutt-send-email-mst@kernel.org>
References: <20220926091130.9244-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926091130.9244-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 05:11:30AM -0400, Bo Liu wrote:
> It passes '_vq' to vring_free(), which still calls to_vvq()
> to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq() in hot path.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

What is the point of this change?

__vring_new_virtqueue returns struct virtqueue *, so vring_free
matches that. No?

> ---
>  drivers/virtio/virtio_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..d6d77bf58802 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -221,7 +221,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					       void (*callback)(struct virtqueue *),
>  					       const char *name);
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> -static void vring_free(struct virtqueue *_vq);
> +static void vring_free(struct vring_virtqueue *vq);
>  
>  /*
>   * Helpers.
> @@ -1140,7 +1140,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>  	if (err)
>  		goto err_state_extra;
>  
> -	vring_free(&vq->vq);
> +	vring_free(vq);
>  
>  	virtqueue_vring_init_split(&vring_split, vq);
>  
> @@ -2059,7 +2059,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>  	if (err)
>  		goto err_state_extra;
>  
> -	vring_free(&vq->vq);
> +	vring_free(vq);
>  
>  	virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
>  
> @@ -2649,10 +2649,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>  
> -static void vring_free(struct virtqueue *_vq)
> +static void vring_free(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (vq->we_own_ring) {
>  		if (vq->packed_ring) {
>  			vring_free_queue(vq->vq.vdev,
> @@ -2693,7 +2691,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  	list_del(&_vq->list);
>  	spin_unlock(&vq->vq.vdev->vqs_list_lock);
>  
> -	vring_free(_vq);
> +	vring_free(vq);
>  
>  	kfree(vq);
>  }
> -- 
> 2.27.0

