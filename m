Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3269BA18
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBRM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBRM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:56:27 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EA10D7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 04:56:24 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 189so740243oih.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112; t=1676724983;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4T/3VjZ2wUE2kiltfp+IEnD9NbcnF/4jn4QQsLwaKQ=;
        b=WFUutkwQzJllOyCFl9Tyt7c/8C1QB8tGsITnK6uGdRDVGT89Qb2gvLDjJTqHdqbERm
         O1tgIm2GRydG5xAtQIq7fzmGRdLlHSkhVmwHNWVGsn3cTaaH10X1aLWx1g9Ca0TJpQ5s
         13bE9b8pvo6mNhvEa0GpyawCPzWE6gyQCMZbZdK6CjoEGktQB5WBwOJCBLRYGS3niNpH
         ita6/hfL7rvhIpfu0UIMp8fadhGLrW03XniCzlrB5FUqAWMIzf8Y3OdOEPxvoUqHVbY/
         lcIYIGjOReCACIMFdDY524OJziMs3E40n4Xs4FhPM73MTbDWVLdEgOJrBsnpHDMugxht
         0jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676724983;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4T/3VjZ2wUE2kiltfp+IEnD9NbcnF/4jn4QQsLwaKQ=;
        b=ETOsnQ1uNOCGilK8gfjwsTaKqEZqP2qejDa7vgS+267EKL7ySvRut/EoCsOpBJj+CQ
         gtyaikFf9IwJR+hQ1yRHGO/Wbb4uZAvkPmA2JxyqEAZq1GSLx/N7g3kqdYqgodQ7nDud
         3SH3FMnGTE0iAjfigKB4lA1mlJEjh9sWGJnHupppMRelDLiHWPB2u2Mqf03Qzt4c70Jl
         P8JNEQsDzsNo+Qvgt2ciSniqtBnyg6uTmJKjg1sWj9Ths363e3I9tcSeoL3wjVC6BxQ6
         31ovBOaeusB6+2ygfV/58LWH2G7LCWsdo4RYk/b17yVSLX03j5BKxmjyje5AgvUKpL27
         dRvQ==
X-Gm-Message-State: AO0yUKUMmUGV/2Wr377U20n9H1k+8wz8dnNPg2d//JIGgd6ShuiBWV4d
        uwxDEasJUh+WHfHHy4I++QE7sA==
X-Google-Smtp-Source: AK7set+eMXV7537L5Whj6keT9oGEqRHiBF5BCK2/XFF63eFpDJ+bIyReLkdZb0jCLH19KzS79utdZA==
X-Received: by 2002:a05:6808:21a1:b0:37f:acb8:cd8f with SMTP id be33-20020a05680821a100b0037facb8cd8fmr3108272oib.0.1676724983375;
        Sat, 18 Feb 2023 04:56:23 -0800 (PST)
Received: from [192.168.10.175] ([190.11.59.127])
        by smtp.gmail.com with ESMTPSA id w13-20020a9d538d000000b00690e6d56670sm2150969otg.25.2023.02.18.04.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 04:56:22 -0800 (PST)
Date:   Sat, 18 Feb 2023 09:56:11 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v8 2/6] media: verisilicon: Do not use ctx fields as
 format storage when resetting
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Message-Id: <N91AQR.BQFKAM8JI9HC2@vanguardiasur.com.ar>
In-Reply-To: <20230203091622.127279-3-benjamin.gaignard@collabora.com>
References: <20230203091622.127279-1-benjamin.gaignard@collabora.com>
        <20230203091622.127279-3-benjamin.gaignard@collabora.com>
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

Hi Benjamin,

On Fri, Feb 3 2023 at 10:16:18 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> Source and destination pixel formats fields of context structure 
> should
> not be used as storage when resetting the format.
> Use local variables instead and let hantro_set_fmt_out() and
> hantro_set_fmt_cap() set them correctly later.
> 
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
> 

The above Fixes tag looks incorrect. I am unsure what would be the
right Fixes, perhaps we can avoid putting any?

Same for all the other patches, the Fixes tag look wrong.

Thanks,
Ezequiel

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/platform/verisilicon/hantro_v4l2.c  | 40 
> +++++++++----------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c 
> b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 33cb865238de..e60151a8a401 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -377,47 +377,43 @@ static void
>  hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>  {
>  	const struct hantro_fmt *vpu_fmt;
> -	struct v4l2_pix_format_mplane *fmt;
> +	struct v4l2_pix_format_mplane fmt;
> 
>  	vpu_fmt = hantro_get_default_fmt(ctx, true);
> +	if (!vpu_fmt)
> +		return;
> 
> +	hantro_reset_fmt(&fmt, vpu_fmt);
> +	fmt.width = vpu_fmt->frmsize.min_width;
> +	fmt.height = vpu_fmt->frmsize.min_height;
>  	if (ctx->is_encoder)
> -		fmt = &ctx->dst_fmt;
> -	else
> -		fmt = &ctx->src_fmt;
> -
> -	hantro_reset_fmt(fmt, vpu_fmt);
> -	fmt->width = vpu_fmt->frmsize.min_width;
> -	fmt->height = vpu_fmt->frmsize.min_height;
> -	if (ctx->is_encoder)
> -		hantro_set_fmt_cap(ctx, fmt);
> +		hantro_set_fmt_cap(ctx, &fmt);
>  	else
> -		hantro_set_fmt_out(ctx, fmt);
> +		hantro_set_fmt_out(ctx, &fmt);
>  }
> 
>  static void
>  hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  {
>  	const struct hantro_fmt *raw_vpu_fmt;
> -	struct v4l2_pix_format_mplane *raw_fmt, *encoded_fmt;
> +	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
> 
>  	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
> +	if (!raw_vpu_fmt)
> +		return;
> 
> -	if (ctx->is_encoder) {
> -		raw_fmt = &ctx->src_fmt;
> +	if (ctx->is_encoder)
>  		encoded_fmt = &ctx->dst_fmt;
> -	} else {
> -		raw_fmt = &ctx->dst_fmt;
> +	else
>  		encoded_fmt = &ctx->src_fmt;
> -	}
> 
> -	hantro_reset_fmt(raw_fmt, raw_vpu_fmt);
> -	raw_fmt->width = encoded_fmt->width;
> -	raw_fmt->height = encoded_fmt->height;
> +	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
> +	raw_fmt.width = encoded_fmt->width;
> +	raw_fmt.height = encoded_fmt->height;
>  	if (ctx->is_encoder)
> -		hantro_set_fmt_out(ctx, raw_fmt);
> +		hantro_set_fmt_out(ctx, &raw_fmt);
>  	else
> -		hantro_set_fmt_cap(ctx, raw_fmt);
> +		hantro_set_fmt_cap(ctx, &raw_fmt);
>  }
> 
>  void hantro_reset_fmts(struct hantro_ctx *ctx)
> --
> 2.34.1
> 


