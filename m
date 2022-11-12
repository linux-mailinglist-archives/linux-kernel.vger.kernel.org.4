Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB796266A9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiKLDha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiKLDh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:37:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239213F1F;
        Fri, 11 Nov 2022 19:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53474B8289C;
        Sat, 12 Nov 2022 03:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22380C433C1;
        Sat, 12 Nov 2022 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668224244;
        bh=dyhBstJ8iKl6kHdBh0zcJOx01JWP4TBTvxAjdx3k+O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kT6iKVypgqpuHRLN2cN5PfVxRETJRyRhg19SCU6NkKvQFAMP+HadqfLw/OP334ldG
         EUFp1pCUlVALl0WZVO5EUozEdXSqLnD9osPAxwVIHFjUih9hQa+dltNiuPA+cqFHDj
         vhxaizrlPLs+ushOo8thh+5MMhB4qKCviVKPbsHTvpYKSqWyhazB8fTZoqIg7574a0
         bsBN9LgQnlfPjAr56m8vttaS/m+8ugKyw5lUwrGsJgYqV7pvc8anNU1SjqTcKC0zsg
         xngFeuy36sQRowA00uLCP14q6rxCOXPvBlAfcLQAZ3EVHuPBWjZ5z2dOge9zfsKYOF
         PIuiBZrHnYxJQ==
Date:   Fri, 11 Nov 2022 21:37:21 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, patches@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: qcom_smd: Add PMR735a regulators
Message-ID: <20221112033721.3se3lz7pdk5brex3@builder.lan>
References: <20221110091736.3344-1-konrad.dybcio@linaro.org>
 <20221110091736.3344-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110091736.3344-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:17:36AM +0100, Konrad Dybcio wrote:
> PMR735a is already supported in the RPMH regulator driver, but
> there are cases where it's bundled with SMD RPM SoCs. Port it over
> to qcom_smd-regulator to enable usage in such cases.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> Changes since v1:
> - Add and use pmic5_ftsmps520 in place of pms405_hfsmps3 for s3
> 
>  drivers/regulator/qcom_smd-regulator.c | 33 ++++++++++++++++++++++++++
>  include/linux/soc/qcom/smd-rpm.h       |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index f98168d58dce..9f2b58458841 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -677,6 +677,24 @@ static const struct regulator_desc pm6125_ftsmps = {
>  	.ops = &rpm_smps_ldo_ops,
>  };
>  
> +static const struct regulator_desc pmic5_ftsmps520 = {
> +	.linear_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	},
> +	.n_linear_ranges = 1,
> +	.n_voltages = 264,
> +	.ops = &rpm_smps_ldo_ops,
> +};
> +
> +static const struct regulator_desc pmic5_hfsmps515 = {
> +	.linear_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
> +	},
> +	.n_linear_ranges = 1,
> +	.n_voltages = 236,
> +	.ops = &rpm_smps_ldo_ops,
> +};
> +
>  static const struct regulator_desc pms405_hfsmps3 = {
>  	.linear_ranges = (struct linear_range[]) {
>  		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> @@ -1265,6 +1283,20 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
>  	{}
>  };
>  
> +static const struct rpm_regulator_data rpm_pmr735a_regulators[] = {
> +	{ "s1", QCOM_SMD_RPM_SMPE, 1, &pmic5_ftsmps520, "vdd_s1"},
> +	{ "s2", QCOM_SMD_RPM_SMPE, 2, &pmic5_ftsmps520, "vdd_s2"},
> +	{ "s3", QCOM_SMD_RPM_SMPE, 3, &pmic5_hfsmps515, "vdd_s3"},
> +	{ "l1", QCOM_SMD_RPM_LDOE, 1, &pm660_nldo660, "vdd_l1_l2"},
> +	{ "l2", QCOM_SMD_RPM_LDOE, 2, &pm660_nldo660, "vdd_l1_l2"},
> +	{ "l3", QCOM_SMD_RPM_LDOE, 3, &pm660_nldo660, "vdd_l3"},
> +	{ "l4", QCOM_SMD_RPM_LDOE, 4, &pm660_ht_lvpldo, "vdd_l4"},
> +	{ "l5", QCOM_SMD_RPM_LDOE, 5, &pm660_nldo660, "vdd_l5_l6"},
> +	{ "l6", QCOM_SMD_RPM_LDOE, 6, &pm660_nldo660, "vdd_l5_l6"},
> +	{ "l7", QCOM_SMD_RPM_LDOE, 7, &pm660_pldo660, "vdd_l7_bob"},
> +	{}
> +};
> +
>  static const struct rpm_regulator_data rpm_pms405_regulators[] = {
>  	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pms405_hfsmps3, "vdd_s1" },
>  	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pms405_hfsmps3, "vdd_s2" },
> @@ -1305,6 +1337,7 @@ static const struct of_device_id rpm_of_match[] = {
>  	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
>  	{ .compatible = "qcom,rpm-pmi8994-regulators", .data = &rpm_pmi8994_regulators },
>  	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
> +	{ .compatible = "qcom,rpm-pmr735a-regulators", .data = &rpm_pmr735a_regulators },
>  	{ .compatible = "qcom,rpm-pms405-regulators", .data = &rpm_pms405_regulators },
>  	{}
>  };
> diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
> index 3ab8c07f71c0..62de54992e49 100644
> --- a/include/linux/soc/qcom/smd-rpm.h
> +++ b/include/linux/soc/qcom/smd-rpm.h
> @@ -19,6 +19,7 @@ struct qcom_smd_rpm;
>  #define QCOM_SMD_RPM_CLK_BUF_A	0x616B6C63
>  #define QCOM_SMD_RPM_LDOA	0x616f646c
>  #define QCOM_SMD_RPM_LDOB	0x626F646C
> +#define QCOM_SMD_RPM_LDOE	0x656f646c
>  #define QCOM_SMD_RPM_RWCX	0x78637772
>  #define QCOM_SMD_RPM_RWMX	0x786d7772
>  #define QCOM_SMD_RPM_RWLC	0x636c7772
> @@ -32,6 +33,7 @@ struct qcom_smd_rpm;
>  #define QCOM_SMD_RPM_QUP_CLK	0x707571
>  #define QCOM_SMD_RPM_SMPA	0x61706d73
>  #define QCOM_SMD_RPM_SMPB	0x62706d73
> +#define QCOM_SMD_RPM_SMPE	0x65706d73
>  #define QCOM_SMD_RPM_SPDM	0x63707362
>  #define QCOM_SMD_RPM_VSA	0x00617376
>  #define QCOM_SMD_RPM_MMAXI_CLK	0x69786d6d
> -- 
> 2.38.1
> 
