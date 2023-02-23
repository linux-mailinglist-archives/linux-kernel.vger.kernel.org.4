Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D66A0181
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjBWDYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWDYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:24:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC012A6E6;
        Wed, 22 Feb 2023 19:24:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86492B81733;
        Thu, 23 Feb 2023 03:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C19BC433D2;
        Thu, 23 Feb 2023 03:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677122643;
        bh=e1QIQuOBVdmi2tiHZ/xai1rSaIqCT7wlBRBcoAQUl/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYROHYabF4OwV2y+2tpoWXpS++YNKSDKWR/wwgY/5yxwFL99FKYmmhLFr70YilVCQ
         MjU/ruelGPqs/OPeiAvxjIWDdSDIGNk5Umh8nSjltjErwFkTMHNfjaLoRrlgcsTfkI
         VslW/fIOc0L5Ls2wRmOrOXr74E2u6uJEBDfI//VpEKEqgrI89oJVhhKn2zqlgIYdgc
         s9Sc9f/BRSZ+QtjDtIxNmmJ8MCPYu7FJwrvrWogRErmnKsKr6nM0zwvUbWi9Fb5zch
         ey8HwLL2IDer4ej5TVnYDB6pVVzuzPtj9KMUl9WRXYkEh7oYtC6NP/eG6C/H6mn0wR
         r9UMIJB5S2mvA==
Date:   Wed, 22 Feb 2023 19:27:30 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Simplify counting frequency domains
Message-ID: <20230223032730.fhnxjzfwralkexun@ripper>
References: <20230216105140.3938749-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216105140.3938749-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:51:40AM +0100, Konrad Dybcio wrote:
> For quite some time, this driver has been performing some quite
> low-level DT operations. Simplify that using platform_get_resource.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> v1 -> v2:
> - remove stray newline near probe return
> - s/doing performing/performing/
> 
> v1: https://lore.kernel.org/linux-arm-msm/20230216102956.3933639-1-konrad.dybcio@linaro.org/T/#u
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 2f581d2d617d..575a4461c25a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -29,6 +29,8 @@
>  
>  #define GT_IRQ_STATUS			BIT(2)
>  
> +#define MAX_FREQ_DOMAINS		3
> +
>  struct qcom_cpufreq_soc_data {
>  	u32 reg_enable;
>  	u32 reg_domain_state;
> @@ -651,10 +653,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  {
>  	struct clk_hw_onecell_data *clk_data;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *soc_node;
>  	struct device *cpu_dev;
>  	struct clk *clk;
> -	int ret, i, num_domains, reg_sz;
> +	int ret, i, num_domains;
>  
>  	clk = clk_get(dev, "xo");
>  	if (IS_ERR(clk))
> @@ -681,24 +682,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
> -	soc_node = of_get_parent(dev->of_node);
> -	if (!soc_node)
> -		return -EINVAL;
> -
> -	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
> -	if (ret)
> -		goto of_exit;
> -
> -	ret = of_property_read_u32(soc_node, "#size-cells", &i);
> -	if (ret)
> -		goto of_exit;
> -
> -	reg_sz += i;
> -
> -	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
> -	if (num_domains <= 0)
> -		return num_domains;
> +	for (num_domains = 0; num_domains < MAX_FREQ_DOMAINS; num_domains++)
> +		if (!platform_get_resource(pdev, IORESOURCE_MEM, num_domains))
> +			break;
>  
>  	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
>  					 GFP_KERNEL);
> @@ -762,9 +748,6 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	else
>  		dev_dbg(dev, "QCOM CPUFreq HW driver initialized\n");
>  
> -of_exit:
> -	of_node_put(soc_node);
> -
>  	return ret;
>  }
>  
> -- 
> 2.39.1
> 
