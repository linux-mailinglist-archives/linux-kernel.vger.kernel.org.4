Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C49743F80
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjF3QOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjF3QOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:14:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9613AAD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:14:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40345bf4875so148991cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688141643; x=1690733643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwYr2ZD/8ZWnO4Xj07hSpuP/dVxj1HlExl+/gKMpnGI=;
        b=7EfGlNRuaPp1z0kJmSqyFqK4qN5WcNW+/fxO/gSGSQzqy18MkCktaiBCn2LduIpJny
         r+gEpSlIQTafmlbu1JTD1VZhAOrXtRhJW7cEbt5Q0XN4HJcaZzeetG/ry0sir6mIdJvQ
         s8RY33YPO/32uDiEkCe/r/iEIUtA4Cei8+a3AqDT3JC/MnWc0AeKYTzzuRPyvz/Du/kh
         uHUkQZ/uko6XKV0tR8V9xG2R0bmH+eveEPAV8bMPpannTuHSySj5TxsvSB1beUTcoODn
         c9JiS46Hj9V+A9TlxmF46rE0eLrAG9I20y34TCTYFOOdn1Ts8HVGcJQp7LnkK6lvrkjh
         9JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141643; x=1690733643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwYr2ZD/8ZWnO4Xj07hSpuP/dVxj1HlExl+/gKMpnGI=;
        b=BUkZ9AG+9FYodyTct+Z746V+hzmGxVaxz9KmVEsIkXxhHjhiD+iXpmD8/2vQZRA1WL
         fHZPTZ7QelML1j9hN5P0ZpZhjfFVJ606zL3RblbNWPn73nNCLIKaTBXSE5Ubu6eRPuCT
         T4jG8Nq4oMhbfp1qvIk0KzCTdXxxgLjx3rpK3gnYHAvcEcrhGpUmIMsUsxkM4lw/lUeM
         YweawCi4nLsifoQrGSzLgLgi0Q6rH3n2uQTzo/JvBNEVpvGSRJ6QgYmjeLzx7qcpKeUu
         pyxfbjLD5afhyFk3NlQHyB18vn/Uv2DN/RIItpw3pk9uF/XFtdRmPzckkqi5+CAd5K54
         FE4w==
X-Gm-Message-State: AC+VfDyIJzzqDnUC3lhbIvX/zD13uI0P9P2/RRCy5yg10GgFxCn/g0ay
        43ocBvh+vEHM+ZVgUWG41bFfyGgs8Z7ApBlCgU6mDA==
X-Google-Smtp-Source: ACHHUZ4pLQK2D7/WrgyPQH/dNOlOT3FnvGuF1yG4Ukf3tigoWjYuFdsE87agCHIEEkH4752EazqhyZDrlnFCQaWxSf0=
X-Received: by 2002:ac8:5843:0:b0:3ef:404a:b291 with SMTP id
 h3-20020ac85843000000b003ef404ab291mr814868qth.7.1688141643169; Fri, 30 Jun
 2023 09:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org> <20230628200141.2739587-4-namhyung@kernel.org>
In-Reply-To: <20230628200141.2739587-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 09:13:51 -0700
Message-ID: <CAP-5=fUiuVevgNkhxzXpU2B8RkZ4E7HdPLoZ6KU_yWmp73Y_Cg@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf lock contention: Add --output option
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> To avoid formatting failures for example in CSV output due to debug
> messages, add --output option to put the result in a file.
> Unfortunately the short -o option was taken by the --owner already.
>
>   $ sudo ./perf lock con -ab --output lock-out.txt -v sleep 1
>   Looking at the vmlinux_path (8 entries long)
>   symsrc__init: cannot get elf header.
>   Using /proc/kcore for kernel data
>   Using /proc/kallsyms for symbols
>
>   $ head lock-out.txt
>    contended   total wait     max wait     avg wait         type   caller
>
>            3     76.79 us     26.89 us     25.60 us     rwlock:R   ep_pol=
l_callback+0x2d
>                         0xffffffff9a23f4b5  _raw_read_lock_irqsave+0x45
>                         0xffffffff99bbd4dd  ep_poll_callback+0x2d
>                         0xffffffff999029f3  __wake_up_common+0x73
>                         0xffffffff99902b82  __wake_up_common_lock+0x82
>                         0xffffffff99fa5b1c  sock_def_readable+0x3c
>                         0xffffffff9a11521d  unix_stream_sendmsg+0x18d
>                         0xffffffff99f9fc9c  sock_sendmsg+0x5c
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Making some of my previous suggestions mute :-)

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
> ---
>  tools/perf/Documentation/perf-lock.txt |   3 +
>  tools/perf/builtin-lock.c              | 140 +++++++++++++++----------
>  2 files changed, 85 insertions(+), 58 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index d1efcbe7a470..30eea576721f 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -36,6 +36,9 @@ COMMON OPTIONS
>  --input=3D<file>::
>          Input file name. (default: perf.data unless stdin is a fifo)
>
> +--output=3D<file>::
> +        Output file name for perf lock contention and report.
> +
>  -v::
>  --verbose::
>          Be more verbose (show symbol address, etc).
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 98b0c0b1b307..c15386cb1033 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -27,6 +27,7 @@
>  #include "util/map.h"
>  #include "util/util.h"
>
> +#include <stdio.h>
>  #include <sys/types.h>
>  #include <sys/prctl.h>
>  #include <semaphore.h>
> @@ -65,6 +66,8 @@ static int max_stack_depth =3D CONTENTION_STACK_DEPTH;
>  static int stack_skip =3D CONTENTION_STACK_SKIP;
>  static int print_nr_entries =3D INT_MAX / 2;
>  static LIST_HEAD(callstack_filters);
> +static const char *output_name =3D NULL;
> +static FILE *lock_output;
>
>  struct callstack_filter {
>         struct list_head list;
> @@ -227,7 +230,7 @@ static void lock_stat_key_print_time(unsigned long lo=
ng nsec, int len)
>
>         /* for CSV output */
>         if (len =3D=3D 0) {
> -               pr_info("%llu", nsec);
> +               fprintf(lock_output, "%llu", nsec);
>                 return;
>         }
>
> @@ -235,18 +238,18 @@ static void lock_stat_key_print_time(unsigned long =
long nsec, int len)
>                 if (nsec < table[i].base)
>                         continue;
>
> -               pr_info("%*.2f %s", len - 3, nsec / table[i].base, table[=
i].unit);
> +               fprintf(lock_output, "%*.2f %s", len - 3, nsec / table[i]=
.base, table[i].unit);
>                 return;
>         }
>
> -       pr_info("%*llu %s", len - 3, nsec, "ns");
> +       fprintf(lock_output, "%*llu %s", len - 3, nsec, "ns");
>  }
>
>  #define PRINT_KEY(member)                                              \
>  static void lock_stat_key_print_ ## member(struct lock_key *key,       \
>                                            struct lock_stat *ls)        \
>  {                                                                      \
> -       pr_info("%*llu", key->len, (unsigned long long)ls->member);     \
> +       fprintf(lock_output, "%*llu", key->len, (unsigned long long)ls->m=
ember);\
>  }
>
>  #define PRINT_TIME(member)                                             \
> @@ -1335,12 +1338,12 @@ static void print_bad_events(int bad, int total)
>         if (quiet || total =3D=3D 0 || (broken =3D=3D 0 && verbose <=3D 0=
))
>                 return;
>
> -       pr_info("\n=3D=3D=3D output for debug =3D=3D=3D\n\n");
> -       pr_info("bad: %d, total: %d\n", bad, total);
> -       pr_info("bad rate: %.2f %%\n", (double)bad / (double)total * 100)=
;
> -       pr_info("histogram of events caused bad sequence\n");
> +       fprintf(lock_output, "\n=3D=3D=3D output for debug =3D=3D=3D\n\n"=
);
> +       fprintf(lock_output, "bad: %d, total: %d\n", bad, total);
> +       fprintf(lock_output, "bad rate: %.2f %%\n", (double)bad / (double=
)total * 100);
> +       fprintf(lock_output, "histogram of events caused bad sequence\n")=
;
>         for (i =3D 0; i < BROKEN_MAX; i++)
> -               pr_info(" %10s: %d\n", name[i], bad_hist[i]);
> +               fprintf(lock_output, " %10s: %d\n", name[i], bad_hist[i])=
;
>  }
>
>  /* TODO: various way to print, coloring, nano or milli sec */
> @@ -1352,10 +1355,10 @@ static void print_result(void)
>         int bad, total, printed;
>
>         if (!quiet) {
> -               pr_info("%20s ", "Name");
> +               fprintf(lock_output, "%20s ", "Name");
>                 list_for_each_entry(key, &lock_keys, list)
> -                       pr_info("%*s ", key->len, key->header);
> -               pr_info("\n\n");
> +                       fprintf(lock_output, "%*s ", key->len, key->heade=
r);
> +               fprintf(lock_output, "\n\n");
>         }
>
>         bad =3D total =3D printed =3D 0;
> @@ -1380,7 +1383,7 @@ static void print_result(void)
>                                 name =3D thread__comm_str(t);
>                         }
>
> -                       pr_info("%20s ", name);
> +                       fprintf(lock_output, "%20s ", name);
>                 } else {
>                         strncpy(cut_name, st->name, 16);
>                         cut_name[16] =3D '.';
> @@ -1388,14 +1391,14 @@ static void print_result(void)
>                         cut_name[18] =3D '.';
>                         cut_name[19] =3D '\0';
>                         /* cut off name for saving output style */
> -                       pr_info("%20s ", cut_name);
> +                       fprintf(lock_output, "%20s ", cut_name);
>                 }
>
>                 list_for_each_entry(key, &lock_keys, list) {
>                         key->print(key, st);
> -                       pr_info(" ");
> +                       fprintf(lock_output, " ");
>                 }
> -               pr_info("\n");
> +               fprintf(lock_output, "\n");
>
>                 if (++printed >=3D print_nr_entries)
>                         break;
> @@ -1412,13 +1415,13 @@ static void dump_threads(void)
>         struct rb_node *node;
>         struct thread *t;
>
> -       pr_info("%10s: comm\n", "Thread ID");
> +       fprintf(lock_output, "%10s: comm\n", "Thread ID");
>
>         node =3D rb_first(&thread_stats);
>         while (node) {
>                 st =3D container_of(node, struct thread_stat, rb);
>                 t =3D perf_session__findnew(session, st->tid);
> -               pr_info("%10d: %s\n", st->tid, thread__comm_str(t));
> +               fprintf(lock_output, "%10d: %s\n", st->tid, thread__comm_=
str(t));
>                 node =3D rb_next(node);
>                 thread__put(t);
>         }
> @@ -1444,7 +1447,7 @@ static void dump_map(void)
>         unsigned int i;
>         struct lock_stat *st;
>
> -       pr_info("Address of instance: name of class\n");
> +       fprintf(lock_output, "Address of instance: name of class\n");
>         for (i =3D 0; i < LOCKHASH_SIZE; i++) {
>                 hlist_for_each_entry(st, &lockhash_table[i], hash_entry) =
{
>                         insert_to_result(st, compare_maps);
> @@ -1452,7 +1455,7 @@ static void dump_map(void)
>         }
>
>         while ((st =3D pop_from_result()))
> -               pr_info(" %#llx: %s\n", (unsigned long long)st->addr, st-=
>name);
> +               fprintf(lock_output, " %#llx: %s\n", (unsigned long long)=
st->addr, st->name);
>  }
>
>  static int dump_info(void)
> @@ -1637,18 +1640,18 @@ static void print_header_stdio(void)
>         struct lock_key *key;
>
>         list_for_each_entry(key, &lock_keys, list)
> -               pr_info("%*s ", key->len, key->header);
> +               fprintf(lock_output, "%*s ", key->len, key->header);
>
>         switch (aggr_mode) {
>         case LOCK_AGGR_TASK:
> -               pr_info("  %10s   %s\n\n", "pid",
> +               fprintf(lock_output, "  %10s   %s\n\n", "pid",
>                         show_lock_owner ? "owner" : "comm");
>                 break;
>         case LOCK_AGGR_CALLER:
> -               pr_info("  %10s   %s\n\n", "type", "caller");
> +               fprintf(lock_output, "  %10s   %s\n\n", "type", "caller")=
;
>                 break;
>         case LOCK_AGGR_ADDR:
> -               pr_info("  %16s   %s\n\n", "address", "symbol");
> +               fprintf(lock_output, "  %16s   %s\n\n", "address", "symbo=
l");
>                 break;
>         default:
>                 break;
> @@ -1659,23 +1662,23 @@ static void print_header_csv(const char *sep)
>  {
>         struct lock_key *key;
>
> -       pr_info("# output: ");
> +       fprintf(lock_output, "# output: ");
>         list_for_each_entry(key, &lock_keys, list)
> -               pr_info("%s%s ", key->header, sep);
> +               fprintf(lock_output, "%s%s ", key->header, sep);
>
>         switch (aggr_mode) {
>         case LOCK_AGGR_TASK:
> -               pr_info("%s%s %s\n", "pid", sep,
> +               fprintf(lock_output, "%s%s %s\n", "pid", sep,
>                         show_lock_owner ? "owner" : "comm");
>                 break;
>         case LOCK_AGGR_CALLER:
> -               pr_info("%s%s %s", "type", sep, "caller");
> +               fprintf(lock_output, "%s%s %s", "type", sep, "caller");
>                 if (verbose > 0)
> -                       pr_info("%s %s", sep, "stacktrace");
> -               pr_info("\n");
> +                       fprintf(lock_output, "%s %s", sep, "stacktrace");
> +               fprintf(lock_output, "\n");
>                 break;
>         case LOCK_AGGR_ADDR:
> -               pr_info("%s%s %s%s %s\n", "address", sep, "symbol", sep, =
"type");
> +               fprintf(lock_output, "%s%s %s%s %s\n", "address", sep, "s=
ymbol", sep, "type");
>                 break;
>         default:
>                 break;
> @@ -1700,21 +1703,21 @@ static void print_lock_stat_stdio(struct lock_con=
tention *con, struct lock_stat
>
>         list_for_each_entry(key, &lock_keys, list) {
>                 key->print(key, st);
> -               pr_info(" ");
> +               fprintf(lock_output, " ");
>         }
>
>         switch (aggr_mode) {
>         case LOCK_AGGR_CALLER:
> -               pr_info("  %10s   %s\n", get_type_str(st->flags), st->nam=
e);
> +               fprintf(lock_output, "  %10s   %s\n", get_type_str(st->fl=
ags), st->name);
>                 break;
>         case LOCK_AGGR_TASK:
>                 pid =3D st->addr;
>                 t =3D perf_session__findnew(session, pid);
> -               pr_info("  %10d   %s\n",
> +               fprintf(lock_output, "  %10d   %s\n",
>                         pid, pid =3D=3D -1 ? "Unknown" : thread__comm_str=
(t));
>                 break;
>         case LOCK_AGGR_ADDR:
> -               pr_info("  %016llx   %s (%s)\n", (unsigned long long)st->=
addr,
> +               fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned l=
ong long)st->addr,
>                         st->name, get_type_name(st->flags));
>                 break;
>         default:
> @@ -1734,7 +1737,7 @@ static void print_lock_stat_stdio(struct lock_conte=
ntion *con, struct lock_stat
>                         ip =3D st->callstack[i];
>                         sym =3D machine__find_kernel_symbol(con->machine,=
 ip, &kmap);
>                         get_symbol_name_offset(kmap, sym, ip, buf, sizeof=
(buf));
> -                       pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, bu=
f);
> +                       fprintf(lock_output, "\t\t\t%#lx  %s\n", (unsigne=
d long)ip, buf);
>                 }
>         }
>  }
> @@ -1748,22 +1751,23 @@ static void print_lock_stat_csv(struct lock_conte=
ntion *con, struct lock_stat *s
>
>         list_for_each_entry(key, &lock_keys, list) {
>                 key->print(key, st);
> -               pr_info("%s ", sep);
> +               fprintf(lock_output, "%s ", sep);
>         }
>
>         switch (aggr_mode) {
>         case LOCK_AGGR_CALLER:
> -               pr_info("%s%s %s", get_type_str(st->flags), sep, st->name=
);
> +               fprintf(lock_output, "%s%s %s", get_type_str(st->flags), =
sep, st->name);
>                 if (verbose <=3D 0)
> -                       pr_info("\n");
> +                       fprintf(lock_output, "\n");
>                 break;
>         case LOCK_AGGR_TASK:
>                 pid =3D st->addr;
>                 t =3D perf_session__findnew(session, pid);
> -               pr_info("%d%s %s\n", pid, sep, pid =3D=3D -1 ? "Unknown" =
: thread__comm_str(t));
> +               fprintf(lock_output, "%d%s %s\n", pid, sep,
> +                       pid =3D=3D -1 ? "Unknown" : thread__comm_str(t));
>                 break;
>         case LOCK_AGGR_ADDR:
> -               pr_info("%llx%s %s%s %s\n", (unsigned long long)st->addr,=
 sep,
> +               fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long l=
ong)st->addr, sep,
>                         st->name, sep, get_type_name(st->flags));
>                 break;
>         default:
> @@ -1783,9 +1787,9 @@ static void print_lock_stat_csv(struct lock_content=
ion *con, struct lock_stat *s
>                         ip =3D st->callstack[i];
>                         sym =3D machine__find_kernel_symbol(con->machine,=
 ip, &kmap);
>                         get_symbol_name_offset(kmap, sym, ip, buf, sizeof=
(buf));
> -                       pr_info("%s %#lx %s", i ? ":" : sep, (unsigned lo=
ng) ip, buf);
> +                       fprintf(lock_output, "%s %#lx %s", i ? ":" : sep,=
 (unsigned long) ip, buf);
>                 }
> -               pr_info("\n");
> +               fprintf(lock_output, "\n");
>         }
>  }
>
> @@ -1809,15 +1813,15 @@ static void print_footer_stdio(int total, int bad=
, struct lock_contention_fails
>                 return;
>
>         total +=3D broken;
> -       pr_info("\n=3D=3D=3D output for debug =3D=3D=3D\n\n");
> -       pr_info("bad: %d, total: %d\n", broken, total);
> -       pr_info("bad rate: %.2f %%\n", (double)broken / (double)total * 1=
00);
> +       fprintf(lock_output, "\n=3D=3D=3D output for debug =3D=3D=3D\n\n"=
);
> +       fprintf(lock_output, "bad: %d, total: %d\n", broken, total);
> +       fprintf(lock_output, "bad rate: %.2f %%\n", 100.0 * broken / tota=
l);
>
> -       pr_info("histogram of failure reasons\n");
> -       pr_info(" %10s: %d\n", "task", fails->task);
> -       pr_info(" %10s: %d\n", "stack", fails->stack);
> -       pr_info(" %10s: %d\n", "time", fails->time);
> -       pr_info(" %10s: %d\n", "data", fails->data);
> +       fprintf(lock_output, "histogram of failure reasons\n");
> +       fprintf(lock_output, " %10s: %d\n", "task", fails->task);
> +       fprintf(lock_output, " %10s: %d\n", "stack", fails->stack);
> +       fprintf(lock_output, " %10s: %d\n", "time", fails->time);
> +       fprintf(lock_output, " %10s: %d\n", "data", fails->data);
>  }
>
>  static void print_footer_csv(int total, int bad, struct lock_contention_=
fails *fails,
> @@ -1831,21 +1835,21 @@ static void print_footer_csv(int total, int bad, =
struct lock_contention_fails *f
>                 return;
>
>         total +=3D bad;
> -       pr_info("# debug: total=3D%d%s bad=3D%d", total, sep, bad);
> +       fprintf(lock_output, "# debug: total=3D%d%s bad=3D%d", total, sep=
, bad);
>
>         if (use_bpf) {
> -               pr_info("%s bad_%s=3D%d", sep, "task", fails->task);
> -               pr_info("%s bad_%s=3D%d", sep, "stack", fails->stack);
> -               pr_info("%s bad_%s=3D%d", sep, "time", fails->time);
> -               pr_info("%s bad_%s=3D%d", sep, "data", fails->data);
> +               fprintf(lock_output, "%s bad_%s=3D%d", sep, "task", fails=
->task);
> +               fprintf(lock_output, "%s bad_%s=3D%d", sep, "stack", fail=
s->stack);
> +               fprintf(lock_output, "%s bad_%s=3D%d", sep, "time", fails=
->time);
> +               fprintf(lock_output, "%s bad_%s=3D%d", sep, "data", fails=
->data);
>         } else {
>                 int i;
>                 const char *name[4] =3D { "acquire", "acquired", "contend=
ed", "release" };
>
>                 for (i =3D 0; i < BROKEN_MAX; i++)
> -                       pr_info("%s bad_%s=3D%d", sep, name[i], bad_hist[=
i]);
> +                       fprintf(lock_output, "%s bad_%s=3D%d", sep, name[=
i], bad_hist[i]);
>         }
> -       pr_info("\n");
> +       fprintf(lock_output, "\n");
>  }
>
>  static void print_footer(int total, int bad, struct lock_contention_fail=
s *fails)
> @@ -2427,10 +2431,29 @@ static int parse_call_stack(const struct option *=
opt __maybe_unused, const char
>         return ret;
>  }
>
> +static int parse_output(const struct option *opt __maybe_unused, const c=
har *str,
> +                       int unset __maybe_unused)
> +{
> +       const char **name =3D (const char **)opt->value;
> +
> +       if (str =3D=3D NULL)
> +               return -1;
> +
> +       lock_output =3D fopen(str, "w");
> +       if (lock_output =3D=3D NULL) {
> +               pr_err("Cannot open %s\n", str);
> +               return -1;
> +       }
> +
> +       *name =3D str;
> +       return 0;
> +}
> +
>  int cmd_lock(int argc, const char **argv)
>  {
>         const struct option lock_options[] =3D {
>         OPT_STRING('i', "input", &input_name, "file", "input file name"),
> +       OPT_CALLBACK(0, "output", &output_name, "file", "output file name=
", parse_output),
>         OPT_INCR('v', "verbose", &verbose, "be more verbose (show symbol =
address, etc)"),
>         OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace, "dump raw trace i=
n ASCII"),
>         OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
> @@ -2530,6 +2553,7 @@ int cmd_lock(int argc, const char **argv)
>         for (i =3D 0; i < LOCKHASH_SIZE; i++)
>                 INIT_HLIST_HEAD(lockhash_table + i);
>
> +       lock_output =3D stderr;
>         argc =3D parse_options_subcommand(argc, argv, lock_options, lock_=
subcommands,
>                                         lock_usage, PARSE_OPT_STOP_AT_NON=
_OPTION);
>         if (!argc)
> --
> 2.41.0.255.g8b1d071c50-goog
>
