Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF4A66A38D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAMTmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjAMTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:42:26 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C3889BC0;
        Fri, 13 Jan 2023 11:41:34 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id d188so7354280oia.3;
        Fri, 13 Jan 2023 11:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mBnUYKy58RXajii2MNybXybrXIhWph3hvd6cbN/7aE=;
        b=JvAo93TLhkMDSiStmpQYM2n3QdRJW76nz5/KXIuMX+xhT8woYd54o1sBE+UkXNC13T
         WWsquiLF+aUfGgr8O/7yYxPIxPplbvvvN4JJF74NBqpnGeAvk8zyNLmAwDLXVY6zyKt0
         2+0Qfc9yqhp8zxH1OEhql4VsQkYk4/P/GYPfYx4DKSJy0N9sZggagFR245PwwdP9xv8s
         7cUha5CXT/aH9FnOm19felIJbfn+9Hr9cXagmEuQ0Vpig/h3oaRM2GQxCOoPHEL2nU7o
         bDvmqBM8o6DKq5/MI5UvQG7B2pnR/8IDFZBC1j6OO8ncZpikFqFxGFJ1QDHH4iGwno9k
         +3FA==
X-Gm-Message-State: AFqh2kqFOoE/Cosw48Q6VWvaXHNpB60o90nm/qySlawOdtTFIYMpbR/y
        EWuURiX4Jr3is7sazcwIpeOxVfIShQ==
X-Google-Smtp-Source: AMrXdXvWdX+bakMJiR46G9PhYUmShF9HfgpmIt8PBbBqhcO+m+xgN6Pll57Y821zYtm+MA2FQKd/ew==
X-Received: by 2002:aca:d0a:0:b0:364:6fd1:92d6 with SMTP id 10-20020aca0d0a000000b003646fd192d6mr6410758oin.25.1673638894083;
        Fri, 13 Jan 2023 11:41:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg31-20020a056808179f00b00363b5a6bc9esm9693433oib.12.2023.01.13.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:41:33 -0800 (PST)
Received: (nullmailer pid 2821769 invoked by uid 1000);
        Fri, 13 Jan 2023 19:41:32 -0000
Date:   Fri, 13 Jan 2023 13:41:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Ensure only freq-domain regs are
 counted in num_domains
Message-ID: <20230113194132.GA2806609-robh@kernel.org>
References: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
 <20230111205125.1860858-2-konrad.dybcio@linaro.org>
 <20230112153704.6d37dygm4yfexdq6@builder.lan>
 <7dec47af-0981-7d70-3926-69419f5d1c8e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dec47af-0981-7d70-3926-69419f5d1c8e@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:41:50PM +0100, Konrad Dybcio wrote:
> 
> 
> On 12.01.2023 16:37, Bjorn Andersson wrote:
> > On Wed, Jan 11, 2023 at 09:51:25PM +0100, Konrad Dybcio wrote:
> >> In preparation for CPRh-aware OSM programming, change the probe
> >> function so that we determine the number of frequency domains by
> >> counting the number of reg-names entries that begin with
> >> "freq-domain", as the aforementioned changes require introduction
> >> of non-freq-domain register spaces.
> >>
> > 
> > Requiring reg-names would break backwards compatibility with at least
> > sc7280 and sm6115.
> Ouch, you're correct..
> 
> Does checking for reg-names and applying the code flow proposed in this
> patch if found and the existing one if not sound good?

Why support 2 ways?


> Konrad
> > 
> > Regards,
> > Bjorn
> > 
> >> Fixes: 1a6a8b0080b0 ("cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2")
> >> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++---------
> >>  1 file changed, 24 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> index 9505a812d6a1..89d5ed267399 100644
> >> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> @@ -651,8 +651,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >>  	struct device *dev = &pdev->dev;
> >>  	struct device_node *soc_node;
> >>  	struct device *cpu_dev;
> >> +	const char *reg_name;
> >>  	struct clk *clk;
> >> -	int ret, i, num_domains, reg_sz;
> >> +	int ret, i, num_reg_names, num_domains = 0;
> >>  
> >>  	clk = clk_get(dev, "xo");
> >>  	if (IS_ERR(clk))
> >> @@ -684,19 +685,32 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >>  	if (!soc_node)
> >>  		return -EINVAL;
> >>  
> >> -	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
> >> -	if (ret)
> >> +	num_reg_names = of_property_count_strings(dev->of_node, "reg-names");
> >> +	if (num_reg_names <= 0) {
> >> +		ret = num_reg_names ? num_reg_names : -ENODATA;
> >>  		goto of_exit;
> >> +	}
> >>  
> >> -	ret = of_property_read_u32(soc_node, "#size-cells", &i);
> >> -	if (ret)
> >> -		goto of_exit;
> >> +	for (i = 0; i < num_reg_names; i++) {
> >> +		ret = of_property_read_string_index(dev->of_node, "reg-names", i, &reg_name);
> >> +		if (ret < 0)
> >> +			goto of_exit;
> >>  
> >> -	reg_sz += i;
> >> +		/*
> >> +		 * Check if the i-th reg is a freq-domain base, no need to add 1
> >> +		 * more byte for idx, as sizeof counts \0 whereas strlen does not.
> >> +		 */
> >> +		if (strlen(reg_name) == sizeof("freq-domain")) {
> >> +			/* Check if this reg-name begins with "freq-domain" */
> >> +			if (!strncmp(reg_name, "freq-domain", sizeof("freq-domain") - 1))
> >> +				num_domains++;
> >> +		}
> >> +	}
> >>  
> >> -	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);

This code was not great to begin with. Any code parsing 'reg' on it's 
own is suspect IMO. It's a standard property and all parsing of it 
should be in drivers/of/address.c. (Yes, I know there are other cases.)

The reg entries are already available as platform_device resources? Why 
don't you use that? There's also of_address_count(), but I prefer if 
there's a platform device equivalent like we have for interrupts.

Rob
