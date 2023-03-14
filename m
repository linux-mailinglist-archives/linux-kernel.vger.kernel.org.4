Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B66B958F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjCNNJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCNNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:08:34 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5194AB084
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:05:13 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2636F200D8;
        Tue, 14 Mar 2023 14:04:41 +0100 (CET)
Date:   Tue, 14 Mar 2023 14:04:39 +0100
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
Subject: Re: [PATCH v4 06/10] drm/msm/dsi: Switch the QCM2290-specific
 compatible to index autodetection
Message-ID: <20230314130439.nbarj2wsdf6ishmo@SoMainline.org>
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
 <20230307-topic-dsi_qcm-v4-6-54b4898189cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v4-6-54b4898189cb@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 13:13:44, Konrad Dybcio wrote:
> Now that the logic can handle multiple sets of registers, move
> the QCM2290 to the common logic and mark it deprecated. This allows us
> to remove a couple of structs, saving some memory.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.c     |  5 +++--
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 20 ++------------------
>  2 files changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 31fdee2052be..f761973e4cba 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include "dsi.h"
> -#include "dsi_cfg.h"
>  
>  bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
>  {
> @@ -174,7 +173,9 @@ static int dsi_dev_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
> -	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = &qcm2290_dsi_cfg_handler },
> +
> +	/* Deprecated, don't use */
> +	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
>  	{}
>  };
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 03d98cbcc978..29ccd755cc2e 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -169,7 +169,8 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>  	.bus_clk_names = dsi_v2_4_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>  	.io_start = {
> -		{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 / SC7180 */
> +		{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 */
> +		{ 0x5e94000 }, /* QCM2290 / SM6115 / SM6125 / SM6375 */
>  	},
>  };
>  
> @@ -203,17 +204,6 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>  	},
>  };
>  
> -static const struct msm_dsi_config qcm2290_dsi_cfg = {
> -	.io_offset = DSI_6G_REG_SHIFT,
> -	.regulator_data = dsi_v2_4_regulators,
> -	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
> -	.bus_clk_names = dsi_v2_4_clk_names,
> -	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> -	.io_start = {
> -		{ 0x5e94000 },
> -	},
> -};
> -
>  static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>  	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
>  	.link_clk_enable = dsi_link_clk_enable_v2,
> @@ -304,9 +294,3 @@ const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
>  
>  	return cfg_hnd;
>  }
> -
> -/*  Non autodetect configs */
> -const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler = {
> -	.cfg = &qcm2290_dsi_cfg,
> -	.ops = &msm_dsi_6g_v2_host_ops,
> -};

Should be removed from dsi_cfg.h, but you did that in patch 7 instead.

- Marijn

> 
> -- 
> 2.39.2
> 
