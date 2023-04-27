Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD36F0D90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjD0VEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjD0VD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:03:58 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2A1FF3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:03:57 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C674D200D5;
        Thu, 27 Apr 2023 23:03:55 +0200 (CEST)
Date:   Thu, 27 Apr 2023 23:03:54 +0200
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
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 08/13] drm/msm: mdss: Add SM6350 support
Message-ID: <34x5l7awnu4ft5erwbew6yymopcsicomk222z3ekh2qcy6oan4@yy64w63bkgn7>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-21 00:31:17, Konrad Dybcio wrote:
> Add support for MDSS on SM6350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index e8c93731aaa1..4e3a5f0c303c 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -538,6 +538,14 @@ static const struct msm_mdss_data sdm845_data = {
>  	.highest_bank_bit = 2,
>  };
>  
> +static const struct msm_mdss_data sm6350_data = {
> +	.ubwc_version = UBWC_2_0,
> +	.ubwc_dec_version = UBWC_2_0,
> +	.ubwc_swizzle = 6,
> +	.ubwc_static = 0x1e,
> +	.highest_bank_bit = 1,
> +};
> +
>  static const struct msm_mdss_data sm8150_data = {
>  	.ubwc_version = UBWC_3_0,
>  	.ubwc_dec_version = UBWC_3_0,
> @@ -571,6 +579,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,sc8180x-mdss", .data = &sc8180x_data },
>  	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
>  	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
> +	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
>  	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
>  	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
>  	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },
> 
> -- 
> 2.40.0
> 
