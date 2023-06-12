Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2F72BAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjFLIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjFLIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:36:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD87107;
        Mon, 12 Jun 2023 01:36:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B449E1FB;
        Mon, 12 Jun 2023 01:36:57 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70B143F663;
        Mon, 12 Jun 2023 01:36:00 -0700 (PDT)
Message-ID: <d41c0063-6659-e186-ce24-3c125cadbcd8@arm.com>
Date:   Mon, 12 Jun 2023 14:05:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
 <e960d5d5-07a8-2049-7d0a-07268ecfe36a@arm.com>
 <ZIMfVsF50cODuOYx@FVFF77S0Q05N.cambridge.arm.com>
 <ZIMl170wv1ZDyNsK@FVFF77S0Q05N.cambridge.arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZIMl170wv1ZDyNsK@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/23 18:45, Mark Rutland wrote:
> On Fri, Jun 09, 2023 at 01:47:18PM +0100, Mark Rutland wrote:
>> On Fri, Jun 09, 2023 at 10:52:37AM +0530, Anshuman Khandual wrote:
>>> On 6/5/23 19:13, Mark Rutland wrote:
>>>> Looking at <linux/perf_event.h> I see:
>>>>
>>>> | /*
>>>> |  * branch stack layout:
>>>> |  *  nr: number of taken branches stored in entries[]
>>>> |  *  hw_idx: The low level index of raw branch records
>>>> |  *          for the most recent branch.
>>>> |  *          -1ULL means invalid/unknown.
>>>> |  *
>>>> |  * Note that nr can vary from sample to sample
>>>> |  * branches (to, from) are stored from most recent
>>>> |  * to least recent, i.e., entries[0] contains the most
>>>> |  * recent branch.
>>>> |  * The entries[] is an abstraction of raw branch records,
>>>> |  * which may not be stored in age order in HW, e.g. Intel LBR.
>>>> |  * The hw_idx is to expose the low level index of raw
>>>> |  * branch record for the most recent branch aka entries[0].
>>>> |  * The hw_idx index is between -1 (unknown) and max depth,
>>>> |  * which can be retrieved in /sys/devices/cpu/caps/branches.
>>>> |  * For the architectures whose raw branch records are
>>>> |  * already stored in age order, the hw_idx should be 0.
>>>> |  */
>>>> | struct perf_branch_stack {
>>>> |         __u64                           nr;  
>>>> |         __u64                           hw_idx;
>>>> |         struct perf_branch_entry        entries[];
>>>> | };
>>>>
>>>> ... which seems to indicate we should be setting hw_idx to 0, since IIUC our
>>>> records are in age order.
>>> Branch records are indeed in age order, sure will change hw_idx as 0. Earlier
>>> figured that there was no need for hw_idx and hence marked it as -1UL similar
>>> to other platforms like powerpc.
>>
>> That's fair enough; looking at power_pmu_bhrb_read() in
>> arch/powerpc/perf/core-book3s.c, I see a comment:
>>
>> 	Branches are read most recent first (ie. mfbhrb 0 is
>> 	the most recent branch).
>>
>> ... which suggests that should be 0 also, or that the documentation is wrong.
>>
>> Do you know how the perf tool consumes this?
> 
> 
> Thinking about this some more, if what this is saying is that if entries[0]
> must be strictly the last branch, and we've lost branches due to interrupt
> latency, then we clearly don't meet that requirement and must report -1ULL
> here.

'last branch' means relative to the captured records not in absolute terms.
Loosing records for interrupt latency too does not change the relative age
order for the set. Hence '0' might suggest valid relative not absolute age
order for the branch records set.

> 
> So while it'd be nice to figure this out, I'm happy using -1ULL, and would be a
> bit concerned using 0.

Sounds reasonable. If tools are not going to use this anyway, I guess there
is no point in suggesting that each record set has got valid age order with
subtle conditions involved.
