Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE96C3900
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCUSQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:16:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ADA8A7E;
        Tue, 21 Mar 2023 11:16:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 460FAFB;
        Tue, 21 Mar 2023 19:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679422564;
        bh=YYbBI+yZSSJbYGhSeo7clHqjJfv86VCoUJSEWpYXO+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=et96KRBewPZzizQfexOFCLJXkqb5wSeGgSv6hB9T2tVkzio8N0HVTy7cx7cQxPgeJ
         xkoMRqVvU70aL6Gb9D3BeLPHdljMgL/LuwnNWcLW5bf0+XFhvoWCKgy4EI5/1+occk
         4d/lA/Yw7mIY0BWH9k+99HYvgqDCoH4KUE2+nYE4=
Date:   Tue, 21 Mar 2023 20:16:10 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        jernel@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic
 allocated
Message-ID: <20230321181610.GE20234@pendragon.ideasonboard.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-3-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-3-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patch.

On Tue, Mar 21, 2023 at 11:28:49AM +0100, Benjamin Gaignard wrote:
> Instead of a static array change bufs to a dynamically allocated array.
> This will allow to store more video buffer if needed.
> Protect the array with a spinlock.

I think I asked in the review of v1 why we couldn't use the kernel
IDA/IDR APIs to allocate buffer IDs and register buffers, but I don't
think I've received a reply. Wouldn't it be better than rolling out our
own mechanism ?

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   |  8 +++
>  include/media/videobuf2-core.h                | 49 ++++++++++++++++---
>  2 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 79e90e338846..ae9d72f4d181 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -2452,6 +2452,13 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	mutex_init(&q->mmap_lock);
>  	init_waitqueue_head(&q->done_wq);
>  
> +	q->max_num_bufs = 32;
> +	q->bufs = kmalloc_array(q->max_num_bufs, sizeof(*q->bufs), GFP_KERNEL | __GFP_ZERO);
> +	if (!q->bufs)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&q->bufs_lock);
> +
>  	q->memory = VB2_MEMORY_UNKNOWN;
>  
>  	if (q->buf_struct_size == 0)
> @@ -2479,6 +2486,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	mutex_lock(&q->mmap_lock);
>  	__vb2_queue_free(q, q->num_buffers);
>  	mutex_unlock(&q->mmap_lock);
> +	kfree(q->bufs);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>  
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 5b1e3d801546..397dbf6e61e1 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -558,6 +558,8 @@ struct vb2_buf_ops {
>   * @dma_dir:	DMA mapping direction.
>   * @bufs:	videobuf2 buffer structures
>   * @num_buffers: number of allocated/used buffers
> + * @bufs_lock: lock to protect bufs access
> + * @max_num_bufs: max number of buffers storable in bufs
>   * @queued_list: list of buffers currently queued from userspace
>   * @queued_count: number of buffers queued and ready for streaming.
>   * @owned_by_drv_count: number of buffers owned by the driver
> @@ -619,8 +621,10 @@ struct vb2_queue {
>  	struct mutex			mmap_lock;
>  	unsigned int			memory;
>  	enum dma_data_direction		dma_dir;
> -	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
> +	struct vb2_buffer		**bufs;
>  	unsigned int			num_buffers;
> +	spinlock_t			bufs_lock;
> +	size_t				max_num_bufs;
>  
>  	struct list_head		queued_list;
>  	unsigned int			queued_count;
> @@ -1239,9 +1243,16 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>  static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  						unsigned int index)
>  {
> -	if (index < q->num_buffers)
> -		return q->bufs[index];
> -	return NULL;
> +	struct vb2_buffer *vb = NULL;
> +
> +	spin_lock(&q->bufs_lock);
> +
> +	if (index < q->max_num_bufs)
> +		vb = q->bufs[index];
> +
> +	spin_unlock(&q->bufs_lock);
> +
> +	return vb;
>  }
>  
>  /**
> @@ -1251,12 +1262,30 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>   */
>  static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>  {
> -	if (vb->index < VB2_MAX_FRAME) {
> +	bool ret = false;
> +
> +	spin_lock(&q->bufs_lock);
> +
> +	if (vb->index >= q->max_num_bufs) {
> +		struct vb2_buffer **tmp;
> +
> +		tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
> +		if (!tmp)
> +			goto realloc_failed;
> +
> +		q->max_num_bufs *= 2;
> +		q->bufs = tmp;
> +	}
> +
> +	if (vb->index < q->max_num_bufs) {
>  		q->bufs[vb->index] = vb;
> -		return true;
> +		ret = true;
>  	}
>  
> -	return false;
> +realloc_failed:
> +	spin_unlock(&q->bufs_lock);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -1266,8 +1295,12 @@ static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *
>   */
>  static inline void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>  {
> -	if (vb->index < VB2_MAX_FRAME)
> +	spin_lock(&q->bufs_lock);
> +
> +	if (vb->index < q->max_num_bufs)
>  		q->bufs[vb->index] = NULL;
> +
> +	spin_unlock(&q->bufs_lock);
>  }
>  
>  /*

-- 
Regards,

Laurent Pinchart
