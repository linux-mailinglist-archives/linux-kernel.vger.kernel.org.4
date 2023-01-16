Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688666B87A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAPHzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjAPHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:55:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A451043A;
        Sun, 15 Jan 2023 23:55:01 -0800 (PST)
Received: from [192.168.15.130] (unknown [194.152.46.21])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C55B56602D09;
        Mon, 16 Jan 2023 07:54:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673855699;
        bh=VHAdl9bhBGxxREJcOK8QcHBboqqMjDLzA64zCLk2l4c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mmMzMDUxd1Uj7zkfzPCFVdPtwFr3bM70WpOweD7P6lrlWASLUg2VaWDDnlGz34TnY
         eP6yhnBIoYvznGtKkgMFvt/NDwMomiYL0d8Mwl3cbfKLL6u8AvVZ3RcJK7kuWYMcHx
         z2y12CndWrYuBga4rDfPHRd5rd1yKTOBy2VwKr6hsZb3Fd7DdLV0h4CR8O4Urzl098
         JhAhHEYdFxWNome5EFmx+TQWoN4fM+EuxtJDeC8m9e8bTMKeJrQO/Zz5CymOZK3XwL
         KPyOhyJPAX7jq0DxzzDSFDly0i7A4eRWgTQasoQO0YcfR6sBMchH/wFa1RDAb3ocp1
         yizjFpglTZjVw==
Message-ID: <4cbfcbfb-4d77-83e9-f5f2-d8752d8860eb@collabora.com>
Date:   Mon, 16 Jan 2023 08:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/12] staging: media: rkvdec: Helper for buffer queue
 busy check
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
 <20230101-patch-series-v2-6-2-rc1-v2-3-fa1897efac14@collabora.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-3-fa1897efac14@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

W dniu 12.01.2023 o 13:56, Sebastian Fricke pisze:
> Implement a helper function, wrapping around getting a vb2 queue and
> checking whether it is busy, to reduce the amount of code duplication in
> the driver.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>   drivers/staging/media/rkvdec/rkvdec.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 7bab7586918c..c849f6c20279 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -27,6 +27,17 @@
>   #include "rkvdec.h"
>   #include "rkvdec-regs.h"
>   
> +static int rkvdec_queue_busy(struct rkvdec_ctx *ctx, enum v4l2_buf_type buf_type)
> +{
> +	struct vb2_queue *vq;
> +
> +	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, buf_type);
> +	if (vb2_is_busy(vq))
> +		return -EBUSY;
> +	else
> +		return 0;

Optionally you can use the ternary operator:

return vb2_is_busy(vg) ? -EBUSY : 0;

But then this new function essentially becomes a wrapper around extracting
the vq. The wrapper then encodes its result in the return value,
which is later decoded at call site to only return -EBUSY if the wrapper
returns -EBUSY and ignore the result if 0. This makes me think that
maybe you want a macro instead:

#define rkvdec_queue_busy(ctx, type) \
	vb2_is_busy(v4l2_m2m_get_vq((ctx)->fh.m2m_ctx, (type)))

and call it like this:

if (rkvdec_queue_busy(c, t))
	return -EBUSY;

> +}
> +
>   static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>   {
>   	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> @@ -311,13 +322,10 @@ static int rkvdec_s_capture_fmt(struct file *file, void *priv,
>   				struct v4l2_format *f)
>   {
>   	struct rkvdec_ctx *ctx = fh_to_rkvdec_ctx(priv);
> -	struct vb2_queue *vq;
>   	int ret;
>   
>   	/* Change not allowed if queue is busy */
> -	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> -			     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> -	if (vb2_is_busy(vq))
> +	if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) != 0)

if you keep the current version you can drop the "!= 0"

Regards,

Andrzej

>   		return -EBUSY;
>   
>   	ret = rkvdec_try_capture_fmt(file, priv, f);
> @@ -335,7 +343,7 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
>   	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
>   	const struct rkvdec_coded_fmt_desc *desc;
>   	struct v4l2_format *cap_fmt;
> -	struct vb2_queue *peer_vq, *vq;
> +	struct vb2_queue *vq;
>   	int ret;
>   
>   	/*
> @@ -354,8 +362,7 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
>   	 * queue, we can't allow doing so when the CAPTURE queue has buffers
>   	 * allocated.
>   	 */
> -	peer_vq = v4l2_m2m_get_vq(m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> -	if (vb2_is_busy(peer_vq))
> +	if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) != 0)
>   		return -EBUSY;
>   
>   	ret = rkvdec_try_output_fmt(file, priv, f);
> 

