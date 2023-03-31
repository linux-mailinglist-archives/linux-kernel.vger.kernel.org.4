Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E2F6D2BE9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjCaX43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjCaX4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:56:20 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E81D2EA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680306957;
        bh=9nyNnLivc1BqEloXmD08qB4ClT5kReJTKRHvthlKyww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jlg49I/vkV2uw0fWOda2m5qAZLJHbnMN0rmXPCTS0DxmPAcX975CQkKaHteSExR5E
         ONRsEGQ02e0wCx5U1UeIYZXbzVd3ienrJysEps98sH55ugw9wxbWyJMWzDe/Wwn/Sb
         OXogHaNrB9zY55AzBrBO4kubX7g/7UYbz6uY3D9jjVW1TkBvbt1U7GdJuGFF3QlWKG
         uONfYMunlyQtNtqm/qtuf3lWIr79owd8L9gD0X4b9Y++M+KelRIjgeob+EGNCOYYED
         lSgQZE/y8/YT4iLWW+YlqVteDXsbNmFO0nY7SyvEdIt3N7D3RjRDx/JvJ0fCrrTQXN
         RBduLz8iEofQQ==
Received: from [172.25.5.198] (unknown [209.226.41.181])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PpHHK2GmxztVq;
        Fri, 31 Mar 2023 19:55:57 -0400 (EDT)
Message-ID: <5efc39c5-865b-1c0f-e22d-dc79c67dbcf2@efficios.com>
Date:   Fri, 31 Mar 2023 19:56:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
 <20230331083830.GA186694@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230331083830.GA186694@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-31 04:38, Aaron Lu wrote:
> On Thu, Mar 30, 2023 at 07:09:11PM -0400, Mathieu Desnoyers wrote:
> 
>>   void sched_mm_cid_exit_signals(struct task_struct *t)
>>   {
>>   	struct mm_struct *mm = t->mm;
>> -	unsigned long flags;
>> +	struct rq *rq = this_rq();
> 
> Got many below messages due to the above line:
> 
> [   19.294089] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u449:0/1621
> 
>> +	struct rq_flags rf;
>>   
>>   	if (!mm)
>>   		return;
>> -	local_irq_save(flags);
>> +	rq_lock_irqsave(rq, &rf);
>>   	mm_cid_put(mm, t->mm_cid);
>>   	t->mm_cid = -1;
>>   	t->mm_cid_active = 0;
>> -	local_irq_restore(flags);
>> +	rq_unlock_irqrestore(rq, &rf);
>>   }
>>   
>>   void sched_mm_cid_before_execve(struct task_struct *t)
>>   {
>>   	struct mm_struct *mm = t->mm;
>> -	unsigned long flags;
>> +	struct rq *rq = this_rq();
> 
> Also here;
> 
>> +	struct rq_flags rf;
>>   
>>   	if (!mm)
>>   		return;
>> -	local_irq_save(flags);
>> +	rq_lock_irqsave(rq, &rf);
>>   	mm_cid_put(mm, t->mm_cid);
>>   	t->mm_cid = -1;
>>   	t->mm_cid_active = 0;
>> -	local_irq_restore(flags);
>> +	rq_unlock_irqrestore(rq, &rf);
>>   }
>>   
>>   void sched_mm_cid_after_execve(struct task_struct *t)
>>   {
>>   	struct mm_struct *mm = t->mm;
>> -	unsigned long flags;
>> +	struct rq *rq = this_rq();
> 
> And here.
> 
>> +	struct rq_flags rf;
>>   
>>   	if (!mm)
>>   		return;
>> -	local_irq_save(flags);
>> +	rq_lock_irqsave(rq, &rf);
>>   	t->mm_cid = mm_cid_get(mm);
>>   	t->mm_cid_active = 1;
>> -	local_irq_restore(flags);
>> +	rq_unlock_irqrestore(rq, &rf);
>>   	rseq_set_notify_resume(t);
>>   }
> 
> I used below diff to get rid of these messages without understanding the
> purpose of these functions:

I'll fold this fix into the next round, thanks!

Mathieu

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f07b87d155bd..7194c29f3c91 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11444,45 +11444,57 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int src_c
>   void sched_mm_cid_exit_signals(struct task_struct *t)
>   {
>   	struct mm_struct *mm = t->mm;
> -	struct rq *rq = this_rq();
>   	struct rq_flags rf;
> +	struct rq *rq;
>   
>   	if (!mm)
>   		return;
> +
> +	preempt_disable();
> +	rq = this_rq();
>   	rq_lock_irqsave(rq, &rf);
>   	mm_cid_put(mm, t->mm_cid);
>   	t->mm_cid = -1;
>   	t->mm_cid_active = 0;
>   	rq_unlock_irqrestore(rq, &rf);
> +	preempt_enable();
>   }
>   
>   void sched_mm_cid_before_execve(struct task_struct *t)
>   {
>   	struct mm_struct *mm = t->mm;
> -	struct rq *rq = this_rq();
>   	struct rq_flags rf;
> +	struct rq *rq;
>   
>   	if (!mm)
>   		return;
> +
> +	preempt_disable();
> +	rq = this_rq();
>   	rq_lock_irqsave(rq, &rf);
>   	mm_cid_put(mm, t->mm_cid);
>   	t->mm_cid = -1;
>   	t->mm_cid_active = 0;
>   	rq_unlock_irqrestore(rq, &rf);
> +	preempt_enable();
>   }
>   
>   void sched_mm_cid_after_execve(struct task_struct *t)
>   {
>   	struct mm_struct *mm = t->mm;
> -	struct rq *rq = this_rq();
>   	struct rq_flags rf;
> +	struct rq *rq;
>   
>   	if (!mm)
>   		return;
> +
> +	preempt_disable();
> +	rq = this_rq();
>   	rq_lock_irqsave(rq, &rf);
>   	t->mm_cid = mm_cid_get(mm);
>   	t->mm_cid_active = 1;
>   	rq_unlock_irqrestore(rq, &rf);
> +	preempt_enable();
>   	rseq_set_notify_resume(t);
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

