Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA862DA49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiKQMJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiKQMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:08:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 769976EB5E;
        Thu, 17 Nov 2022 04:08:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9481B13D5;
        Thu, 17 Nov 2022 04:08:57 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CAE03FA31;
        Thu, 17 Nov 2022 04:08:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 12:08:46 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117120846.yhmilsndw2bmmvnv@bogus>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
 <20221117111207.GA93179@thinkpad>
 <20221117115203.356vexlpca746o6m@bogus>
 <20221117115807.GF93179@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117115807.GF93179@thinkpad>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:28:07PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 17, 2022 at 11:52:03AM +0000, Sudeep Holla wrote:
> > On Thu, Nov 17, 2022 at 04:42:07PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Nov 17, 2022 at 10:19:03AM +0000, Sudeep Holla wrote:
> > > > 
> > > > Why do you need the above 3 changes if the below(4/4) will ensure
> > > > cpufreq_get(cpu) returns the clock frequency. I was expecting to drop the
> > > > whole "confusing" clock bindings and the unnecessary clock provider.
> > > > 
> > > > Can't we just use cpufreq_get(cpu) ?
> > > > 
> > > 
> > > This can be possible for OPP implementations for the CPUs but not for other
> > > peripherals making use of OPP framework like GPU etc... Moreover this may end
> > > up with different code path for CPUs and other peripherals inside OPP framework.
> > > 
> > 
> > Fair enough, you can use this for non-CPU devices. But you are adding this for
> > CPUs here. Is the consumer unaware that this is a CPU or non-CPU device ?
> > If so, make sense. Otherwise, it is unnecessary to go through the clk
> > framework to get CPU frequency.
> > 
> 
> The consumer here is the OPP framework and yes it doesn't have the knowledge of
> the device it is dealing with (for this context).

Ah OK, I thought it is something else. Does this mean OPP is tied with clk
framework or clock bindings ? Is this for some specific feature ? Or is it
compulsory for all the devices using OPP ? Just wondering how this affects
SCMI which doesn't use or provide clocks yet.

-- 
Regards,
Sudeep
