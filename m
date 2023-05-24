Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E970F4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjEXLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEXLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439B1A8;
        Wed, 24 May 2023 04:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AD1C63510;
        Wed, 24 May 2023 11:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA684C4339B;
        Wed, 24 May 2023 11:04:14 +0000 (UTC)
Message-ID: <6bbb7f81-76ed-6794-fc51-7ff09f921e1d@xs4all.nl>
Date:   Wed, 24 May 2023 13:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3,3/4] media: mediatek: vcodec: move core context from
 device to each instance
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230424060130.18395-1-yunfei.dong@mediatek.com>
 <20230424060130.18395-4-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230424060130.18395-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 08:01, Yunfei Dong wrote:
> There are so many lat buffer in core context list, some instances
> maybe be scheduled for a very long time. Moving the core context to
> each instance, it only be used to control lat buffer of each instance.
> And the core work queue of each instance is scheduled by system.

Building with patches 1-3 (but not patch 4/4!) breaks compilation. That can
be a problem if someone does a git bisect.

So I decided to drop this series for now, waiting for a v4.

Patch 3 should compile fine without patch 4, so please fix that.

Note that v4 should be on top of your hevc v7 series since that will be
merged to our staging tree by Friday.

Regards,

	Hans

> 
> Fixes: 2cfca6c1bf80 ("media: mediatek: vcodec: move lat_buf to the top of core list")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  1 -
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  2 -
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      |  4 +-
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  2 +-
>  .../platform/mediatek/vcodec/vdec_msg_queue.c | 53 +++++++------------
>  .../platform/mediatek/vcodec/vdec_msg_queue.h |  4 +-
>  6 files changed, 23 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 3755acc61d7d..d2543fb27ba7 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -310,7 +310,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>  	}
>  
>  	if (IS_VDEC_LAT_ARCH(dev->vdec_pdata->hw_arch)) {
> -		vdec_msg_queue_init_ctx(&dev->msg_queue_core_ctx, MTK_VDEC_CORE);
>  		dev->core_workqueue =
>  			alloc_ordered_workqueue("core-decoder",
>  						WQ_MEM_RECLAIM | WQ_FREEZABLE);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index 9acab54fd650..15d2cb171b89 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -461,7 +461,6 @@ struct mtk_vcodec_enc_pdata {
>   * @enc_capability: used to identify encode capability
>   *
>   * @core_workqueue: queue used for core hardware decode
> - * @msg_queue_core_ctx: msg queue context used for core workqueue
>   *
>   * @subdev_dev: subdev hardware device
>   * @subdev_prob_done: check whether all used hw device is prob done
> @@ -510,7 +509,6 @@ struct mtk_vcodec_dev {
>  	unsigned int enc_capability;
>  
>  	struct workqueue_struct *core_workqueue;
> -	struct vdec_msg_queue_ctx msg_queue_core_ctx;
>  
>  	void *subdev_dev[MTK_VDEC_HW_MAX];
>  	int (*subdev_prob_done)(struct mtk_vcodec_dev *vdec_dev);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> index 181cc52e0847..a7e8e3257b7f 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> @@ -672,7 +672,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  	if (IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability)) {
>  		memcpy(&share_info->h264_slice_params, &inst->vsi->h264_slice_params,
>  		       sizeof(share_info->h264_slice_params));
> -		vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
> +		vdec_msg_queue_qbuf(&inst->ctx->msg_queue.core_ctx, lat_buf);
>  	}
>  
>  	/* wait decoder done interrupt */
> @@ -698,7 +698,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  	if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability)) {
>  		memcpy(&share_info->h264_slice_params, &inst->vsi->h264_slice_params,
>  		       sizeof(share_info->h264_slice_params));
> -		vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
> +		vdec_msg_queue_qbuf(&inst->ctx->msg_queue.core_ctx, lat_buf);
>  	}
>  	mtk_vcodec_debug(inst, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->slice_dec_num,
>  			 inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.crc[2]);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index 6d981d7341d2..c2f90848f498 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -2119,7 +2119,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue,
>  				       vsi->trans.dma_addr_end +
>  				       ctx->msg_queue.wdma_addr.dma_addr);
> -	vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
> +	vdec_msg_queue_qbuf(&ctx->msg_queue.core_ctx, lat_buf);
>  
>  	return 0;
>  err_free_fb_out:
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> index 03f8d7cd8edd..08c720c9760e 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> @@ -177,26 +177,17 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
>  
>  bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
>  {
> -	struct vdec_lat_buf *buf, *tmp;
> -	struct list_head *list_core[3];
> -	struct vdec_msg_queue_ctx *core_ctx;
> -	int ret, i, in_core_count = 0, count = 0;
> +	int ret;
>  	long timeout_jiff;
>  
> -	core_ctx = &msg_queue->ctx->dev->msg_queue_core_ctx;
> -	spin_lock(&core_ctx->ready_lock);
> -	list_for_each_entry_safe(buf, tmp, &core_ctx->ready_queue, core_list) {
> -		if (buf && buf->ctx == msg_queue->ctx) {
> -			list_core[in_core_count++] = &buf->core_list;
> -			list_del(&buf->core_list);
> -		}
> -	}
> -
> -	for (i = 0; i < in_core_count; i++) {
> -		list_add(list_core[in_core_count - (1 + i)], &core_ctx->ready_queue);
> -		queue_work(msg_queue->ctx->dev->core_workqueue, &msg_queue->core_work);
> +	if (atomic_read(&msg_queue->lat_list_cnt) == NUM_BUFFER_COUNT) {
> +		mtk_v4l2_debug(3, "wait buf full: list(%d %d) ready_num:%d status:%d",
> +			       atomic_read(&msg_queue->lat_list_cnt),
> +			       atomic_read(&msg_queue->core_list_cnt),
> +			       msg_queue->lat_ctx.ready_num,
> +			       msg_queue->status);
> +		return true;
>  	}
> -	spin_unlock(&core_ctx->ready_lock);
>  
>  	timeout_jiff = msecs_to_jiffies(1000 * (NUM_BUFFER_COUNT + 2));
>  	ret = wait_event_timeout(msg_queue->ctx->msg_queue.core_dec_done,
> @@ -208,18 +199,9 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
>  		return true;
>  	}
>  
> -	spin_lock(&core_ctx->ready_lock);
> -	list_for_each_entry_safe(buf, tmp, &core_ctx->ready_queue, core_list) {
> -		if (buf && buf->ctx == msg_queue->ctx) {
> -			count++;
> -			list_del(&buf->core_list);
> -		}
> -	}
> -	spin_unlock(&core_ctx->ready_lock);
> -
> -	mtk_v4l2_err("failed with lat buf isn't full: list(%d %d) count:%d",
> +	mtk_v4l2_err("failed with lat buf isn't full: list(%d %d)",
>  		     atomic_read(&msg_queue->lat_list_cnt),
> -		     atomic_read(&msg_queue->core_list_cnt), count);
> +		     atomic_read(&msg_queue->core_list_cnt));
>  
>  	return false;
>  }
> @@ -247,6 +229,8 @@ void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
>  
>  		kfree(lat_buf->private_data);
>  	}
> +
> +	cancel_work_sync(&msg_queue->core_work);
>  }
>  
>  static void vdec_msg_queue_core_work(struct work_struct *work)
> @@ -258,11 +242,11 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
>  	struct mtk_vcodec_dev *dev = ctx->dev;
>  	struct vdec_lat_buf *lat_buf;
>  
> -	spin_lock(&ctx->dev->msg_queue_core_ctx.ready_lock);
> +	spin_lock(&msg_queue->core_ctx.ready_lock);
>  	ctx->msg_queue.status &= ~CONTEXT_LIST_QUEUED;
> -	spin_unlock(&ctx->dev->msg_queue_core_ctx.ready_lock);
> +	spin_unlock(&msg_queue->core_ctx.ready_lock);
>  
> -	lat_buf = vdec_msg_queue_dqbuf(&dev->msg_queue_core_ctx);
> +	lat_buf = vdec_msg_queue_dqbuf(&msg_queue->core_ctx);
>  	if (!lat_buf)
>  		return;
>  
> @@ -276,12 +260,11 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
>  	mtk_vcodec_dec_disable_hardware(ctx, MTK_VDEC_CORE);
>  	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
>  
> -	wake_up_all(&ctx->msg_queue.core_dec_done);
>  	if (!(ctx->msg_queue.status & CONTEXT_LIST_QUEUED) &&
>  	    atomic_read(&msg_queue->core_list_cnt)) {
> -		spin_lock(&ctx->dev->msg_queue_core_ctx.ready_lock);
> +		spin_lock(&msg_queue->core_ctx.ready_lock);
>  		ctx->msg_queue.status |= CONTEXT_LIST_QUEUED;
> -		spin_unlock(&ctx->dev->msg_queue_core_ctx.ready_lock);
> +		spin_unlock(&msg_queue->core_ctx.ready_lock);
>  		queue_work(ctx->dev->core_workqueue, &msg_queue->core_work);
>  	}
>  }
> @@ -297,8 +280,8 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
>  	if (msg_queue->wdma_addr.size)
>  		return 0;
>  
> -	msg_queue->ctx = ctx;
>  	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
> +	vdec_msg_queue_init_ctx(&msg_queue->core_ctx, MTK_VDEC_CORE);
>  	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
>  
>  	atomic_set(&msg_queue->lat_list_cnt, 0);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> index 8f82d1484772..efc94165e016 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> @@ -84,7 +84,7 @@ struct vdec_lat_buf {
>   * @wdma_wptr_addr: ube write point
>   * @core_work: core hardware work
>   * @lat_ctx: used to store lat buffer list
> - * @ctx: point to mtk_vcodec_ctx
> + * @core_ctx: used to store core buffer list
>   *
>   * @lat_list_cnt: used to record each instance lat list count
>   * @core_list_cnt: used to record each instance core list count
> @@ -100,7 +100,7 @@ struct vdec_msg_queue {
>  
>  	struct work_struct core_work;
>  	struct vdec_msg_queue_ctx lat_ctx;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct vdec_msg_queue_ctx core_ctx;
>  
>  	atomic_t lat_list_cnt;
>  	atomic_t core_list_cnt;

