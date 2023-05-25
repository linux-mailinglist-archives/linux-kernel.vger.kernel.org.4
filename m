Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394C9711754
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbjEYTXU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbjEYTXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:23:02 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0742AE57;
        Thu, 25 May 2023 12:19:35 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-456f7ea8694so312199e0c.0;
        Thu, 25 May 2023 12:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685042277; x=1687634277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUkevm3aMU5xLxVBa9KxEIFuZRkmPE748qzKxoDf9/0=;
        b=dNZ3rmg6sV4BREbRboM9CuBrgR24asHz38JUEVp2l5Zx77M4xIhYBCYbOx15qkXAgq
         /Xlae6PgTtVTfxIwOwKJF603ioO8shZhnO4oz8VdQwBskLPiagLq8k5aTuk1JtWe5d8j
         gZfKwC75aJ8Efc3et4VdwqMplnJsMqdtO/gU0CPGcS8x02hA/ogjCkrj/4/w/H7Swksv
         Z+F2jFNOTqessoEwGAWScSoOmpQ3nr/ASkXkuhIYz1UPfFh/h6mlSaeKusqbNIOVXa7d
         t36KL2/tr+kTqcbJvtRWLoDQsuECUWCEaP+E3VpbWv0Ps6oW4ciDtYJV8IA5605bY91t
         iGZw==
X-Gm-Message-State: AC+VfDw+CSeWisxj/wWZo1Z9/PaGan7IyR1t5qFW1WjL4FwxTAsyAash
        7OHIQ21CsjmRBExBRz5TD/A7etAJ/GQYu9FW6G4=
X-Google-Smtp-Source: ACHHUZ70TCJa3LuotxEpuRt8HHeEdaR6EhrXfj0TDwMm/6pncpPKae8houpIaIJqkJH9JxLSLSk63tXSWWdYymK7Pv8=
X-Received: by 2002:a1f:e604:0:b0:43f:e32a:c650 with SMTP id
 d4-20020a1fe604000000b0043fe32ac650mr6364003vkh.15.1685042277355; Thu, 25 May
 2023 12:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com> <20230525071133.2066610-9-irogers@google.com>
In-Reply-To: <20230525071133.2066610-9-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 May 2023 12:17:46 -0700
Message-ID: <CAM9d7ci5XB7-PdcXchWW7bBFO_64B0M76rpY8xgkBYr3-mGW0Q@mail.gmail.com>
Subject: Re: [PATCH v1 08/16] perf daemon: Dynamically allocate path to perf
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, May 25, 2023 at 12:12 AM Ian Rogers <irogers@google.com> wrote:
>
> Avoid a PATH_MAX array in __daemon (the .data section) by dynamically
> allocating the memory.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-daemon.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 34cbe3e959aa..adb5751c3ed0 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -90,7 +90,7 @@ struct daemon {
>         char                    *base;
>         struct list_head         sessions;
>         FILE                    *out;
> -       char                     perf[PATH_MAX];
> +       char                    *perf;
>         int                      signal_fd;
>         time_t                   start;
>  };
> @@ -1490,6 +1490,15 @@ static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
>         return send_cmd(daemon, &cmd);
>  }
>
> +static char *set_perf_exe(void)
> +{
> +       char path[PATH_MAX];
> +
> +       perf_exe(path, sizeof(path));
> +       __daemon.perf = strdup(path);
> +       return __daemon.perf;

Then you need to free it somewhere.

Thanks,
Namhyung


> +}
> +
>  int cmd_daemon(int argc, const char **argv)
>  {
>         struct option daemon_options[] = {
> @@ -1503,7 +1512,9 @@ int cmd_daemon(int argc, const char **argv)
>                 OPT_END()
>         };
>
> -       perf_exe(__daemon.perf, sizeof(__daemon.perf));
> +       if (!set_perf_exe())
> +               return -ENOMEM;
> +
>         __daemon.out = stdout;
>
>         argc = parse_options(argc, argv, daemon_options, daemon_usage,
> --
> 2.40.1.698.g37aff9b760-goog
>
