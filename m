Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074F5E879A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiIXCtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiIXCtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:49:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C82BD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:49:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iv17so1265615wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=44PHLAFFr/xjmdOFKAz7bT66nwC87SvDUnUenHVK6zs=;
        b=b3l1JF04D5cK9FCSUV5yWpe4jXQiO38hhNC3eUjZlPtHMRXMMWyrh0z3ni5wqx6fH6
         jN7ITFhgb2CBFxFmv5ihybT0ZJT83vXIdn7g4V0AY1K67jqon0uIR3pJBhCKpLMFB8ln
         OIIcWg4OowwRGBMAVua8wBEX1bwMKgOhvyI8KA+Dyyzn7UnL8JiewJ8FFN6WhdjHQhU/
         npspuKctZsjZs2EynN2+8cUTJkLu42Wlq5zEoiCewf5bZEJPUoQSHMOMz/rjs79UjU+2
         noyVgLcfRVmPOojS83iKKW6rG8x8PiwzhaXRcIOzKlstWUJeDFXBIojAJrl1boqhJpKe
         qaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=44PHLAFFr/xjmdOFKAz7bT66nwC87SvDUnUenHVK6zs=;
        b=oF7txgKvccKyG7Dn2ieH54eOMYlqz1kpMJOCYMvpsIfkfSDxDVJB0+mJlTV0oep7wt
         lGxe6ACastWdVqfv2LAPbsi6mOk8Emqk6Cp8DYWNo1NQiNU3Xyk/0PBsOEtLNokvEcQa
         qIY9N7zwYdzVX/qTTU7G5xqrYhV2OC2TYyG+D7xKzUi6idYyRsc47XH4A4CeDvp4/6J2
         BM9zsiwiYcXvn8fs8rmqUaTSeUI5hMtRfkAVYrQQTn5rS76L7uz0sxOaZ59dF1EiQ0lm
         L2kTy+S4KSvN9tymhrxxtem45QmJh2q5zFlUVW90DH/aB9MR1Fr6zLUw2iurxF8cicvo
         R7gw==
X-Gm-Message-State: ACrzQf37fuFu0B75AUxUKqKS5U78a+bv+B824MzWl8/u67t6IhAkbnek
        43oeJbWeL5JUvjK+KG1z9toUvBTOErQ5EYEh+87L4w==
X-Google-Smtp-Source: AMsMyM4C+4WatuahEwxP306EwjKhsVg7m9cZ3qPR2p8oC8RBnzW5zW9Cr+BjevJj2xWJdNkOURUNKoyiOSeQU6QMT8k=
X-Received: by 2002:a7b:ca54:0:b0:3b4:fb06:9b1 with SMTP id
 m20-20020a7bca54000000b003b4fb0609b1mr7642630wml.67.1663987767740; Fri, 23
 Sep 2022 19:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220924004221.841024-1-namhyung@kernel.org>
In-Reply-To: <20220924004221.841024-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 19:49:14 -0700
Message-ID: <CAP-5=fUb9muc-5ncaOvWjciXydOhiS7S+5y_L8QR=A-PDU2jCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf lock: Add -E/--entries option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 5:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Like perf top, the -E option can limit number of entries to print.
> It can be useful when users want to see top N contended locks only.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-lock.txt | 10 ++++++++++
>  tools/perf/builtin-lock.c              | 20 +++++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 5f2dc634258e..b23e76200ac2 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -94,6 +94,11 @@ REPORT OPTIONS
>           EventManager_De       1845          1             636
>           futex-default-S       1609          0               0
>
> +-E::
> +--entries=<value>::
> +       Display this many entries.
> +
> +
>  INFO OPTIONS
>  ------------
>
> @@ -105,6 +110,7 @@ INFO OPTIONS
>  --map::
>         dump map of lock instances (address:name table)
>
> +
>  CONTENTION OPTIONS
>  --------------
>
> @@ -154,6 +160,10 @@ CONTENTION OPTIONS
>  --stack-skip
>         Number of stack depth to skip when finding a lock caller (default: 3).
>
> +-E::
> +--entries=<value>::
> +       Display this many entries.
> +
>
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 25d75fa09b90..1c0d52384d9e 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -58,6 +58,7 @@ static bool use_bpf;
>  static unsigned long bpf_map_entries = 10240;
>  static int max_stack_depth = CONTENTION_STACK_DEPTH;
>  static int stack_skip = CONTENTION_STACK_SKIP;
> +static int print_nr_entries = INT_MAX / 2;
>
>  static enum {
>         LOCK_AGGR_ADDR,
> @@ -1266,14 +1267,14 @@ static void print_result(void)
>         struct lock_stat *st;
>         struct lock_key *key;
>         char cut_name[20];
> -       int bad, total;
> +       int bad, total, printed;
>
>         pr_info("%20s ", "Name");
>         list_for_each_entry(key, &lock_keys, list)
>                 pr_info("%*s ", key->len, key->header);
>         pr_info("\n\n");
>
> -       bad = total = 0;
> +       bad = total = printed = 0;
>         while ((st = pop_from_result())) {
>                 total++;
>                 if (st->broken)
> @@ -1311,6 +1312,9 @@ static void print_result(void)
>                         pr_info(" ");
>                 }
>                 pr_info("\n");
> +
> +               if (++printed >= print_nr_entries)
> +                       break;
>         }
>
>         print_bad_events(bad, total);
> @@ -1476,7 +1480,7 @@ static void print_contention_result(struct lock_contention *con)
>  {
>         struct lock_stat *st;
>         struct lock_key *key;
> -       int bad, total;
> +       int bad, total, printed;
>
>         list_for_each_entry(key, &lock_keys, list)
>                 pr_info("%*s ", key->len, key->header);
> @@ -1486,7 +1490,7 @@ static void print_contention_result(struct lock_contention *con)
>         else
>                 pr_info("  %10s   %s\n\n", "type", "caller");
>
> -       bad = total = 0;
> +       bad = total = printed = 0;
>         if (use_bpf)
>                 bad = bad_hist[BROKEN_CONTENDED];
>
> @@ -1507,7 +1511,7 @@ static void print_contention_result(struct lock_contention *con)
>                         /* st->addr contains tid of thread */
>                         t = perf_session__findnew(session, pid);
>                         pr_info("  %10d   %s\n", pid, thread__comm_str(t));
> -                       continue;
> +                       goto next;
>                 }
>
>                 pr_info("  %10s   %s\n", get_type_str(st), st->name);
> @@ -1527,6 +1531,10 @@ static void print_contention_result(struct lock_contention *con)
>                                 pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
>                         }
>                 }
> +
> +next:
> +               if (++printed >= print_nr_entries)
> +                       break;
>         }
>
>         print_bad_events(bad, total);
> @@ -1878,6 +1886,7 @@ int cmd_lock(int argc, const char **argv)
>                     "combine locks in the same class"),
>         OPT_BOOLEAN('t', "threads", &show_thread_stats,
>                     "show per-thread lock stats"),
> +       OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>         OPT_PARENT(lock_options)
>         };
>
> @@ -1905,6 +1914,7 @@ int cmd_lock(int argc, const char **argv)
>         OPT_INTEGER(0, "stack-skip", &stack_skip,
>                     "Set the number of stack depth to skip when finding a lock caller, "
>                     "Default: " __stringify(CONTENTION_STACK_SKIP)),
> +       OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>         OPT_PARENT(lock_options)
>         };
>
> --
> 2.37.3.998.g577e59143f-goog
>
