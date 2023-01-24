Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568767A3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjAXUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAXUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:12:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5F18144
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674591174; x=1706127174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kuoQvFSDe8ByIQVr7QxfdKQgTjZUPEth+kg/QH/tNbo=;
  b=QOLRc+i183KnIfclGOKRAj6teRHQL1lxsk/z/ZWI/+H6+SCd5UhqU+X5
   jMWTOJmHGPAkvZJ7/G1UKYY9f+8Npf14g55Ok3YODnieJOYvzsB3YjFJH
   MSj6FgG0vg/+jY5fxDz7QG9zz9jDVJNvENpb87wj11ELZtTg+rYno0dWo
   Rk1ADYXhKrTkI8tyxh7Q1/wwe15sw2D79bNxqBk5ecLRcHIUPo0xvVGSp
   eJ+AO9crB1R34TYP6/uyXBbjLXNyW/Y2mRo9SLXL1cbHMsrB3ZARYA7Ze
   JqjRbzi3buaLJoxEbAxwn3tmhxTMABIsTLzDhwrVjO0fx/1Sbo2fz6V+k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="309969072"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="309969072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 12:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="770456028"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="770456028"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2023 12:12:53 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 35486580691;
        Tue, 24 Jan 2023 12:12:51 -0800 (PST)
Message-ID: <1fb59dfa-1ab9-51ad-98c6-89431aa56918@linux.intel.com>
Date:   Tue, 24 Jan 2023 15:12:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to
 monotonic
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com>
 <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
 <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com>
 <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-24 1:43 p.m., John Stultz wrote:
> On Tue, Jan 24, 2023 at 7:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-01-24 2:01 a.m., John Stultz wrote:
>>> On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>>>> +               /*
>>>> +                * Check whether the given timestamp is on the current
>>>> +                * timekeeping interval.
>>>> +                */
>>>> +               now = tk_clock_read(tkr);
>>>> +               interval_start = tkr->cycle_last;
>>>> +               if (!cycle_between(interval_start, cycles, now))
>>>> +                       return -EOPNOTSUPP;
>>>
>>> So. I've not fully thought this out, but it seems like it would be
>>> quite likely that you'd run into the case where the cycle_last value
>>> is updated and your earlier TSC timestamp isn't valid for the current
>>> interval. The get_device_system_crosststamp() logic has a big chunk of
>>> complex code to try to handle this case by interpolating the cycle
>>> value back in time. How well does just failing in this case work out?
>>>
>>
>> For the case, perf fallback to the time captured in the NMI handler, via
>> ktime_get_mono_fast_ns().
> 
> This feels like *very* subtle behavior. Maybe I'm misunderstanding,
> but the goal seems to be to have more accurate timestamps on the hw
> events, and using the captured tsc timestamp avoids the measuring
> latency reading the time again. But if every timekeeping update
> interval (~tick) you transparently get a delayed value due to the
> fallback, it makes it hard to understand which timestamps are better
> or worse. The latency between two reads may be real or it may be just
> bad luck. This doesn't intuitively seem like a great benefit over more
> consistent latency of just using the ktime_get_mono_fast()
> timestamping.

Your understand is correct. We want a more accurate timestamp for the
analysis work.

As my understanding, the timekeeping update should not be very often. If
I read the code correctly, it should happen only when adjusting NTP or
suspending/resuming. If so, I think the drawback should not impact the
normal analysis work. I will call out the drwabacks in the comments
where the function is used.

> 
>> The TSC in PEBS is captured by HW when the sample was generated. There
>> should be a small delta compared with the time captured in the NMI
>> handler. But I think the delta should be acceptable as a backup solution
>> for the most analysis cases. Also, I don't think the case (the
>> cycle_last value is updated during the monitoring) should occur very
>> often either. So I drop the history support to simplify the function.
> 
> So the reads and this function are *always* used in NMI context?   Has
> this been stressed with things like SMIs to see how it does if
> interrupted in those cases?

Yes, it's *always* and only used in NMI context.

> 
> My worry is that (as I bored everyone earlier), the
> ktime_get_*_fast_ns() interfaces already have some sharp edges and
> need a fair amount of thought as to when they should be used. This is
> sort of compounding that adding an interface that has further special
> cases where it can fail, making it difficult to fully understand and
> easier to accidentally misuse.
> 
> My other concern is that interfaces always get stretched and used
> beyond anything they were initially planned for (see the
> ktime_get_*fast_ns() interfaces here as an example! :), and in this
> case the logic seems to have lots of implicit dependencies on the
> facts of your specific use case, so it seems a bit fragile should
> folks on other architectures with other constraints try to use it.
> 
> So I just want to push a bit to think how you might be able to
> extend/generalize the existing get_system_crosststamp for your
> purposes, or alternatively find a way to simplify the logic's behavior
> so its less tied to specific constraints ("this works most of the time
> from NMI, but otherwise no promises").  Or at least some better
> documentation around the code, its uses and its constraints? ( "NMI
> safe" is not the same as "Only safe to use from NMI" :)

Since our usage is fixed (only in NMI), I prefer the latter. I think
extending/generalizing the existing function only makes the function
extremely complex and low efficient. The new function should have the
same constraints as the existing ktime_get_mono_fast_ns(). Since perf
can live with the ktime_get_mono_fast_ns(), there should be no problem
with the new function for the constraints. I will add more comments to
clarify the usage and constraints to avoid the abuse of the new function.

Thanks,
Kan

