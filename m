Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461BE6E49E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjDQN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDQN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:28:58 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8642120
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681738132;
        bh=VC7Pv9TEKGhlauLAq1ahambxH+r0JhmzgY0wLXKnuKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NYuXrnyKJmha+P9EOoFA5IBspXsJWJ02js9vyHNs0i6FmLKKde0dWWp74q37y5kjB
         QboGd7urPRsTMTwQBAXUAv+9DgyXIlxh/8wtVMke7yU091a3ug5mpYy/o90zoJqyUi
         OGbdfGKeB52Jon3KAs1xL0PXwDERtbIa4slCP2tCk3sgNJAvygtYXvnBzwGkXLhK4+
         hJFEcv2FUkMtCNP3UGidcJZ0DjwmFr/cgueUEHtjAYcE0/xCm/QktuzrhhAxj5jQkG
         zDY6mCy03BFYpL+IWbTbWiabPu6UmfLMM3Zr7HLaBKDCj0kcWnMYGtMNYF/l2+ZePO
         sdbL/rixHW/rQ==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q0SYw2WBQzvpK;
        Mon, 17 Apr 2023 09:28:52 -0400 (EDT)
Message-ID: <5abacbf4-8101-7931-6dee-84f4f004240a@efficios.com>
Date:   Mon, 17 Apr 2023 09:28:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v7] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230416223217.191261-1-mathieu.desnoyers@efficios.com>
 <20230417101855.GA485797@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230417101855.GA485797@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-17 06:18, Aaron Lu wrote:
> On Sun, Apr 16, 2023 at 06:32:17PM -0400, Mathieu Desnoyers wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0d18c3969f90..9532cf1a2a44 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2084,8 +2084,10 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>>   
>>   void activate_task(struct rq *rq, struct task_struct *p, int flags)
>>   {
>> -	if (task_on_rq_migrating(p))
>> +	if (task_on_rq_migrating(p)) {
>>   		flags |= ENQUEUE_MIGRATED;
>> +		sched_mm_cid_migrate_to(rq, p);
> 
> 
> I noticed you did this in previous version too but forgot to ask:
> is it your intention to only invoke sched_mm_cid_migrate_to() for queued
> tasks, i.e. tasks that are being migrated due to load/idle balance etc,
> but not those tasks that migrated on wakeup?

My intent is to also cover tasks migrated on wakeup.

> 
> I saw you did the corresonding sched_mm_cid_migrate_from() in
> set_task_cpu(), which on the other hand includes tasks that migrated due
> to wakeup, so it kind of feel weird.

I'm probably missing something here. AFAIU, when try_to_wake_up() moves 
the target process to a different cpu:

         cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
         if (task_cpu(p) != cpu) {

it ends up calling ttwu_queue() with wake_flags |= WF_MIGRATED bit set.

Then ttwu_queue() ends up calling ttwu_queue_wakelist(), which may 
initiate an IPI to the target cpu which executes sched_ttwu_pending().
This function will take the target cpu's runqueue lock and call 
ttwu_do_activate() with wake_flags=WF_MIGRATED.

The other path that ttwu_queue() can take is to issue ttwu_do_activate() 
with the target cpu's rq lock held.

ttwu_do_activate() calls activate_task() with flags having 
ENQUEUE_MIGRATED set.

OK I think I see what I missed here, I should change this to:

void activate_task(struct rq *rq, struct task_struct *p, int flags)
{
         if (task_on_rq_migrating(p))
                 flags |= ENQUEUE_MIGRATED;
	if (flags & ENQUEUE_MIGRATED)
                 sched_mm_cid_migrate_to(rq, p);
[...]

Because flags is received as input parameter as well.

Do I get your meaning correctly ?

Thanks!

Mathieu

> 
>> +	}
>>   
>>   	enqueue_task(rq, p, flags);
>>   
>> @@ -3195,6 +3197,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>>   			p->sched_class->migrate_task_rq(p, new_cpu);
>>   		p->se.nr_migrations++;
>>   		rseq_migrate(p);
>> +		sched_mm_cid_migrate_from(p);
>>   		perf_event_task_migrate(p);
>>   	}
> 
> Thanks,
> Aaron

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

