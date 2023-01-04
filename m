Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5165DCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbjADTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbjADTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:33:18 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942D1BE88
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:33:15 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id i19so23632781ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6N+OP+6yy03flX+mI06gXGKWmxb8vTgx5JtQZDesWc=;
        b=ywyJ1diL3UYldnanPgu/gbwLosUj6n9Xuv3577wYf9BSvcU2PDcsjh2ibb8sXd9Tie
         E8aPBCBkVzYCMbxpOU/YKCI9CmG2nYIvmQQ3kh6jz5mxzAmxYrml35vV8rCxjRVeFb1U
         fO4J6FyfrVi5S0U8084vsGWn4mFMng22spHnL0OCYGndX/sdTlO62l2U5oaud7K8q8bS
         EPYLdxoRLKrlnbA6SBQjod7CIIMlmj4hl/vLD8KCEOkMk73GZMehbfs6yKOw8IlliRIi
         3sFKYdwvw8iBK0q7aL4/8QhxNS5xd/ThFdxd2q0xaei41ggJMZ+qVKOtTb/3r27vexB4
         8gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6N+OP+6yy03flX+mI06gXGKWmxb8vTgx5JtQZDesWc=;
        b=KQY4d9QgR/OwZKX7nN/7dTu7krM3Xi/nbCJuKmjnK5gQFjGIarFoQfViyh0vuFljUU
         SaHHwos68Wn85JYsisyRJV/uIRnbS88W6gQF13StdUkjEj7a11moPetqYUDH7B+nDljp
         rSGp+rbRsjE7eGSJcOiPbh7R5NBkxuOeBnd4j3S2+MX2QfOUGggMPH5cnRs595kNgpft
         6fqBKafVjpCKRCmKAAo7ae9ujOrviN1JrFWLONP3bVw60kcb7/8NhKnRyn/mNJ0bMdru
         TvCBrm5L6y1NQh4by+WXZZeIgTp7lUnnQNCkb024Sdr0CTFv6ZU3aAnqo9pMbyVh1j+P
         BBbg==
X-Gm-Message-State: AFqh2kptN8kctVPc1r1yibIndktb4yI78LV2PEVcOQVal4ndJvvIr8J0
        LsaodzmswpXueuCAocbPp8VZR23HsPtCLSWExretiA==
X-Google-Smtp-Source: AMrXdXsw/78tBcgISSlM45Fz8wx/0zC7FLlIbONYasugHZBibZQRhly4sSsbLzK+gYIUEjhvu2ylEmwzLDylydzpIy8=
X-Received: by 2002:a2e:b54c:0:b0:27f:e3e3:7f25 with SMTP id
 a12-20020a2eb54c000000b0027fe3e37f25mr655188ljn.103.1672860793967; Wed, 04
 Jan 2023 11:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com> <20230103170058.810597-8-benjamin.gaignard@collabora.com>
In-Reply-To: <20230103170058.810597-8-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 4 Jan 2023 16:33:02 -0300
Message-ID: <CAAEAJfBpGwa-ZDFFCep8rk4+dgLrYOFdfyrqBZP68C+jkN0qMQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] media: verisilicon: Check AV1 bitstreams bit depth
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks for the patch.

On Tue, Jan 3, 2023 at 2:01 PM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> The driver supports 8 and 10 bits bitstreams, make sure to discard
> other cases.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 8e93710dcfed..16539e89935c 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -282,7 +282,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
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
> @@ -333,7 +339,13 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
>
>         switch (ctrl->id) {
>         case V4L2_CID_STATELESS_AV1_SEQUENCE:
> -               ctx->bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
> +               int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
> +
> +               if (vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)))
> +                       if (ctx->bit_depth != bit_depth)
> +                               return -EINVAL;
> +

Please use the v4l2_ctrl_grab API. Can you send a separate series to address
this for the other codecs?

Thanks a lot!
Ezequiel

> +               ctx->bit_depth = bit_depth;
>                 break;
>         default:
>                 return -EINVAL;
> --
> 2.34.1
>
