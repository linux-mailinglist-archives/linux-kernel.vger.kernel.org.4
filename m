Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAA728BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjFHX14 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 19:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFHX1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:27:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263330D4;
        Thu,  8 Jun 2023 16:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF6465151;
        Thu,  8 Jun 2023 23:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A534EC433EF;
        Thu,  8 Jun 2023 23:27:50 +0000 (UTC)
Date:   Thu, 8 Jun 2023 19:27:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230608192748.435a1dbf@gandalf.local.home>
In-Reply-To: <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
References: <20230608212613.424070-1-jolsa@kernel.org>
        <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 15:43:03 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Jun 8, 2023 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> >
> > hi,
> > when ftrace based tracers we need to cross check available_filter_functions
> > with /proc/kallsyms. For example for kprobe_multi bpf link (based on fprobe)
> > we need to make sure that symbol regex resolves to traceable symbols and
> > that we get proper addresses for them.

I forgot, what was the problem with doing the above?

> >
> > Looks like on the last last LSF/MM/BPF there was an agreement to add new
> > file that will have available_filter_functions symbols plus addresses.
> >
> > This RFC is to kick off the discussion, I'm not sure Steven wants to do
> > that differently ;-)

I'm not totally against this, but I'd like to know the full issue its
solving. Perhaps I need to know more about what is being done, and what is
needed too.

> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Adding new available_filter_functions_addrs file that shows all available
> > functions (same as available_filter_functions) together with addresses,
> > like:
> >
> >   # cat available_filter_functions_addrs | head  
> 
> nit: can we have some more succinct name, like "traceable_funcs" or


It's to match avaliable_filter_functions

Another way is to add a tracing option to make the address show up in the
available_filter_functions file. That would be my preferred choice.

  echo 1 > options/available_filter_addrs

Or something like that.



> something? And btw, does this have to be part of tracefs/debugfs

Because it's part of ftrace, and that belongs in tracefs.

> (never knew the difference, sorry). E.g., can it be instead exposed
> through sysfs?

tracefs is not debugfs, as debugfs includes all things debuggy (and
considered not secure). tracefs is its own file system dedicated to the
tracing code in the kernel. It exists with CONFIG_DEBUG not defined, and
lives in /sys/kernel/tracing. The only reason /sys/kernel/debug/tracing
(which is a duplicate mount point) exists is for backward compatibility for
before tracefs existed. But that path really should be deprecated.

> 
> Either than these minor things, yep, I think this is something that
> would be extremely useful, thanks, Jiri, for taking a stab at it!
> 
> >   ffffffff81000770 __traceiter_initcall_level
> >   ffffffff810007c0 __traceiter_initcall_start
> >   ffffffff81000810 __traceiter_initcall_finish
> >   ffffffff81000860 trace_initcall_finish_cb
> >   ...
> >
> > It's useful to have address avilable for traceable symbols, so we don't
> > need to allways cross check kallsyms with available_filter_functions
> > (or the other way around) and have all the data in single file.

Is it really that big of an issue? Again, I'm not against this change, but
I'm just wondering how much of a burden is it relieving?

> >
> > For backwards compatibility reasons we can't change the existing
> > available_filter_functions file output, but we need to add new file.

Or we could add an option to change it ;-)

> >
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/ftrace.h |  1 +
> >  kernel/trace/ftrace.c  | 52 ++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 48 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index b23bdd414394..6e372575a8e9 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -633,6 +633,7 @@ enum {
> >         FTRACE_ITER_MOD         = (1 << 5),
> >         FTRACE_ITER_ENABLED     = (1 << 6),
> >         FTRACE_ITER_TOUCHED     = (1 << 7),
> > +       FTRACE_ITER_ADDRS       = (1 << 8),
> >  };
> >
> >  void arch_ftrace_update_code(int command);
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 764668467155..1f33e1f04834 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3804,7 +3804,7 @@ static int __init ftrace_check_sync(void)
> >  late_initcall_sync(ftrace_check_sync);
> >  subsys_initcall(ftrace_check_for_weak_functions);
> >
> > -static int print_rec(struct seq_file *m, unsigned long ip)
> > +static int print_rec(struct seq_file *m, unsigned long ip, bool print_addr)
> >  {
> >         unsigned long offset;
> >         char str[KSYM_SYMBOL_LEN];
> > @@ -3819,7 +3819,11 @@ static int print_rec(struct seq_file *m, unsigned long ip)
> >                 ret = NULL;
> >         }
> >
> > -       seq_puts(m, str);
> > +       if (print_addr)
> > +               seq_printf(m, "%lx %s", ip, str);
> > +       else
> > +               seq_puts(m, str);
> > +
> >         if (modname)
> >                 seq_printf(m, " [%s]", modname);
> >         return ret == NULL ? -1 : 0;
> > @@ -3830,9 +3834,13 @@ static inline int test_for_valid_rec(struct dyn_ftrace *rec)
> >         return 1;
> >  }
> >
> > -static inline int print_rec(struct seq_file *m, unsigned long ip)
> > +static inline int print_rec(struct seq_file *m, unsigned long ip, bool print_addr)
> >  {
> > -       seq_printf(m, "%ps", (void *)ip);
> > +       if (print_addr)
> > +               seq_printf(m, "%lx %ps", ip, (void *)ip);
> > +       else
> > +               seq_printf(m, "%ps", (void *)ip);
> > +
> >         return 0;
> >  }
> >  #endif
> > @@ -3861,7 +3869,7 @@ static int t_show(struct seq_file *m, void *v)
> >         if (!rec)
> >                 return 0;
> >

Hmm, why not add the print here?

	if (iter->flags & FTRACE_ITER_ADDRS)
		seq_printf(m, "%lx ", rec->ip);

and not touch print_rec().

> > -       if (print_rec(m, rec->ip)) {
> > +       if (print_rec(m, rec->ip, iter->flags & FTRACE_ITER_ADDRS)) {
> >                 /* This should only happen when a rec is disabled */
> >                 WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
> >                 seq_putc(m, '\n');
> > @@ -3996,6 +4004,30 @@ ftrace_touched_open(struct inode *inode, struct file *file)
> >         return 0;
> >  }
> >

-- Steve
