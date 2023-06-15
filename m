Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB74730CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbjFOBo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjFOBow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:44:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183802942;
        Wed, 14 Jun 2023 18:44:26 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QhQ3P4s2nzMpTW;
        Thu, 15 Jun 2023 09:40:33 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 09:43:38 +0800
Subject: Re: [PATCH] perf top & record: Fix segfault when default cycles event
 is not supported
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230614151625.2077-1-yangjihong1@huawei.com>
 <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <6d8d8641-d935-c920-6ef4-1766a82ec6b3@huawei.com>
Date:   Thu, 15 Jun 2023 09:43:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/15 0:18, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 8:18 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> The perf-record and perf-top call parse_event() to add a cycles event to
>> an empty evlist. For the system that does not support hardware cycles
>> event, such as QEMU, the evlist is empty due to the following code process:
>>
>>    parse_event(evlist, "cycles:P" or ""cycles:Pu")
>>      parse_events(evlist, "cycles:P")
>>        __parse_events
>>          ...
>>          ret = parse_events__scanner(str, &parse_state);
>>          // ret = 0
>>          ...
>>          ret2 = parse_events__sort_events_and_fix_groups()
>>          if (ret2 < 0)
>>            return ret;
>>          // The cycles event is not supported, here ret2 = -EINVAL,
>>          // Here return 0.
>>          ...
>>          evlist__splice_list_tail(evlist)
>>          // The code here does not execute to, so the evlist is still empty.
>>
>> A null pointer occurs when the content in the evlist is accessed later.
>>
>> Before:
>>
>>    # perf list hw
>>
>>    List of pre-defined events (to be used in -e or -M):
>>
>>    # perf record true
>>    libperf: Miscounted nr_mmaps 0 vs 1
>>    WARNING: No sample_id_all support, falling back to unordered processing
>>    perf: Segmentation fault
>>    Obtained 1 stack frames.
>>    [0xc5beff]
>>    Segmentation fault
>>
>> Solution:
>>    If cycles event is not supported, try to fall back to cpu-clock event.
>>
>> After:
>>    # perf record true
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.006 MB perf.data ]
>>    #
>>
>> Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Thanks, useful addition. The cpu-clock fall back wasn't present before
> 7b100989b4f6 so is the fixes tag correct?
> 
Before 7b100989b4f6, perf-record call evlist__add_default() to create an 
evsel and directly add it to the evlist, it does not search for the 
corresponding PMU in the sysfs. Therefore, the evlist is not empty 
before the commit 7b100989b4f6.

> Wrt segv, I'm beginning to think that we should always forcibly create
> a core PMU even if we can't find one one in sysfs, my guess is that is
> what triggers the segv.
>

Yes, that's the reason.

Thanks,
Yang.

> evlist__add_default doesn't really explain what the function is doing
> and default can have >1 meaning. Perhaps, evlist__add_cycles.
> 
> Thanks,
> Ian
> 
>> ---
>>   tools/perf/builtin-record.c |  4 +---
>>   tools/perf/builtin-top.c    |  3 +--
>>   tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>>   tools/perf/util/evlist.h    |  1 +
>>   4 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index aec18db7ff23..29ae2b84a63a 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -4161,9 +4161,7 @@ int cmd_record(int argc, const char **argv)
>>                  record.opts.tail_synthesize = true;
>>
>>          if (rec->evlist->core.nr_entries == 0) {
>> -               bool can_profile_kernel = perf_event_paranoid_check(1);
>> -
>> -               err = parse_event(rec->evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
>> +               err = evlist__add_default(rec->evlist);
>>                  if (err)
>>                          goto out;
>>          }
>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>> index c363c04e16df..798cb9252a5f 100644
>> --- a/tools/perf/builtin-top.c
>> +++ b/tools/perf/builtin-top.c
>> @@ -1665,8 +1665,7 @@ int cmd_top(int argc, const char **argv)
>>                  goto out_delete_evlist;
>>
>>          if (!top.evlist->core.nr_entries) {
>> -               bool can_profile_kernel = perf_event_paranoid_check(1);
>> -               int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
>> +               int err = evlist__add_default(top.evlist);
>>
>>                  if (err)
>>                          goto out_delete_evlist;
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 7ef43f72098e..60efa762405e 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -287,6 +287,24 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>>          return evsel;
>>   }
>>
>> +int evlist__add_default(struct evlist *evlist)
>> +{
>> +       bool can_profile_kernel;
>> +       int err;
>> +
>> +       can_profile_kernel = perf_event_paranoid_check(1);
>> +       err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
>> +       if (err)
>> +               return err;
>> +
>> +       if (!evlist->core.nr_entries) {
>> +               pr_debug("The cycles event is not supported, trying to fall back to cpu-clock event\n");
>> +               return parse_event(evlist, "cpu-clock");
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   #ifdef HAVE_LIBTRACEEVENT
>>   struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
>>   {
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 664c6bf7b3e0..47eea809ee91 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -116,6 +116,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
>>
>>   int evlist__add_dummy(struct evlist *evlist);
>>   struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
>> +int evlist__add_default(struct evlist *evlist);
>>   static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
>>   {
>>          return evlist__add_aux_dummy(evlist, true);
>> --
>> 2.30.GIT
>>
> .
> 
