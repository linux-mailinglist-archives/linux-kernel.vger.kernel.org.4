Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6763707E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjERKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjERKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:37:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C81BFC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:37:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae7033f4e5so2051305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684406259; x=1686998259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TN0khYDoCxGGhU5ss9Q38NY81uIy7NyfHWBZ/foWTNs=;
        b=YL4RF+ajG6qmFtw1krWMbvmqp58K2LdZMkdN9NtDq9e7qB3xM66fR+vKPs9LqZrUI3
         z/cPBUbxaZ4Mw/HmC/E8mx5KxEa5i6J03kQoUue1Ik904Mj84kPWUy4rLKZHni07u46x
         Lhgt1OggQSQZKi4LXbciYoburV0kltKx9Z6vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684406259; x=1686998259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN0khYDoCxGGhU5ss9Q38NY81uIy7NyfHWBZ/foWTNs=;
        b=kz09barQzCW9T94WM82U8tAKnVy7bx3nfwnIz3IaugOsHRWSLmU3UDYfKe+C2qgtQj
         WfVfV5gf4gUPY9oA29hx/LyC/EGz1NfpHdUEDuzEDYwU6M0HYrss4jKTCg0sCJ/x1KG5
         h1HxZQIr1E0Rg7z/ZvICMoxbKjzKrSsC0fpo0Zs39ExHJsRdXhK/XTZg7HoRme0B/jkY
         JObpkGq8D2QbSUlaAjr77dc4AYq5OlPmmO/ZECKih1jrJ3j/dOzYT7G2VuS0MMCwngc/
         QfbGGwHVrkB7aN7N8S2b0kL2fDN4IECikcwkn9zqRQWMr/R8IkwUW97APG125nY00FXR
         XIdw==
X-Gm-Message-State: AC+VfDxpXSq56uXdzPS+T5KaAPDuGQOlHotRe0hARKSvhPv9jxHmXT70
        NOYoLu8+sFYc+1HgeNCuD4h3wA==
X-Google-Smtp-Source: ACHHUZ6W+zJ2HYptQYSQqBcWmDXV2Skkvr77A8XeRCPRwOALKveKfXkSKd9XHlfW112zz6NLjZUcYQ==
X-Received: by 2002:a17:902:e889:b0:1ac:6fc3:6beb with SMTP id w9-20020a170902e88900b001ac6fc36bebmr2063035plg.9.1684406259377;
        Thu, 18 May 2023 03:37:39 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b001ab0669d84csm1104058plb.26.2023.05.18.03.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:37:38 -0700 (PDT)
Date:   Thu, 18 May 2023 10:37:33 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, eagle.zhou@nxp.com, bin.liu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, daniel.almeida@collabora.com,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        jernel@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/8] media: videobuf2: Access vb2_queue bufs array
 through helper functions
Message-ID: <20230518103733.djr5zp5mac3xixxa@chromium.org>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-2-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Tue, Mar 21, 2023 at 11:28:48AM +0100, Benjamin Gaignard wrote:
> The first step before changing how vb2 buffers are stored into queue
> is to avoid direct access to bufs arrays.
> 
> This patch adds 2 helpers functions to add and remove vb2 buffers
> from a queue. With these 2 and vb2_get_buffer(), bufs field of
> struct vb2_queue becomes like a private member of the structure.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 84 +++++++++++--------
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 17 ++--
>  drivers/media/platform/amphion/vpu_dbg.c      |  4 +-
>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  2 +-
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  2 +-
>  drivers/media/test-drivers/visl/visl-dec.c    | 16 ++--
>  .../staging/media/atomisp/pci/atomisp_ioctl.c |  2 +-
>  include/media/videobuf2-core.h                | 26 ++++++
>  8 files changed, 101 insertions(+), 52 deletions(-)
> 

Sorry for being late with review and thanks a lot for working on this.
This is a quite a long overdue functionality.

[snip]

> @@ -2679,7 +2689,13 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	 * Check if plane_count is correct
>  	 * (multiplane buffers are not supported).
>  	 */
> -	if (q->bufs[0]->num_planes != 1) {
> +	vb = vb2_get_buffer(q, 0);
> +	if (!vb) {
> +		ret = -EBUSY;

Out of curiosity, is there any reason for specifically chosing -EBUSY here?

It shouldn't be possible for this to happen, but since we're
dealing with a pointer here, a NULL check is a good thing. I guess that makes
-EBUSY as good as any other code here.

I see some other similar places in the code, with a comment "This shouldn't
happen" and a dprinkt(). Maybe it would be good to add those here too?

> +		goto err_reqbufs;
> +	}
> +
> +	if (vb->num_planes != 1) {
>  		ret = -EBUSY;
>  		goto err_reqbufs;
>  	}
> @@ -2688,12 +2704,14 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	 * Get kernel address of each buffer.
>  	 */
>  	for (i = 0; i < q->num_buffers; i++) {
> -		fileio->bufs[i].vaddr = vb2_plane_vaddr(q->bufs[i], 0);
> +		vb = vb2_get_buffer(q, i);
> +
> +		fileio->bufs[i].vaddr = vb2_plane_vaddr(vb, 0);
>  		if (fileio->bufs[i].vaddr == NULL) {
>  			ret = -EINVAL;
>  			goto err_reqbufs;
>  		}
> -		fileio->bufs[i].size = vb2_plane_size(q->bufs[i], 0);
> +		fileio->bufs[i].size = vb2_plane_size(vb, 0);
>  	}
>  
>  	/*
> @@ -2821,15 +2839,15 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  
>  		fileio->cur_index = index;
>  		buf = &fileio->bufs[index];
> -		b = q->bufs[index];
> +		b = vb2_get_buffer(q, index);
>  
>  		/*
>  		 * Get number of bytes filled by the driver
>  		 */
>  		buf->pos = 0;
>  		buf->queued = 0;
> -		buf->size = read ? vb2_get_plane_payload(q->bufs[index], 0)
> -				 : vb2_plane_size(q->bufs[index], 0);
> +		buf->size = read ? vb2_get_plane_payload(b, 0)
> +				 : vb2_plane_size(b, 0);
>  		/* Compensate for data_offset on read in the multiplanar case. */
>  		if (is_multiplanar && read &&
>  				b->planes[0].data_offset < buf->size) {
> @@ -2872,7 +2890,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  	 * Queue next buffer if required.
>  	 */
>  	if (buf->pos == buf->size || (!read && fileio->write_immediately)) {
> -		struct vb2_buffer *b = q->bufs[index];
> +		struct vb2_buffer *b = vb2_get_buffer(q, index);
>  
>  		/*
>  		 * Check if this is the last buffer to read.
> @@ -2899,7 +2917,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  		 */
>  		buf->pos = 0;
>  		buf->queued = 1;
> -		buf->size = vb2_plane_size(q->bufs[index], 0);
> +		buf->size = vb2_plane_size(vb2_get_buffer(q, index), 0);
>  		fileio->q_count += 1;
>  		/*
>  		 * If we are queuing up buffers for the first time, then
> @@ -2970,7 +2988,7 @@ static int vb2_thread(void *data)
>  		 * Call vb2_dqbuf to get buffer back.
>  		 */
>  		if (prequeue) {
> -			vb = q->bufs[index++];
> +			vb = vb2_get_buffer(q, index++);
>  			prequeue--;
>  		} else {
>  			call_void_qop(q, wait_finish, q);
> @@ -2979,7 +2997,7 @@ static int vb2_thread(void *data)
>  			call_void_qop(q, wait_prepare, q);
>  			dprintk(q, 5, "file io: vb2_dqbuf result: %d\n", ret);
>  			if (!ret)
> -				vb = q->bufs[index];
> +				vb = vb2_get_buffer(q, index);
>  		}
>  		if (ret || threadio->stop)
>  			break;
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 1f5d235a8441..01b2bb957239 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -383,7 +383,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>  		return -EINVAL;
>  	}
>  
> -	if (q->bufs[b->index] == NULL) {
> +	if (!vb2_get_buffer(q, b->index)) {
>  		/* Should never happen */
>  		dprintk(q, 1, "%s: buffer is NULL\n", opname);
>  		return -EINVAL;
> @@ -394,7 +394,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>  		return -EINVAL;
>  	}
>  
> -	vb = q->bufs[b->index];
> +	vb = vb2_get_buffer(q, b->index);
>  	vbuf = to_vb2_v4l2_buffer(vb);
>  	ret = __verify_planes_array(vb, b);
>  	if (ret)
> @@ -628,11 +628,14 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
>  struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>  {
>  	unsigned int i;
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
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(vb2_find_buffer);
> @@ -664,7 +667,7 @@ int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b)
>  		dprintk(q, 1, "buffer index out of range\n");
>  		return -EINVAL;
>  	}
> -	vb = q->bufs[b->index];
> +	vb = vb2_get_buffer(q, b->index);
>  	ret = __verify_planes_array(vb, b);
>  	if (!ret)
>  		vb2_core_querybuf(q, b->index, b);
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index 44b830ae01d8..8a423c1f6b55 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -133,7 +133,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>  
>  	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
>  	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>  		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  
>  		if (vb->state == VB2_BUF_STATE_DEQUEUED)
> @@ -148,7 +148,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>  
>  	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
>  	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>  		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>  
>  		if (vb->state == VB2_BUF_STATE_DEQUEUED)
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 969516a940ba..0be07f691d9a 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -603,7 +603,7 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>  		return -EINVAL;
>  	}
>  
> -	vb = vq->bufs[buf->index];
> +	vb = vb2_get_buffer(vq, buf->index);
>  	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
>  	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
>  
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index cbb6728b8a40..f5958b6d834a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -1701,7 +1701,7 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
>  
>  	/* update internal buffer's width/height */
>  	for (i = 0; i < vq->num_buffers; i++) {
> -		if (vb == vq->bufs[i]) {
> +		if (vb == vb2_get_buffer(vq, i)) {
>  			instance->dpb[i].width = w;
>  			instance->dpb[i].height = h;
>  			break;
> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
> index 318d675e5668..328016b456ba 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.c
> +++ b/drivers/media/test-drivers/visl/visl-dec.c
> @@ -290,13 +290,14 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  	for (i = 0; i < out_q->num_buffers; i++) {
>  		char entry[] = "index: %u, state: %s, request_fd: %d, ";
>  		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
> +		struct vb2_buffer *vb2 = vb2_get_buffer(out_q, i);
> +		char *q_status = visl_get_vb2_state(vb2->state);
>  
>  		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
>  				 entry, i, q_status,
> -				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
> +				 to_vb2_v4l2_buffer(vb2)->request_fd);
>  
> -		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
> +		len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
>  					   &buf[len],
>  					   TPG_STR_BUF_SZ - len);
>  
> @@ -342,13 +343,14 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>  	len = 0;
>  	for (i = 0; i < cap_q->num_buffers; i++) {
>  		u32 old_len = len;
> -		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
> +		struct vb2_buffer *vb2 = vb2_get_buffer(cap_q, i);
> +		char *q_status = visl_get_vb2_state(vb2->state);
>  
>  		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
>  				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
> -				 cap_q->bufs[i]->index, q_status,
> -				 cap_q->bufs[i]->timestamp,
> -				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
> +				 vb2->index, q_status,
> +				 vb2->timestamp,
> +				 to_vb2_v4l2_buffer(vb2)->is_held);
>  
>  		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
>  		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
> index d1314bdbf7d5..c7778860f3d4 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
> @@ -1095,7 +1095,7 @@ static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
>  	if (ret)
>  		return ret;
>  
> -	vb = pipe->vb_queue.bufs[buf->index];
> +	vb = vb2_get_buffer(pipe->vb_queue, buf->index);
>  	frame = vb_to_frame(vb);
>  
>  	buf->reserved = asd->frame_status[buf->index];
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 4b6a9d2ea372..5b1e3d801546 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -1244,6 +1244,32 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  	return NULL;
>  }
>  
> +/**
> + * vb2_queue_add_buffer() - add a buffer to a queue
> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
> + * @vb:	pointer to &struct vb2_buffer to be added to the queue.
> + */
> +static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)

Could we make index an argument to this function and actually assign it to
vb->index if the operation succeeds?
Similarly, could we assign q to vb->vb2_queue in this function as well?

I have plans to make the vb2_buffer struct represent a buffer, rather than
an entry in the queue, because the memory can actually outlive the queue,
e.g. when REQBUFS(0) happens, but an exported DMA-buf still references the
buffer. Currently the DMA-buf object is tied to the allocator-private
struct, but that one has a pointer to a vb2_buffer, which becomes invalid
in such scenario with current implementation.

> +{
> +	if (vb->index < VB2_MAX_FRAME) {
> +		q->bufs[vb->index] = vb;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * vb2_queue_remove_buffer() - remove a buffer from a queue
> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
> + * @vb:	pointer to &struct vb2_buffer to be removed from the queue.
> + */
> +static inline void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> +{
> +	if (vb->index < VB2_MAX_FRAME)
> +		q->bufs[vb->index] = NULL;

Here we could also NULLify vb->vb2_queue. Right now I think the struct
would be just kfree()d instantly after returning to the caller, but with
the design I mentioned above, it could still stay there until the last
reference goes away.

Best regards,
Tomasz
