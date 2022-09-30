Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFA5F0D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiI3ORn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiI3ORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:17:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8681A1083;
        Fri, 30 Sep 2022 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664547457; x=1696083457;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=PY8jZf3xeexXBiHYf11NTTh0RwhmCZqxr9AMDIByppA=;
  b=ilV8PVKZHjHAXAURyJEe2EnjSEt7SnV0IWLXcwWHbVaLeZqmYwkGv8R9
   IScs2xyP0OsVgIJLtA0c9YmTx0ghvfKmGE2sMgnqUylnfk3aEzI/UQQCM
   Lge0YvzcG3mCtf8BIv9bvlCeBKn+4PqqpnP+O3g48jvyQVbb/6Yqidn8h
   yiniSvZkESAmrcfCqw66dgOM7eaE9zt5AOXMyNjqH0i1bUOa7Uk5OJEw4
   VE2C2XMy8EKTEDW5SvbGyuRbAei60iC0Ocbjq1m7fpr8wMWI+Cj41DGks
   ZVGvysWxe61zr4CdzCwf1GcoHFULVrfjnuo0AxYsI0a0/g3tB1rS/7XiN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="300917244"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="300917244"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="622781924"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="622781924"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 30 Sep 2022 07:17:36 -0700
Received: from [10.252.215.94] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BA8EF580583;
        Fri, 30 Sep 2022 07:17:33 -0700 (PDT)
Message-ID: <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
Date:   Fri, 30 Sep 2022 10:17:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
In-Reply-To: <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-30 8:50 a.m., Ravi Bangoria wrote:
> On 30-Sep-22 4:18 PM, kajoljain wrote:
>>
>>
>> On 9/28/22 15:27, Ravi Bangoria wrote:
>>> PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
>>> extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
>>> accesses but it can not distinguish between local and remote IO.
>>> Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
>>> PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>> ---
>>>  include/uapi/linux/perf_event.h | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>> index e639c74cf5fb..4ae3c249f675 100644
>>> --- a/include/uapi/linux/perf_event.h
>>> +++ b/include/uapi/linux/perf_event.h
>>> @@ -1336,7 +1336,9 @@ union perf_mem_data_src {
>>>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>>>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>>>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>>> -/* 5-0xa available */
>>> +/* 5-0x8 available */
>>> +#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
>>
>> Hi Ravi,
>>     Here we are adding entry explicitly for accesses to Extension memory
>> like CXL. In future if we want to extend it for cache or other accesses
>> , we again need to add new entries.
>> Can we rather add single entry say PERF_MEM_LVLNUM_EXTN and further can
>> use reserved bits to specify memory/cache?
> 
> Is everybody okay with this:
> 
> #define PERF_MEM_LVLNUM_EXTN	0x09 /* CXL */

I think a generic name, PERF_MEM_LVLNUM_EXTN, only make sense, when it
wants to include all the types of the Extension memory, e.g., CXL, PMEM,
HBM, etc. Then we can set this bit and the corresponding CXL bits to
understand the real source. Is it the case here?

But if it's only for the CXL, I think it's better to use a dedicated
name, PERF_MEM_LVLNUM_CXL. (as we did for PMEM, PERF_MEM_LVLNUM_PMEM).
If so, I don't think we need the PERF_MEM_EXTN_CXL_ANY.

Thanks,
Kan

> 
> And a 3 bit variable to define what type of cxl that would be:
> 
> #define PERF_MEM_EXTN_CXL_ANY	0x1
> #define PERF_MEM_EXTN_CXL_MEM	0x2
> #define PERF_MEM_EXTN_CXL_CACHE	0x2
> #define PERF_MEM_EXTN_CXL_IO	0x3
> 
> Peter, Shall I send this as addon patch series or are you okay reverting
> current patches?
> 
> Thanks,
> Ravi
