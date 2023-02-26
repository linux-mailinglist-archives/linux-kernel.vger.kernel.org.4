Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C615D6A2F87
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBZM7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZM7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:59:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B3BBB8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:58:59 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id cc12-20020a05683061cc00b00693daa9016fso2185996otb.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xU2OW9b85rVHMCoQmN+vBOcqQqQ6/K7t9dGl9R42A6I=;
        b=4fIVpSHDVNIQ0r88f46kz+NnERZrjK9/Nhc/cxBrGIntIe8RjuD3O9v1DCNNFuws8m
         6H3jRVkyZ7FabGfG0xxoO4bZiO96MZW7zy8+O30cg8+v8NpXgxDVQ2ok/pI819pXjqAV
         uDrrVweItV1qixLTHxPogaveel567Wr2yahjYbetowht8jzk4DIHfpkkgZ+9DyAX1TpF
         nDGT/pazv0vMDG/xFccPk9WDDlmOAXHUKw83O6h8AtaTOLnd243wPwz4BupwRqT43HG5
         IjMHZOJ4vcyW9oq0Hl/gh9SbnzpMHBZJwZEwTYo8b/Zo4GvXQgPxEvwrCvu2gowQq/ZI
         ziNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU2OW9b85rVHMCoQmN+vBOcqQqQ6/K7t9dGl9R42A6I=;
        b=huVSMCWBYRAoLIB1aFnsDec11zQH8f81ft5OUb4OFy1rwxWDdLeIS1QVRmq7gtbKuM
         +YcCxYSngkEsgQygYPbqNpIlARbSrnrPoPVNo90ZGWxVGy1Jh8KQTeh+Fvxl1Bwu+FsL
         uIu5LU64M4wmmZmKHY0cs6AXj4KSvn16K1MYmi/QADBRqpfAYbxQCSvA5M1bCjJNn3BN
         Ao7o7y99w3iix6/jfEt0/UaGF9ws6FlH11TSES8jTb3DdkoXUxy/ZgbWaaA9+Q792Q1c
         Ch18UxoHiosJSGUXvzUqIgZ93qbFgBIOaobXLoFiu7ScTZKeN12T057ix3xPWeLAfJs/
         NNew==
X-Gm-Message-State: AO0yUKVLbgzRs4uoGFAyKKo7Icujcp8EaJMJ2lIWhZ0gmwL4jXatL32c
        /Gx8E+9M+PTQjXGmpYSsa6s+uw==
X-Google-Smtp-Source: AK7set/8fqgkojKXCsfLPehtswAr1bPNfmLFCKRTN5FsAKnf51p72+FZXgPWNWIkOhGUT60DoFpQiA==
X-Received: by 2002:a05:6830:2470:b0:686:40e1:2bf3 with SMTP id x48-20020a056830247000b0068640e12bf3mr10316085otr.0.1677416339082;
        Sun, 26 Feb 2023 04:58:59 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.26])
        by smtp.gmail.com with ESMTPSA id w11-20020a9d70cb000000b0068bb3a9e2b9sm1533016otj.77.2023.02.26.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:58:58 -0800 (PST)
Date:   Sun, 26 Feb 2023 09:58:47 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v9 2/6] media: verisilicon: Do not use ctx fields as
 format storage when resetting
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, robert.mader@collabora.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Message-Id: <ZPUOQR.4QD6IOKPPRQ@vanguardiasur.com.ar>
In-Reply-To: <20230220104849.398203-3-benjamin.gaignard@collabora.com>
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
        <20230220104849.398203-3-benjamin.gaignard@collabora.com>
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



On Mon, Feb 20 2023 at 11:48:45 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> Source and destination pixel formats fields of context structure 
> should
> not be used as storage when resetting the format.
> Use local variables instead and let hantro_set_fmt_out() and
> hantro_set_fmt_cap() set them correctly later.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  .../media/platform/verisilicon/hantro_v4l2.c  | 40 
> +++++++++----------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c 
> b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index d8aa42bd4cd4..d94c99f875c8 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -378,47 +378,43 @@ static void
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


