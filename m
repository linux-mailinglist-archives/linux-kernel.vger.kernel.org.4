Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6545E9A73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiIZHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiIZHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:32:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92320BFD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:32:53 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbZCT2c0xzpVcF;
        Mon, 26 Sep 2022 15:29:57 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 15:32:51 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 15:32:51 +0800
Message-ID: <18e90120-dad4-853e-0373-f114d94c53ee@huawei.com>
Date:   Mon, 26 Sep 2022 15:32:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Question about kill a process group
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     lkml <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <elver@google.com>,
        <legion@kernel.org>, <oleg@redhat.com>, <brauner@kernel.org>
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
 <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
 <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
 <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
 <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com>
 <874k2mtny7.fsf@email.froward.int.ebiederm.org> <87zgk5v148.ffs@tglx>
 <87a6bnudfy.fsf@email.froward.int.ebiederm.org> <87bkw3y943.ffs@tglx>
 <87mtfmhap2.fsf@email.froward.int.ebiederm.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <87mtfmhap2.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/13 2:23, Eric W. Biederman 写道:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
>> On Wed, May 11 2022 at 13:33, Eric W. Biederman wrote:
>>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>> So unless the number of PIDs for a user is limited this _is_ an
>>>> unpriviledged DoS vector.
>>>
>>> After having slept on this a bit it finally occurred to me the
>>> semi-obvious solution to this issue is to convert tasklist_lock
>>> from a rw-spinlock to rw-semaphore.  The challenge is finding
>>> the users (tty layer?) that generate signals from interrupt
>>> context and redirect that signal generation.
>>
>> From my outdated notes where I looked at this before:
>>
>> [soft]interrupt context which acquires tasklist_lock:
>> sysrq-e		send_sig_all()
>> sysrq-i         send_sig_all()
>> sysrq-n		normalize_rt_tasks()
>>
>> tasklist_lock nesting into other locks:
>>    fs/fcntl.c: send_sigio(), send_sigurg()
>>
>>    send_sigurg() is called from the network stack ...
>>
>> Some very obscure stuff in arch/ia64/kernel/mca.c which is called
>> from a DIE notifier.
> 
> I think we are very close to the point that if ia64 is the only user
> problem case we can just do "git rm arch/ia64".  I am not certain
> there is even anyone left that cares enough to report breakage
> on ia64.
> 
>> Plus quite a bunch of read_lock() instances which nest inside
>> rcu_read_lock() held sections.
>>
>> This is probably incomplete, but the scope of the problem has been
>> greatly reduced vs. the point where I looked at it last time a couple of
>> years ago. But that's still a herculean task.
> 
> I won't argue.
> 
>>> Once signals holding tasklist_lock are no longer generated from
>>> interrupt context irqs no longer need to be disabled and
>>> after verifying tasklist_lock isn't held under any other spinlocks
>>> it can be converted to a semaphore.
>>
>> Going to take a while. :)
> 
> It is a very tractable problem that people can work on incrementally.
> 
>>> It won't help the signal delivery times, but it should reduce
>>> the effect on the rest of the system, and prevent watchdogs from
>>> firing.
>>
>> The signal delivery time itself is the least of the worries, but this
>> still prevents any other operations which require tasklist_lock from
>> making progress for quite some time, i.e. fork/exec for unrelated
>> processes/users will have to wait too. So you converted the 'visible'
>> DoS to an 'invisible' one.
>>
>> The real problem is that the scope of tasklist_lock is too broad for
>> most use cases. That does not change when you actually can convert it to
>> a rwsem. The underlying problem still persists.
>>
>> Let's take a step back and look what most sane use cases (sysrq-* is not
>> in that category) require:
>>
>>    Preventing that tasks are added or removed
>>
>> Do they require that any task is added or removed? No.
>>
>>    They require to prevent add/remove for the intended scope.
>>
>> That's the thing we need to focus on: reducing the protection scope.
>>
>> If we can segment the protection for the required scope of e.g. kill(2)
>> then we still can let unrelated processes/tasks make progress and just
>> inflict the damage on the affected portion of processes/tasks.
>>
>> For example:
>>
>> 	read_lock(&tasklist_lock);
>> 	for_each_process(p) {
>> 		if (task_pid_vnr(p) > 1 &&
>> 		    !same_thread_group(p, current)) {
>>
>> 			group_send_sig_info(...., p);
>> 		}
>> 	}
>> 	read_unlock(&tasklist_lock);
>>
>> same_thread_group() does:
>>
>>    return p->signal == current->signal;
> 
> Yes.  So the sender can not send a signal to itself.
> Basically it is a test to see if a thread is a member of a process.
> 
>> Ideally we can do:
>>
>> 	read_lock(&tasklist_lock);
>>         prevent_add_remove(current->signal);
>> 	read_unlock(&tasklist_lock);
>>
>>         rcu_read_lock();
>> 	for_each_process(p) {
>> 		if (task_pid_vnr(p) > 1 &&
>> 		    !same_thread_group(p, current)) {
>>
>> 			group_send_sig_info(...., p);
>> 		}
>> 	}
>>         rcu_read_unlock();
>>
>>         allow_add_remove(current->signal);
>>
>> Where prevent_add_remove() sets a state which has to be waited for to be
>> cleared by anything which wants to add/remove a task in that scope or
>> change $relatedtask->signal until allow_add_remove() removes that
>> blocker. I'm sure it's way more complicated, but you get the idea.
> 
> Hmm.
> 
> For sending signals what is needed is the guarantee that the signal is
> sent to an atomic snapshot of the appropriate group of processes so that
> SIGKILL sent to the group will reliably kill all of the processes.  It
> should be ok for a process to exit on it's own from the group.  As long
> as it logically looks like the process exited before the signal was
> sent.
> 
> There is also ptrace_attach/__ptrace_unlink, reparenting,
> kill_orphaned_pgrp, zap_pid_ns_processes, and pid hash table
> maintenance in release_task.
> 
> I have a patch I am playing with that protects task->parent and
> task->real_parent with siglock and with a little luck that can
> be generalized so that sending signals to parents and ptrace don't
> need tasklist_lock at all.
> 
> For reparenting of children the new parents list of children
> needs protection but that should not need tasklist lock.
> 
> For kill_orphaned_pgrp with some additional per process group
> maintenance state so that will_become_orphaned_pgrp and has_stopped_jobs
> don't need to traverse the process group it should be possible to
> just have it send a sender of a process group signal.
> 
> zap_pid_ns_processes is already called without the tasklist_lock.
> 
> Maintenance of the pid hash table certainly needs a write lock in
> __exit_signal but it doesn't need to be tasklist_lock.
> 
> 
> 
> 
> 
> Which is a long way of saying semantically all we need is to
> prevent_addition to the group of processes a signal will be sent to.  We
> have one version of that prevention today in fork where it tests
> fatal_signal_pending after taking tasklist_lock and siglock.  For the
> case you are describing the code would just need to check each group of
> processes the new process is put into.
> 
> 
> Hmm.
> 
> When I boil it all down in my head I wind up with something like:
> 
> 	rwlock_t *lock = signal_lock(enum pid_type type);
>         read_lock(lock);
>         	/* Do the work of sending the signal */
>         read_unlock(lock);
> 
> With fork needing to grab all of those possible locks for write
> as it adds the process to the group.
> 
> Maybe it could be something like:
> 
> 	struct group_signal {
>         	struct hlist_node node;
>                 struct kernel_siginfo *info;
>         };
> 
> 	void start_group_signal(struct group_signal *group, struct
> 				kernel_siginfo *info, enum pid_type type);
> 	void end_group_signal(struct group_signal *group);
> 
> 	struct group_signal group_sig;
> 	start_group_signal(&group_sig, info, PIDTYPE_PGID);
> 
> 	/* Walk through the list and deliver the signal */
> 
> 	end_group_signal(&group_sig);
> 
> That would allow fork to see all signals that are being delivered to a
> group even it the signal has not been delivered to the parent process
> yet.  At which point the signal could be delivered to the parent before
> the fork.  I just need something to ensure that the signal delivery loop
> between start_group_signal and end_group_signal skips processes that
> hurried up and delivered the signal to themselves, and does not
> deliver to newly added processes.  A generation counter perhaps.
> 
> There is a lot to flesh out, and I am burried alive in other cleanups
> but I think that could work, and remove the need to hold tasklist_lock
> during signal delivery.
> 
> 
>> If we find a solution to this scope reduction problem, then it will not
>> only squash the issue which started this discussion. This will have a
>> benefit in general.
> 
> We need to go farther than simple scope reduction to benefit the
> original problem.  As all of the process in that problem were
> all sending a signal to the same process group.  So they all needed
> to wait for each other.
> 
> If we need to block adds then the adds need to effectively take a
> write_lock to the read_lock taken during signal delivery.  Because
> all of the blocking is the same we won't see an improvement of
> the original problem.
> 
> 
> 
> If in addition to scope reduction, a barrier is implemented so that
> it is guaranteed that past a certain point processes will see the signal
> before they fork (or do anything else that userspace could tell the
> signal was not delivered atomically) then I think we can eliminate
> blocking in the same places and an improvement in the issue that
> started this discussion can be seen.
> 
> 
> I will queue it up on my list of things I would like to do.  I am


hi, Eric:

Do you have any plans to fix it?  I look forward to your patches.

thanks!
-Zhang Qiao
.



> burried in other signal related cleanups at the moment so I don't know
> when I will be able to get to anything like that.  But I really
> appreciate the idea.
> 
> Eric
> 
> .
> 
