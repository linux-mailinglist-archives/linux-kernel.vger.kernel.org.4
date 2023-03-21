Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F596C359F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCUP1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCUP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:27:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F1A4A1FB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679412419; x=1710948419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eqCW/4qYymwba3TT+nvEFmOTqofddEHVEWApk+Ial4I=;
  b=X0rPlPC/c01iW4YK/16PqBDn0Zb81DpdE34CbhONjmQM6Css74y5XX9L
   o4jwml10ET1jHaNFl0y7C5nvht629zLLfUlEJxK5Du3woiHKJK7awmQly
   MdKAJO8SEvHQNMNE49XHorgRNTIkLID8xZlCY47sttVfwGrv7LDbJFIYL
   VILLQS7m9NNQ+hRxtEnUDcC6r7vP6aALZHR+fwEo8fBWt29nrxWCqz3Up
   n4Hgrndsodrx1gmi3tIXb4bvbRrXjOWAdPijBF7lSP/IrQemfDSyZT5Yq
   XXyJKEwsYiJ1i34TqSRnoPpWySJ+S4GDy5diYjaP/ORo4fCKZB1Rc7u1A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319361538"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319361538"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="770684377"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="770684377"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2023 08:26:58 -0700
Received: from [10.209.33.254] (kliang2-mobl1.ccr.corp.intel.com [10.209.33.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 35F81580AA4;
        Tue, 21 Mar 2023 08:26:57 -0700 (PDT)
Message-ID: <3ec02222-4096-224d-d3c7-4cea811d76ab@linux.intel.com>
Date:   Tue, 21 Mar 2023 11:26:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
 <44422a27-081b-0722-58c4-ace1b7e871f8@linux.intel.com>
 <CANDhNCq7a7DBhb83veKtVOOkGpHLssgd4JpQ552B40YK51cLsg@mail.gmail.com>
 <76362685-0250-ef03-e6b9-e905a1bfd942@linux.intel.com>
 <CANDhNComKRDdZJ8SJECNdoAzQhmR3vu9yKAtp7NKDmECxff=fg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNComKRDdZJ8SJECNdoAzQhmR3vu9yKAtp7NKDmECxff=fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2023-03-18 2:02 a.m., John Stultz wrote:
> On Mon, Mar 13, 2023 at 2:19 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-03-11 12:55 a.m., John Stultz wrote:
>>> On Thu, Mar 9, 2023 at 8:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>> On 2023-03-08 8:17 p.m., John Stultz wrote:
>>>>> So I spent a little bit of time today adding some trace_printks to the
>>>>> timekeeping code so I could record the actual TSC and timestamps being
>>>>> calculated from CLOCK_MONOTONIC_RAW.
>>>>>
>>>>> I did catch one error in the test code, which unfortunately I'm to blame for:
>>>>>   mid = start + (delta +(delta/2))/2; //round-closest
>>>>>
>>>>> That should be
>>>>>   mid = start + (delta +(2/2))/2  //round-closest
>>>>> or more simply
>>>>>   mid = start + (delta +1)/2; //round-closest
>>>>>
>>>>> Generalized rounding should be: (value + (DIV/2))/DIV), but I'm
>>>>> guessing with two as the divisor, my brain mixed it up and typed
>>>>> "delta". My apologies!
>>>>>
>>>>> With that fix, I'm seeing closer to ~500ns of error in the
>>>>> interpolation, just using the userland sampling.   Now, I've also
>>>>> disabled vsyscalls for this (otherwise I wouldn't be able to
>>>>> trace_printk), so the error likely would be higher than with
>>>>> vsyscalls.
>>>>>
>>>>> Now, part of the error is that:
>>>>>   start= rdtsc();
>>>>>   clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
>>>>>   end = rdtsc();
>>>>>
>>>>> Ends up looking like
>>>>>   start= rdtsc();
>>>>>   clock_gettime() {
>>>>>      now = rdtsc();
>>>>>      delta = now - last;
>>>>>      ns = (delta * mult) >> shift
>>>>> [~midpoint~]
>>>>>      ts->nsec = base_ns + ns;
>>>>>      ts->sec = base_sec;
>>>>>      normalize_ts(ts)
>>>>>   }
>>>>>   end = rdtsc();
>>>>>
>>>>> And so by taking the mid-point we're always a little skewed from where
>>>>> the tsc was actually read.  Looking at the data for my case the tsc
>>>>> read seems to be ~12% in, so you could instead try:
>>>>>
>>>>> delta = end - start;
>>>>> p12 = start + ((delta * 12) + (100/2))/100;
>>>>>
>>>>> With that adjustment, I'm seeing error around ~40ns.
>>>>>
>>>>> Mind giving that a try?
>>>>
>>>> I tried both the new mid and p12. The error becomes even larger.
>>>>
>>>> With new mid (start + (delta +1)/2), the error is now ~3800ns
>>>> With p12 adjustment, the error is ~6700ns.
>>>>
>>>>
>>>> Here is how I run the test.
>>>> $./time
>>>> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
>>>> $./time
>>>>
>>>> Here are some raw data.
>>>>
>>>> For the first ./time,
>>>> start: 961886196018
>>>> end: 961886215603
>>>> MONO_RAW: 341485848531
>>>>
>>>> For the second ./time,
>>>> start: 986870117783
>>>> end: 986870136152
>>>> MONO_RAW: 351495432044
>>>>
>>>> Here is the time generated from one PEBS record.
>>>> TSC: 968210217271
>>>> PEBS_MONO_RAW (calculated via kernel conversion information): 344019503072
>>>>
>>>> Using new mid (start + (delta +1)/2), the guessed PEBS_MONO_RAW is
>>>> 344019506897. The error is 3825ns.
>>>> Using p12 adjustment, the guessed PEBS_MONO_RAW is 344019509831.
>>>> The error is 6759ns
>>>
>>> Huh. I dunno. That seems wild that the error increased.
>>>
>>> Just in case something is going astray with the PEBS_MONO_RAW logic,
>>> can you apply the hack patch I was using to display the MONOTONIC_RAW
>>> values the kernel calculates?
>>>   https://github.com/johnstultz-work/linux-dev/commit/8d7896b078965b059ea5e8cc21841580557f6df6
>>>
>>> It uses trace_printk, so you'll have to cat /sys/kernel/tracing/trace
>>> to get the output.
>>>
>>
>>
>> $ ./time_3
>> start: 7358368893806 end: 7358368902944 delta: 9138
>> MONO_RAW: 2899739790738
>> MID: 7358368898375
>> P12: 7358368894903
>> $ sudo cat /sys/kernel/tracing/trace | grep time_3
>>           time_3-1443    [002] .....  2899.858936: ktime_get_raw_ts64:
>> JDB: timekeeping_get_delta cycle_now: 7358368897679
>>           time_3-1443    [002] .....  2899.858937: ktime_get_raw_ts64:
>> JDB: ktime_get_raw_ts64: 2899739790738
>>
>> The error between MID and cycle_now is -696ns
>> The error between P12 and cycle_now is 2776ns
> 
> Hey Kan,
>   So I'm terribly sorry, I'm a bit underwater right now and haven't
> had time to look deeper at this. The MID case you have above looks
> closer to what I was seeing but I can't explain why the 12% case is
> worse.
> 
> Since I feel it's not really fair to object to your patch but not have
> the time to work through an alternative with you, I'm going to
> withdraw my objection (though others may persist!).
> I'd still really prefer if we avoided exposing internal timekeeping
> state directly to userland, and it would be good to see some further
> exploration in other directions, but there is the existing perf mmap
> precedence (even if I dislike it).   Sorry I can't be of more help to
> find a better approach here. :(
> 

Thank you all the same. I think we learnt that there should be more work
for the pure user space solution. It is not a solution for the monotonic
raw conversion for now.

I have no idea how to do the post-processing conversion without the
internal conversion information.
So, for now, there seems only two candidate solutions.
- Pure kernel solution (Similar to V1).
- Expose the internal conversion information to the user space and does
post-processing conversion. (V2)

I will ping Thomas in the other thread and see if he has any suggestions.

Thanks,
Kan
