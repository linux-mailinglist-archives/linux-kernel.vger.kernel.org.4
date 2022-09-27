Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5865EB6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiI0BUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiI0BUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:20:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FBA02F8;
        Mon, 26 Sep 2022 18:20:41 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mc1tC47SXzWgvc;
        Tue, 27 Sep 2022 09:16:35 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:20:39 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 09:20:39 +0800
Message-ID: <eb4db7a7-d84e-7228-d564-4a31fe255331@huawei.com>
Date:   Tue, 27 Sep 2022 09:20:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH -next 3/5] perf: Remove duplicate errbuf
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <john.garry@huawei.com>, <adrian.hunter@intel.com>,
        <ak@linux.intel.com>, <florian.fischer@muhq.space>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
 <20220926031440.28275-4-chenzhongjin@huawei.com>
 <YzIDcPVXLabTeZ11@kernel.org>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YzIDcPVXLabTeZ11@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/9/27 3:54, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 26, 2022 at 11:14:38AM +0800, Chen Zhongjin escreveu:
>> char errbuf[BUFSIZ] is defined twice in trace__run.
>>
>> However out_error_open is not cross to other out_error path, they can
>> share one errbuf together.
>>
>> Define the errbuf[BUFSIZ] at the beginning of function, and remove the
>> redefinations of them for code cleaning.
> Have you looked at the end result in the generated code? Just out of
> curiosity.

Good question. Because it is an auto reported warning of clang I didn't 
try it.

Just tried and found no different for 'objdump -d perf' on two version.


Best,

Chen

>
> - Arnaldo
>   
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>   tools/perf/builtin-trace.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
>> index 7ecd76428440..5660c0ee3507 100644
>> --- a/tools/perf/builtin-trace.c
>> +++ b/tools/perf/builtin-trace.c
>> @@ -3937,6 +3937,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   	unsigned long before;
>>   	const bool forks = argc > 0;
>>   	bool draining = false;
>> +	char errbuf[BUFSIZ];
>>   
>>   	trace->live = true;
>>   
>> @@ -4027,8 +4028,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   
>>   	err = bpf__apply_obj_config();
>>   	if (err) {
>> -		char errbuf[BUFSIZ];
>> -
>>   		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
>>   		pr_err("ERROR: Apply config to BPF failed: %s\n",
>>   			 errbuf);
>> @@ -4185,8 +4184,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   	trace->evlist = NULL;
>>   	trace->live = false;
>>   	return err;
>> -{
>> -	char errbuf[BUFSIZ];
>>   
>>   out_error_sched_stat_runtime:
>>   	tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "sched", "sched_stat_runtime");
>> @@ -4213,7 +4210,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>>   		evsel->filter, evsel__name(evsel), errno,
>>   		str_error_r(errno, errbuf, sizeof(errbuf)));
>>   	goto out_delete_evlist;
>> -}
>> +
>>   out_error_mem:
>>   	fprintf(trace->output, "Not enough memory to run!\n");
>>   	goto out_delete_evlist;
>> -- 
>> 2.17.1
