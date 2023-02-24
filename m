Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051596A17CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBXISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBXISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:18:11 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F013529;
        Fri, 24 Feb 2023 00:18:09 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id b5so2246541iow.0;
        Fri, 24 Feb 2023 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O0ngU5kfJKxMYZFBd+7WXjjgrm7mINfk+g1OE6PGkNw=;
        b=juyQhWTkOySr/EdhXTXw0uQdF8kVaOzrtUeaH7yY7M6zf1AEu10smfDCdKgUDooeJA
         drqAgRRPNKdFRJLBakxny9P/0HxNuy7DFGBdt8GBg6zdO5eADPmSjyPo2FWnGApn2Ewp
         Hu7IcPlSSxcqeT6B/gfP7esDGhVgxRpnMDB3HDFHLFNlcc8q0FbDWBZrwdQHUoKjMc3/
         zjgJbBgD/hZ8ussa5VvU+3asesbQR77NVJXnuMTx/55VnEBXTpJuJYtUP9FPY6mHbYX2
         e9hu+Vn5H+6kHRG8X5FQ15PYpwn7Kqas6oBHRJRI+XnFgeX3mURWfmv9tE+Z1tm3jPSm
         2tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0ngU5kfJKxMYZFBd+7WXjjgrm7mINfk+g1OE6PGkNw=;
        b=i/JMzO6TXIQF/3s2DcW3BlYfpU3+MLJqQruRMzL3eoTODUFzoKJeVtHX82TH4Q4D7t
         DzbhaqRtaJLONIUyTiK00CuqoAqJ+j4FNYJCLWRvTva3hsgVEoBpRZP5dEC4oPHoOlhj
         A4JX2vYMgvXz/UfpkPOfYDMTZNWGcNb8oP8Cc5xOmM/lUEY6/w/UW43kL4J2F0Mwb5FJ
         s4HfjBHaNksaHORt7QT4gtAPfK4bSg5sGWNF5IU/E9iXeQV5EIrK8i+DOYvb/sfIV7VW
         draDSHkAqCqDd8zpHHl4aXa132FxFFVZFfeAWpcxnoQQNkmmfyn/CFO27OySbQPDOFmq
         STqA==
X-Gm-Message-State: AO0yUKWC3cUA5+QcNFbIGqS0+59fZH2eUncpla87aJKk+JmwSWH4NN4T
        2SrbY/7vq3BhfqNtQueokhisIbdSbuTYVAh2UnM=
X-Google-Smtp-Source: AK7set8Jq6plJbbrBmatQWDPxsz0GV823XNOEt52m+0mf8yWNEVK00R+UGnjbQjEdlzrpO+Iau02uUa8QqrmmEH9I1Q=
X-Received: by 2002:a05:6638:1342:b0:3c2:c1c9:8bca with SMTP id
 u2-20020a056638134200b003c2c1c98bcamr6370686jad.2.1677226688551; Fri, 24 Feb
 2023 00:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20230221201740.2236-1-gregory.price@memverge.com> <20230221201740.2236-3-gregory.price@memverge.com>
In-Reply-To: <20230221201740.2236-3-gregory.price@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 24 Feb 2023 00:17:56 -0800
Message-ID: <CANaxB-zTkCLbjBti8hrs9RVna21KzwC0GugyDu7=nTzGLLum2Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 12:18 PM Gregory Price
<gourry.memverge@gmail.com> wrote:

...

> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index 22396b234854..08e8b377557f 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/sched.h>
>  #include <linux/prctl.h>
> +#include <linux/ptrace.h>
>  #include <linux/syscall_user_dispatch.h>
>  #include <linux/uaccess.h>
>  #include <linux/signal.h>
> @@ -113,3 +114,42 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
>  {
>         return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
>  }
> +
> +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> +                                    void __user *data)
> +{
> +       struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> +       struct ptrace_sud_config config;

WARNING: Missing a blank line after declarations

You need to verify all patches with ./scripts/checkpatch.pl. Here are
a few other warnings.

> +       if (size != sizeof(struct ptrace_sud_config))
> +               return -EINVAL;
> +

config has to be fully initialized otherwise it leaks data from a kernel stack.

> +       if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
> +               config.mode = PR_SYS_DISPATCH_ON;
> +       else
> +               config.mode = PR_SYS_DISPATCH_OFF;
> +
> +       config.offset = sd->offset;
> +       config.len = sd->len;
> +       config.selector = (__u64)sd->selector;
> +
> +       if (copy_to_user(data, &config, sizeof(config))) {
> +               return -EFAULT;
> +       }
> +       return 0;
> +}
> +
> +int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
> +                                    void __user *data)
> +{
> +       int rc;
> +       struct ptrace_sud_config cfg;
> +       if (size != sizeof(struct ptrace_sud_config))
> +               return -EINVAL;
> +
> +       if (copy_from_user(&cfg, data, sizeof(cfg))) {
> +               return -EFAULT;
> +       }
> +       rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset,
> +                                           cfg.len, (void __user*)cfg.selector);
> +       return rc;
> +}
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 54482193e1ed..d99376532b56 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -32,6 +32,7 @@
>  #include <linux/compat.h>
>  #include <linux/sched/signal.h>
>  #include <linux/minmax.h>
> +#include <linux/syscall_user_dispatch.h>
>
>  #include <asm/syscall.h>       /* for syscall_get_* */
>
> @@ -1259,6 +1260,14 @@ int ptrace_request(struct task_struct *child, long request,
>                 break;
>  #endif
>
> +       case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
> +               ret = syscall_user_dispatch_set_config(child, addr, datavp);
> +               break;
> +
> +       case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
> +               ret = syscall_user_dispatch_get_config(child, addr, datavp);
> +               break;
> +
>         default:
>                 break;
>         }
> diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
> index 792318aaa30c..b7dde152e75a 100644
> --- a/tools/testing/selftests/ptrace/.gitignore
> +++ b/tools/testing/selftests/ptrace/.gitignore
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  get_syscall_info
> +get_set_sud
>  peeksiginfo
>  vmaccess
> diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
> index 2f1f532c39db..33a36b73bcb9 100644
> --- a/tools/testing/selftests/ptrace/Makefile
> +++ b/tools/testing/selftests/ptrace/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -std=c99 -pthread -iquote../../../../include/uapi -Wall
>
> -TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
> +TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
>
>  include ../lib.mk
> diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c

I think the test has to be in a separate patch.

> new file mode 100644
> index 000000000000..c4e7b87cab03
> --- /dev/null
> +++ b/tools/testing/selftests/ptrace/get_set_sud.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <sys/prctl.h>
> +
> +#include "linux/ptrace.h"
> +
> +static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
> +{
> +       return syscall(SYS_ptrace, request, pid, addr, data);
> +}
> +
> +TEST(get_set_sud)
> +{
> +       struct ptrace_sud_config config;
> +       pid_t child;
> +       int ret = 0;
> +       int status;
> +
> +       child = fork();
> +       ASSERT_GE(child, 0);
> +       if (child == 0) {
> +               ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
> +                       TH_LOG("PTRACE_TRACEME: %m");
> +               }
> +               kill(getpid(), SIGSTOP);
> +               _exit(1);
> +       }
> +
> +       waitpid(child, &status, 0);
> +
> +       memset(&config, 0xff, sizeof(config));
> +       config.mode = PR_SYS_DISPATCH_ON;
> +
> +       ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
> +                        (void*)sizeof(config), &config);
> +       if (ret < 0) {
> +               ASSERT_EQ(errno, EIO);

When do we expect to get EIO here?

> +               goto leave;
> +       }
> +
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
> +       ASSERT_EQ(config.selector, 0);
> +       ASSERT_EQ(config.offset, 0);
> +       ASSERT_EQ(config.len, 0);
> +
> +       config.mode = PR_SYS_DISPATCH_ON;
> +       config.selector = 0;
> +       config.offset = 0x400000;
> +       config.len = 0x1000;
> +
> +       ret = sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
> +                        (void*)sizeof(config), &config);
> +
> +       ASSERT_EQ(ret, 0);
> +
> +       memset(&config, 1, sizeof(config));
> +       ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
> +                        (void*)sizeof(config), &config);
> +
> +       ASSERT_EQ(ret, 0);
> +       ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
> +       ASSERT_EQ(config.selector, 0);
> +       ASSERT_EQ(config.offset, 0x400000);
> +       ASSERT_EQ(config.len, 0x1000);
> +
> +leave:
> +       kill(child, SIGKILL);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.39.1
>
