Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029296436A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiLEVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiLEVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:17:23 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6962BB23;
        Mon,  5 Dec 2022 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1670275040;
        bh=E/xyV8U24nd/vaCi3wVkaU0Zn3uE8TKj3J2Nc9PgcbM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iauDUWXrswxfHQrnQ5qZYI4tGiGslhFi2w1MfbWpptVSabM0BP7fziQ2UFn0XNUhE
         evcIdVaeSlAc2e9uFel2y9km93GmSrRSde3gMnXVYRilxovMrOC3WJkwYx5gihNpOY
         b9EyFnawIIz4VhPYTecc/n6G0iQGAKT1e7/tnX9IqP78OqFI/cQr+9ljIk5CnmsUIK
         Ej904knfN0L0CdAT/t3uobYnDBZkfaz1VQueeSgnpP9vB+bIFdohFOG5IROUSe7itq
         EqkWFSxn4QLSGmU1JPgRUPtzje4Dp3nB81GMnRx5tzM9tm5RLs8kklGsaQ542KAZba
         Tui3jYo45aKUg==
Received: from [172.16.0.118] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NQxFr2ySJzZ7j;
        Mon,  5 Dec 2022 16:17:20 -0500 (EST)
Message-ID: <fcb9026b-d65d-64eb-7080-40078ad75cf1@efficios.com>
Date:   Mon, 5 Dec 2022 16:17:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 02/11] tracing/user_events: Track fork/exec/exit for mm
 lifetime
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
 <20221205210017.23440-3-beaub@linux.microsoft.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221205210017.23440-3-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-05 16:00, Beau Belgrave wrote:
> During tracefs discussions it was decided instead of requiring a mapping
> within a user-process to track the lifetime of memory descriptors we
> should hook the appropriate calls. Do this by adding the minimal stubs
> required for task fork, exec, and exit. Currently this is just a NOP.
> Future patches will implement these calls fully.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>   fs/exec.c                   |  2 ++
>   include/linux/sched.h       |  5 +++++
>   include/linux/user_events.h | 16 +++++++++++++++-
>   kernel/exit.c               |  2 ++
>   kernel/fork.c               |  2 ++
>   5 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a0b1f0337a62..75ca6fbd195c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -64,6 +64,7 @@
>   #include <linux/io_uring.h>
>   #include <linux/syscall_user_dispatch.h>
>   #include <linux/coredump.h>
> +#include <linux/user_events.h>
>   
>   #include <linux/uaccess.h>
>   #include <asm/mmu_context.h>
> @@ -1842,6 +1843,7 @@ static int bprm_execve(struct linux_binprm *bprm,
>   	current->fs->in_exec = 0;
>   	current->in_execve = 0;
>   	rseq_execve(current);
> +	user_events_execve(current);
>   	acct_update_integrals(current);
>   	task_numa_free(current, false);
>   	return retval;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffb6eb55cd13..61ed2f9deb26 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -69,6 +69,7 @@ struct sighand_struct;
>   struct signal_struct;
>   struct task_delay_info;
>   struct task_group;
> +struct user_event_mm;
>   
>   /*
>    * Task state bitmask. NOTE! These bits are also
> @@ -1528,6 +1529,10 @@ struct task_struct {
>   	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
>   #endif
>   
> +#ifdef CONFIG_USER_EVENTS
> +	struct user_event_mm		*user_event_mm;
> +#endif
> +
>   	/*
>   	 * New fields for task_struct should be added above here, so that
>   	 * they are included in the randomized portion of task_struct.
> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> index 036b360f3d97..3d747c45d2fa 100644
> --- a/include/linux/user_events.h
> +++ b/include/linux/user_events.h
> @@ -12,7 +12,21 @@
>   #include <uapi/linux/user_events.h>
>   
>   #ifdef CONFIG_USER_EVENTS
> -#else
> +struct user_event_mm {
> +};
>   #endif
>   
> +static inline void user_events_fork(struct task_struct *t,
> +				    unsigned long clone_flags)
> +{
> +}
> +
> +static inline void user_events_execve(struct task_struct *t)
> +{
> +}
> +
> +static inline void user_events_exit(struct task_struct *t)
> +{
> +}
> +
>   #endif /* _LINUX_USER_EVENTS_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 35e0a31a0315..0bfadc26d278 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -67,6 +67,7 @@
>   #include <linux/io_uring.h>
>   #include <linux/kprobes.h>
>   #include <linux/rethook.h>
> +#include <linux/user_events.h>
>   
>   #include <linux/uaccess.h>
>   #include <asm/unistd.h>
> @@ -769,6 +770,7 @@ void __noreturn do_exit(long code)
>   
>   	coredump_task_exit(tsk);
>   	ptrace_event(PTRACE_EVENT_EXIT, code);
> +	user_events_exit(tsk);
>   
>   	validate_creds_for_do_exit(tsk);
>   
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 08969f5aa38d..a4be76276ccb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -97,6 +97,7 @@
>   #include <linux/scs.h>
>   #include <linux/io_uring.h>
>   #include <linux/bpf.h>
> +#include <linux/user_events.h>
>   
>   #include <asm/pgalloc.h>
>   #include <linux/uaccess.h>
> @@ -2487,6 +2488,7 @@ static __latent_entropy struct task_struct *copy_process(
>   
>   	trace_task_newtask(p, clone_flags);
>   	uprobe_copy_process(p, clone_flags);
> +	user_events_fork(p, clone_flags);
>   
>   	copy_oom_score_adj(clone_flags, p);
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

