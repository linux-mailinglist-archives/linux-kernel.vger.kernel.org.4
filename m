Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB7730CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjFOBuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbjFOBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:49:56 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1A2DF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:49:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f9b7de94e7so114561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686793793; x=1689385793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUGtQqvU4doNuraDYOeyIMqy4qa8mxp0g8G/zCpNJBo=;
        b=3Mv27sSob3hnvKuUvL3GhR2J4Zug+RHsAbzy84j7grFB9UCkt7jfIecOwlmblOnMSu
         fSZobWYEatbbU9bsg0RQGMrLx7gqLaHPMyRMW1P4XPQev2XkQszTJYIC2WevLfj40y+Q
         5d5TyZCLlIc1BxEO12Ih9+C+CR4Ob+Ubm4q9QMBwSrLlNJZfHImfU1KCxmZHDykq6Xrt
         uNa8QeKKkeqyty/4LUCkGVassMhskovsomi3LMqw6gmutN7KnJps2cd+T+zgH5qTjpbn
         /gWF//Tvx7UeDdYMQ+O4QTaHyDn7A8GhLNYZkuZy3szjUGtlXhmmmZghlyswfM8HhVeZ
         7fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686793793; x=1689385793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUGtQqvU4doNuraDYOeyIMqy4qa8mxp0g8G/zCpNJBo=;
        b=guk5ckYbYLF32tLJw1D2bYlJrtlpzAnNEFshF0iKUR+AOE7EKvHWBVwGKtXUryRoJa
         zZ23FaUpjfhUlnDijMsdQQ28VdoPszYwrB8HRP/+VGcMNsBuuw4RwOkUMmtc/vfPaMVY
         n24bSr6CeTUG6jGM4AWletLFdwLJb+u3/GXfl1wCTlo7ya/PHI0/eTVfw6jMAkKfGTtY
         UArDwDtesJFoBGgFEC8vI2OV2uRKp2gwNRIaThToVL0OoMJTi0cW8vQntwVMIEK+qJ8k
         Fevn42fl76M1jPWjhz+FI5M3/EYOnpIEyMzmltt3QTYgVrcHi7zvZHVJJHqU/72WV402
         dmFQ==
X-Gm-Message-State: AC+VfDzo9HQV3pw8clpxZlFoPqVbdPQZWP0gYdm9nwgNjrblU+kj5ZQq
        sKQ07tUSmUb5DtYmXnYtASFlcNyFShBh0IA9WejwZA==
X-Google-Smtp-Source: ACHHUZ5OzkM+LrRZ88OrNNphLBUf+eDdvEyc3WQaRwb7gJ+Ywe27HFMwPFkXbELIdJ7l2Btkk8db8svt/LaE4HHJOIY=
X-Received: by 2002:a05:622a:1748:b0:3f8:3065:7fc5 with SMTP id
 l8-20020a05622a174800b003f830657fc5mr39981qtk.1.1686793793518; Wed, 14 Jun
 2023 18:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230611072751.637227-1-irogers@google.com> <20230611072751.637227-2-irogers@google.com>
 <CAM9d7ci5zL8NWMrJVq4FQ242LNx0cQoY3Z32B+yuO2HFu6R1gA@mail.gmail.com>
In-Reply-To: <CAM9d7ci5zL8NWMrJVq4FQ242LNx0cQoY3Z32B+yuO2HFu6R1gA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 18:49:40 -0700
Message-ID: <CAP-5=fXnqZxWVbgMcainpTPc6mSHjUu3y1tELjdRk2zfLM4bOw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf annotation: Switch lock from a mutex to a sharded_mutex
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Wed, Jun 14, 2023 at 5:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Sun, Jun 11, 2023 at 12:28=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Remove the "struct mutex lock" variable from annotation that is
> > allocated per symbol. This removes in the region of 40 bytes per
> > symbol allocation. Use a sharded mutex where the number of shards is
> > set to the number of CPUs. Assuming good hashing of the annotation
> > (done based on the pointer), this means in order to contend there
> > needs to be more threads than CPUs, which is not currently true in any
> > perf command. Were contention an issue it is straightforward to
> > increase the number of shards in the mutex.
> >
> > On my Debian/glibc based machine, this reduces the size of struct
> > annotation from 136 bytes to 96 bytes, or nearly 30%.
>
> That's quite a good improvement given the number of symbols
> we can have in a report session!
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> [SNIP]
> > @@ -1291,17 +1292,64 @@ int disasm_line__scnprintf(struct disasm_line *=
dl, char *bf, size_t size, bool r
> >         return ins__scnprintf(&dl->ins, bf, size, &dl->ops, max_ins_nam=
e);
> >  }
> >
> > -void annotation__init(struct annotation *notes)
> > +void annotation__exit(struct annotation *notes)
> >  {
> > -       mutex_init(&notes->lock);
> > +       annotated_source__delete(notes->src);
> >  }
> >
> > -void annotation__exit(struct annotation *notes)
> > +static struct sharded_mutex *sharded_mutex;
> > +
> > +static void annotation__init_sharded_mutex(void)
> >  {
> > -       annotated_source__delete(notes->src);
> > -       mutex_destroy(&notes->lock);
> > +       /* As many mutexes as there are CPUs. */
> > +       sharded_mutex =3D sharded_mutex__new(cpu__max_present_cpu().cpu=
);
> > +}
> > +
> > +static size_t annotation__hash(const struct annotation *notes)
> > +{
> > +       return ((size_t)notes) >> 4;
>
> But I'm afraid it might create more contention depending on the
> malloc implementation.  If it always returns 128-byte (or 256)
> aligned memory for this struct then it could always collide in the
> slot 0 if the number of CPU is 8 or less, right?

Right, I think we can use a secondary hash and hashmap.h has one lying
around for us:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/hashmap.h?h=3Dtmp.perf-tools-next#n15
it will mean that the sharded locks will need to be a power of 2
capacity. I'll work on a v2. Fwiw, the hash of a pointer for
collection like those in abseil is just the pointer value, so I'll
drop the shift to remove the low-bits once I'm using a more expensive
hash function.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  }
> >
> > +static struct mutex *annotation__get_mutex(const struct annotation *no=
tes)
> > +{
> > +       static pthread_once_t once =3D PTHREAD_ONCE_INIT;
> > +
> > +       pthread_once(&once, annotation__init_sharded_mutex);
> > +       if (!sharded_mutex)
> > +               return NULL;
> > +
> > +       return sharded_mutex__get_mutex(sharded_mutex, annotation__hash=
(notes));
> > +}
> > +
> > +void annotation__lock(struct annotation *notes)
> > +       NO_THREAD_SAFETY_ANALYSIS
> > +{
> > +       struct mutex *mutex =3D annotation__get_mutex(notes);
> > +
> > +       if (mutex)
> > +               mutex_lock(mutex);
> > +}
> > +
> > +void annotation__unlock(struct annotation *notes)
> > +       NO_THREAD_SAFETY_ANALYSIS
> > +{
> > +       struct mutex *mutex =3D annotation__get_mutex(notes);
> > +
> > +       if (mutex)
> > +               mutex_unlock(mutex);
> > +}
> > +
> > +bool annotation__trylock(struct annotation *notes)
> > +{
> > +       struct mutex *mutex =3D annotation__get_mutex(notes);
> > +
> > +       if (!mutex)
> > +               return false;
> > +
> > +       return mutex_trylock(mutex);
> > +}
> > +
> > +
> >  static void annotation_line__add(struct annotation_line *al, struct li=
st_head *head)
> >  {
> >         list_add_tail(&al->node, head);
