Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52D6C8AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 04:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCYD3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 23:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCYD3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 23:29:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6A212E;
        Fri, 24 Mar 2023 20:29:06 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk4KC3wvxzrWd5;
        Sat, 25 Mar 2023 11:27:59 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 11:29:02 +0800
Subject: Re: [PATCH] perf ftrace: Make system wide the default target for
 latency subcommand
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230324032702.109964-1-yangjihong1@huawei.com>
 <CAM9d7ciGy2Mycm6etHDrt6tu331i-7DphHgBzde0_1=w67mvHg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <b17b5edf-44bb-4734-c42a-8a498372ac8a@huawei.com>
Date:   Sat, 25 Mar 2023 11:29:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciGy2Mycm6etHDrt6tu331i-7DphHgBzde0_1=w67mvHg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/3/25 9:39, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Mar 23, 2023 at 8:29 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> If no target is specified for 'latency' subcommand, the execution fails
>> because - 1 (invalid value) is written to set_ftrace_pid tracefs file.
>> Make system wide the default target, which is the same as the default
>> behavior of 'trace' subcommand.
> 
> I followed the convention to use -a for system-wide profiling.
> Not sure if it's ok to make it default, but I don't object. :)
> 
Thanks for the reply.

Yes, "perf ftrace latency" supports -a for system wide profiles.
Because "perf ftrace trace" defaults to system wide when no target is 
specified. Therefore, I sent the patch to check whether "latency" is 
consistent with the behavior of the "trace". :)

Thanks,
Yang.

> Thanks,
> Namhyung
> 
>>
>> Before the fix:
>>
>>    # perf ftrace latency -T schedule
>>    failed to set ftrace pid
>>
>> After the fix:
>>
>>    # perf ftrace latency -T schedule
>>    ^C#   DURATION     |      COUNT | GRAPH                                          |
>>         0 - 1    us |          0 |                                                |
>>         1 - 2    us |          0 |                                                |
>>         2 - 4    us |          0 |                                                |
>>         4 - 8    us |       2828 | ####                                           |
>>         8 - 16   us |      23953 | ########################################       |
>>        16 - 32   us |        408 |                                                |
>>        32 - 64   us |        318 |                                                |
>>        64 - 128  us |          4 |                                                |
>>       128 - 256  us |          3 |                                                |
>>       256 - 512  us |          0 |                                                |
>>       512 - 1024 us |          1 |                                                |
>>         1 - 2    ms |          4 |                                                |
>>         2 - 4    ms |          0 |                                                |
>>         4 - 8    ms |          0 |                                                |
>>         8 - 16   ms |          0 |                                                |
>>        16 - 32   ms |          0 |                                                |
>>        32 - 64   ms |          0 |                                                |
>>        64 - 128  ms |          0 |                                                |
>>       128 - 256  ms |          4 |                                                |
>>       256 - 512  ms |          2 |                                                |
>>       512 - 1024 ms |          0 |                                                |
>>         1 - ...   s |          0 |                                                |
>>
>> Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/builtin-ftrace.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
>> index d7fe00f66b83..fb1b66ef2e16 100644
>> --- a/tools/perf/builtin-ftrace.c
>> +++ b/tools/perf/builtin-ftrace.c
>> @@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
>>                  goto out_delete_filters;
>>          }
>>
>> +       /* Make system wide (-a) the default target. */
>> +       if (!argc && target__none(&ftrace.target))
>> +               ftrace.target.system_wide = true;
>> +
>>          switch (subcmd) {
>>          case PERF_FTRACE_TRACE:
>> -               if (!argc && target__none(&ftrace.target))
>> -                       ftrace.target.system_wide = true;
>>                  cmd_func = __cmd_ftrace;
>>                  break;
>>          case PERF_FTRACE_LATENCY:
>> --
>> 2.30.GIT
>>
> .
> 
