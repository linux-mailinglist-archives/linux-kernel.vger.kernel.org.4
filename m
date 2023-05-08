Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B326F9D90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjEHB7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjEHB7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:59:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097AEA5DF;
        Sun,  7 May 2023 18:59:11 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QF49c1kzszpStJ;
        Mon,  8 May 2023 09:55:00 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 09:59:08 +0800
Subject: Re: [PATCH v3] perf/core: Fix perf_sample_data not properly
 initialized for different swevents in perf_tp_event()
To:     <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230425103217.130600-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>
Message-ID: <9ae47526-8d40-dcd7-4fef-199b8605bfe9@huawei.com>
Date:   Mon, 8 May 2023 09:59:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230425103217.130600-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter

PING.

As shown in Link [1] report, data->raw->frag.data may be accessed in 
perf_tp_event_match().
we may need to init sample_data and then go through swevent hlist to 
prevent reference of NULL pointer.

Please check whether the solution is OK.

[1] Link: 
https://lore.kernel.org/oe-lkp/202304250929.efef2caa-yujie.liu@intel.com

Thanks,
Yang

On 2023/4/25 18:32, Yang Jihong wrote:
> data->sample_flags may be modified in perf_prepare_sample(),
> in perf_tp_event(), different swevents use the same on-stack
> perf_sample_data, the previous swevent may change sample_flags in
> perf_prepare_sample(), as a result, some members of perf_sample_data are
> not correctly initialized when next swevent_event preparing sample
> (for example data->id, the value varies according to swevent).
> 
> A simple scenario triggers this problem is as follows:
> 
>    # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
>    [ perf record: dump data: Woken up 0 times ]
>    [ perf record: Dump perf.data.2023041209014396 ]
>    [ perf record: dump data: Woken up 0 times ]
>    [ perf record: Dump perf.data.2023041209014662 ]
>    [ perf record: dump data: Woken up 0 times ]
>    [ perf record: Dump perf.data.2023041209014910 ]
>    [ perf record: Woken up 0 times to write data ]
>    [ perf record: Dump perf.data.2023041209015164 ]
>    [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
>    # ls -l
>    total 860
>    -rw------- 1 root root  95694 Apr 12 09:01 perf.data.2023041209014396
>    -rw------- 1 root root 606430 Apr 12 09:01 perf.data.2023041209014662
>    -rw------- 1 root root  82246 Apr 12 09:01 perf.data.2023041209014910
>    -rw------- 1 root root  82342 Apr 12 09:01 perf.data.2023041209015164
>    # perf script -i perf.data.2023041209014396
>    0x11d58 [0x80]: failed to process type: 9 [Bad address]
> 
> Solution: Re-initialize perf_sample_data after each event is processed.
> Note that data->raw->frag.data may be accessed in perf_tp_event_match().
> Therefore, need to init sample_data and then go through swevent hlist to prevent
> reference of NULL pointer, reported by [1].
> 
> After fix:
> 
>    # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
>    [ perf record: dump data: Woken up 0 times ]
>    [ perf record: Dump perf.data.2023041209442259 ]
>    [ perf record: dump data: Woken up 0 times ]
>    [ perf record: Dump perf.data.2023041209442514 ]
>    [ perf record: dump data: Woken up 0 times ]
>    [ perf record: Dump perf.data.2023041209442760 ]
>    [ perf record: Woken up 0 times to write data ]
>    [ perf record: Dump perf.data.2023041209443003 ]
>    [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
>    # ls -l
>    total 864
>    -rw------- 1 root root 100166 Apr 12 09:44 perf.data.2023041209442259
>    -rw------- 1 root root 606438 Apr 12 09:44 perf.data.2023041209442514
>    -rw------- 1 root root  82246 Apr 12 09:44 perf.data.2023041209442760
>    -rw------- 1 root root  82342 Apr 12 09:44 perf.data.2023041209443003
>    # perf script -i perf.data.2023041209442259 | head -n 5
>                perf   232 [000]    66.846217: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=D ==> next_comm=perf next_pid=234 next_prio=120
>                perf   234 [000]    66.846449: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
>                perf   232 [000]    66.846546: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120
>                perf   234 [000]    66.846606: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
>                perf   232 [000]    66.846646: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120
> 
> [1] Link: https://lore.kernel.org/oe-lkp/202304250929.efef2caa-yujie.liu@intel.com
> 
> Fixes: bb447c27a467 ("perf/core: Set data->sample_flags in perf_prepare_sample()")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v2:
>   - Initialize perf_sample_data before go through the swevent hlist.
>   - Re-initialize perf_sample_data after each swevent is processed.
> 
> Changes since v1:
>   - Re-initialize the entire perf_sample_data before processing each swevent.
> 
>   kernel/events/core.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 435815d3be3f..753d4e9665b6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10150,8 +10150,20 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>   	perf_trace_buf_update(record, event_type);
>   
>   	hlist_for_each_entry_rcu(event, head, hlist_entry) {
> -		if (perf_tp_event_match(event, &data, regs))
> +		if (perf_tp_event_match(event, &data, regs)) {
>   			perf_swevent_event(event, count, &data, regs);
> +
> +			/*
> +			 * Here use the same on-stack perf_sample_data,
> +			 * some members in data are event-specific and
> +			 * need to be re-computed for different sweveents.
> +			 * Re-initialize data->sample_flags safely to avoid
> +			 * the problem that next event skips preparing data
> +			 * because data->sample_flags is set.
> +			 */
> +			perf_sample_data_init(&data, 0, 0);
> +			perf_sample_save_raw_data(&data, &raw);
> +		}
>   	}
>   
>   	/*
> 
