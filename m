Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342172C8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjFLOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjFLOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:46:28 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B09C4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:46:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9a81da5d7so392201cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686581186; x=1689173186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaPmxqEpeaJR+RWpvgc6oPZytx2qIxyOn1fsy3TsqOY=;
        b=VRU+InYCcZpTelAOH/3Dse96vo49RF6NcywDNha7tkAangBX0BEUrPnYT78SregrzU
         9P5rk1vrc/sjNB8YWECOB++7jVyyn+tFaxPiJR7hfXzp/qsgIxHlsAf7NKo/+tEAgKg6
         SaZRDFq0RbiTDddIdz9cMTsUj+/oS3ZozohryEteUjF4UMbssgOgTXD7MgsaiLbQJ+Qw
         BFcWCZm9TtDXugG4BjsUKNtu7h5qlYOOYkN1ffJaQSbu3BT+yKns26xTPF5G8MQ+kg1+
         CeMtL3kSA9NkpTrgOeesiKHU8uVf2GcaEBaSwcN4mD39bqB6AjV9lkre+My4AtGLMGgl
         jXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686581186; x=1689173186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaPmxqEpeaJR+RWpvgc6oPZytx2qIxyOn1fsy3TsqOY=;
        b=VZ35r3upkc08DMnmR5tWdNfVXJrz3jsT78ZqScoEPLM6wXIAP85KQekcIS2NRFPvr8
         IoZlrZsIEAULc1Rm9izvvTEbfDHd5y6wiIj5r6MnLwVOSw6pvGd+Mn7bYl1lbUGnV+Vh
         0j9C2/t58owdUlFNfVxYXlY9N0Lsb4XqJnQTN2b9PM334PC26qWm3mGnBfHF0uDDzh7F
         expnmbD4jZT1oNnNZ+QPtuDNaTFIK9cCyrFF2bKCA8bf97hYfe8upMfbPO3zThw3soEA
         j81egSDBig7HuLakHRYaZSialtiNH8/1L9k4M1EJ6wH5PfXPoxTjlzGjXCFeshiZhHi+
         6PQg==
X-Gm-Message-State: AC+VfDy6nKmchi9dMtTDi2cwMjXOcRcO1HibjqURTmYphCcwa9fziZuE
        sT61uZhgQdKpRdu7jcRqpLWZjkOq+7nhl9D3bnhEXQ==
X-Google-Smtp-Source: ACHHUZ55F/W0Dacq5LPDdYKu+10SBuMBnRW0GP7N75n6EsQ4tqNo6zeDE2nTADw5muDPyz0U3fDNE5889w3Og092Q/4=
X-Received: by 2002:a05:622a:1015:b0:3f6:97b4:1a4a with SMTP id
 d21-20020a05622a101500b003f697b41a4amr368857qte.20.1686581186287; Mon, 12 Jun
 2023 07:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com> <20230608232823.4027869-27-irogers@google.com>
 <ZIcoJytUEz4UgQYR@kernel.org> <ZIcorZVu1z8jaPL/@kernel.org>
In-Reply-To: <ZIcorZVu1z8jaPL/@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 07:46:14 -0700
Message-ID: <CAP-5=fXby-Yk3U4LCQeYkGU_E22kd92=dCnfb7DkN5iPYvCDGA@mail.gmail.com>
Subject: Re: [PATCH v2 26/26] perf hist: Fix srcline memory leak
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
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

On Mon, Jun 12, 2023 at 7:16=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 12, 2023 at 11:13:59AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Jun 08, 2023 at 04:28:23PM -0700, Ian Rogers escreveu:
> > > srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
> > > case as such strdups are redundant and leak memory.
> >
> > The patch is ok as its what the rest of the code is doing, i.e. strcmp(=
)
> > to check if a srcline is the unknown one, but how about the following
> > patch on top of yours?
>
> [acme@quaco perf-tools-next]$ strings ~/bin/perf | grep '??:0'
> ??:0
> SRCLINE_UNKNOWN ((char *) "??:0")
> [acme@quaco perf-tools-next]$

Agreed, the strcmps make me nervous as they won't distinguish heap
from a global meaning we could end up with things like pointers to
freed memory. The comparison with the global is always going to be
same imo.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > From 5163e54c1ed3d476f6b4e7f938861039bd4eec7c Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Mon, 12 Jun 2023 11:10:46 -0300
> > Subject: [PATCH 1/1] perf srcline: Optimize comparision against
> >  SRCLINE_UNKNOWN
> >
> > This is a string constant that gets returned and then strcmp() around,
> > we can instead just do a pointer comparision.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-diff.c    | 4 ++--
> >  tools/perf/util/block-info.c | 4 ++--
> >  tools/perf/util/hist.c       | 2 +-
> >  tools/perf/util/map.c        | 2 +-
> >  tools/perf/util/sort.c       | 2 +-
> >  tools/perf/util/srcline.c    | 2 +-
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index eec89567ae483604..e8a1b16aa5f83f4f 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -1378,8 +1378,8 @@ static int cycles_printf(struct hist_entry *he, s=
truct hist_entry *pair,
> >       end_line =3D map__srcline(he->ms.map, bi->sym->start + bi->end,
> >                               he->ms.sym);
> >
> > -     if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)=
) !=3D 0) &&
> > -         (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) =
!=3D 0)) {
> > +     if (start_line !=3D SRCLINE_UNKNOWN &&
> > +         end_line !=3D SRCLINE_UNKNOWN) {
> >               scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
> >                         start_line, end_line, block_he->diff.cycles);
> >       } else {
> > diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.=
c
> > index 08279b1b65e5a4b0..fe4c17248799f0a2 100644
> > --- a/tools/perf/util/block-info.c
> > +++ b/tools/perf/util/block-info.c
> > @@ -296,8 +296,8 @@ static int block_range_entry(struct perf_hpp_fmt *f=
mt, struct perf_hpp *hpp,
> >       end_line =3D map__srcline(he->ms.map, bi->sym->start + bi->end,
> >                               he->ms.sym);
> >
> > -     if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)=
) !=3D 0) &&
> > -         (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) =
!=3D 0)) {
> > +     if (start_line !=3D SRCLINE_UNKNOWN) &&
> > +         end_line !=3D SRCLINE_UNKNOWN) {
> >               scnprintf(buf, sizeof(buf), "[%s -> %s]",
> >                         start_line, end_line);
> >       } else {
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 0a10bcc6ec95b5e0..3dc8a4968beb9c01 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -484,7 +484,7 @@ static int hist_entry__init(struct hist_entry *he,
> >                       goto err_infos;
> >       }
> >
> > -     if (he->srcline && strcmp(he->srcline, SRCLINE_UNKNOWN)) {
> > +     if (he->srcline && he->srcline !=3D SRCLINE_UNKNOWN) {
> >               he->srcline =3D strdup(he->srcline);
> >               if (he->srcline =3D=3D NULL)
> >                       goto err_rawdata;
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index c77e2fce6a379e7f..f30d34903aa4eabe 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -496,7 +496,7 @@ int map__fprintf_srcline(struct map *map, u64 addr,=
 const char *prefix,
> >
> >       if (dso) {
> >               char *srcline =3D map__srcline(map, addr, NULL);
> > -             if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKN=
OWN)) !=3D 0)
> > +             if (srcline !=3D SRCLINE_UNKNOWN)
> >                       ret =3D fprintf(fp, "%s%s", prefix, srcline);
> >               zfree_srcline(&srcline);
> >       }
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 047c3606802f5b7f..6aa1c7f2b4448b30 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -643,7 +643,7 @@ static char *hist_entry__get_srcfile(struct hist_en=
try *e)
> >
> >       sf =3D __get_srcline(map__dso(map), map__rip_2objdump(map, e->ip)=
,
> >                        e->ms.sym, false, true, true, e->ip);
> > -     if (!strcmp(sf, SRCLINE_UNKNOWN))
> > +     if (sf =3D=3D SRCLINE_UNKNOWN)
> >               return no_srcfile;
> >       p =3D strchr(sf, ':');
> >       if (p && *sf) {
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index b8e596528d7e7e5e..48a04f42b308b080 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -809,7 +809,7 @@ void zfree_srcline(char **srcline)
> >       if (*srcline =3D=3D NULL)
> >               return;
> >
> > -     if (strcmp(*srcline, SRCLINE_UNKNOWN))
> > +     if (*srcline !=3D SRCLINE_UNKNOWN)
> >               free(*srcline);
> >
> >       *srcline =3D NULL;
> > --
> > 2.39.2
> >
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/hist.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index 77cb2cc83bb9..cc6f7f51faa5 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -484,7 +484,7 @@ static int hist_entry__init(struct hist_entry *he=
,
> > >                     goto err_infos;
> > >     }
> > >
> > > -   if (he->srcline) {
> > > +   if (he->srcline && strcmp(he->srcline, SRCLINE_UNKNOWN)) {
> > >             he->srcline =3D strdup(he->srcline);
> > >             if (he->srcline =3D=3D NULL)
> > >                     goto err_rawdata;
> > > --
> > > 2.41.0.162.gfafddb0af9-goog
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
