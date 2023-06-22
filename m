Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0777395EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFVDwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 23:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFVDwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:52:11 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9661BD4;
        Wed, 21 Jun 2023 20:52:07 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f866383b25so58258111cf.2;
        Wed, 21 Jun 2023 20:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687405927; x=1689997927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJIEGRogedDSySy/in7S1jLWRFNMM5lAJSXnknF9fS4=;
        b=B/WXWJkZyrmOOm8kI6eEfmuzcdf+lPuOiv5Q/o3oqPqFMjICltDNeJIdejaIJL+c3p
         Ied9A1e/88A9piAJPYDkmQ6UkowgS3HBn3TGaNwl/6hbBKCjXobCeFCjpo9P4zC83GVW
         QNmGQn3IlOq8Ppm/9MPK/aNkqNKQYVdiytwAwYZBHXOzQt93YWrDA7tqmZV3jWGjfvMk
         dGft8NeWMPWwE+XqN6AXNr0AlAfu6OIAmNgksc8og1Atn6OrTisGjdaXdqq5Ii2TNx6z
         L92kor/G5xErr3GaiSQSg8jKbzUkbVdB3FS0kAXNyFNkBKfly61/qQPTJr64JoOJVIMd
         EWjA==
X-Gm-Message-State: AC+VfDxsYUyxm8ucSsa5FndTzV8NlFQ2RHBE/G2ONlwjEgbtgC/e0hc4
        FBxLmSylZDIQsd62cidKhOJowM4Wl+GFxlFHOf4=
X-Google-Smtp-Source: ACHHUZ5aWT1ag0gDE0MRudTVEeeQRT7TbV84nEWMFV/slc5G62552tQDb4KKUuNbDVs1GznhYS8pi/YxLsOuNEfsQnE=
X-Received: by 2002:a05:622a:391:b0:3f6:ba9d:50fc with SMTP id
 j17-20020a05622a039100b003f6ba9d50fcmr22093554qtx.31.1687405926784; Wed, 21
 Jun 2023 20:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063749.3358430-1-irogers@google.com> <20230621063749.3358430-2-irogers@google.com>
In-Reply-To: <20230621063749.3358430-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 20:51:55 -0700
Message-ID: <CAM9d7cjAiwXHAO71cjEWjBzDeau5FOMo4QNzfugSFRXy1o0oyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf symbol_conf: Remove now unused sort_by_name
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:37 PM Ian Rogers <irogers@google.com> wrote:
>
> Previously used to specify symbol_name_rb_node was in use.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-kallsyms.c   | 1 -
>  tools/perf/builtin-lock.c       | 2 --
>  tools/perf/builtin-report.c     | 1 -
>  tools/perf/tests/builtin-test.c | 1 -
>  tools/perf/util/probe-event.c   | 1 -
>  tools/perf/util/symbol_conf.h   | 1 -
>  6 files changed, 7 deletions(-)
>
> diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
> index 3751df744577..7f75c5b73f26 100644
> --- a/tools/perf/builtin-kallsyms.c
> +++ b/tools/perf/builtin-kallsyms.c
> @@ -62,7 +62,6 @@ int cmd_kallsyms(int argc, const char **argv)
>         if (argc < 1)
>                 usage_with_options(kallsyms_usage, options);
>
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
>         if (symbol__init(NULL) < 0)
>                 return -1;
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 8b505e1e5002..da36ace66d68 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1774,7 +1774,6 @@ static int __cmd_report(bool display_info)
>         }
>
>         /* for lock function check */
> -       symbol_conf.sort_by_name = true;

The comment also can go away.


>         symbol_conf.allow_aliases = true;
>         symbol__init(&session->header.env);
>
> @@ -1904,7 +1903,6 @@ static int __cmd_contention(int argc, const char **argv)
>                 con.save_callstack = true;
>
>         /* for lock function check */
> -       symbol_conf.sort_by_name = true;

Ditto.

Thanks,
Namhyung



>         symbol_conf.allow_aliases = true;
>         symbol__init(&session->header.env);
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index a31a23af5547..dcedfe00f04d 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1676,7 +1676,6 @@ int cmd_report(int argc, const char **argv)
>                          * See symbol__browser_index.
>                          */
>                         symbol_conf.priv_size += sizeof(u32);
> -                       symbol_conf.sort_by_name = true;
>                 }
>                 annotation_config__init(&report.annotation_opts);
>         }
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index aa44fdc84763..1f6557ce3b0a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -542,7 +542,6 @@ int cmd_test(int argc, const char **argv)
>                 return run_workload(workload, argc, argv);
>
>         symbol_conf.priv_size = sizeof(int);
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.try_vmlinux_path = true;
>
>         if (symbol__init(NULL) < 0)
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 277cb8f84cbc..16822a8a540f 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -74,7 +74,6 @@ int init_probe_symbol_maps(bool user_only)
>  {
>         int ret;
>
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.allow_aliases = true;
>         ret = symbol__init(NULL);
>         if (ret < 0) {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index f26f81eb8252..0b589570d1d0 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -18,7 +18,6 @@ struct symbol_conf {
>                         show_kernel_path,
>                         use_modules,
>                         allow_aliases,
> -                       sort_by_name,
>                         show_nr_samples,
>                         show_total_period,
>                         use_callchain,
> --
> 2.41.0.162.gfafddb0af9-goog
>
