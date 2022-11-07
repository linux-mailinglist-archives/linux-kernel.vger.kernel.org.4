Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB72162024A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKGWbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:31:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7BB2126C;
        Mon,  7 Nov 2022 14:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51B99B810C2;
        Mon,  7 Nov 2022 22:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7D4C433D6;
        Mon,  7 Nov 2022 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667860258;
        bh=XKo5S07i/ljM5DE1VsdqDN0PornhI4jPwJP1HNcqn1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhwEY4GNHVdgzAC+DXY0eF6rASV17RImf2S+IiTgcaJsifRUpScntfdrIPcr9018O
         dLjEDTqDBp+2qFQUNFfLLC2CdXp9nG0LduFyLpqWyR8k+3GoF6bkDn9yHiKQWLlIAa
         31SLQE5t+rPLjmphVG92aA0wkLpPzmgb6KHA7p3qHfEr7lkdVbhivyUeqKWQTNmccI
         cbQPdbvnX4XIqJcIYdJrNqQsMrdXxBPmeWxQudN2XqLBW1GTlyqr/rMAqirZzEv65Z
         v8TDvoBnKqAo78VIQ4yd/VCjFcnu4VHqbsHWEr5wW8297lZaikKsQgh6yBksGb1xe3
         7Aqcq8Sa8khDw==
Date:   Mon, 7 Nov 2022 16:30:55 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     viresh.kumar@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221107223055.k6bc7bp7djww5lxg@builder.lan>
References: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
 <20221102090818.65321-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102090818.65321-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:38:18PM +0530, Manivannan Sadhasivam wrote:
> Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> cores. But this relationship is not represented with the clk framework
> so far.
> 
> So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> clock producer/consumer relationship cleaner and is also useful for CPU
> related frameworks like OPP to know the frequency at which the CPUs are
> running.
> 
> The clock frequency provided by the driver is for each frequency domain.
> We cannot get the frequency of each CPU core because, not all platforms
> support per-core DCVS feature.
> 
> Also the frequency supplied by the driver is the actual frequency that
> comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> not same as what the CPUFreq framework has set but it is the one that gets
> supplied to the CPUs after throttling by LMh.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 5e0598730a04..5b5f9a4d1466 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
>  #include <linux/cpufreq.h>
>  #include <linux/init.h>
>  #include <linux/interconnect.h>
> @@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
>  	bool cancel_throttle;
>  	struct delayed_work throttle_work;
>  	struct cpufreq_policy *policy;
> +	struct clk_hw cpu_clk;
>  
>  	bool per_core_dcvs;
>  
> @@ -615,8 +617,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.ready		= qcom_cpufreq_ready,
>  };
>  
> +static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
> +
> +	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;

Shouldn't this just be qcom_lmh_get_throttle_freq()? So that we get a
value in Hz.


I presume you got the division from qcom_lmh_dcvs_notify(), where
throttled_freq seems to supposed to be in kHz when passed to
topology_update_thermal_pressure(), as it contains a division by 1000
and a comment that it takes us to units of MHz.

But it's not clear what the frequency unit for freq_qos_update_request()
would be - but it's a 31 bit value, so better hope it's kHz there as
well(?)

Regards,
Bjorn

> +}
> +
> +static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
> +	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
> +};
> +
>  static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  {
> +	struct clk_hw_onecell_data *clk_data;
>  	struct device *dev = &pdev->dev;
>  	struct device *cpu_dev;
>  	struct clk *clk;
> @@ -659,8 +673,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  
>  	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
>  
> +	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	clk_data->num = num_domains;
> +
>  	for (i = 0; i < num_domains; i++) {
>  		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
> +		struct clk_init_data init = {};
> +		const char *clk_name;
>  		struct resource *res;
>  		void __iomem *base;
>  
> @@ -672,6 +694,27 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  
>  		data->base = base;
>  		data->res = res;
> +
> +		/* Register CPU clock for each frequency domain */
> +		clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);
> +		init.name = clk_name;
> +		init.flags = CLK_GET_RATE_NOCACHE;
> +		init.ops = &qcom_cpufreq_hw_clk_ops;
> +		data->cpu_clk.init = &init;
> +
> +		ret = devm_clk_hw_register(dev, &data->cpu_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
> +			return ret;
> +		}
> +
> +		clk_data->hws[i] = &data->cpu_clk;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
> +		return ret;
>  	}
>  
>  	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> -- 
> 2.25.1
> 
