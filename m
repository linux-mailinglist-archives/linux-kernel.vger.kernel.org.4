Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36613745F69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGCPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:06:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 285C0EE;
        Mon,  3 Jul 2023 08:06:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3343C2F4;
        Mon,  3 Jul 2023 08:07:14 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED223F663;
        Mon,  3 Jul 2023 08:06:28 -0700 (PDT)
Message-ID: <57a5dc82-f2c9-5190-e3fa-702b2eb2de5e@arm.com>
Date:   Mon, 3 Jul 2023 16:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/17] PM: EM: Add update_power() callback for runtime
 modifications
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-7-lukasz.luba@arm.com>
 <70e630b8-e577-a148-0179-61aedf910c09@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <70e630b8-e577-a148-0179-61aedf910c09@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 5/30/23 10:31, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> The Energy Model (EM) is going to support runtime modifications. This
>> new callback would be used in the upcoming EM changes. The drivers
>> or frameworks which want to modify the EM have to implement the
>> update_power() callback and provide it via EM API
>> em_dev_update_perf_domain(). The callback is then used by the EM
>> framework to get new power values for each frequency in existing EM.
> 
> Do we have any numbers or feedback that the chosen design (i.e. update
> per performance state through update_power()) is performant enough for
> the anticipated use case on real devices?
> 

Yes, we have. I have a testing kernel module which updates the EM
with queue_delayed_work() every 100ms. That update is for Little's EM
where we have 11 OPPs. We call the new callback for each OPP
in the em_dev_update_perf_domain(). I have measured that total function
time.

When we fix all CPUs freq to max freq on pixel6 and disable deep idle
states and leave only WFI, then we can run some tracing and capture the
results:

(The 4 CPUs from top are the little (1.8MHz), than 2 Mid (2.2GHz) and
then 2 big (2.8GHz))
------------------------------------
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain             3104    51236.39 us     16.506 
us       75.344 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain             1264    20768.15 us     16.430 
us       62.257 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain             1166    18632.95 us     15.980 
us       70.707 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain              770    12334.43 us     16.018 
us       66.337 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain              101    920.613 us      9.114 
us        21.380 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain               20    211.830 us      10.591 
us       23.998 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   em_dev_update_perf_domain               15    78.085 us       5.205 
us        7.444 us

------------------------------------

As you can see in avg on Little CPUs it takes ~16us, on Mid ~10us and on
Big ~5us.

If such updating kernel module is implemented correctly, it would be
most often scheduled on the Littles as you can see based on 'Hit'
column.

Therefore, IMO this cost can be OK for the upstream. This EM runtime
change won't be triggered very often. If it would be e.g. every
100ms than the cost ~1.5us per 1 OPP is negligible.

Regards,
Lukasz
