Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F146B8029
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCMSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:14:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958275CEDE;
        Mon, 13 Mar 2023 11:14:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [89.244.118.114])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5D6B16FA;
        Mon, 13 Mar 2023 19:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678731284;
        bh=ECiuzkN+DQNQmLQ9FTJM9eiXiAf3Dhfgrx4QRUBTQag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp3tT8MEY1rg0ePG1lryXVLvQL0nDEttkrDEwbh9XQRRhQxYs/wPJoW700jfDUeCF
         qFrwMfZYGqpNq3oN/L5IQrZVh0/Sm2OnHOfg3vg1xaZFkPfRu9dY9YGq3jw/XRu87T
         J57mJg9x30wvyFq0EAMz4gQknKoQlaikH07FFnXs=
Date:   Mon, 13 Mar 2023 20:14:48 +0200
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
        jerbel@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [RFC 3/4] media: videobuf2: Use bitmap to manage vb2 index
Message-ID: <20230313181448.GD22646@pendragon.ideasonboard.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230313135916.862852-4-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patch.

On Mon, Mar 13, 2023 at 02:59:15PM +0100, Benjamin Gaignard wrote:
> Using a bitmap to get vb2 index will allow to avoid holes
> in the indexes when introducing DELETE_BUF ioctl.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 22 ++++++++++++++++++-
>  include/media/videobuf2-core.h                |  6 +++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 96597d339a07..3554811ec06a 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -397,6 +397,22 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>  		vb->skip_cache_sync_on_finish = 1;
>  }
>  
> +/*
> + * __vb2_get_index() - find a free index in the queue for vb2 buffer.
> + *
> + * Returns an index for vb2 buffer.
> + */
> +static int __vb2_get_index(struct vb2_queue *q)
> +{
> +	unsigned long index;
> +
> +	index = bitmap_find_next_zero_area(q->bmap, q->idx_max, 0, 1, 0);
> +	if (index > q->idx_max)
> +		dprintk(q, 1, "no index available for buffer\n");

Ignoring the error is scary. If we limited the total number of buffers
as proposed in the review of 2/4, the error wouldn't occur.

I'm also wondering if it wouldn't be better to use the IDA API to
allocate IDs, and possibly the IDR API as well to replace the list.

> +
> +	return index;
> +}
> +
>  /*
>   * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
>   * video buffer memory for all buffers/planes on the queue and initializes the
> @@ -423,7 +439,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  		vb->state = VB2_BUF_STATE_DEQUEUED;
>  		vb->vb2_queue = q;
>  		vb->num_planes = num_planes;
> -		vb->index = q->num_buffers + buffer;
> +		vb->index = __vb2_get_index(q);
>  		vb->type = q->type;
>  		vb->memory = memory;
>  		init_buffer_cache_hints(q, vb);
> @@ -2438,6 +2454,9 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	mutex_init(&q->mmap_lock);
>  	init_waitqueue_head(&q->done_wq);
>  
> +	q->idx_max = ALIGN(256, BITS_PER_LONG);
> +	q->bmap = bitmap_zalloc(q->idx_max, GFP_KERNEL);
> +
>  	q->memory = VB2_MEMORY_UNKNOWN;
>  
>  	if (q->buf_struct_size == 0)
> @@ -2465,6 +2484,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	mutex_lock(&q->mmap_lock);
>  	__vb2_queue_free(q, q->num_buffers);
>  	mutex_unlock(&q->mmap_lock);
> +	bitmap_free(q->bmap);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>  
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 47f1f35eb9cb..4fddc6ae9f20 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -561,6 +561,8 @@ struct vb2_buf_ops {
>   * @dma_dir:	DMA mapping direction.
>   * @allocated_bufs: list of buffer allocated for the queue.
>   * @num_buffers: number of allocated/used buffers
> + * @bmap: Bitmap of buffers index
> + * @idx_max: number of bits in bmap
>   * @queued_list: list of buffers currently queued from userspace
>   * @queued_count: number of buffers queued and ready for streaming.
>   * @owned_by_drv_count: number of buffers owned by the driver
> @@ -624,6 +626,8 @@ struct vb2_queue {
>  	enum dma_data_direction		dma_dir;
>  	struct list_head		allocated_bufs;
>  	unsigned int			num_buffers;
> +	unsigned long			*bmap;
> +	int				idx_max;
>  
>  	struct list_head		queued_list;
>  	unsigned int			queued_count;
> @@ -1259,6 +1263,7 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>  {
>  	list_add_tail(&vb->allocated_entry, &q->allocated_bufs);
> +	__set_bit(vb->index, q->bmap);
>  }
>  
>  /**
> @@ -1268,6 +1273,7 @@ static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static inline void vb2_del_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>  {
> +	__clear_bit(vb->index, q->bmap);
>  	list_del(&vb->allocated_entry);
>  }
>  

-- 
Regards,

Laurent Pinchart
