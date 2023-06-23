Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE273AE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFWA4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFWA4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:56:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43853268A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:56:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4007b5bafceso56541cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687481802; x=1690073802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ikq5b9kgTceT+X+WpMJVM1coIwpvRfiKLd0ATl6S7OQ=;
        b=JUAI62BobRApovyUny4rN/CIgEhRU64qfCjg7BoeX/mTynRJsLfPpsZSOElY1GBU6b
         4Cg2dAlChBeV5KCkC1a2zCVf7i+EpSe0nPoFHNcb3TiTgkrR2ywCeCbEH+GakIAfs0d4
         +eIEAF3ufXOyt2GXc2o6Ne07aX5VIvKmPKtyWk2lMv6JkcaylwzxKPZ6TMNAEhe6Dt13
         dMOl6AyO/JCbkK21Rs2lY79wQkWqiLX18brhTk6/iXRvw45RCAuSZkRdXbrYEiPLfGrm
         160tU0FbtVi9xuDEZ0rG0QJ2JY3dqL7EXukQAGdMDWrgvnw/H0exCAStJcaMyN9jmfCY
         VVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687481802; x=1690073802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikq5b9kgTceT+X+WpMJVM1coIwpvRfiKLd0ATl6S7OQ=;
        b=AP3AErO7xHRyVCXAf8XRzt8droKzq/Z4kUJ4Rxqf9R1HEvUOh9H9vkYOciz2uj7JGf
         19iQUAD5pjddUCTeOPpvvbHaRodxFayAh8dLLDfZg0mZdPujckA9rrNY/EElAgAhxIg7
         yAd/eKVGcn0l3cBTglhiH0/GEYCAOS6KBKsYCVByHqSoWmiISaVbblPralOt65fJqjPw
         z/e9HF7HoqpiIWefNQ5lONmF4SS9474RElXc4vveLZGhGgIPLn7N/6T2Zpp+X9Sy2aQy
         VsLZafOgvVKMmIaPBWVr72exyoAi0NWRGVzU86yMymqWc5C5dD06pqgO3wzAhbQH60Ft
         H2kw==
X-Gm-Message-State: AC+VfDx7gEOJtJez4cB7bzNU+29u4hKTEyPSAfNKQtYAXOX38H6gDdYS
        O1x8Cq4m2lhfxkVJpO5v7p3gORUa0PrUCUvpE8dCiQ==
X-Google-Smtp-Source: ACHHUZ5+4WAa4iuwtTStbNTVmHUKj2RWDXvJqcEsOKPMfHsa8pq/mwhCbgeDKx7ifa9n3ihbIa4FsDhCM2n3c/UvbLM=
X-Received: by 2002:a05:622a:138f:b0:3fd:aaef:3807 with SMTP id
 o15-20020a05622a138f00b003fdaaef3807mr21214qtk.16.1687481802209; Thu, 22 Jun
 2023 17:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230525220927.3544192-1-namhyung@kernel.org> <CAP-5=fWOji8vCQfO-y4HnmFk2k+F70BtGHTjCg6XyORNfYNcww@mail.gmail.com>
 <CAM9d7cgnOzVV7ww-+4N_mccgn9r_xYX1LeExgxDOo0x5NG=Zqw@mail.gmail.com>
In-Reply-To: <CAM9d7cgnOzVV7ww-+4N_mccgn9r_xYX1LeExgxDOo0x5NG=Zqw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 17:56:30 -0700
Message-ID: <CAP-5=fXPpWgs6JXpQgvwrWmAFCVFwP3a_dq95YwnYuUbo+GQaA@mail.gmail.com>
Subject: Re: [PATCH] tools lib subcmd: Show parent options in help
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

On Thu, Jun 22, 2023 at 3:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jun 21, 2023 at 12:05=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Thu, May 25, 2023 at 3:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > I've just realized that help message in a subcommand didn't show one
> > > in the parent command.  Since the option parser understands the paren=
t,
> > > display code should do the same.  For example, `perf ftrace latency -=
h`
> > > should show options in the `perf ftrace` command too.
> > >
> > > Before:
> > >
> > >   $ perf ftrace latency -h
> > >
> > >    Usage: perf ftrace [<options>] [<command>]
> > >       or: perf ftrace [<options>] -- [<command>] [<options>]
> > >       or: perf ftrace {trace|latency} [<options>] [<command>]
> > >       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<op=
tions>]
> > >
> > >       -b, --use-bpf         Use BPF to measure function latency
> > >       -n, --use-nsec        Use nano-second histogram
> > >       -T, --trace-funcs <func>
> > >                             Show latency of given function
> > >
> > > After:
> > >
> > >   $ perf ftrace latency -h
> > >
> > >    Usage: perf ftrace [<options>] [<command>]
> > >       or: perf ftrace [<options>] -- [<command>] [<options>]
> > >       or: perf ftrace {trace|latency} [<options>] [<command>]
> > >       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<op=
tions>]
> > >
> > >       -a, --all-cpus        System-wide collection from all CPUs
> > >       -b, --use-bpf         Use BPF to measure function latency
> > >       -C, --cpu <cpu>       List of cpus to monitor
> > >       -n, --use-nsec        Use nano-second histogram
> > >       -p, --pid <pid>       Trace on existing process id
> > >       -T, --trace-funcs <func>
> > >                             Show latency of given function
> > >       -v, --verbose         Be more verbose
> > >           --tid <tid>       Trace on existing thread id (exclusive to=
 --pid)
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/lib/subcmd/parse-options.c | 26 ++++++++++++++++++--------
> > >  1 file changed, 18 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/pars=
e-options.c
> > > index 9fa75943f2ed..41de97671c72 100644
> > > --- a/tools/lib/subcmd/parse-options.c
> > > +++ b/tools/lib/subcmd/parse-options.c
> > > @@ -806,18 +806,28 @@ static int option__cmp(const void *va, const vo=
id *vb)
> > >
> > >  static struct option *options__order(const struct option *opts)
> > >  {
> > > -       int nr_opts =3D 0, nr_group =3D 0, len;
> > > -       const struct option *o =3D opts;
> > > -       struct option *opt, *ordered, *group;
> > > +       int nr_opts =3D 0, nr_group =3D 0, nr_parent =3D 0, len;
> > > +       const struct option *o, *p =3D opts;
> > > +       struct option *opt, *ordered =3D NULL, *group;
> > >
> > > -       for (o =3D opts; o->type !=3D OPTION_END; o++)
> > > +retry:
> >
> > Why use "goto retry" and not compute the size with the parent upfront?
>
> No specific reason, just followed the same pattern as in
> parse_{short,long}_opt(). :)

:-) Could those loops not be:

for (; options; options =3D options->parent) {
...
}

rather than using a goto?

> >
> > > +       for (o =3D p; o->type !=3D OPTION_END; o++)
> > >                 ++nr_opts;
> > >
> > > -       len =3D sizeof(*o) * (nr_opts + 1);
> > > -       ordered =3D malloc(len);
> > > -       if (!ordered)
> > > +       len =3D sizeof(*o) * (nr_opts + !o->parent);
> >
> > It'd be nice to comment on why the "!o->parent" here.
>
> What about this?
>
> /* It needs a terminating NULL entry when there's no parent */

Perhaps:
the length is given by the number of options plus a null terminator
for the last loop iteration.

It may be cleaner to just compute this after nr_opts settles. perhaps
something along the lines of:

for (p =3D .. ; p; p =3D p->parent)
   for (o =3D p; o->type !=3D OPTION_END; o++)
                 ++nr_opts;
len =3D sizeof(*o) * (nr_opts + 1); /* +1 for terminator */

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >
> > Thanks,
> > Ian
> >
> > > +       group =3D realloc(ordered, len);
> > > +       if (!group)
> > >                 goto out;
> > > -       memcpy(ordered, opts, len);
> > > +       ordered =3D group;
> > > +       memcpy(&ordered[nr_parent], p, sizeof(*o) * (nr_opts - nr_par=
ent));
> > > +
> > > +       if (o->parent) {
> > > +               p =3D o->parent;
> > > +               nr_parent =3D nr_opts;
> > > +               goto retry;
> > > +       }
> > > +       /* copy the last OPTION_END */
> > > +       memcpy(&ordered[nr_opts], o, sizeof(*o));
> > >
> > >         /* sort each option group individually */
> > >         for (opt =3D group =3D ordered; opt->type !=3D OPTION_END; op=
t++) {
> > > --
> > > 2.41.0.rc0.172.g3f132b7071-goog
> > >
