Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6A7743F63
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3QDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjF3QDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:03:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F23C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:03:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso315271cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688140984; x=1690732984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhghgI0oBo2b2j8ydGUvaJ9pZyozYDsGsYC8VqGuac0=;
        b=j26GCD04PhcO8gGpao5mG0+kk3gXy4ObS4HNiW07tJ118CFWldqVLzgMsVZvwy6t5A
         o0EnbGDEaG7zu3FHQQGdkkJFrbuhU/9jYWiOrKxhpP+b3vwv9S1WzlCJa3jzpoHqHrLT
         kYN/u+cngnQDiBDvK20r8T+2bizDkp7J+XwcjrAbi4tHZ8sHlwD9uziZIWmjhM9KvvoB
         2lFroG+Z2043ms+q0mYhEPt+rxEEnTcMdddvtVuEPFeKlJ19jK8VTRJweDaVCyHjnPzb
         Z8o2n+hnoRpjKzcnPSN7tCSGbA3O4xR7mgNnI0ojnX9JEBdpPeu1LtuQ9h4EVz32OsOC
         eykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688140984; x=1690732984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhghgI0oBo2b2j8ydGUvaJ9pZyozYDsGsYC8VqGuac0=;
        b=Z72unmAVKhwxvl/hkAeyhmf7b1jrm8deHjjmuLMMGMtVBl6m7gCglwW72jLZg1mUX7
         vxJvok611h1tJ4rwn4UtI8MWoO0ADLjbIVaoxoSTvUYcxD611236Sk8v95MAS16e7Ggb
         wzrW562zzoIVPTvrxEKKUFhdBtP7p8xPvzGFj6s58WOniExxRE9dsGn40lEqhE27ilIF
         IBO7K/m3Qv+H6RMKeg0paa27zcijOcqeaG+ixceXGPveg1zor1ZalbIE4qJtITd0NamN
         nuLGs1u8lyMRCyE3pNn78Iqscn8nXGFO2AwkFmnfhKTJLRGWPHDnA676nNhX7+jFi/ye
         CEOg==
X-Gm-Message-State: AC+VfDwn4OvXUi+hUgc2iwCgn3jamhfyaZneAB5P/I5DKbwSd1cURDM5
        XLUp8UPJXztSG4c2IHEUxJY0omcFTJFMuVi6kiGj1w==
X-Google-Smtp-Source: ACHHUZ4PxrCPs2MxpRyt2IZAm9OHNeL2qOcW41GipMOURPsdXXGlUUCzdYFi7HB8xa5QgmKBoQIh0FnWi4GMFbhxZGg=
X-Received: by 2002:a05:622a:ca:b0:3d6:5f1b:1e7c with SMTP id
 p10-20020a05622a00ca00b003d65f1b1e7cmr779436qtw.9.1688140983773; Fri, 30 Jun
 2023 09:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org> <20230628200141.2739587-3-namhyung@kernel.org>
In-Reply-To: <20230628200141.2739587-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 09:02:52 -0700
Message-ID: <CAP-5=fWCVP1itpO5AAotHy17sz1X66WLCch1yL4EsXyx4=z6cQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf lock contention: Add -x option for CSV style output
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Sometimes we want to process the output by external programs.  Let's add
> the -x option to specify the field separator like perf stat.
>
>   $ sudo ./perf lock con -ab -x, sleep 1
>   # output: contended, total wait, max wait, avg wait, type, caller
>   19, 194232, 21415, 10222, spinlock, process_one_work+0x1f0
>   15, 162748, 23843, 10849, rwsem:R, do_user_addr_fault+0x40e
>   4, 86740, 23415, 21685, rwlock:R, ep_poll_callback+0x2d
>   1, 84281, 84281, 84281, mutex, iwl_mvm_async_handlers_wk+0x135
>   8, 67608, 27404, 8451, spinlock, __queue_work+0x174
>   3, 58616, 31125, 19538, rwsem:W, do_mprotect_pkey+0xff
>   3, 52953, 21172, 17651, rwlock:W, do_epoll_wait+0x248
>   2, 30324, 19704, 15162, rwsem:R, do_madvise+0x3ad
>   1, 24619, 24619, 24619, spinlock, rcu_core+0xd4
>
> The first line is a comment that shows the output format.  Each line is
> separated by the given string ("," in this case).  The time is printed
> in nsec without the unit so that it can be parsed easily.
>
> The characters can be used in the output like (":", "+" and ".") are not
> allowed for the -x option.
>
>   $ ./perf lock con -x:
>   Cannot use the separator that is already used
>
>    Usage: perf lock contention [<options>]
>
>       -x, --field-separator <separator>
>                             print result in CSV format with custom separa=
tor
>
> The stacktraces are printed in the same line separated by ":".  The
> header is updated to show the stacktrace.  Also the debug output is
> added at the end as a comment.
>
>   $ sudo ./perf lock con -abv -x, -F wait_total sleep 1
>   Looking at the vmlinux_path (8 entries long)
>   symsrc__init: cannot get elf header.
>   Using /proc/kcore for kernel data
>   Using /proc/kallsyms for symbols
>   # output: total wait, type, caller, stacktrace
>   37134, spinlock, rcu_core+0xd4, 0xffffffff9d0401e4 _raw_spin_lock_irqsa=
ve+0x44: 0xffffffff9c738114 rcu_core+0xd4: ...
>   21213, spinlock, raw_spin_rq_lock_nested+0x1b, 0xffffffff9d0407c0 _raw_=
spin_lock+0x30: 0xffffffff9c6d9cfb raw_spin_rq_lock_nested+0x1b: ...
>   20506, rwlock:W, ep_done_scan+0x2d, 0xffffffff9c9bc4dd ep_done_scan+0x2=
d: 0xffffffff9c9bd5f1 do_epoll_wait+0x6d1: ...
>   18044, rwlock:R, ep_poll_callback+0x2d, 0xffffffff9d040555 _raw_read_lo=
ck_irqsave+0x45: 0xffffffff9c9bc81d ep_poll_callback+0x2d: ...
>   17890, rwlock:W, do_epoll_wait+0x47b, 0xffffffff9c9bd39b do_epoll_wait+=
0x47b: 0xffffffff9c9be9ef __x64_sys_epoll_wait+0x6d1: ...
>   12114, spinlock, futex_wait_queue+0x60, 0xffffffff9d0407c0 _raw_spin_lo=
ck+0x30: 0xffffffff9d037cae __schedule+0xbe: ...
>   # debug: total=3D7, bad=3D0, bad_task=3D0, bad_stack=3D0, bad_time=3D0,=
 bad_data=3D0
>
> Also note that some field (like lock symbols) can be empty.
>
>   $ sudo ./perf lock con -abl -x, -E 10 sleep 1
>   # output: contended, total wait, max wait, avg wait, address, symbol, t=
ype
>   6, 275025, 61764, 45837, ffff9dcc9f7d60d0, , spinlock
>   18, 87716, 11196, 4873, ffff9dc540059000, , spinlock
>   2, 6472, 5499, 3236, ffff9dcc7f730e00, rq_lock, spinlock
>   3, 4429, 2341, 1476, ffff9dcc7f7b0e00, rq_lock, spinlock
>   3, 3974, 1635, 1324, ffff9dcc7f7f0e00, rq_lock, spinlock
>   4, 3290, 1326, 822, ffff9dc5f4e2cde0, , rwlock
>   3, 2894, 1023, 964, ffffffff9e0d7700, rcu_state, spinlock
>   1, 2567, 2567, 2567, ffff9dcc7f6b0e00, rq_lock, spinlock
>   4, 1259, 596, 314, ffff9dc69c2adde0, , rwlock
>   1, 934, 934, 934, ffff9dcc7f670e00, rq_lock, spinlock
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-lock.txt |   5 +
>  tools/perf/builtin-lock.c              | 303 +++++++++++++++++++------
>  2 files changed, 241 insertions(+), 67 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index 6e5ba3cd2b72..d1efcbe7a470 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -200,6 +200,11 @@ CONTENTION OPTIONS
>         Note that it matches the substring so 'rq' would match both 'raw_=
spin_rq_lock'
>         and 'irq_enter_rcu'.
>
> +-x::
> +--field-separator=3D<SEP>::
> +       Show results using a CSV-style output to make it easy to import d=
irectly
> +       into spreadsheets. Columns are separated by the string specified =
in SEP.
> +
>
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 187efb651436..98b0c0b1b307 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -225,6 +225,12 @@ static void lock_stat_key_print_time(unsigned long l=
ong nsec, int len)
>                 { 0, NULL },
>         };
>
> +       /* for CSV output */
> +       if (len =3D=3D 0) {
> +               pr_info("%llu", nsec);

Perhaps for the next patch set. Picking on the first print, I think it
makes sense with CSV output that there should be a file option.
Otherwise debug messages pr_* are going to end up breaking the CSV
format.

> +               return;
> +       }
> +
>         for (int i =3D 0; table[i].unit; i++) {
>                 if (nsec < table[i].base)
>                         continue;
> @@ -1626,11 +1632,179 @@ static void sort_contention_result(void)
>         sort_result();
>  }
>
> -static void print_bpf_events(int total, struct lock_contention_fails *fa=
ils)
> +static void print_header_stdio(void)
> +{
> +       struct lock_key *key;
> +
> +       list_for_each_entry(key, &lock_keys, list)
> +               pr_info("%*s ", key->len, key->header);
> +
> +       switch (aggr_mode) {
> +       case LOCK_AGGR_TASK:
> +               pr_info("  %10s   %s\n\n", "pid",
> +                       show_lock_owner ? "owner" : "comm");
> +               break;
> +       case LOCK_AGGR_CALLER:
> +               pr_info("  %10s   %s\n\n", "type", "caller");
> +               break;
> +       case LOCK_AGGR_ADDR:
> +               pr_info("  %16s   %s\n\n", "address", "symbol");
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +static void print_header_csv(const char *sep)
> +{
> +       struct lock_key *key;
> +
> +       pr_info("# output: ");
> +       list_for_each_entry(key, &lock_keys, list)
> +               pr_info("%s%s ", key->header, sep);
> +
> +       switch (aggr_mode) {
> +       case LOCK_AGGR_TASK:
> +               pr_info("%s%s %s\n", "pid", sep,
> +                       show_lock_owner ? "owner" : "comm");

So a thought here, I would kind of like all the CSV functions
together. It is key for CSV output that the columns line up, the
layout here means you need to jump through the code to determine this.
I'd also prefer that the '\n' weren't output until after the switch.
The purpose being to show that the line is created, at the end of the
function when the line is done we move to the next line and that is
common for all aggregation modes.

> +               break;
> +       case LOCK_AGGR_CALLER:
> +               pr_info("%s%s %s", "type", sep, "caller");
> +               if (verbose > 0)
> +                       pr_info("%s %s", sep, "stacktrace");
> +               pr_info("\n");
> +               break;
> +       case LOCK_AGGR_ADDR:
> +               pr_info("%s%s %s%s %s\n", "address", sep, "symbol", sep, =
"type");
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +static void print_header(void)
> +{
> +       if (!quiet) {
> +               if (symbol_conf.field_sep)
> +                       print_header_csv(symbol_conf.field_sep);
> +               else
> +                       print_header_stdio();

Suggestion: could we switch to the callback style here. So there is
some state and a set of callback routines - the usual fake OO pattern.
I could imagine the state for CSV being the current column number,
that way there could be asserts on the layout.

Thanks,
Ian

> +       }
> +}
> +
> +static void print_lock_stat_stdio(struct lock_contention *con, struct lo=
ck_stat *st)
> +{
> +       struct lock_key *key;
> +       struct thread *t;
> +       int pid;
> +
> +       list_for_each_entry(key, &lock_keys, list) {
> +               key->print(key, st);
> +               pr_info(" ");
> +       }
> +
> +       switch (aggr_mode) {
> +       case LOCK_AGGR_CALLER:
> +               pr_info("  %10s   %s\n", get_type_str(st->flags), st->nam=
e);
> +               break;
> +       case LOCK_AGGR_TASK:
> +               pid =3D st->addr;
> +               t =3D perf_session__findnew(session, pid);
> +               pr_info("  %10d   %s\n",
> +                       pid, pid =3D=3D -1 ? "Unknown" : thread__comm_str=
(t));
> +               break;
> +       case LOCK_AGGR_ADDR:
> +               pr_info("  %016llx   %s (%s)\n", (unsigned long long)st->=
addr,
> +                       st->name, get_type_name(st->flags));
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (aggr_mode =3D=3D LOCK_AGGR_CALLER && verbose > 0) {
> +               struct map *kmap;
> +               struct symbol *sym;
> +               char buf[128];
> +               u64 ip;
> +
> +               for (int i =3D 0; i < max_stack_depth; i++) {
> +                       if (!st->callstack || !st->callstack[i])
> +                               break;
> +
> +                       ip =3D st->callstack[i];
> +                       sym =3D machine__find_kernel_symbol(con->machine,=
 ip, &kmap);
> +                       get_symbol_name_offset(kmap, sym, ip, buf, sizeof=
(buf));
> +                       pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, bu=
f);
> +               }
> +       }
> +}
> +
> +static void print_lock_stat_csv(struct lock_contention *con, struct lock=
_stat *st,
> +                               const char *sep)
> +{
> +       struct lock_key *key;
> +       struct thread *t;
> +       int pid;
> +
> +       list_for_each_entry(key, &lock_keys, list) {
> +               key->print(key, st);
> +               pr_info("%s ", sep);
> +       }
> +
> +       switch (aggr_mode) {
> +       case LOCK_AGGR_CALLER:
> +               pr_info("%s%s %s", get_type_str(st->flags), sep, st->name=
);
> +               if (verbose <=3D 0)
> +                       pr_info("\n");
> +               break;
> +       case LOCK_AGGR_TASK:
> +               pid =3D st->addr;
> +               t =3D perf_session__findnew(session, pid);
> +               pr_info("%d%s %s\n", pid, sep, pid =3D=3D -1 ? "Unknown" =
: thread__comm_str(t));
> +               break;
> +       case LOCK_AGGR_ADDR:
> +               pr_info("%llx%s %s%s %s\n", (unsigned long long)st->addr,=
 sep,
> +                       st->name, sep, get_type_name(st->flags));
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (aggr_mode =3D=3D LOCK_AGGR_CALLER && verbose > 0) {
> +               struct map *kmap;
> +               struct symbol *sym;
> +               char buf[128];
> +               u64 ip;
> +
> +               for (int i =3D 0; i < max_stack_depth; i++) {
> +                       if (!st->callstack || !st->callstack[i])
> +                               break;
> +
> +                       ip =3D st->callstack[i];
> +                       sym =3D machine__find_kernel_symbol(con->machine,=
 ip, &kmap);
> +                       get_symbol_name_offset(kmap, sym, ip, buf, sizeof=
(buf));
> +                       pr_info("%s %#lx %s", i ? ":" : sep, (unsigned lo=
ng) ip, buf);
> +               }
> +               pr_info("\n");
> +       }
> +}
> +
> +static void print_lock_stat(struct lock_contention *con, struct lock_sta=
t *st)
> +{
> +       if (symbol_conf.field_sep)
> +               print_lock_stat_csv(con, st, symbol_conf.field_sep);
> +       else
> +               print_lock_stat_stdio(con, st);
> +}
> +
> +static void print_footer_stdio(int total, int bad, struct lock_contentio=
n_fails *fails)
>  {
>         /* Output for debug, this have to be removed */
>         int broken =3D fails->task + fails->stack + fails->time + fails->=
data;
>
> +       if (!use_bpf)
> +               print_bad_events(bad, total);
> +
>         if (quiet || total =3D=3D 0 || (broken =3D=3D 0 && verbose <=3D 0=
))
>                 return;
>
> @@ -1646,38 +1820,53 @@ static void print_bpf_events(int total, struct lo=
ck_contention_fails *fails)
>         pr_info(" %10s: %d\n", "data", fails->data);
>  }
>
> +static void print_footer_csv(int total, int bad, struct lock_contention_=
fails *fails,
> +                            const char *sep)
> +{
> +       /* Output for debug, this have to be removed */
> +       if (use_bpf)
> +               bad =3D fails->task + fails->stack + fails->time + fails-=
>data;
> +
> +       if (quiet || total =3D=3D 0 || (bad =3D=3D 0 && verbose <=3D 0))
> +               return;
> +
> +       total +=3D bad;
> +       pr_info("# debug: total=3D%d%s bad=3D%d", total, sep, bad);
> +
> +       if (use_bpf) {
> +               pr_info("%s bad_%s=3D%d", sep, "task", fails->task);
> +               pr_info("%s bad_%s=3D%d", sep, "stack", fails->stack);
> +               pr_info("%s bad_%s=3D%d", sep, "time", fails->time);
> +               pr_info("%s bad_%s=3D%d", sep, "data", fails->data);
> +       } else {
> +               int i;
> +               const char *name[4] =3D { "acquire", "acquired", "contend=
ed", "release" };
> +
> +               for (i =3D 0; i < BROKEN_MAX; i++)
> +                       pr_info("%s bad_%s=3D%d", sep, name[i], bad_hist[=
i]);
> +       }
> +       pr_info("\n");
> +}
> +
> +static void print_footer(int total, int bad, struct lock_contention_fail=
s *fails)
> +{
> +       if (symbol_conf.field_sep)
> +               print_footer_csv(total, bad, fails, symbol_conf.field_sep=
);
> +       else
> +               print_footer_stdio(total, bad, fails);
> +}
> +
>  static void print_contention_result(struct lock_contention *con)
>  {
>         struct lock_stat *st;
> -       struct lock_key *key;
>         int bad, total, printed;
>
> -       if (!quiet) {
> -               list_for_each_entry(key, &lock_keys, list)
> -                       pr_info("%*s ", key->len, key->header);
> -
> -               switch (aggr_mode) {
> -               case LOCK_AGGR_TASK:
> -                       pr_info("  %10s   %s\n\n", "pid",
> -                               show_lock_owner ? "owner" : "comm");
> -                       break;
> -               case LOCK_AGGR_CALLER:
> -                       pr_info("  %10s   %s\n\n", "type", "caller");
> -                       break;
> -               case LOCK_AGGR_ADDR:
> -                       pr_info("  %16s   %s\n\n", "address", "symbol");
> -                       break;
> -               default:
> -                       break;
> -               }
> -       }
> +       if (!quiet)
> +               print_header();
>
>         bad =3D total =3D printed =3D 0;
>
>         while ((st =3D pop_from_result())) {
> -               struct thread *t;
> -               int pid;
> -
>                 total +=3D use_bpf ? st->nr_contended : 1;
>                 if (st->broken)
>                         bad++;
> @@ -1685,45 +1874,7 @@ static void print_contention_result(struct lock_co=
ntention *con)
>                 if (!st->wait_time_total)
>                         continue;
>
> -               list_for_each_entry(key, &lock_keys, list) {
> -                       key->print(key, st);
> -                       pr_info(" ");
> -               }
> -
> -               switch (aggr_mode) {
> -               case LOCK_AGGR_CALLER:
> -                       pr_info("  %10s   %s\n", get_type_str(st->flags),=
 st->name);
> -                       break;
> -               case LOCK_AGGR_TASK:
> -                       pid =3D st->addr;
> -                       t =3D perf_session__findnew(session, pid);
> -                       pr_info("  %10d   %s\n",
> -                               pid, pid =3D=3D -1 ? "Unknown" : thread__=
comm_str(t));
> -                       break;
> -               case LOCK_AGGR_ADDR:
> -                       pr_info("  %016llx   %s (%s)\n", (unsigned long l=
ong)st->addr,
> -                               st->name, get_type_name(st->flags));
> -                       break;
> -               default:
> -                       break;
> -               }
> -
> -               if (aggr_mode =3D=3D LOCK_AGGR_CALLER && verbose > 0) {
> -                       struct map *kmap;
> -                       struct symbol *sym;
> -                       char buf[128];
> -                       u64 ip;
> -
> -                       for (int i =3D 0; i < max_stack_depth; i++) {
> -                               if (!st->callstack || !st->callstack[i])
> -                                       break;
> -
> -                               ip =3D st->callstack[i];
> -                               sym =3D machine__find_kernel_symbol(con->=
machine, ip, &kmap);
> -                               get_symbol_name_offset(kmap, sym, ip, buf=
, sizeof(buf));
> -                               pr_info("\t\t\t%#lx  %s\n", (unsigned lon=
g)ip, buf);
> -                       }
> -               }
> +               print_lock_stat(con, st);
>
>                 if (++printed >=3D print_nr_entries)
>                         break;
> @@ -1740,10 +1891,7 @@ static void print_contention_result(struct lock_co=
ntention *con)
>         /* some entries are collected but hidden by the callstack filter =
*/
>         total +=3D con->nr_filtered;
>
> -       if (use_bpf)
> -               print_bpf_events(total, &con->fails);
> -       else
> -               print_bad_events(bad, total);
> +       print_footer(total, bad, &con->fails);
>  }
>
>  static bool force;
> @@ -1847,6 +1995,16 @@ static int check_lock_contention_options(const str=
uct option *options,
>                 return -1;
>         }
>
> +       if (symbol_conf.field_sep) {
> +               if (strstr(symbol_conf.field_sep, ":") || /* part of type=
 flags */
> +                   strstr(symbol_conf.field_sep, "+") || /* part of call=
er offset */
> +                   strstr(symbol_conf.field_sep, ".")) { /* can be in a =
symbol name */
> +                       pr_err("Cannot use the separator that is already =
used\n");
> +                       parse_options_usage(usage, options, "x", 1);
> +                       return -1;
> +               }
> +       }
> +
>         if (show_lock_owner)
>                 show_thread_stats =3D true;
>
> @@ -1962,6 +2120,15 @@ static int __cmd_contention(int argc, const char *=
*argv)
>         if (select_key(true))
>                 goto out_delete;
>
> +       if (symbol_conf.field_sep) {
> +               int i;
> +               struct lock_key *keys =3D contention_keys;
> +
> +               /* do not align output in CSV format */
> +               for (i =3D 0; keys[i].name; i++)
> +                       keys[i].len =3D 0;
> +       }
> +
>         if (use_bpf) {
>                 lock_contention_start();
>                 if (argc)
> @@ -2330,6 +2497,8 @@ int cmd_lock(int argc, const char **argv)
>         OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
>                      "Filter specific function in the callstack", parse_c=
all_stack),
>         OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owner=
s instead of waiters"),
> +       OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep=
, "separator",
> +                  "print result in CSV format with custom separator"),
>         OPT_PARENT(lock_options)
>         };
>
> --
> 2.41.0.255.g8b1d071c50-goog
>
