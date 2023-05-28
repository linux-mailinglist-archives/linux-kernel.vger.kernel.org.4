Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DAC713897
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjE1H57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1H56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3AAE1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685260626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyBcNco0Gge4gbJKk143iR4E9OyphOPro7TAZfxT0Hc=;
        b=GitCVOIf9M101iFz+moo2DSL/oSqlZV7nHEg6Dpl9e4rkUaNATNmD5ca/J5C63OzuM/5Lb
        1jxg7jEQkd461Pexf7hzdwhHImNhVFYTx4Mim9mjd2qOX04gW9ItYTSXGnHs1xHOWzZPzX
        xaMyvN9dNakxx3AlDaR3uITctvHsWoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-68v24Vq1MO-Eh9p-H3COsQ-1; Sun, 28 May 2023 03:57:05 -0400
X-MC-Unique: 68v24Vq1MO-Eh9p-H3COsQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1283355f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685260623; x=1687852623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyBcNco0Gge4gbJKk143iR4E9OyphOPro7TAZfxT0Hc=;
        b=NHEfQ+FHKuw1fXZetEqZvm1HIT3oKT4NgoiUn8NitoSwofTL/inNut4ZKmNWGdh0WD
         dSGzvhaUC8AnKKQjZLiFW2rvmch3bl8jwLAn+lqOFw8Lrdm3VpozXdVgX77rEcSix7hJ
         FPkVgPmuTmYtc/rPgvEloJS83k9XGZnzN8qbbTs+6Lf/CHz4uvU9OP07OgINgx61G4vX
         Ng/oTbBAxuFI4Hztj13MzF8+48q/HIqggP5ysw+q9jGA5rLgvRnk3xZrnQHHf5SvylI0
         HHe1RP8iy6SRzPIfCYqVMoC/eEnuFueYHScVtbADCodxUyaF2T0ziZS79B19ps69BeZH
         d9CQ==
X-Gm-Message-State: AC+VfDzM3twhkv9nnkjXHMGu/EEubfJERTxkrFFtCGekfu7kfUWz4KYu
        hR9MUl8y5Vcd8WbHNf1KxiLgeM1SLl9+d+fvozNfQM88/yscOYbfHW5fLwlsbMujI5QSsrcjcck
        7O+q2C4A6pj28Y+pQJK3XooYC/y1HlFcW
X-Received: by 2002:adf:e792:0:b0:2ef:b4a9:202f with SMTP id n18-20020adfe792000000b002efb4a9202fmr7016235wrm.69.1685260623374;
        Sun, 28 May 2023 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ767ZoQH/pG0ey6X7gF0Jmfrk6DqK79WVQkChFfUtJV6MOsypliJHSsmkZygA+OLw1Cb5+jbw==
X-Received: by 2002:adf:e792:0:b0:2ef:b4a9:202f with SMTP id n18-20020adfe792000000b002efb4a9202fmr7016219wrm.69.1685260622976;
        Sun, 28 May 2023 00:57:02 -0700 (PDT)
Received: from redhat.com ([2.52.146.27])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b00306344eaebfsm10100637wrt.28.2023.05.28.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 00:57:02 -0700 (PDT)
Date:   Sun, 28 May 2023 03:56:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: validate used buffer length
Message-ID: <20230528033037-mutt-send-email-mst@kernel.org>
References: <20230526063041.18359-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526063041.18359-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 02:30:41PM +0800, Jason Wang wrote:
> This patch validate

validates

> the used buffer length provided by the device
> before trying to use it.

before returning it to caller

> This is done by remembering the in buffer
> length in a dedicated array during virtqueue_add(), then we can fail
> the virtqueue_get_buf() when we find the device is trying to give us a
> used buffer length which is greater than we stored before.

than what we stored

> 
> This validation is disable

disabled

> by default via module parameter to unbreak
> some existing devices since some legacy devices are known to report
> buggy used length.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

First I'm not merging this without more data about
what is known to be broken and what is known to work well
in the commit log. And how exactly do things work if used length
is wrong?
Second what's wrong with dma_desc_extra that we already maintain?
Third motivation - it's part and parcel of the hardening effort yes?
I'd like to know the fate of VIRTIO_HARDEN_NOTIFICATION before
we do more hardening. If it's irrevocably broken let's rip it out?


> ---
> Changes since V4:
> - drop the flat for driver to suppress the check
> - validation is disabled by default
> - don't do validation for legacy device
> - rebase and support virtqueue resize
> ---
>  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 143f380baa1c..5b151605aaf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -15,6 +15,9 @@
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
>  
> +static bool force_used_validation = false;
> +module_param(force_used_validation, bool, 0444);
> +
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
>  #define BAD_RING(_vq, fmt, args...)				\
> @@ -105,6 +108,9 @@ struct vring_virtqueue_split {
>  	struct vring_desc_state_split *desc_state;
>  	struct vring_desc_extra *desc_extra;
>  
> +	/* Maximum in buffer length, NULL means no used validation */
> +	u32 *buflen;
> +
>  	/* DMA address and size information */
>  	dma_addr_t queue_dma_addr;
>  	size_t queue_size_in_bytes;
> @@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
>  	struct vring_desc_state_packed *desc_state;
>  	struct vring_desc_extra *desc_extra;
>  
> +	/* Maximum in buffer length, NULL means no used validation */
> +	u32 *buflen;
> +
>  	/* DMA address and size information */
>  	dma_addr_t ring_dma_addr;
>  	dma_addr_t driver_event_dma_addr;
> @@ -552,6 +561,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -635,6 +645,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -675,6 +686,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	else
>  		vq->split.desc_state[head].indir_desc = ctx;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->split.buflen)
> +		vq->split.buflen[head] = buflen;
> +
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> @@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (vq->split.buflen && unlikely(*len > vq->split.buflen[i])) {
> +		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
> +			*len, vq->split.buflen[i]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1085,10 +1105,25 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
>  			 vring_split->queue_dma_addr,
>  			 dma_dev);
>  
> +	kfree(vring_split->buflen);
>  	kfree(vring_split->desc_state);
>  	kfree(vring_split->desc_extra);
>  }
>  
> +static bool vring_needs_used_validation(const struct virtio_device *vdev)
> +{
> +	/*
> +	 * Several legacy devices are known to produce buggy used
> +	 * length. In order to let driver work, we won't validate used
> +	 * buffer length in this case.
> +	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> +		return false;
> +	if (force_used_validation)
> +		return true;
> +	return false;
> +}
> +
>  static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  				   struct virtio_device *vdev,
>  				   u32 num,
> @@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	vring_split->vring_align = vring_align;
>  	vring_split->may_reduce_num = may_reduce_num;
>  
> +	if (vring_needs_used_validation(vdev)) {
> +		vring_split->buflen =
> +			kmalloc_array(num, sizeof(*vring_split->buflen),
> +				      GFP_KERNEL);
> +		if (!vring_split->buflen)
> +			goto err_buflen;
> +	}
> +
>  	return 0;
> +
> +err_buflen:
> +	vring_free_split(vring_split, vdev, dma_dev);
> +	return -ENOMEM;
>  }
>  
>  static struct virtqueue *vring_create_virtqueue_split(
> @@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u32 buflen = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].last = id;
>  	vq->packed.desc_state[id].premapped = premapped;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->packed.buflen)
> +		vq->packed.buflen[id] = buflen;
> +
>  	vq->num_added += 1;
>  
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -1416,6 +1470,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  	int err;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -1498,6 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1518,6 +1575,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].last = prev;
>  	vq->packed.desc_state[id].premapped = premapped;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->packed.buflen)
> +		vq->packed.buflen[id] = buflen;
> +
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
>  	 * available before all subsequent descriptors comprising
> @@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (vq->packed.buflen && unlikely(*len > vq->packed.buflen[id])) {
> +		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
> +			*len, vq->packed.buflen[id]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> @@ -1937,6 +2003,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
>  				 vring_packed->device_event_dma_addr,
>  				 dma_dev);
>  
> +	kfree(vring_packed->buflen);
>  	kfree(vring_packed->desc_state);
>  	kfree(vring_packed->desc_extra);
>  }
> @@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  
>  	vring_packed->vring.num = num;
>  
> +	if (vring_needs_used_validation(vdev)) {
> +		vring_packed->buflen =
> +			kmalloc_array(num, sizeof(*vring_packed->buflen),
> +				      GFP_KERNEL);
> +		if (!vring_packed->buflen)
> +			goto err;
> +	}
> +
>  	return 0;
>  
>  err:
> -- 
> 2.25.1

