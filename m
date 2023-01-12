Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87C666799D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjALPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbjALPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:39:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77B532B3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:30:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j17so28974840lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iKwwjEGopbISTrCjxgfQJsmoWWl/0HgOwyebrt0JLGA=;
        b=QbI169xhV8vhsr4V43oKe3t3ypXsYwuhSqv+U3fpDtFAZlimhEns/OKDdeLbZoZmIh
         vBTAIdpXaeEx1D8wnaC3SOK1pmpgvLkcH52Ack0AR7xityglMY5G15apEjxBliyOTcKf
         KFFNUZ/wh5OgRKL1qOxea/YdXalez4QJD7y6CWBklcPj8VmiUF9OHe+7zenmpRYbEwyj
         vVdl99EChOEYB09vc3Xi2oVNySDI1Kr72mtUi2hElBPN5ZCghAltKgpET/OaAgmQjr1y
         KGcH3IH4RklrAMcPgz1IyWMrFqQh8AnpD12cHrk5PQxIO3ZQD7ZqWRNC9TEbE+lVRNPl
         asWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKwwjEGopbISTrCjxgfQJsmoWWl/0HgOwyebrt0JLGA=;
        b=l1Mr9voyg7+X8ad2cNdUs1iEBEraJ1oGXlE5Sko+MOIIMXJW7ce73Nde+GXYjFDgku
         M8Cm6e7lOOdC7k97TY6OxbfQS4vxjsbPP9yR5Iu4/QIBZ6uwSZFRj0ZvVAlba6GCLVye
         4owjVcgg5dXxmfvGtiFiyRuyrzXOFWWGWMAVjwicNQkR7A4Lcl70BeLOzfN6YO163WcN
         Z/DOv7mzFeb6StiZXZGx/xLxPBRem9NVD4f7ZoaDipfVNV+G5tOloXQXDJ484PIpeaO4
         ksLXx/vkaIxVGWBLrJ4pz3vf+9XY7VEE3Cqya9/NjHuf9oejDuv85oTeCJrvIpmuyQTo
         f4tQ==
X-Gm-Message-State: AFqh2koauogp+N5MCRPmOfWhuVf0rqmJ4A52BhujFuPIt8DBNrXV0laq
        pReDjv/Q/iedUsF5PN/EOhrv3C4x9NQgND9TsVFcxA==
X-Google-Smtp-Source: AMrXdXsfoS3G1+dA5+WKzSYh25yd+Y2eQHNON3kw/MeVVXIcC4tY8i5M8+KHlpGkY0ARtDng3p/ekgpCc9RpY74z6no=
X-Received: by 2002:a05:6512:2805:b0:4b5:b18a:c52d with SMTP id
 cf5-20020a056512280500b004b5b18ac52dmr7967483lfb.299.1673537423283; Thu, 12
 Jan 2023 07:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com> <20230101-patch-series-v2-6-2-rc1-v2-6-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-6-fa1897efac14@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 12 Jan 2023 12:30:11 -0300
Message-ID: <CAAEAJfDOcYBtWR41BLM-SUnm9oe1t=8ffJS1Kg_V-gYWzUfe8w@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] staging: media: rkvdec: Add a valid pixel format
 check as callback
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Jan 12, 2023 at 9:56 AM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
>
> Provide a callback for codec variant drivers to indicate the correct
> output pixel-format. It will either utilize the SPS structure stored via
> the S_CTRL IOCTL or return the default pixel-format.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 45 +++++++++++++++++++++++++++++------
>  drivers/staging/media/rkvdec/rkvdec.h |  1 +
>  2 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index e0e95d06e216..a46f918926a2 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -38,6 +38,20 @@ static int rkvdec_queue_busy(struct rkvdec_ctx *ctx, enum v4l2_buf_type buf_type
>                 return 0;
>  }
>
> +/*
> + * Use the current SPS, set by the user via the VIDIOC_S_CTRL IOCTL,
> + * to determine the optimal pixel-format. Each codec is responsible
> + * for choosing the appropriate pixel-format for a given parameter set.
> + */

It seems this assumes there's always only one valid format.
Do you think that will hold true always for RKVDEC and for all codecs?

How about we approach this differently? Instead of having a callback
for codecs to implement, we just maintain a list of valid decoded formats
(in the context) and re-create the list when the SPS is changed (in the S_CTRL).

Possibly simpler and less invasive, not sure if there are any caveats.

Thanks,
Ezequiel

> +static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx)
> +{
> +       const struct rkvdec_coded_fmt_desc *coded_desc = ctx->coded_fmt_desc;
> +
> +       if (coded_desc->ops->valid_fmt)
> +               return coded_desc->ops->valid_fmt(ctx);
> +       return ctx->coded_fmt_desc->decoded_fmts[0];
> +}
> +
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> @@ -200,8 +214,9 @@ static void rkvdec_reset_coded_fmt(struct rkvdec_ctx *ctx)
>  static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
>  {
>         struct v4l2_format *f = &ctx->decoded_fmt;
> +       u32 valid_fmt = rkvdec_get_valid_fmt(ctx);
>
> -       rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
> +       rkvdec_reset_fmt(ctx, f, valid_fmt);
>         f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>         v4l2_fill_pixfmt_mp(&f->fmt.pix_mp,
>                             ctx->coded_fmt_desc->decoded_fmts[0],
> @@ -260,13 +275,17 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
>         if (WARN_ON(!coded_desc))
>                 return -EINVAL;
>
> -       for (i = 0; i < coded_desc->num_decoded_fmts; i++) {
> -               if (coded_desc->decoded_fmts[i] == pix_mp->pixelformat)
> -                       break;
> -       }
> +       if (ctx->sps) {
> +               pix_mp->pixelformat = rkvdec_get_valid_fmt(ctx);
> +       } else {
> +               for (i = 0; i < coded_desc->num_decoded_fmts; i++) {
> +                       if (coded_desc->decoded_fmts[i] == pix_mp->pixelformat)
> +                               break;
> +               }
>
> -       if (i == coded_desc->num_decoded_fmts)
> -               pix_mp->pixelformat = coded_desc->decoded_fmts[0];
> +               if (i == coded_desc->num_decoded_fmts)
> +                       pix_mp->pixelformat = coded_desc->decoded_fmts[0];
> +       }
>
>         /* Always apply the frmsize constraint of the coded end. */
>         pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
> @@ -435,6 +454,18 @@ static int rkvdec_enum_capture_fmt(struct file *file, void *priv,
>         if (WARN_ON(!ctx->coded_fmt_desc))
>                 return -EINVAL;
>
> +       /*
> +        * According to the specification the driver can only return formats
> +        * that are supported by both the current encoded format and the
> +        * provided controls
> +        */
> +       if (ctx->sps) {
> +               if (f->index)
> +                       return -EINVAL;
> +               f->pixelformat = rkvdec_get_valid_fmt(ctx);
> +               return 0;
> +       }
> +
>         if (f->index >= ctx->coded_fmt_desc->num_decoded_fmts)
>                 return -EINVAL;
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index 332126e7b812..e353a4403e5b 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -66,6 +66,7 @@ vb2_to_rkvdec_decoded_buf(struct vb2_buffer *buf)
>  struct rkvdec_coded_fmt_ops {
>         int (*adjust_fmt)(struct rkvdec_ctx *ctx,
>                           struct v4l2_format *f);
> +       u32 (*valid_fmt)(struct rkvdec_ctx *ctx);
>         int (*start)(struct rkvdec_ctx *ctx);
>         void (*stop)(struct rkvdec_ctx *ctx);
>         int (*run)(struct rkvdec_ctx *ctx);
>
> --
> 2.25.1
