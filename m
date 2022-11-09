Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBEC6224F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKIHzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:55:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBED1B7B2;
        Tue,  8 Nov 2022 23:55:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC403B81D12;
        Wed,  9 Nov 2022 07:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57778C433C1;
        Wed,  9 Nov 2022 07:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667980536;
        bh=t1X8tGhPnTqhrxpV3kqt4S1VIJabTvUnGc+aFkHBdgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTX5AVlssCn5Xtu7RtHEcJvX4iGC7mnlFhxqFZkwcuqiQEJf8b4iMNHC4OnobBH6w
         nC+CCTnP11NXxnD8uCFQyHqBki+Tp43wS9iwTv8Du8EgdKDV78/UvK67cI44aTM53M
         8fITbQmcmTdK0677AEv4+A3Z2inbRrz9azRD/fhVUDy2Aavsa8Vyb0kbHpH7kiOfVp
         OF8UUP6gp6Gmm07lbkt7NbwDY9rYgaNVmohNM5TRoDaokOHahxkBaqHoWFWjzYg1fj
         yi3l1b5O7fiYYrEW9Fy2A6C8VtKwWssbPpsRDqtcZWERHq40qj9mIoU4QlZoDX7iZk
         Tl+H9u9dIv5Iw==
Date:   Wed, 9 Nov 2022 13:25:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221109075527.GD4651@thinkpad>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
 <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
 <Y2qfmFVK665b1Nbw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2qfmFVK665b1Nbw@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:27:36PM +0000, Matthias Kaehlcke wrote:
> Hi,
> 
> On Tue, Nov 08, 2022 at 09:10:37PM +0530, Manivannan Sadhasivam wrote:
> > Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> > cores. But this relationship is not represented with the clk framework
> > so far.
> > 
> > So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> > clock producer/consumer relationship cleaner and is also useful for CPU
> > related frameworks like OPP to know the frequency at which the CPUs are
> > running.
> > 
> > The clock frequency provided by the driver is for each frequency domain.
> > We cannot get the frequency of each CPU core because, not all platforms
> > support per-core DCVS feature.
> > 
> > Also the frequency supplied by the driver is the actual frequency that
> > comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> > not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 5e0598730a04..86bb11de347f 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/init.h>
> >  #include <linux/interconnect.h>
> > @@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
> >  	bool cancel_throttle;
> >  	struct delayed_work throttle_work;
> >  	struct cpufreq_policy *policy;
> > +	struct clk_hw cpu_clk;
> >  
> >  	bool per_core_dcvs;
> >  
> > @@ -615,8 +617,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> >  	.ready		= qcom_cpufreq_ready,
> >  };
> >  
> > +static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > +{
> > +	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
> > +
> > +	return qcom_lmh_get_throttle_freq(data);
> > +}
> > +
> > +static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
> > +	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
> > +};
> > +
> >  static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  {
> > +	struct clk_hw_onecell_data *clk_data;
> >  	struct device *dev = &pdev->dev;
> >  	struct device *cpu_dev;
> >  	struct clk *clk;
> > @@ -659,8 +673,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  
> >  	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
> >  
> > +	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
> > +	if (!clk_data)
> > +		return -ENOMEM;
> > +
> > +	clk_data->num = num_domains;
> > +
> >  	for (i = 0; i < num_domains; i++) {
> >  		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
> > +		struct clk_init_data init = {};
> > +		const char *clk_name;
> >  		struct resource *res;
> >  		void __iomem *base;
> >  
> > @@ -672,6 +694,27 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  
> >  		data->base = base;
> >  		data->res = res;
> > +
> > +		/* Register CPU clock for each frequency domain */
> > +		clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);
> > +		init.name = clk_name;
> 
> nit: 'clk_name' isn't really needed, the result of devm_kasprintf() could be
> assigned directly to 'init.name'. 'init' could be renamed to 'clk_init' if
> the purpose of using 'clk_name' is to make clear that this is the name of a
> clock.
> 

Ack.

Thanks,
Mani

> > +		init.flags = CLK_GET_RATE_NOCACHE;
> > +		init.ops = &qcom_cpufreq_hw_clk_ops;
> > +		data->cpu_clk.init = &init;
> > +
> > +		ret = devm_clk_hw_register(dev, &data->cpu_clk);
> > +		if (ret < 0) {
> > +			dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
> > +			return ret;
> > +		}
> > +
> > +		clk_data->hws[i] = &data->cpu_clk;
> > +	}
> > +
> > +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
> > +		return ret;
> >  	}
> >  
> >  	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
