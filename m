Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049D6DA4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbjDFVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDFVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:33:22 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0BC8A6E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:33:19 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e390e23f83so528031cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680816798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IObMk8A+yB7kzQzd06qcvUQD4B00Pzu5PtnbgiCc0Qc=;
        b=rfBYLWluQ0/Pd7dFpjwZXmRk6uGk/xeFl3oqLaePqw0xeERch2oiY4AxHT9EJaZ+Jc
         O2rdydCfeZvAvtDwiWqxVd3/d/p0jeE4MPlQfO1ys6QZYNdkjk0BoGwyaiXbuLfrzOpw
         hVz0mhcXBPMnkBJyP/9ttJOIr7Mq0Xa3/ladg15pyMqEcH14NjzwzXsgPW7giOlNLX3H
         n+lVKYjoIidbNWXSHuRgz/yB8zRV60SnGZaT2P2Jc7NJ/lvAbVwxwTihErJQddtq4Mwu
         in+uqz8l9G9gPh72cka0drTL5o7FJC9HEME2XPBvqESwcdMnMdvOTqYzlaUpeUfZUzUV
         ecDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IObMk8A+yB7kzQzd06qcvUQD4B00Pzu5PtnbgiCc0Qc=;
        b=jzjUNx47D8JT3c5510fs0+TuKLG5mVverwL/9lArcJR5jZ9ngvfdLA4Zqt9gVqpFcG
         QZ6dpujwRuetqwP+ZQCyadcOEXRjk/nB5h+r1vOq4yq5pVLk2bU1QH1H9kHPtSxQfQnb
         QDV6nagH6Pb17E3LPtH4Ushc0vicPapt2MvsXm1bcvGMvrrlwX1AIrFIsJzciig/pimH
         7lYO8wDh0bvpGsPjUYRmHlXv0KzIg+zAncdBcVaUX169v+kz1MQGjtCAni+S3ZLqVLKG
         y6+Kku1iWQTDow4xKrZRLD2HKcriaFAxOLlBC8pRVG/5QNYKgmLmGxsFIsWTlt1cluh6
         P+OQ==
X-Gm-Message-State: AAQBX9cnqR4tJ/4pH9HZeo0j97AhRstcuJxPJozf3dlkBZBsYxFyRUs4
        msd5WjknstRMjPrNnRWEcXZcFZL9fYjWNjCJDdSl5A==
X-Google-Smtp-Source: AKy350bIgdrkwnd6flj3ApzpuX9+RTf+JBOiuXuCCaLVjYUzp6sOfzzSf5eGUkHLXfL+yiLEoDUFxhrrGiyBNDn8G9E=
X-Received: by 2002:ac8:5bd2:0:b0:3bd:17d6:e04c with SMTP id
 b18-20020ac85bd2000000b003bd17d6e04cmr138867qtb.2.1680816798405; Thu, 06 Apr
 2023 14:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230406065224.2553640-1-irogers@google.com> <20230406065224.2553640-2-irogers@google.com>
 <ZC81CTH/VayirB5z@kernel.org>
In-Reply-To: <ZC81CTH/VayirB5z@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Apr 2023 14:33:07 -0700
Message-ID: <CAP-5=fXeuhYBDvRmu6vQLQFfW=0qBTH9EGmMrFb1sfGsJhGLFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf pmu: Fix a few potential fd leaks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Apr 05, 2023 at 11:52:24PM -0700, Ian Rogers escreveu:
> > Ensure fd is closed on error paths.
>
> Was this reported by Jiri?

Jiri's one was in the code I modified, whereas these were from
Namhyung's previous openat change. It is the same issue, I'm agnostic
on whether it needs a tag or not.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 96ef317bac41..9eedbfc9e863 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -494,9 +494,13 @@ static int pmu_aliases_parse(int dirfd, struct lis=
t_head *head)
> >                       continue;
> >
> >               fd =3D openat(dirfd, name, O_RDONLY);
> > +             if (fd =3D=3D -1) {
> > +                     pr_debug("Cannot open %s\n", name);
> > +                     continue;
> > +             }
> >               file =3D fdopen(fd, "r");
> >               if (!file) {
> > -                     pr_debug("Cannot open %s\n", name);
> > +                     close(fd);
> >                       continue;
> >               }
> >
> > @@ -1882,9 +1886,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
> >                       continue;
> >
> >               fd =3D openat(caps_fd, name, O_RDONLY);
> > +             if (fd =3D=3D -1)
> > +                     continue;
> >               file =3D fdopen(fd, "r");
> > -             if (!file)
> > +             if (!file) {
> > +                     close(fd);
> >                       continue;
> > +             }
> >
> >               if (!fgets(value, sizeof(value), file) ||
> >                   (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>
> --
>
> - Arnaldo
