Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14486A2F89
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBZM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBZM72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:59:28 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F63C671
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:59:27 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-172334d5c8aso4868320fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112; t=1677416367;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEEIkfCEKNb+yJat01VLOoIx0jwHxX8KxFsxTv/3AWA=;
        b=5JV/brtC/PBagCV/s/mJY0JaOjX9a5frBx9rjjhs3gEx+4/C4wrI02ciyPAStBAOum
         EHKuBPo21xtkjlesjuo+pFCcM87pyOP+A/6HMV3YRoW8km3QQvun3wM6lKRbISJAZfhW
         FqXM4IKLi4Vki8I8PdUGixXpy41VKkGLiyWH2g52PUiaxyOopz8E7ajvPkGjFgZdJuA6
         pXetR7sXEs0X2CL0Z6Ex53dgTurtcdUZ0iC4o5+WmSun0Cu2ue2ny0kbfEd3JFZ6H/tF
         bS5i7mvKOlmqV9/ETi362Z3XEBZJGhMkROVb8s6wZqPhEN8BrtThVJjh3R2aDxegP30P
         Cecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677416367;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEEIkfCEKNb+yJat01VLOoIx0jwHxX8KxFsxTv/3AWA=;
        b=0EzswcMAk2Jagt2TVNABheFCLORIydXMWwTETFlswgYU8ZGr597saqdZnxK7JdTo+f
         /kP9eICfXswTgtOicBPP+Otcn4mlX3U3BVAki/eK+kWnp1kQb10hhRLAH5cGxd6tYwIK
         O9pb6TM4MbLFyL2brb8mJVB2E9LkNgj+5CJ7NGGciVOabeFuNkmsRPL3Swsk0uorC6dv
         6b7Y+A1g5YoNgNdo7gMtmbLBPN8YEE68BHAO7dOoXEWm+EoGjvPF246nDl1jQZJ/Dqz5
         RB7e1P19cemqlZYolaJ8v8QVr5EIaXX8225BkBLpzbrWIAT2itX4HJNqq1tYe+F1vfqx
         Ptxg==
X-Gm-Message-State: AO0yUKWLweVATffoP8c6mtpBGFOm21HWMpmeM3vBwecXD1z4D6AWYul2
        HcHXzXywUyeVdjPpRzYLGWswgQ==
X-Google-Smtp-Source: AK7set+8v7z6Aboy4L5hWmdTsc35qvdCVTbUT1gATzHCTVITOJivrC5DQc8wDB7PLDGXPVo/hsPq6g==
X-Received: by 2002:a05:6870:e88f:b0:172:8985:95c5 with SMTP id q15-20020a056870e88f00b00172898595c5mr6606295oan.0.1677416367029;
        Sun, 26 Feb 2023 04:59:27 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.26])
        by smtp.gmail.com with ESMTPSA id q21-20020a056870e89500b0017256ba1fd0sm779737oan.41.2023.02.26.04.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:59:26 -0800 (PST)
Date:   Sun, 26 Feb 2023 09:59:14 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v9 3/6] media: verisilicon: Do not set ctx->bit_depth in
 hantro_try_ctrl()
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, robert.mader@collabora.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Message-Id: <QQUOQR.DDXB801QURT72@vanguardiasur.com.ar>
In-Reply-To: <20230220104849.398203-4-benjamin.gaignard@collabora.com>
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
        <20230220104849.398203-4-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Feb 20 2023 at 11:48:46 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> In hantro_try_ctrl() we should only check the values inside
> control parameters and not set ctx->bit_depth. That must
> be done in controls set function.
> Create a set control function for hevc where ctx->bit_depth is
> set at the right time.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  .../media/platform/verisilicon/hantro_drv.c   | 32 
> ++++++++++++++-----
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c 
> b/drivers/media/platform/verisilicon/hantro_drv.c
> index b0aeedae7b65..c237253803f4 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, 
> struct vb2_queue *dst_vq)
> 
>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct hantro_ctx *ctx;
> -
> -	ctx = container_of(ctrl->handler,
> -			   struct hantro_ctx, ctrl_handler);
> -
>  	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>  		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
> 
> @@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 
> != 2)
>  			/* Only 8-bit and 10-bit are supported */
>  			return -EINVAL;
> -
> -		ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;
>  	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>  		const struct v4l2_ctrl_vp9_frame *dec_params = 
> ctrl->p_new.p_vp9_frame;
> 
> @@ -324,6 +317,24 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl 
> *ctrl)
>  	return 0;
>  }
> 
> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx = container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_HEVC_SPS:
> +		ctx->bit_depth = ctrl->p_new.p_hevc_sps->bit_depth_luma_minus8 + 8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>  	.try_ctrl = hantro_try_ctrl,
>  };
> @@ -336,6 +347,11 @@ static const struct v4l2_ctrl_ops 
> hantro_vp9_ctrl_ops = {
>  	.s_ctrl = hantro_vp9_s_ctrl,
>  };
> 
> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
> +	.try_ctrl = hantro_try_ctrl,
> +	.s_ctrl = hantro_hevc_s_ctrl,
> +};
> +
>  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>  					 V4L2_JPEG_ACTIVE_MARKER_COM | \
>  					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -470,7 +486,7 @@ static const struct hantro_ctrl controls[] = {
>  		.codec = HANTRO_HEVC_DECODER,
>  		.cfg = {
>  			.id = V4L2_CID_STATELESS_HEVC_SPS,
> -			.ops = &hantro_ctrl_ops,
> +			.ops = &hantro_hevc_ctrl_ops,
>  		},
>  	}, {
>  		.codec = HANTRO_HEVC_DECODER,
> --
> 2.34.1
> 


