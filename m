Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40CC69BA27
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBRNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBRNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:11:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3C16AEA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 05:11:55 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b22so1121073lfv.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sFZb+KyGAfqdWcVh2QTgnXaoGg7pVVta8DL5jcjkaHA=;
        b=CD+nZ/SzGoNOMg8Mk2mopOlJfDYIRF3XlRUaULLdQYrYb0b/mc9ZIUbVbcb4QCrILP
         Ji7C1kzakqozOxnD+TQo2pwU9X4rm/BOxVQzd7zhTKjTdPjMswvaEDCjTNOua2xxV/EZ
         usY0cN5OWy+Q0XdeVmpy7+K+L1rtwbeG6W/jzd1IcqCnbVjgtdgz6Ctj0D20Us3acuWS
         1IkuJskkTpghq7CVu83wKyHAw5zcmCxvRu/QNKVWxdZS7zj5rYXOURQcVB8zzlMAxW8I
         YLj2ZMnLSTh5jJZdLd85/H3weSF9OZ0Tr6SngDt4oarVlcd7W7U+kAuZER3VSfNF3yeH
         xYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFZb+KyGAfqdWcVh2QTgnXaoGg7pVVta8DL5jcjkaHA=;
        b=Ejf5DkgOUKYN1CPPRkyGFwFoyQisgefWtXNMNnOubRA/GUABJjZHurQOUHnE0xP+Nb
         UvkmvH0O8Bx9Q0a8qkwssHND2vD60C9lc5MKVzo7IY/JaCqPOdH4qCcrLru3S93sOQDF
         9xVZYqLm5IyXAa6VgVzNuzAU8P7o/ekTFid92VzybXGW0vcZnfNldS7t+pguM7FuOoZx
         PvDl5dN4Tgd0ah9ahj1jicmv1LnJtppDzELi0wx1kE3nHAi2F+xs+fySba+QR6/W2Mq5
         MOUZJDtA/yJqbi6IBokBICHtyIO764o44NiK10cZsXu7kw3bROsOHLCmItxHPIkkPfxZ
         MkdA==
X-Gm-Message-State: AO0yUKUK0O0VMWZr2R+kKY9RbNL2RVVhnXOF7N9xaFfTYAqhsjVzUnz/
        qk0U9upASi9Qw+JWc+HgA2/IrX+HZd2sNaHic7jyUA==
X-Google-Smtp-Source: AK7set+eHOfizBIwI1T3DsyV1863LifcB+yOBYdN4HyMZXw04IZPDsu/+QgX/HoCnpfPWQYxjvnFFjkbay+ekbeNW8E=
X-Received: by 2002:ac2:4439:0:b0:4d5:ca43:703e with SMTP id
 w25-20020ac24439000000b004d5ca43703emr1311163lfl.1.1676725913903; Sat, 18 Feb
 2023 05:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20230214140557.537984-1-benjamin.gaignard@collabora.com> <20230214140557.537984-7-benjamin.gaignard@collabora.com>
In-Reply-To: <20230214140557.537984-7-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 18 Feb 2023 10:11:41 -0300
Message-ID: <CAAEAJfDihZND+1FSzFxT86j9u6h-wH6uMMNh7BiaEWQWtSpk=Q@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] media: verisilicon: Check AV1 bitstreams bit depth
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil@xs4all.nl, nicolas.dufresne@collabora.com,
        jernej.skrabec@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:06 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> The driver supports 8 and 10 bits bitstreams, make sure to discard
> other cases.
> It could happens that userland test if V4L2_CID_STATELESS_AV1_SEQUENCE
> exists without setting bit_depth field in this case use
> HANTRO_DEFAULT_BIT_DEPTH value.
>

This shouldn't happen.

If the bit_depth argument in hantro_check_depth_match()
can be set unchecked by userspace, we have done something wrong!!

Are you sure that userspace can do a S_CTRL with an invalid bit-depth?
The try_or_set_cluster() function seems to always call try_ctrl before s_ctrl.

Thanks,
Ezequiel

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 4:
> - This patch is the result of squashing "Save bit depth for AV1 decoder"
>   and "Check AV1 bitstreams bit depth" of version 3 + adapation to
>   "[PATCH v8 0/6] media: verisilicon: HEVC: fix 10bits handling" series.
>
>  .../media/platform/verisilicon/hantro_drv.c   | 36 +++++++++++++++++++
>  .../media/platform/verisilicon/hantro_v4l2.c  |  4 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index bc1a85456142..666cd46902da 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -275,7 +275,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>                 /* We only support profile 0 */
>                 if (dec_params->profile != 0)
>                         return -EINVAL;
> +       } else if (ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE) {
> +               const struct v4l2_ctrl_av1_sequence *sequence = ctrl->p_new.p_av1_sequence;
> +
> +               if (sequence->bit_depth != 8 && sequence->bit_depth != 10)
> +                       return -EINVAL;
>         }
> +
>         return 0;
>  }
>
> @@ -348,6 +354,30 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +       struct hantro_ctx *ctx;
> +
> +       ctx = container_of(ctrl->handler,
> +                          struct hantro_ctx, ctrl_handler);
> +
> +       switch (ctrl->id) {
> +       case V4L2_CID_STATELESS_AV1_SEQUENCE:
> +       {
> +               int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
> +
> +               if (ctx->bit_depth == bit_depth)
> +                       return 0;
> +
> +               return hantro_reset_raw_fmt(ctx, bit_depth);
> +       }
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>         .try_ctrl = hantro_try_ctrl,
>  };
> @@ -365,6 +395,11 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
>         .s_ctrl = hantro_hevc_s_ctrl,
>  };
>
> +static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops = {
> +       .try_ctrl = hantro_try_ctrl,
> +       .s_ctrl = hantro_av1_s_ctrl,
> +};
> +
>  #define HANTRO_JPEG_ACTIVE_MARKERS     (V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>                                          V4L2_JPEG_ACTIVE_MARKER_COM | \
>                                          V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -542,6 +577,7 @@ static const struct hantro_ctrl controls[] = {
>                 .codec = HANTRO_AV1_DECODER,
>                 .cfg = {
>                         .id = V4L2_CID_STATELESS_AV1_SEQUENCE,
> +                       .ops = &hantro_av1_ctrl_ops,
>                 },
>         }, {
>                 .codec = HANTRO_AV1_DECODER,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 992c5baa929f..7e74e47c9a89 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -86,6 +86,10 @@ hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
>         if (!fmt->match_depth && !fmt->postprocessed)
>                 return true;
>
> +       /* 0 means default depth, which is 8 */
> +       if (!bit_depth)
> +               bit_depth = HANTRO_DEFAULT_BIT_DEPTH;
> +
>         fmt_depth = hantro_get_format_depth(fmt->fourcc);
>
>         /*
> --
> 2.34.1
>
