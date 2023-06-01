Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57AD71F2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjFATML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFATMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF0107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685646683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPROO+BMdoWhYdvZQA+k8C1jtc23e9qFRrEtKqqUhLs=;
        b=TdW40fj1bg8OSSD11fdsRTgBNIYVvrxw7HCUiUIakniLt+KwOLGgKvq0KfSI7GreOs96mU
        kcF1WK33/dejaYc5vrdl9uZ47WrXchdN7G0cgJy4oQ1Tq+MDvwUA2wJk/tEfcTq1L7Hyzm
        mHBf5SAYOUBg6wYhhc/ljC+vDVilpR8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-IJ2dHgMoPQ6mIkwsiB6clQ-1; Thu, 01 Jun 2023 15:11:08 -0400
X-MC-Unique: IJ2dHgMoPQ6mIkwsiB6clQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30c2e9541b9so730392f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 12:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685646667; x=1688238667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPROO+BMdoWhYdvZQA+k8C1jtc23e9qFRrEtKqqUhLs=;
        b=GdrAQzCBcxhKgLNqYm4UekHeJ817zcrp4iUsj/IeycOsz8FoYFu445yhPFaePDvGCq
         s/6IH+HWHbo/G/JvCbvaBAuYDCsNum5qwoIK1adkHn+KCgsLAXqbDD04NRO7TdOb2kaP
         UDdnpMPHkasOahQA4dQzqXKs63Vrp2tGHJ93aW0yKLXN3kcieWfkXaYDra1IwcRmGEHr
         lC8hvoCYoIJPs65bmXuIp2JGi4KkFeeSKHyv2jFApT1oMVB5COSCf+LZ+jvyriUlSMzJ
         3Zi2XImeQBqo1aQXWGdGALIRWOqv65QgFPag6eFS5TZWih4ul1mkqBHHO8XOkK6FPscs
         z51A==
X-Gm-Message-State: AC+VfDzaVmvpjhEcUrswWd4voU/vjyJTjj84uH9ANFiicrngjkoebUuo
        djP7Ak2XSIxAtyaa74xrYfFYvJeUk6f/0VGPSfkKcPSWdv3/gnArvjKLyzltzYFAW68X2xPdaQa
        wotbH+pkkxXi3uWHa7YesA25s
X-Received: by 2002:adf:e382:0:b0:2ef:b052:1296 with SMTP id e2-20020adfe382000000b002efb0521296mr2897300wrm.22.1685646666941;
        Thu, 01 Jun 2023 12:11:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ym5/5TsSdG0avU/DkhrpvtkP75LaKok4wo591G0O+XTUR5q+R3aVyTtcSVe4EgGnw0U/kYg==
X-Received: by 2002:adf:e382:0:b0:2ef:b052:1296 with SMTP id e2-20020adfe382000000b002efb0521296mr2897280wrm.22.1685646666471;
        Thu, 01 Jun 2023 12:11:06 -0700 (PDT)
Received: from redhat.com ([2.55.41.2])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d440e000000b002e5ff05765esm11191759wrq.73.2023.06.01.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 12:11:05 -0700 (PDT)
Date:   Thu, 1 Jun 2023 15:11:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230601151034-mutt-send-email-mst@kernel.org>
References: <20230601183232.8384-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:32:32PM -0500, Mike Christie wrote:
> When switching from kthreads to vhost_tasks two bugs were added:
> 1. The vhost worker tasks's now show up as processes so scripts doing
> ps or ps a would not incorrectly detect the vhost task as another
> process.  2. kthreads disabled freeze by setting PF_NOFREEZE, but
> vhost tasks's didn't disable or add support for them.
> 
> To fix both bugs, this switches the vhost task to be thread in the
> process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
> get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
> SIGKILL/STOP support is required because CLONE_THREAD requires
> CLONE_SIGHAND which requires those 2 signals to be supported.
> 
> This is a modified version of the patch written by Mike Christie
> <michael.christie@oracle.com> which was a modified version of patch
> originally written by Linus.
> 
> Much of what depended upon PF_IO_WORKER now depends on PF_USER_WORKER.
> Including ignoring signals, setting up the register state, and having
> get_signal return instead of calling do_group_exit.
> 
> Tidied up the vhost_task abstraction so that the definition of
> vhost_task only needs to be visible inside of vhost_task.c.  Making
> it easier to review the code and tell what needs to be done where.
> As part of this the main loop has been moved from vhost_worker into
> vhost_task_fn.  vhost_worker now returns true if work was done.
> 
> The main loop has been updated to call get_signal which handles
> SIGSTOP, freezing, and collects the message that tells the thread to
> exit as part of process exit.  This collection clears
> __fatal_signal_pending.  This collection is not guaranteed to
> clear signal_pending() so clear that explicitly so the schedule()
> sleeps.
> 
> For now the vhost thread continues to exist and run work until the
> last file descriptor is closed and the release function is called as
> part of freeing struct file.  To avoid hangs in the coredump
> rendezvous and when killing threads in a multi-threaded exec.  The
> coredump code and de_thread have been modified to ignore vhost threads.
> 
> Remvoing the special case for exec appears to require teaching
> vhost_dev_flush how to directly complete transactions in case
> the vhost thread is no longer running.
> 
> Removing the special case for coredump rendezvous requires either the
> above fix needed for exec or moving the coredump rendezvous into
> get_signal.
> 
> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Co-developed-by: Mike Christie <michael.christie@oracle.com>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  arch/x86/include/asm/fpu/sched.h |  2 +-
>  arch/x86/kernel/fpu/context.h    |  2 +-
>  arch/x86/kernel/fpu/core.c       |  2 +-
>  drivers/vhost/vhost.c            | 22 ++------
>  fs/coredump.c                    |  4 +-
>  include/linux/sched/task.h       |  1 -
>  include/linux/sched/vhost_task.h | 15 ++----
>  kernel/exit.c                    |  5 +-
>  kernel/fork.c                    | 13 ++---
>  kernel/signal.c                  |  8 +--
>  kernel/vhost_task.c              | 92 +++++++++++++++++++++-----------
>  11 files changed, 89 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
> index c2d6cd78ed0c..78fcde7b1f07 100644
> --- a/arch/x86/include/asm/fpu/sched.h
> +++ b/arch/x86/include/asm/fpu/sched.h
> @@ -39,7 +39,7 @@ extern void fpu_flush_thread(void);
>  static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
>  {
>  	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
> -	    !(current->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> +	    !(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		save_fpregs_to_fpstate(old_fpu);
>  		/*
>  		 * The save operation preserved register state, so the
> diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
> index 9fcfa5c4dad7..af5cbdd9bd29 100644
> --- a/arch/x86/kernel/fpu/context.h
> +++ b/arch/x86/kernel/fpu/context.h
> @@ -57,7 +57,7 @@ static inline void fpregs_restore_userregs(void)
>  	struct fpu *fpu = &current->thread.fpu;
>  	int cpu = smp_processor_id();
>  
> -	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_IO_WORKER)))
> +	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
>  		return;
>  
>  	if (!fpregs_state_valid(fpu, cpu)) {
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index caf33486dc5e..1015af1ae562 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -426,7 +426,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  
>  	this_cpu_write(in_kernel_fpu, true);
>  
> -	if (!(current->flags & (PF_KTHREAD | PF_IO_WORKER)) &&
> +	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
>  	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>  		set_thread_flag(TIF_NEED_FPU_LOAD);
>  		save_fpregs_to_fpstate(&current->thread.fpu);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a92af08e7864..074273020849 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->vtsk->task);
> +		vhost_task_wake(dev->worker->vtsk);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vhost_work_queue);
> @@ -333,31 +333,19 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  	__vhost_vq_meta_reset(vq);
>  }
>  
> -static int vhost_worker(void *data)
> +static bool vhost_worker(void *data)
>  {
>  	struct vhost_worker *worker = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> -	for (;;) {
> -		/* mb paired w/ kthread_stop */
> -		set_current_state(TASK_INTERRUPTIBLE);
> -
> -		if (vhost_task_should_stop(worker->vtsk)) {
> -			__set_current_state(TASK_RUNNING);
> -			break;
> -		}
> -
> -		node = llist_del_all(&worker->work_list);
> -		if (!node)
> -			schedule();
> -
> +	node = llist_del_all(&worker->work_list);
> +	if (node) {
>  		node = llist_reverse_order(node);
>  		/* make sure flag is seen after deletion */
>  		smp_wmb();
>  		llist_for_each_entry_safe(work, work_next, node, node) {
>  			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> -			__set_current_state(TASK_RUNNING);
>  			kcov_remote_start_common(worker->kcov_handle);
>  			work->fn(work);
>  			kcov_remote_stop();
> @@ -365,7 +353,7 @@ static int vhost_worker(void *data)
>  		}
>  	}
>  
> -	return 0;
> +	return !!node;
>  }
>  
>  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> diff --git a/fs/coredump.c b/fs/coredump.c
> index ece7badf701b..88740c51b942 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -371,7 +371,9 @@ static int zap_process(struct task_struct *start, int exit_code)
>  		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
>  			sigaddset(&t->pending.signal, SIGKILL);
>  			signal_wake_up(t, 1);
> -			nr++;
> +			/* The vhost_worker does not particpate in coredumps */
> +			if ((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)
> +				nr++;
>  		}
>  	}
>  
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 537cbf9a2ade..e0f5ac90a228 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -29,7 +29,6 @@ struct kernel_clone_args {
>  	u32 io_thread:1;
>  	u32 user_worker:1;
>  	u32 no_files:1;
> -	u32 ignore_signals:1;
>  	unsigned long stack;
>  	unsigned long stack_size;
>  	unsigned long tls;
> diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
> index 6123c10b99cf..837a23624a66 100644
> --- a/include/linux/sched/vhost_task.h
> +++ b/include/linux/sched/vhost_task.h
> @@ -2,22 +2,13 @@
>  #ifndef _LINUX_VHOST_TASK_H
>  #define _LINUX_VHOST_TASK_H
>  
> -#include <linux/completion.h>
>  
> -struct task_struct;
> +struct vhost_task;
>  
> -struct vhost_task {
> -	int (*fn)(void *data);
> -	void *data;
> -	struct completion exited;
> -	unsigned long flags;
> -	struct task_struct *task;
> -};
> -
> -struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
> +struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
>  				     const char *name);
>  void vhost_task_start(struct vhost_task *vtsk);
>  void vhost_task_stop(struct vhost_task *vtsk);
> -bool vhost_task_should_stop(struct vhost_task *vtsk);
> +void vhost_task_wake(struct vhost_task *vtsk);
>  
>  #endif
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 34b90e2e7cf7..edb50b4c9972 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -411,7 +411,10 @@ static void coredump_task_exit(struct task_struct *tsk)
>  	tsk->flags |= PF_POSTCOREDUMP;
>  	core_state = tsk->signal->core_state;
>  	spin_unlock_irq(&tsk->sighand->siglock);
> -	if (core_state) {
> +
> +	/* The vhost_worker does not particpate in coredumps */
> +	if (core_state &&
> +	    ((tsk->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)) {
>  		struct core_thread self;
>  
>  		self.task = current;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..81cba91f30bb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2336,16 +2336,16 @@ __latent_entropy struct task_struct *copy_process(
>  	p->flags &= ~PF_KTHREAD;
>  	if (args->kthread)
>  		p->flags |= PF_KTHREAD;
> -	if (args->user_worker)
> -		p->flags |= PF_USER_WORKER;
> -	if (args->io_thread) {
> +	if (args->user_worker) {
>  		/*
> -		 * Mark us an IO worker, and block any signal that isn't
> +		 * Mark us a user worker, and block any signal that isn't
>  		 * fatal or STOP
>  		 */
> -		p->flags |= PF_IO_WORKER;
> +		p->flags |= PF_USER_WORKER;
>  		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>  	}
> +	if (args->io_thread)
> +		p->flags |= PF_IO_WORKER;
>  
>  	if (args->name)
>  		strscpy_pad(p->comm, args->name, sizeof(p->comm));
> @@ -2517,9 +2517,6 @@ __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_cleanup_io;
>  
> -	if (args->ignore_signals)
> -		ignore_signals(p);
> -
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..2547fa73bde5 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1368,7 +1368,9 @@ int zap_other_threads(struct task_struct *p)
>  
>  	while_each_thread(p, t) {
>  		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> -		count++;
> +		/* Don't require de_thread to wait for the vhost_worker */
> +		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
> +			count++;
>  
>  		/* Don't bother with already dead threads */
>  		if (t->exit_state)
> @@ -2861,11 +2863,11 @@ bool get_signal(struct ksignal *ksig)
>  		}
>  
>  		/*
> -		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * PF_USER_WORKER threads will catch and exit on fatal signals
>  		 * themselves. They have cleanup that must be performed, so
>  		 * we cannot call do_exit() on their behalf.
>  		 */
> -		if (current->flags & PF_IO_WORKER)
> +		if (current->flags & PF_USER_WORKER)
>  			goto out;
>  
>  		/*
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..f80d5c51ae67 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -12,58 +12,88 @@ enum vhost_task_flags {
>  	VHOST_TASK_FLAGS_STOP,
>  };
>  
> +struct vhost_task {
> +	bool (*fn)(void *data);
> +	void *data;
> +	struct completion exited;
> +	unsigned long flags;
> +	struct task_struct *task;
> +};
> +
>  static int vhost_task_fn(void *data)
>  {
>  	struct vhost_task *vtsk = data;
> -	int ret;
> +	bool dead = false;
> +
> +	for (;;) {
> +		bool did_work;
> +
> +		/* mb paired w/ vhost_task_stop */
> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
> +			break;
> +
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal will block in SIGSTOP,
> +			 * or clear fatal_signal_pending, but remember
> +			 * what was set.
> +			 *
> +			 * This thread won't actually exit until all
> +			 * of the file descriptors are closed, and
> +			 * the release function is called.
> +			 */
> +			dead = get_signal(&ksig);
> +			if (dead)
> +				clear_thread_flag(TIF_SIGPENDING);
> +		}
> +
> +		did_work = vtsk->fn(vtsk->data);
> +		if (!did_work) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule();
> +		}
> +	}
>  
> -	ret = vtsk->fn(vtsk->data);
>  	complete(&vtsk->exited);
> -	do_exit(ret);
> +	do_exit(0);
> +}
> +
> +/**
> + * vhost_task_wake - wakeup the vhost_task
> + * @vtsk: vhost_task to wake
> + *
> + * wake up the vhost_task worker thread
> + */
> +void vhost_task_wake(struct vhost_task *vtsk)
> +{
> +	wake_up_process(vtsk->task);
>  }
> +EXPORT_SYMBOL_GPL(vhost_task_wake);
>  
>  /**
>   * vhost_task_stop - stop a vhost_task
>   * @vtsk: vhost_task to stop
>   *
> - * Callers must call vhost_task_should_stop and return from their worker
> - * function when it returns true;
> + * vhost_task_fn ensures the worker thread exits after
> + * VHOST_TASK_FLAGS_SOP becomes true.
>   */
>  void vhost_task_stop(struct vhost_task *vtsk)
>  {
> -	pid_t pid = vtsk->task->pid;
> -
>  	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
> -	wake_up_process(vtsk->task);
> +	vhost_task_wake(vtsk);
>  	/*
>  	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
> -	 * freeing it below. If userspace crashed or exited without closing,
> -	 * then the vhost_task->task could already be marked dead so
> -	 * kernel_wait will return early.
> +	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> -	/*
> -	 * If we are just closing/removing a device and the parent process is
> -	 * not exiting then reap the task.
> -	 */
> -	kernel_wait4(pid, NULL, __WCLONE, NULL);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
>  
>  /**
> - * vhost_task_should_stop - should the vhost task return from the work function
> - * @vtsk: vhost_task to stop
> - */
> -bool vhost_task_should_stop(struct vhost_task *vtsk)
> -{
> -	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
> -}
> -EXPORT_SYMBOL_GPL(vhost_task_should_stop);
> -
> -/**
> - * vhost_task_create - create a copy of a process to be used by the kernel
> - * @fn: thread stack
> + * vhost_task_create - create a copy of a task to be used by the kernel
> + * @fn: vhost worker function
>   * @arg: data to be passed to fn
>   * @name: the thread's name
>   *
> @@ -71,17 +101,17 @@ EXPORT_SYMBOL_GPL(vhost_task_should_stop);
>   * failure. The returned task is inactive, and the caller must fire it up
>   * through vhost_task_start().
>   */
> -struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
> +struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
>  				     const char *name)
>  {
>  	struct kernel_clone_args args = {
> -		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
> +		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
> +				  CLONE_THREAD | CLONE_SIGHAND,
>  		.exit_signal	= 0,
>  		.fn		= vhost_task_fn,
>  		.name		= name,
>  		.user_worker	= 1,
>  		.no_files	= 1,
> -		.ignore_signals	= 1,
>  	};
>  	struct vhost_task *vtsk;
>  	struct task_struct *tsk;
> -- 
> 2.25.1

