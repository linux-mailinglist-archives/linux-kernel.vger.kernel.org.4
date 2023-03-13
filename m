Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937B46B866F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCMX6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCMX6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:58:10 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB44D73AE5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:58:09 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E2CAB20373;
        Tue, 14 Mar 2023 00:58:06 +0100 (CET)
Date:   Tue, 14 Mar 2023 00:58:05 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] drm/msm/dsi: dsi_cfg: Merge SC7180 config into
 SDM845
Message-ID: <20230313235805.2ic4xewn2jf2ffir@SoMainline.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-5-8bd7e1add38a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v3-5-8bd7e1add38a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-07 14:01:43, Konrad Dybcio wrote:
> The configs are identical, other than the number of *maximum* DSI
> hosts allowed. This isn't an issue, unless somebody deliberately
> tries to access the inexistent host by adding a dt node for it.
> 
> Remove the SC7180 struct and point the hw revision match to the
> SDM845's one. On a note, this could have been done back when
> 7180 support was introduced.

Maybe differences were expected, but then sdm845_dsi_cfg is used on many
other revisions.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index d39521850018..6d4b2ce4b918 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -169,7 +169,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>  	.bus_clk_names = dsi_v2_4_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>  	.io_start = {
> -		{ 0xae94000, 0xae96000 },
> +		{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 / SC7180 */
>  	},
>  };
>  
> @@ -188,17 +188,6 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>  	},
>  };
>  
> -static const struct msm_dsi_config sc7180_dsi_cfg = {
> -	.io_offset = DSI_6G_REG_SHIFT,
> -	.regulator_data = dsi_v2_4_regulators,
> -	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
> -	.bus_clk_names = dsi_v2_4_clk_names,
> -	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> -	.io_start = {
> -		{ 0xae94000 },
> -	},
> -};
> -
>  static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
>  	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
>  };
> @@ -299,7 +288,7 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_0,
>  		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_1,
> -		&sc7180_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> +		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_0,
>  		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,
> 
> -- 
> 2.39.2
> 
