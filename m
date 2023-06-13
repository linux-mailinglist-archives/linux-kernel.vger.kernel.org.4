Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3354672D73B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFMCDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFMCDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:03:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0AAE55;
        Mon, 12 Jun 2023 19:03:45 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QgBYM5Phyz18Lnb;
        Tue, 13 Jun 2023 09:58:47 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 10:03:42 +0800
Subject: Re: [RFC] Adding support for setting the affinity of the recording
 process
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
 <ZIcqmlHIfBbyZFDl@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <5531be0b-a421-fc92-9798-afdb58fc9336@huawei.com>
Date:   Tue, 13 Jun 2023 10:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ZIcqmlHIfBbyZFDl@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Sorry, I forgot to add another recipient in the last email. Send it again.

On 2023/6/12 22:24, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 12, 2023 at 06:26:10PM +0800, Yang Jihong escreveu:
>> Hello everyone,
>>
>> Currently, perf-record supports profiling an existing process, thread, or a
>> specified command.
>>
>> Sometimes we may need to set CPU affinity of the target process before
>> recording:
>>
>>    # taskset -pc <cpus> <pid>
>>    # perf record -p <pid> -- sleep 10
>>
>> or:
>>
>>    # perf record -- `taskset -c <cpus> COMMAND`
>>
>> I'm thinking about getting perf to support setting the affinity of the
>> recording process, for example:
> 
> not of the 'recording process' but the 'observed process', right?
> 


Yes, it's the process of being observed.

>> 1. set the CPU affinity of the <pid1> process to <cpus1>, <pid2> process to
>> <cpus2>,  and record:
>>
>>    # perf record -p <pid1>/<cpus1>:<pid2>/<cpus2> -- sleep 10
> 
> but what would be the semantic for what is being observed? Would this
> result in it recording events on that CPU or just for that process (that
> now runs just on that CPU)?
> 

just for the process running on a specific CPU.

> Without affinity setting that could mean: observe just that process when
> it runs on that CPU.
> 
> But could you please spell out the use case, why do you need this, is
> this so common (for you) that you repeatedly need to first taskset, then
> perf, etc?

As Peter said, big.LITTLE is a common scenario where a process may 
behave differently on different CPUs.

There are other scenarios. For example, if I run a server and a client 
and do not set affinity for them, they may sometimes run on the same 
NUMA node or on different NUMA nodes due to scheduling reasons.
In this case, the performance may fluctuate due to reasons such as cache 
miss.  When analyzing performance problems, we sometimes care about 
stability.

>   
>> and
>>
>> 2. set CPU affinity of the COMMAND and record:
>>
>>    # perf record --taskset-command <cpus> COMMAND
>>
>> In doing so, perf, as an observer, actually changes some of the properties
>> of the target process, which may be contrary to the purpose of perf tool.
> 
> Up for discussion, but I don't think this is that much a problem if it
> streamlines common observability sessions/experimentations.

If the perf is used to set the affinity of the observed process, it 
actually interferes with some behavior of the target process (such as 
affecting scheduling).
In this scenario, the perf is not just a simple observer. Therefore, I 
am not sure whether this behavior is acceptable.

Thank you for your reply.

Thanks,
Yang.
