Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E058060B7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiJXTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiJXT2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:28:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE914013
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:00:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y10so7062678wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq4LmojLbcxp/5HVAG4AMK3Qx1p6rp18L2XqoY3yjqk=;
        b=QFBkGG/eOnEFT2BxX8o5iEmIfNTM/zapl+rEUcxifKBNrdoBULWd9Weo1GXX9N9ori
         4ni8xwEDXt4s9D8TsLVlH6qLlsd3H8PAvFc9XqiuDMu8B9IBxfCG5BLpPIDlsK6PhgVg
         jkFIkguR3lk87K06Odeb0Gp1NMuAktUQdqQB+ksFtwpnpjgBiPekOMpVuEBYN7eJA0Gs
         ewIxDgFMUmLuuj7wsEpG8u2jYnreuTIJYZtH/502J6aBV4tmPvmCIWLWaw/jh1ip8nZY
         rHG+HQrlLofdsuotnpV94jE+/Z7c8JjfWGhLsI/F/oELeZiSaopNJZMDAyz4D0DwNdn+
         Owag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq4LmojLbcxp/5HVAG4AMK3Qx1p6rp18L2XqoY3yjqk=;
        b=73SdYIorC8u5/DI+pz3XxWUGQHpJPUOw14luzUBlYUGgEqcsfNazo0uurevmh/sik1
         zaPxI4lWDFQsM6/LoVva/z9NUxJVf2tbUT6lRgw7IDU2GkX9cUsGWw6qgfh8xZnudnKT
         dsLYUHCSKYHCGerbi+UHgxfKcJZY8VEWAZCpR0MXxQ47tGT+JTLY5qRLgXdy6M/Hqkuz
         T7144ccngtvEC9znL6x/Mrw3wvN/cefVa1GzMBo3svHapxMsn1aTpQoJa658c6LDb6tK
         m3gkM+uBUOa3zLPbZlMeUjYNSGW38nSgITrumqGdvmfFvSqe1FLsqB8KSMmxY+BYv+iK
         jJCw==
X-Gm-Message-State: ACrzQf1bJfBvv4PPRMs+oxYzfe3PGywrcpVSDpANRVQJVFPPi3YTyQMH
        Z39iw4qJPd2nF4QG6iqWmhuuTvHlHeRDBFKGNOuGMQ==
X-Google-Smtp-Source: AMsMyM6r4Yar8+wf9FBgx3rWmEhKwMDbYX+XOOz3rIMGGFJaiI+SsUfHFdy/D38b1/sUZ3g//DtzUO1kdFt2XDTXsPk=
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id
 u12-20020a05600c19cc00b003c6fbb9caabmr24904004wmq.182.1666634356029; Mon, 24
 Oct 2022 10:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com> <Y1bQlxxABicj4k3+@kernel.org>
In-Reply-To: <Y1bQlxxABicj4k3+@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Oct 2022 10:59:03 -0700
Message-ID: <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:51 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 24, 2022 at 10:35:15AM -0700, Ian Rogers escreveu:
> > The use of C11 is mainstream in the kernel [1]. There was some
> > confusion on volatile and signal handlers in [2]. Switch to using
> > stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
> > Yan <leo.yan@linaro.org> for the suggestions.
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
> > [3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
>
> I think I'll apply this to perf/core, i.e. for 6.3, ok?

Sounds good to me. 6.3 or 6.2? I suspect there is more cleanup like
this and to the iterators (from C11) that can be done.

Thanks,
Ian

> - Arnaldo
>
> >
> > Ian Rogers (8):
> >   perf build: Update to C standard to gnu11
> >   perf record: Use sig_atomic_t for signal handlers
> >   perf daemon: Use sig_atomic_t to avoid UB
> >   perf ftrace: Use sig_atomic_t to avoid UB
> >   perf session: Change type to avoid UB
> >   perf stat: Use sig_atomic_t to avoid UB
> >   perf top: Use sig_atomic_t to avoid UB
> >   perf trace: Use sig_atomic_t to avoid UB
> >
> >  tools/perf/Makefile.config  | 2 +-
> >  tools/perf/builtin-daemon.c | 3 ++-
> >  tools/perf/builtin-ftrace.c | 4 ++--
> >  tools/perf/builtin-record.c | 9 +++++----
> >  tools/perf/builtin-stat.c   | 9 +++++----
> >  tools/perf/builtin-top.c    | 4 ++--
> >  tools/perf/builtin-trace.c  | 4 ++--
> >  tools/perf/util/session.c   | 3 ++-
> >  8 files changed, 21 insertions(+), 17 deletions(-)
> >
> > --
> > 2.38.0.135.g90850a2211-goog
>
> --
>
> - Arnaldo
