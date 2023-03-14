Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4606B959A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCNNKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjCNNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:09:40 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C7ABB3B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:06:10 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C57DE2010C;
        Tue, 14 Mar 2023 14:05:23 +0100 (CET)
Date:   Tue, 14 Mar 2023 14:05:22 +0100
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
Subject: Re: [PATCH v4 07/10] drm/msm/dsi: Remove custom DSI config handling
Message-ID: <20230314130522.wimbrf7d6lqwdbgz@SoMainline.org>
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
 <20230307-topic-dsi_qcm-v4-7-54b4898189cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v4-7-54b4898189cb@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 13:13:45, Konrad Dybcio wrote:
> Now that the only user is handled by common code, remove the option to
> specify custom handlers through match data.
> 
> This is effectively a revert of commit:
> 5ae15e76271 ("drm/msm/dsi: Allow to specify dsi config as pdata")
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.c      | 4 ++--
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h  | 3 ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ----
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index f761973e4cba..baab79ab6e74 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -172,10 +172,10 @@ static int dsi_dev_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id dt_match[] = {
> -	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
> +	{ .compatible = "qcom,mdss-dsi-ctrl" },
>  
>  	/* Deprecated, don't use */
> -	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
> +	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290" },
>  	{}
>  };
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 8772a3631ac1..91bdaf50bb1a 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -65,8 +65,5 @@ struct msm_dsi_cfg_handler {
>  
>  const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor);
>  
> -/* Non autodetect configs */
> -extern const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler;
> -

Probably the wrong `fixup!` commit: this should have been part of patch
6 where the struct is removed, not patch 7 (this patch).

- Marijn

>  #endif /* __MSM_DSI_CFG_H__ */
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 9cfb9e91bfea..961689a255c4 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -214,10 +214,6 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
>  	int ret;
>  	u32 major = 0, minor = 0;
>  
> -	cfg_hnd = device_get_match_data(dev);
> -	if (cfg_hnd)
> -		return cfg_hnd;
> -
>  	ahb_clk = msm_clk_get(msm_host->pdev, "iface");
>  	if (IS_ERR(ahb_clk)) {
>  		pr_err("%s: cannot get interface clock\n", __func__);
> 
> -- 
> 2.39.2
> 
