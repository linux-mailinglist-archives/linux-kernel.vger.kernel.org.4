Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DE62EF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbiKRIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiKRIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:34:54 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E828EB6C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:34:13 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3704852322fso43000177b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wyrIZGrkRGaBx3SBlr53l5QP2brkzSvBi6iVTIgs8bA=;
        b=p/97bDSMHPSl8KJZhheAqVfFItZr4N5ToAF1sL/eRnSDT78a47IjZqZRBiAf1ZRvOg
         StG+00tSdXWDsXeAgM1Yp4aXIAfaybTBv9cNAchnMtgmo5aXXMYFTmz0irktfNHmHGj6
         HWDw/TPmRe0g0WB2Bn0IuhYCvVpx8PcVB34dJWrW/PoSrRDMyZ+v49sW/TslbSrrbRWe
         IuAekW2Aa1UflkJMuh4WDsqRlRIRZieQ1tAGqw8BHbmtlDXAtkrp9FB38PUidu9Tt9Mw
         +GTq7+MjLHDrW7xbA+tLEmVml4W+IkGZGuucNdqLMkzWITkL4uAGfzxdBda0MyxfbW0k
         GLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyrIZGrkRGaBx3SBlr53l5QP2brkzSvBi6iVTIgs8bA=;
        b=LvgEzHwDWGv9YKLYjXbFT6v5ejf9WTvBAQh2Vj+b7yuxhJX+tdINLEcRo76xw2dwS2
         xF4jMVF1qB8ATyWmcmcFyYuvoihlq2F+fT4Oap/yEXpZF4pFR5wRtaMUVJYCKbP7xVpS
         aYF8T785z373++QPDqU6/2bP/qromT10hj0shzpWdapImXOJc8Az3iJzh0IChocPYnJp
         WLlT6Ev0krMxciliDZYFIw+vtjzKkJ3S+CuQqHe/CkenBt/bnOjXUGta8YaGBTr4UXFX
         IFbkcm/ZoIOIUCk7oS37FsU/2q+IF5MfTJdWyAUFAmR9MeRUPJippWJ6JcUznY4Fb2Yx
         TWHQ==
X-Gm-Message-State: ANoB5pmPhHoENjLaM/wxPVWUTGZ+v/4yC/lWN9FgWqoYeuTvDRjX8ofV
        04sjzR185ClCA+HX0qnM0gxkc0w1tKsKpSSWv6hLpw==
X-Google-Smtp-Source: AA0mqf6Kvf44HlZn6iojLaECPn2leREJv9EFhtuvAZO/Mw6881fUR5KToU610B8qLHSvq9W6O51u62BW9Qbmllua0rI=
X-Received: by 2002:a81:1717:0:b0:36f:c0f7:856f with SMTP id
 23-20020a811717000000b0036fc0f7856fmr5472096ywx.4.1668760453041; Fri, 18 Nov
 2022 00:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20221117233838.give.484-kees@kernel.org> <20221117234328.594699-4-keescook@chromium.org>
In-Reply-To: <20221117234328.594699-4-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 18 Nov 2022 09:33:36 +0100
Message-ID: <CANpmjNN2oHP0xLhPG9TboqcXFxdvhE9Hh6qKa0xPGnyFyGDRQg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] panic: Consolidate open-coded panic_on_warn checks
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Dmitry Vyukov <dvyukov@google.com>,
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
        Andrey Konovalov <andreyknvl@gmail.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 00:43, Kees Cook <keescook@chromium.org> wrote:
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

Reviewed-by: Marco Elver <elver@google.com>

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
