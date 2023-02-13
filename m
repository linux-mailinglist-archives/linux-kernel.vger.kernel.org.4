Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2196951D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBMU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjBMU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:26:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2FC7;
        Mon, 13 Feb 2023 12:26:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676319982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPG9ZQQgR/sLK47tvxG7uyWDdzTOW/u630H38kMxtME=;
        b=H0ej11Jxh1HPHMiV2nizNqJjcDFBJVFfStm5e2kCZkexgW/CvrSGm9tfy4uEXpkCwzUhjW
        xSM+eONMStY/5Je4oPSeMmkchfrabopIwaThW5jA2V+MpNLe7mdjwfGCq6BSgUnVVnjEKS
        hYXSo3MmgAHwRd2wNXBFWC6FlCqWT5UyBY+NjGPJht+I+/5dPthHvUpW+atNkip3+y/Smc
        2CmlDZM1Yth28Drr+mtiCIJLCt7LpjAiHl4BSHJnE+swwRNyvox2BqMpsIgSkeW2JBgJQU
        0VsrkNn/uB3nQ4N6X4WJMiZe9yzZzqz2xzTge8qSQO8H5JzY1sNq/qSMuHR2fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676319982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPG9ZQQgR/sLK47tvxG7uyWDdzTOW/u630H38kMxtME=;
        b=/BhFKb6qiS/384IJt9F2ASpmt7uxn6ArbN9h692kPs9aHIz9Z1KuUVUqztvT8V1UCv6d5+
        lz9MY+R6iD6c9lDA==
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v9 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
In-Reply-To: <20230210072503.1808-2-gregory.price@memverge.com>
References: <20230210072503.1808-1-gregory.price@memverge.com>
 <20230210072503.1808-2-gregory.price@memverge.com>
Date:   Mon, 13 Feb 2023 21:26:21 +0100
Message-ID: <871qmttiqa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10 2023 at 02:25, Gregory Price wrote:
>  
>  As the ABI of these intercepted syscalls is unknown to Linux, these
> -syscalls are not instrumentable via ptrace or the syscall tracepoints.
> +syscalls are not instrumentable via ptrace or the syscall tracepoints,
> +however an interfaces to suspend, checkpoint, and restore syscall user
> +dispatch configuration has been added to ptrace to assist userland
> +checkpoint/restart software.

The above is incomprehensible word salad to me. Once the ptrace
functions are there then they can be used independent of CRIU, no?

> + * struct ptrace_sud_config - Per-task configuration for SUD
> + * @mode:	One of PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF
> + * @selector:	Tracee's user virtual address of SUD selector
> + * @offset:	SUD exclusion area (virtual address)
> + * @len:	Length of SUD exclusion area
> + *
> + * Used to get/set the syscall user dispatch configuration for tracee.
> + * process.  Selector is optional (may be NULL), and if invalid will produce
> + * a SIGSEGV in the tracee upon first access.
> + *
> + * If mode is PR_SYS_DISPATCH_ON, syscall dispatch will be enabled. If
> + * PR_SYS_DISPATCH_OFF, syscall dispatch will be disabled and all other
> + * parameters must be 0.  The value in *selector (if not null), also determines
> + * whether syscall dispatch will occur.
> + *
> + * The SUD Exclusion area described by offset/len is the virtual address space
> + * from which syscalls will not produce a user dispatch.
> + */
> +struct ptrace_sud_config {
> +	__u64 mode;
> +	__s8 *selector;

How is this correct for a 32bit ptracer running on a 64bit kernel? Aside
of not wiring up the compat syscall without any argumentation in the
changelog.


> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c

This section:

> -int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
> -			      unsigned long len, char __user *selector)
> +static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
> +		                          unsigned long offset, unsigned long len,
> +		                          char __user *selector)
>  {
>  	switch (mode) {
>  	case PR_SYS_DISPATCH_OFF:
> @@ -94,15 +96,60 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
>  		return -EINVAL;
>  	}
>  
> -	current->syscall_dispatch.selector = selector;
> -	current->syscall_dispatch.offset = offset;
> -	current->syscall_dispatch.len = len;
> -	current->syscall_dispatch.on_dispatch = false;
> +	task->syscall_dispatch.selector = selector;
> +	task->syscall_dispatch.offset = offset;
> +	task->syscall_dispatch.len = len;
> +	task->syscall_dispatch.on_dispatch = false;
>  
>  	if (mode == PR_SYS_DISPATCH_ON)
> -		set_syscall_work(SYSCALL_USER_DISPATCH);
> +		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
>  	else
> -		clear_syscall_work(SYSCALL_USER_DISPATCH);
> +		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
>  
>  	return 0;
>  }
> +
> +int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
> +		              unsigned long len, char __user *selector)
> +{
> +	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
> +}

until here want's to be a seperate preparatory patch.

> +++ b/tools/testing/selftests/ptrace/get_set_sud.c
> +	child = fork();
> +	ASSERT_GE(child, 0);
> +	if (child == 0) {
> +		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
> +			TH_LOG("PTRACE_TRACEME: %m");
> +		}
> +		kill(getpid(), SIGSTOP);
> +		sleep(2);

The purpose of this sleep is what?

> +		_exit(1);
> +	}
> +
> +	waitpid(child, &status, 0);
> +
> +	config.mode = PR_SYS_DISPATCH_ON;
> +	config.selector = (void*)0xDEADBEEF;
> +	config.offset = 0x12345678;
> +	config.len = 0x87654321;

What's the purpose of these magic numbers? memset(&config, 0xff,...) is
sufficient, no?

Thanks,

        tglx
