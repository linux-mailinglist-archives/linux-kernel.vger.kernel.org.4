Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83991650952
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiLSJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:28:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FA65EB;
        Mon, 19 Dec 2022 01:28:07 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbDqh4KHVzmWZV;
        Mon, 19 Dec 2022 17:26:56 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 17:28:01 +0800
Subject: Re: [PATCH] perf tool: Fix output unexpected messages in quiet mode
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <kim.phillips@amd.com>,
        <german.gomez@arm.com>, <ravi.bangoria@amd.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221219024911.62741-1-yangjihong1@huawei.com>
 <194c676b-3a73-7f34-1f29-a157b5e4731f@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <7aecae79-5b6d-09ea-dfd5-4d4810875f3d@huawei.com>
Date:   Mon, 19 Dec 2022 17:28:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <194c676b-3a73-7f34-1f29-a157b5e4731f@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/12/19 14:59, Adrian Hunter wrote:
> On 19/12/22 04:49, Yang Jihong wrote:
>> When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
> 
> Seems like redirect_to_stderr has similar issue?
The redirect_to_stderr is used only in the veprintf function:

   int veprintf(int level, int var, const char *fmt, va_list args)
   {
           int ret = 0;

           if (var >= level) {
                   if (use_browser >= 1 && redirect_to_stderr <= 0) {
                           ui_helpline__vshow(fmt, args);
                   } else {
                           ret = fprintf_time(debug_file);
                           ret += vfprintf(debug_file, fmt, args);
                   }
           }

           return ret;
   }

If use quiet mode, verbose sets to -1. (also assigned in the 
perf_quiet_option function)
Because "var >= level" is false, veprintf function returns directly, 
which avoids this problem.

However, there are cases where:
   # perf --debug stderr=-1 report -vvv 2>/tmp/debug

If stderr is -1, should we redirect pr_debug in this case?

Because I'm not sure if this is a problem,
if redirect_to_stderr needs to be fixed as well,
let me know and I'll submit a patch to fix it.

> 
>> and display_attr incorrectly determines the value of debug_peo_args.
>> As a result, unexpected information is displayed.
>>
>> Before:
>>    # perf record --quiet -- ls > /dev/null
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      size                             128
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|PERIOD
>>      read_format                      ID|LOST
>>      disabled                         1
>>      inherit                          1
>>      mmap                             1
>>      comm                             1
>>      freq                             1
>>      enable_on_exec                   1
>>      task                             1
>>      precise_ip                       3
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      mmap2                            1
>>      comm_exec                        1
>>      ksymbol                          1
>>      bpf_event                        1
>>    ------------------------------------------------------------
>>    ...
>>
>> After:
>>    # perf record --quiet -- ls > /dev/null
>>    #
>>
>> Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
Thanks for reviewed-by.

Thanks,
Yang
