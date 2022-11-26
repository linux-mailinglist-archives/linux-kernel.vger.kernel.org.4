Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F725639763
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKZRJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKZRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:09:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA419288;
        Sat, 26 Nov 2022 09:09:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so10247286pjh.2;
        Sat, 26 Nov 2022 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sLFIKfte67bdoQLm56Ip88k11Q1iXzAXCyP4EbfifyQ=;
        b=Qqdy2+7IeuUQYby+p2g2YD8tGvWMxicv1Ioj0/ANeJyIqaeZBM+ryEn69gs8EgLQj8
         OsKqfgMCujGLXOW7Brr6oT7X7RpQGkIeh7cBicSP0KCHGbD0EgyyjKfkdhKoPJLoltl/
         OIcCd/599NWw12BSkXYU+SA/biJa98039xA0tllKPPxlMcjABR337XIFwWeGAslnt1Ia
         s6byov1peg3lZfXd4v/t13hTYmMrLlAh82i4VRpvravpxGRxkZyAOCOOVTQ2RNLCj82i
         5hqhd2OsBGXyLvFSRvdy6EMyY4zhHj9VQxumVWy5oQN7yjHQbLDwD7gAPBGQ+LvAXtUP
         fBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLFIKfte67bdoQLm56Ip88k11Q1iXzAXCyP4EbfifyQ=;
        b=j33OxB+sU6vdNx9iFIkmRwU9WuppxKVJxAEu+MPOrxK3w96hsQSBvxprqIOodVIzlE
         IYgU+0Y3rW45Hv5eoPEib7IePteWy7t/eTigRIOyHRTS4+0WU8zy5uPMGJ6oxaz147SY
         iR6vKXOCxfPYSjLXu67JShMWfMIkRmF3wrWpWY8Me2yBPB5ND+8eUnYvkRmyq8WT4Cfm
         s75q3HShg68YVVNAI/OGf5xUrsFjODbDXMY2WI2UGfuLMtW6VB+zUX33zZeC0FqUjOzj
         9gJFXYTQFrvOVIZMw76XBM8o9VL5MjItr2u25i2czKky/jRsij9S/HC1bD7ubd8ABgZ2
         SoqA==
X-Gm-Message-State: ANoB5plvY74UCrYh+k50wDj3Y7qLqqDG4sNbtrOekRn8o5tVTSmWEVpQ
        ZdPT15lFZH1HxDGDLF2X9Chilb6VjQA77Yi0agM=
X-Google-Smtp-Source: AA0mqf4TJsENZt3RxiaDOoBbJDmgDFN8Sjw0MX6oPq4zVEGXXt4w7TuhSBtUO9e4gAyy4y002l9CxuLwLJjv7m3cSuY=
X-Received: by 2002:a17:903:300c:b0:186:9ef5:4d59 with SMTP id
 o12-20020a170903300c00b001869ef54d59mr36934713pla.89.1669482580757; Sat, 26
 Nov 2022 09:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20221117233838.give.484-kees@kernel.org> <20221117234328.594699-4-keescook@chromium.org>
In-Reply-To: <20221117234328.594699-4-keescook@chromium.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 26 Nov 2022 18:09:29 +0100
Message-ID: <CA+fCnZdMNs8Ut=_vwZNu-ksAW1T9+dxR3AcLpGb_3rYJjzOffg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] panic: Consolidate open-coded panic_on_warn checks
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Fri, Nov 18, 2022 at 12:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> Several run-time checkers (KASAN, UBSAN, KFENCE, KCSAN, sched) roll
> their own warnings, and each check "panic_on_warn". Consolidate this
> into a single function so that future instrumentation can be added in
> a single location.
>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Gow <davidgow@google.com>
> Cc: tangmeng <tangmeng@uniontech.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/panic.h | 1 +
>  kernel/kcsan/report.c | 3 +--
>  kernel/panic.c        | 9 +++++++--
>  kernel/sched/core.c   | 3 +--
>  lib/ubsan.c           | 3 +--
>  mm/kasan/report.c     | 4 ++--
>  mm/kfence/report.c    | 3 +--
>  7 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index c7759b3f2045..979b776e3bcb 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -11,6 +11,7 @@ extern long (*panic_blink)(int state);
>  __printf(1, 2)
>  void panic(const char *fmt, ...) __noreturn __cold;
>  void nmi_panic(struct pt_regs *regs, const char *msg);
> +void check_panic_on_warn(const char *origin);
>  extern void oops_enter(void);
>  extern void oops_exit(void);
>  extern bool oops_may_print(void);
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 67794404042a..e95ce7d7a76e 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -492,8 +492,7 @@ static void print_report(enum kcsan_value_change value_change,
>         dump_stack_print_info(KERN_DEFAULT);
>         pr_err("==================================================================\n");
>
> -       if (panic_on_warn)
> -               panic("panic_on_warn set ...\n");
> +       check_panic_on_warn("KCSAN");
>  }
>
>  static void release_report(unsigned long *flags, struct other_info *other_info)
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d843d036651e..cfa354322d5f 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -201,6 +201,12 @@ static void panic_print_sys_info(bool console_flush)
>                 ftrace_dump(DUMP_ALL);
>  }
>
> +void check_panic_on_warn(const char *origin)
> +{
> +       if (panic_on_warn)
> +               panic("%s: panic_on_warn set ...\n", origin);
> +}
> +
>  /**
>   *     panic - halt the system
>   *     @fmt: The text string to print
> @@ -619,8 +625,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>         if (regs)
>                 show_regs(regs);
>
> -       if (panic_on_warn)
> -               panic("panic_on_warn set ...\n");
> +       check_panic_on_warn("kernel");
>
>         if (!regs)
>                 dump_stack();
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5800b0623ff3..285ef8821b4f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5729,8 +5729,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
>                 pr_err("Preemption disabled at:");
>                 print_ip_sym(KERN_ERR, preempt_disable_ip);
>         }
> -       if (panic_on_warn)
> -               panic("scheduling while atomic\n");
> +       check_panic_on_warn("scheduling while atomic");
>
>         dump_stack();
>         add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 36bd75e33426..60c7099857a0 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -154,8 +154,7 @@ static void ubsan_epilogue(void)
>
>         current->in_ubsan--;
>
> -       if (panic_on_warn)
> -               panic("panic_on_warn set ...\n");
> +       check_panic_on_warn("UBSAN");
>  }
>
>  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index df3602062bfd..cc98dfdd3ed2 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -164,8 +164,8 @@ static void end_report(unsigned long *flags, void *addr)
>                                        (unsigned long)addr);
>         pr_err("==================================================================\n");
>         spin_unlock_irqrestore(&report_lock, *flags);
> -       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
> -               panic("panic_on_warn set ...\n");
> +       if (!test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
> +               check_panic_on_warn("KASAN");
>         if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
>                 panic("kasan.fault=panic set ...\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 7e496856c2eb..110c27ca597d 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -268,8 +268,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
>
>         lockdep_on();
>
> -       if (panic_on_warn)
> -               panic("panic_on_warn set ...\n");
> +       check_panic_on_warn("KFENCE");
>
>         /* We encountered a memory safety error, taint the kernel! */
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
