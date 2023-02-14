Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCB696AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBNRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:00:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD102E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676394009; x=1707930009;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6w3IpCDuPLIKFZtnviHXY23jwRbMSUMPP4Yq37TxIVk=;
  b=aAMpidOvYI0HG6sBYc+sPMJcZDxW+FqBS6Bsr85TxhAwsH7ARqrD//zy
   WI10QC95bXYfMLISgBQL3CFQkno/cnQT8ijiI3AtQ6PY2rjPBSiBcPRVO
   RyoEwJisOc0TCHEoMqLORRu/pTsn2F5/WXyQwNX185NmaJbMkcB/Zh54a
   xFSSbsmpd19r520Zdb1l3lqgPkRMUGD77CiVNtq349tundrJSR9YfmDEu
   yjEJeQ6AqDfm5gj1P3fYrocVOySbwTmTRyj7NBqTQ/I+RRKC1+yk3Dc7r
   jUZ1yrEzUpSBoBvjZAyVQw82YePRbyx7iusPd8BMxOrgEpBki+oYbtZW6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311568030"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="311568030"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="646821521"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="646821521"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2023 09:00:07 -0800
Received: from [10.251.7.65] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3C868580B9E;
        Tue, 14 Feb 2023 09:00:06 -0800 (PST)
Message-ID: <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
Date:   Tue, 14 Feb 2023 12:00:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
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
In-Reply-To: <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-14 9:51 a.m., Liang, Kan wrote:
> 
> 
> On 2023-02-13 5:22 p.m., John Stultz wrote:
>> On Mon, Feb 13, 2023 at 1:40 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>> On 2023-02-13 2:37 p.m., John Stultz wrote:
>>>> On Mon, Feb 13, 2023 at 11:08 AM <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> The monotonic raw clock is not affected by NTP/PTP correction. The
>>>>> calculation of the monotonic raw clock can be done in the
>>>>> post-processing, which can reduce the kernel overhead.
>>>>>
>>>>> Add hw_time in the struct perf_event_attr to tell the kernel dump the
>>>>> raw HW time to user space. The perf tool will calculate the HW time
>>>>> in post-processing.
>>>>> Currently, only supports the monotonic raw conversion.
>>>>> Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
>>>>> HW time can only be provided in a sample by HW. For other type of
>>>>> records, the user requested clock should be returned as usual. Nothing
>>>>> is changed.
>>>>>
>>>>> Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
>>>>> conversion information. The cap_user_time_mono_raw also indicates
>>>>> whether the monotonic raw conversion information is available.
>>>>> If yes, the clock monotonic raw can be calculated as
>>>>> mono_raw = base + ((cyc - last) * mult + nsec) >> shift
>>>>
>>>> Again, I appreciate you reworking and resending this series out, I
>>>> know it took some effort.
>>>>
>>>> But oof, I'd really like to make sure we're not exporting timekeeping
>>>> internals to userland.
>>>>
>>>> I think Thomas' suggestion of doing the timestamp conversion in
>>>> post-processing was more about interpolating collected system times
>>>> with the counter (tsc) values captured.
>>>>
>>>
>>> Thomas, could you please clarify your suggestion regarding "the relevant
>>> conversion information" provided by the kernel?
>>> https://lore.kernel.org/lkml/87ilgsgl5f.ffs@tglx/
>>>
>>> Is it only the interpolation information or the entire conversion
>>> information (Mult, shift etc.)?
>>>
>>> If it's only the interpolation information, the user space will be lack
>>> of information to handle all the cases. If I understand John's comments
>>> correctly, it could also bring some interpolation error which can only
>>> be addressed by the mult/shift conversion.
>>
> 
> 
> Thanks for the details John.
> 
>> "Only" is maybe too strong a word. I think having the driver use
>> kernel timekeeping accessors to CLOCK_MONONOTONIC_RAW time with
>> counter values will minimize the error.
>>
> 
> The key motivation of using the TSC in the PEBS record is to get an
> accurate timestamp of each record. We definitely want the conversion has
> minimized error.
> 
> 
>> But again, it's not yet established that any interpolation error using
>> existing interfaces is great enough to be problematic here.
>>
>> The interpoloation is pretty easy to do:
>>
>> do {
>>     start= readtsc();
>>     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
>>     end = readtsc();
>>     delta = end-start;
>> } while (delta  > THRESHOLD)   // make sure the reads were not preempted
>> mid = start + (delta +(delta/2))/2; //round-closest
>>
> 
> How to choose the THRESHOLD? It seems the THRESHOLD value also impacts
> the accuracy.
> 
> 
>> and be able to get you a fairly close matching of TSC to
>> CLOCK_MONOTONIC_RAW value.
>>
>> Once you have that mapping you can take a few samples and establish
>> the linear function.
>>
>> But that will have some error, so quantifying that error helps
>> establish why being able to get an atomic mapping of TSC ->
>> CLOCK_MONOTONIC_RAW would help.
>>
>> So I really don't think we need to expose the kernel internal values
>> to userland, but I'm willing to guess the atomic mapping (which the
>> driver will have access to, not userland) may be helpful for the fine
>> granularity you want in the trace.
>>
> 
> If I understand correctly, the idea is to let the user space tool run
> the above interpoloation algorithm several times to 'guess' the atomic
> mapping. Using the mapping information to covert the TSC from the PEBS
> record. Is my understanding correct?
> 
> If so, to be honest, I doubt we can get the accuracy we want.
> 

I implemented a simple test to evaluate the error.

I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algorithm
at the start and end of perf cmd.
	MONO_RAW	TSC
start	89553516545645	223619715214239
end	89562251233830	223641517000376

Here is what I get via mult/shift conversion from this patch.
	MONO_RAW	TSC
PEBS	89555942691466	223625770878571

Then I use the time information from start and end to create a linear
function and 'guess' the MONO_RAW of PEBS from the TSC. I get
89555942692721.
There is a 1255 ns difference.
I tried several different PEBS records. The error is ~1000ns.
I think it should be an observable error.

Thanks,
Kan

