Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D534B67A564
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjAXWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjAXWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:08:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8491F909
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674598087; x=1706134087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wvM59Edi8nqbgKMNL0z60yihBPX0x9u6/vQtdXNwkFg=;
  b=cFS5YqX0/B+HTTFHve28AdzPOjVIdso4Rug02qjFl3AXJw/cW4ws6bM5
   ZWBz1QsDSgdRGdLcns0woOZP3nO7o6OH5d0fcxcgvMMjUv5fLst02cd2G
   NciEwCa0B1WxRxC5vzRUZ//rT1nsdcHuC8OghG9YtdsFugaQQfwKq5Fht
   eOB/YRwK+twWQ3sA45OTjnlxaxb02n8PpNDkDGJ5iH6P9AALcoN1gzDoy
   LD6r9q1XoJvvwInGFj8hE9xjmdb71J9yy2jdYt18N+zUnhnP8BQZBfRdJ
   xj2w8HeZ/2R/csRuDz9xJkDId3H1ilhxe9o6LIf0d1k2t38fNGeJkEbE6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="388765038"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="388765038"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 14:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907673111"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="907673111"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2023 14:08:06 -0800
Received: from [10.251.2.31] (kliang2-mobl1.ccr.corp.intel.com [10.251.2.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 86A84580AA4;
        Tue, 24 Jan 2023 14:08:05 -0800 (PST)
Message-ID: <c8ad4654-6bfd-2983-036e-e969787992e9@linux.intel.com>
Date:   Tue, 24 Jan 2023 17:08:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to
 monotonic
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        Stephane Eranian <eranian@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com>
 <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
 <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com>
 <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
 <1fb59dfa-1ab9-51ad-98c6-89431aa56918@linux.intel.com>
 <CANDhNCodq8iyRY-md-nRkAPYS5p3iTCgDqZXvWAA108TctQASg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCodq8iyRY-md-nRkAPYS5p3iTCgDqZXvWAA108TctQASg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-24 3:33 p.m., John Stultz wrote:
> On Tue, Jan 24, 2023 at 12:13 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-01-24 1:43 p.m., John Stultz wrote:
>>> On Tue, Jan 24, 2023 at 7:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>> On 2023-01-24 2:01 a.m., John Stultz wrote:
>>>>> On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>>>>>> +               /*
>>>>>> +                * Check whether the given timestamp is on the current
>>>>>> +                * timekeeping interval.
>>>>>> +                */
>>>>>> +               now = tk_clock_read(tkr);
>>>>>> +               interval_start = tkr->cycle_last;
>>>>>> +               if (!cycle_between(interval_start, cycles, now))
>>>>>> +                       return -EOPNOTSUPP;
>>>>> So. I've not fully thought this out, but it seems like it would be
>>>>> quite likely that you'd run into the case where the cycle_last value
>>>>> is updated and your earlier TSC timestamp isn't valid for the current
>>>>> interval. The get_device_system_crosststamp() logic has a big chunk of
>>>>> complex code to try to handle this case by interpolating the cycle
>>>>> value back in time. How well does just failing in this case work out?
>>>>>
>>>> For the case, perf fallback to the time captured in the NMI handler, via
>>>> ktime_get_mono_fast_ns().
>>> This feels like *very* subtle behavior. Maybe I'm misunderstanding,
>>> but the goal seems to be to have more accurate timestamps on the hw
>>> events, and using the captured tsc timestamp avoids the measuring
>>> latency reading the time again. But if every timekeeping update
>>> interval (~tick) you transparently get a delayed value due to the
>>> fallback, it makes it hard to understand which timestamps are better
>>> or worse. The latency between two reads may be real or it may be just
>>> bad luck. This doesn't intuitively seem like a great benefit over more
>>> consistent latency of just using the ktime_get_mono_fast()
>>> timestamping.
>> Your understand is correct. We want a more accurate timestamp for the
>> analysis work.
>>
>> As my understanding, the timekeeping update should not be very often. If
> "Often" depends on your your timescale.
> 
>> I read the code correctly, it should happen only when adjusting NTP or
>> suspending/resuming. If so, I think the drawback should not impact the
>> normal analysis work. I will call out the drwabacks in the comments
>> where the function is used.
> So the adjustments are done at tick time depending on the current NTP
> "error" (basically what the kernel tracks as the delta from its sense
> of what NTP has told us).
> 
> Not just at the time when ntp makes an adjustment.
> 
> So the window for it to happen is every timekeeping update (which is ~HZ).

You mean the tkf->base is updated in each tick?
If so, that should be a problem.

Does the NTP "error" consistently happen on all the platforms? Or just
on some platforms which we can check and limit the usage?

There are two configurations for PEBS, single PEBS, and large PEBS.
For the single PEBS mode, HW triggers a NMI for each record. The TSC is
the time which the record is generated, and we convert it in the same
NMI. I don't think the NTP "error" can impact it.

But for the large PEBS mode, HW triggers a NMI only when a fixed number
of records are generated. It's very likely that the base has been
updated between the records. That could bring troubles, since we can
only fall back to the NMI handler time of the last record. I'm afraid we
have to disable the large PEBS mode.

Stephane,

What do you think?
Is it still useful for you if we only support the single PEBS?


Thanks,
Kan
