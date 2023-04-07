Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0C6DB5C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDGVZE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGVZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:25:02 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C64BB80;
        Fri,  7 Apr 2023 14:25:00 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id bh10so1341626uab.13;
        Fri, 07 Apr 2023 14:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680902700; x=1683494700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k612bZuPeU9BYYEiReSh/KaPrQNbIQVI8+7Ue/dHlFU=;
        b=ZqCe5YuRynpr+udmNt/axrpRzStIpDI4/vuDE9MZVg5AJGPoe9yTIdqes+Yu2sAOao
         MW953jGSWaGMyIXVQ/P6j+jg3lSj5Jc2iGAR26ov3ma8Ugu6bLTgzGaO2OIX/bFJ5Il4
         Vqfqv43Mx9Kf8eeSNTu7ZBPKa8ZrmDng1r/cP3Ng2CoVa/nF0WPrmmK3poKEqj29y71s
         8NUixi6A0gAuUjhkYnJ86DJzlkxspmcxm1BfI723/ZOqvIopL0+CcJ/9rqYzSSMF6nQg
         T+lbIGpLfIpiWCN6VYKoFlRIEzxzBMampo+RML7EAvqiKMRMp33e7eoQdurW6TU7gNLD
         TNow==
X-Gm-Message-State: AAQBX9feiibzwawY2wf6jB2NhpobTTBh6QO9X0gqi1gflaL4s3G3OOiu
        YAIse+teZTzmaEZGWnf5bn2CVhIWEwOR/rWZGoU=
X-Google-Smtp-Source: AKy350Ztw9uDm2glyrJJxBO3yMwYpJO9lysNj8tnHY/ST6zgmXq6QhkOPKrkFUDWOk3/MCDYavbbH5kswQQ6NfBJFuc=
X-Received: by 2002:a05:6122:a09:b0:431:eb68:41b with SMTP id
 9-20020a0561220a0900b00431eb68041bmr1412113vkn.11.1680902699507; Fri, 07 Apr
 2023 14:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230407055212.2701635-1-changbin.du@huawei.com> <20230407055212.2701635-3-changbin.du@huawei.com>
In-Reply-To: <20230407055212.2701635-3-changbin.du@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 7 Apr 2023 14:24:48 -0700
Message-ID: <CAM9d7cgQF5n1umb6P3-KtYcmzF+gg0SR2JFjGXK3nR=Qr_bJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf: script: add new output field 'dsoff' to
 print dso offset
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Changbin,

On Thu, Apr 6, 2023 at 10:53 PM Changbin Du <changbin.du@huawei.com> wrote:
>
> This adds a new 'dsoff' field to print dso offset for resolved symbols,
> and the offset is appended to dso name.
>
> Default output:
> $ perf script
>        ls 2695501 3011030.487017:     500000 cycles:      152cc73ef4b5 get_common_indices.constprop.0+0x155 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff99045b3e [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968e107 [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffffc1f54afb [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968382f [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:  ffffffff99e00094 [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:      152cc718a8d0 __errno_location@plt+0x0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1)
>
> Display 'dsoff' field:
> $ perf script -F +dsoff
>        ls 2695501 3011030.487017:     500000 cycles:      152cc73ef4b5 get_common_indices.constprop.0+0x155 (/usr/lib/x86_64-linux-gnu/ld-2.31.so+0x1c4b5)
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff99045b3e [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968e107 [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffffc1f54afb [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968382f [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:  ffffffff99e00094 [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:      152cc718a8d0 __errno_location@plt+0x0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1+0x68d0)
>        ls 2695501 3011030.487019:     500000 cycles:  ffffffff992a6db0 [unknown] ([unknown])
>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 2 +-
>  tools/perf/builtin-script.c              | 5 +++++
>  tools/perf/util/evsel_fprintf.c          | 6 ++++++
>  tools/perf/util/evsel_fprintf.h          | 1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 777a0d8ba7d1..ff9a52e44688 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -130,7 +130,7 @@ OPTIONS
>  -F::
>  --fields::
>          Comma separated list of fields to print. Options are:
> -        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
> +        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
>          brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
>          phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index a792214d1af8..ccc409893c4b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -133,6 +133,7 @@ enum perf_output_field {
>         PERF_OUTPUT_VCPU            = 1ULL << 38,
>         PERF_OUTPUT_CGROUP          = 1ULL << 39,
>         PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
> +       PERF_OUTPUT_DSOFF           = 1ULL << 41,
>  };
>
>  struct perf_script {
> @@ -174,6 +175,7 @@ struct output_option {
>         {.str = "ip",    .field = PERF_OUTPUT_IP},
>         {.str = "sym",   .field = PERF_OUTPUT_SYM},
>         {.str = "dso",   .field = PERF_OUTPUT_DSO},
> +       {.str = "dsoff", .field = PERF_OUTPUT_DSOFF},
>         {.str = "addr",  .field = PERF_OUTPUT_ADDR},
>         {.str = "symoff", .field = PERF_OUTPUT_SYMOFFSET},
>         {.str = "srcline", .field = PERF_OUTPUT_SRCLINE},
> @@ -574,6 +576,9 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>         if (PRINT_FIELD(DSO))
>                 output[type].print_ip_opts |= EVSEL__PRINT_DSO;
>
> +       if (PRINT_FIELD(DSOFF))
> +               output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;

What if the user gives 'dsoff' without 'dso'.  Better to set the
EVSEL__PRINT_DSO as well?

Thanks,
Namhyung

> +
>         if (PRINT_FIELD(SYMOFFSET))
>                 output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
>
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 1fb8044d402e..ae8333772c76 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -116,6 +116,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>         int print_ip = print_opts & EVSEL__PRINT_IP;
>         int print_sym = print_opts & EVSEL__PRINT_SYM;
>         int print_dso = print_opts & EVSEL__PRINT_DSO;
> +       int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
>         int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
>         int print_oneline = print_opts & EVSEL__PRINT_ONELINE;
>         int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
> @@ -174,6 +175,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>                         if (print_dso && (!sym || !sym->inlined)) {
>                                 printed += fprintf(fp, " (");
>                                 printed += map__fprintf_dsoname(map, fp);
> +                               if (print_dsoff && map && map->dso)
> +                                       printed += fprintf(fp, "+0x%lx", addr);
>                                 printed += fprintf(fp, ")");
>                         }
>
> @@ -209,6 +212,7 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>         int print_ip = print_opts & EVSEL__PRINT_IP;
>         int print_sym = print_opts & EVSEL__PRINT_SYM;
>         int print_dso = print_opts & EVSEL__PRINT_DSO;
> +       int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
>         int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
>         int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
>         int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
> @@ -237,6 +241,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>                 if (print_dso) {
>                         printed += fprintf(fp, " (");
>                         printed += map__fprintf_dsoname(al->map, fp);
> +                       if (print_dsoff && al->map && al->map->dso)
> +                               printed += fprintf(fp, "+0x%lx", al->addr);
>                         printed += fprintf(fp, ")");
>                 }
>
> diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprintf.h
> index 3093d096c29f..c8a9fac2f2dd 100644
> --- a/tools/perf/util/evsel_fprintf.h
> +++ b/tools/perf/util/evsel_fprintf.h
> @@ -26,6 +26,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
>  #define EVSEL__PRINT_UNKNOWN_AS_ADDR   (1<<6)
>  #define EVSEL__PRINT_CALLCHAIN_ARROW   (1<<7)
>  #define EVSEL__PRINT_SKIP_IGNORED      (1<<8)
> +#define EVSEL__PRINT_DSOFF             (1<<9)
>
>  struct addr_location;
>  struct perf_event_attr;
> --
> 2.25.1
>
