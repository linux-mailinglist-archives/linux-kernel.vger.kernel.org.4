Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3063D277
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiK3JvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiK3JvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:51:00 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB26925C7C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:50:59 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3b56782b3f6so165129037b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=85CBpe8h6suPlC2YlUqV3pCbiuyIDeu7NL7tAzWSq04=;
        b=WMQHbII59gMQ0BlEfRQu/mx7qNJjrPJO7OqapZERyzpNTOsYZeo79HPXvNUQb2WH/g
         IsVteDPqxVox+ZFHzsroABU1M9JcDSi9MSNK0CmQpoLfJlERObQjoZlYfyCXinMQBfK4
         Iys+Lm0Fp4z5uqFibE++OQPIYgruCqrIIfoonVqw+S5Jwr13dyHJjwXmZykNsxMwUB4E
         S7h1Xhfo8AlwrrLbn876IzrNOITSfHH20iPy6R1kSMirhzHRdOMuNVF+/tUBGGY6JFIn
         Gbn2SoJ+Gkhud76kOUhRyP3c7q6ZuM9HJ1V2QQUn67MAqC5gVATxLXOacvAs2Gd/oKeg
         4ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85CBpe8h6suPlC2YlUqV3pCbiuyIDeu7NL7tAzWSq04=;
        b=FNoGGY4BJ+HIGNj6Sbt6obiajXUJihZxhhjfa2fdRMrICCxDGKM86cmUl3z/NHALMB
         FW3+QCdVqSZrOaq8kepQYB+Ltc7G8uHJmjOEkWF2vxSTzRAxR1tuRCCQh3g/b4q6MMzT
         nJHGU63X7rvGqgVo1DeCHHbUKRTUrP4Ah/60EamlIO3TMdRgWSlJBJZ8p2PujUOe6Oqz
         ehxrRgZX9WOxngJDCL/JVTBNz2AzLG/sWagzHWrA4gh8hNTqbPDFhaWufjGxUBvX5Er/
         e5+GgzEG+vQHHHF/PxlOerAOli747q7GLHSdRVvvA2pY0FmgANNj7wwDifvZZli5zSS8
         GkgA==
X-Gm-Message-State: ANoB5pmEkL8cdQaCj7AsUsTXfxQVZtYY3XGbNeoNrSzFPMmbVRHmABb0
        gbwmLKXVjglpVpvCqxDGeRZNqFHiatohC9izfadnqA==
X-Google-Smtp-Source: AA0mqf5nA1N+rUMCNTWTlTmneC+iJIjUIdYRscTuKjxKx6GwENB0YR1xBSvYfk36+SLH/PPzg8wy1CB+3xgKhh7YJcA=
X-Received: by 2002:a0d:db15:0:b0:3d6:2151:4038 with SMTP id
 d21-20020a0ddb15000000b003d621514038mr1132331ywe.418.1669801858887; Wed, 30
 Nov 2022 01:50:58 -0800 (PST)
MIME-Version: 1.0
References: <1669767131-13854-1-git-send-email-quic_khsieh@quicinc.com> <1669767131-13854-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1669767131-13854-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Nov 2022 11:50:48 +0200
Message-ID: <CAA8EJppEHrPeoCxZUerf4MjDVkYEm7EvTcsm8eTAQBUVMqc_cA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] drm/msm/dp: parser data-lanes and link-frequencies
 from endpoint node
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 02:12, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Both data-lanes and link-frequencies are property of endpoint. This
> patch parser endpoint to retrieve max data lanes and max link rate
> supported specified at dp_out endpoint. In the case where no endpoint
> specified, then 4 data lanes with HBR2 link rate (5.4G) will be the
> default link configuration.

So, you have two changes in a single patch.
1) Moving the data-lanes to the endpoint
2) Adding link-frequencies.

Please split the patch accordingly. Also keep in mind that you have to
provide backwards compatibility for the data-lanes property.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_parser.c | 34 ++++++++++++++++++++++++++--------
>  drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index dd73221..9367f8c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -94,16 +94,34 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
>  static int dp_parser_misc(struct dp_parser *parser)
>  {
>         struct device_node *of_node = parser->pdev->dev.of_node;
> -       int len;
> -
> -       len = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
> -       if (len < 0) {
> -               DRM_WARN("Invalid property \"data-lanes\", default max DP lanes = %d\n",
> -                        DP_MAX_NUM_DP_LANES);
> -               len = DP_MAX_NUM_DP_LANES;
> +       struct device_node *endpoint;
> +       int cnt;
> +       u64 frequence[4];

frequency

> +
> +       endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
> +       if (endpoint) {
> +               cnt = of_property_count_u32_elems(endpoint, "data-lanes");
> +               if (cnt < 0)
> +                       parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
> +               else
> +                       parser->max_dp_lanes = cnt;
> +
> +               cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
> +               if (cnt < 0) {
> +                       parser->max_dp_link_rate = DP_LINK_FREQUENCY_HBR2; /* 54000 khz */

Wrong number of zeroes

> +               } else {
> +                       if (cnt > 4)    /* 4 frequency at most */
> +                               cnt = 4;

'4 frequencies'. Not to mention that magic '4' should be defined
somewhere. Or removed completely. See below.

> +                       of_property_read_u64_array(endpoint, "link-frequencies", frequence, cnt);

Can you please use of_property_read_u64_index() instead? It also has a
nice feature of modifying the out_value only if the proper data was
found. So you can set the default and then override it with the
of_property_read function. And then divide it by 1000 to get the value
in KHz.

> +                       parser->max_dp_link_rate = (u32)frequence[cnt  -1];
> +                       parser->max_dp_link_rate /= 1000;       /* khz */

The HDR3 rate is 8100 Mb/s. 8 100 000 000. This doesn't fit into u32
(U32_MAX = 4 294 967 295).

> +               }
> +       } else {
> +               /* default */
> +               parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
> +               parser->max_dp_link_rate = DP_LINK_FREQUENCY_HBR2; /* 54000 khz */

Wrong number of zeroes. Better use Mb/s or Gb/s directly. Also it is a
rate, not a frequency, so the define should also use 'RATE' in its
name.

>         }
>
> -       parser->max_dp_lanes = len;
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
> index 866c1a8..76ddb751 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.h
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.h
> @@ -15,6 +15,7 @@
>  #define DP_LABEL "MDSS DP DISPLAY"
>  #define DP_MAX_PIXEL_CLK_KHZ   675000
>  #define DP_MAX_NUM_DP_LANES    4
> +#define DP_LINK_FREQUENCY_HBR2 540000
>
>  enum dp_pm_type {
>         DP_CORE_PM,
> @@ -119,6 +120,7 @@ struct dp_parser {
>         struct dp_io io;
>         struct dp_display_data disp_data;
>         u32 max_dp_lanes;
> +       u32 max_dp_link_rate;
>         struct drm_bridge *next_bridge;
>
>         int (*parse)(struct dp_parser *parser);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


--
With best wishes

Dmitry
