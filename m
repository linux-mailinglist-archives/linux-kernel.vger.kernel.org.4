Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD77200E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjFBLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjFBLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:53:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34DACE67;
        Fri,  2 Jun 2023 04:53:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B091063;
        Fri,  2 Jun 2023 04:52:24 -0700 (PDT)
Received: from [10.57.84.31] (unknown [10.57.84.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67043F67D;
        Fri,  2 Jun 2023 04:51:37 -0700 (PDT)
Message-ID: <93c3f3a6-a3bc-f3ca-9077-8985865b8abf@arm.com>
Date:   Fri, 2 Jun 2023 12:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/5] perf: arm_cspmu: ampere_cspmu: Add support for
 Ampere SoC PMU
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
 <20230601030144.3458136-6-ilkka@os.amperecomputing.com>
 <e15f1773-e843-3bc3-f265-65524ea3385a@arm.com>
 <607a395b-b01f-33e1-c67d-d4bd4d92c3d@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <607a395b-b01f-33e1-c67d-d4bd4d92c3d@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-02 08:13, Ilkka Koskinen wrote:
> 
> Hi Robin,
> 
> On Thu, 1 Jun 2023, Robin Murphy wrote:
>> On 2023-06-01 04:01, Ilkka Koskinen wrote:
>> [...]
>>> +static bool ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
>>> +                    struct perf_event *new)
>>> +{
>>> +    struct perf_event *curr;
>>> +    unsigned int idx;
>>> +    u32 threshold = 0, rank = 0, bank = 0;
>>> +
>>> +    /* We compare the global filter settings to existing events */
>>> +    idx = find_first_bit(cspmu->hw_events.used_ctrs,
>>> +                 cspmu->cycle_counter_logical_idx);
>>> +
>>> +    /* This is the first event */
>>> +    if (idx == cspmu->cycle_counter_logical_idx)
>>> +        return true;
>>> +
>>> +    curr = cspmu->hw_events.events[idx];
>>> +
>>> +    if (get_filter_enable(new)) {
>>> +        threshold    = get_threshold(new);
>>> +        rank        = get_rank(new);
>>> +        bank        = get_bank(new);
>>> +    }
>>> +
>>> +    if (get_filter_enable(new) != get_filter_enable(curr) ||
>>
>> Is there any useful purpose in allowing the user to specify nonzero 
>> rank, bank or threshold values with filter_enable=0? Assuming not, 
>> then between this and ampere_cspmu_set_ev_filter() it appears that you 
>> don't need filter_enable at all.
> 
> Not really. I dropped filter_enable at one point but restored it later 
> to match the smmuv3 pmu driver. I totally agree, it's unnecessary and 
> it's better to remove it completely.

Ah, I see - the SMMU PMCG driver needs that to differentiate between 
"filter values defaulted to 0 because user didn't ask for filtering" and 
"user asked to filter an exact match on StreamID 0", since it's 
impractical to expect userspace tools to understand and manually set the 
all-ones mask value to indicate that filtering wasn't requested. In your 
case, though, since values of 0 appear to mean "no filter", it should 
just work as expected without needing any additional complexity. Ideally 
your interface should reflect the functionality and expected usage model 
of your PMU hardware in the way that's most intuitive and helpful for 
the user - it doesn't need to be influenced by other PMUs that work 
differently.

Thanks,
Robin.
