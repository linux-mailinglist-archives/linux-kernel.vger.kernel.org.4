Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5A722D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjFERTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjFERTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:19:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29958D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:19:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so8205ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685985542; x=1688577542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxEXC71EvIBIyrKJkGLhD82I8t0W90h4l0Ayz0o/Zuk=;
        b=E4z+OtE2bX/yCcT11XrY69kLEAdDfz8lyFnka1MGrcDLwOe8Zc/Nb0mpY4WBcxg85n
         scSbvoLxQn9L72GYXgySm/QNrAqXk2QF++Hzl8IMDcMsi9h4DrltRmmdRv+ia8hvyhKR
         F/hxReUxd60B94T1dYjNmaJONz8f5UuJJM9++Nwoyh5NuRJYSnOxs8Xmsjif6ticCaLa
         VuZ7ZvT6VVhJrVEUV12OdRiVx3R89skZso8eBtU7BQNOmRx30UzNbx61LCMDS11zg36G
         CWhgIKdMtWHe7jHfWhMxyi7KMzqs6SDQkeAlQK2Xsq4uVgh13dLRzLhRuUS27sdWn8ep
         oaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985542; x=1688577542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxEXC71EvIBIyrKJkGLhD82I8t0W90h4l0Ayz0o/Zuk=;
        b=UBA8GxyypWQ/VSe05wCupC9IIk+ixmDGPBoLZYl5nyU4Jzqg3nyQ20Wk46KSn50Nmf
         Pn1jEUO0JUYQt5Q9u1V1ilqyVdamb2fYVInkpWHDAaNyDyTxhPz3ZuRH3BcHuOEmqJ/w
         yygXCwzGZrCa8Ohtt36abX/UhDMNaj/0/9XzgFSns+AddZChDq+fljyC3MyLtXaUo1iY
         urFIfA/fI4TSWzNJGtQFFLwB5SjvXGroVkdlsU6J+xm3OiTIOa3cp/8Zmq8iFTRmagM/
         ZW5IgUJ+dNihXCWf9hF3F/wtmGOdM35QCGQvozYF7pCg/Gqdo1SJNH3xNRgKo8SVvT9x
         Jmtw==
X-Gm-Message-State: AC+VfDyfAH4+h9oAAFq4zgqh3OybACISxP1fFN1agLV4dFmCjO1UnNcR
        9ivaWsNWWk7AV3ot0GZ64RoQMdWi8i3cD/+HozRoJA==
X-Google-Smtp-Source: ACHHUZ5yCtTMWiv5JDmds12pvo/vlZ5+DYKz0ecdht2+KB6rBnQ5vhTqoa7+N3iMfOBk8KooPf3yokzgPcfpb92Abos=
X-Received: by 2002:a05:6e02:1e07:b0:33d:c057:f811 with SMTP id
 g7-20020a056e021e0700b0033dc057f811mr10502ila.1.1685985542393; Mon, 05 Jun
 2023 10:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com> <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 10:18:51 -0700
Message-ID: <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 4:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> > satisfy libbpf 'runqueue' type verification") inadvertently created a
> > declaration of 'struct rq' that conflicted with a generated
> > vmlinux.h's:
> >
> > ```
> > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> > struct rq {};
> >        ^
> > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous defin=
ition is here
> > struct rq {
> >        ^
> > 1 error generated.
> > ```
> >
> > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > happen again, bring back build support for generating vmlinux.h then
> > add build tests.
> >
> > Ian Rogers (3):
> >   perf build: Add ability to build with a generated vmlinux.h
> >   perf bpf: Move the declaration of struct rq
> >   perf test: Add build tests for BUILD_BPF_SKEL
> >
> >  tools/perf/Makefile.config                       |  4 ++++
> >  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
> >  tools/perf/tests/make                            |  4 ++++
> >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
> >  6 files changed, 34 insertions(+), 3 deletions(-)
> >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
> >
> > --
> > 2.40.1.698.g37aff9b760-goog
> >
> >
>
> LGTM, for the series:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Arnaldo, could we take this set?

Thanks,
Ian
