Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE36679CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjALPrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbjALPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:47:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F7192B9;
        Thu, 12 Jan 2023 07:37:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6464462077;
        Thu, 12 Jan 2023 15:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F33C433EF;
        Thu, 12 Jan 2023 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673537827;
        bh=5APceSExAsrf4VwDnGXlJySaXuHRaZgzWG4NnwXl+Jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7IU4VWz85tfErlM/RwYKz5Pdon4CNtAKJnKzulWLSuCghMXTX3smxLR1or6853JL
         uYKsZaQe+8GBJhGGeOwMUbQ3AmCvMo5UQdx0ZiJ65jwR60ZIZa+QwXCRymp1kXN1v+
         Bd8ui0hlVzhOBnrY2bJOiLpndAW+QLJoTnFhgz/A6AIl4fDLJ/Z98jO+6/XOto/0YV
         r82gOmbqah641Jm0UZbxAZTJTMLCHD8I5dxpAiyET3LR1Z7xDP7kuOfNbHTHwQ119j
         RzSvdwqz0xVdXloWwqVFbLiSYHgSzz8TShONiqJPtM6de62FZUdOy1rZbqKJXiHAu3
         mukrIdkzkPdhw==
Date:   Thu, 12 Jan 2023 09:37:04 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Ensure only freq-domain regs are
 counted in num_domains
Message-ID: <20230112153704.6d37dygm4yfexdq6@builder.lan>
References: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
 <20230111205125.1860858-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111205125.1860858-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:51:25PM +0100, Konrad Dybcio wrote:
> In preparation for CPRh-aware OSM programming, change the probe
> function so that we determine the number of frequency domains by
> counting the number of reg-names entries that begin with
> "freq-domain", as the aforementioned changes require introduction
> of non-freq-domain register spaces.
> 

Requiring reg-names would break backwards compatibility with at least
sc7280 and sm6115.

Regards,
Bjorn

> Fixes: 1a6a8b0080b0 ("cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2")
> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 9505a812d6a1..89d5ed267399 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -651,8 +651,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *soc_node;
>  	struct device *cpu_dev;
> +	const char *reg_name;
>  	struct clk *clk;
> -	int ret, i, num_domains, reg_sz;
> +	int ret, i, num_reg_names, num_domains = 0;
>  
>  	clk = clk_get(dev, "xo");
>  	if (IS_ERR(clk))
> @@ -684,19 +685,32 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	if (!soc_node)
>  		return -EINVAL;
>  
> -	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
> -	if (ret)
> +	num_reg_names = of_property_count_strings(dev->of_node, "reg-names");
> +	if (num_reg_names <= 0) {
> +		ret = num_reg_names ? num_reg_names : -ENODATA;
>  		goto of_exit;
> +	}
>  
> -	ret = of_property_read_u32(soc_node, "#size-cells", &i);
> -	if (ret)
> -		goto of_exit;
> +	for (i = 0; i < num_reg_names; i++) {
> +		ret = of_property_read_string_index(dev->of_node, "reg-names", i, &reg_name);
> +		if (ret < 0)
> +			goto of_exit;
>  
> -	reg_sz += i;
> +		/*
> +		 * Check if the i-th reg is a freq-domain base, no need to add 1
> +		 * more byte for idx, as sizeof counts \0 whereas strlen does not.
> +		 */
> +		if (strlen(reg_name) == sizeof("freq-domain")) {
> +			/* Check if this reg-name begins with "freq-domain" */
> +			if (!strncmp(reg_name, "freq-domain", sizeof("freq-domain") - 1))
> +				num_domains++;
> +		}
> +	}
>  
> -	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
> -	if (num_domains <= 0)
> -		return num_domains;
> +	if (num_domains <= 0) {
> +		ret = -EINVAL;
> +		goto of_exit;
> +	}
>  
>  	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
>  					 GFP_KERNEL);
> -- 
> 2.39.0
> 
