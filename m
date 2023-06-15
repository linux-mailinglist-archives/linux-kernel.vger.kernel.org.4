Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571AA731835
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjFOMKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbjFOMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22680184
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E6D614A1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC32C433CB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686830993;
        bh=NROSRPyXYVK/aojYX57hBeP9mIw5eeK87deVoNWG6GU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C12D8dxeah/03p6BoorZ+5WhYpmY1zWV8dO6x/tmbcJQwPant6gu/3Cc3RU33jL0Q
         z8pOdD0ZC5ttTadaMN4HNBK2VxfY+wsGAwanV7L0h5+URbi6aR9uxwBr0BBQBnaCT6
         3GP9GoJaTT6+GSSJcWXuTpZzA6hBYOYrAShPmUFHE05LwjD2Yj1lNtpbwBwiuI9jMs
         y5CRsmsR1StMhd1sHTriPehT1l7I8GR0fRCA+YsAp3WSA2vYALNQ4L60FuT0teeP/F
         V6UMbguvruZn+RvTri5C/dfSVG+1Stg8CNbOgeDGNMNOwqAqAhoIt5ODrJln5rljlQ
         ss0qquRQO05rw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so2030312a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:09:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDzb18Z9RBqUTEnXfOci4OBXbPvoS8ixeuqmo3Ngcc5O3FqI0lH+
        0uVubPMUXjW2FMdkWEGGu3SDcdRdAmfD1U8YCbc=
X-Google-Smtp-Source: ACHHUZ59ovbASEXTdy88fPdbBm0+yJPNtgpBjw/5UaMIYzZpQ4W4XjZbqyhDcqp2HPvHEtFZhshxksly9x9hDoBQEuw=
X-Received: by 2002:a05:6402:1847:b0:514:9e2c:90c6 with SMTP id
 v7-20020a056402184700b005149e2c90c6mr10645668edy.38.1686830991054; Thu, 15
 Jun 2023 05:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230603015302.1768127-1-chenhuacai@loongson.cn>
In-Reply-To: <20230603015302.1768127-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 15 Jun 2023 20:09:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6T8Yf=qV+_tpPOT5GpaJB58Rpd18TwBar-=m_3A71qFA@mail.gmail.com>
Message-ID: <CAAhV-H6T8Yf=qV+_tpPOT5GpaJB58Rpd18TwBar-=m_3A71qFA@mail.gmail.com>
Subject: Re: [PATCH V1] kthread: Unify kernel_thread() and user_mode_thread()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I'm very sorry for wasting so much of your time. Although this patch
has dropped, I still agree with Andrews' comment "But the naming isn't
very good anyway.  Should have been usermode_thread/kernel_thread or
user_thread/kernel_thread.". And since Eric describes init and umh as
"user threads run in kernel mode", I want to rename user_mode_thread()
as kmuser_thread(), which is a little better than just user_thread().


Huacai

On Sat, Jun 3, 2023 at 9:53=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn>=
 wrote:
>
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
> @@ -98,8 +98,7 @@ struct task_struct *copy_process(struct pid *pid, int t=
race, int node,
>  struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int n=
ode);
>  struct task_struct *fork_idle(int);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *nam=
e,
> -                           unsigned long flags);
> -extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned lon=
g flags);
> +                           unsigned long flags, bool user);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
>  int kernel_wait(pid_t pid, int *stat);
>
> diff --git a/init/main.c b/init/main.c
> index af50044deed5..469cebbd35e0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -697,7 +697,7 @@ noinline void __ref __noreturn rest_init(void)
>          * the init task will end up wanting to create kthreads, which, i=
f
>          * we schedule it before we create kthreadd, will OOPS.
>          */
> -       pid =3D user_mode_thread(kernel_init, NULL, CLONE_FS);
> +       pid =3D kernel_thread(kernel_init, NULL, NULL, CLONE_FS, true);
>         /*
>          * Pin init on the boot CPU. Task migration is not properly worki=
ng
>          * until sched_init_smp() has been run. It will set the allowed
> @@ -710,7 +710,7 @@ noinline void __ref __noreturn rest_init(void)
>         rcu_read_unlock();
>
>         numa_default_policy();
> -       pid =3D kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILE=
S);
> +       pid =3D kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILE=
S, false);
>         rcu_read_lock();
>         kthreadd_task =3D find_task_by_pid_ns(pid, &init_pid_ns);
>         rcu_read_unlock();
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..f91696904252 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2965,7 +2965,7 @@ pid_t kernel_clone(struct kernel_clone_args *args)
>   * Create a kernel thread.
>   */
>  pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
> -                   unsigned long flags)
> +                   unsigned long flags, bool user)
>  {
>         struct kernel_clone_args args =3D {
>                 .flags          =3D ((lower_32_bits(flags) | CLONE_VM |
> @@ -2974,23 +2974,7 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, =
const char *name,
>                 .fn             =3D fn,
>                 .fn_arg         =3D arg,
>                 .name           =3D name,
> -               .kthread        =3D 1,
> -       };
> -
> -       return kernel_clone(&args);
> -}
> -
> -/*
> - * Create a user mode thread.
> - */
> -pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags=
)
> -{
> -       struct kernel_clone_args args =3D {
> -               .flags          =3D ((lower_32_bits(flags) | CLONE_VM |
> -                                   CLONE_UNTRACED) & ~CSIGNAL),
> -               .exit_signal    =3D (lower_32_bits(flags) & CSIGNAL),
> -               .fn             =3D fn,
> -               .fn_arg         =3D arg,
> +               .kthread        =3D !user,
>         };
>
>         return kernel_clone(&args);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 490792b1066e..5f025569eb38 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -400,7 +400,7 @@ static void create_kthread(struct kthread_create_info=
 *create)
>  #endif
>         /* We want our own signal handler (we take no signals by default)=
. */
>         pid =3D kernel_thread(kthread, create, create->full_name,
> -                           CLONE_FS | CLONE_FILES | SIGCHLD);
> +                           CLONE_FS | CLONE_FILES | SIGCHLD, false);
>         if (pid < 0) {
>                 /* Release the structure when caller killed by a fatal si=
gnal. */
>                 struct completion *done =3D xchg(&create->done, NULL);
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 60aa9e764a38..b0ead7cce761 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -130,7 +130,7 @@ static void call_usermodehelper_exec_sync(struct subp=
rocess_info *sub_info)
>
>         /* If SIGCLD is ignored do_wait won't populate the status. */
>         kernel_sigaction(SIGCHLD, SIG_DFL);
> -       pid =3D user_mode_thread(call_usermodehelper_exec_async, sub_info=
, SIGCHLD);
> +       pid =3D kernel_thread(call_usermodehelper_exec_async, sub_info, N=
ULL, SIGCHLD, true);
>         if (pid < 0)
>                 sub_info->retval =3D pid;
>         else
> @@ -169,8 +169,8 @@ static void call_usermodehelper_exec_work(struct work=
_struct *work)
>                  * want to pollute current->children, and we need a paren=
t
>                  * that always ignores SIGCHLD to ensure auto-reaping.
>                  */
> -               pid =3D user_mode_thread(call_usermodehelper_exec_async, =
sub_info,
> -                                      CLONE_PARENT | SIGCHLD);
> +               pid =3D kernel_thread(call_usermodehelper_exec_async, sub=
_info,
> +                                      NULL, CLONE_PARENT | SIGCHLD, true=
);
>                 if (pid < 0) {
>                         sub_info->retval =3D pid;
>                         umh_complete(sub_info);
> --
> 2.39.1
>
