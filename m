Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8F71301B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjEZWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEZWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:41:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF410A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:41:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso62141cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685140904; x=1687732904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwkGmpNLMpawlS1hBtryEj+jCY8h/pnAE4lAJWcxTi4=;
        b=TaMAAV6xkMalo8ldUpPnsOinYazSt7ArN8neHplTXQd3QNNZqjh2vdzUuvQjDaGQZM
         ikp14z6pbfFLw88G/8huqVTWct4i2LjNEb1HK0UImLhlg1ggf8nCC7rHGKCTlkfCXa+o
         g39TZSYEpge8CXQr56Plau6Tl5AtXBLKTceJVumsIM+sMBOiCQr874Uo+ewRlcu9PI2G
         gnGWn5G8x+YkI6DWzcehORahypzMAXvTdAxK/2WbnbsqhsII5sO3Tu/vsug0EqvySlBy
         GmtMiiB3wOMynHUGA5l64qLKfojs75YKdoG3j7My/D4rPMSaC0r5WXrzTlqMNg1sR5Pz
         I/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685140904; x=1687732904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwkGmpNLMpawlS1hBtryEj+jCY8h/pnAE4lAJWcxTi4=;
        b=Pz+BxGmbimq8ITQqKEtDP14x/4wqfrzmUHgt2tnDfxO0DgYIfpMB/c0cjKAOnEB+7T
         bX4bvPYwqBAfTyRYaHVWdqLcZAyDNcYVPDMhhssuf+XkSIsuEAl7LMSMBFm0oTtf24CT
         ISGMVaDQWw0XzYOo7JgANu7v6GOHrm30Kv4nkszfroimwIJOipW7sc5Z/4b2Fa8ftYCF
         nx3w48xyBGfqSagVqquyJNVoUhKVGiHbPedCpqAkhumM+KIHHZltUpRKadKOqtfHK92T
         OPA8ruINIeT74zxgXGzgJoSkMNQS2xb7DV0PlDF3Ryj0K0X+OVKO4xL0rmlWZERB3tRv
         lf0g==
X-Gm-Message-State: AC+VfDzEiu26LfNgktOPqO3dP8qlNAIea65AP+GzwMpH8giy/4YOxUPw
        EoI7AdBHAbgVNVKmFEV4rHFgXHOBKkjrKEKuHEWq/A==
X-Google-Smtp-Source: ACHHUZ4dNXUIH5tFqniZBC5Q3UQeXlRCvoJ+PJF7hfLIL9YEqpTTdAG55WTuChgfsgcOAHQJKLuD2ctPWLy2FIwL6Eo=
X-Received: by 2002:a05:622a:148e:b0:3f8:e0a:3e66 with SMTP id
 t14-20020a05622a148e00b003f80e0a3e66mr30166qtx.3.1685140903703; Fri, 26 May
 2023 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230524210600.3095830-1-namhyung@kernel.org> <d06cac04-00b5-651d-14af-378fc25f37c4@amd.com>
In-Reply-To: <d06cac04-00b5-651d-14af-378fc25f37c4@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 May 2023 15:41:29 -0700
Message-ID: <CAP-5=fVMR0Y1=_W2scQBg_uWceOHrHaZ2GMwOai4Veq7OaGJ4A@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix perf stat JSON output test
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Wed, May 24, 2023 at 8:01=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello Namhyung,
>
> On 5/25/2023 2:36 AM, Namhyung Kim wrote:
> > The recent --per-cache option test caused a problem.  According to
> > the option name, I think it should check args.per_cache instead of
> > args.per_cache_instance.
> >
> >   $ sudo ./perf test -v 99
> >    99: perf stat JSON output linter                                    =
:
> >   --- start ---
> >   test child forked, pid 3086101
> >   Checking json output: no args [Success]
> >   Checking json output: system wide [Success]
> >   Checking json output: interval [Success]
> >   Checking json output: event [Success]
> >   Checking json output: per thread [Success]
> >   Checking json output: per node [Success]
> >   Checking json output: system wide no aggregation [Success]
> >   Checking json output: per core [Success]
> >   Checking json output: per cache_instance Test failed for input:
> >   ...
> >   Traceback (most recent call last):
> >     File "linux/tools/perf/tests/shell/lib/perf_json_output_lint.py", l=
ine 88, in <module>
> >       elif args.per_core or args.per_socket or args.per_node or args.pe=
r_die or args.per_cache_instance:
> >   AttributeError: 'Namespace' object has no attribute 'per_cache_instan=
ce'
> >   test child finished with -1
> >   ---- end ----
> >   perf stat JSON output linter: FAILED!
> >
> > Fixes: bfce728db317 ("pert tests: Add tests for new "perf stat --per-ca=
che" aggregation option")
>
> Another oversight on my part. Thank you for fixing this :)
>
>    $ sudo perf test -v 99
>    99: perf stat JSON output linter                                    :
>    --- start ---
>    test child forked, pid 25046
>    Checking json output: no args [Success]
>    Checking json output: system wide [Success]
>    Checking json output: interval [Success]
>    Checking json output: event [Success]
>    Checking json output: per thread [Success]
>    Checking json output: per node [Success]
>    Checking json output: system wide no aggregation [Success]
>    Checking json output: per core [Success]
>    Checking json output: per cache_instance [Success]
>    Checking json output: per die [Success]
>    Checking json output: per socket [Success]
>    test child finished with 0
>    ---- end ----
>    perf stat JSON output linter: Ok
>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks Namhyung and Prateek, Arnaldo could we get this in
perf-tools-next so that the failing test goes away?

Acked-by: Ian Rogers <irogers@google.com>

> > Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tool=
s/perf/tests/shell/lib/perf_json_output_lint.py
> > index 4acaaed5560d..b81582a89d36 100644
> > --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > @@ -85,7 +85,7 @@ Lines =3D args.file.readlines()
> >      expected_items =3D 7
> >    elif args.interval or args.per_thread or args.system_wide_no_aggr:
> >      expected_items =3D 8
> > -  elif args.per_core or args.per_socket or args.per_node or args.per_d=
ie or args.per_cache_instance:
> > +  elif args.per_core or args.per_socket or args.per_node or args.per_d=
ie or args.per_cache:
> >      expected_items =3D 9
> >    else:
> >      # If no option is specified, don't check the number of items.
>
> --
> Thanks and Regards,
> Prateek
