Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107162DC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiKQNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiKQNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:23:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D310D133;
        Thu, 17 Nov 2022 05:23:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE1A81424;
        Thu, 17 Nov 2022 05:23:29 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B262E3F663;
        Thu, 17 Nov 2022 05:23:21 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:23:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117132319.cx7cwt3dwywlt6wx@bogus>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
 <20221117111207.GA93179@thinkpad>
 <20221117115203.356vexlpca746o6m@bogus>
 <20221117115807.GF93179@thinkpad>
 <20221117120846.yhmilsndw2bmmvnv@bogus>
 <20221117123841.GI93179@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117123841.GI93179@thinkpad>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 06:08:41PM +0530, Manivannan Sadhasivam wrote:

[...]
>
> AFAIK, OPP framework needs to know the current frequency of the device it is
> dealing with for setting the device's OPP. So it uses clk_get_rate() of the
> first clock of the device. If the clock is not available, then it uses the
> frequency in the first entry of the OPP table (since it is going to be the
> minimum freq of the device).
>

It has been a while since I followed OPP. Thanks for all the info, helped me
get updated without looking at the code in detail.

> As you can see, the clk_get_rate() is eminent for switching the OPPs and since
> OPP framework doesn't know what device it is dealing with, it cannot use
> cpufreq_get().
>

Agreed. I had assumed the qcom-cpufreq-hw as setting cpufreq directly pocking
the hardware but now I see it is using opp library to set some additional
policy.

> Is SCMI node itself has the OPP tables? Or the consumer nodes of the SCMI?
>

No, OPPs are read from the f/w and we just use OPP APIs to register them.
But we don't use OPP library to set the performance.

> TLDR; If you tell OPP framework to set a new OPP for a device, it needs to the
> know the current frequency of the device. And it is not manadatory now, but in
> the future maybe.
>

Hmm, good to know. I prefer it is not coupled with clocks and have some
alternative mechanism that is suitable for performance domains and don't
enforce the use of clock bindings and clk framework unnecessarily.

--
Regards,
Sudeep`
