Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71AC62E996
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiKQX2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiKQX2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:28:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515276155
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:28:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so3026800pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcOLKLI7Dm9mEvWr+m80g8x+dHIAf7454LwMBIEgBJs=;
        b=lj3JmYhmFP49enZ7BxP/5GWppKnAj8SCgQGp6xPE+6+tFUOgdM7wDLFEj70QX9lmbX
         yGcp5CKcwqVjrv/Mk2mtpSyahI9rVFSpvCnHXYBUYU8FPmUKWsFrnsXv8zBXVi5jSr/l
         mKjLka+gt5yA5FVG5FscBRzNyfWnHm2lnmqbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcOLKLI7Dm9mEvWr+m80g8x+dHIAf7454LwMBIEgBJs=;
        b=xUq9wpMw1MF4ohUe5Kzme1z702xTWd8d7st+Hj0h8zE59k1+E+L4QT4c3tC60MhpkQ
         eKLCL4YRvXw/qJraHxdI3oKvBhAPD4YEKMiK9j6g/Cl7FXQdCYjUmDFywwp6lO8aRAFN
         lXVhXUCV49gj1HG1tL7eFUUy49Ln7wjUhf998xIX3yILo0JwpJAvCCTF76G4lHTCdiyo
         QWYLhEAX4XIFfk5XusG0QF5yDtSVAYtKVbQEcHkxsCArpwEdMdLt+T7G93XzoHuhC3vz
         Nc/c+KEQlNEcbMB3CZ1G83FWdLog0R3IrryPGokrTfxMM3WE4mSXp+qsL2l61Q9yVEpB
         idqg==
X-Gm-Message-State: ANoB5pk0STHB/u8FaZBdYqpDKIsC0nq8PHjZFNS24/J/7/J5HXgn4Cky
        XnmU/RCJ+j8yOsk5VZjvgzPA1Q==
X-Google-Smtp-Source: AA0mqf58Ma7eiUSU1v06lTRmXyRIaf5qGvRu9GMxwZP155Uu9IDglDpTru83Stj4Ke9kGjDXEKX0gg==
X-Received: by 2002:a17:902:f651:b0:186:b5c8:4c8f with SMTP id m17-20020a170902f65100b00186b5c84c8fmr4827739plg.124.1668727725304;
        Thu, 17 Nov 2022 15:28:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a656c0f000000b0046f7e1ca434sm1643826pgu.0.2022.11.17.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:28:44 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:28:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Jann Horn <jannh@google.com>, Dmitry Vyukov <dvyukov@google.com>,
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
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
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
Subject: Re: [PATCH v2 4/6] panic: Consolidate open-coded panic_on_warn checks
Message-ID: <202211171528.DF818B1CB6@keescook>
References: <20221109194404.gonna.558-kees@kernel.org>
 <20221109200050.3400857-4-keescook@chromium.org>
 <CANpmjNNrYDNrRR8i+8xAFnmSjZ0Rdp-P14Sf9d+dadfsik18QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNrYDNrRR8i+8xAFnmSjZ0Rdp-P14Sf9d+dadfsik18QA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:57:15AM +0100, Marco Elver wrote:
> On Wed, 9 Nov 2022 at 21:00, Kees Cook <keescook@chromium.org> wrote:
> >
> > Several run-time checkers (KASAN, UBSAN, KFENCE, KCSAN, sched) roll
> > their own warnings, and each check "panic_on_warn". Consolidate this
> > into a single function so that future instrumentation can be added in
> > a single location.
> >
> > Cc: Marco Elver <elver@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: David Gow <davidgow@google.com>
> > Cc: tangmeng <tangmeng@uniontech.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> > Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Cc: kasan-dev@googlegroups.com
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/panic.h | 1 +
> >  kernel/kcsan/report.c | 3 +--
> >  kernel/panic.c        | 9 +++++++--
> >  kernel/sched/core.c   | 3 +--
> >  lib/ubsan.c           | 3 +--
> >  mm/kasan/report.c     | 4 ++--
> >  mm/kfence/report.c    | 3 +--
> >  7 files changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/panic.h b/include/linux/panic.h
> > index c7759b3f2045..1702aeb74927 100644
> > --- a/include/linux/panic.h
> > +++ b/include/linux/panic.h
> > @@ -11,6 +11,7 @@ extern long (*panic_blink)(int state);
> >  __printf(1, 2)
> >  void panic(const char *fmt, ...) __noreturn __cold;
> >  void nmi_panic(struct pt_regs *regs, const char *msg);
> > +void check_panic_on_warn(const char *reason);
> >  extern void oops_enter(void);
> >  extern void oops_exit(void);
> >  extern bool oops_may_print(void);
> > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > index 67794404042a..e95ce7d7a76e 100644
> > --- a/kernel/kcsan/report.c
> > +++ b/kernel/kcsan/report.c
> > @@ -492,8 +492,7 @@ static void print_report(enum kcsan_value_change value_change,
> >         dump_stack_print_info(KERN_DEFAULT);
> >         pr_err("==================================================================\n");
> >
> > -       if (panic_on_warn)
> > -               panic("panic_on_warn set ...\n");
> > +       check_panic_on_warn("KCSAN");
> >  }
> >
> >  static void release_report(unsigned long *flags, struct other_info *other_info)
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 129936511380..3afd234767bc 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -201,6 +201,12 @@ static void panic_print_sys_info(bool console_flush)
> >                 ftrace_dump(DUMP_ALL);
> >  }
> >
> > +void check_panic_on_warn(const char *reason)
> > +{
> > +       if (panic_on_warn)
> > +               panic("%s: panic_on_warn set ...\n", reason);
> > +}
> > +
> >  /**
> >   *     panic - halt the system
> >   *     @fmt: The text string to print
> > @@ -619,8 +625,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
> >         if (regs)
> >                 show_regs(regs);
> >
> > -       if (panic_on_warn)
> > -               panic("panic_on_warn set ...\n");
> > +       check_panic_on_warn("kernel");
> 
> What is the reason "kernel" in this context? The real reason is a WARN
> - so would the reason "WARNING" be more intuitive?

I'll rename "reason" to "origin" or something -- it's mainly to see
who was calling this when it's not core kernel logic.

-- 
Kees Cook
