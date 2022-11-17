Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76562D7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiKQKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:19:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7404E4D5ED;
        Thu, 17 Nov 2022 02:19:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5170F13D5;
        Thu, 17 Nov 2022 02:19:14 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE583F73B;
        Thu, 17 Nov 2022 02:19:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:19:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, robh+dt@kernel.org,
        johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117101903.sw3hxaruj5sfhybw@bogus>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:01:41AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds clock provider support to the Qcom CPUFreq driver for
> supplying the clocks to the CPU cores in Qcom SoCs.
> 
> The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> clocks to the CPU cores. But this is not represented clearly in devicetree.
> There is no clock coming out of the CPUFreq HW node to the CPU. This created
> an issue [1] with the OPP core when a recent enhancement series was submitted.
> Eventhough the issue got fixed in the OPP framework in the meantime, that's
> not a proper solution and this series aims to fix it properly.
> 
> There was also an attempt made by Viresh [2] to fix the issue by moving the
> clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> since those clocks belong to the CPUFreq HW node only.
> 
> The proposal here is to add clock provider support to the Qcom CPUFreq HW
> driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> This correctly reflects the hardware implementation.
> 
> The clock provider is a simple one that just provides the frequency of the
> clocks supplied to each frequency domain in the SoC using .recalc_rate()
> callback. The frequency supplied by the driver will be the actual frequency
> that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> is not same as what the CPUFreq framework has set but it is the one that gets
> supplied to the CPUs after throttling by LMh.
> 
> This series has been tested on SM8450 based dev board with the OPP hack removed
> and hence there is a DTS change only for that platform. Once this series gets
> accepted, rest of the platform DTS can also be modified and finally the hack on
> the OPP core can be dropped.
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/lkml/YsxSkswzsqgMOc0l@hovoldconsulting.com/
> [2] https://lore.kernel.org/lkml/20220801054255.GA12039@thinkpad/t/
> 
> Changes in v7:
> 
> * Added a patch that returns the throttled frequency for cpufreq_driver->get()
>   callback (Sudeep & Viresh)
> * Added error check for kasprintf and allocated the clk name locally
> 
> Changes in v6:
> 
> * Removed the local variable clk_name (Matthias)
> * Added the clock id to the error message of devm_clk_hw_register()
> 
> Changes in v5:
> 
> * Switched to Hz unit for the CPU clocks
> 
> Changes in v4:
> 
> * Rebased on top of cpufreq/arm/linux-next branch
> 
> Changes in v3:
> 
> * Submitted the cpufreq driver cleanup patches as a separate series as
>   suggested by Viresh
> * Removed static keyword from clk_init_data declaration
> 
> Changes in v2:
> 
> * Moved the qcom_cpufreq_data allocation to probe
> * Added single clock provider with multiple clks for each freq domain
> * Moved soc_data to qcom_cpufreq struct
> * Added Rob's review for binding
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
>   arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
>   cpufreq: qcom-hw: Add CPU clock provider support

Why do you need the above 3 changes if the below(4/4) will ensure
cpufreq_get(cpu) returns the clock frequency. I was expecting to drop the
whole "confusing" clock bindings and the unnecessary clock provider.

Can't we just use cpufreq_get(cpu) ?

-- 
Regards,
Sudeep
