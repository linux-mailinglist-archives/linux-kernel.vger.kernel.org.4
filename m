Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5423623A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiKJDtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiKJDtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:49:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033322EF77;
        Wed,  9 Nov 2022 19:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89772B82082;
        Thu, 10 Nov 2022 03:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF96C433C1;
        Thu, 10 Nov 2022 03:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668052133;
        bh=ronxNhxwQQype8CTzKYSEe7q0nUEd0SkKinoXgwtdBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8IUr+bqI7PJvQcDwBfsKhEZ+gEf9jklL47NiR74ailybZz7r2rUYeRjHWPY3Etv0
         yswFFTYINtrFfQRrj97Qp5yLbuqIZkb28Tll4ndntP+i+FzfJK39E2wgT7BODj0N7Z
         l/9KBn1VZApfYBriXKkx8Fun5EmBcaMPaXwaT3TGRf2p0+UTnQ6+xVRMK7oBejQh7t
         qBP1vyJksg3HoparmjpEyr+fknULejHGmfU63W1tLFrOJFNoopElPToRvrztXMBLLR
         wZJ9IjatH58qijjfNn6V1YURsRriQK4Pd257MkZJElZ2miMhsj1krzaiSDJdOoq6kB
         nlRORqp5MorCA==
Date:   Wed, 9 Nov 2022 21:48:50 -0600
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
Subject: Re: [PATCH 2/2] regulator: qcom_smd: Add PMR735a regulators
Message-ID: <20221110034850.vss3ofv36nedmj6e@builder.lan>
References: <20221109110846.45789-1-konrad.dybcio@linaro.org>
 <20221109110846.45789-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109110846.45789-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:08:46PM +0100, Konrad Dybcio wrote:
> PMR735a is already supported in the RPMH regulator driver, but
> there are cases where it's bundled with SMD RPM SoCs. Port it over
> to qcom_smd-regulator to enable usage in such cases.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/regulator/qcom_smd-regulator.c | 24 ++++++++++++++++++++++++
>  include/linux/soc/qcom/smd-rpm.h       |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index f98168d58dce..9eaae13fd385 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -677,6 +677,15 @@ static const struct regulator_desc pm6125_ftsmps = {
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
>  static const struct regulator_desc pms405_hfsmps3 = {
>  	.linear_ranges = (struct linear_range[]) {
>  		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> @@ -1265,6 +1274,20 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
>  	{}
>  };
>  
> +static const struct rpm_regulator_data rpm_pmr735a_regulators[] = {
> +	{ "s1", QCOM_SMD_RPM_SMPE, 1, &pmic5_ftsmps520, "vdd_s1"},
> +	{ "s2", QCOM_SMD_RPM_SMPE, 2, &pmic5_ftsmps520, "vdd_s2"},
> +	{ "s3", QCOM_SMD_RPM_SMPE, 3, &pms405_hfsmps3, "vdd_s3"},

This should be a hfsmps515 instead, which has a wider voltage range.
Please pick the range from the rpmh regulator driver and add that as
well.

Regards,
Bjorn

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
> @@ -1305,6 +1328,7 @@ static const struct of_device_id rpm_of_match[] = {
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
