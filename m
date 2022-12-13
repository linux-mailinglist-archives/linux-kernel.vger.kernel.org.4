Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9AB64B2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiLMKHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiLMKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:07:01 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5244D1A811
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:07:00 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.64.13])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 62240B0069A26;
        Tue, 13 Dec 2022 18:06:58 +0800 (CST)
Received: from [172.28.90.63] (10.79.65.102) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 13 Dec 2022 18:06:57 +0800
Message-ID: <2a54f264-de3d-d5a3-941a-016ed2cfea0a@didichuxing.com>
Date:   Tue, 13 Dec 2022 18:06:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
To:     Chen Yu <yu.c.chen@intel.com>, Josh Don <joshdon@google.com>
CC:     Yicong Yang <yangyicong@huawei.com>, <yangyicong@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>
Content-Language: en-US
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <Y5gRsnLQLlzugB4I@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.79.65.102]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/13 13:46, Chen Yu wrote:
> On 2022-12-12 at 10:17:35 -0800, Josh Don wrote:
>>> BTW, I've changed the threshold to (sysctl_sched_min_granularity / 8) in my next
>>> version, as this is the value that fit my previous test case and also not to break
>>> the case Josh mentioned.
>>
>> Do you mean a hardcoded value of some number of micros, or literally
>> sched_min_granularity / 8?
> The latter. According to the test, the average task duration when system
> is under heavy load:
> 6 ~ 9 us for netperf
> 7 ~ 70 us for hackbench
> 7 ~ 8 us for tbench
> 13 ~ 20 ms for schbench
> Overall the duration of the micros are quite small(except for schbench).
> The default sysctl_sched_min_granularity is 750 us in kernel if no user
> has changed it. Then 750 / 8 = 93 us, which is close to what you suggested(100us).
> On the other hand, if someone changes sysctl_sched_min_granularity,
> then '8' can be viewed as log2(256). That is, if there are 256 CPUs online,
> and the sysctl_sched_min_granularity is changed to 750 us * log2(256) by
> the user, we can devide the sysctl_sched_min_granularity by 8 in case the
> sysctl_sched_min_granularity is too large.
> 

Hi Yu,

Seems there is a min_t() call in get_update_sysctl_factor(). In most 
cases, we'll get 750 us * (1+log2(8)) = 3000 us in default due to 
sysctl_sched_tunable_scaling is set as '1' default. (Correct me if I 
misunderstand).

For the value in production environment, I've seen 10 ms and 3 ms in 
different place, FYI. Hope this help.

Thanks,
Honglei

> My concern of using hardcoded value is that, this value depends on how fast
> the CPU runs(cpu frequency). The value I measured above is when the
> CPU is running at 1.9Ghz. If a CPU runs faster, a hard code value might not
> be appropriate and could not be tuned.
>> I don't think the latter is necessary, and
>> indeed can lead to weirdness if min_gran is too small or too large. I
>> don't think the concept of what a short duration task is should
>> expand/contract with min_gran.
> The value of sysctl_sched_min_granularity might indicate how long the
> user would like a task to run at least. If the user enlarge this value,
> does it mean the user wants every task in the system to run longer?
>  From this point I found connection between the the definition of short task
> duration and this value. I'm open to changing this value to a fixed one, may
> I have more insights on how this value would be set in production environment?
> 
> thanks,
> Chenyu
>>
>> Best,
>> Josh
