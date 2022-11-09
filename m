Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8319623070
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKIQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiKIQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:47:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BDEF233A7;
        Wed,  9 Nov 2022 08:47:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CA251FB;
        Wed,  9 Nov 2022 08:47:31 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92CF23F534;
        Wed,  9 Nov 2022 08:47:22 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:47:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        viresh.kumar@linaro.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221109164719.d7kowdu7wskyzjsc@bogus>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
 <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
 <20221108155717.srlnabls5ze2resx@bogus>
 <20221109074908.GC4651@thinkpad>
 <20221109110831.lngwmwyjqp4qj73r@bogus>
 <20221109123526.GA29805@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109123526.GA29805@thinkpad>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 06:05:26PM +0530, Manivannan Sadhasivam wrote:
> I don't think using the final DCVS frequency would be applicable for cpufreq
> core.
> 
> cpufreq core sets the desired frequency in the form of index using the
> target_index() callback and the qcom-cpufreq-hw driver uses that index directly
> to select the specific entry in the hardware LUT (Look Up Table).
> 
> Then with get() callback, the frequency will be returned based on the LUT index
> read from the hardware. In this case, the frequency is going to be static
> (i.e, what gets set by the cpufreq core will be the same). I believe this is
> what the API also expects.
>

I guessed so and hence thought of asking. Is the cpufreq_get() API expected
to return something close to what was set or is it expected to return the
real set h/w value if and when possible. I wanted to confirm if that is the
expectation from the cpufreq core or is it just the way qcom cpufreq-hw
driver(probably many others too) work today.

> In the case of qcom_lmh_get_throttle_freq(), the frequency is going to be
> dynamic (i.e changes with every internal DCVS operation). But this is exactly
> what the OPP core expects with clk_get_rate() of CPU clock, so using
> qcom_lmh_get_throttle_freq() makes sense there.
>

OK, the reason I ask is that IIRC the ACPI CPPC driver might get the exact
delivered frequency rather than something based on the set value, so it
shouldn't be a requirement but I may be wrong.

Viresh, thoughts ?

--
Regards,
Sudeep
