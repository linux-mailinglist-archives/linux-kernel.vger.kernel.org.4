Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7365D6619CB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjAHVNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjAHVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:12:51 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA136565
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:12:48 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id g14so6993393ljh.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x53uwOLKbwK81PFlMs31vANCaDhh1Zsvs/a9zuGpPQk=;
        b=0PDk1gKy7Bf3a6EwyRvCAxmVMnlOtuNpFYpwSfF8y6YltxiIQb7a28VlfLbdiYUi6Z
         8MUnG9BR3yVVQpLQU8XqLEmftHA2d1Gw5X/S61ZSMcY9nerIvO6sUXlrqj5+Ry8uK6s4
         9+cxshzjPhDQxmL8A46alekPNVEs72Y5+5WPOa/B1jrup3Id5EloKkFXO0A1+jXx9HcN
         4DK1RRwIkfvPYHrFAU2H0zcozt4Orl+qAk871SXv+SFwN217D4TvTQj04jycZig2r0f2
         EQxBzqR9uic9UGoshpdACfObFi9jPenr8z/7THbGN2Te4ymD3Z1yCRA1igE8Ygf8s6Xr
         +M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x53uwOLKbwK81PFlMs31vANCaDhh1Zsvs/a9zuGpPQk=;
        b=MMguic+F4N5lFjbHrHjs9r0Y+v+MFjb/XSrGEEFZq/MbGG4yGPUhQ9BanK/DbEzJ7u
         8e9Lep2jBObUDuU1mySSE6h6vy+xlWcpu4KeKF8MyMyLHBTaz6ahTK54zkA91HGM0WLg
         RPWzBjOr9sHtyIRRvRD3ES2z0ClA5u3ICCFNxMpLbvWIhVKCyauLKtxnTwHuQvcVPRTt
         M/56MLXDOAmLAkKWMiCKec8Ju54m0VS2PmLsIIHGR3YzEdOFh59S8JFwfSRyeW3XdonS
         IxJeP6N4fYNAAWX6wj7f4E8/ZuXgkSljFbCetkMlyX02ZC8UgSz+dTfu1on5OOgoNzW4
         8hAA==
X-Gm-Message-State: AFqh2kqENrBIfSKUxCQapVENMecdO1r5Ls/RaDYzIAnyIVIjTLzymF6W
        InpZHZX8qZLdJSeZJ42XofmSgNkajQTaE4kCqQgl6Q==
X-Google-Smtp-Source: AMrXdXssLooCUB3JcSjFGQGlVuCaFAVGO6fwtMCDpc/mUlglB++tww+r2xlSFr4vPtbjYEwsLwWpTCjfAlStv55FVrU=
X-Received: by 2002:a2e:90d2:0:b0:27f:f22d:afe9 with SMTP id
 o18-20020a2e90d2000000b0027ff22dafe9mr1990761ljg.404.1673212366368; Sun, 08
 Jan 2023 13:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com> <20230103170058.810597-14-benjamin.gaignard@collabora.com>
In-Reply-To: <20230103170058.810597-14-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 8 Jan 2023 18:12:34 -0300
Message-ID: <CAAEAJfBRtBSZt0B3OyQSCHhsseUn6_H+JSvAR3cOH15WUryuNw@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] media: verisilicon: Conditionnaly ignore native formats
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 2:01 PM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> AV1 film grain feature requires to use the postprocessor to produce
> valid frames. In such case the driver shouldn't propose native pixels
> format but only post-processed pixels format.
> If a codec set need_postproc field in hantro_ctx structure to true
> native pixel formats will be ignored.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro.h   |  3 ++
>  .../media/platform/verisilicon/hantro_drv.c   |  5 ++
>  .../platform/verisilicon/hantro_postproc.c    |  4 ++
>  .../media/platform/verisilicon/hantro_v4l2.c  | 46 +++++++++++++------
>  4 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index a98cb40a8d3b..7a5357e810fb 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -231,6 +231,8 @@ struct hantro_dev {
>   * @ctrl_handler:      Control handler used to register controls.
>   * @jpeg_quality:      User-specified JPEG compression quality.
>   * @bit_depth:         Bit depth of current frame
> + * @need_postproc:     Set to true if the bitstream features require to
> + *                     use the post-processor.
>   *
>   * @codec_ops:         Set of operations related to codec mode.
>   * @postproc:          Post-processing context.
> @@ -258,6 +260,7 @@ struct hantro_ctx {
>         struct v4l2_ctrl_handler ctrl_handler;
>         int jpeg_quality;
>         int bit_depth;
> +       bool need_postproc;
>
>         const struct hantro_codec_ops *codec_ops;
>         struct hantro_postproc_ctx postproc;
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 4fc6dea16ae6..8d7055c0bf3b 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -346,6 +346,11 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
>                                 return -EINVAL;
>
>                 ctx->bit_depth = bit_depth;
> +
> +               if (ctrl->p_new.p_av1_sequence->flags
> +                   & V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT)
> +                       ctx->need_postproc = true;
> +
>                 break;
>         default:
>                 return -EINVAL;
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
> index 7dc39519a2ee..293e5612e2ce 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -57,6 +57,10 @@ bool hantro_needs_postproc(const struct hantro_ctx *ctx,
>  {
>         if (ctx->is_encoder)
>                 return false;
> +
> +       if (ctx->need_postproc)
> +               return true;
> +
>         return fmt->postprocessed;
>  }
>
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index bbe79dbd2cd9..5c381766cca3 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -38,6 +38,11 @@ hantro_get_formats(const struct hantro_ctx *ctx, unsigned int *num_fmts)
>  {
>         const struct hantro_fmt *formats;
>
> +       if (ctx->need_postproc) {
> +               *num_fmts = 0;
> +               return NULL;
> +       }
> +
>         if (ctx->is_encoder) {
>                 formats = ctx->dev->variant->enc_fmts;
>                 *num_fmts = ctx->dev->variant->num_enc_fmts;
> @@ -132,6 +137,15 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
>                     hantro_check_depth_match(ctx, &formats[i]))
>                         return &formats[i];
>         }
> +
> +       formats = hantro_get_postproc_formats(ctx, &num_fmts);
> +       for (i = 0; i < num_fmts; i++) {
> +               if (bitstream == (formats[i].codec_mode !=
> +                                 HANTRO_MODE_NONE) &&
> +                   hantro_check_depth_match(ctx, &formats[i]))
> +                       return &formats[i];
> +       }
> +
>         return NULL;
>  }
>
> @@ -261,19 +275,6 @@ static int vidioc_g_fmt_out_mplane(struct file *file, void *priv,
>         return 0;
>  }
>
> -static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
> -                                  struct v4l2_format *f)
> -{
> -       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> -       struct hantro_ctx *ctx = fh_to_ctx(priv);
> -
> -       vpu_debug(4, "f->type = %d\n", f->type);
> -
> -       *pix_mp = ctx->dst_fmt;
> -
> -       return 0;
> -}
> -
>  static int hantro_try_fmt(const struct hantro_ctx *ctx,
>                           struct v4l2_pix_format_mplane *pix_mp,
>                           enum v4l2_buf_type type)
> @@ -353,6 +354,25 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
>         return 0;
>  }
>
> +static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
> +                                  struct v4l2_format *f)
> +{
> +       struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
> +       struct hantro_ctx *ctx = fh_to_ctx(priv);
> +       int ret;
> +
> +       vpu_debug(4, "f->type = %d\n", f->type);
> +
> +       ret = hantro_try_fmt(ctx, pix_mp, f->type);
> +       if (ret)
> +               return ret;
> +
> +       ctx->vpu_dst_fmt = hantro_find_format(ctx, pix_mp->pixelformat);
> +       ctx->dst_fmt = *pix_mp;
> +

This looks like the g_fmt is setting some state in the context,
this looks incorrect.

Thanks,
Ezequiel
