Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6B60741C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJUJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJUJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:31:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0CA25475B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:31:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c24so1828920pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftcvvRSypIlVVbBphyIpZ4XC4awbXO0ZbRsIlri8op4=;
        b=UHBtTRSZjQ10HVWKLKVuW0ulK/tgF/BJZqtCihMIbix0nTrR53hTw6VZYEJ13VItOW
         t1ggg62PSPrWTWpXx/wnGI+FavqcyEqIUvSLY0/Kjx0UuXjo+UXc5QvotiBhSUgJDEgC
         tCEiGkVzyjMDrvZo6MvwKmd2d0qKIubnLzAYKosY4jHCOPZ43tw8xfX5gz9AfsGYL3Fv
         1MmiD3z1OfATdHZQYzHP1Iq2p2f/hulLck0FoWfKqVA4Mo3Ggand5ufK/w87M0CAJNFv
         jQSwFMNHA85wFdRNxxiEtByLksenMueaqb6bQHn+oG3aeMBW4NsNPT7WGhYPnPDSel3j
         gfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftcvvRSypIlVVbBphyIpZ4XC4awbXO0ZbRsIlri8op4=;
        b=VPmOTIVpex5ixTolvCYx0So0ISCmbikBaHXwOr1w22i+wGeaSmkEIdqdiu7vnswTpR
         OqHah9KwEx3hi2LAPodI8xUrXikEw7kIQyqCz5o7EzjHqX+DSUbkHNnkje640tf2ZAN5
         Emu8RaMERKhVMF8u7B+4luUp5BQTWkd+kOHIfbBUA005YM4T/tawTniw8Fj/9tW8BK+G
         K2k7f//MAc7v7hwna6A7VcxSjoxl+h9lstjLsVok98bTODhie2Osesd+57Mxnpo+ofXL
         egMvhEuDfo3jXW494uiKFeYvoXUiH5YMV0uoTB+WpqrHZle7TsY0gh4ILXI+MZ6mbYpr
         9Ysg==
X-Gm-Message-State: ACrzQf1PAXeZBDXhl01kD+su8tUhOB0PnByXvfMB3icaGX64j+ytuubG
        JT+iRO7Ncs3URzijZl8W9bc6
X-Google-Smtp-Source: AMsMyM4hBdw3s4MzwYF+WzdMIfsTs3ZRpfDk3Kiu9CorRSHBOBkYj09PziVzuJ7MKr9mb9KGv0ywdQ==
X-Received: by 2002:a17:902:9a8b:b0:17a:455:d967 with SMTP id w11-20020a1709029a8b00b0017a0455d967mr18315533plp.52.1666344708197;
        Fri, 21 Oct 2022 02:31:48 -0700 (PDT)
Received: from thinkpad ([117.193.215.105])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001866049ddb1sm3099788plf.161.2022.10.21.02.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:31:46 -0700 (PDT)
Date:   Fri, 21 Oct 2022 15:01:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221021093140.GC93287@thinkpad>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
 <20221019135925.366162-4-manivannan.sadhasivam@linaro.org>
 <b88de305-cb1f-7251-ccb8-4ea3b62bc322@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88de305-cb1f-7251-ccb8-4ea3b62bc322@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 08:39:50AM +0300, Dmitry Baryshkov wrote:
> On 19/10/2022 16:59, Manivannan Sadhasivam wrote:
> > Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> > cores. But this relationship is not represented with the clk framework
> > so far.
> > 
> > So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> > clock producer/consumer relationship cleaner and is also useful for CPU
> > related frameworks like OPP to know the frequency at which the CPUs are
> > running.
> > 
> > The clock frequency provided by the driver is for each CPU policy. We
> > cannot get the frequency of each CPU core because, not all platforms
> > support per-core DCVS feature.
> > 
> > Also the frequency supplied by the driver is the actual frequency that
> > comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> > not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/cpufreq/qcom-cpufreq-hw.c | 67 +++++++++++++++++++++++++++++--
> >   1 file changed, 63 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index a5b3b8d0e164..4dd710f9fb69 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -4,6 +4,7 @@
> >    */
> >   #include <linux/bitfield.h>
> > +#include <linux/clk-provider.h>
> >   #include <linux/cpufreq.h>
> >   #include <linux/init.h>
> >   #include <linux/interconnect.h>
> > @@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
> >   	bool cancel_throttle;
> >   	struct delayed_work throttle_work;
> >   	struct cpufreq_policy *policy;
> > +	struct clk_hw cpu_clk;
> >   	bool per_core_dcvs;
> >   };
> > @@ -482,6 +484,54 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> >   	free_irq(data->throttle_irq, data);
> >   }
> > +static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > +{
> > +	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
> > +
> > +	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
> > +}
> > +
> > +static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
> > +	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
> > +};
> > +
> > +static int qcom_cpufreq_hw_clk_add(struct qcom_cpufreq_data *data, u32 index)
> > +{
> > +	struct platform_device *pdev = cpufreq_get_driver_data();
> > +	struct device *dev = &pdev->dev;
> > +	char *clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", index);
> > +	static struct clk_init_data init = {};
> > +	int ret;
> > +
> > +	init.name = clk_name;
> > +	init.flags = CLK_GET_RATE_NOCACHE;
> > +	init.ops = &qcom_cpufreq_hw_clk_ops;
> > +	data->cpu_clk.init = &init;
> > +
> > +	ret = clk_hw_register(dev, &data->cpu_clk);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get, &data->cpu_clk);
> 
> This doesn't look corresponding to the DT bindings you are adding.
> of_clk_hw_simple_get() would return a single clock per dt node, whichever
> arguments were passed, while you are adding clocks correspoding to CPU
> clusters.
> 
> From what I see according to the bindings, you should register a single
> provider using the of_clk_hw_onecell_get() function.
> 

Well, that won't work either :( The detail that I missed in first place is
that the clock providers are added for the same DT node for each policy. So
there is a single clock under the clock provider for a policy but they all
belong to the same DT node.

This works when a clk provider gets added and then followed by "clk_get()"
(that's what happening during the ->init() callback). But each time a new
provider gets added, it is replacing the old for the same DT node.

The problem here is, we do not know how many policys are going to be there
during the probe time. I'll think about a proper solution and update.

Thanks,
Mani

> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
> > +		clk_hw_unregister(&data->cpu_clk);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void qcom_cpufreq_hw_clk_remove(struct qcom_cpufreq_data *data)
> > +{
> > +	struct platform_device *pdev = cpufreq_get_driver_data();
> > +	struct device *dev = &pdev->dev;
> > +
> > +	of_clk_del_provider(dev->of_node);
> > +	clk_hw_unregister(&data->cpu_clk);
> > +}
> > +
> >   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >   {
> >   	struct platform_device *pdev = cpufreq_get_driver_data();
> > @@ -556,19 +606,24 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >   	policy->driver_data = data;
> >   	policy->dvfs_possible_from_any_cpu = true;
> > +	ret = qcom_cpufreq_hw_clk_add(data, index);
> > +	if (ret) {
> > +		dev_err(dev, "Domain-%d failed to add CPU clock\n", index);
> > +		goto error;
> > +	}
> > +
> >   	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
> >   	if (ret) {
> >   		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> > -		goto error;
> > +		goto clk_remove;
> >   	}
> >   	ret = dev_pm_opp_get_opp_count(cpu_dev);
> >   	if (ret <= 0) {
> >   		dev_err(cpu_dev, "Failed to add OPPs\n");
> >   		ret = -ENODEV;
> > -		goto error;
> > +		goto clk_remove;
> >   	}
> > -
> >   	if (policy_has_boost_freq(policy)) {
> >   		ret = cpufreq_enable_boost_support();
> >   		if (ret)
> > @@ -577,9 +632,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >   	ret = qcom_cpufreq_hw_lmh_init(policy, index);
> >   	if (ret)
> > -		goto error;
> > +		goto clk_remove;
> >   	return 0;
> > +
> > +clk_remove:
> > +	qcom_cpufreq_hw_clk_remove(data);
> >   error:
> >   	kfree(data);
> >   unmap_base:
> > @@ -599,6 +657,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> >   	dev_pm_opp_remove_all_dynamic(cpu_dev);
> >   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> >   	qcom_cpufreq_hw_lmh_exit(data);
> > +	qcom_cpufreq_hw_clk_remove(data);
> >   	kfree(policy->freq_table);
> >   	kfree(data);
> >   	iounmap(base);
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
