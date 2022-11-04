Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACE7619A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKDOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiKDOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:34:29 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B919016
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:32:06 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6E01D1F8A5;
        Fri,  4 Nov 2022 15:32:04 +0100 (CET)
Date:   Fri, 4 Nov 2022 15:32:02 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH 2/2] soc: qcom: spm: Implement support for SAWv2.3,
 MSM8976 L2 PM
Message-ID: <20221104143202.nps2iwqjcwug6mij@SoMainline.org>
References: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
 <20221104133452.131227-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104133452.131227-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-04 14:34:52, AngeloGioacchino Del Regno wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Implement the support for SAW v2.3, used in at least MSM8976, MSM8956
> and APQ variants and while at it also add the configuration for the
> MSM8976's little (a53) and big (a72) clusters cache power management.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Marijn: reorder struct definitions to follow high-to-low order]

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/soc/qcom/spm.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index 484b42b7454e..bfcd321d7837 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -98,6 +98,35 @@ static const struct spm_reg_data spm_reg_8916_cpu = {
>  	.start_index[PM_SLEEP_MODE_SPC] = 5,
>  };
>  
> +static const u16 spm_reg_offset_v2_3[SPM_REG_NR] = {
> +	[SPM_REG_CFG]		= 0x08,
> +	[SPM_REG_SPM_CTL]	= 0x30,
> +	[SPM_REG_DLY]		= 0x34,
> +	[SPM_REG_PMIC_DATA_0]	= 0x40,
> +	[SPM_REG_PMIC_DATA_1]	= 0x44,
> +};
> +
> +/* SPM register data for 8976 */
> +static const struct spm_reg_data spm_reg_8976_gold_l2 = {
> +	.reg_offset = spm_reg_offset_v2_3,
> +	.spm_cfg = 0x14,
> +	.spm_dly = 0x3c11840a,
> +	.pmic_data[0] = 0x03030080,
> +	.pmic_data[1] = 0x00030000,
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 3,
> +};
> +
> +static const struct spm_reg_data spm_reg_8976_silver_l2 = {
> +	.reg_offset = spm_reg_offset_v2_3,
> +	.spm_cfg = 0x14,
> +	.spm_dly = 0x3c102800,
> +	.pmic_data[0] = 0x03030080,
> +	.pmic_data[1] = 0x00030000,
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 2,
> +};
> +
>  static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x30,
> @@ -213,6 +242,10 @@ static const struct of_device_id spm_match_table[] = {
>  	  .data = &spm_reg_8916_cpu },
>  	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>  	  .data = &spm_reg_8974_8084_cpu },
> +	{ .compatible = "qcom,msm8976-gold-saw2-v2.3-l2",
> +	  .data = &spm_reg_8976_gold_l2 },
> +	{ .compatible = "qcom,msm8976-silver-saw2-v2.3-l2",
> +	  .data = &spm_reg_8976_silver_l2 },
>  	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
>  	  .data = &spm_reg_8998_gold_l2 },
>  	{ .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
> -- 
> 2.37.2
> 
