Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78B373C4C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFWXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFWXYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:24:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D11739
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:24:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4007b5bafceso50621cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687562645; x=1690154645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic9YiLELZWIcxjCuVy1CB9Zy7BGKTgexGt2dQ+9B2fo=;
        b=lzDczzlnHnkSoDJG9jVkbnTvvH8+J0IVoHO0F0ZJzsHVZECA7R+Hy0J4tykPCTsmVo
         MrRpaaQx6I3Hx1DQTpXgxvlsPHEChY2bI2XXNoKm8Iqxde5VwjZfZTkSUuOfMAgblBsS
         17zutBzIWbdohR2Gruie30ydIYFnl6r4HzPu64kVx/Z/a4sLL/Kxg649ceos14o7y179
         31tNxWCM8tyC4xi3mz4i+p3GpQ7aV9Sp6kflX8gD7+kUQrH9yXpBewGCILx/1zmOmtIX
         ouO4m0OBOI1dPuuCP/kxfcajeRJJT2g6adpnVrPCLKx97Weq77G5jgKTUoMCTD8Ho9xu
         MRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562645; x=1690154645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic9YiLELZWIcxjCuVy1CB9Zy7BGKTgexGt2dQ+9B2fo=;
        b=NuIk3XXb2zGfrLKC3AdSwA39kUavBbd3fNjTNJ4J8nYRiqnMbHaBn5/BkC/fSbK9J6
         2n6B2NdccLGQqBuRDejWABAn5VWrhH4EZQoIZleG+0wY+7qKt9PdSswpi1hR47oVNxXr
         HS4xgTOC6RSF3v77g8FBEW/+3vWAu/DAeMzK9XryFGsEaiFUa1wFfYPnvr1Jtqb62vjD
         wD+QWbYNHhEcfUz+HQ18BjZGWQHkN+12xkZJLYgBokf2fgSJazxfHIlli/zE9tVYDOn3
         A0zAtRbMFQY4z8ZRQcYA307wgTvvrXiEL+xKYgfrNCvpCIKVQLD+E/jUlBqnnVZFW9XK
         ePQg==
X-Gm-Message-State: AC+VfDw1QX0oHOq1fXh+rEsO5BOpmoIdMsZuKrbylZ9e6533SjcfuBCV
        ajHINSeExuK6KAxM7bZts3GkpwUaoI4buxJkBMLEhg==
X-Google-Smtp-Source: ACHHUZ6sGiQ4XkLpRSm+PKUcIUBs3JG+12D5xlhs6yteJrmR4SKqeWGsIG3MtU8kqOfvaB3CnqHIY8Y7h1Slf0NoBA4=
X-Received: by 2002:a05:622a:1a87:b0:3f8:3065:7fc5 with SMTP id
 s7-20020a05622a1a8700b003f830657fc5mr44444qtc.1.1687562645387; Fri, 23 Jun
 2023 16:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230623230139.985594-1-namhyung@kernel.org> <20230623230139.985594-2-namhyung@kernel.org>
In-Reply-To: <20230623230139.985594-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 16:23:53 -0700
Message-ID: <CAP-5=fXUfdmEKDF7JW7bTx+=WMWa79mBM5BxX6OhpTUjanh8xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Skip metrics w/o event name in stat STD
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
> This test checks if the output of perf stat to match event names and
> metrics.  So it wants the output lines to have both event name and
> metric.  Otherwise it should skip the line.
>
> On AMD machines, the instruction event has two metrics and they are print=
ed
> in separate lines.  It makes the line without event name like below:
>
>   # perf stat -a sleep 1
>
>    Performance counter stats for 'system wide':
>
>            64,383.34 msec cpu-clock                  #   64.048 CPUs util=
ized
>               14,526      context-switches           #  225.617 /sec
>                  112      cpu-migrations             #    1.740 /sec
>                  190      page-faults                #    2.951 /sec
>          807,558,652      cycles                     #    0.013 GHz      =
                   (83.30%)
>           69,809,799      stalled-cycles-frontend    #    8.64% frontend =
cycles idle        (83.30%)
>          196,983,266      stalled-cycles-backend     #   24.39% backend c=
ycles idle         (83.30%)
>          424,876,008      instructions               #    0.53  insn per =
cycle
>  (here) --->                                  #    0.46  stalled cycles p=
er insn     (83.30%)
>           97,788,321      branches                   #    1.519 M/sec    =
                   (83.34%)
>            4,147,377      branch-misses              #    4.24% of all br=
anches             (83.46%)
>
>          1.005241409 seconds time elapsed
>
> Also modern Intel machines have TopDown metrics which also don't have
> event names.
>
>   # perf stat -a sleep 1
>
>    Performance counter stats for 'system wide':
>
>             8,015.39 msec cpu-clock                        #    7.996 CPU=
s utilized
>                5,823      context-switches                 #  726.477 /se=
c
>                  189      cpu-migrations                   #   23.580 /se=
c
>                  139      page-faults                      #   17.342 /se=
c
>          435,139,308      cycles                           #    0.054 GHz
>          193,891,345      instructions                     #    0.45  ins=
n per cycle
>           42,773,028      branches                         #    5.336 M/s=
ec
>            2,298,113      branch-misses                    #    5.37% of =
all branches
>                           TopdownL1                 #     25.5 %  tma_bac=
kend_bound
>               /-->                                  #      7.9 %  tma_bad=
_speculation
>     (here) --+                                      #     55.7 %  tma_fro=
ntend_bound
>               \-->                                  #     10.9 %  tma_ret=
iring
>
>          1.002395924 seconds time elapsed
>
> There is a check to skip TopdownL1 and TopdownL2 specifically but it
> does not cover every affected lines.
>
> So there is another check to skip the line if it has nothing on the left
> side of # sign.  Well.. it seems ok but that's not enough too.
>
> When aggregation mode (like --per-socket or --per-thread) is used, it
> adds some prefix (e.g. CPU socket, task name and PID) in the output
> line.  So the test code ignores them to normalize result.
>
> A problem can happen for per-thread mode when task name contains one or
> more spaces.  It'd only ignore the first part of the task name, and it
> thinks there's something more in the line so it would not skip.
>
>   # perf stat -a --perf-thread sleep 1
>   ...
>             perf-21276                  #     70.2 %  tma_backend_bound
>             perf-21276                  #      3.9 %  tma_bad_speculation
>             perf-21276                  #     10.5 %  tma_frontend_bound
>             perf-21276                  #     15.3 %  tma_retiring
>             ^^^^^^^^^^
>             (ignored)
>
>          my task-21328                  #     70.2 %  tma_backend_bound
>          my task-21328                  #      3.9 %  tma_bad_speculation
>          my task-21328                  #     10.5 %  tma_frontend_bound
>          my task-21328                  #     15.3 %  tma_retiring
>          ^^
>      (ignored)
>
> So I think it should look at the metric names instead.  Add skip_metric
> to hold the list of names to skip.  It would contain 'stalled cycles per
> insn' and metrics started by 'tma_'.
>
> Fixes: 99a04a48f225 ("perf test: Add test case for the standard 'perf sta=
t' output")
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat+std_output.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 1f70aab45184..f972b31fa0c2 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -12,8 +12,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std=
.XXXXX)
>
>  event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults stalled-cycles-frontend stalled-cycles-backend cycles instructions b=
ranches branch-misses)
>  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "fr=
ontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of=
 all branches")
> -
> -metricgroup_name=3D(TopdownL1 TopdownL2)
> +skip_metric=3D("stalled cycles per insn" "tma_")
>
>  cleanup() {
>    rm -f "${stat_output}"
> @@ -58,13 +57,14 @@ function commachecker()
>
>                 main_body=3D$(echo $line | cut -d' ' -f$prefix-)
>                 x=3D${main_body%#*}
> -               # Check default metricgroup
> -               y=3D$(echo $x | tr -d ' ')
> -               [ "$y" =3D "" ] && continue
> -               for i in "${!metricgroup_name[@]}"; do
> -                       [[ "$y" =3D=3D *"${metricgroup_name[$i]}"* ]] && =
break
> +               [ "$x" =3D "" ] && continue
> +
> +               # Skip metrics without event name
> +               y=3D${main_body#*#}
> +               for i in "${!skip_metric[@]}"; do
> +                       [[ "$y" =3D=3D *"${skip_metric[$i]}"* ]] && break
>                 done
> -               [[ "$y" =3D=3D *"${metricgroup_name[$i]}"* ]] && continue
> +               [[ "$y" =3D=3D *"${skip_metric[$i]}"* ]] && continue
>
>                 # Check default event
>                 for i in "${!event_name[@]}"; do
> --
> 2.41.0.162.gfafddb0af9-goog
>
