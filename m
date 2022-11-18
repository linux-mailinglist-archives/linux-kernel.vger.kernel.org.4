Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC962F416
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiKRLy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241554AbiKRLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:54:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B8093CD9;
        Fri, 18 Nov 2022 03:54:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEBC023A;
        Fri, 18 Nov 2022 03:54:25 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D80D93F587;
        Fri, 18 Nov 2022 03:54:17 -0800 (PST)
Date:   Fri, 18 Nov 2022 11:54:15 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221118115415.gr2crvyhs7rcfbir@bogus>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
 <20221117112403.haffuclwooudvgwz@vireshk-i7>
 <20221117120145.ou2pg7obxnwlsc36@bogus>
 <20221118055730.yrzpuih3zfko5c2q@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118055730.yrzpuih3zfko5c2q@vireshk-i7>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:27:30AM +0530, Viresh Kumar wrote:
> On 17-11-22, 12:01, Sudeep Holla wrote:
> > Thanks for the link. Sorry I still don't get the complete picture. Who are
> > the consumers of these clock nodes if not cpufreq itself.
> > 
> > I am going to guess, so other device(like inter-connect) with phandle into
> > CPU device perhaps ? Also I assume it will have phandle to non-CPU device
> > and hence we need generic device clock solution. Sorry for the noise, but
> > I still find having both clocks and qcom,freq-domain property is quite
> > confusing but I am fine as I understand it bit better now.
> 
> Lemme try to explain what the initial problem was, because of which I suggested
> the DT to be fixed, even if no one is going to use it as a client.
> 
> The OPP core provides two features:
> 
> - Parsing of the OPP table and provide the data to the client.
> - Ability to switch the OPPs, i.e. configuring all resources.
> 
> qcom-cpufreq-hw driver uses both of these, but in a tricky way (like Tegra30).
> It used the OPP core to parse the data, along with "opp-hz" property and switch
> the OPPs by calling dev_pm_opp_set_opp(). But it doesn't want
> dev_pm_opp_set_opp() to change the clock rate, but configure everything else.
> 
> Now the OPP core needs to distinguish platforms for valid and invalid
> configurations, to make sure something isn't broken. For example a developer
> wants to change the OPP along with frequency and passes a valid OPP table. But
> forgets to set the clock entry in device's node. This is an error and the OPP
> core needs to report it. There can be more of such issues with different
> configurations.
> 
> Also, as Mani explained, if the OPP core is required to switch the OPPs, then it
> needs to know the initial frequency of the device to see if we are going up or
> down the frequency graph. And so it will do a clk_get_rate() if there is
> "opp-hz" available.
> 
> 
> What we did in case of Tegra30 (commit 1b195626) is provide a .config_clks
> helper, which does nothing. So the OPP core doesn't need to know if frequency is
> programmed or not.
> 
> The same can not be done for Qcom right now as the CPU node doesn't have the clk
> property though it has "opp-hz".
> 
> Weather we have a user in kernel (OS) or not, shouldn't decide how the DT looks
> like. The DT should clearly define what the hardware looks like, irrespective of
> the users. The CPU has a clock and it should be mentioned. If the OPP core
> chooses to use that information, then it is a fine expectation to have.
> 
> And so we are here. Most likely no one will ever do clk_set_rate() on this new
> clock, which is fine, though OPP core will likely do clk_get_rate() here.
> 
> Hope I was able to clarify few things here.
> 

Thanks a ton for such detailed explanation. Ulf was trying to integrate
genpd + performance domains with SCMI. That is the reason for my interest
in this topic. Sorry for all the trouble.

-- 
Regards,
Sudeep
