Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34E0730CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbjFOBzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbjFOByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:54:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A39BA6;
        Wed, 14 Jun 2023 18:54:53 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QhQG81z38zqTx4;
        Thu, 15 Jun 2023 09:49:52 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 09:54:50 +0800
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
 <CAP-5=fVOXjjcusjv858SOGrnNgE2w2sb7zS=0sZUpdFfR1T_GA@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <668a6159-b7a8-ed25-d8fa-5584a4c04d37@huawei.com>
Date:   Thu, 15 Jun 2023 09:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVOXjjcusjv858SOGrnNgE2w2sb7zS=0sZUpdFfR1T_GA@mail.gmail.com>
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

On 2023/6/15 6:03, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 9:18 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Jun 14, 2023 at 8:18 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>
>>> The perf-record and perf-top call parse_event() to add a cycles event to
>>> an empty evlist. For the system that does not support hardware cycles
>>> event, such as QEMU, the evlist is empty due to the following code process:
>>>
>>>    parse_event(evlist, "cycles:P" or ""cycles:Pu")
>>>      parse_events(evlist, "cycles:P")
>>>        __parse_events
>>>          ...
>>>          ret = parse_events__scanner(str, &parse_state);
>>>          // ret = 0
>>>          ...
>>>          ret2 = parse_events__sort_events_and_fix_groups()
>>>          if (ret2 < 0)
>>>            return ret;
>>>          // The cycles event is not supported, here ret2 = -EINVAL,
>>>          // Here return 0.
>>>          ...
>>>          evlist__splice_list_tail(evlist)
>>>          // The code here does not execute to, so the evlist is still empty.
>>>
>>> A null pointer occurs when the content in the evlist is accessed later.
>>>
>>> Before:
>>>
>>>    # perf list hw
>>>
>>>    List of pre-defined events (to be used in -e or -M):
>>>
>>>    # perf record true
>>>    libperf: Miscounted nr_mmaps 0 vs 1
>>>    WARNING: No sample_id_all support, falling back to unordered processing
>>>    perf: Segmentation fault
>>>    Obtained 1 stack frames.
>>>    [0xc5beff]
>>>    Segmentation fault
>>>
>>> Solution:
>>>    If cycles event is not supported, try to fall back to cpu-clock event.
>>>
>>> After:
>>>    # perf record true
>>>    [ perf record: Woken up 1 times to write data ]
>>>    [ perf record: Captured and wrote 0.006 MB perf.data ]
>>>    #
>>>
>>> Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>
>> Thanks, useful addition. The cpu-clock fall back wasn't present before
>> 7b100989b4f6 so is the fixes tag correct?
> 
> Hmm... it should be coming from evsel__fallback:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=tmp.perf-tools-next#n2840
> so we shouldn't duplicate that logic. The question is why we're not
> doing the fallback.
> 

Yes, it's a bit of the same logic as evsel__fallback, or we can call 
evlist__add_default() as before, simply create an evsel of hardware 
cycles and add it directly to evlist.

Please confirm whether this solution is feasible. If it is feasible, I 
will send a v2 version.

Thanks,
Yang
