Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC626B1140
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjCHSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCHSor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:44:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD1E8B041
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678301086; x=1709837086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Ot7UuhTWj62y8Sg6scKa94wEO8HoMcFRcNWKJd2noI=;
  b=UM9kV/An1sffQkw/pdjStUMyR95tx4pqdYtLpNAWS6e+1Ok7R7qLQw2j
   93xyqr9wRA9iHIIJmKT61ib2+pipc8/z29yhf+3edPMr1IpPvyi7wZKNR
   09pWQWr67UfB7YOoGgsPO4IlzQvbbSTRCJFItYq8wHRWjbPAcm9KwsBPT
   48RKrM9j5t5kSm/JqBosmrsQD3IsD0j9pi2sECwB93W85ZgrTZFtE599X
   ZtPPMkvynwtfwLsnwdqu0OOoYTKmRJQqkhsRJ+fSsgVDej/rHpJw7PwWx
   DxQIfnpbY401HgPvDXSdQgpLFF/2IwtPQ3hM+JHFYiOzRjV3S9ZDSMOgw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316640109"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="316640109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="1006432009"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="1006432009"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2023 10:44:45 -0800
Received: from [10.212.213.11] (kliang2-mobl1.ccr.corp.intel.com [10.212.213.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5B61E580377;
        Wed,  8 Mar 2023 10:44:44 -0800 (PST)
Message-ID: <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com>
Date:   Wed, 8 Mar 2023 13:44:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
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
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2023-02-17 6:11 p.m., John Stultz wrote:
> On Tue, Feb 14, 2023 at 12:38 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-02-14 3:11 p.m., John Stultz wrote:
>>> On Tue, Feb 14, 2023 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>> On 2023-02-14 9:51 a.m., Liang, Kan wrote:
>>>>> If I understand correctly, the idea is to let the user space tool run
>>>>> the above interpoloation algorithm several times to 'guess' the atomic
>>>>> mapping. Using the mapping information to covert the TSC from the PEBS
>>>>> record. Is my understanding correct?
>>>>>
>>>>> If so, to be honest, I doubt we can get the accuracy we want.
>>>>>
>>>>
>>>> I implemented a simple test to evaluate the error.
>>>
>>> Very cool!
>>>
>>>> I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algorithm
>>>> at the start and end of perf cmd.
>>>>         MONO_RAW        TSC
>>>> start   89553516545645  223619715214239
>>>> end     89562251233830  223641517000376
>>>>
>>>> Here is what I get via mult/shift conversion from this patch.
>>>>         MONO_RAW        TSC
>>>> PEBS    89555942691466  223625770878571
>>>>
>>>> Then I use the time information from start and end to create a linear
>>>> function and 'guess' the MONO_RAW of PEBS from the TSC. I get
>>>> 89555942692721.
>>>> There is a 1255 ns difference.
>>>> I tried several different PEBS records. The error is ~1000ns.
>>>> I think it should be an observable error.
>>>
>>> Interesting. That's a good bit higher than I'd expect as I'd expect a
>>> clock_gettime() call to take ~ double digit nanoseconds range on
>>> average, so the error should be within that.
>>>
>>> Can you share your logic?
>>>
>>
>> I run the algorithm right before and after the perf command as below.
>> (The source code of time is attached.)
>>
>> $./time
>> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
>> $./time
>>
>> The time will dump both MONO_RAW and TSC. That's where "start" and "end"
>> from.
>> The perf command print out both TSC and converted MONO_RAW (using the
>> mul/shift from this patch series). That's where "PEBS" value from.
>>
>> Than I use the below formula to calculate the guessed MONO_RAW of PEBS TSC.
>> Guessed_MONO_RAW = (PEBS_TSC - start_TSC) / (end_TSC - start_TSC) *
>> (end_MONO_RAW - start_MONO_RAW) + start_MONO_RAW.
>>
>> The guessed_MONO_RAW is 89555942692721.
>> The PEBS_MONO_RAW is 89555942691466.
>> The difference is 1255.
>>
>> Is the calculation correct?
> 
> Thanks for sharing it. The equation you have there looks ok at a high
> level for the values you captured (there's small tweaks like doing the
> mult before the div to make sure you don't hit integer precision
> issues, but I didn't see that with your results).
> 
> I've got a todo to try to see how the calculation changes if we do
> provide atomic TSC/RAW stamps, here but I got a little busy with other
> work and haven't gotten to it.
> So my apologies, but I'll try to get back to this soon.
> 

Have you got a chance to try the idea?

I just want to check whether the userspace interpolation approach works.
Should I prepare V3 and go back to the kernel solution?


Thanks,
Kan
