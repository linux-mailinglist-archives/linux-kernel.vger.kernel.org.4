Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E268C322
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjBFQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:25:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3931C5BA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675700714; x=1707236714;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CkoXo9WxWrDBnTHUQtoyijp5lVZCbr3JBRJzGSN4X1U=;
  b=bil/rjeqptHiHLOAcoKAYsVMOrnm2VXoPbmnvpYPQ0V4ZI4KVXNoRbQJ
   HooIvijR7nOC063y+N9FQMfwtXW8ZDATCNQl8//mbwsGy+QAyBvxKZ9c5
   Dg2ksUUj268pYNPObRmJBV/YFeVc6dj9Aohc4ovlvL7QXtxTK58jUMOiF
   DCRIZ9LBsUZAn4mhmt/JnV7qGdha/JnZV4HkZz29wLWwZGcIOWnoirYlR
   AhNlDJIrISoqaJCj+0jNPytdD+tW50CpZ7NK2I/vIyDE2u7NJ/LGXV7Z0
   j0rY3SJN21CBUbvpKZtaLdRzVTtZx6YCXetLMI99v9FV2NC7IFJEazWqz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356605181"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356605181"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775210008"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775210008"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2023 08:25:05 -0800
Received: from [10.212.205.76] (kliang2-mobl1.ccr.corp.intel.com [10.212.205.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D1116580C75;
        Mon,  6 Feb 2023 08:25:04 -0800 (PST)
Message-ID: <32d7df47-6d7e-6b7c-f444-9f31e6425ff2@linux.intel.com>
Date:   Mon, 6 Feb 2023 11:25:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3 3/3] perf test: Support the retire_lat check
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
 <20230202192209.1795329-3-kan.liang@linux.intel.com>
 <Y+EWWLaBj1OPrkLo@kernel.org>
 <8e493d2f-827a-03d9-610b-6246502bf92a@linux.intel.com>
 <Y+EdposucD4mWp6S@kernel.org> <Y+Ed7823ZSXevwA6@kernel.org>
 <30bc05e4-a479-ad53-22b1-4afca4fa7ec2@linux.intel.com>
In-Reply-To: <30bc05e4-a479-ad53-22b1-4afca4fa7ec2@linux.intel.com>
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



On 2023-02-06 10:49 a.m., Liang, Kan wrote:
> 
> 
> On 2023-02-06 10:34 a.m., Arnaldo Carvalho de Melo wrote:
>> Em Mon, Feb 06, 2023 at 12:32:54PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Mon, Feb 06, 2023 at 10:17:46AM -0500, Liang, Kan escreveu:
>>>>
>>>>
>>>> On 2023-02-06 10:01 a.m., Arnaldo Carvalho de Melo wrote:
>>>>> Em Thu, Feb 02, 2023 at 11:22:09AM -0800, kan.liang@linux.intel.com escreveu:
>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>
>>>>>> Add test for the new field for Retire Latency in the X86 specific test.
>>>>>
>>>>> Is this passing 'perf test' for you?
>>>>
>>>> Ah, it should be the original V2 missed the below change.
>>>
>>> Can you please send this as a separate patch as I already merged
>>> torvalds/master and added more csets on top, so to just fix it and
>>> force push now would be bad.
>>>
>>> Please use what is in my perf/core branch and add a Fixes for that v2
>>> patch.
>>
>> BTW, the 3rd patch with the test is already on the tmp.perf/core branch,
>> that will move to perf/core after the next round of container build
>> tests.
>>
> 
> Thanks. I will sent a V4 to fix the 'perf test' issue.
> 

The V4 is here. It includes a fix for the 'perf test' issue and a fix
for the perf script document.
https://lore.kernel.org/lkml/20230206162100.3329395-1-kan.liang@linux.intel.com/

Sorry again for the inconvenience.

Thanks,
Kan

> Thanks,
> Kan
>> - Arnaldo
>>  
>>> Thanks,
>>>
>>> - Arnaldo
>>>  
>>>> @@ -100,5 +101,25 @@ void arch_perf_synthesize_sample_weight(const
>>>> struct perf_sample *data,
>>>>  	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>>>>  		*array &= 0xffffffff;
>>>>  		*array |= ((u64)data->ins_lat << 32);
>>>> +		*array |= ((u64)data->retire_lat << 48);
>>>>  	}
>>>>  }
>>>>
>>>> Could you please remove the V2 and re-apply the V3?
>>>  
>>>> $ sudo ./perf test -v "x86 sample parsing"
>>>>  74: x86 Sample parsing                                              :
>>>> --- start ---
>>>> test child forked, pid 3316797
>>>> test child finished with 0
>>>> ---- end ----
>>>> x86 Sample parsing: Ok
>>>>
>>>>
>>>> Thanks,
>>>> Kan
>>>>
>>>>>
>>>>> [root@quaco ~]# perf test -v "x86 sample parsing"
>>>>>  74: x86 Sample parsing                                              :
>>>>> --- start ---
>>>>> test child forked, pid 72526
>>>>> Samples differ at 'retire_lat'
>>>>> parsing failed for sample_type 0x1000000
>>>>> test child finished with -1
>>>>> ---- end ----
>>>>> x86 Sample parsing: FAILED!
>>>>> [root@quaco ~]#
>>>>>
>>>>> - Arnaldo
>>>>>  
>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>> ---
>>>>>>
>>>>>> New patch since V2
>>>>>>
>>>>>>  tools/perf/arch/x86/tests/sample-parsing.c | 5 ++++-
>>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
>>>>>> index 690c7c07e90d..a061e8619267 100644
>>>>>> --- a/tools/perf/arch/x86/tests/sample-parsing.c
>>>>>> +++ b/tools/perf/arch/x86/tests/sample-parsing.c
>>>>>> @@ -27,8 +27,10 @@ static bool samples_same(const struct perf_sample *s1,
>>>>>>  			 const struct perf_sample *s2,
>>>>>>  			 u64 type)
>>>>>>  {
>>>>>> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
>>>>>> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>>>>>>  		COMP(ins_lat);
>>>>>> +		COMP(retire_lat);
>>>>>> +	}
>>>>>>  
>>>>>>  	return true;
>>>>>>  }
>>>>>> @@ -48,6 +50,7 @@ static int do_test(u64 sample_type)
>>>>>>  	struct perf_sample sample = {
>>>>>>  		.weight		= 101,
>>>>>>  		.ins_lat        = 102,
>>>>>> +		.retire_lat     = 103,
>>>>>>  	};
>>>>>>  	struct perf_sample sample_out;
>>>>>>  	size_t i, sz, bufsz;
>>>>>> -- 
>>>>>> 2.35.1
>>>>>>
>>>>>
>>>
>>> -- 
>>>
>>> - Arnaldo
>>
