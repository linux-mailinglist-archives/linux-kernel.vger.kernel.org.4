Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A56199C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiKDO2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiKDO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:27:26 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC12E9DE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:25:09 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D52C23F796;
        Fri,  4 Nov 2022 15:25:07 +0100 (CET)
Message-ID: <8671f237-5b18-88c3-aef4-9acc46cfcbad@somainline.org>
Date:   Fri, 4 Nov 2022 15:25:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] soc: qcom: spm: Implement support for SAWv2.3,
 MSM8976 L2 PM
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
 <20221104133452.131227-3-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104133452.131227-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 14:34, AngeloGioacchino Del Regno wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>
> Implement the support for SAW v2.3, used in at least MSM8976, MSM8956
> and APQ variants and while at it also add the configuration for the
> MSM8976's little (a53) and big (a72) clusters cache power management.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Marijn: reorder struct definitions to follow high-to-low order]

Weird to have a name without an email address in any of the tags, but I

suppose it's not much of an issue?


> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

For the code:

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   drivers/soc/qcom/spm.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index 484b42b7454e..bfcd321d7837 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -98,6 +98,35 @@ static const struct spm_reg_data spm_reg_8916_cpu = {
>   	.start_index[PM_SLEEP_MODE_SPC] = 5,
>   };
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
>   static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
>   	[SPM_REG_CFG]		= 0x08,
>   	[SPM_REG_SPM_CTL]	= 0x30,
> @@ -213,6 +242,10 @@ static const struct of_device_id spm_match_table[] = {
>   	  .data = &spm_reg_8916_cpu },
>   	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>   	  .data = &spm_reg_8974_8084_cpu },
> +	{ .compatible = "qcom,msm8976-gold-saw2-v2.3-l2",
> +	  .data = &spm_reg_8976_gold_l2 },
> +	{ .compatible = "qcom,msm8976-silver-saw2-v2.3-l2",
> +	  .data = &spm_reg_8976_silver_l2 },
>   	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
>   	  .data = &spm_reg_8998_gold_l2 },
>   	{ .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
