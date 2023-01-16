Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3366BC10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjAPKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjAPKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:43:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A01A4B1;
        Mon, 16 Jan 2023 02:42:20 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A84B6602B33;
        Mon, 16 Jan 2023 10:42:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673865738;
        bh=xij3rwdRDRnxNe9fbFCug+kKCRkyGZuk5HRqHXMn734=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TuHE446oUwwn8hpiRvkBLfCFnRI5fZhkkArAP7gGM9Gl7YWLAkt4xWOTYx53RP9ni
         QrHGUTR0Bf1NRJZCjpXo5+SqPv4bU9yIOAFOm1hkZ5gtyenUlJWoFUNWbEyujnazv7
         c0VSl5ORgrj1QBkTyD6COgmtYLjzxQ24+FYYDxgvDjO9PF/bu5g5SbNF9MpJv1NUuQ
         gxUkZKoAHsYsC8wmsKSlLZw6OafJlTkQ6C/Qk4cQGS9SpDuC2LIjLwgaTxP1qHDC6G
         LHg6YvujLLrD8cgOaM3VHPNmI0d32tvaeUWddWSZX5f/VS9fxSjUNHhxnf0PmEd/8F
         y7ANx7rKh/OJg==
Message-ID: <2835d8cb-2652-1ac5-fff1-23928c0e569c@collabora.com>
Date:   Mon, 16 Jan 2023 11:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/12] staging: media: rkvdec: Wrapper for pixel format
 preparation
Content-Language: en-US
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
 <20230101-patch-series-v2-6-2-rc1-v2-10-fa1897efac14@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-10-fa1897efac14@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

W dniu 12.01.2023 o 13:56, Sebastian Fricke pisze:
> Reduce code duplication by creating a wrapper around the preparation of
> the `v4l2_pix_format_mplane` structure and the calculation of the
> image size.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>   drivers/staging/media/rkvdec/rkvdec.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 8d948bcc4e46..b303c6e0286d 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -27,6 +27,17 @@
>   #include "rkvdec.h"
>   #include "rkvdec-regs.h"
>   
> +static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
> +				       struct v4l2_pix_format_mplane *pix_mp)
> +{
> +	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> +			    pix_mp->width, pix_mp->height);
> +	pix_mp->plane_fmt[0].sizeimage += 128 *
> +		DIV_ROUND_UP(pix_mp->width, 16) *
> +		DIV_ROUND_UP(pix_mp->height, 16);
> +	pix_mp->field = V4L2_FIELD_NONE;
> +}
> +
>   static int rkvdec_queue_busy(struct rkvdec_ctx *ctx, enum v4l2_buf_type buf_type)
>   {
>   	struct vb2_queue *vq;
> @@ -248,13 +259,9 @@ static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
>   
>   	rkvdec_reset_fmt(ctx, f, valid_fmt);
>   	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> -	v4l2_fill_pixfmt_mp(&f->fmt.pix_mp,
> -			    ctx->coded_fmt_desc->decoded_fmts[0],
> -			    ctx->coded_fmt.fmt.pix_mp.width,
> -			    ctx->coded_fmt.fmt.pix_mp.height);
> -	f->fmt.pix_mp.plane_fmt[0].sizeimage += 128 *
> -		DIV_ROUND_UP(f->fmt.pix_mp.width, 16) *
> -		DIV_ROUND_UP(f->fmt.pix_mp.height, 16);
> +	f->fmt.pix_mp.width = ctx->coded_fmt.fmt.pix_mp.width;
> +	f->fmt.pix_mp.height = ctx->coded_fmt.fmt.pix_mp.height;
> +	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);

Strictly technically this function has _not_ been setting pix_mt->field
to V4L2_FIELD_NONE, but after this change there exists such a "side effect".
Maybe it is actually desired, or maybe it being missing in the not patched
version was a mistake in the first place. Just letting you know so that
you can make sure pix_mp->field being actually set now is ok in the context
of rkvdec_queue_busy().

Regards,

Andrzej

>   }
>   
>   static int rkvdec_enum_framesizes(struct file *file, void *priv,
> @@ -324,13 +331,7 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
>   				       &pix_mp->height,
>   				       &coded_desc->frmsize);
>   
> -	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> -			    pix_mp->width, pix_mp->height);
> -	pix_mp->plane_fmt[0].sizeimage +=
> -		128 *
> -		DIV_ROUND_UP(pix_mp->width, 16) *
> -		DIV_ROUND_UP(pix_mp->height, 16);
> -	pix_mp->field = V4L2_FIELD_NONE;
> +	rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
>   
>   	return 0;
>   }
> 

