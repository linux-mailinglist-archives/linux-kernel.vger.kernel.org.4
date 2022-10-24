Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57F609873
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJXDHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJXDHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:07:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046E748DA;
        Sun, 23 Oct 2022 20:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1540CB80E9F;
        Mon, 24 Oct 2022 03:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D936BC433B5;
        Mon, 24 Oct 2022 03:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666580816;
        bh=OTPB1px/TQ1L+ivbreKiJg+huXfwkJNCMLM8eFY1jAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8I5YOOq6RENk15yBPp/ILx1JAUkXY4gqIsDthh7TOQh993lkGqU98r2z2u65gbe6
         Bka4zV0XH6p5JVKbSfMy5/zvPAEyqbt4vE0KDfLUMVy8ZQjEkVkLkINEVoIuMJA4r1
         8jWiMBALMDYu2Mp2IqmKbuIFFmYUcLARHGVs4tKZsARCBVhZyLWmr/78zpdrz0oQVU
         lv59UcOCKjlpNnFNj5DWNtOVU8Vy2fNO+XMV9I5/Fahy+h4d3q8/XZDSKawmCncY/G
         hu7JPiSYNM26kmsctlGzBOx6C92aKUEFmUmLsLsCMQHVW1HUGk0fUzFNu2TNCFRm59
         Iw+JhhEnNHxZw==
Date:   Sun, 23 Oct 2022 22:06:48 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        viresh.kumar@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221024030648.dthglkkcy5wtziwd@baldur>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
 <20221019135925.366162-4-manivannan.sadhasivam@linaro.org>
 <b88de305-cb1f-7251-ccb8-4ea3b62bc322@linaro.org>
 <20221021093140.GC93287@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021093140.GC93287@thinkpad>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 03:01:40PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 20, 2022 at 08:39:50AM +0300, Dmitry Baryshkov wrote:
> > On 19/10/2022 16:59, Manivannan Sadhasivam wrote:
> > > Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> > > cores. But this relationship is not represented with the clk framework
> > > so far.
> > > 
> > > So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> > > clock producer/consumer relationship cleaner and is also useful for CPU
> > > related frameworks like OPP to know the frequency at which the CPUs are
> > > running.
> > > 
> > > The clock frequency provided by the driver is for each CPU policy. We
> > > cannot get the frequency of each CPU core because, not all platforms
> > > support per-core DCVS feature.
> > > 
> > > Also the frequency supplied by the driver is the actual frequency that
> > > comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> > > not same as what the CPUFreq framework has set but it is the one that gets
> > > supplied to the CPUs after throttling by LMh.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   drivers/cpufreq/qcom-cpufreq-hw.c | 67 +++++++++++++++++++++++++++++--
> > >   1 file changed, 63 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index a5b3b8d0e164..4dd710f9fb69 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -4,6 +4,7 @@
> > >    */
> > >   #include <linux/bitfield.h>
> > > +#include <linux/clk-provider.h>
> > >   #include <linux/cpufreq.h>
> > >   #include <linux/init.h>
> > >   #include <linux/interconnect.h>
> > > @@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
> > >   	bool cancel_throttle;
> > >   	struct delayed_work throttle_work;
> > >   	struct cpufreq_policy *policy;
> > > +	struct clk_hw cpu_clk;
> > >   	bool per_core_dcvs;
> > >   };
> > > @@ -482,6 +484,54 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> > >   	free_irq(data->throttle_irq, data);
> > >   }
> > > +static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > +{
> > > +	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
> > > +
> > > +	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
> > > +}
> > > +
> > > +static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
> > > +	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
> > > +};
> > > +
> > > +static int qcom_cpufreq_hw_clk_add(struct qcom_cpufreq_data *data, u32 index)
> > > +{
> > > +	struct platform_device *pdev = cpufreq_get_driver_data();
> > > +	struct device *dev = &pdev->dev;
> > > +	char *clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", index);
> > > +	static struct clk_init_data init = {};
> > > +	int ret;
> > > +
> > > +	init.name = clk_name;
> > > +	init.flags = CLK_GET_RATE_NOCACHE;
> > > +	init.ops = &qcom_cpufreq_hw_clk_ops;
> > > +	data->cpu_clk.init = &init;
> > > +
> > > +	ret = clk_hw_register(dev, &data->cpu_clk);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get, &data->cpu_clk);
> > 
> > This doesn't look corresponding to the DT bindings you are adding.
> > of_clk_hw_simple_get() would return a single clock per dt node, whichever
> > arguments were passed, while you are adding clocks correspoding to CPU
> > clusters.
> > 
> > From what I see according to the bindings, you should register a single
> > provider using the of_clk_hw_onecell_get() function.
> > 
> 
> Well, that won't work either :( The detail that I missed in first place is
> that the clock providers are added for the same DT node for each policy. So
> there is a single clock under the clock provider for a policy but they all
> belong to the same DT node.
> 
> This works when a clk provider gets added and then followed by "clk_get()"
> (that's what happening during the ->init() callback). But each time a new
> provider gets added, it is replacing the old for the same DT node.
> 
> The problem here is, we do not know how many policys are going to be there
> during the probe time. I'll think about a proper solution and update.
> 

You could get this by looping over all the cpus and count how many
unique qcom,freq-domains you have.

But it seems like a bigger problem is that you need to register your
clock "provider" at a device-level, rather than a policy level. I did
some experiments with moving most of the resource management to probe
and it did look quite promising, but in the end I figured out a shorter
path to per-core frequency voting and threw that code out again.

It seems however that this would be a good idea to pick up.


Beyond resolving Viresh request though, we have the problem that on
SM8350 and SC8280XP (at least), the L3 cache is controlled by per-core
registers residing in the register blocks hogged by the cpufreq driver,
and is configured in unit of Hz. So we can't directly use the osm-l3
model - without hacking up the drivers to allow for overlapping ioremap.

We could probably extend the cpufreq driver to express this as a path
between each core and the L3 cache and just ignore the unit (kBps vs Hz)
(i.e.  duplicate osm-l3 in the cpufreq driver).
But it doesn't seem unreasonable to me to express this as a clock per
CPU and just add another opp-hz value to the opp-table, now that this is
supported.

This design would also allow for profiling based mechanisms to pick
these clocks up and issue clk_set_rate(), if such mechanisms would be
desirable.

Regards,
Bjorn
