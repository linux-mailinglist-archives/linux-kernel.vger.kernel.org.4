Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30BC722F72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjFETOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjFETOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:14:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1407910E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:14:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33d928a268eso31865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685992473; x=1688584473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyL91Ec69lqQv1cIeAH4Hob9qDym4MqPZUuyevd3R8g=;
        b=jXB+Z7R1bUy16bQtNnF/M7OCBmgsTgJcWjiLkVx5tWQwzvzZKrrREsGFh3FB60Zmc4
         mTKQG1kEgqW1xh9f6Gy81vr7OGZwCA33ZSSa3pziU4SQdXfur+Rn7K8jc9aCtWBsQwVQ
         bOLvWSWpx54SLeXlVgMcYqKiVMpimpSAO3fvop0uW6W79SPgRnGSxiPqtb6Db5HW26ou
         pTAQ7ZSJPgyQTRvrN79IUm83ANOvVmzKtSzBQIDieDH4QWEgFLXn9tNdqotHzF04MGyg
         0wwmeSGDvgZS2qz7plot8Kb+62nWwndGzYH+M2o1qlUjTdwq3sLN8Cc0khlaZ9rUATsl
         z88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992473; x=1688584473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyL91Ec69lqQv1cIeAH4Hob9qDym4MqPZUuyevd3R8g=;
        b=bK8qAyh3P8BiYxaS8WEC9ArDARq5FO7iEyJsA6WA14WgQfuPv2+vDta155cpO93ZAO
         Lj/0uZ2I4LgxIgTkfcaueKTbpKy3My3AJ808yxROWyFm78jHaUhYkGIe1nVDXMFpYC2N
         l+jNOHM3tWWr9gyjfXAvjFwW0B1s/33WjmEA0V5WiGAyLtFHqscVw0F+6ilsXdCNerDt
         kFC1EL7Yz45QDF2In4tB15mYgX4tKFqUcDo7Wx5CmP/14bTlfVwmXTv9lqQUYlT+HZuA
         TIV7reSiyBInubXH/n4GQNhGOE+FNYBU3cpdY5xRoJod/qQA8M1cpSrJfsZfxyP7XTSS
         /yvQ==
X-Gm-Message-State: AC+VfDyTJZh8kdpQSyBen699lQE2vmZgT/G45xV9ps1Plp80HpoKr+LH
        pgQRSIbYQ5n4OlyHqxwqLy0vGnSG/gB0S1TzaLJzpg==
X-Google-Smtp-Source: ACHHUZ6rYSRmEK2A9Buvh4btbinrCfMTRWuZimZRs3lS+f5OxIwk3+ZAurfM7dLslT7TFPLsqza3h46NyyJP9qDqyPw=
X-Received: by 2002:a05:6e02:17cb:b0:33d:6c0e:83c0 with SMTP id
 z11-20020a056e0217cb00b0033d6c0e83c0mr11732ilu.27.1685992473307; Mon, 05 Jun
 2023 12:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com> <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
 <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com> <ZH4vru4zR8UlIdEN@kernel.org>
In-Reply-To: <ZH4vru4zR8UlIdEN@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 12:14:21 -0700
Message-ID: <CAP-5=fVhMSBk0Q0az7O=OdXtfiktqdxg9GaXdjOFCPPSS25GZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back vmlinux.h generation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

On Mon, Jun 5, 2023 at 11:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 05, 2023 at 10:18:51AM -0700, Ian Rogers escreveu:
> > On Mon, May 22, 2023 at 4:35=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' t=
o
> > > > satisfy libbpf 'runqueue' type verification") inadvertently created=
 a
> > > > declaration of 'struct rq' that conflicted with a generated
> > > > vmlinux.h's:
> > > >
> > > > ```
> > > > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of '=
rq'
> > > > struct rq {};
> > > >        ^
> > > > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous d=
efinition is here
> > > > struct rq {
> > > >        ^
> > > > 1 error generated.
> > > > ```
> > > >
> > > > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > > > happen again, bring back build support for generating vmlinux.h the=
n
> > > > add build tests.
> > > >
> > > > Ian Rogers (3):
> > > >   perf build: Add ability to build with a generated vmlinux.h
> > > >   perf bpf: Move the declaration of struct rq
> > > >   perf test: Add build tests for BUILD_BPF_SKEL
> > > >
> > > >  tools/perf/Makefile.config                       |  4 ++++
> > > >  tools/perf/Makefile.perf                         | 16 ++++++++++++=
+++-
> > > >  tools/perf/tests/make                            |  4 ++++
> > > >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> > > >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> > > >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
> > > >  6 files changed, 34 insertions(+), 3 deletions(-)
> > > >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
> > > >
> > > > --
> > > > 2.40.1.698.g37aff9b760-goog
> > > >
> > > >
> > >
> > > LGTM, for the series:
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Arnaldo, could we take this set?
>
> This one isn't applying right now on perf-tools-next.
>
> - Arnaldo

I'll rebase and resend.

Thanks,
Ian
