Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC516B2B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCIRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCIRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:02:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3234D612
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678381007; x=1709917007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gQsyaOmL6yMIOeYRC+4YKTrY8vU3xJzoVCBgJxmA+m4=;
  b=m/XozKnXrzTvUyJWxbdKL6jdK5dMl1bf9XYlNqTWZxw22LYWArkJU6bo
   6kVyz4YFeq8XVPN2TlqENC67kD7fPBU9uxe3usNAYViSdhnQyanG+B4sG
   fD0gd2j8Bxfzj1mxwpDEs3mZJcuewGlc2c/IOMqQkE8rjfKoykp47xwTX
   2brKCTOlcE9wntSmFPTQ4fgOJfI2D96nD4XJSFB3p7tHZhQC8rTg4eXcO
   37XN7hIZcIawLg8MHJD9I3cQfxULVr8ZwKJLZkcn/jA2KeoKX6THkHAD2
   LDZNEB7G9XU19H2gct+LXzxZzOKJuMqIRpCie0COJwU/iHfG6wv4rTuUS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335202801"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="335202801"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 08:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="787659055"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="787659055"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 08:56:46 -0800
Received: from [10.209.16.11] (kliang2-mobl1.ccr.corp.intel.com [10.209.16.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E4493580BBE;
        Thu,  9 Mar 2023 08:56:44 -0800 (PST)
Message-ID: <44422a27-081b-0722-58c4-ace1b7e871f8@linux.intel.com>
Date:   Thu, 9 Mar 2023 11:56:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
 <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
 <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com>
 <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
 <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com>
 <CANDhNCpnoRjrX7k7spDdnUgwzygVUoaF5u7A2-heQfCuokcN6Q@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCpnoRjrX7k7spDdnUgwzygVUoaF5u7A2-heQfCuokcN6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-08 8:17 p.m., John Stultz wrote:
> On Wed, Mar 8, 2023 at 10:44 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-02-17 6:11 p.m., John Stultz wrote:
>>> On Tue, Feb 14, 2023 at 12:38 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>> On 2023-02-14 3:11 p.m., John Stultz wrote:
>>>>> On Tue, Feb 14, 2023 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>> On 2023-02-14 9:51 a.m., Liang, Kan wrote:
>>>>>>> If I understand correctly, the idea is to let the user space tool run
>>>>>>> the above interpoloation algorithm several times to 'guess' the atomic
>>>>>>> mapping. Using the mapping information to covert the TSC from the PEBS
>>>>>>> record. Is my understanding correct?
>>>>>>>
>>>>>>> If so, to be honest, I doubt we can get the accuracy we want.
>>>>>>>
>>>>>>
>>>>>> I implemented a simple test to evaluate the error.
>>>>>
>>>>> Very cool!
>>>>>
>>>>>> I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algorithm
>>>>>> at the start and end of perf cmd.
>>>>>>         MONO_RAW        TSC
>>>>>> start   89553516545645  223619715214239
>>>>>> end     89562251233830  223641517000376
>>>>>>
>>>>>> Here is what I get via mult/shift conversion from this patch.
>>>>>>         MONO_RAW        TSC
>>>>>> PEBS    89555942691466  223625770878571
>>>>>>
>>>>>> Then I use the time information from start and end to create a linear
>>>>>> function and 'guess' the MONO_RAW of PEBS from the TSC. I get
>>>>>> 89555942692721.
>>>>>> There is a 1255 ns difference.
>>>>>> I tried several different PEBS records. The error is ~1000ns.
>>>>>> I think it should be an observable error.
>>>>>
>>>>> Interesting. That's a good bit higher than I'd expect as I'd expect a
>>>>> clock_gettime() call to take ~ double digit nanoseconds range on
>>>>> average, so the error should be within that.
>>>>>
>>>>> Can you share your logic?
>>>>>
>>>>
>>>> I run the algorithm right before and after the perf command as below.
>>>> (The source code of time is attached.)
>>>>
>>>> $./time
>>>> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
>>>> $./time
>>>>
>>>> The time will dump both MONO_RAW and TSC. That's where "start" and "end"
>>>> from.
>>>> The perf command print out both TSC and converted MONO_RAW (using the
>>>> mul/shift from this patch series). That's where "PEBS" value from.
>>>>
>>>> Than I use the below formula to calculate the guessed MONO_RAW of PEBS TSC.
>>>> Guessed_MONO_RAW = (PEBS_TSC - start_TSC) / (end_TSC - start_TSC) *
>>>> (end_MONO_RAW - start_MONO_RAW) + start_MONO_RAW.
>>>>
>>>> The guessed_MONO_RAW is 89555942692721.
>>>> The PEBS_MONO_RAW is 89555942691466.
>>>> The difference is 1255.
>>>>
>>>> Is the calculation correct?
>>>
>>> Thanks for sharing it. The equation you have there looks ok at a high
>>> level for the values you captured (there's small tweaks like doing the
>>> mult before the div to make sure you don't hit integer precision
>>> issues, but I didn't see that with your results).
>>>
>>> I've got a todo to try to see how the calculation changes if we do
>>> provide atomic TSC/RAW stamps, here but I got a little busy with other
>>> work and haven't gotten to it.
>>> So my apologies, but I'll try to get back to this soon.
>>>
>>
>> Have you got a chance to try the idea?
>>
>> I just want to check whether the userspace interpolation approach works.
>> Should I prepare V3 and go back to the kernel solution?
> 
> Oh, my apologies. I had some other work come up and this fell off my plate.
> 
> So I spent a little bit of time today adding some trace_printks to the
> timekeeping code so I could record the actual TSC and timestamps being
> calculated from CLOCK_MONOTONIC_RAW.
> 
> I did catch one error in the test code, which unfortunately I'm to blame for:
>   mid = start + (delta +(delta/2))/2; //round-closest
> 
> That should be
>   mid = start + (delta +(2/2))/2  //round-closest
> or more simply
>   mid = start + (delta +1)/2; //round-closest
> 
> Generalized rounding should be: (value + (DIV/2))/DIV), but I'm
> guessing with two as the divisor, my brain mixed it up and typed
> "delta". My apologies!
> 
> With that fix, I'm seeing closer to ~500ns of error in the
> interpolation, just using the userland sampling.   Now, I've also
> disabled vsyscalls for this (otherwise I wouldn't be able to
> trace_printk), so the error likely would be higher than with
> vsyscalls.
> 
> Now, part of the error is that:
>   start= rdtsc();
>   clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
>   end = rdtsc();
> 
> Ends up looking like
>   start= rdtsc();
>   clock_gettime() {
>      now = rdtsc();
>      delta = now - last;
>      ns = (delta * mult) >> shift
> [~midpoint~]
>      ts->nsec = base_ns + ns;
>      ts->sec = base_sec;
>      normalize_ts(ts)
>   }
>   end = rdtsc();
> 
> And so by taking the mid-point we're always a little skewed from where
> the tsc was actually read.  Looking at the data for my case the tsc
> read seems to be ~12% in, so you could instead try:
> 
> delta = end - start;
> p12 = start + ((delta * 12) + (100/2))/100;
> 
> With that adjustment, I'm seeing error around ~40ns.
> 
> Mind giving that a try?

I tried both the new mid and p12. The error becomes even larger.

With new mid (start + (delta +1)/2), the error is now ~3800ns
With p12 adjustment, the error is ~6700ns.


Here is how I run the test.
$./time
$perf record -e cycles:upp --clockid monotonic_raw $some_workaround
$./time

Here are some raw data.

For the first ./time,
start: 961886196018
end: 961886215603
MONO_RAW: 341485848531

For the second ./time,
start: 986870117783
end: 986870136152
MONO_RAW: 351495432044

Here is the time generated from one PEBS record.
TSC: 968210217271
PEBS_MONO_RAW (calculated via kernel conversion information): 344019503072

Using new mid (start + (delta +1)/2), the guessed PEBS_MONO_RAW is
344019506897. The error is 3825ns.
Using p12 adjustment, the guessed PEBS_MONO_RAW is 344019509831.
The error is 6759ns

Thanks,
Kan
> 
> Now, if you had two snapshots of MONOTONIC_RAW + the TSC value used to
> calculate it(maybe the driver access this via a special internal
> timekeeping interface), in my testing interpolating will give you
> sub-ns error. So I think this is workable without exposing quite so
> much to userland.
> 
> thanks
> -john
