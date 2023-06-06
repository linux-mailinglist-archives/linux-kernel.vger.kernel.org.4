Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03E723435
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjFFA5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjFFA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:57:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF9102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:57:27 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33b36a9fdf8so22085875ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 17:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686013047; x=1688605047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dz3G9DrzQ6+mY/mhrhS6QSFdwnoHXrH6ZP5uaXRobUo=;
        b=Mm37RoKCFb+0pGbQDq6T9q+3UxrvLEeRenMwfTAap0hK3aUgvMwDG4QFzddtwQq4ac
         0YMZsCByZJrdieXXZR4TS44peQbPRcGhUzLEPa9T3O9yMiQlOMPQLcMDyRx9boqtbRUL
         MCJ7Wz0J3Zol4alRhgvN4o00F5+c5x9NE/vl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686013047; x=1688605047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz3G9DrzQ6+mY/mhrhS6QSFdwnoHXrH6ZP5uaXRobUo=;
        b=fI0l+kiAJlNkj4jD/9dleDkcdjvBK7q3Ke4aEg6/3s2+t9K/V4K/HSPd7z8Qr3s/v1
         YtacRoMvAPHuQQyhOjOZ0gjBfanXkBHX6d1lSgrtPYkusviOv1HTH+lgNBFW0xkWCZn3
         gKq1adip4pXFtibqCphv+eEEHhlh0yJCYKmzJkPbSgoNJOHSB54+2uIL2eZTP7nH6MwM
         Alaffw/JxuAEB9JM/zeW3NgnuN9DA5UuWUp65gyyo+QtLoKMbIX3pvR3Y3/JoTHNxZDz
         QEGTTEl7piLRa1kHW0aSQrfjI6FbXPFu6tuQWrLWMxhGSHOVk9hv+P61ua6/J1vIKZFs
         GTzQ==
X-Gm-Message-State: AC+VfDxyObrZbqLR98Hl9rRkBSzfP34KYgihtcMQqiqzuW5wvntTgZb8
        oPj6kgS8HN+BmS+UkKjJGbX3Ox6yK2F/V2+GniE=
X-Google-Smtp-Source: ACHHUZ5oRmFixNfzhceLZm8pkBWDrdW+zW0x/OHIPkB5L7tYB8mCUGPqBkXLBmyTaEqPBFVUKwKPXA==
X-Received: by 2002:a92:2802:0:b0:33a:56d6:d9a7 with SMTP id l2-20020a922802000000b0033a56d6d9a7mr816596ilf.19.1686013047345;
        Mon, 05 Jun 2023 17:57:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f25-20020aa782d9000000b0064d74808738sm5641884pfn.214.2023.06.05.17.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:57:26 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:57:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        chenhuacai@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] kthread: Unify kernel_thread() and user_mode_thread()
Message-ID: <202306051755.051BDBABB@keescook>
References: <20230603015302.1768127-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603015302.1768127-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 09:53:02AM +0800, Huacai Chen wrote:
> Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
> and umh") introduces a new function user_mode_thread() for init and umh.
> 
> init and umh are different from typical kernel threads since the don't
> need a "kthread" struct and they will finally become user processes by
> calling kernel_execve(), but on the other hand, they are also different
> from typical user mode threads (they have no "mm" structs at creation
> time, which is traditionally used to distinguish a user thread and a
> kernel thread).
> 
> So I think it is reasonable to treat init and umh as "special kernel
> threads". Then let's unify the kernel_thread() and user_mode_thread()
> to kernel_thread() again, and add a new 'user' parameter for init and
> umh.
> 
> This also makes code simpler. 
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> RFC -> V1: Update commit message and change "user" from int to bool.
> 
>  include/linux/sched/task.h |  3 +--
>  init/main.c                |  4 ++--
>  kernel/fork.c              | 20 ++------------------
>  kernel/kthread.c           |  2 +-
>  kernel/umh.c               |  6 +++---
>  5 files changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 537cbf9a2ade..02eb953bc809 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -98,8 +98,7 @@ struct task_struct *copy_process(struct pid *pid, int trace, int node,
>  struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
>  struct task_struct *fork_idle(int);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
> -			    unsigned long flags);
> -extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
> +			    unsigned long flags, bool user);

Please make this an enum not a bool, otherwise it's not obvious when
reading calling code what it means.

>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
>  int kernel_wait(pid_t pid, int *stat);
>  
> diff --git a/init/main.c b/init/main.c
> index af50044deed5..469cebbd35e0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -697,7 +697,7 @@ noinline void __ref __noreturn rest_init(void)
>  	 * the init task will end up wanting to create kthreads, which, if
>  	 * we schedule it before we create kthreadd, will OOPS.
>  	 */
> -	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);
> +	pid = kernel_thread(kernel_init, NULL, NULL, CLONE_FS, true);

i.e. instead of "true", if this said USER_MODE_THREAD, it would be
easier to under.

>  	/*
>  	 * Pin init on the boot CPU. Task migration is not properly working
>  	 * until sched_init_smp() has been run. It will set the allowed
> @@ -710,7 +710,7 @@ noinline void __ref __noreturn rest_init(void)
>  	rcu_read_unlock();
>  
>  	numa_default_policy();
> -	pid = kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILES);
> +	pid = kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILES, false);

And similarly, KERNEL_THREAD instead of "false".

-Kees

-- 
Kees Cook
