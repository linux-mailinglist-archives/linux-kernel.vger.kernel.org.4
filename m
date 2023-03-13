Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687516B862A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCMXiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCMXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:38:00 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF92115
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:37:57 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8BC47202E1;
        Tue, 14 Mar 2023 00:37:55 +0100 (CET)
Date:   Tue, 14 Mar 2023 00:37:54 +0100
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
Subject: Re: [PATCH v3 02/10] drm/msm/dsi: Get rid of msm_dsi_config::num_dsi
Message-ID: <20230313233754.k6hz2jn7rul5gakc@SoMainline.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-2-8bd7e1add38a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v3-2-8bd7e1add38a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-07 14:01:40, Konrad Dybcio wrote:
> In preparation for supporting multiple sets of possible base registers,
> remove the num_dsi variable. We're comparing the io_start array contents
> with the reg value from the DTS, so it will either match one of the
> expected values or don't match against a zero (which we get from partial

"but won't match against zero" (and drop "either"), that makes this
sentence flow more naturally IMO (otherwise "fail to match against
zero").

> array initialization).
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 13 -------------
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 -
>  drivers/gpu/drm/msm/dsi/dsi_host.c |  2 +-
>  3 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 6d21f0b33411..4515f52b407a 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -22,7 +22,6 @@ static const struct msm_dsi_config apq8064_dsi_cfg = {
>  	.bus_clk_names = dsi_v2_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_v2_bus_clk_names),
>  	.io_start = { 0x4700000, 0x5800000 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_6g_bus_clk_names[] = {
> @@ -42,7 +41,6 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
>  	.bus_clk_names = dsi_6g_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
>  	.io_start = { 0xfd922800, 0xfd922b00 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_8916_bus_clk_names[] = {
> @@ -61,7 +59,6 @@ static const struct msm_dsi_config msm8916_dsi_cfg = {
>  	.bus_clk_names = dsi_8916_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
>  	.io_start = { 0x1a98000 },
> -	.num_dsi = 1,
>  };
>  
>  static const char * const dsi_8976_bus_clk_names[] = {
> @@ -80,7 +77,6 @@ static const struct msm_dsi_config msm8976_dsi_cfg = {
>  	.bus_clk_names = dsi_8976_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
>  	.io_start = { 0x1a94000, 0x1a96000 },
> -	.num_dsi = 2,
>  };
>  
>  static const struct regulator_bulk_data msm8994_dsi_regulators[] = {
> @@ -99,7 +95,6 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
>  	.bus_clk_names = dsi_6g_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
>  	.io_start = { 0xfd998000, 0xfd9a0000 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_8996_bus_clk_names[] = {
> @@ -119,7 +114,6 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
>  	.bus_clk_names = dsi_8996_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
>  	.io_start = { 0x994000, 0x996000 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_msm8998_bus_clk_names[] = {
> @@ -138,7 +132,6 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
>  	.bus_clk_names = dsi_msm8998_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_msm8998_bus_clk_names),
>  	.io_start = { 0xc994000, 0xc996000 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_sdm660_bus_clk_names[] = {
> @@ -156,7 +149,6 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
>  	.bus_clk_names = dsi_sdm660_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_sdm660_bus_clk_names),
>  	.io_start = { 0xc994000, 0xc996000 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_sdm845_bus_clk_names[] = {
> @@ -178,7 +170,6 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>  	.bus_clk_names = dsi_sdm845_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>  	.io_start = { 0xae94000, 0xae96000 },
> -	.num_dsi = 2,
>  };
>  
>  static const struct regulator_bulk_data sm8550_dsi_regulators[] = {
> @@ -192,7 +183,6 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>  	.bus_clk_names = dsi_sdm845_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>  	.io_start = { 0xae94000, 0xae96000 },
> -	.num_dsi = 2,
>  };
>  
>  static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
> @@ -206,7 +196,6 @@ static const struct msm_dsi_config sc7180_dsi_cfg = {
>  	.bus_clk_names = dsi_sc7180_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
>  	.io_start = { 0xae94000 },
> -	.num_dsi = 1,
>  };
>  
>  static const char * const dsi_sc7280_bus_clk_names[] = {
> @@ -224,7 +213,6 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>  	.bus_clk_names = dsi_sc7280_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
>  	.io_start = { 0xae94000, 0xae96000 },
> -	.num_dsi = 2,
>  };
>  
>  static const char * const dsi_qcm2290_bus_clk_names[] = {
> @@ -242,7 +230,6 @@ static const struct msm_dsi_config qcm2290_dsi_cfg = {
>  	.bus_clk_names = dsi_qcm2290_bus_clk_names,
>  	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
>  	.io_start = { 0x5e94000 },
> -	.num_dsi = 1,
>  };
>  
>  static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 44be4a88aa83..6b6b16c5fd25 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -39,7 +39,6 @@ struct msm_dsi_config {
>  	const char * const *bus_clk_names;
>  	const int num_bus_clks;
>  	const resource_size_t io_start[DSI_MAX];
> -	const int num_dsi;
>  };
>  
>  struct msm_dsi_host_cfg_ops {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 18fa30e1e858..9021f0d65515 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1868,7 +1868,7 @@ static int dsi_host_get_id(struct msm_dsi_host *msm_host)
>  	if (!res)
>  		return -EINVAL;
>  
> -	for (i = 0; i < cfg->num_dsi; i++) {
> +	for (i = 0; i < DSI_MAX; i++) {
>  		if (cfg->io_start[i] == res->start)
>  			return i;
>  	}
> 
> -- 
> 2.39.2
> 
