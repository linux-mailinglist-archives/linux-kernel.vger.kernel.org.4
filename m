Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215076E27C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDNP45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDNP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:56:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6993626BE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681487810; x=1713023810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sqI2bR2Hrn9cV4SNP1ykx8l2wFJBLbfB23ofqfAWA1o=;
  b=kO/6QQ7eH2Cp25R8/XYBCY8eGrrnAMgcsJzP2q4XMgrpBiNpBdUFzVow
   H4DQtek4f8mXdVnPDnmy+mP0Qxw6nPNlKF3tcFu+299jK5ikBfNk7k0aj
   5jA1gREVOHzYTYMDl9u1lb/ZloeFPndexRYnTvNI8mFB7wJNXD1AT2BtZ
   UxUiNsXE5HDSa2yslnWmaFXn3NiT8vwGeWI/idAeZYLNprwlPykyV3VIT
   vdzlDqou2G7wUuw1TD5ozDNL5WpyfnMhznxzLfiZM7mPhhVhseHEQffO2
   nmQYsHvRSNoA37N9YFu0ydq6bJrpDVREa1mZQIxvd9rRfc/PoGVKYCZ+H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324847243"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="324847243"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 08:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="720329427"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="720329427"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2023 08:56:44 -0700
Received: from [10.212.165.245] (kliang2-mobl1.ccr.corp.intel.com [10.212.165.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 941215805CB;
        Fri, 14 Apr 2023 08:56:42 -0700 (PDT)
Message-ID: <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
Date:   Fri, 14 Apr 2023 11:56:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230414145324.GB761523@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-14 10:53 a.m., Peter Zijlstra wrote:
> On Fri, Apr 14, 2023 at 09:35:37AM -0400, Liang, Kan wrote:
>>
>>
>> On 2023-04-14 6:38 a.m., Peter Zijlstra wrote:
>>> On Mon, Apr 10, 2023 at 01:43:48PM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> With the cycle time information between branches, stalls can be easily
>>>> observed. But it's difficult to explain what causes the long delay.
>>>>
>>>> Add a new field to collect the occurrences of events since the last
>>>> branch entry, which can be used to provide some causality information
>>>> for the cycle time values currently recorded in branches.
>>>>
>>>> Add a new branch sample type to indicate whether include occurrences of
>>>> events in branch info.
>>>>
>>>> Only support up to 4 events with saturating at value 3.
>>>> In the current kernel, the events are ordered by either the counter
>>>> index or the enabling sequence. But none of the order information is
>>>> available to the user space tool.
>>>> Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, and generic
>>>> support to dump the event IDs of the branch events.
>>>> Add a helper function to detect the branch event flag.
>>>> These will be used in the following patch.
>>>
>>> I'm having trouble reverse engineering this. Can you more coherently
>>> explain this feature and how you've implemented it?
>>
>> Sorry for that.
>>
>> The feature is an enhancement of ARCH LBR. It adds new fields in the
>> LBR_INFO MSRs to log the occurrences of events on the first 4 GP
>> counters. Worked with the previous timed LBR feature together, the user
>> can understand not only the latency between two LBR blocks, but also
>> which events causes the stall.
>>
>> The spec can be found at the latest Intel® Architecture Instruction Set
>> Extensions and Future Features, v048. Chapter 8.4.
>> https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Oh gawd; that's terse. Why can't these people write comprehensible
> things :/ It's almost as if they don't want this stuff to be used.
> 
> So IA32_LBR_x_INFO is extended:
> 
>   [0:15]	CYC_CNT
>   [16:31]	undefined
> + [32:33]	PMC0_CNT
> + [34:35]	PMC1_CNT
> + [36:37]	PMC2_CNT
> + [38:39]	PMC3_CNT
> + [40:41]	PMC4_CNT
> + [42:43]	PMC5_CNT
> + [44:45]	PMC6_CNT
> + [46:47]	PMC7_CNT
>   [48:55]	undefined
>   [56:59]	BR_TYPE
>   [60]		CYC_CNT_VALID
>   [61]		TSX_ABORT
> 
> Where the PMCx_CNT fields are saturating counters for the respective
> PMCs. And we'll run out of bits if we get more than 12 PMCs. Is SMT=n
> PMC merging still a thing?
> 
> And for some reason this counting is enabled in PERFEVTSELx[35] instead
> of in LBR_CTL somewhere :/
> 
>> To support the feature, there are three main changes in ABIs.
>> - A new branch sample type, PERF_SAMPLE_BRANCH_EVENT, is used as a knob
>> to enable the feature.
> 
>> - Extend the struct perf_branch_entry layout, because we have to save
>> and pass the occurrences of events to user space. Since it's only
>> available for 4 counters and saturating at value 3, it only occupies 8
>> bits. For the current Intel implementation, the order is the order of
>> counters.
> 
> Only for 4? Where does it say that? 

"Per-counter support for LBR Event Logging is indicated by the “Event
Logging Supported” bitmap in
CPUID.(EAX=01CH, ECX=0).ECX[19:16]"

There are only 4 bits to indicate the supported counter.

> If it were to only support 4, then
> we're in counter scheduling contraint hell again 

Unfortunately, yes.

> and we need to somehow
> group all these things together with the LBR event.

Group will bring many limits for the usage. For example, I was told
there could be someone wants to use it with multiplexing.

> 
>   @@ -1410,6 +1423,10 @@ union perf_mem_data_src {
>   *    cycles: cycles from last branch (or 0 if not supported)
>   *      type: branch type
>   *      spec: branch speculation info (or 0 if not supported)
>   + *      events: occurrences of events since the last branch entry.
>   + *              The fields can store up to 4 events with saturating
>   + *              at value 3.
>   + *              (or 0 if not supported)
>   */
>   struct perf_branch_entry {
> 	  __u64   from;
>   @@ -1423,7 +1440,8 @@ struct perf_branch_entry {
> 		  spec:2,     /* branch speculation info */
> 		  new_type:4, /* additional branch type */
> 		  priv:3,     /* privilege level */
>   -               reserved:31;
>   +               events:8,   /* occurrences of events since the last branch entry */
>   +               reserved:23;
>   };
> 
>   union perf_sample_weight {
> 
> This seems properly terrible from an interface pov. What if the next
> generation of silicon extends this to all 8 PMCs or another architecture
> comes along that does this with 3 bits per counter etc...

OK. The reserved space is not enough anymore. I think we have to add
several new fields. I will redesign it.

> 
>> - Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, to dump
>> the order information. User space tool doesn't understand the order of
>> counters. So it cannot map the new fields in struct perf_branch_entry to
>> a specific event. We have to dump the order information.
> 
> Sorry; I can't parse this.

The perf tool has no idea which physical counter is assigned to an event.
The HW has no idea about an event. It only log the information from the
counter 0 into IA32_LBR_x_INFO[32:33].
If we pass the information from IA32_LBR_x_INFO[32:33] to the perf tool.
The perf tool lacks of knowledge to connect the information to an event.
So we have to dump the event ID at the same time.

Thanks,
Kan

