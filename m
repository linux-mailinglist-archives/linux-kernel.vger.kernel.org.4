Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C972CD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjFLR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjFLR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:59:51 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6665E51
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:59:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9a81da5d7so31641cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686592786; x=1689184786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILFhlbqLVYCkvMkd83ZOGAmp4d8jQSiKbMxbQnZD5rA=;
        b=tdMkRizyfMWaXZvmVYCuSYSVv7+zDgFuO1ZU7MleR5M8JC17ke+8ydQweTOJ1zbPmU
         1NRV3R/B5c1A5vEpe019yI1Hc+7oFSldlRgyqJpd3F132cvciHFG2l8UwYgKZYuJKvlx
         YLoDCZYWVSNgVtxwzCDfG7x743wTlnoQxEIi5KpiXCsracw//U6gR41Na4ea5ELqOfOX
         NQVm64FoeOuhMYYT++BMj00g7bMr9GpiTxoVEEi6z/EOuKMc1ccTRoQl8teYzYGVoaos
         bgA7yvaPTLi+lSenAmx8lDOEaX2NQHRA9kavD5yhgIVPwt6eAfhH0BMg3KrcxX+0gD2E
         +2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592786; x=1689184786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILFhlbqLVYCkvMkd83ZOGAmp4d8jQSiKbMxbQnZD5rA=;
        b=F35yEBwrQ/3li0hIwuirx8gZmK4K/LF0Zyp9XkvSAGL9Bazz6LXdxge1W9mENK/Gqp
         vPVUTv+IAnjchJuf5p8+e3r4c9IU6EMh8diqjVq9GkoUFIFsIGEOLKq0J0maz3ddttmZ
         ybD55nwlZVtwK+yJ0rw3vPSsIVz0nbtLyogVJZf0POeClwqLCiM7tsjQRKErnTM8fgHP
         tSgyqOm6E3IxH4bDPOrctK8602tIcf/zdQaCCaJEA6/8NxOh5lSN4ZAT8YA0x6Tes0Z9
         sEHYY7IpWySWvI06JMUOrz0+3Ap7pE9N0oZ4Nsf2SvvJTRRDIkw0zopWsVgU5eHegetR
         qvbQ==
X-Gm-Message-State: AC+VfDzQYJWpJqVgcLKi7jyUjj3IuCiM8TEVnCfgJbIu6Jfv56jYiOre
        tnRmlXrQk/28ZveTpfON/kAYbO7COwzXVmFEGU3qJI7kTpkM0Wo9cpDbjQ==
X-Google-Smtp-Source: ACHHUZ4bUM8GRJd5hVVOzLx255CUquI4ffTrwuQNTvagqC6syOQfcoCVYYTHioGEnalkJNjwbHb4niB5dw4dIvZm8q4=
X-Received: by 2002:a05:622a:1187:b0:3f9:f877:1129 with SMTP id
 m7-20020a05622a118700b003f9f8771129mr220710qtk.29.1686592785710; Mon, 12 Jun
 2023 10:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230612150424.198914-1-james.clark@arm.com> <CAP-5=fWu0yCSCB__prps2g=JRDScbhWuimPJHUsU0S_c0ywDhg@mail.gmail.com>
 <ZIdWBl+MZYKI83Mb@kernel.org> <ZIdYkRHj8tkaxgED@kernel.org>
In-Reply-To: <ZIdYkRHj8tkaxgED@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 10:59:34 -0700
Message-ID: <CAP-5=fWpBSG5kJygrYQ7SSN7iRWodV+CUpME84BkmKpLJvmjeQ@mail.gmail.com>
Subject: Re: [PATCH] perf map: Fix refcount errors on Arm with -DREFCNT_CHECKING=1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 10:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 12, 2023 at 02:29:42PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Jun 12, 2023 at 09:32:30AM -0700, Ian Rogers escreveu:
> > > On Mon, Jun 12, 2023 at 8:05=E2=80=AFAM James Clark <james.clark@arm.=
com> wrote:
> > > >
> > > > When quitting after running a perf report, the refcount checker fin=
ds
> > > > some double frees. The issue is that map__put() is called on a func=
tion
> > > > argument so it removes the refcount wrapper that someone else was u=
sing.
> > > >
> > > > Fix it by only calling map__put() on a reference that is owned by t=
his
> > > > function.
> > > >
> > > > Signed-off-by: James Clark <james.clark@arm.com>
> > >
> > > Acked-by: Ian Rogers <irogers@google.com>
> > >
> > > > ---
> > > >  tools/perf/util/symbol-elf.c | 9 +++++----
> > > >  tools/perf/util/symbol.c     | 9 +++++----
> > > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-=
elf.c
> > > > index 63882a4db5c7..ec0d7810bbb0 100644
> > > > --- a/tools/perf/util/symbol-elf.c
> > > > +++ b/tools/perf/util/symbol-elf.c
> > > > @@ -1365,6 +1365,7 @@ static int dso__process_kernel_symbol(struct =
dso *dso, struct map *map,
> > > >         struct dso *curr_dso =3D *curr_dsop;
> > > >         struct map *curr_map;
> > > >         char dso_name[PATH_MAX];
> > > > +       struct map *map_ref;
> > >
> > > nit: can we narrow the scope of this by moving it to the scope where =
it is used.
> >
> > Which is what you did in a patch I already processed, its only in
> > tmp.perf-tools-next as I was going thru the other patches, but this one
> > is there already.
> >
> > I'm checking the tools/perf/util/symbol.c part.
>
> I narrowed the scope and removed the symbol-elf.c part, end result:
>
> From 6fd34445b8c94aa7f519fb0b1ed45c7ef9f6cc4e Mon Sep 17 00:00:00 2001
> From: James Clark <james.clark@arm.com>
> Date: Mon, 12 Jun 2023 16:04:24 +0100
> Subject: [PATCH 1/1] perf map: Fix double 'struct map' reference free fou=
nd
>  with -DREFCNT_CHECKING=3D1
>
> When quitting after running a 'perf report', the refcount checker finds
> some double frees. The issue is that map__put() is called on a function
> argument so it removes the refcount wrapper that someone else was using.
>
> Fix it by only calling map__put() on a reference that is owned by this
> function.
>
> Committer notes:
>
> Narrowed the map_ref scope as suggested by Ian, removed the symbol-elf
> part as it was already fixed by another patch, from Ian.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20230612150424.198914-1-james.clark@arm.c=
om
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks Arnaldo! I think we should be able to automate finding these
issues with the warn_unused_result function attribute:

```
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 66a87b3d9965..2c77c28ff000 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -172,7 +172,7 @@ struct map *map__new2(u64 start, struct dso *dso);
void map__delete(struct map *map);
struct map *map__clone(struct map *map);

-static inline struct map *map__get(struct map *map)
+__attribute__ ((warn_unused_result)) static inline struct map
*map__get(struct map *map)
{
       struct map *result;

diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 83144e0645ed..5b74465316dd 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -60,7 +60,7 @@ struct maps *maps__new(struct machine *machine);
bool maps__empty(struct maps *maps);
int maps__clone(struct thread *thread, struct maps *parent);

-struct maps *maps__get(struct maps *maps);
+struct maps *maps__get(struct maps *maps) __attribute__ ((warn_unused_resu=
lt));
void maps__put(struct maps *maps);

static inline void __maps__zput(struct maps **map)
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 8c0731c6cbb7..04e1878b9551 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -50,7 +50,7 @@ int nsinfo__init(struct nsinfo *nsi);
struct nsinfo *nsinfo__new(pid_t pid);
struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);

-struct nsinfo *nsinfo__get(struct nsinfo *nsi);
+struct nsinfo *nsinfo__get(struct nsinfo *nsi) __attribute__
((warn_unused_result));
void nsinfo__put(struct nsinfo *nsi);

bool nsinfo__need_setns(const struct nsinfo *nsi);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 9068a21ce0fa..c6228252b093 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -71,7 +71,7 @@ struct thread *thread__new(pid_t pid, pid_t tid);
irogers@irogers-glaptop0:~/kernel.org$ git diff
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 66a87b3d9965..2c77c28ff000 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -172,7 +172,7 @@ struct map *map__new2(u64 start, struct dso *dso);
void map__delete(struct map *map);
struct map *map__clone(struct map *map);

-static inline struct map *map__get(struct map *map)
+__attribute__ ((warn_unused_result)) static inline struct map
*map__get(struct map *map)
{
       struct map *result;

diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 83144e0645ed..5b74465316dd 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -60,7 +60,7 @@ struct maps *maps__new(struct machine *machine);
bool maps__empty(struct maps *maps);
int maps__clone(struct thread *thread, struct maps *parent);

-struct maps *maps__get(struct maps *maps);
+struct maps *maps__get(struct maps *maps) __attribute__ ((warn_unused_resu=
lt));
void maps__put(struct maps *maps);

static inline void __maps__zput(struct maps **map)
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 8c0731c6cbb7..04e1878b9551 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -50,7 +50,7 @@ int nsinfo__init(struct nsinfo *nsi);
struct nsinfo *nsinfo__new(pid_t pid);
struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);

-struct nsinfo *nsinfo__get(struct nsinfo *nsi);
+struct nsinfo *nsinfo__get(struct nsinfo *nsi) __attribute__
((warn_unused_result));
void nsinfo__put(struct nsinfo *nsi);

bool nsinfo__need_setns(const struct nsinfo *nsi);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 9068a21ce0fa..c6228252b093 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -71,7 +71,7 @@ struct thread *thread__new(pid_t pid, pid_t tid);
int thread__init_maps(struct thread *thread, struct machine *machine);
void thread__delete(struct thread *thread);

-struct thread *thread__get(struct thread *thread);
+struct thread *thread__get(struct thread *thread) __attribute__
((warn_unused_result));
void thread__put(struct thread *thread);

static inline void __thread__zput(struct thread **thread)
```

This shows the problem like:
```
util/symbol.c: In function =E2=80=98dso__load_kcore=E2=80=99:
util/symbol.c:1467:25: error: ignoring return value of =E2=80=98map__get=E2=
=80=99
declared with attribute =E2=80=98warn_unused_result=E2=80=99 [-Werror=3Dunu=
sed-result]
1467 |                         map__get(map);
     |
```

I double checked and the symbol.c issue was the only one in my build
environment. Using warn_unused_result should be done via compiler.h
which is a bit more than the patch above.

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 6b9c55784b56a4be..d275d3bef7d54a40 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1458,16 +1458,18 @@ static int dso__load_kcore(struct dso *dso, struc=
t map *map,
>                 list_del_init(&new_node->node);
>
>                 if (RC_CHK_ACCESS(new_map) =3D=3D RC_CHK_ACCESS(replaceme=
nt_map)) {
> +                       struct map *map_ref;
> +
>                         map__set_start(map, map__start(new_map));
>                         map__set_end(map, map__end(new_map));
>                         map__set_pgoff(map, map__pgoff(new_map));
>                         map__set_map_ip(map, map__map_ip_ptr(new_map));
>                         map__set_unmap_ip(map, map__unmap_ip_ptr(new_map)=
);
>                         /* Ensure maps are correctly ordered */
> -                       map__get(map);
> -                       maps__remove(kmaps, map);
> -                       err =3D maps__insert(kmaps, map);
> -                       map__put(map);
> +                       map_ref =3D map__get(map);
> +                       maps__remove(kmaps, map_ref);
> +                       err =3D maps__insert(kmaps, map_ref);
> +                       map__put(map_ref);
>                         map__put(new_map);
>                         if (err)
>                                 goto out_err;
> --
> 2.37.1
>
