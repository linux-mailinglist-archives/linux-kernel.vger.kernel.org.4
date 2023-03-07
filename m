Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514A66AE1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCGOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA469239
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:40 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PWHKX35GVzrS1N;
        Tue,  7 Mar 2023 22:05:52 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 22:06:37 +0800
Message-ID: <494b157f-fd16-1b01-82d4-75cec1587128@huawei.com>
Date:   Tue, 7 Mar 2023 22:06:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <rkagan@amazon.de>,
        <linux-kernel@vger.kernel.org>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <1587bdc3-908e-1d63-1d38-019e88ace4df@arm.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <1587bdc3-908e-1d63-1d38-019e88ace4df@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/7 20:45, Dietmar Eggemann 写道:
> On 06/03/2023 14:24, Zhang Qiao wrote:
>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
>> entity being placed") fix an overflowing bug, but ignore
>> a case that se->exec_start is reset after a migration.
>>
>> For fixing this case, we reset the vruntime of a long
>> sleeping task in migrate_task_rq_fair().
>>
>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> 
> [...]
> 
>> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>  	if (READ_ONCE(p->__state) == TASK_WAKING) {
>>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>  
>> -		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>> +		/*
>> +		 * We determine whether a task sleeps for long by checking
>> +		 * se->exec_start, and if it is, we sanitize its vruntime at
>> +		 * place_entity(). However, after a migration, this detection
>> +		 * method fails due to se->exec_start being reset.
>> +		 *
>> +		 * For fixing this case, we add the same check here. For a task
>> +		 * which has slept for a long time, its vruntime should be reset
>> +		 * to cfs_rq->min_vruntime with a sleep credit. Because waking
>> +		 * task's vruntime will be added to cfs_rq->min_vruntime when
> 
> Isn't this the other way around? `vruntime += min_vruntime`
> 
>> +		 * enqueue, we only need to reset the se->vruntime of waking task
>> +		 * to a credit here.
> 
> You not reset it to credit, you subtract the credit from vruntime ?
> 
> I assume this is done to have sleeper credit accounted on both
> (se->vruntime and vruntime) for `se->vruntime =
> max_vruntime(se->vruntime, vruntime)` in place_entity() since
> entity_is_long_sleep(se)=false for a remove wakeup since `se->exec_start=0`.
> 
> 
>> +		 */
>> +		if (entity_is_long_sleep(se))
>> +			se->vruntime = -sched_sleeper_credit(se);
>> +		else
>> +			se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> 
> Not sure I understand this part.
> Don't we have to do `vruntime -= min_vruntime` here for long sleeping
> task as well?

Hi, Dietmar，

At this time, `se->vruntime - min_vruntime` maybe greater than s64max as well.

thanks,
ZhangQiao

> 
> Since we always do the `vruntime += min_vruntime` on the new CPU for a
> remote wakeup.
> 
> [...]
> 
> .
> 
