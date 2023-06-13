Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722BC72DA58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbjFMHEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjFMHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:04:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A410F7;
        Tue, 13 Jun 2023 00:04:29 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QgKCp6wPXzqTMw;
        Tue, 13 Jun 2023 14:59:02 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:03:58 +0800
Subject: Re: [RFC] Adding support for setting the affinity of the recording
 process
To:     Namhyung Kim <namhyung@kernel.org>
CC:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
 <a24634f7-be80-6ca2-9df7-1624fe11c281@arm.com>
 <c291692c-7db8-b4cc-e17a-422c75ad8daa@huawei.com>
 <CAM9d7chqy-RztC943JOgRLcEHvKZN8rS542q3xxW63==KGY3CQ@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <c2f82ca1-8fda-bd0c-4162-3a9e5d867a75@huawei.com>
Date:   Tue, 13 Jun 2023 15:03:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7chqy-RztC943JOgRLcEHvKZN8rS542q3xxW63==KGY3CQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/6/13 13:50, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jun 12, 2023 at 7:28 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Hello,
>>
>> On 2023/6/12 23:27, James Clark wrote:
>>>
>>>
>>> On 12/06/2023 11:26, Yang Jihong wrote:
>>>> Hello everyone,
>>>>
>>>> Currently, perf-record supports profiling an existing process, thread,
>>>> or a specified command.
>>>>
>>>> Sometimes we may need to set CPU affinity of the target process before
>>>> recording:
>>>>
>>>>     # taskset -pc <cpus> <pid>
>>>>     # perf record -p <pid> -- sleep 10
>>>>
>>>> or:
>>>>
>>>>     # perf record -- `taskset -c <cpus> COMMAND`
>>>>
>>>> I'm thinking about getting perf to support setting the affinity of the
>>>> recording process, for example:
>>>>
>>>> 1. set the CPU affinity of the <pid1> process to <cpus1>, <pid2> process
>>>> to <cpus2>,  and record:
>>>>
>>>>     # perf record -p <pid1>/<cpus1>:<pid2>/<cpus2> -- sleep 10
>>>>
>>>
>>> I'm not sure if this is necessary. You can already do this with taskset
>>> when you launch the processes or for existing ones.
>>
>> Yes, that's what we're doing now, and I'm thinking about whether perf
>> can support this "taskset" feature.
> 
> I agree with James that it looks out of scope of perf tools.
> You can always use `taskset` for external processes.
> 
OK, so let's not consider this scenario.
>>
>>>
>>>> and
>>>>
>>>> 2. set CPU affinity of the COMMAND and record:
>>>>
>>>>     # perf record --taskset-command <cpus> COMMAND
>>>>
>>>> In doing so, perf, as an observer, actually changes some of the
>>>> properties of the target process, which may be contrary to the purpose
>>>> of perf tool.
>>>>
>>>>
>>>> Will we consider accepting this approach?
>>>>
>>>
>>> For #2 I do this sometimes, but I prefix the perf command with taskset
>>> because otherwise there is a small time between when taskset does its
>>> thing and launching the child process that it runs in the wrong place.
>>>
>>> Then one issue with the above method is that perf itself gets pinned to
>>> those CPUs as well. I suppose that could influence your application but
>>> I've never had an issue with it.
>>>
>>> If you really can't live with perf also being pinned to those CPUs I
>>> would say it makes sense to add options for #2. Otherwise I would just
>>> run everything under taskset and no changes are needed.
>>
>> If "perf" process and the target process are pinned to the same CPU,
>> and the CPU usage of the target process is high, the perf data
>> collection may be affected. Therefore, in this case, we may need to pin
>> the target process and "perf" to different CPUs.
>>
>>>
>>> I think you would still need to have perf itself pinned to the CPUs just
>>> before it does the fork and exec, and then after that it can undo its
>>> pinning. Otherwise you'd still get that small time running on the wrong
>>> cores.
>>>
>>
>> Thanks for your advice, or we can support setting different affinities
>> for the "perf" process and the target process.
> 
> When it comes to controlling `perf`, you can use --threads=<spec>
> option which supports fairly complex control for parallelism and
> affinity.
> 
Yes, we can ues --threads=<spec>

In addition to the above, or we can simply add a parameter to pin the 
COMMAND to specific cpus.

Thank you for your reply.

Thanks,
Yang.
