Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B278730A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjFNWEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjFNWD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:03:58 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61C2695
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:03:57 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9b7de94e7so79901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686780236; x=1689372236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hBNzsqDA+ibibh6Quql+9MMSvftWOYFNSxUTSCrW9A=;
        b=waQ12cIx29ruzEBjWasuZPAkcbUNyESfpjzBm/sofM4Ba5fd80/qEqEH4Vtn2MnlC/
         McZM0JA2FfDbO9D9AXqxHMs3myciAe8MfnZXprubiA76wy41vYvDD0L/Kc0b9sOVoKXc
         2VKpI5gWnv7/meQpohmXNBqKvSUF44HRQ2y16Bm1+aShU6ECmhMNDVb1S2ox0WJAUaQE
         EjVOmvj4B4i2OUvgw9nsc4j1YuwKCpWQaeCYYSW84FtPT66HP1QOGtVvvasaPyKdq5lA
         dpk7wHCKKjPEeVbhGwL/uUw05HrzlVMF2FYZ7kN61ib1JlXLlREgoD0qQnEpD+k4lxVw
         z0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686780236; x=1689372236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hBNzsqDA+ibibh6Quql+9MMSvftWOYFNSxUTSCrW9A=;
        b=gBjjYRmKIfEfzW+GkkRU5t9yaKVC4zvlVg8yOzDwlUWB95e+7qcXaQVzWME5giIxUt
         LUJwH5bI/oRxAypRHvpbRbb/4ROIN3MG0XJPC33jnToT4gPEIT8ZPP/NPTD63YKWY+y8
         Bm4z90ApydBN55N9mFTNRxHflNqsyNVWd9zFiUV0Dw5c52WZjSl7qTYlG07OSZQMuus8
         6wzGwxkly3+80Jx3RtQ6p356INF1iEtRLVxUQUeDxkBl+V61LVPTJSRFnV47KZ4iKGOr
         UnRrIAzkGyZulYdzn77ReK+F+9DJq7EtxdjedfE1tQkGLTXMBRDAGoyXx5llIo5QkMdW
         xuRA==
X-Gm-Message-State: AC+VfDwNnUsIgocTinHLGvei4ziNmW4FrRNyHWJRH1OB70gNEJ97E0Qi
        rw639aV4FTyBbmfinD1I6E3ZDBHoHqd6dQHxPJkYEA==
X-Google-Smtp-Source: ACHHUZ42EHdoeQupLHIFSGWKznpqdzVEvwG490POEyFe+l0583GQrW1UuyjwqUW9Bb3LViSR+R/UaE2LjNzK64sFqE0=
X-Received: by 2002:a05:622a:1108:b0:3f8:5b2:aef5 with SMTP id
 e8-20020a05622a110800b003f805b2aef5mr12457qty.29.1686780235563; Wed, 14 Jun
 2023 15:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230614151625.2077-1-yangjihong1@huawei.com> <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 15:03:43 -0700
Message-ID: <CAP-5=fVOXjjcusjv858SOGrnNgE2w2sb7zS=0sZUpdFfR1T_GA@mail.gmail.com>
Subject: Re: [PATCH] perf top & record: Fix segfault when default cycles event
 is not supported
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jun 14, 2023 at 9:18=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jun 14, 2023 at 8:18=E2=80=AFAM Yang Jihong <yangjihong1@huawei.c=
om> wrote:
> >
> > The perf-record and perf-top call parse_event() to add a cycles event t=
o
> > an empty evlist. For the system that does not support hardware cycles
> > event, such as QEMU, the evlist is empty due to the following code proc=
ess:
> >
> >   parse_event(evlist, "cycles:P" or ""cycles:Pu")
> >     parse_events(evlist, "cycles:P")
> >       __parse_events
> >         ...
> >         ret =3D parse_events__scanner(str, &parse_state);
> >         // ret =3D 0
> >         ...
> >         ret2 =3D parse_events__sort_events_and_fix_groups()
> >         if (ret2 < 0)
> >           return ret;
> >         // The cycles event is not supported, here ret2 =3D -EINVAL,
> >         // Here return 0.
> >         ...
> >         evlist__splice_list_tail(evlist)
> >         // The code here does not execute to, so the evlist is still em=
pty.
> >
> > A null pointer occurs when the content in the evlist is accessed later.
> >
> > Before:
> >
> >   # perf list hw
> >
> >   List of pre-defined events (to be used in -e or -M):
> >
> >   # perf record true
> >   libperf: Miscounted nr_mmaps 0 vs 1
> >   WARNING: No sample_id_all support, falling back to unordered processi=
ng
> >   perf: Segmentation fault
> >   Obtained 1 stack frames.
> >   [0xc5beff]
> >   Segmentation fault
> >
> > Solution:
> >   If cycles event is not supported, try to fall back to cpu-clock event=
.
> >
> > After:
> >   # perf record true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.006 MB perf.data ]
> >   #
> >
> > Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>
> Thanks, useful addition. The cpu-clock fall back wasn't present before
> 7b100989b4f6 so is the fixes tag correct?

Hmm... it should be coming from evsel__fallback:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/evsel.c?h=3Dtmp.perf-tools-next#n2840
so we shouldn't duplicate that logic. The question is why we're not
doing the fallback.

Thanks,
Ian

> Wrt segv, I'm beginning to think that we should always forcibly create
> a core PMU even if we can't find one one in sysfs, my guess is that is
> what triggers the segv.
>
> evlist__add_default doesn't really explain what the function is doing
> and default can have >1 meaning. Perhaps, evlist__add_cycles.
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/builtin-record.c |  4 +---
> >  tools/perf/builtin-top.c    |  3 +--
> >  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
> >  tools/perf/util/evlist.h    |  1 +
> >  4 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index aec18db7ff23..29ae2b84a63a 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -4161,9 +4161,7 @@ int cmd_record(int argc, const char **argv)
> >                 record.opts.tail_synthesize =3D true;
> >
> >         if (rec->evlist->core.nr_entries =3D=3D 0) {
> > -               bool can_profile_kernel =3D perf_event_paranoid_check(1=
);
> > -
> > -               err =3D parse_event(rec->evlist, can_profile_kernel ? "=
cycles:P" : "cycles:Pu");
> > +               err =3D evlist__add_default(rec->evlist);
> >                 if (err)
> >                         goto out;
> >         }
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index c363c04e16df..798cb9252a5f 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1665,8 +1665,7 @@ int cmd_top(int argc, const char **argv)
> >                 goto out_delete_evlist;
> >
> >         if (!top.evlist->core.nr_entries) {
> > -               bool can_profile_kernel =3D perf_event_paranoid_check(1=
);
> > -               int err =3D parse_event(top.evlist, can_profile_kernel =
? "cycles:P" : "cycles:Pu");
> > +               int err =3D evlist__add_default(top.evlist);
> >
> >                 if (err)
> >                         goto out_delete_evlist;
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 7ef43f72098e..60efa762405e 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -287,6 +287,24 @@ struct evsel *evlist__add_aux_dummy(struct evlist =
*evlist, bool system_wide)
> >         return evsel;
> >  }
> >
> > +int evlist__add_default(struct evlist *evlist)
> > +{
> > +       bool can_profile_kernel;
> > +       int err;
> > +
> > +       can_profile_kernel =3D perf_event_paranoid_check(1);
> > +       err =3D parse_event(evlist, can_profile_kernel ? "cycles:P" : "=
cycles:Pu");
> > +       if (err)
> > +               return err;
> > +
> > +       if (!evlist->core.nr_entries) {
> > +               pr_debug("The cycles event is not supported, trying to =
fall back to cpu-clock event\n");
> > +               return parse_event(evlist, "cpu-clock");
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  #ifdef HAVE_LIBTRACEEVENT
> >  struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool sys=
tem_wide)
> >  {
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 664c6bf7b3e0..47eea809ee91 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -116,6 +116,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const=
 struct evsel *rhs);
> >
> >  int evlist__add_dummy(struct evlist *evlist);
> >  struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system=
_wide);
> > +int evlist__add_default(struct evlist *evlist);
> >  static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlis=
t *evlist)
> >  {
> >         return evlist__add_aux_dummy(evlist, true);
> > --
> > 2.30.GIT
> >
