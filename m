Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD170C93A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjEVTqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjEVTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAECA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684784702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQTcGQmcdt/GFHUE9ukH1FXd2F7vXJA1Gm3R6PDU1zM=;
        b=Vf6XJi2+3XZ1tbypaqpgwqnuNj7mAKyG0/mVa1dZ3fZDexZZwKkfwdblyXJMffBwVKCzRj
        pePOrYuJ7kZ5gPfT+qkqIeK6sEhzIKK8DTFGX/NdiX8Gv3w9gmhjS++RtCufcnxkwH+9jO
        cinMq/CXvxqR3LoQXkstU5Lcd3lA9VI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-OXKKM7dENYmr0PTFeVcDdg-1; Mon, 22 May 2023 15:40:55 -0400
X-MC-Unique: OXKKM7dENYmr0PTFeVcDdg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3095bd1a05bso1298859f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784454; x=1687376454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQTcGQmcdt/GFHUE9ukH1FXd2F7vXJA1Gm3R6PDU1zM=;
        b=BAqBBNSWPFjq4d1BYZwzpng1IUoEJI0j0Hc2WFMB+4JSJvuqdYc023OCTZRvREMCly
         VWBC/vyu4Uy7xJMVPDy05J/SVCq6Qp0HSAFL4q1pBbPT4JgUvqOJCRapVlPXL5WH+UmG
         LkibdCH5kkGCdUqa1p1BqRPzwabv1xQK9J9IF89tC9PrepjgPibrme5Na4v9mHopZglU
         OpAJaAElAiMIljHSvgSjyw25T7Vg7ca7yp/67jc+KohMiwFI3Q73irw6+BdKYTuYvFbs
         +oEbtnLyKdTEBBHdb6LpmbUrUOLjVHhdwxj4KCYdvQ3Qqm4rdXczxOkRjIg/1jGP2cHs
         2TLg==
X-Gm-Message-State: AC+VfDwiOStZ06135+PkaRMK47v1ptqnpD/A1pRYcEXHJrd3WBjlsA7y
        ZcVF0qH7AeD4FHEJnaUMUM53HC1Em6pZvPy/3I2YzuqV2BURNrxFN5v40GDSq9reqTzsKnsQkg3
        egbsD92m9WIN73+v+mkCHuv60+KfCPd5K
X-Received: by 2002:a05:6000:1361:b0:306:2d3d:a108 with SMTP id q1-20020a056000136100b003062d3da108mr7896633wrz.11.1684784453736;
        Mon, 22 May 2023 12:40:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pr3vUykeXOoCgclaXz/IjxyFh9K2bggfSTJrWm5vv7kVYJaiW0GjtEaVvW2d4GickX43xpg==
X-Received: by 2002:a05:6000:1361:b0:306:2d3d:a108 with SMTP id q1-20020a056000136100b003062d3da108mr7896615wrz.11.1684784453346;
        Mon, 22 May 2023 12:40:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.68])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000104d00b0030632833e74sm8697842wrx.11.2023.05.22.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:40:52 -0700 (PDT)
Date:   Mon, 22 May 2023 15:40:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230522153852-mutt-send-email-mst@kernel.org>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522025124.5863-4-michael.christie@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 09:51:24PM -0500, Mike Christie wrote:
> When switching from kthreads to vhost_tasks two bugs were added:
> 1. The vhost worker tasks's now show up as processes so scripts doing ps
> or ps a would not incorrectly detect the vhost task as another process.
> 2. kthreads disabled freeze by setting PF_NOFREEZE, but vhost tasks's
> didn't disable or add support for them.
> 
> To fix both bugs, this switches the vhost task to be thread in the
> process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
> get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
> SIGKILL/STOP support is required because CLONE_THREAD requires
> CLONE_SIGHAND which requires those 2 signals to be suppported.
> 
> This a modified version of patch originally written by Linus which
> handles his review comment to himself to rename ignore_signals to
> block_signals to better represent what it now does. And it includes a
> change to vhost_worker() to support SIGSTOP/KILL and freeze, and it
> drops the wait use per Oleg's review comment that it's no longer needed
> when using CLONE_THREAD.
> 
> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c      | 17 ++++++++++++++++-
>  include/linux/sched/task.h |  2 +-
>  kernel/fork.c              | 12 +++---------
>  kernel/signal.c            |  1 +
>  kernel/vhost_task.c        | 16 ++++------------
>  5 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a92af08e7864..bf83e9340e40 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -338,6 +338,7 @@ static int vhost_worker(void *data)
>  	struct vhost_worker *worker = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
> +	bool dead = false;
>  
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
> @@ -349,8 +350,22 @@ static int vhost_worker(void *data)
>  		}
>  
>  		node = llist_del_all(&worker->work_list);
> -		if (!node)
> +		if (!node) {
>  			schedule();
> +			/*
> +			 * When we get a SIGKILL our release function will
> +			 * be called. That will stop new IOs from being queued
> +			 * and check for outstanding cmd responses. It will then
> +			 * call vhost_task_stop to tell us to return and exit.
> +			 */
> +			if (!dead && signal_pending(current)) {
> +				struct ksignal ksig;
> +
> +				dead = get_signal(&ksig);
> +				if (dead)
> +					clear_thread_flag(TIF_SIGPENDING);


Does get_signal actually return true only on SIGKILL then?

> +			}
> +		}
>  
>  		node = llist_reverse_order(node);
>  		/* make sure flag is seen after deletion */
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 537cbf9a2ade..249a5ece9def 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -29,7 +29,7 @@ struct kernel_clone_args {
>  	u32 io_thread:1;
>  	u32 user_worker:1;
>  	u32 no_files:1;
> -	u32 ignore_signals:1;
> +	u32 block_signals:1;
>  	unsigned long stack;
>  	unsigned long stack_size;
>  	unsigned long tls;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..9e04ab5c3946 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2338,14 +2338,10 @@ __latent_entropy struct task_struct *copy_process(
>  		p->flags |= PF_KTHREAD;
>  	if (args->user_worker)
>  		p->flags |= PF_USER_WORKER;
> -	if (args->io_thread) {
> -		/*
> -		 * Mark us an IO worker, and block any signal that isn't
> -		 * fatal or STOP
> -		 */
> +	if (args->io_thread)
>  		p->flags |= PF_IO_WORKER;
> +	if (args->block_signals)
>  		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> -	}
>  
>  	if (args->name)
>  		strscpy_pad(p->comm, args->name, sizeof(p->comm));
> @@ -2517,9 +2513,6 @@ __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_cleanup_io;
>  
> -	if (args->ignore_signals)
> -		ignore_signals(p);
> -
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {
> @@ -2861,6 +2854,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  		.fn_arg		= arg,
>  		.io_thread	= 1,
>  		.user_worker	= 1,
> +		.block_signals	= 1,
>  	};
>  
>  	return copy_process(NULL, 0, node, &args);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8050fe23c732..a0f00a078cbb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2891,6 +2891,7 @@ bool get_signal(struct ksignal *ksig)
>  
>  	return ksig->sig > 0;
>  }
> +EXPORT_SYMBOL_GPL(get_signal);

If you are exporting this, could you add documentation please?


>  /**
>   * signal_delivered - called after signal delivery to update blocked signals
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..7a2d7d9fe772 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -31,22 +31,13 @@ static int vhost_task_fn(void *data)
>   */
>  void vhost_task_stop(struct vhost_task *vtsk)
>  {
> -	pid_t pid = vtsk->task->pid;
> -
>  	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
>  	wake_up_process(vtsk->task);
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
> @@ -75,13 +66,14 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
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
> +		.block_signals	= 1,
>  	};
>  	struct vhost_task *vtsk;
>  	struct task_struct *tsk;
> -- 
> 2.25.1

