Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBD696756
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjBNOvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBNOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:51:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C5101
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676386288; x=1707922288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BdTfk4QL3SLrECjJ45QmTLm1+AmI82NvQMspdAlr3uY=;
  b=IfQHKbiwgRzl/8HAJDViJDtyk8LU+cLk3Mhm7CPW/HKWcTrrAqVYbk1A
   BDDogvCJZdJdRcgvG4lLJTmZ7MQt7V9LinGyiyPMSZpMgFHOBonL+hqRx
   BQXnhSFTCwfIwI+C3TQvMnKI8YKT6ieZH1IgcdqCGhoI6VkwOMo3L96cY
   mjBSUBf5uoEyr1AjuIf75yg9K6hKXzx/iWC6ndOLrBEeLLTA3jQvFThLm
   nUBoqtgAU4eCKBk2nzXXo+8QU2sdiGubIMfZ33YzsQCLMY8+1jI3oRPPP
   6K0SYcg/Jv7gNuf6jPU4h/0HlkabJfo+9u8MXHJFvTfepiQpMlMRfFuYv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332484963"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="332484963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 06:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="646789551"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="646789551"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2023 06:51:27 -0800
Received: from [10.251.7.65] (kliang2-mobl1.ccr.corp.intel.com [10.251.7.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A06C9580BE4;
        Tue, 14 Feb 2023 06:51:26 -0800 (PST)
Message-ID: <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
Date:   Tue, 14 Feb 2023 09:51:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-13 5:22 p.m., John Stultz wrote:
> On Mon, Feb 13, 2023 at 1:40 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-02-13 2:37 p.m., John Stultz wrote:
>>> On Mon, Feb 13, 2023 at 11:08 AM <kan.liang@linux.intel.com> wrote:
>>>>
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The monotonic raw clock is not affected by NTP/PTP correction. The
>>>> calculation of the monotonic raw clock can be done in the
>>>> post-processing, which can reduce the kernel overhead.
>>>>
>>>> Add hw_time in the struct perf_event_attr to tell the kernel dump the
>>>> raw HW time to user space. The perf tool will calculate the HW time
>>>> in post-processing.
>>>> Currently, only supports the monotonic raw conversion.
>>>> Only dump the raw HW time with PERF_RECORD_SAMPLE, because the accurate
>>>> HW time can only be provided in a sample by HW. For other type of
>>>> records, the user requested clock should be returned as usual. Nothing
>>>> is changed.
>>>>
>>>> Add perf_event_mmap_page::cap_user_time_mono_raw ABI to dump the
>>>> conversion information. The cap_user_time_mono_raw also indicates
>>>> whether the monotonic raw conversion information is available.
>>>> If yes, the clock monotonic raw can be calculated as
>>>> mono_raw = base + ((cyc - last) * mult + nsec) >> shift
>>>
>>> Again, I appreciate you reworking and resending this series out, I
>>> know it took some effort.
>>>
>>> But oof, I'd really like to make sure we're not exporting timekeeping
>>> internals to userland.
>>>
>>> I think Thomas' suggestion of doing the timestamp conversion in
>>> post-processing was more about interpolating collected system times
>>> with the counter (tsc) values captured.
>>>
>>
>> Thomas, could you please clarify your suggestion regarding "the relevant
>> conversion information" provided by the kernel?
>> https://lore.kernel.org/lkml/87ilgsgl5f.ffs@tglx/
>>
>> Is it only the interpolation information or the entire conversion
>> information (Mult, shift etc.)?
>>
>> If it's only the interpolation information, the user space will be lack
>> of information to handle all the cases. If I understand John's comments
>> correctly, it could also bring some interpolation error which can only
>> be addressed by the mult/shift conversion.
> 


Thanks for the details John.

> "Only" is maybe too strong a word. I think having the driver use
> kernel timekeeping accessors to CLOCK_MONONOTONIC_RAW time with
> counter values will minimize the error.
>

The key motivation of using the TSC in the PEBS record is to get an
accurate timestamp of each record. We definitely want the conversion has
minimized error.


> But again, it's not yet established that any interpolation error using
> existing interfaces is great enough to be problematic here.
> 
> The interpoloation is pretty easy to do:
> 
> do {
>     start= readtsc();
>     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
>     end = readtsc();
>     delta = end-start;
> } while (delta  > THRESHOLD)   // make sure the reads were not preempted
> mid = start + (delta +(delta/2))/2; //round-closest
>

How to choose the THRESHOLD? It seems the THRESHOLD value also impacts
the accuracy.


> and be able to get you a fairly close matching of TSC to
> CLOCK_MONOTONIC_RAW value.
> 
> Once you have that mapping you can take a few samples and establish
> the linear function.
> 
> But that will have some error, so quantifying that error helps
> establish why being able to get an atomic mapping of TSC ->
> CLOCK_MONOTONIC_RAW would help.
> 
> So I really don't think we need to expose the kernel internal values
> to userland, but I'm willing to guess the atomic mapping (which the
> driver will have access to, not userland) may be helpful for the fine
> granularity you want in the trace.
> 

If I understand correctly, the idea is to let the user space tool run
the above interpoloation algorithm several times to 'guess' the atomic
mapping. Using the mapping information to covert the TSC from the PEBS
record. Is my understanding correct?

If so, to be honest, I doubt we can get the accuracy we want.

Thanks,
Kan
