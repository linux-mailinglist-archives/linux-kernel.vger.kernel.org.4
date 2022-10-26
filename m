Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E7360E2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiJZN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiJZN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1201E8E719
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666792538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3hx4lUNHHT6HeYb8UB9w7OMcarmIm4ywJ8XKMKZHRg=;
        b=YNhWgfsNo/lYHvHKpOnvpYbQM7Vur5g9Zs07InULmbNKUT/gMxLzoLwGXvfCu2rx0XHK5a
        vcIgzdLrITp+Ttv8d8Ph1Wb12B+g96NQdIGbdhSLOXQ37GdczmS+7zJmLv/HTXTMh3pfVl
        5VHi/FCAZQIjTDiT84fgJKqLHRZVZbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-t26SELyFOBG-Xnt5uXOxcw-1; Wed, 26 Oct 2022 09:55:37 -0400
X-MC-Unique: t26SELyFOBG-Xnt5uXOxcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 644F81012440;
        Wed, 26 Oct 2022 13:55:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-168.brq.redhat.com [10.40.192.168])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36E571121315;
        Wed, 26 Oct 2022 13:55:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 26 Oct 2022 15:55:35 +0200 (CEST)
Date:   Wed, 26 Oct 2022 15:55:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     chenzhang_0901@163.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptrace: disable single step in __ptrace_unlink for
 protecting init task
Message-ID: <20221026135531.GA9928@redhat.com>
References: <20221026052923.11902-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026052923.11902-1-chenzhang@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen,

I do not know what can I add to our discussion. Let me repeat once again
to summarize:

	- I don't think this patch makes a lot of sense. If debugger
	  exits without PTRACE_DETACH it can crash the tracee in many
	  ways, even without PTRACE_SINGLESTEP.

	- The patch is wrong in any case. If __ptrace_unlink() is called
	  by the exiting debugger, the child can be running. In this case
	  we can't use user_disable_single_step(child), it assumes this
	  child is frozen.

	- Even if the change in __ptrace_unlink() was correct, it is racy.
	  __ptrace_unlink()->user_disable_single_step() can be called after
	  force_sig_info_to_task() was already called, but before it takes
	  ->siglock and checks ->ptrace. In this case ->ptrace will be zero
	  and SIGNAL_UNKILLABLE will be cleared.

Oh. but I already said this all, but you seem to ignore. You simply keep
sending the same patch without addressing my objections. So I wrote this
stupid test-case:

	#include <stdio.h>
	#include <unistd.h>
	#include <sys/ptrace.h>
	#include <sys/wait.h>
	#include <assert.h>

	int main(void)
	{
		for (int c = 0;;c++) {
			if ((c % 10000) == 0)
				printf("%d\n", c);

			if (fork())
				wait(NULL);
			else {
				assert(ptrace(PTRACE_ATTACH, 1, NULL,NULL) == 0);
				assert(wait(NULL) == 1);
				assert(ptrace(PTRACE_SINGLESTEP, 1, NULL, SIGWINCH) == 0);
				assert(wait(NULL) == 1);
				assert(ptrace(PTRACE_SINGLESTEP, 1, NULL, NULL) == 0);
				assert(wait(NULL) == 1);
				assert(ptrace(PTRACE_SINGLESTEP, 1, NULL, NULL) == 0);
				assert(wait(NULL) == 1);
				assert(ptrace(PTRACE_SINGLESTEP, 1, NULL, NULL) == 0);
				assert(wait(NULL) == 1);
				assert(ptrace(PTRACE_SINGLESTEP, 1, NULL, NULL) == 0);
				return 0;
			}
		}

		return 0;
	}

and it crashes the kernel WITH YOUR PATCH APPLIED. This proves that
the patch is racy even if the change in __ptrace_unlink() was correct.

Not sure this test-case will work on your machine, I ran it under qemu
with init=/bin/bash.

Chen, I am sorry, but I will not answer if you resend this patch again.

Oleg.

On 10/26, chen zhang wrote:
>
> I got below panic when doing fuzz test:
>
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000005
> CPU: 2 PID: 1 Comm: systemd Kdump: loaded Not tainted 6.1.0-rc1 #1
> Hardware name: LENOVO 20L5A07XCD/20L5A07XCD, BIOS N24ET56W (1.31 ) 02/19/2020
> Call Trace:
> [  157.210356]  dump_stack_lvl+0x49/0x63
> [  157.210364]  dump_stack+0x10/0x16
> [  157.210368]  panic+0x10c/0x299
> [  157.210375]  do_exit.cold+0x15/0x15
> [  157.210381]  do_group_exit+0x35/0x90
> [  157.210386]  get_signal+0x910/0x960
> [  157.210390]  ? signal_wake_up_state+0x2e/0x40
> [  157.210396]  ? complete_signal+0xd0/0x2c0
> [  157.210402]  arch_do_signal_or_restart+0x37/0x7c0
> [  157.210408]  ? send_signal_locked+0xf5/0x140
> [  157.210416]  exit_to_user_mode_prepare+0x133/0x180
> [  157.210423]  irqentry_exit_to_user_mode+0x9/0x20
> [  157.210428]  noist_exc_debug+0xea/0x150
> [  157.210433]  asm_exc_debug+0x34/0x40
> [  157.210438] RIP: 0033:0x7fcf2a8e51c9
> [  157.210442] Code: ff ff 73 01 c3 48 8b 0d c5 7c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 ba 00 00 00 <0f> 05 c3 0f 1f 40 00 f3 0f 1e fa b8 ea 00 00 00 0f 05 48 3d 01 f0
> [  157.210446] RSP: 002b:00007ffd7dc44678 EFLAGS: 00000302
> [  157.210451] RAX: 00000000000000ba RBX: 000055f7c0363170 RCX: 000055f7c04d2820
> [  157.210454] RDX: 00000000ffffffff RSI: ffffffffffffffff RDI: 000055f7c0363170
> [  157.210457] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000001dd0
> [  157.210460] R10: 00007ffd7ddc9090 R11: 000000000000d7da R12: 0000000000000001
> [  157.210463] R13: ffffffffffffffff R14: 000055f7bf3557c1 R15: 0000000000000000
>
> If a task attaches init task and is single stepping it, when this task
> exits, ptrace value will be cleaned. It causes SIGNAL_UNKILLABLE flag
> cleaned, and init task will lose the protection. Init task maybe be killed
> by SIGTRAP signal because of stepping enabled. So syscall tracing and
> stepping should be turned off for protecting init task before ptrace value
> is cleaned.
>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
> change for v2: remove _TIF_SINGLESTEP because of some architecture has not defined _TIF_SINGLESTEP such as mips.
>
> change for v3:
> Thanks for your reply and your patience. Let us discuss if the patch is useful to avoid kernel panic. In my x86 machine,
> I tested v5.4.18 kernel version, v5.15.67 kernel version and v6.1.0-rc1 kernel version.
> My test C codes include:
>   r[3] = 1;
>   syscall(__NR_ptrace, 0x4206, r[3], 0, 0);
>   syscall(__NR_ptrace, 0x4207, r[3]);
>   syscall(__NR_ptrace, 9, r[3], 0, 0);
> I tested while(1) loop and ctrl-c operation, fork and call ptrace syscall, loop 100 times syscalls and so on. The kernel will be in panic.
> For example in 5.4 kernel, trap signal is sent by two pathes:
> the one is:
> 	force_sig_info_to_task.cold+0x71/0x76
> 	force_sig_fault+0x63/0x80
> 	send_sigtrap+0x45/0x50
> 	do_debug+0x170/0x210
> 	debug+0x3f/0x60
> 	debug+0x53/0x60
> the other one is:
> 	force_sig_info_to_task.cold+0x84/0x8e
> 	force_sig_fault+0x63/0x80
> 	user_single_step_report+0x49/0x50
> 	syscall_slow_exit_work+0x75/0x150
> 	do_syscall_64+0x156/0x190
> 	entry_SYSCALL_64_after_hwframe+0x44/0xa9
> I debugged the sigtrap sending and get_signal function. When the debugger exits, the first sigtrap
> is prevent by SIGNAL_UNKILLABLE flag in get_signal function. Without my patch, the second sigtrap will be sent,
> and kernel will be in panic.
> I added my patch into the kernel:
> +	if (unlikely(child->signal->flags & SIGNAL_UNKILLABLE) &&
> +	    unlikely(task_thread_info(child)->flags & _TIF_SINGLESTEP))
> +		user_disable_single_step(child);
> I test the kernel with my patch, the kernel will not be in panic when I run my test program or ctrl-c the test program.
> So I think my patch is efficient to avoid kernel panic. You said:
> - debugger does ptrace(PTRACE_SINGLESTEP), this wakes the tracee up
> - the tracee enters force_sig_info_to_task(SIGTRAP) after single step
> - debugger exits, __ptrace_unlink() clears ptrace/TIF_SINGLESTEP
> - force_sig_info_to_task() clears SIGNAL_UNKILLABLE, the traced init will be killed.
>
> But run kernel with my patch, I can not find SIGTRAP signal without SIGNAL_UNKILLABLE flag for init task in get_signal function,
> so the kernel can not be in panic. Please let me verify my patch, I write a simple test, test.c includes
>   r[3] = 1;
>   syscall(__NR_ptrace, 0x4206, r[3], 0, 0);  /* ptrace(PTRACE_SEIZE, 1, NULL, 0) */
>   syscall(__NR_ptrace, 0x4207, r[3]);		/* ptrace(PTRACE_INTERRUPT, 1) */
>   syscall(__NR_ptrace, 9, r[3], 0, 0);		/* ptrace(PTRACE_SINGLESTEP, 1, NULL, 0) */
>   syscall(__NR_ptrace, 9, r[3], 0, 0);		/* ptrace(PTRACE_SINGLESTEP, 1, NULL, 0) */
>   sleep(10000);
> When test is sleeping, I will ctrl-c to stop the test. Do you think the traced init will be killed by SIGTRAP and my patch is unuseful?
> For verify my patch, I add three debug in the kernel of 6.1.0-rc1:
> 1. kernel/ptrace.c
> printk("user_disable_single_step will be called in __ptrace_unlink, child is %s, parent is %s, cpu is %d\n",
> child->comm, child->parent->comm, smp_processor_id());
> 2. kernel/signal.c
> bool get_signal(struct ksignal *ksig) {
> 	...
> 	/* Trace actually delivered signals. */
> 	trace_signal_deliver(signr, &ksig->info, ka);
> 	/* chen zhang add */
> 	if (current->pid == 1 && signr == 5) {
> 		printk("current->siganl->flags is 0x%x,current->parent is %s, ptrace is %d, cpu is %d in get_signal\n",
> 			current->signal->flags, current->parent->comm, current->ptrace, smp_processor_id());
> 		if (unlikely(signal->flags & SIGNAL_UNKILLABLE) &&
> 				!sig_kernel_only(signr))
> 			printk("flages is SIGNAL_UNKILLABLE in get_signal\n");
> 		else
> 			printk("SIGNAL_UNKILLABLE is clear in get_signal\n");
>
>
> 	}
> 	/* chen zhang add end */
> 	if (!signr)
> 		break; /* will return 0 */
> 	...
>
> }
> 3. kernel/signal.c
> static int
> force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
> 	enum sig_handler handler) {
> 	...
> 	/* chen zhang add */
> 	if (t->pid == 1 && sig == 5) {
> 		printk("init will send sigtrap in force_sig_info_to_task, ptrace is %d, parent is %s,"
> 			"regs eflags is 0x%lx, thread info flags is 0x%lx, cpu is %d\n",
> 			t->ptrace,t->parent->comm,task_pt_regs(t)->flags,
> 			task_thread_info(t)->flags,smp_processor_id());
> 	}
> 	/* chen zhang add end */
> 	if (action->sa.sa_handler == SIG_DFL &&
> 	    (!t->ptrace || (handler == HANDLER_EXIT))) {
> 	    	/* chen zhang add */
> 	    	printk("SIGNAL_UNKILLABLE will be clear in force_sig_info_to_task, pid is %d, sig is %d\n", t->pid, sig);
> 	    	/* chen zhang add end */
> 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
> 	}
> 	ret = send_signal_locked(sig, info, t, PIDTYPE_PID);
> 	...
> }
> I installed the debug kernel with my patch and run strace ./test, dmesg:
> [  768.416269] init will send sigtrap in force_sig_info_to_task, ptrace is 65537, parent is test,regs eflags is 0x306, thread info flags is 0x1000010, cpu is 1
> [  768.416288] init will send sigtrap in force_sig_info_to_task, ptrace is 65537, parent is test,regs eflags is 0x306, thread info flags is 0x1000010, cpu is 1
> After ctrl-c
> [  780.963530] user_disable_single_step will be called in __ptrace_unlink, child is systemd, parent is swapper/0, cpu is 5
> [  780.963580] current->siganl->flags is 0x40,current->parent is swapper/0, ptrace is 0, cpu is 6 in get_signal
> [  780.963583] flages is SIGNAL_UNKILLABLE in get_signal
>
> Kernel is not in panic. I also use orignal test program, it autogenerated by syzkaller. And it use fork and while(1) loop.
> When it run, the orignal kernel of v6.1.0-rc1 without my patch must be appear panic immediately.
> Now test my kernel, ./err_orig, run two minutes, then ctrl+c stop it, tail of dmesg:
> [ 1993.688471] user_disable_single_step will be called in __ptrace_unlink, child is systemd, parent is swapper/0, cpu is 0
> [ 1993.688514] current->siganl->flags is 0x40,current->parent is swapper/0, ptrace is 0, cpu is 7 in get_signal
> [ 1993.688516] flages is SIGNAL_UNKILLABLE in get_signal
> [ 1993.724130] init will send sigtrap in force_sig_info_to_task, ptrace is 65537, parent is err_orig,regs eflags is 0x306, thread info flags is 0x1000010, cpu is 1
> [ 1993.724299] user_disable_single_step will be called in __ptrace_unlink, child is systemd, parent is swapper/0, cpu is 5
> [ 1993.724367] current->siganl->flags is 0x40,current->parent is swapper/0, ptrace is 0, cpu is 2 in get_signal
> [ 1993.724372] flages is SIGNAL_UNKILLABLE in get_signal
>
> It seemed running well and no kernel panic happened, SIGNAL_UNKILLABLE flag always protected the init task. My patch disabled
> hardware debug on time and avoid many SIGTRIP signals to be created and sent. So my patch is useful and it can avoid kernel
> panic. At last I expect and welcome you review and verify my patch on your x86 machine. You can also give me a test case that
> can cause kernel panic, I will test it on my kernel. Thanks again!
>
> ---
>  kernel/ptrace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 54482193e1ed..e7c41154b31e 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -130,6 +130,9 @@ void __ptrace_unlink(struct task_struct *child)
>  	put_cred(old_cred);
>
>  	spin_lock(&child->sighand->siglock);
> +	if (unlikely(child->signal->flags & SIGNAL_UNKILLABLE) &&
> +	    unlikely(task_thread_info(child)->flags & _TIF_SINGLESTEP))
> +		user_disable_single_step(child);
>  	child->ptrace = 0;
>  	/*
>  	 * Clear all pending traps and TRAPPING.  TRAPPING should be
> --
> 2.25.1
>

