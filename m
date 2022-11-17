Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331CC62E98F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiKQX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKQX17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:27:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A63266C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:27:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso3466722pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+zOnZ+iVEe8Qzy0xCfuCuxCEDTF24JR1bRlLbEe2Zd0=;
        b=lV/oOdWqej5RkQtxkQr7BqcpjgxET4zu2n3EB3MbJ/Mzt7OV7xFbi0S8yNY5S5knqW
         4TtRGgV/rPxM3uAjyFZ0WjOKTxSfTSbu7+ShBacYWJZv7UMTP/J9oZp2lEAjLZ7QOiS+
         S5qmYEpkNu7+FPF75+/tdNc0rtxKkt0tnxfOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zOnZ+iVEe8Qzy0xCfuCuxCEDTF24JR1bRlLbEe2Zd0=;
        b=ofOL0TxqB0Cn/22CWBvPb/j2b3QIjlxYhfYlu688Ea23p9vALfvb649A4YkeyPKN4f
         VssCQ+ZxaI9g6HrX3q/laGc6a0xB179TmEMjp/hd16JEsPRib403kJ83kPu8gqWkpO97
         ph1nLZb/0zeKQe1UZODRBx97JIHKcIutbQJuXNhbt5zoID1RTSh+5z96UWYLZMnTTzFc
         FNLoGzKisFkpuDw3MNGgGG2ec3S5SEEmQs9IfFIngbQ4H/Fyr4OvWHF8G6Ce9RwLkrJe
         Nx5/Ffddq5S28UadyczaK5BVg54NP/MGs+M4xaIQ/sXmRub2vZwJlTNycqgpgy1vWftB
         Uo4g==
X-Gm-Message-State: ANoB5pnuhj555mleKCfC7FSREDWFJ6PdfxQXzzqp+KQrzje+eSC/hML7
        hCjcHTW676BvSOpCQGP64Zw8CA==
X-Google-Smtp-Source: AA0mqf4N0rDT96rsS5N0QMBsicNjM1Eg3p/fTMT0yKfNf3Ol9BqUKC7VybTTGA+g9YUGGEAnaWzCzg==
X-Received: by 2002:a17:90a:c901:b0:212:fe9a:5784 with SMTP id v1-20020a17090ac90100b00212fe9a5784mr4887578pjt.91.1668727677220;
        Thu, 17 Nov 2022 15:27:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b00186b1bfbe79sm2070434plg.66.2022.11.17.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:27:56 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:27:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-doc@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/6] panic: Introduce warn_limit
Message-ID: <202211171526.5F09B6D3D@keescook>
References: <20221109194404.gonna.558-kees@kernel.org>
 <20221109200050.3400857-5-keescook@chromium.org>
 <CANpmjNO_ujNwaFxpsAWWXhBajhV8LJMXQjCHiSLHKG2Dc+od4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO_ujNwaFxpsAWWXhBajhV8LJMXQjCHiSLHKG2Dc+od4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:48:38AM +0100, Marco Elver wrote:
> On Wed, 9 Nov 2022 at 21:00, Kees Cook <keescook@chromium.org> wrote:
> >
> > Like oops_limit, add warn_limit for limiting the number of warnings when
> > panic_on_warn is not set.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Cc: Eric Biggers <ebiggers@google.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: tangmeng <tangmeng@uniontech.com>
> > Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> > Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
> >  kernel/panic.c                              | 13 +++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index 09f3fb2f8585..c385d5319cdf 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -1508,6 +1508,15 @@ entry will default to 2 instead of 0.
> >  2 Unprivileged calls to ``bpf()`` are disabled
> >  = =============================================================
> >
> > +
> > +warn_limit
> > +==========
> > +
> > +Number of kernel warnings after which the kernel should panic when
> > +``panic_on_warn`` is not set. Setting this to 0 or 1 has the same effect
> > +as setting ``panic_on_warn=1``.
> > +
> > +
> >  watchdog
> >  ========
> >
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 3afd234767bc..b235fa4a6fc8 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -58,6 +58,7 @@ bool crash_kexec_post_notifiers;
> >  int panic_on_warn __read_mostly;
> >  unsigned long panic_on_taint;
> >  bool panic_on_taint_nousertaint = false;
> > +static unsigned int warn_limit __read_mostly = 10000;
> >
> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
> >  EXPORT_SYMBOL_GPL(panic_timeout);
> > @@ -88,6 +89,13 @@ static struct ctl_table kern_panic_table[] = {
> >                 .extra2         = SYSCTL_ONE,
> >         },
> >  #endif
> > +       {
> > +               .procname       = "warn_limit",
> > +               .data           = &warn_limit,
> > +               .maxlen         = sizeof(warn_limit),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_douintvec,
> > +       },
> >         { }
> >  };
> >
> > @@ -203,8 +211,13 @@ static void panic_print_sys_info(bool console_flush)
> >
> >  void check_panic_on_warn(const char *reason)
> >  {
> > +       static atomic_t warn_count = ATOMIC_INIT(0);
> > +
> >         if (panic_on_warn)
> >                 panic("%s: panic_on_warn set ...\n", reason);
> > +
> > +       if (atomic_inc_return(&warn_count) >= READ_ONCE(warn_limit))
> > +               panic("Warned too often (warn_limit is %d)", warn_limit);
> 
> Shouldn't this also include the "reason", like above? (Presumably a
> warning had just been generated to console so the reason is easy
> enough to infer from the log, although in that case "reason" also
> seems redundant above.)

Yeah, that makes sense. I had been thinking that since it was an action
due to repeated prior actions, the current "reason" didn't matter here.
But thinking about it more, I see what you mean. :)

-- 
Kees Cook
