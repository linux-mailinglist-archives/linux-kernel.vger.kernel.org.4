Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B72622EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiKIPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiKIPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:09:31 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A81CB24;
        Wed,  9 Nov 2022 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1668006569;
        bh=JEJysdOirf9b1qalbUU8Yx+Cw0Eu6WznZk97FtOqlTs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ovXcExtRmcK8u+r/oQWKDojSsbEI+lGG949UMreX0oANwWktQFsc5YqvTvaWYKdcV
         cWkP7wQL5qfofI9Ki36j7WctaX4iAVoUZgIPsXa+AwJVVjjv9vghWbKLm9Yghj1rSg
         C0MG+pKKaEJMM8qgNUcINXIv6w8DmfC+4BJshlSiO0qs0c8VvjxbmmhJkcmovvVwnj
         uNhPzXCBpEFC6Czcb93bohOF3Cng144ViIMfGoda1NdfqZ7lqNCUkErPuVf3c+GdBv
         FMS/ck79UxdQYh50q9otR1Vw+6bV9uCgMY+1Rhbalm07oXHyAwnXnArcteGaeZOSUC
         9rTjHH2LhidIA==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N6pKN3TpczgLh;
        Wed,  9 Nov 2022 10:09:28 -0500 (EST)
Message-ID: <a438952f-7002-1ed6-18a7-708178a97ba4@efficios.com>
Date:   Wed, 9 Nov 2022 10:09:36 -0500
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
 <Y2t2DcHHLVB3tDfw@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y2t2DcHHLVB3tDfw@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-09 04:42, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:
> 
>> +void sched_vcpu_exit_signals(struct task_struct *t)
>> +{
>> +	struct mm_struct *mm = t->mm;
>> +	unsigned long flags;
>> +
>> +	if (!mm)
>> +		return;
>> +	local_irq_save(flags);
>> +	mm_vcpu_put(mm, t->mm_vcpu);
>> +	t->mm_vcpu = -1;
>> +	t->mm_vcpu_active = 0;
>> +	local_irq_restore(flags);
>> +}
>> +
>> +void sched_vcpu_before_execve(struct task_struct *t)
>> +{
>> +	struct mm_struct *mm = t->mm;
>> +	unsigned long flags;
>> +
>> +	if (!mm)
>> +		return;
>> +	local_irq_save(flags);
>> +	mm_vcpu_put(mm, t->mm_vcpu);
>> +	t->mm_vcpu = -1;
>> +	t->mm_vcpu_active = 0;
>> +	local_irq_restore(flags);
>> +}
>> +
>> +void sched_vcpu_after_execve(struct task_struct *t)
>> +{
>> +	struct mm_struct *mm = t->mm;
>> +	unsigned long flags;
>> +
>> +	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
>> +
>> +	local_irq_save(flags);
>> +	t->mm_vcpu = mm_vcpu_get(mm);
>> +	t->mm_vcpu_active = 1;
>> +	local_irq_restore(flags);
>> +	rseq_set_notify_resume(t);
>> +}
> 
>> +static inline void mm_vcpu_put(struct mm_struct *mm, int vcpu)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +	if (vcpu < 0)
>> +		return;
>> +	spin_lock(&mm->vcpu_lock);
>> +	__cpumask_clear_cpu(vcpu, mm_vcpumask(mm));
>> +	spin_unlock(&mm->vcpu_lock);
>> +}
>> +
>> +static inline int mm_vcpu_get(struct mm_struct *mm)
>> +{
>> +	int ret;
>> +
>> +	lockdep_assert_irqs_disabled();
>> +	spin_lock(&mm->vcpu_lock);
>> +	ret = __mm_vcpu_get(mm);
>> +	spin_unlock(&mm->vcpu_lock);
>> +	return ret;
>> +}
> 
> 
> This:
> 
> 	local_irq_disable()
> 	spin_lock()
> 
> thing is a PREEMPT_RT anti-pattern.
> 
> At the very very least this should then be raw_spin_lock(), not in the
> least because you're calling this from under rq->lock, which itself is a
> raw_spin_lock_t.

Very good point, will fix using raw_spinlock_t.

Thanks,

Mathieu

> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

