Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B857F5E879B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiIXCt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiIXCtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:49:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C41F38A20
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:49:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id iv17so1265836wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qgmabv58fZ9njrtbIOHmEKJQiz9eDWNFD6BIt5tb1rU=;
        b=PKdVNU9KaKqKRM8PYKTuQtSOueBpzfCKl5iXrQaZ4b8qqczbAXTNXHtZnmljZfOCU8
         IB2WRCN7/kPkCBynRzT2hxzRRGyCQH1sqCvLBiFr5Xk+jizzOt9GG63orsLcmOBdAHib
         Pftb7Q8gEO2GA3Cu4K1RNg84Tw6ZprBXkE6mzsFXlGdY2hJXMqcXgq+NKfwtpnLaJjLk
         SU4iWH7a1RoJ31kQUIKJXxXcTySMPgz1MJjZsBIBmQnHfWcA/we+tBlI9MKsStxxDVCd
         r5fnAs4zdIyGYMmeZt2fIf3ELqcOOuv1eikvmAEi3vZ34GPKN+jhjuz6+PTx0HDytXQB
         xoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qgmabv58fZ9njrtbIOHmEKJQiz9eDWNFD6BIt5tb1rU=;
        b=FHfJLrhh0eZMjWQmQkAJSxMp4t23HyHX3h7dO16oUUjbYZH8Rx/V3SU1SgBguxRQEV
         oj8bpPZ0G8RCEbUcNcR/0g2woFYNNRepEj74hM4cyP9IEtNsTJhSzUbT70GWPmKlJ8fd
         007Mw/VaKLSX8DyWyJYpzqeEIDqyA+FppfVKbtfmJneJNPTJn8knDBvesEkX3sJ4MfOM
         YB/6hTc3onNK0ofWWpk8zUAqUMsjYH9OaGkxqWwkdvkD2cX9FdozcxHwXLSBD6ZZkRQe
         vPLeuGuEeCNpOUGEP02pTiK1NQ3qmx1ByWY2voBGiFbwpCVUArnbQGMqxaBhIekVwSST
         SBEw==
X-Gm-Message-State: ACrzQf0sK0lYfkc5zBCJry9TK2CRm05b+dO0NjhdqoR9921HTKb4s+q/
        LgkRyDqsYspnYgf68aB9PPyxfJJz4fUJ1s7b/RVXdA==
X-Google-Smtp-Source: AMsMyM41uVSJYY5fUD/F9eLoJ1DNhw1bur5QbKbBhIuTn0jRLcmUBoQZ0bAUEvnH2/7ovV5871ygomLr+PnwItUnSgA=
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id
 u8-20020a7bc048000000b003b4fb26f0f3mr10828377wmc.115.1663987787283; Fri, 23
 Sep 2022 19:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220924004221.841024-1-namhyung@kernel.org> <20220924004221.841024-2-namhyung@kernel.org>
In-Reply-To: <20220924004221.841024-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 19:49:34 -0700
Message-ID: <CAP-5=fW6-w=+zkZ2820yg6GUR5X-=JP1RBOm1JMMr7osLkiW4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf lock: Add -q/--quiet option
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
> Like perf report, this option is to suppress header and debug messages.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-lock.txt |  4 ++++
>  tools/perf/builtin-lock.c              | 27 +++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index b23e76200ac2..3b1e16563b79 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -40,6 +40,10 @@ COMMON OPTIONS
>  --verbose::
>          Be more verbose (show symbol address, etc).
>
> +-q::
> +--quiet::
> +       Do not show any message. (Suppress -v)
> +
>  -D::
>  --dump-raw-trace::
>          Dump raw trace in ASCII.
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 1c0d52384d9e..9722d4ab2e55 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1250,7 +1250,7 @@ static void print_bad_events(int bad, int total)
>         for (i = 0; i < BROKEN_MAX; i++)
>                 broken += bad_hist[i];
>
> -       if (broken == 0 && !verbose)
> +       if (quiet || (broken == 0 && !verbose))
>                 return;
>
>         pr_info("\n=== output for debug===\n\n");
> @@ -1269,10 +1269,12 @@ static void print_result(void)
>         char cut_name[20];
>         int bad, total, printed;
>
> -       pr_info("%20s ", "Name");
> -       list_for_each_entry(key, &lock_keys, list)
> -               pr_info("%*s ", key->len, key->header);
> -       pr_info("\n\n");
> +       if (!quiet) {
> +               pr_info("%20s ", "Name");
> +               list_for_each_entry(key, &lock_keys, list)
> +                       pr_info("%*s ", key->len, key->header);
> +               pr_info("\n\n");
> +       }
>
>         bad = total = printed = 0;
>         while ((st = pop_from_result())) {
> @@ -1482,13 +1484,15 @@ static void print_contention_result(struct lock_contention *con)
>         struct lock_key *key;
>         int bad, total, printed;
>
> -       list_for_each_entry(key, &lock_keys, list)
> -               pr_info("%*s ", key->len, key->header);
> +       if (!quiet) {
> +               list_for_each_entry(key, &lock_keys, list)
> +                       pr_info("%*s ", key->len, key->header);
>
> -       if (show_thread_stats)
> -               pr_info("  %10s   %s\n\n", "pid", "comm");
> -       else
> -               pr_info("  %10s   %s\n\n", "type", "caller");
> +               if (show_thread_stats)
> +                       pr_info("  %10s   %s\n\n", "pid", "comm");
> +               else
> +                       pr_info("  %10s   %s\n\n", "type", "caller");
> +       }
>
>         bad = total = printed = 0;
>         if (use_bpf)
> @@ -1865,6 +1869,7 @@ int cmd_lock(int argc, const char **argv)
>                    "file", "vmlinux pathname"),
>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>                    "file", "kallsyms pathname"),
> +       OPT_BOOLEAN('q', "quiet", &quiet, "Do not show any message"),
>         OPT_END()
>         };
>
> --
> 2.37.3.998.g577e59143f-goog
>
