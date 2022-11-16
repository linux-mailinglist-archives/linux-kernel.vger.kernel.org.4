Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBFF62BBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiKPL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKPL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:26:16 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B007E25EA3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:17:26 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.64.13])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id BAD6D110243209;
        Wed, 16 Nov 2022 19:17:24 +0800 (CST)
Received: from [172.24.140.14] (10.79.64.101) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 16 Nov 2022 19:17:24 +0800
Message-ID: <58020f64-fbbc-fdc7-2cbc-a2aa40062d74@didichuxing.com>
Date:   Wed, 16 Nov 2022 19:17:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] sched/core: use correct cpu_capacity in
 wake_affine_weight()
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Honglei Wang <wanghonglei@didiglobal.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Content-Language: en-US
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <CAKfTPtCthYY9HxaNDyHYszgJctrjTiWPF=AYaj2dLhcB5X=NYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.79.64.101]
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



On 2022/11/16 19:00, Vincent Guittot wrote:
> On Wed, 16 Nov 2022 at 10:12, Honglei Wang <wanghonglei@didiglobal.com> wrote:
>>
>> It seems make more sense to do the load weight calculation with
>> respective cpu_capacity.
>>
>> Signed-off-by: Honglei Wang <wanghonglei@didiglobal.com>
>> ---
>>   kernel/sched/fair.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..a9f75040969b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6262,13 +6262,13 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>>          this_eff_load += task_load;
>>          if (sched_feat(WA_BIAS))
>>                  this_eff_load *= 100;
>> -       this_eff_load *= capacity_of(prev_cpu);
>> +       this_eff_load *= capacity_of(this_cpu);
>>
>>          prev_eff_load = cpu_load(cpu_rq(prev_cpu));
>>          prev_eff_load -= task_load;
>>          if (sched_feat(WA_BIAS))
>>                  prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
>> -       prev_eff_load *= capacity_of(this_cpu);
>> +       prev_eff_load *= capacity_of(prev_cpu);
> 
> we want to test :
>      (cpu_load(this_rq) + task_h_load(p) ) / capacity_of(this_cpu)  <
> cpu_load(prev_rq) / capacity_of(prev_cpu)
> 
> but instead of doing expensive division, we do the below which gives
> the same result
>      (cpu_load(this_rq) + task_h_load(p) ) * capacity_of(prev_cpu)  <
> cpu_load(prev_rq) * capacity_of(this_cpu)
> 
> 

ha, I misunderstand the strategy, thanks for coaching, Vincent.

>>
>>          /*
>>           * If sync, adjust the weight of prev_eff_load such that if
>> --
>> 2.14.1
>>
