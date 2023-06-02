Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA42671F73C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjFBAni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFBAnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:43:35 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3998
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:43:30 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46364)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4st6-005nTy-E7; Thu, 01 Jun 2023 18:43:28 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42496 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q4st5-002xjg-0I; Thu, 01 Jun 2023 18:43:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
Date:   Thu, 01 Jun 2023 19:43:20 -0500
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com> (Mike
        Christie's message of "Thu, 1 Jun 2023 13:32:32 -0500")
Message-ID: <87fs7a8ziv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q4st5-002xjg-0I;;;mid=<87fs7a8ziv.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19gjFlb69o32ctZ8A+BQrp1h5U1revTqvs=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 770 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.45
        (0.2%), extract_message_metadata: 7 (1.0%), get_uri_detail_list: 4.4
        (0.6%), tests_pri_-2000: 4.4 (0.6%), tests_pri_-1000: 3.0 (0.4%),
        tests_pri_-950: 1.53 (0.2%), tests_pri_-900: 1.22 (0.2%),
        tests_pri_-200: 1.00 (0.1%), tests_pri_-100: 13 (1.7%), tests_pri_-90:
        115 (15.0%), check_bayes: 112 (14.5%), b_tokenize: 14 (1.8%),
        b_tok_get_all: 12 (1.6%), b_comp_prob: 3.9 (0.5%), b_tok_touch_all: 78
        (10.1%), b_finish: 1.14 (0.1%), tests_pri_0: 590 (76.6%),
        check_dkim_signature: 0.86 (0.1%), check_dkim_adsp: 3.5 (0.5%),
        poll_dns_idle: 1.16 (0.2%), tests_pri_10: 2.2 (0.3%), tests_pri_500: 8
        (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

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

Please see below for a race in that tidying up.

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



In just fixing the hang after exec I am afraid I may have introduced
something worse.

Two different sighand_struct's (and their associated locks) pointing
at the same signal_struct.  (Should be fixable?)

I am worried about what happens with that vhost task after an exec.
It retains it's existing cred (and technically the old mm) but shares
signal_struct so it might be possible to use permission checks against
the old vhost task cred to bypass permission checks on the new tasks
cred.  In particular for exec's that gain privilege.

It doesn't look like that is an issue for signals and suid exec as
kill_ok_by_cred seems to deliberately allow the same thing.


We may be ok but the way that vhost task remains after exec it smells
like the setup for a local privilege escalation.


Oleg do you have any insights?

Does anyone see why using the vhost task to modify the process should
not result in privilege escalation?


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

I am about to head off on vacation for a week or so, but I want to
add some comments before I go.


First moving set_current_state(TASK_INTERRUPTIBLE) here in the loop
won't work.  It introduces a race between vhost_work_queue and this wake
up.

Better would be to move the "if (!dead && signal_pending(current)) ..."
check up above "test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)"

Eric
