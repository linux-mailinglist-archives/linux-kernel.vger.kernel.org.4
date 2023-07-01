Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA7744AB9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 19:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGARjR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGARjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 13:39:15 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D615199B;
        Sat,  1 Jul 2023 10:39:14 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bd6446528dcso3107582276.2;
        Sat, 01 Jul 2023 10:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688233153; x=1690825153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2OE5cWzJzNcPgewdA6Xd337X3DXTWHScGpIummK9Ec=;
        b=DUt3LFZe4w8gCzCV4IQBtzx4DVLTJ4jw3Ij2miAQdAZ3rKaXb/N/ybFk8A/RcrAOBc
         4UR6f8gFmVR/SL6yLV9umZFpWT41Y1nZuRNwpycPZEzy9gmfActiooHkeda975iDMJTP
         z7FHsB+DTk1GZ+L0dLHVxmYvOX0yLCB3EwWQDJqs625B2nVeTvpj7LyRYRP2HJQmYMCm
         KUXFGa9gWO1ZaFy4pxjQ2447xA2z4L6O4vVFDw8pgGig3JDHq8EsiLbZlycF+n18CyCg
         64Gg6tjWt0Tqce1oXr5mIeLcgMy9nAZnjD5llCIc5sn2tDG1OhY4D73Mg9IhW5T/GVg6
         eCQg==
X-Gm-Message-State: ABy/qLbPD70Fd6Abz8HQi2h9fetxOWpCZjEJXlDGdIYGlEXpNzKzvO87
        hifk15U+9tyIMkvyY1ZXOgvHmVJu+ENdoDeu3do=
X-Google-Smtp-Source: APBJJlGUGaf94rCMr4Dm044k6b34Jm3VB3c+ygEHOKwJbH8sELGvTojgcjzC+sj1dq9H/esuqozsraSzI/VNWQqKaD8=
X-Received: by 2002:a25:ce83:0:b0:c25:3076:ffdc with SMTP id
 x125-20020a25ce83000000b00c253076ffdcmr6393766ybe.1.1688233153256; Sat, 01
 Jul 2023 10:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org> <20230628200141.2739587-3-namhyung@kernel.org>
 <CAP-5=fWCVP1itpO5AAotHy17sz1X66WLCch1yL4EsXyx4=z6cQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWCVP1itpO5AAotHy17sz1X66WLCch1yL4EsXyx4=z6cQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 10:39:01 -0700
Message-ID: <CAM9d7cigZjmd9pFF-PXi-FHWGeK=JPq3dOzqxuKrJcOv+wQ4Hw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf lock contention: Add -x option for CSV style output
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Jun 30, 2023 at 9:03 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jun 28, 2023 at 1:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Sometimes we want to process the output by external programs.  Let's add
> > the -x option to specify the field separator like perf stat.
> >
> >   $ sudo ./perf lock con -ab -x, sleep 1
> >   # output: contended, total wait, max wait, avg wait, type, caller
> >   19, 194232, 21415, 10222, spinlock, process_one_work+0x1f0
> >   15, 162748, 23843, 10849, rwsem:R, do_user_addr_fault+0x40e
> >   4, 86740, 23415, 21685, rwlock:R, ep_poll_callback+0x2d
> >   1, 84281, 84281, 84281, mutex, iwl_mvm_async_handlers_wk+0x135
> >   8, 67608, 27404, 8451, spinlock, __queue_work+0x174
> >   3, 58616, 31125, 19538, rwsem:W, do_mprotect_pkey+0xff
> >   3, 52953, 21172, 17651, rwlock:W, do_epoll_wait+0x248
> >   2, 30324, 19704, 15162, rwsem:R, do_madvise+0x3ad
> >   1, 24619, 24619, 24619, spinlock, rcu_core+0xd4
> >
> > The first line is a comment that shows the output format.  Each line is
> > separated by the given string ("," in this case).  The time is printed
> > in nsec without the unit so that it can be parsed easily.
> >
> > The characters can be used in the output like (":", "+" and ".") are not
> > allowed for the -x option.
> >
> >   $ ./perf lock con -x:
> >   Cannot use the separator that is already used
> >
> >    Usage: perf lock contention [<options>]
> >
> >       -x, --field-separator <separator>
> >                             print result in CSV format with custom separator
> >
> > The stacktraces are printed in the same line separated by ":".  The
> > header is updated to show the stacktrace.  Also the debug output is
> > added at the end as a comment.
> >
> >   $ sudo ./perf lock con -abv -x, -F wait_total sleep 1
> >   Looking at the vmlinux_path (8 entries long)
> >   symsrc__init: cannot get elf header.
> >   Using /proc/kcore for kernel data
> >   Using /proc/kallsyms for symbols
> >   # output: total wait, type, caller, stacktrace
> >   37134, spinlock, rcu_core+0xd4, 0xffffffff9d0401e4 _raw_spin_lock_irqsave+0x44: 0xffffffff9c738114 rcu_core+0xd4: ...
> >   21213, spinlock, raw_spin_rq_lock_nested+0x1b, 0xffffffff9d0407c0 _raw_spin_lock+0x30: 0xffffffff9c6d9cfb raw_spin_rq_lock_nested+0x1b: ...
> >   20506, rwlock:W, ep_done_scan+0x2d, 0xffffffff9c9bc4dd ep_done_scan+0x2d: 0xffffffff9c9bd5f1 do_epoll_wait+0x6d1: ...
> >   18044, rwlock:R, ep_poll_callback+0x2d, 0xffffffff9d040555 _raw_read_lock_irqsave+0x45: 0xffffffff9c9bc81d ep_poll_callback+0x2d: ...
> >   17890, rwlock:W, do_epoll_wait+0x47b, 0xffffffff9c9bd39b do_epoll_wait+0x47b: 0xffffffff9c9be9ef __x64_sys_epoll_wait+0x6d1: ...
> >   12114, spinlock, futex_wait_queue+0x60, 0xffffffff9d0407c0 _raw_spin_lock+0x30: 0xffffffff9d037cae __schedule+0xbe: ...
> >   # debug: total=7, bad=0, bad_task=0, bad_stack=0, bad_time=0, bad_data=0
> >
> > Also note that some field (like lock symbols) can be empty.
> >
> >   $ sudo ./perf lock con -abl -x, -E 10 sleep 1
> >   # output: contended, total wait, max wait, avg wait, address, symbol, type
> >   6, 275025, 61764, 45837, ffff9dcc9f7d60d0, , spinlock
> >   18, 87716, 11196, 4873, ffff9dc540059000, , spinlock
> >   2, 6472, 5499, 3236, ffff9dcc7f730e00, rq_lock, spinlock
> >   3, 4429, 2341, 1476, ffff9dcc7f7b0e00, rq_lock, spinlock
> >   3, 3974, 1635, 1324, ffff9dcc7f7f0e00, rq_lock, spinlock
> >   4, 3290, 1326, 822, ffff9dc5f4e2cde0, , rwlock
> >   3, 2894, 1023, 964, ffffffff9e0d7700, rcu_state, spinlock
> >   1, 2567, 2567, 2567, ffff9dcc7f6b0e00, rq_lock, spinlock
> >   4, 1259, 596, 314, ffff9dc69c2adde0, , rwlock
> >   1, 934, 934, 934, ffff9dcc7f670e00, rq_lock, spinlock
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > Acked-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-lock.txt |   5 +
> >  tools/perf/builtin-lock.c              | 303 +++++++++++++++++++------
> >  2 files changed, 241 insertions(+), 67 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> > index 6e5ba3cd2b72..d1efcbe7a470 100644
> > --- a/tools/perf/Documentation/perf-lock.txt
> > +++ b/tools/perf/Documentation/perf-lock.txt
> > @@ -200,6 +200,11 @@ CONTENTION OPTIONS
> >         Note that it matches the substring so 'rq' would match both 'raw_spin_rq_lock'
> >         and 'irq_enter_rcu'.
> >
> > +-x::
> > +--field-separator=<SEP>::
> > +       Show results using a CSV-style output to make it easy to import directly
> > +       into spreadsheets. Columns are separated by the string specified in SEP.
> > +
> >
> >  SEE ALSO
> >  --------
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 187efb651436..98b0c0b1b307 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -225,6 +225,12 @@ static void lock_stat_key_print_time(unsigned long long nsec, int len)
> >                 { 0, NULL },
> >         };
> >
> > +       /* for CSV output */
> > +       if (len == 0) {
> > +               pr_info("%llu", nsec);
>
> Perhaps for the next patch set. Picking on the first print, I think it
> makes sense with CSV output that there should be a file option.
> Otherwise debug messages pr_* are going to end up breaking the CSV
> format.

Yep, in the patch 3/4. :)

>
> > +               return;
> > +       }
> > +
> >         for (int i = 0; table[i].unit; i++) {
> >                 if (nsec < table[i].base)
> >                         continue;
> > @@ -1626,11 +1632,179 @@ static void sort_contention_result(void)
> >         sort_result();
> >  }
> >
> > -static void print_bpf_events(int total, struct lock_contention_fails *fails)
> > +static void print_header_stdio(void)
> > +{
> > +       struct lock_key *key;
> > +
> > +       list_for_each_entry(key, &lock_keys, list)
> > +               pr_info("%*s ", key->len, key->header);
> > +
> > +       switch (aggr_mode) {
> > +       case LOCK_AGGR_TASK:
> > +               pr_info("  %10s   %s\n\n", "pid",
> > +                       show_lock_owner ? "owner" : "comm");
> > +               break;
> > +       case LOCK_AGGR_CALLER:
> > +               pr_info("  %10s   %s\n\n", "type", "caller");
> > +               break;
> > +       case LOCK_AGGR_ADDR:
> > +               pr_info("  %16s   %s\n\n", "address", "symbol");
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +}
> > +
> > +static void print_header_csv(const char *sep)
> > +{
> > +       struct lock_key *key;
> > +
> > +       pr_info("# output: ");
> > +       list_for_each_entry(key, &lock_keys, list)
> > +               pr_info("%s%s ", key->header, sep);
> > +
> > +       switch (aggr_mode) {
> > +       case LOCK_AGGR_TASK:
> > +               pr_info("%s%s %s\n", "pid", sep,
> > +                       show_lock_owner ? "owner" : "comm");
>
> So a thought here, I would kind of like all the CSV functions
> together. It is key for CSV output that the columns line up, the
> layout here means you need to jump through the code to determine this.
> I'd also prefer that the '\n' weren't output until after the switch.
> The purpose being to show that the line is created, at the end of the
> function when the line is done we move to the next line and that is
> common for all aggregation modes.

Yeah, I also think we should rewrite output code including perf stat
to do the job better.  I hope I can find some time for it.

>
> > +               break;
> > +       case LOCK_AGGR_CALLER:
> > +               pr_info("%s%s %s", "type", sep, "caller");
> > +               if (verbose > 0)
> > +                       pr_info("%s %s", sep, "stacktrace");
> > +               pr_info("\n");
> > +               break;
> > +       case LOCK_AGGR_ADDR:
> > +               pr_info("%s%s %s%s %s\n", "address", sep, "symbol", sep, "type");
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +}
> > +
> > +static void print_header(void)
> > +{
> > +       if (!quiet) {
> > +               if (symbol_conf.field_sep)
> > +                       print_header_csv(symbol_conf.field_sep);
> > +               else
> > +                       print_header_stdio();
>
> Suggestion: could we switch to the callback style here. So there is
> some state and a set of callback routines - the usual fake OO pattern.
> I could imagine the state for CSV being the current column number,
> that way there could be asserts on the layout.

Something like hpp code.  Let me think about it later..

Thanks,
Namhyung
