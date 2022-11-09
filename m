Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10424622BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKIMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:35:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42B175B2;
        Wed,  9 Nov 2022 04:35:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD6061A6C;
        Wed,  9 Nov 2022 12:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE482C433C1;
        Wed,  9 Nov 2022 12:35:31 +0000 (UTC)
Date:   Wed, 9 Nov 2022 18:05:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org,
        viresh.kumar@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221109123526.GA29805@thinkpad>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
 <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
 <20221108155717.srlnabls5ze2resx@bogus>
 <20221109074908.GC4651@thinkpad>
 <20221109110831.lngwmwyjqp4qj73r@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109110831.lngwmwyjqp4qj73r@bogus>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:08:31AM +0000, Sudeep Holla wrote:
> On Wed, Nov 09, 2022 at 01:19:08PM +0530, Manivannan Sadhasivam wrote:
> 
> [...]
> 
> > qcom_cpufreq_hw_get() returns the frequency that got programmed by the cpufreq
> > core. But that frequency is not necessarily the one that gets delivered to the
> > CPU cores because the EPSS/OSM hardware block may vary the frequency after the
> > DCVS operation.
> > 
> > So this frequency is the final one that gets delivered to the CPU cores.
> > 
> 
> OK, thanks for the info. Just wondering if there is any issue making
> qcom_cpufreq_hw_get() return this value instead of all these complexity.
> I think the DT binding is too confusing as cpufreq-dt uses that to manage
> DVFS which this one uses it.
> 
> If possible we should just make cpufreq_get(cpu) return the value you need
> and use the same where ever you need. Sorry if I am missing something obvious
> but I am struggling to see that.
> 

I don't think using the final DCVS frequency would be applicable for cpufreq
core.

cpufreq core sets the desired frequency in the form of index using the
target_index() callback and the qcom-cpufreq-hw driver uses that index directly
to select the specific entry in the hardware LUT (Look Up Table).

Then with get() callback, the frequency will be returned based on the LUT index
read from the hardware. In this case, the frequency is going to be static
(i.e, what gets set by the cpufreq core will be the same). I believe this is
what the API also expects.

In the case of qcom_lmh_get_throttle_freq(), the frequency is going to be
dynamic (i.e changes with every internal DCVS operation). But this is exactly
what the OPP core expects with clk_get_rate() of CPU clock, so using
qcom_lmh_get_throttle_freq() makes sense there.

Thanks,
Mani

> -- 
> Regards,
> Sudeep

-- 
மணிவண்ணன் சதாசிவம்
