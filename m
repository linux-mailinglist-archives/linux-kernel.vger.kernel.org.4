Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9C650C81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLSNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:14:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A17670;
        Mon, 19 Dec 2022 05:14:12 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbKrc1gn0zmWjX;
        Mon, 19 Dec 2022 21:13:04 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 21:14:09 +0800
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
 <7aecae79-5b6d-09ea-dfd5-4d4810875f3d@huawei.com>
 <d2189ccc-26aa-250a-ad43-59d53ef01d5e@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <0e06416c-fac3-1149-2660-9a1981e3460d@huawei.com>
Date:   Mon, 19 Dec 2022 21:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d2189ccc-26aa-250a-ad43-59d53ef01d5e@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/12/19 18:28, Adrian Hunter wrote:
> On 19/12/22 11:28, Yang Jihong wrote:
>> Hello,
>>
>> On 2022/12/19 14:59, Adrian Hunter wrote:
>>> On 19/12/22 04:49, Yang Jihong wrote:
>>>> When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
>>>
>>> Seems like redirect_to_stderr has similar issue?
>> The redirect_to_stderr is used only in the veprintf function:
>>
>>    int veprintf(int level, int var, const char *fmt, va_list args)
>>    {
>>            int ret = 0;
>>
>>            if (var >= level) {
>>                    if (use_browser >= 1 && redirect_to_stderr <= 0) {
>>                            ui_helpline__vshow(fmt, args);
>>                    } else {
>>                            ret = fprintf_time(debug_file);
>>                            ret += vfprintf(debug_file, fmt, args);
>>                    }
>>            }
>>
>>            return ret;
>>    }
>>
>> If use quiet mode, verbose sets to -1. (also assigned in the perf_quiet_option function)
>> Because "var >= level" is false, veprintf function returns directly, which avoids this problem.
>>
>> However, there are cases where:
>>    # perf --debug stderr=-1 report -vvv 2>/tmp/debug
>>
>> If stderr is -1, should we redirect pr_debug in this case?
> 
> tools/perf/Documentation/perf.txt says debug variables are in value
> range (0, 10), so -1 is invalid anyway.
> 
Okay, I see.
>>
>> Because I'm not sure if this is a problem,
>> if redirect_to_stderr needs to be fixed as well,
>> let me know and I'll submit a patch to fix it.
> 
> perf_quiet_option() sets redirect_to_stderr = -1 with the intention
> that it turns it off, but it doesn't, although it gets turned of by
> verbose = -1. Perhaps set redirect_to_stderr = 0 in perf_quiet_option() ?
> 
I think it's better to fix redirect_to_stderr and debug_peo_args in the 
same way (because they're similar):

Solution A:
   diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
   index 65e6c22f38e4..908b26e579e5 100644
   --- a/tools/perf/util/debug.c
   +++ b/tools/perf/util/debug.c
   @@ -68,7 +68,7 @@ int veprintf(int level, int var, const char *fmt, 
va_list args)
           int ret = 0;

           if (var >= level) {
   -               if (use_browser >= 1 && !redirect_to_stderr) {
   +               if (use_browser >= 1 && redirect_to_stderr <= 0) {
                           ui_helpline__vshow(fmt, args);
                   } else {
                           ret = fprintf_time(debug_file);
   diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
   index f99468a7f681..f6ab84c93ec0 100644
   --- a/tools/perf/util/debug.h
   +++ b/tools/perf/util/debug.h
   @@ -41,7 +41,7 @@ extern int debug_data_convert;

    /* Special macro to print perf_event_open arguments/return value. */
    #define pr_debug2_peo(fmt, ...) {                              \
   -       if (debug_peo_args)                                             \
   +       if (debug_peo_args > 0)                                         \
                   pr_debugN(0, pr_fmt(fmt), ##__VA_ARGS__);       \
           else                                                    \
                   pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__);       \
   diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
   index 999dd1700502..45cf144c5d5d 100644
   --- a/tools/perf/util/evsel.c
   +++ b/tools/perf/util/evsel.c
   @@ -1775,7 +1775,7 @@ static int __open_attr__fprintf(FILE *fp, const 
char *name, const char *val,

    static void display_attr(struct perf_event_attr *attr)
    {
   -       if (verbose >= 2 || debug_peo_args) {
   +       if (verbose >= 2 || debug_peo_args > 0) {
                   fprintf(stderr, "%.60s\n", graph_dotted_line);
                   fprintf(stderr, "perf_event_attr:\n");
                   perf_event_attr__fprintf(stderr, attr, 
__open_attr__fprintf, NULL);

or
Solution B:

   diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
   index 908b26e579e5..e3acc213edd1 100644
   --- a/tools/perf/util/debug.c
   +++ b/tools/perf/util/debug.c
   @@ -241,6 +241,9 @@ int perf_quiet_option(void)
                   opt++;
           }

   +       redirect_to_stderr = 0;
   +       debug_peo_args = 0;
   +

> I see we have another problem as well: places that check "if (verbose)"
> instead of "if (verbose > 0)"
Yes,  places that "if (verbose)" also have problems, I'll submit a patch 
to change them to "if (verbose > 0)"

In addition, I found another problem, perf lock/stat/probe does not call 
the perf_quiet_option function when quiet is true.

Thanks,
Yang
