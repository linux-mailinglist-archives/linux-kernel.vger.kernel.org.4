Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C7B679D32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjAXPRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjAXPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:17:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40BE1F496
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674573451; x=1706109451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a4xOERBBsWctpb5VHdowcCjr+mGesLUPgMTN+7bds+U=;
  b=Wo6ZpJCcN0DTTgBnoC3cePJfZ498f5TogZYLpWWLUOotNToxcSQfevzj
   rfQaNpThAp9Uu+36v3Orlzo5Qv+ZGifLWzbY4gGMbn3O9RZjntj7sWH1u
   t9ohF3OA6wv1zj+zzdSen2Ph2xr7PhEtNpKRGTqwNzuISFlko7dbuoMlw
   IV0WKolnNIe6ac6BNYcgqmNT0vsPI+A0bbqv5n7NTE83LxSt0GCMjqr4I
   Bdouw9cBOrLDjGQQiD0KfNLKn9Ex6nUMFe5rkoeGctczmxC8EGz9oXTSA
   MPIoOklQbds+soQXpQhha93JRuIK4RpN/bD+J0rs6XEE6Uv5DCXBdaxoK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314216995"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="314216995"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="692617602"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="692617602"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2023 07:17:31 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1EC97580AA4;
        Tue, 24 Jan 2023 07:17:30 -0800 (PST)
Message-ID: <8cb0ebd6-59ea-5c01-dc2a-d3f11730ab43@linux.intel.com>
Date:   Tue, 24 Jan 2023 10:17:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] perf/x86/intel/ds: Support monotonic clock for PEBS
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-4-kan.liang@linux.intel.com>
 <CANDhNCqMaqg1S4Vt_6Pe6M-9seGwA8Hxb8vR5KnLaByvG1JANg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCqMaqg1S4Vt_6Pe6M-9seGwA8Hxb8vR5KnLaByvG1JANg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-24 1:56 a.m., John Stultz wrote:
> On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Users try to reconcile user samples with PEBS samples and require a
>> common clock source. However, the current PEBS codes only convert to
>> sched_clock, which is not available from the user space.
>>
>> Only support converting to clock monotonic. Having one common clock
>> source is good enough to fulfill the requirement.
>>
>> Enable the large PEBS for the monotonic clock to reduce the PEBS
>> overhead.
>>
>> There are a few rare cases that may make the conversion fails. For
>> example, TSC overflows. The cycle_last may be changed between samples.
>> The time will fallback to the inaccurate SW times. But the cases are
>> extremely unlikely to happen.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> 
> Thanks for sending this out!
> A few minor style issues below and a warning.

Thanks.

> 
>> The patch has to be on top of the below patch
>> https://lore.kernel.org/all/20230123172027.125385-1-kan.liang@linux.intel.com/
>>
>>  arch/x86/events/intel/core.c |  2 +-
>>  arch/x86/events/intel/ds.c   | 30 ++++++++++++++++++++++++++----
>>  2 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 14f0a746257d..ea194556cc73 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3777,7 +3777,7 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
>>  {
>>         unsigned long flags = x86_pmu.large_pebs_flags;
>>
>> -       if (event->attr.use_clockid)
>> +       if (event->attr.use_clockid && (event->attr.clockid != CLOCK_MONOTONIC))
>>                 flags &= ~PERF_SAMPLE_TIME;
>>         if (!event->attr.exclude_kernel)
>>                 flags &= ~PERF_SAMPLE_REGS_USER;
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 7980e92dec64..d7f0eaf4405c 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1570,13 +1570,33 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
>>         return val;
>>  }
>>
>> +static int pebs_get_synctime(struct system_counterval_t *system,
>> +                            void *ctx)
> 
> Just because the abstract function type taken by
> get_mono_fast_from_given_time is vague, doesn't mean the
> implementation needs to be.
> ctx is really a tsc value, right? So let's call it that to make this a
> bit more readable.

Sure, I will use the tsc to replace ctx.

> 
>> +{
>> +       *system = set_tsc_system_counterval(*(u64 *)ctx);
>> +       return 0;
>> +}
>> +
>> +static inline int pebs_clockid_time(clockid_t clk_id, u64 tsc, u64 *clk_id_time)
> 
> clk_id_time is maybe a bit too fuzzy. It is really a mono_ns value,
> right? Let's keep that explicit here.

Yes. Will make it explicit.

> 
>> +{
>> +       /* Only support converting to clock monotonic */
>> +       if (clk_id != CLOCK_MONOTONIC)
>> +               return -EINVAL;
>> +
>> +       return get_mono_fast_from_given_time(pebs_get_synctime, &tsc, clk_id_time);
>> +}
>> +
>>  static void setup_pebs_time(struct perf_event *event,
>>                             struct perf_sample_data *data,
>>                             u64 tsc)
>>  {
>> -       /* Converting to a user-defined clock is not supported yet. */
>> -       if (event->attr.use_clockid != 0)
>> -               return;
>> +       u64 time;
> 
> Again, "time" is too generic a term without any context here.
> mono_nsec or something would be more clear.

Sure.

> 
>> +
>> +       if (event->attr.use_clockid != 0) {
>> +               if (pebs_clockid_time(event->attr.clockid, tsc, &time))
>> +                       return;
>> +               goto done;
>> +       }
> 
> Apologies for this warning/rant:
> 
> So, I do get the NMI safety of the "fast" time accessors (along with
> the "high performance" sounding name!) is attractive, but as its use
> expands I worry the downsides of this interface isn't made clear
> enough.
> 
> The fast accessors *can* see time discontinuities! Because the logic
> is done without holding the tk_core.seq lock, If you are reading in
> the middle of a ntp adjustment, you may find the current value to be
> larger than the next time you read the time.  These discontinuities
> are likely to be very small, but a negative delta will look very large
> as a u64.  So part of using these "fast *and unsafe*" interfaces is
> you get to keep both pieces when it breaks. Make sure the code here
> that is using these interfaces guards against this (zeroing out
> negative deltas).
> 

Thanks for the warning.
I will add more comments and specially handle it here.

Thanks,
Kan
