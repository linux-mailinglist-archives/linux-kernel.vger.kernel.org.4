Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2419773A724
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjFVRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:23:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC6819A1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:23:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4007b5bafceso10701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687454625; x=1690046625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sImtbMqQzYkGHBNkAlqgrtpNozbS6ZDGSsAbNBKF2yg=;
        b=eh9P8uUt+ICiKU9A0APy2oJnRdiuwyxogTclThwgYDu5AoJTAXk173jyuveZx1raFb
         6UBXVvXrRi7azA+Btw14tntZUfWD/spOwwuLrRPbt6CtvHG/i5bV5OdQm6Rv0RwRsC6I
         op6M2wFYdRRASeG3sGLsJ6UfyOGVOOBylx0O1GDYkuwEbBOI/ubejP6t0F7lrbjR9Xs9
         +EkQozqY97NM5XYTPnYRT/uSmCNv3AH6kDKaDGYgXJGbS8aV1fuE9tgnBccg69Dgvdk1
         HmiO3JjSjc1dfeN5i3QKgvMvnMNM+Syfwja9kL8uf4TlP9kfsP6hcf7CvhgFA9w7JCVE
         hZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454625; x=1690046625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sImtbMqQzYkGHBNkAlqgrtpNozbS6ZDGSsAbNBKF2yg=;
        b=a6Tytpo0vRMR1Td0VMuP5xp6lMkCkPyPQASn381wAfvHhnfYV40iilvWa1KYJpZN/u
         LrLyomav/HcnrBhHXvhs1EA3dqSthveessp6CSt28XEE3Yyor7mUB8EkjpXjxH4Oqsv6
         fPgSzlyUd5k6OmqxZMEzkCT7keJvN/a6CKsqEBcK54T+xA5fzpnZ06Gt7tR3ZAFTX1dx
         uROzSwefjxUZCFoMGKNUht/kDOB/3RQlXrTggVn/ClnBsFuqoZKF3VD7VJIPnWlNauv7
         KyGzJlBye1THYZP3VGgyV1w+p5Mlx8/PEg9sDpbgaXRHe4tndcwxoWSD3/qE6xY9yYqy
         Bsmg==
X-Gm-Message-State: AC+VfDz/to8DoyJpD6jpCf4dDFXwwpvm86gZ3+RcJ0qij1NLVxYnogg/
        Zo87FPVybGT8DLe9ZOvhnz3NHsCfxi4wO7079TVoCg==
X-Google-Smtp-Source: ACHHUZ6wf4wGlU0ZWkgcTSKAhQkhaUGGzLzZITiplhOIsXLw84MbXX9lbdRwraQMhTE9VRKP9kiR/D/peGAY5RrqJDs=
X-Received: by 2002:a05:622a:85:b0:3f8:5b2:aeed with SMTP id
 o5-20020a05622a008500b003f805b2aeedmr1599600qtw.21.1687454624879; Thu, 22 Jun
 2023 10:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201818.1670753-1-namhyung@kernel.org> <20230620201818.1670753-2-namhyung@kernel.org>
In-Reply-To: <20230620201818.1670753-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 10:23:33 -0700
Message-ID: <CAP-5=fWrVh=RDEhise-gSzBfrfno8v8pyMw3QpBxio2j7QN3pA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Add kallsyms__get_symbol_start()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 1:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The kallsyms__get_symbol_start() to get any symbol address from
> kallsyms.  The existing kallsyms__get_function_start() only allows text
> symbols so create this to allow data symbols too.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/event.c | 30 +++++++++++++++++++++++++++---
>  tools/perf/util/event.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 3860b0c74829..6fdda0eb3854 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -93,8 +93,8 @@ struct process_symbol_args {
>         u64        start;
>  };
>
> -static int find_symbol_cb(void *arg, const char *name, char type,
> -                         u64 start)
> +static int find_func_symbol_cb(void *arg, const char *name, char type,
> +                              u64 start)
>  {
>         struct process_symbol_args *args =3D arg;
>
> @@ -110,12 +110,36 @@ static int find_symbol_cb(void *arg, const char *na=
me, char type,
>         return 1;
>  }
>
> +static int find_any_symbol_cb(void *arg, const char *name,
> +                             char type __maybe_unused, u64 start)
> +{
> +       struct process_symbol_args *args =3D arg;
> +
> +       if (strcmp(name, args->name))
> +               return 0;
> +
> +       args->start =3D start;
> +       return 1;
> +}
> +
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>                                  const char *symbol_name, u64 *addr)
>  {
>         struct process_symbol_args args =3D { .name =3D symbol_name, };
>
> -       if (kallsyms__parse(kallsyms_filename, &args, find_symbol_cb) <=
=3D 0)
> +       if (kallsyms__parse(kallsyms_filename, &args, find_func_symbol_cb=
) <=3D 0)
> +               return -1;
> +
> +       *addr =3D args.start;
> +       return 0;
> +}
> +
> +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> +                              const char *symbol_name, u64 *addr)
> +{
> +       struct process_symbol_args args =3D { .name =3D symbol_name, };
> +
> +       if (kallsyms__parse(kallsyms_filename, &args, find_any_symbol_cb)=
 <=3D 0)
>                 return -1;
>
>         *addr =3D args.start;
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index de20e01c9d72..d8bcee2e9b93 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -360,6 +360,8 @@ size_t perf_event__fprintf(union perf_event *event, s=
truct machine *machine, FIL
>
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>                                  const char *symbol_name, u64 *addr);
> +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> +                              const char *symbol_name, u64 *addr);
>
>  void event_attr_init(struct perf_event_attr *attr);
>
> --
> 2.41.0.185.g7c58973941-goog
>
