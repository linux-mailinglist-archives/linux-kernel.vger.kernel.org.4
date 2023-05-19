Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5148709740
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjESMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:33:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28213C4;
        Fri, 19 May 2023 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684499584; x=1716035584;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SkVUZoNFymk8p02t7x88e7sBCdlRXTIQsYoP3tMDF2w=;
  b=GVwbzf4GR3iiWORP9NvVEt0ApmSsoAckayf3gDK5rpg+G7LZCjPLbNlm
   r/wDPZZ7pB4ox3npjm5EPA6AQL0y5esOXmlbZ4sxmbiy2AC+60VvK8sh2
   S31nWhqXsM8fb1xdh+d0OBz3huy9e1y/Mg5/sZRMLeGL8Y9+ON1tcoTmm
   0nqckF6qmJf1NCHVMPVd+wf4u3kJQ8caoiHD+2GviT0MEYIoMFPcD8ID6
   +mKpL/F5iy8d7rdQqrjp1MmCKWAade6uBCoSUGvve84ypl8lF4HpYhduT
   pR0dgbz5ra7Y3eClLTjUCTHAdzu1ptz7O2OrkjnoqETFQx9pCev+eI87w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438710540"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="438710540"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 05:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735492273"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="735492273"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2023 05:33:03 -0700
Received: from [10.212.162.68] (kliang2-mobl1.ccr.corp.intel.com [10.212.162.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0423F580ABD;
        Fri, 19 May 2023 05:33:02 -0700 (PDT)
Message-ID: <7212f2d5-afb0-05b4-b202-156c18db8ca0@linux.intel.com>
Date:   Fri, 19 May 2023 08:33:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg
 when using guest PEBS
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20230517133808.67885-1-likexu@tencent.com>
 <3dca8ccf-081a-0765-b5e3-9584f9128137@linux.intel.com>
 <70c86b5e-a8c8-fb6a-d4cf-0580a527ee5a@gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <70c86b5e-a8c8-fb6a-d4cf-0580a527ee5a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-19 3:40 a.m., Like Xu wrote:
> On 19/5/2023 12:31 am, Liang, Kan wrote:
>>
>>
>> On 2023-05-17 9:38 a.m., Like Xu wrote:
>>> From: Like Xu <likexu@tencent.com>
>>>
>>> After commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when
>>> changing
>>> PEBS_DATA_CFG"), the cpuc->pebs_data_cfg may save some bits that are not
>>> supported by real hardware, such as PEBS_UPDATE_DS_SW. This would cause
>>> the VMX hardware MSR switching mechanism to save/restore invalid values
>>> for PEBS_DATA_CFG MSR, thus crashing the host when PEBS is used for
>>> guest.
>>
>> I believe we clear the SW bit when it takes effect.
>>
>> +    if (cpuc->pebs_data_cfg & PEBS_UPDATE_DS_SW) {
>> +        cpuc->pebs_data_cfg = pebs_data_cfg;
>> +        pebs_update_threshold(cpuc);
>> +    }
>>
>> I think the SW bit can only be seen in a shot period between add() and
>> enable(). Is it caused by a VM enter which just happens on the period?
> 
> What happens here is that when *intel_pmu_pebs_del()* is called,

Ah, yes. I think it's useless to set the bit for the removal. We may
need a cleanup patch to improve it.

Thanks,
Kan

> the pebs_update_state() also triggers:
>     cpuc->pebs_data_cfg |= PEBS_UPDATE_DS_SW;
> and the new value will then be used for the next kvm_entry.
> 
> The KVM created pebs perf_event is not added/enabled at this point
> and the cpuc->pebs_data_cfg strangely holds a non-zero value.
> 
> Perhaps there is more room for perf fixes here, but for guest pebs usages,
> using active_pebs_data_cfg in intel_guest_get_msrs() is part of what is
> needed.
> 
>>
>>> Fix it by using the active host value from cpuc->active_pebs_data_cfg.
>>
>> I don't see a problem of using active_pebs_data_cfg, since it reflects
>> the current MSR setting. Just curious about how it's triggered.
>>
>>>
>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Like Xu <likexu@tencent.com>
>>> ---
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> Thanks,
>> Kan
>>
>>>   arch/x86/events/intel/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 070cc4ef2672..89b9c1cebb61 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr
>>> *intel_guest_get_msrs(int *nr, void *data)
>>>       if (x86_pmu.intel_cap.pebs_baseline) {
>>>           arr[(*nr)++] = (struct perf_guest_switch_msr){
>>>               .msr = MSR_PEBS_DATA_CFG,
>>> -            .host = cpuc->pebs_data_cfg,
>>> +            .host = cpuc->active_pebs_data_cfg,
>>>               .guest = kvm_pmu->pebs_data_cfg,
>>>           };
>>>       }
