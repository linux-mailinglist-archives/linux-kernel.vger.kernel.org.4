Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3772509E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbjFFXPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjFFXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:15:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0CA1721
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:15:03 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so26535ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686093303; x=1688685303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJcTOjLSPVe3TW5IYKBe1nDoXetkbFhwDMWoyyExPes=;
        b=Y0xNu0uVXUEDoZNQy33qvMfncNoIKrsaRa8xSVtYodHLeBpw6dh9VTy1yqAEeTL1cc
         SvAeSKeS1xsHDK/JFD7qMhxRqJmRBFrfc6VbQGvzKEA7DMK9aGLkMVxYJphK0Sscmocx
         1Pcpc46mEGmP/BRtiMfZkq7h1nGTdkleJGAyWo+5ZDDo5HNc2nosi6eiy/XyShwKmuFx
         zMCcSAbAe/GJicYSRZPFCPcFMjoKX4XjNuzBZPRrexVAT1P4Fq5NQfbNFTI3hiaDXEE4
         L4yyb/xN4o4zmb5wly3A1znMaJKLk17cGA6WH/AztH9tmmbIOhg3qa1eVYmEwaeZX7cQ
         tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093303; x=1688685303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJcTOjLSPVe3TW5IYKBe1nDoXetkbFhwDMWoyyExPes=;
        b=be+R4AWXvtynWfFZTB5qkkui4sWfoSzBwnRyO+qwgIBsy4nvcG+EhK/NqeD4XGN1OB
         OHIaaZVZJQupqw0oyuUdogSfX/AjIWGuxmRmEfwjChKexeoc6S34r5rJzWqfayKJKa9n
         KYJL+7+AWR40AiFRl9T1ZjjKyn0DFZzkb2F5/LaSPcPVReIg370aNXyu2blJHpoLLz89
         dAIVsS02+5gnEsEx8VeaIo9f9k4/nHy7ndS+fBjsvjstpsaTZxHN1u9R3CH47o62/d0Y
         9xSB+xcXRKoST26zWnGyuh2usm2lgcbTZ1TBxPhDd+ZdtLwO9CS7cmajPGpTKdvQaTqH
         2BdQ==
X-Gm-Message-State: AC+VfDyXBYyrabwNpow6gJGgK5Q/NAcBGD1O3cQE5OZ6s2LBBabJ4UQL
        0HmdvEaWRE8sA/yWKgYZL5ysWMJqoRNO6TWwoCawvg==
X-Google-Smtp-Source: ACHHUZ4JfdFaMa+uvHR7Db+b/+Y2smU94LqDkKJVaRdVm92blluolykPMOC+66y2EnnqI/QJx9B5Ym68EM+jsbiIkFA=
X-Received: by 2002:a05:6e02:194a:b0:331:a582:1c63 with SMTP id
 x10-20020a056e02194a00b00331a5821c63mr30403ilu.3.1686093302838; Tue, 06 Jun
 2023 16:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZH+F0wGAWV14zvMP@kernel.org>
In-Reply-To: <ZH+F0wGAWV14zvMP@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Jun 2023 16:14:51 -0700
Message-ID: <CAP-5=fUNefbgzKNVDZJZvem0bm8cYhc4FPQzp+Ja7v9n6y5ufA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf script: Fix allocation of evsel->priv related to
 per-event dump files
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jun 6, 2023 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> I'm carrying this in my perf-tools-next, please ack :-)
>
> - Arnaldo
>
> ---
>
> When printing output we may want to generate per event files, where the
> --per-event-dump option should be used, creating perf.data.EVENT.dump
> files instead of printing to stdout.
>
> The callback thar processes event thus expects that evsel->priv->fp
> should point to either the per-event FILE descriptor or to stdout.
>
> The a3af66f51bd0bca7 ("perf script: Fix crash because of missing
> evsel->priv") changeset fixed a case where evsel->priv wasn't setup,
> thus set to NULL, causing a segfault when trying to access
> evsel->priv->fp.
>
> But it did it for the non --per-event-dump case by allocating a 'struct
> perf_evsel_script' just to set its ->fp to stdout.
>
> Since evsel->priv is only freed when --per-event-dump is used, we ended
> up with a memory leek, detected using ASAN.

nit: s/leek/leak/

>
> Fix it by using the same method as perf_script__setup_per_event_dump(),
> and reuse that static 'struct perf_evsel_script'.
>
> Also check if evsel_script__new() failed.
>
> Fixes: a3af66f51bd0bca7 ("perf script: Fix crash because of missing evsel=
->priv")
> Reported-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Tested on top of my asan work:
Tested-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/builtin-script.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 70549fc93b125394..b02ad386a55baf07 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2410,6 +2410,9 @@ static int process_sample_event(struct perf_tool *t=
ool,
>         return ret;
>  }
>
> +// Used when scr->per_event_dump is not set
> +static struct evsel_script es_stdout;
> +
>  static int process_attr(struct perf_tool *tool, union perf_event *event,
>                         struct evlist **pevlist)
>  {
> @@ -2418,7 +2421,6 @@ static int process_attr(struct perf_tool *tool, uni=
on perf_event *event,
>         struct evsel *evsel, *pos;
>         u64 sample_type;
>         int err;
> -       static struct evsel_script *es;
>
>         err =3D perf_event__process_attr(tool, event, pevlist);
>         if (err)
> @@ -2428,14 +2430,13 @@ static int process_attr(struct perf_tool *tool, u=
nion perf_event *event,
>         evsel =3D evlist__last(*pevlist);
>
>         if (!evsel->priv) {
> -               if (scr->per_event_dump) {
> +               if (scr->per_event_dump) {

nit: whitespace issue.

>                         evsel->priv =3D evsel_script__new(evsel, scr->ses=
sion->data);
> -               } else {
> -                       es =3D zalloc(sizeof(*es));
> -                       if (!es)
> +                       if (!evsel->priv)
>                                 return -ENOMEM;
> -                       es->fp =3D stdout;
> -                       evsel->priv =3D es;
> +               } else { // Replicate what is done in perf_script__setup_=
per_event_dump()
> +                       es_stdout.fp =3D stdout;
> +                       evsel->priv =3D &es_stdout;
>                 }
>         }
>
> @@ -2741,7 +2742,6 @@ static int perf_script__fopen_per_event_dump(struct=
 perf_script *script)
>  static int perf_script__setup_per_event_dump(struct perf_script *script)
>  {
>         struct evsel *evsel;
> -       static struct evsel_script es_stdout;
>
>         if (script->per_event_dump)
>                 return perf_script__fopen_per_event_dump(script);
> --
> 2.37.1
>
