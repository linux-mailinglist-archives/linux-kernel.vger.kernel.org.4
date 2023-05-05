Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2124B6F8A58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjEEUqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjEEUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:46:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AA4ECD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:46:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef36d814a5so1180721cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683319602; x=1685911602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/s9My8H4cCPZPBiY4BlplIQfiwdkVVysMC+ak2ie9Q=;
        b=Fb3LMCNaqBZ3DDFbg4Q/J3CLGNRHc83iTyOzQujFh6ddgRVuMufM/52DLIUzM5IrMN
         R/5EPlW71DMij+/t8o7M6KlZ3zdO5wGPfIyG3AjVg6cn4RTPU2jqsY50kuhVQsmBydsc
         xaPmgoJi7xeY+yZG8nAeshcAQNHabwFnaFcCk7IZYBj0ifRWIlTL8XmsQAQaA+506QuE
         Pi3xGmPQhZQd7IsajszL4jQIQw1whX0PocM1Ser2fnyHtWIIczu/7BfnMYOAvluJEWZW
         xn1rBBOMAupCVC0xmOwGhyNxaguRtQ/h+nybpW1GcS2KqYfLWWV3R7vavM/b1sxM6toM
         wn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319602; x=1685911602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/s9My8H4cCPZPBiY4BlplIQfiwdkVVysMC+ak2ie9Q=;
        b=RFj5jupoPOtg6fOIvuseRotyAzjuStEGIfasUQcIilK+IRh/BPm9AgpMx1CfeAQVqK
         oxNJGb9vM7h8yFSkoLpoGKnKK/XIxGi9UAiV8YJ2ZE+lJQAqHUYhseesXwcrK6v2n6uo
         QfFcG+mG3epHAePLuPy5GG8DWnuNi4gEpnkIJHY0ds7jz+zqrqbLJ0zhn7g/lJ701H13
         AtawLfeiqYQRlebQXFs259hZB79vDZ/VDZdvX65Ju9WpyI7/wjPZ8lJrV2Sc2Ut7DyZk
         UPasHqcAR08U0RLCN0FGt0OfMVkP3iMHimyFQw8GuolD6zaYp1AYxTH8TaY2v/0+rTEw
         lvJA==
X-Gm-Message-State: AC+VfDznDFDiXC+IWQM57YIIfuMqjLBjJSJjk0/3mtkKRHpMQndi+Bsq
        e8NiBYmXTw/+GJ0pYJm5/vlMuu/Kq+amvvV+p57kBA==
X-Google-Smtp-Source: ACHHUZ6r35soXoYb3Vr/ajkeJ2LbbzSWSiHaf6n7tOIj6q+JtAt+eHi1x8dxvBt7Hu1q/mP/oaCdXxr9BVLPQfhs9SA=
X-Received: by 2002:a05:622a:14d4:b0:3ef:2f55:2204 with SMTP id
 u20-20020a05622a14d400b003ef2f552204mr85499qtx.6.1683319601659; Fri, 05 May
 2023 13:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org> <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava> <ZFUFmxDU/6Z/JEsi@kernel.org> <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com> <ZFVqeKLssg7uzxzI@krava>
In-Reply-To: <ZFVqeKLssg7uzxzI@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 May 2023 13:46:30 -0700
Message-ID: <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Clarke <pc@us.ibm.com>
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

On Fri, May 5, 2023 at 1:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > On Fri, May 5, 2023 at 9:56=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > That with the preserve_access_index isn't needed, we need just the
> > > > fields that we access in the tools, right?
> > >
> > > I'm now doing build test this in many distro containers, without the =
two
> > > reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> > > test build and also for the functionality tests on the tools using su=
ch
> > > bpf skels, see below, no touching of vmlinux nor BTF data during the
> > > build.
> > >
> > > - Arnaldo
> > >
> > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 200=
1
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated f=
rom BTF,
> > >  use subset of used structs + CO-RE
> > >
> > > Linus reported a build break due to using a vmlinux without a BTF elf
> > > section to generate the vmlinux.h header with bpftool for use in the =
BPF
> > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > >
> > > Instead add a vmlinux.h file with the structs needed with the fields =
the
> > > tools need, marking the structs with __attribute__((preserve_access_i=
ndex)),
> > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > >
> > > In some cases the vmlinux.h file that was being generated by bpftool
> > > from the kernel BTF information was not needed at all, just including
> > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > types were not being used.
> > >
> > > To keep te patch small, include those UAPI headers from the trimmed d=
own
> > > vmlinux.h file, that then provides the tools with just the structs an=
d
> > > the subset of its fields needed for them.
> > >
> > > Testing it:
> > >
> > >   # perf lock contention -b find / > /dev/null
>
> I tested perf lock con -abv -L rcu_state sleep 1
> and needed fix below
>
> jirka

I thought this was fixed by:
https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kernel.org/
but I think that is just in perf-tools-next.

Thanks,
Ian

> ---
> From b12aea55f1171dc09cde2957f9019c84bda7adbb Mon Sep 17 00:00:00 2001
> From: Jiri Olsa <jolsa@kernel.org>
> Date: Fri, 5 May 2023 13:28:46 +0200
> Subject: [PATCH] perf tools: Fix lock_contention bpf program
>
> We need to define empty 'struct rq' so the runqueues gets
> resolved properly:
>
>   # ./perf lock con -b
>   libbpf: extern (var ksym) 'runqueues': incompatible types, expected [99=
] fwd rq, but kernel has [19783] struct rq
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
>   Failed to load lock-contention BPF skeleton
>
> Also rq__old/rq__new need additional '_' so the suffix is ignored
> properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 8911e2a077d8..c2bf24c68c14 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -416,13 +416,15 @@ int contention_end(u64 *ctx)
>         return 0;
>  }
>
> +struct rq {};
> +
>  extern struct rq runqueues __ksym;
>
> -struct rq__old {
> +struct rq___old {
>         raw_spinlock_t lock;
>  } __attribute__((preserve_access_index));
>
> -struct rq__new {
> +struct rq___new {
>         raw_spinlock_t __lock;
>  } __attribute__((preserve_access_index));
>
> @@ -434,8 +436,8 @@ int BPF_PROG(collect_lock_syms)
>
>         for (int i =3D 0; i < MAX_CPUS; i++) {
>                 struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
> -               struct rq__new *rq_new =3D (void *)rq;
> -               struct rq__old *rq_old =3D (void *)rq;
> +               struct rq___new *rq_new =3D (void *)rq;
> +               struct rq___old *rq_old =3D (void *)rq;
>
>                 if (rq =3D=3D NULL)
>                         break;
> --
> 2.40.1
>
