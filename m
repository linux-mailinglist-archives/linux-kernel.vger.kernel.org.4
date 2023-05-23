Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342470D763
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjEWI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbjEWIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:25:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910610D2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:23:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so3989975b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684830206; x=1687422206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uL1K7Jn4HAic+IgVkKP1XlX31FYJK1MaHHXhjAWowJ0=;
        b=K8t6nEGPIf7y3OejF9cTpMxnD9f+IW2kWI9UIlGC20nPW30gOWHERdjr6twKYnrIQb
         QkNF4wUUq8oTWG92/932f0pd2DK0OK+b7dhpcbaHPj/r9W9lHWUg6/WvFBf1Sl28+o7N
         kC2FdVg2RL14xlZe11fCBnzKut3m/jcfchZH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830206; x=1687422206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL1K7Jn4HAic+IgVkKP1XlX31FYJK1MaHHXhjAWowJ0=;
        b=LphY75I0jyoOoI+MdUy+uCvzBbZGPkKRfD4Kd3YcMKt15v9diGy2ytVPeTQ1W0Q3uB
         XmnB6cB7kaQe1pV+uid4tHn3TQKuoriDUpbeJl/UJSmwTBQOSO6d+HqJF4w4a4B3j8Mf
         7ocElGVYjbKywv8J6IddQLbjW9RTQ/wlOiL1cFdWSQy8puf2xjpzxmMqLEji+wdHfn5c
         QoJ8HQs21nbvBLBug6gBuRUQBu5sK+Dn7Q/cwWXs/SO1aSbe0SizbK1Z0mLssfFY8Zwr
         OS316MVR0T9PLu0iNYb0FF12RcjSVR2Jo3qOlzmhOZEiWJZz/qha6rMVG5rSdCScLeYo
         GnOQ==
X-Gm-Message-State: AC+VfDy6n9AWiK7ow68e8jYLE7gDk7BVZAog+uQc2uiOWo0IEveAvC0m
        ue7J/jsAPmpQhQgj5ibuVfvfrQ==
X-Google-Smtp-Source: ACHHUZ7C/3gK4tglhoWtOSFtZQTN5c+zYptt2miKmcxSqwrtjSbJ8p63MmXN4dsy/YUXayz5Xy+O5A==
X-Received: by 2002:a17:903:2796:b0:1ac:65ab:cf7b with SMTP id jw22-20020a170903279600b001ac65abcf7bmr13865631plb.9.1684830206026;
        Tue, 23 May 2023 01:23:26 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b001aafa2e4716sm6134855plo.264.2023.05.23.01.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:23:25 -0700 (PDT)
Date:   Tue, 23 May 2023 08:23:20 +0000
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
Subject: Re: [PATCH v2 5/8] media: v4l2: Add DELETE_BUF ioctl
Message-ID: <20230523082320.akofzwevkhwswosm@chromium.org>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-6-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-6-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:28:52AM +0100, Benjamin Gaignard wrote:
> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../userspace-api/media/v4l/user-func.rst     |  1 +
>  .../media/v4l/vidioc-delete-buf.rst           | 51 ++++++++++++++++
>  .../media/common/videobuf2/videobuf2-core.c   | 59 ++++++++++++++++++-
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  6 ++
>  drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>  include/media/v4l2-ioctl.h                    |  4 ++
>  include/media/videobuf2-core.h                |  9 +++
>  include/media/videobuf2-v4l2.h                | 11 ++++
>  include/uapi/linux/videodev2.h                |  1 +
>  10 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> 
> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
> index 228c1521f190..93e0a6a117fc 100644
> --- a/Documentation/userspace-api/media/v4l/user-func.rst
> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
> @@ -17,6 +17,7 @@ Function Reference
>      vidioc-dbg-g-chip-info
>      vidioc-dbg-g-register
>      vidioc-decoder-cmd
> +    vidioc-delete-buf
>      vidioc-dqevent
>      vidioc-dv-timings-cap
>      vidioc-encoder-cmd
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> new file mode 100644
> index 000000000000..0e7ce58f91bc
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> @@ -0,0 +1,51 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +.. c:namespace:: V4L
> +
> +.. _VIDIOC_DELETE_BUF:
> +
> +************************
> +ioctl VIDIOC_DELETE_BUF
> +************************
> +
> +Name
> +====
> +
> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
> +
> +Synopsis
> +========
> +
> +.. c:macro:: VIDIOC_DELETE_BUF
> +
> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
> +
> +Arguments
> +=========
> +
> +``fd``
> +    File descriptor returned by :c:func:`open()`.
> +
> +``argp``
> +    Pointer to struct :c:type:`v4l2_buffer`.

Would struct v4l2_create_buffers make more sense here? With it, we could
actually make this ioctl VIDIOC_DELETE_BUF*S*, consistently with
VIDIOC_CREATE_BUF*S* and allow the user space to remove a block of buffers
the same way it created a block of buffers in the first place.

> +
> +Description
> +===========
> +
> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF` ioctl to
> +delete a buffer from a queue.
> +
> +The struct :c:type:`v4l2_buffer` structure is specified in
> +:ref:`buffer`.
> +
> +Return Value
> +============
> +
> +On success 0 is returned, on error -1 and the ``errno`` variable is set
> +appropriately. The generic error codes are described at the
> +:ref:`Generic Error Codes <gen-errors>` chapter.
> +
> +EBUSY
> +    File I/O is in progress.
> +
> +EINVAL
> +    The buffer ``index`` doesn't exist in the queue.
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 3c6ced360770..ec241d726fe6 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -401,6 +401,24 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>  		vb->skip_cache_sync_on_finish = 1;
>  }
>  
> +/*
> + * __vb2_queue_get_free_index() - find a free index in the queue for vb2 buffer.
> + *
> + * Returns an index for vb2 buffer.
> + */
> +static int __vb2_queue_get_free_index(struct vb2_queue *q)
> +{
> +	int i;
> +
> +	spin_lock(&q->bufs_lock);
> +	for (i = 0; i < q->max_num_bufs; i++)
> +		if (!q->bufs[i])
> +			break;
> +	spin_unlock(&q->bufs_lock);
> +
> +	return i;
> +}

Another reason to go with XArray, so that we don't have to open code
index reclaim.

> +
>  /*
>   * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
>   * video buffer memory for all buffers/planes on the queue and initializes the
> @@ -427,7 +445,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  		vb->state = VB2_BUF_STATE_DEQUEUED;
>  		vb->vb2_queue = q;
>  		vb->num_planes = num_planes;
> -		vb->index = q->num_buffers + buffer;
> +		vb->index = __vb2_queue_get_free_index(q);
>  		vb->type = q->type;
>  		vb->memory = memory;
>  		init_buffer_cache_hints(q, vb);
> @@ -1570,6 +1588,45 @@ int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>  
> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
> +{
> +	struct vb2_buffer *vb;
> +
> +	vb = vb2_get_buffer(q, index);
> +	if (!vb) {
> +		dprintk(q, 1, "invalid buffer index %d\n", index);
> +		return -EINVAL;
> +	}
> +
> +	if (vb->state == VB2_BUF_STATE_QUEUED) {

How about other states? I'd probably only allow this when the state is
DEQUEUED for simplicity. Is there a need to allow deleting buffers in
other states?

Also, do we need to synchronize this with other contexts which could change
the buffer state?

> +		dprintk(q, 1, "can't delete queued buffer index %d\n", index);
> +		return -EINVAL;
> +	}
> +

Don't we also need to hold q->mmap_lock to prevent racing with an attempt
to mmap the buffer?

> +	if (vb && vb->planes[0].mem_priv)

nit: At this point it's not possible for vb to be NULL, since we already
ruled that out a few lines above.

> +		call_void_vb_qop(vb, buf_cleanup, vb);
> +
> +	/* Free MMAP buffers or release USERPTR buffers */
> +	if (q->memory == VB2_MEMORY_MMAP)
> +		__vb2_buf_mem_free(vb);
> +	else if (q->memory == VB2_MEMORY_DMABUF)
> +		__vb2_buf_dmabuf_put(vb);
> +	else
> +		__vb2_buf_userptr_put(vb);
> +
> +	vb2_queue_remove_buffer(q, vb);
> +	kfree(vb);
> +
> +	q->num_buffers--;
> +	if (!q->num_buffers) {
> +		q->memory = VB2_MEMORY_UNKNOWN;
> +		INIT_LIST_HEAD(&q->queued_list);
> +	}

Would it make sense to refactor __vb2_queue_free() instead to take a
range of buffer indexes rather than duplicating the code here?

Best regards,
Tomasz

