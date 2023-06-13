Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8340372EC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbjFMTy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFMTyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:54:25 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108BE3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:54:24 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9b7de94e7so60011cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686686063; x=1689278063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kaFNmrqlXNHl6myJJQwEsOqHgyEX905kiiiOT//v0E=;
        b=Qo/exQHT36cb+zXUyJ2uhsj50qlk6woHq8nmHeIhTvlhuqtByy5ah0TJKBKiPmMZw8
         H2iwmNk5t5tm//j1J2U+E17Kr4Yio8o/y/N5sC/oMc4Q08pJJbfqKNiwLzYQImpTt51x
         d1zaTvuJ3T8Et1qV8VtPe/FWyGMjwtuztRCOjAraJSmhM8+ljMKKqtpxSa7IeRl6q+lD
         vGOVxeoh8FUxtegF+KqR2qQcJdt7HO3vBB12OZXjdI+uHj0qu9a3R6CrMeXESML6CKGN
         uOcbHiLLcbb7ZU2T4XZ/3I9rSrt7XvCCjn8xgUHCC3+L4O4/mbvryDWU5rAypGD3P8TV
         nZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686686063; x=1689278063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kaFNmrqlXNHl6myJJQwEsOqHgyEX905kiiiOT//v0E=;
        b=MJQYPH72IbGRbN/3cDcUd5XLnFFJBOVJr4pLhpx+4+UP8ttyyfLIgNn8f36o2/hXcj
         Y0MTClNG8phxkLbcBk3/uDBeHJzsIatCl4hnIU+p2rK3CcX09+x6+VEE5+zUVVUt8aKy
         e2ZojAVaiLmc2AZKUV836qW35puYyz2X9QqI0oOg0hb6xuWWGZYh88OwcK0ngdAORmWr
         Bj5UKurlNfD+xSv9XEX6dnxYNxAMUJFVk5qkQUWEEwYej6hzOknPo+9Ukl3GyC/Ld1Fc
         R9tUvvoFRx2PrSs/Vrb/XZNEEcGHD+tC3MNj2YZwSmpNGlZC1pSkm0muFEOzvDWiOJWq
         qPiw==
X-Gm-Message-State: AC+VfDyDxZl6Pq/+UF54LUFx/KFlOBrUA6QPl43kogk6ydee4qqYQUQ7
        o6SuLQ+Z7sAxaaxvZhS5asYfh8ztO63IFg+pr8LXPg==
X-Google-Smtp-Source: ACHHUZ4YzZm7OoifKmmJgSwGRdJRZJ56jjZluRQ/w5pW4YLVSsvKxL4+BJJ8N/hAR1JJWv7rUSdIr6Nw8YumyN+B67g=
X-Received: by 2002:ac8:7d84:0:b0:3ef:343b:fe7e with SMTP id
 c4-20020ac87d84000000b003ef343bfe7emr56480qtd.2.1686686063049; Tue, 13 Jun
 2023 12:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230613191639.1547925-1-irogers@google.com> <ZIjIiPAfTwL/P1dt@kernel.org>
In-Reply-To: <ZIjIiPAfTwL/P1dt@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:54:11 -0700
Message-ID: <CAP-5=fUQC2homPem0C4gsmiTMhwnNA0Jau8ehg=WG_oXRq0-8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] perf util: asprintf helper for leak sanitizer
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 13, 2023 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 13, 2023 at 12:16:38PM -0700, Ian Rogers escreveu:
> > asprintf is a source of memory leaks but produces bad stack traces on
> > my Debian linux. This patch adds a simple asprintf implementation to
> > util.c that works around it.
>
> So is this something to report to the glibc maintainers or debian?

*shrug* Folks appear to have been complaining about no option for
nearly 10 years, motivated by profiling more than sanitizers. Perhaps
I need to convince my employer to switch to Fedora.

Thanks,
Ian

> - Arnaldo
>
> > Before output:
> > ```
> > =3D=3D1541752=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 10 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f90c76b89cf in __interceptor_malloc ../../../../src/libsaniti=
zer/asan/asan_malloc_linux.cpp:69
> >     #1 0x7f90c649d2c7 in __vasprintf_internal libio/vasprintf.c:71
> >     #2 0x55ad9b79afbf  (/tmp/perf/perf+0x850fbf)
> >
> > SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
> > ```
> >
> > After output:
> > ```
> > =3D=3D1545918=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 10 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f2755a7077b in __interceptor_strdup ../../../../src/libsaniti=
zer/asan/asan_interceptors.cpp:439
> >     #1 0x564986a8df31 in asprintf util/util.c:566
> >     #2 0x5649869b5901 in metricgroup__lookup_default_metricgroup util/m=
etricgroup.c:1520
> >     #3 0x5649869b5e57 in metricgroup__lookup_create util/metricgroup.c:=
1579
> >     #4 0x5649869b6ddc in parse_groups util/metricgroup.c:1698
> >     #5 0x5649869b7714 in metricgroup__parse_groups util/metricgroup.c:1=
771
> >     #6 0x5649867da9d5 in add_default_attributes tools/perf/builtin-stat=
.c:2164
> >     #7 0x5649867ddbfb in cmd_stat tools/perf/builtin-stat.c:2707
> >     #8 0x5649868fa5a2 in run_builtin tools/perf/perf.c:323
> >     #9 0x5649868fab13 in handle_internal_command tools/perf/perf.c:377
> >     #10 0x5649868faedb in run_argv tools/perf/perf.c:421
> >     #11 0x5649868fb443 in main tools/perf/perf.c:537
> >     #12 0x7f2754846189 in __libc_start_call_main ../sysdeps/nptl/libc_s=
tart_call_main.h:58
> >
> > SUMMARY: AddressSanitizer: 10 byte(s) leaked in 1 allocation(s).
> > ```
> >
> > RFC: is this useful for others? Should we have a build flag for it?
> > ---
> >  tools/perf/util/util.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index c1fd9ba6d697..57eb528c5fed 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -552,3 +552,22 @@ int sched_getcpu(void)
> >       return -1;
> >  }
> >  #endif
> > +
> > +int asprintf(char **restrict strp, const char *restrict fmt, ...)
> > +{
> > +     char buf[1024];
> > +     va_list ap;
> > +     int size;
> > +     char *result;
> > +
> > +     va_start(ap, fmt);
> > +     size =3D vsnprintf(buf, sizeof(buf), fmt, ap);
> > +     if (size < (int)sizeof(buf))
> > +             result =3D strdup(buf);
> > +     else
> > +             size =3D vasprintf(&result, fmt, ap);
> > +
> > +     *strp =3D result;
> > +     va_end(ap);
> > +     return size;
> > +}
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> --
>
> - Arnaldo
