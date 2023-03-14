Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD56B868D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCNADw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCNADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:03:50 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279955051;
        Mon, 13 Mar 2023 17:03:26 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CC7BD202E5;
        Tue, 14 Mar 2023 01:03:23 +0100 (CET)
Date:   Tue, 14 Mar 2023 01:03:22 +0100
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
Subject: Re: [PATCH v3 06/10] drm/msm/dsi: Switch the QCM2290-specific
 compatible to index autodetection
Message-ID: <20230314000322.ptxs5d5mx54vdopa@SoMainline.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-6-8bd7e1add38a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v3-6-8bd7e1add38a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-07 14:01:44, Konrad Dybcio wrote:
> Now that the logic can handle multiple sets of registers, move
> the QCM2290 to the common logic and mark it deprecated. This allows us
> to remove a couple of structs, saving some memory.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.c     |  4 +++-
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 28 ++--------------------------
>  2 files changed, 5 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 31fdee2052be..90d43628b22b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -174,7 +174,9 @@ static int dsi_dev_remove(struct platform_device *pdev)
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
> index 6d4b2ce4b918..29ccd755cc2e 100644
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
> @@ -203,25 +204,6 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>  	},
>  };
>  
> -static const char * const dsi_qcm2290_bus_clk_names[] = {
> -	"iface", "bus",
> -};
> -
> -static const struct regulator_bulk_data qcm2290_dsi_cfg_regulators[] = {
> -	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
> -};

These two consts should really have already been deleted as part of
04/10: drm/msm/dsi: dsi_cfg: Deduplicate identical structs.

> -static const struct msm_dsi_config qcm2290_dsi_cfg = {
> -	.io_offset = DSI_6G_REG_SHIFT,
> -	.regulator_data = qcm2290_dsi_cfg_regulators,
> -	.num_regulators = ARRAY_SIZE(qcm2290_dsi_cfg_regulators),
> -	.bus_clk_names = dsi_qcm2290_bus_clk_names,
> -	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
> -	.io_start = {
> -		{ 0x5e94000 },
> -	},
> -};
> -
>  static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>  	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
>  	.link_clk_enable = dsi_link_clk_enable_v2,
> @@ -312,9 +294,3 @@ const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
>  
>  	return cfg_hnd;
>  }
> -
> -/*  Non autodetect configs */
> -const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler = {
> -	.cfg = &qcm2290_dsi_cfg,
> -	.ops = &msm_dsi_6g_v2_host_ops,
> -};

And how do you think dsi.c is able to reference this... don't forget to
remove it from dsi_cfg.h in v4.  In fact, if you look at how this was
implemented you should also be able to remove #include "dsi_cfg.h" from
dsi.c.  A clean revert of that patch would be nice, or just use it as
reference to find the remnants:

https://lore.kernel.org/all/1644853060-12222-2-git-send-email-loic.poulain@linaro.org/

- Marijn
