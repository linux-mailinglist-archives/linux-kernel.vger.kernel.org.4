Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829FF73ADB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFWAQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFWAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:16:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29720C6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:16:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so106181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687479403; x=1690071403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uInZG3QLCuNSLqjwt2yJFumF8gcsP5JuPhFH6XK6y3g=;
        b=dbF7LtuKF+tcSdVQuyXVOqQD1DNwyYnCH7h2BoirQv4OzScfDs8hW2cXwlrXJim0sT
         wK/5rVm5U2xSZszL616B0pLp+dUb3zj2Iny35k5saYJfA8NBQMwco/bDPoSn4wOWx/LJ
         PViraUwexCqGdACZlm6GkDtx8vl2bSsVWziHk408KY4Cf3+HAL0ecpiDa4JJFZIDPgMt
         nKp9zaU8TjDYod0QDJsAjdqC6dtpeRC9f6yhnE7DBHqQyzyRJ0DX+n9l2jnEmykcQDcs
         CPDD496kCeqyL/MvMUw0u2I3143GhYXM0pmdq+En/eAx0UNxk0+TmV2/jznix7biyQsU
         V8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687479403; x=1690071403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uInZG3QLCuNSLqjwt2yJFumF8gcsP5JuPhFH6XK6y3g=;
        b=XZNNhzGIFRwpARjYrBLgfPbDV8Dvaz23O/Du/VN7FHlt8n8uq7WNDB+M8lC43DN+d8
         kEir6FcWguhwm460h/6B2VAwwMgcCWl8U8/Z2de982FhHKzvkcHjv4V+GbpGC2L9zjkd
         3I9h2qYK6upkeXP9tDbMyVLhj/y3mVvEiX+oKwsqxK99pFlVaMcahvgkFAO78gtrP+//
         MEjdxKaPKZ9a8VgUUbmpapxIoreDGYU94ZnrdVD0XuErvKUwIFeEw2uah8s14DDVePS0
         oA6OmptkVqe05ugCrATf79cxSrreEkNHl+iIs9gfmlvk0MDY4MQRdxm1dK48eJLHHhRp
         QrCg==
X-Gm-Message-State: AC+VfDw9KECoH7GTFKkj9Z0Q1kWPb6VeuEgb9UAWZfTUEAIr+5gBzqc4
        ayO8Etv6N/E9Vdq/dy+D9vDVjf65eMoR+YaIS9CO+Q==
X-Google-Smtp-Source: ACHHUZ6JH5TsP8kj9v+stNMOdxEtKF9MDjfa8HP4JoD4pnttpooKyfe9Sb9MJ2E0zsraxbmY1ynCh/wnt/FXNSYstyc=
X-Received: by 2002:ac8:5749:0:b0:3f8:5b2:aeee with SMTP id
 9-20020ac85749000000b003f805b2aeeemr10130qtx.22.1687479403173; Thu, 22 Jun
 2023 17:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230622235357.225190-1-namhyung@kernel.org>
In-Reply-To: <20230622235357.225190-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 17:16:31 -0700
Message-ID: <CAP-5=fVxz--VxTrHwgyY4VudhpqPqUUp=gdMA+t15EnrmTpsGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script: Initialize buffer for regs_map()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Aditya Gupta <adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 4:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The buffer is used to save register mapping in a sample.  Normally
> perf samples don't have any register so the string should be empty.
> But it missed to initialize the buffer when the size is 0.  And it's
> passed to PyUnicode_FromString() with a garbage data.
>
> So it returns NULL due to invalid input (instead of an empty unicode
> string object) which causes a segfault like below:
>
>   Thread 2.1 "perf" received signal SIGSEGV, Segmentation fault.
>   [Switching to Thread 0x7ffff7c83780 (LWP 193775)]
>   0x00007ffff6dbca2e in PyDict_SetItem () from /lib/x86_64-linux-gnu/libp=
ython3.11.so.1.0
>   (gdb) bt
>   #0  0x00007ffff6dbca2e in PyDict_SetItem () from /lib/x86_64-linux-gnu/=
libpython3.11.so.1.0
>   #1  0x00007ffff6dbf848 in PyDict_SetItemString () from /lib/x86_64-linu=
x-gnu/libpython3.11.so.1.0
>   #2  0x000055555575824d in pydict_set_item_string_decref (val=3D0x0, key=
=3D0x5555557f96e3 "iregs", dict=3D0x7ffff5f7f780)
>       at util/scripting-engines/trace-event-python.c:145
>   #3  set_regs_in_dict (evsel=3D0x555555efc370, sample=3D0x7fffffffb870, =
dict=3D0x7ffff5f7f780)
>       at util/scripting-engines/trace-event-python.c:776
>   #4  get_perf_sample_dict (sample=3Dsample@entry=3D0x7fffffffb870, evsel=
=3Devsel@entry=3D0x555555efc370, al=3Dal@entry=3D0x7fffffffb2e0,
>       addr_al=3Daddr_al@entry=3D0x0, callchain=3Dcallchain@entry=3D0x7fff=
f63ef440) at util/scripting-engines/trace-event-python.c:923
>   #5  0x0000555555758ec1 in python_process_tracepoint (sample=3D0x7ffffff=
fb870, evsel=3D0x555555efc370, al=3D0x7fffffffb2e0, addr_al=3D0x0)
>       at util/scripting-engines/trace-event-python.c:1044
>   #6  0x00005555555c5db8 in process_sample_event (tool=3D<optimized out>,=
 event=3D<optimized out>, sample=3D<optimized out>,
>       evsel=3D0x555555efc370, machine=3D0x555555ef4d68) at builtin-script=
.c:2421
>   #7  0x00005555556b7793 in perf_session__deliver_event (session=3D0x5555=
55ef4b60, event=3D0x7ffff62ff7d0, tool=3D0x7fffffffc150,
>       file_offset=3D30672, file_path=3D0x555555efb8a0 "perf.data") at uti=
l/session.c:1639
>   #8  0x00005555556bc864 in do_flush (show_progress=3Dtrue, oe=3D0x555555=
efb700) at util/ordered-events.c:245
>   #9  __ordered_events__flush (oe=3Doe@entry=3D0x555555efb700, how=3Dhow@=
entry=3DOE_FLUSH__FINAL, timestamp=3Dtimestamp@entry=3D0)
>       at util/ordered-events.c:324
>   #10 0x00005555556bd06e in ordered_events__flush (oe=3Doe@entry=3D0x5555=
55efb700, how=3Dhow@entry=3DOE_FLUSH__FINAL)
>       at util/ordered-events.c:342
>   #11 0x00005555556b9d63 in __perf_session__process_events (session=3D0x5=
55555ef4b60) at util/session.c:2465
>   #12 perf_session__process_events (session=3D0x555555ef4b60) at util/ses=
sion.c:2627
>   #13 0x00005555555cb1d0 in __cmd_script (script=3D0x7fffffffc150) at bui=
ltin-script.c:2839
>   #14 cmd_script (argc=3D<optimized out>, argv=3D<optimized out>) at buil=
tin-script.c:4365
>   #15 0x0000555555650811 in run_builtin (p=3Dp@entry=3D0x555555ed8948 <co=
mmands+456>, argc=3Dargc@entry=3D4, argv=3Dargv@entry=3D0x7fffffffe240)
>       at perf.c:323
>   #16 0x0000555555597eb3 in handle_internal_command (argv=3D0x7fffffffe24=
0, argc=3D4) at perf.c:377
>   #17 run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) =
at perf.c:421
>   #18 main (argc=3D4, argv=3D0x7fffffffe240) at perf.c:537
>
> Fixes: 51cfe7a3e87e ("perf python: Avoid 2 leak sanitizer issues")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
> index 25fcd6630a4d..94312741443a 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -737,11 +737,11 @@ static void regs_map(struct regs_dump *regs, uint64=
_t mask, const char *arch, ch
>         unsigned int i =3D 0, r;
>         int printed =3D 0;
>
> +       bf[0] =3D 0;
> +
>         if (size <=3D 0)
>                 return;
>
> -       bf[0] =3D 0;
> -
>         if (!regs || !regs->regs)
>                 return;
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
