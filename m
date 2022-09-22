Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204DE5E5B94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIVGoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIVGoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:44:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B835EB6D4F;
        Wed, 21 Sep 2022 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663829059; x=1695365059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YI6R/Fbd3ccV4vt0qaxDC0nMu1Hi71Zek1sN+E5/XWg=;
  b=Jpr3y+b/J/7JDm9gvWnD+3omSAkWFE18a+wM3pO+D0H4Vl7UmWYfm6K8
   sRkCk7dJ3uxt5N8v4dtyS3pf5Di7JJTu9zHE4j2PUdK8iNOYWY7NbXBnn
   L0MbgfJAFT5x/YLQ2paQwkibKSRuwnM3WNZw5ABOPkKu3E7xWO9NPTzgb
   M576bFjeXT5gVNrx+e5ZllPkB9B/59CVnPHdSnJjGBafWXNkisXNQh1EY
   68h8jV0yA6aGxPGfgxAemKaG0DqWDDuzI8hC17U5bVmlP6ToqAFsaFIvN
   imtOz0N1DU0kRgJcI8QNX4ggA03i/kB76r0ZUqjjIcbM3wehr4xwK51d4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297815098"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297815098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 23:44:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619674962"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.231]) ([10.238.4.231])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 23:44:11 -0700
Message-ID: <f43d235b-2d74-c95b-c0c1-613239032c2d@linux.intel.com>
Date:   Thu, 22 Sep 2022 14:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] perf print-events: Fix "perf list" can not display
 the PMU prefix for some hybrid cache events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
References: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUecPUJ-Z5WwbjVgA6b6r3-MmmfpjE+iw_pAK_K+rhxMA@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAP-5=fUecPUJ-Z5WwbjVgA6b6r3-MmmfpjE+iw_pAK_K+rhxMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/2022 11:12 AM, Ian Rogers wrote:
> On Wed, Sep 21, 2022 at 6:47 PM <zhengjun.xing@linux.intel.com> wrote:
>>
>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>
>> Some hybrid hardware cache events are only available on one CPU PMU. For
>> example, 'L1-dcache-load-misses' is only available on cpu_core. We have
>> supported in the perf list clearly reporting this info, the function works
>> fine before but recently the argument "config" in API is_event_supported()
>> is changed from "u64" to "unsigned int" which caused a regression, the
>> "perf list" then can not display the PMU prefix for some hybrid cache
>> events. For the hybrid systems, the PMU type ID is stored at config[63:32],
>> define config to "unsigned int" will miss the PMU type ID information, then
>> the regression happened, the config should be defined as "u64".
>>
>> Before:
>>   # ./perf list |grep "Hardware cache event"
>>    L1-dcache-load-misses                              [Hardware cache event]
>>    L1-dcache-loads                                    [Hardware cache event]
>>    L1-dcache-stores                                   [Hardware cache event]
>>    L1-icache-load-misses                              [Hardware cache event]
>>    L1-icache-loads                                    [Hardware cache event]
>>    LLC-load-misses                                    [Hardware cache event]
>>    LLC-loads                                          [Hardware cache event]
>>    LLC-store-misses                                   [Hardware cache event]
>>    LLC-stores                                         [Hardware cache event]
>>    branch-load-misses                                 [Hardware cache event]
>>    branch-loads                                       [Hardware cache event]
>>    dTLB-load-misses                                   [Hardware cache event]
>>    dTLB-loads                                         [Hardware cache event]
>>    dTLB-store-misses                                  [Hardware cache event]
>>    dTLB-stores                                        [Hardware cache event]
>>    iTLB-load-misses                                   [Hardware cache event]
>>    node-load-misses                                   [Hardware cache event]
>>    node-loads                                         [Hardware cache event]
>>
>> After:
>>   # ./perf list |grep "Hardware cache event"
>>    L1-dcache-loads                                    [Hardware cache event]
>>    L1-dcache-stores                                   [Hardware cache event]
>>    L1-icache-load-misses                              [Hardware cache event]
>>    LLC-load-misses                                    [Hardware cache event]
>>    LLC-loads                                          [Hardware cache event]
>>    LLC-store-misses                                   [Hardware cache event]
>>    LLC-stores                                         [Hardware cache event]
>>    branch-load-misses                                 [Hardware cache event]
>>    branch-loads                                       [Hardware cache event]
>>    cpu_atom/L1-icache-loads/                          [Hardware cache event]
>>    cpu_core/L1-dcache-load-misses/                    [Hardware cache event]
>>    cpu_core/node-load-misses/                         [Hardware cache event]
>>    cpu_core/node-loads/                               [Hardware cache event]
>>    dTLB-load-misses                                   [Hardware cache event]
>>    dTLB-loads                                         [Hardware cache event]
>>    dTLB-store-misses                                  [Hardware cache event]
>>    dTLB-stores                                        [Hardware cache event]
>>    iTLB-load-misses                                   [Hardware cache event]
>>
>> Fixes: 9b7c7728f4e4 ("perf parse-events: Break out tracepoint and printing")
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Sorry for this breakage, I suspect that a long review on the
> refactoring CL meant that I missed the intervening fix. Can we add a
> test on this? It would need to be hybrid specific and skip otherwise.

Thanks. I will add a test case for hybrid-specific later.
> 
> Thanks,
> Ian
> 
>> ---
>>   tools/perf/util/print-events.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
>> index ba1ab5134685..04050d4f6db8 100644
>> --- a/tools/perf/util/print-events.c
>> +++ b/tools/perf/util/print-events.c
>> @@ -239,7 +239,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
>>          strlist__delete(sdtlist);
>>   }
>>
>> -static bool is_event_supported(u8 type, unsigned int config)
>> +static bool is_event_supported(u8 type, u64 config)
>>   {
>>          bool ret = true;
>>          int open_return;
>> --
>> 2.25.1
>>

-- 
Zhengjun Xing
