Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACC6B7E23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMQwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCMQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:52:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B7B2471B;
        Mon, 13 Mar 2023 09:51:42 -0700 (PDT)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9D0D6602135;
        Mon, 13 Mar 2023 16:51:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678726291;
        bh=dmX8aSMDGdnKVVwb34Im4TzUC75nbAE+WEfMhqfpkKY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UzL8AXuaUfv8YamQyQpf+4UGagM+ztPxrsuzVbGEdaf1Y+T4NBTJ8Pg0QAFFx1oqs
         sMnyl5XgTqO3yLpMi1Cd2XdGZAgkL7fh/x6W4LMmG0luQQlc5MEByNEGuLoVEXm2Bo
         Fb8FEYL3T6igcenf+H2Rxn7ZDNQGLKXIznqHvUA+6P0JuyiUnorhjEJTtS6gNjNp4I
         QrLealFvtUXSxaXGGVa7SutlClsrJBZBqcb69gOZGFJs4YQU16avJP3cW+XT/KzYqg
         bJQqipi4yi+A4JQ89cfMve9uUAl2yN7ec78aOyZOFNLUMc8ZiAlavE/BIP20sZBYMi
         txqySeN+zOhGw==
Message-ID: <60c05cfb-9afb-3b25-7f91-71cf56ed6bfc@collabora.com>
Date:   Mon, 13 Mar 2023 17:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC 1/4] media: videobuf2: Use vb2_get_buffer() as helper
 everywhere
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jerbel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-2-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230313135916.862852-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

W dniu 13.03.2023 o 14:59, Benjamin Gaignard pisze:
> The first step before changing how vb2 buffers are stored into queue
> is to avoid direct call to bufs arrays.
> This patch add 2 helpers functions to set and delete vb2 buffers
> from a queue. With these 2 and vb2_get_buffer(), bufs field of
> struct vb2_queue becomes like a private member of the structure.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   .../media/common/videobuf2/videobuf2-core.c   | 69 ++++++++++---------
>   .../media/common/videobuf2/videobuf2-v4l2.c   | 17 +++--
>   drivers/media/platform/amphion/vpu_dbg.c      |  4 +-
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  2 +-
>   .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  2 +-
>   drivers/media/test-drivers/visl/visl-dec.c    | 16 +++--
>   include/media/videobuf2-core.h                | 20 ++++++
>   7 files changed, 81 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index cf6727d9c81f..b51152ace763 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -359,7 +359,7 @@ static void __setup_offsets(struct vb2_buffer *vb)
>   	unsigned long off = 0;
>   
>   	if (vb->index) {
> -		struct vb2_buffer *prev = q->bufs[vb->index - 1];
> +		struct vb2_buffer *prev = vb2_get_buffer(q, vb->index - 1);

internally vb2_get_buffer() verifies the index is within allowed range, but...

>   		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
>   
>   		off = PAGE_ALIGN(p->m.offset + p->length);
> @@ -437,7 +437,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>   		}
>   		call_void_bufop(q, init_buffer, vb);
>   
> -		q->bufs[vb->index] = vb;
> +		vb2_set_buffer(q, vb);
>   
>   		/* Allocate video buffer memory for the MMAP type */
>   		if (memory == VB2_MEMORY_MMAP) {
> @@ -445,7 +445,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>   			if (ret) {
>   				dprintk(q, 1, "failed allocating memory for buffer %d\n",
>   					buffer);
> -				q->bufs[vb->index] = NULL;
> +				vb2_del_buffer(q, vb);
>   				kfree(vb);
>   				break;
>   			}
> @@ -460,7 +460,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>   				dprintk(q, 1, "buffer %d %p initialization failed\n",
>   					buffer, vb);
>   				__vb2_buf_mem_free(vb);
> -				q->bufs[vb->index] = NULL;
> +				vb2_del_buffer(q, vb);
>   				kfree(vb);
>   				break;
>   			}
> @@ -483,7 +483,7 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>   
>   	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>   	     ++buffer) {
> -		vb = q->bufs[buffer];
> +		vb = vb2_get_buffer(q, buffer);
>   		if (!vb)
>   			continue;
>   
> @@ -511,7 +511,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>   	/* Call driver-provided cleanup function for each buffer, if provided */
>   	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>   	     ++buffer) {
> -		struct vb2_buffer *vb = q->bufs[buffer];
> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>   
>   		if (vb && vb->planes[0].mem_priv)
>   			call_void_vb_qop(vb, buf_cleanup, vb);
> @@ -591,8 +591,10 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>   	/* Free vb2 buffers */
>   	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>   	     ++buffer) {
> -		kfree(q->bufs[buffer]);
> -		q->bufs[buffer] = NULL;
> +		struct vb2_buffer *vb2 = vb2_get_buffer(q, buffer);
> +
> +		vb2_del_buffer(q, vb2);
> +		kfree(vb2);
>   	}
>   
>   	q->num_buffers -= buffers;
> @@ -628,7 +630,7 @@ static bool __buffers_in_use(struct vb2_queue *q)
>   {
>   	unsigned int buffer;
>   	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> -		if (vb2_buffer_in_use(q, q->bufs[buffer]))
> +		if (vb2_buffer_in_use(q, vb2_get_buffer(q, buffer)))
>   			return true;
>   	}
>   	return false;
> @@ -636,7 +638,7 @@ static bool __buffers_in_use(struct vb2_queue *q)
>   
>   void vb2_core_querybuf(struct vb2_queue *q, unsigned int index, void *pb)
>   {
> -	call_void_bufop(q, fill_user_buffer, q->bufs[index], pb);
> +	call_void_bufop(q, fill_user_buffer, vb2_get_buffer(q, index), pb);
>   }
>   EXPORT_SYMBOL_GPL(vb2_core_querybuf);
>   
> @@ -1547,7 +1549,7 @@ int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
>   	struct vb2_buffer *vb;
>   	int ret;
>   
> -	vb = q->bufs[index];
> +	vb = vb2_get_buffer(q, index);
>   	if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>   		dprintk(q, 1, "invalid buffer state %s\n",
>   			vb2_state_name(vb->state));
> @@ -1618,7 +1620,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
>   		 * correctly return them to vb2.
>   		 */
>   		for (i = 0; i < q->num_buffers; ++i) {
> -			vb = q->bufs[i];
> +			vb = vb2_get_buffer(q, i);
>   			if (vb->state == VB2_BUF_STATE_ACTIVE)
>   				vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED);
>   		}
> @@ -1646,7 +1648,7 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb,
>   		return -EIO;
>   	}
>   
> -	vb = q->bufs[index];
> +	vb = vb2_get_buffer(q, index);
>   
>   	if (!req && vb->state != VB2_BUF_STATE_IN_REQUEST &&
>   	    q->requires_requests) {
> @@ -2022,12 +2024,15 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>   	 * to vb2 in stop_streaming().
>   	 */
>   	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
> -		for (i = 0; i < q->num_buffers; ++i)
> -			if (q->bufs[i]->state == VB2_BUF_STATE_ACTIVE) {
> +		for (i = 0; i < q->num_buffers; ++i) {
> +			struct vb2_buffer *vb2 = vb2_get_buffer(q, i);
> +
> +			if (vb2->state == VB2_BUF_STATE_ACTIVE) {
>   				pr_warn("driver bug: stop_streaming operation is leaving buf %p in active state\n",
> -					q->bufs[i]);
> -				vb2_buffer_done(q->bufs[i], VB2_BUF_STATE_ERROR);
> +					vb2);
> +				vb2_buffer_done(vb2, VB2_BUF_STATE_ERROR);
>   			}
> +		}
>   		/* Must be zero now */
>   		WARN_ON(atomic_read(&q->owned_by_drv_count));
>   	}
> @@ -2061,7 +2066,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>   	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
>   	 */
>   	for (i = 0; i < q->num_buffers; ++i) {
> -		struct vb2_buffer *vb = q->bufs[i];
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>   		struct media_request *req = vb->req_obj.req;
>   
>   		/*
> @@ -2215,7 +2220,7 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
>   	 * return its buffer and plane numbers.
>   	 */
>   	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> -		vb = q->bufs[buffer];
> +		vb = vb2_get_buffer(q, buffer);
>   
>   		for (plane = 0; plane < vb->num_planes; ++plane) {
>   			if (vb->planes[plane].m.offset == off) {
> @@ -2262,7 +2267,7 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
>   		return -EINVAL;
>   	}
>   
> -	vb = q->bufs[index];
> +	vb = vb2_get_buffer(q, index);
>   
>   	if (plane >= vb->num_planes) {
>   		dprintk(q, 1, "buffer plane out of range\n");
> @@ -2339,7 +2344,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>   	if (ret)
>   		goto unlock;
>   
> -	vb = q->bufs[buffer];
> +	vb = vb2_get_buffer(q, buffer);
>   
>   	/*
>   	 * MMAP requires page_aligned buffers.
> @@ -2679,7 +2684,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>   	 * Check if plane_count is correct
>   	 * (multiplane buffers are not supported).
>   	 */
> -	if (q->bufs[0]->num_planes != 1) {
> +	if (vb2_get_buffer(q, 0)->num_planes != 1) {
>   		ret = -EBUSY;
>   		goto err_reqbufs;
>   	}
> @@ -2688,12 +2693,14 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>   	 * Get kernel address of each buffer.
>   	 */
>   	for (i = 0; i < q->num_buffers; i++) {
> -		fileio->bufs[i].vaddr = vb2_plane_vaddr(q->bufs[i], 0);
> +		struct vb2_buffer *vb2 = vb2_get_buffer(q, i);
> +
> +		fileio->bufs[i].vaddr = vb2_plane_vaddr(vb2, 0);
>   		if (fileio->bufs[i].vaddr == NULL) {
>   			ret = -EINVAL;
>   			goto err_reqbufs;
>   		}
> -		fileio->bufs[i].size = vb2_plane_size(q->bufs[i], 0);
> +		fileio->bufs[i].size = vb2_plane_size(vb2, 0);
>   	}
>   
>   	/*
> @@ -2821,15 +2828,15 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>   
>   		fileio->cur_index = index;
>   		buf = &fileio->bufs[index];
> -		b = q->bufs[index];
> +		b = vb2_get_buffer(q, index);
>   
>   		/*
>   		 * Get number of bytes filled by the driver
>   		 */
>   		buf->pos = 0;
>   		buf->queued = 0;
> -		buf->size = read ? vb2_get_plane_payload(q->bufs[index], 0)
> -				 : vb2_plane_size(q->bufs[index], 0);
> +		buf->size = read ? vb2_get_plane_payload(b, 0)
> +				 : vb2_plane_size(b, 0);
>   		/* Compensate for data_offset on read in the multiplanar case. */
>   		if (is_multiplanar && read &&
>   				b->planes[0].data_offset < buf->size) {
> @@ -2872,7 +2879,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>   	 * Queue next buffer if required.
>   	 */
>   	if (buf->pos == buf->size || (!read && fileio->write_immediately)) {
> -		struct vb2_buffer *b = q->bufs[index];
> +		struct vb2_buffer *b = vb2_get_buffer(q, index);
>   
>   		/*
>   		 * Check if this is the last buffer to read.
> @@ -2899,7 +2906,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>   		 */
>   		buf->pos = 0;
>   		buf->queued = 1;
> -		buf->size = vb2_plane_size(q->bufs[index], 0);
> +		buf->size = vb2_plane_size(vb2_get_buffer(q, index), 0);
>   		fileio->q_count += 1;
>   		/*
>   		 * If we are queuing up buffers for the first time, then
> @@ -2970,7 +2977,7 @@ static int vb2_thread(void *data)
>   		 * Call vb2_dqbuf to get buffer back.
>   		 */
>   		if (prequeue) {
> -			vb = q->bufs[index++];
> +			vb = vb2_get_buffer(q, index++);
>   			prequeue--;
>   		} else {
>   			call_void_qop(q, wait_finish, q);
> @@ -2979,7 +2986,7 @@ static int vb2_thread(void *data)
>   			call_void_qop(q, wait_prepare, q);
>   			dprintk(q, 5, "file io: vb2_dqbuf result: %d\n", ret);
>   			if (!ret)
> -				vb = q->bufs[index];
> +				vb = vb2_get_buffer(q, index);
>   		}
>   		if (ret || threadio->stop)
>   			break;
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 1f5d235a8441..01b2bb957239 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -383,7 +383,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>   		return -EINVAL;
>   	}
>   
> -	if (q->bufs[b->index] == NULL) {
> +	if (!vb2_get_buffer(q, b->index)) {
>   		/* Should never happen */
>   		dprintk(q, 1, "%s: buffer is NULL\n", opname);
>   		return -EINVAL;
> @@ -394,7 +394,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>   		return -EINVAL;
>   	}
>   
> -	vb = q->bufs[b->index];
> +	vb = vb2_get_buffer(q, b->index);
>   	vbuf = to_vb2_v4l2_buffer(vb);
>   	ret = __verify_planes_array(vb, b);
>   	if (ret)
> @@ -628,11 +628,14 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
>   struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>   {
>   	unsigned int i;
> +	struct vb2_buffer *vb2;
>   
> -	for (i = 0; i < q->num_buffers; i++)
> -		if (q->bufs[i]->copied_timestamp &&
> -		    q->bufs[i]->timestamp == timestamp)
> -			return vb2_get_buffer(q, i);
> +	for (i = 0; i < q->num_buffers; i++) {
> +		vb2 = vb2_get_buffer(q, i);
> +		if (vb2->copied_timestamp &&
> +		    vb2->timestamp == timestamp)
> +			return vb2;
> +	}
>   	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(vb2_find_buffer);
> @@ -664,7 +667,7 @@ int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b)
>   		dprintk(q, 1, "buffer index out of range\n");
>   		return -EINVAL;
>   	}
> -	vb = q->bufs[b->index];
> +	vb = vb2_get_buffer(q, b->index);
>   	ret = __verify_planes_array(vb, b);
>   	if (!ret)
>   		vb2_core_querybuf(q, b->index, b);
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index 44b830ae01d8..8a423c1f6b55 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -133,7 +133,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   
>   	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
>   	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>   		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>   
>   		if (vb->state == VB2_BUF_STATE_DEQUEUED)
> @@ -148,7 +148,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   
>   	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
>   	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>   		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>   
>   		if (vb->state == VB2_BUF_STATE_DEQUEUED)
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..0be07f691d9a 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -603,7 +603,7 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>   		return -EINVAL;
>   	}
>   
> -	vb = vq->bufs[buf->index];
> +	vb = vb2_get_buffer(vq, buf->index);
>   	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
>   	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
>   
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index cbb6728b8a40..f5958b6d834a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -1701,7 +1701,7 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
>   
>   	/* update internal buffer's width/height */
>   	for (i = 0; i < vq->num_buffers; i++) {
> -		if (vb == vq->bufs[i]) {
> +		if (vb == vb2_get_buffer(vq, i)) {
>   			instance->dpb[i].width = w;
>   			instance->dpb[i].height = h;
>   			break;
> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
> index 318d675e5668..328016b456ba 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.c
> +++ b/drivers/media/test-drivers/visl/visl-dec.c
> @@ -290,13 +290,14 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>   	for (i = 0; i < out_q->num_buffers; i++) {
>   		char entry[] = "index: %u, state: %s, request_fd: %d, ";
>   		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
> +		struct vb2_buffer *vb2 = vb2_get_buffer(out_q, i);
> +		char *q_status = visl_get_vb2_state(vb2->state);
>   
>   		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
>   				 entry, i, q_status,
> -				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
> +				 to_vb2_v4l2_buffer(vb2)->request_fd);
>   
> -		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> +		len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
>   					   &buf[len],
>   					   TPG_STR_BUF_SZ - len);
>   
> @@ -342,13 +343,14 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>   	len = 0;
>   	for (i = 0; i < cap_q->num_buffers; i++) {
>   		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
> +		struct vb2_buffer *vb2 = vb2_get_buffer(cap_q, i);
> +		char *q_status = visl_get_vb2_state(vb2->state);
>   
>   		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
>   				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
> -				 cap_q->bufs[i]->index, q_status,
> -				 cap_q->bufs[i]->timestamp,
> -				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
> +				 vb2->index, q_status,
> +				 vb2->timestamp,
> +				 to_vb2_v4l2_buffer(vb2)->is_held);
>   
>   		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
>   		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 4b6a9d2ea372..d18c57e7aef0 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -1244,6 +1244,26 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>   	return NULL;
>   }
>   
> +/**
> + * vb2_set_buffer() - set a buffer to a queue
> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
> + * @vb:	pointer to &struct vb2_buffer to be added to the queue.
> + */
> +static inline void vb2_set_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> +{
> +	q->bufs[vb->index] = vb;

neither this...

> +}
> +
> +/**
> + * vb2_del_buffer() - remove a buffer from a queue
> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
> + * @vb:	pointer to &struct vb2_buffer to be removed from the queue.
> + */
> +static inline void vb2_del_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> +{
> +	q->bufs[vb->index] = NULL;

nor this does so. Is it intentional?

> +}
> +
>   /*
>    * The following functions are not part of the vb2 core API, but are useful
>    * functions for videobuf2-*.

