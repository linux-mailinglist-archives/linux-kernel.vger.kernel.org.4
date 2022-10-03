Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437DE5F3104
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJCNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJCNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:16:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0381520B5;
        Mon,  3 Oct 2022 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664802957; x=1696338957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tM5UCFVGRksNNDE27Ze8+o8RfXheJP0Mj+I4W40y1Ac=;
  b=OsSD8C4od1axfyeZw2fIFc2PSWvmJ/56Lqi230EVnWursk8qyTw4igKq
   KXl6jyc+VVjnNGpdazjOaIKXhzt8O36MMdGA74UV9XYJoanIx+xASwTLC
   n7jeHZpm5V3dQwDcSMy361Cj7kmqCRwdES2uXfft3mT8MeNF5Elisoptn
   tkE6StmXuLWmX7ataEe0dR0r8iZlpI/QgSMHgVnPmoADwu4kfcMZEqmIs
   akfo8ZXuJJXce8Cx+ourotguAtK04RaxWa0M5+lC9aluFPyL2UG2bjOMD
   mvVj4gigwnuqQzhAFyVwMHNULJZu1vYUb5Nc03bh2Yf2n5BwVOUaRDbue
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366671994"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="366671994"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 06:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="574619844"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="574619844"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2022 06:15:57 -0700
Received: from [10.252.215.152] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0A7D05805EE;
        Mon,  3 Oct 2022 06:15:53 -0700 (PDT)
Message-ID: <d428b526-a592-2ea5-dad8-d6eae72eb118@linux.intel.com>
Date:   Mon, 3 Oct 2022 09:15:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        kajoljain <kjain@linux.ibm.com>, peterz@infradead.org,
        acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
 <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
 <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
 <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-10-01 2:37 a.m., Ravi Bangoria wrote:
> On 30-Sep-22 7:47 PM, Liang, Kan wrote:
>>
>>
>> On 2022-09-30 8:50 a.m., Ravi Bangoria wrote:
>>> On 30-Sep-22 4:18 PM, kajoljain wrote:
>>>>
>>>>
>>>> On 9/28/22 15:27, Ravi Bangoria wrote:
>>>>> PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
>>>>> extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
>>>>> accesses but it can not distinguish between local and remote IO.
>>>>> Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
>>>>> PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.
>>>>>
>>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>>> ---
>>>>>  include/uapi/linux/perf_event.h | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>>>> index e639c74cf5fb..4ae3c249f675 100644
>>>>> --- a/include/uapi/linux/perf_event.h
>>>>> +++ b/include/uapi/linux/perf_event.h
>>>>> @@ -1336,7 +1336,9 @@ union perf_mem_data_src {
>>>>>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>>>>>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>>>>>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>>>>> -/* 5-0xa available */
>>>>> +/* 5-0x8 available */
>>>>> +#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
>>>>
>>>> Hi Ravi,
>>>>     Here we are adding entry explicitly for accesses to Extension memory
>>>> like CXL. In future if we want to extend it for cache or other accesses
>>>> , we again need to add new entries.
>>>> Can we rather add single entry say PERF_MEM_LVLNUM_EXTN and further can
>>>> use reserved bits to specify memory/cache?
>>>
>>> Is everybody okay with this:
>>>
>>> #define PERF_MEM_LVLNUM_EXTN	0x09 /* CXL */
>>
>> I think a generic name, PERF_MEM_LVLNUM_EXTN, only make sense, when it
>> wants to include all the types of the Extension memory, e.g., CXL, PMEM,
>> HBM, etc. Then we can set this bit and the corresponding CXL bits to
>> understand the real source. Is it the case here?
>>
>> But if it's only for the CXL, I think it's better to use a dedicated
>> name, PERF_MEM_LVLNUM_CXL. (as we did for PMEM, PERF_MEM_LVLNUM_PMEM).
>> If so, I don't think we need the PERF_MEM_EXTN_CXL_ANY.
> 
> Ok. For now, I think below is good enough? Later we can introduce new
> variable to provide type of cxl device.
> 
> 
> From 5deb2055e2b5b0a61403f2d5f4e5a784b14a65e3 Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Sat, 1 Oct 2022 11:37:05 +0530
> Subject: [PATCH] perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
>  PERF_MEM_LVLNUM_CXL
> 
> PERF_MEM_LVLNUM_EXTN_MEM was introduced to cover CXL devices but it's
> bit ambiguous name and also not generic enough to cover cxl.cache and
> cxl.io devices. Rename it to PERF_MEM_LVLNUM_CXL to be more specific.

Looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c       | 2 +-
>  include/uapi/linux/perf_event.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3271735f0070..4cb710efbdd9 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -801,7 +801,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>  	/* Extension Memory */
>  	if (ibs_caps & IBS_CAPS_ZEN4 &&
>  	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
> -		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
>  		if (op_data2->rmt_node) {
>  			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>  			/* IBS doesn't provide Remote socket detail */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 85be78e0e7f6..eb1090604d53 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1337,7 +1337,7 @@ union perf_mem_data_src {
>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>  /* 5-0x8 available */
> -#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
> +#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
>  #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
>  #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
>  #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
