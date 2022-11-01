Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9139861555D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKAW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKAW45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:56:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED3FD2B;
        Tue,  1 Nov 2022 15:56:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a13so23949775edj.0;
        Tue, 01 Nov 2022 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd8jKs4tdxesO+PR444FHbSJvw1vCZI71YqUB5zSy+4=;
        b=noZZW365vyPqp3/6l2w0rgrza+Jf6SMdGGiPeaq6IEEN7MqNKRvnmpTk9Zveysb8zB
         jJinoewyBEvOaD09hH0w/rVPIhztdHfmiWaOkI8A6mBiOv/Uzn9UhFxTu2cvnCaHhfzG
         Mt5oPSO+Wj3L5g1Ad3Z7/XZtsvXHICy0jXW4XzlYaa95ruiBFHokOSbLhbC9LV7MBsqp
         OI2ULAZ44X73SHOsNGrhRAJQ5v607QIQCkF9oo49R4Jw63SzNeaYKwgyXTWRbHfz0TLp
         vxDQvHqWUwy1a4uUJ76tCkLH5YtaIHpnE/eJDC/tCC5Zl/OUvFGrxM4U8W3SslGR5FSc
         vfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd8jKs4tdxesO+PR444FHbSJvw1vCZI71YqUB5zSy+4=;
        b=KpShpuGI/UlLdo+73qlGXwMbK+t3Aij17XrGSO3gCQG8ZwXxOENjWvz8sxnCSQyuba
         W2JcjKqHQifmOeEu4lZ+Jn3WY/ySxUO977IsEaIvCfdxVJc8EFtZAMkaVTh3fndVi2tK
         HIQPFkUfS4cfYEQM7ArPf5nwKJ95Wz/gKnOHan1vcIoHx1QU204Sp0pGMNACMAAABn//
         NTA+UEQp6vSDVrgrSwi8+1EBUkd+iAJSkdHfYwCFlLzZHHJv+V3j3NIepmNge7Xic29F
         5skR49v46liB2XNIvg7Txs673/T4/UVJIauqwn9tRWbAwYguR1nSIBpQskSEk5lHMAno
         nabw==
X-Gm-Message-State: ACrzQf000o3flOk1lRMSMmv6CZKAgx59hunCOLuZlBJL4AVsO3ZKo95G
        vcj3JYVcF7q3wErtLxlm5aU=
X-Google-Smtp-Source: AMsMyM7Gxfvvt5MNrTj+Wb0osWhHMipmKhBlCHZudlpAsGu/WDGgLWZlqNMFKFid6V9BPYw1VcvL+w==
X-Received: by 2002:aa7:d996:0:b0:461:88b8:c581 with SMTP id u22-20020aa7d996000000b0046188b8c581mr21435355eds.111.1667343411529;
        Tue, 01 Nov 2022 15:56:51 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id b7-20020a0564021f0700b00458a03203b1sm4992951edb.31.2022.11.01.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:56:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] media: cedrus: Filter controls based on capability
Date:   Tue, 01 Nov 2022 23:56:49 +0100
Message-ID: <5872247.lOV4Wx5bFT@kista>
In-Reply-To: <20221024201515.34129-6-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com> <20221024201515.34129-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 24. oktober 2022 ob 22:15:09 CET je Jernej Skrabec napisal(a):
> Because not all Cedrus variants supports all codecs, controls should be
> registered only if codec related to individual control is supported by
> Cedrus.
> 
> Replace codec enum, which is not used at all, with capabilities flags
> and register control only if capabilities are met.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 45 +++++++++++----------
>  drivers/staging/media/sunxi/cedrus/cedrus.h |  2 +-
>  2 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c
> b/drivers/staging/media/sunxi/cedrus/cedrus.c index
> 2f284a58d787..023566b02dc5 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -77,56 +77,56 @@ static const struct cedrus_control cedrus_controls[] = {
> .cfg = {
>  			.id	= 
V4L2_CID_STATELESS_MPEG2_SEQUENCE,
>  		},
> -		.codec		= CEDRUS_CODEC_MPEG2,
> +		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_MPEG2_PICTURE,
>  		},
> -		.codec		= CEDRUS_CODEC_MPEG2,
> +		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_MPEG2_QUANTISATION,
>  		},
> -		.codec		= CEDRUS_CODEC_MPEG2,
> +		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_H264_DECODE_PARAMS,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_H264_SLICE_PARAMS,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_H264_SPS,
>  			.ops	= &cedrus_ctrl_ops,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_H264_PPS,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_H264_SCALING_MATRIX,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_H264_PRED_WEIGHTS,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
> @@ -134,7 +134,7 @@ static const struct cedrus_control cedrus_controls[] = {
> .max	= V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
>  			.def	= 
V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
> @@ -142,7 +142,7 @@ static const struct cedrus_control cedrus_controls[] = {
> .max	= V4L2_STATELESS_H264_START_CODE_NONE,
>  			.def	= 
V4L2_STATELESS_H264_START_CODE_NONE,
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	/*
>  	 * We only expose supported profiles information,
> @@ -160,20 +160,20 @@ static const struct cedrus_control cedrus_controls[] =
> { .menu_skip_mask =
>  				
BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
>  		},
> -		.codec		= CEDRUS_CODEC_H264,
> +		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_HEVC_SPS,
>  			.ops	= &cedrus_ctrl_ops,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_HEVC_PPS,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
> @@ -181,13 +181,13 @@ static const struct cedrus_control cedrus_controls[] =
> { /* The driver can only handle 1 entry per slice for now */
>  			.dims   = { 1 },
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= 
V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
> @@ -197,7 +197,7 @@ static const struct cedrus_control cedrus_controls[] = {
> .max = 0xffffffff,
>  			.step = 1,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
> @@ -205,7 +205,7 @@ static const struct cedrus_control cedrus_controls[] = {
> .max	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
>  			.def	= 
V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
> @@ -213,19 +213,19 @@ static const struct cedrus_control cedrus_controls[] =
> { .max	= V4L2_STATELESS_HEVC_START_CODE_NONE,
>  			.def	= 
V4L2_STATELESS_HEVC_START_CODE_NONE,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_VP8_FRAME,
>  		},
> -		.codec		= CEDRUS_CODEC_VP8,
> +		.capabilities	= CEDRUS_CAPABILITY_VP8_DEC,
>  	},
>  	{
>  		.cfg = {
>  			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
>  		},
> -		.codec		= CEDRUS_CODEC_H265,
> +		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
>  	},
>  };
> 
> @@ -275,6 +275,9 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev,
> struct cedrus_ctx *ctx) return -ENOMEM;
> 
>  	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
> +		if (!cedrus_is_capable(ctx, 
cedrus_controls[i].capabilities))
> +			continue;

While it's not visible from this commit, above filtering causes issues when 
searching for controls in ctx->ctrls[]. Now are not packed together and search 
functions (cedrus_find_control_data, cedrus_get_num_of_controls) rely on 
controls not being null. null control marks end of the array.

I'll fix that in next revision.

Best regards,
Jernej

> +
>  		ctrl = v4l2_ctrl_new_custom(hdl, 
&cedrus_controls[i].cfg,
>  					    NULL);
>  		if (hdl->error) {
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> 1a98790a99af..7a1619967513 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -57,7 +57,7 @@ enum cedrus_h264_pic_type {
> 
>  struct cedrus_control {
>  	struct v4l2_ctrl_config cfg;
> -	enum cedrus_codec	codec;
> +	unsigned int		capabilities;
>  };
> 
>  struct cedrus_h264_run {
> --
> 2.38.1


