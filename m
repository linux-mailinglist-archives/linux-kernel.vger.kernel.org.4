Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75B8622EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiKIPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiKIPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:04:29 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B761704C;
        Wed,  9 Nov 2022 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1668006266;
        bh=faHKfW8MX8mNlpGQT35ygkU0EZ9+oVOiOfdlQbE62ZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rbl/rYo99EGMuJjSPaRXAEF7Mhf0Op8mWIS0vRknojlJhj4Ueov+4p9CITPz5kZE+
         qVjU6OIOccpiTKU00ulHyzVmRNUcbMFWq8ZU941T/BZcyff/mQGWm2QAVPQ7DBOY6h
         wYr78zGi69TlKZFlfLrI1RjmP0LS+88O79AfW13DQ4nldxc79GlHV6ZQ8syW+mjPxR
         UvLsDpoSYsjydX4OjVaLeZ0cKqb4PKTAnOFGQrp3LP7dY4OV+9gc1T4wbWmR2KbGre
         r/5wB3viilNmSrpxZBKbo4BUn2N52fAaqPl4muvIqTQWA+XZKOOseShlON4c84zP9V
         t0iC9mKBuo4vw==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N6pCY64HXzgg1;
        Wed,  9 Nov 2022 10:04:25 -0500 (EST)
Message-ID: <afdd9ed9-6224-3a47-e3de-017a5398024f@efficios.com>
Date:   Wed, 9 Nov 2022 10:04:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <Y2tyshbt+qgJXU9O@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y2tyshbt+qgJXU9O@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-09 04:28, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:
> 
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 08969f5aa38d..6a2323266942 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1047,6 +1047,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>>   	tsk->reported_split_lock = 0;
>>   #endif
>>   
>> +#ifdef CONFIG_SCHED_MM_VCPU
>> +	tsk->mm_vcpu = -1;
>> +	tsk->mm_vcpu_active = 0;
>> +#endif
>>   	return tsk;
>>   
>>   free_stack:
> 
> Note how the above hunk does exactly the same as the below thunk, and I
> think they're even on the same code-path.
> 
> How about moving all of this to __sched_fork() or something?
> 
>> @@ -1579,6 +1586,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>>   
>>   	tsk->mm = mm;
>>   	tsk->active_mm = mm;
>> +	sched_vcpu_fork(tsk);
>>   	return 0;
>>   }
> 
>> +void sched_vcpu_fork(struct task_struct *t)
>> +{
>> +	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
>> +	t->mm_vcpu = -1;
>> +	t->mm_vcpu_active = 1;
>> +}

Let's look at how things are brought up in copy_process():

         p = dup_task_struct(current, node);
           tsk->mm_vcpu = -1;
           tsk->mm_vcpu_active = 0;
­[...]

         /* Perform scheduler related setup. Assign this task to a CPU. */
         retval = sched_fork(clone_flags, p);

-> I presume that from this point the task is observable by the scheduler. However, tsk->mm does not point to the new mm yet.
The "mm_vcpu_active" flag == 0 prevents the scheduler from trying to poke into the wrong mm vcpu_id bitmaps across early mm-struct
lifetime (clone/fork), late in the mm-struct lifetime (exit), and across reset of the mm-struct (exec).

[...]

         retval = copy_mm(clone_flags, p);
             new_mm = dup_mm(old_mm)
               mm_init(new_mm)
                  mm_init_vcpu(new_mm)
-> At this point it becomes OK for the scheduler to poke into the tsk->mm vcpu_id bitmaps. Therefore, sched_vcpu_fork() sets
mm_vcpu_active flag = 1.
              sched_vcpu_fork(tsk)
-> From this point the scheduler can poke into tsk->mm's vcpu_id bitmaps.

So what I think we should to do here is to remove the extra "t->mm_vcpu = -1;" assignment from sched_vcpu_fork(), because
it has already been set by dup_task_struct. We could actually turn that into a "WARN_ON_ONCE(t->mm_vcpu != -1)".

However, if my understanding is correct, keeping "tsk->mm_vcpu_active = 0;" early in dup_task_struct and "tsk->mm_vcpu_active = 1"
in sched_vcpu_fork() after the new mm is initialized is really important. Or am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

