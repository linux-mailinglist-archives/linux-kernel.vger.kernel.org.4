Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAA622529
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKIIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4799B1BE81;
        Wed,  9 Nov 2022 00:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8C8618EE;
        Wed,  9 Nov 2022 08:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23376C433C1;
        Wed,  9 Nov 2022 08:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667981801;
        bh=Xu0pJZHgNqiJ14KtQMOxTvZJNLdPl1pLSA3nwf+3Ac4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYt+QveGoM8LsxlrCCOhmG+yQO3jUvDl5NaKvldIwLP/QVblszdTn7vbzR6ZPDQWV
         NSpdDiWnpH8dC5asIolfDxi/u3OpjuopVnsTiXDEGTb51YyMyrkq31GhGwO5XhPqCQ
         9J1pgZZfZo/hONj1QduB7Wz6VSiyL8T8Z28s0wGP4yxI8N6Ii3uCZ9JX959XupE1fb
         ZjmtbkXca1baWqzaBSa60w4E7aTyxI1+m3n60em4T1yvVYpIFNRqTWEyavf33aTYWk
         OfdRSMt7xjCBcBERwcn6GNmB3yA6+RVQGiwvspyfuKOn5czYUJIND/8XxeK9KZ7EOP
         UlxSh2YwyVelg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1osgFr-0006qG-Lf; Wed, 09 Nov 2022 09:16:15 +0100
Date:   Wed, 9 Nov 2022 09:16:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <Y2thz0vk8krV5bBH@hovoldconsulting.com>
References: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
 <20221109080120.19078-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109080120.19078-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:31:20PM +0530, Manivannan Sadhasivam wrote:
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
>  drivers/cpufreq/qcom-cpufreq-hw.c | 41 +++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 5e0598730a04..c0e4b223f9c1 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
 
> @@ -672,6 +693,26 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  
>  		data->base = base;
>  		data->res = res;
> +
> +		/* Register CPU clock for each frequency domain */
> +		clk_init.name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);

This is still an allocation and can in theory fail.

But it is also unnecessary to keep these around after registering the
clocks so it's better to just reuse a single stack allocated buffer for
this.

> +		clk_init.flags = CLK_GET_RATE_NOCACHE;
> +		clk_init.ops = &qcom_cpufreq_hw_clk_ops;
> +		data->cpu_clk.init = &clk_init;
> +
> +		ret = devm_clk_hw_register(dev, &data->cpu_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to register Qcom CPUFreq clock(%d)\n", i);

nit: This looks unnecessarily verbose. Using

	"failed to register clock %d: %d\n", i, ret

should do just fine as you are using dev_err().

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

Johan
