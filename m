Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79C73C4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjFWXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFWXWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:22:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA8D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:22:38 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40079b6fc56so48021cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687562557; x=1690154557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVCy/Qbk9kNtXs7TzOYDCjZWn+6FmeL5t8WtYyr2TL4=;
        b=aTzYN8jTYt6CPp98Tr2lZT8/Z+UJtI536y4LxWMavVgTlAudUdrjF+V9DAT4ilaiNR
         ef03exKNjcoxF0gxn42dDDdajxmbpNajLAhkvZRnnDUowThceFeh6RWhDUR8uxzZVJgS
         yDkSwkxwK/ZAKwdDhGiu912ZsLXQFcBvWYu1oOgNq4BgXqsA91q3w+Vr63ZeLotXlHNV
         g8eoWiORai84PuWIOWrMDpZCJb6dBcytLwrhvizLideXlfNB+j8AaUQVw5IcmvC/H67/
         nlmPvepeEALmBLySxBM7fv0CIMOP2/sZK3q5sDrPcmTc6uXyJKJ2B2eQQoLoCD6+xap1
         jeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562557; x=1690154557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVCy/Qbk9kNtXs7TzOYDCjZWn+6FmeL5t8WtYyr2TL4=;
        b=E3bSQBXk9NA/lT3FEJaYMGxg9h1corZiHbRuE3biMqoP5ZFDvE5qo16dXReB3pOfAr
         uS1vFoB4JxV0sfDO4p85UkVzv3seM2C62kGA9bu34j+enZ++C79duvKo/5myBUzOLExl
         tUu+lvfRLPeT2ciI1AsGTCltT8dLuMpP0kqISfxy1C1NNm+sJQi0ecU1XfHekRRiAh27
         lSTpAsJqFLlVuOQK+4dVEzDOobAWYKBBlNLlz5qAH06s2FpPj3tXWKAKcf0qLpYprTSZ
         Wo6kiqRuacU/0MPDoMWLhbOZZG1ccVRwY3C9UEpURI64Uw46/75c2Wwuigzr9amLAnVz
         PlSg==
X-Gm-Message-State: AC+VfDxEdJEwoGE8QEEzBCYfBSXw3yrjBp7LNOZ61d4v5vER2B5P6it1
        OdER+1UygA3132yZcKrbYQSpyepp45PtwGTZFMVfqQ==
X-Google-Smtp-Source: ACHHUZ4p5kBDh9CVuIEQ6H2HfBbKX547s0FEjTSlecEFitznDyDkatRfqP63wMtH84Gy5QkTpBpLtkLclehdmCUSd+Q=
X-Received: by 2002:a05:622a:1743:b0:3ef:404a:b291 with SMTP id
 l3-20020a05622a174300b003ef404ab291mr49619qtk.7.1687562557389; Fri, 23 Jun
 2023 16:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230623230139.985594-1-namhyung@kernel.org>
In-Reply-To: <20230623230139.985594-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 16:22:25 -0700
Message-ID: <CAP-5=fX6Of3pKjZGLEaNL58opn2veXxOhrY_sQqgY6hgUJeaBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test: Reorder event name checks in stat STD
 output linter
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 4:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On AMD machines, the perf stat STD output test failed like below:
>
>   $ sudo ./perf test -v 98
>    98: perf stat STD output linter                                     :
>   --- start ---
>   test child forked, pid 1841901
>   Checking STD output: no argswrong event metric.
>     expected 'GHz' in 108,121 stalled-cycles-frontend  # 10.88% frontend =
cycles idle
>   test child finished with -1
>   ---- end ----
>   perf stat STD output linter: FAILED!
>
> This is because there are stalled-cycles-{frontend,backend} events are
> used by default.  The current logic checks the event_name array to find
> which event it's running.  But 'cycles' event comes before those stalled
> cycles event and it matches first.  So it tries to find 'GHz' metric
> in the output (which is for the 'cycles') and fails.
>
> Move the stalled-cycles-{frontend,backend} events before 'cycles' so
> that it can find the stalled cycles events first.
>
> Also add a space after 'no args' test name for consistency.
>
> Fixes: 99a04a48f225 ("perf test: Add test case for the standard 'perf sta=
t' output")
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/stat_output.sh | 2 +-
>  tools/perf/tests/shell/stat+std_output.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests=
/shell/lib/stat_output.sh
> index 363979b1123d..698343f0ecf9 100644
> --- a/tools/perf/tests/shell/lib/stat_output.sh
> +++ b/tools/perf/tests/shell/lib/stat_output.sh
> @@ -9,7 +9,7 @@ function ParanoidAndNotRoot()
>  # $1 name $2 extra_opt
>  check_no_args()
>  {
> -        echo -n "Checking $1 output: no args"
> +        echo -n "Checking $1 output: no args "
>          perf stat $2 true
>          commachecker --no-args
>          echo "[Success]"
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 98cc3356a04a..1f70aab45184 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -10,8 +10,8 @@ set -e
>
>  stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>
> -event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults cycles instructions branches branch-misses stalled-cycles-frontend s=
talled-cycles-backend)
> -event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "GH=
z" "insn per cycle" "/sec" "of all branches" "frontend cycles idle" "backen=
d cycles idle")
> +event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults stalled-cycles-frontend stalled-cycles-backend cycles instructions b=
ranches branch-misses)
> +event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "fr=
ontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of=
 all branches")
>
>  metricgroup_name=3D(TopdownL1 TopdownL2)
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
