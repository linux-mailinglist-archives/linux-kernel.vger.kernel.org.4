Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD62B6C1D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjCTRAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjCTRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:00:07 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6249E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:53:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3d7aef37dccso665561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679331123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWdoWDWA2zGPZh0WiVzdHXKzQ7+JwitNTcH7EoLdDD4=;
        b=JUOmn+coycE/EZ7iH4iVpsdGiO+mRNACqNbBuvboslwjg0vx2iflIKy+tQBpSKDgPF
         RKd8xIpUZL3SPQGV5M9mUVZcSPnDqku0sBNGrqMwR9XYxt7eLRTxIgvqSNaAkWQSn3GK
         bpFwyvql70NcmdJtRHfivjeeYmeXQWIaT3C54Ai5YxWQeSkD5Bv93/+UhHea0kuW5c0g
         Y85PLMRCUl0ct8JKewrxRf60k6+OV6wbOptlczf3ATCmMT4zWjqHPbDthHhZFZVEi/w4
         8FYE/vwu3Ml3zDSqEcuMfqG26fNyUcTOLU64El+cBXuSveK7ae8bYK/2t3Lkr7GMbLWT
         KdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWdoWDWA2zGPZh0WiVzdHXKzQ7+JwitNTcH7EoLdDD4=;
        b=jQ8yD2TKfN+JcVQS9RfhjOsr99xNlWVGgpFzIj444+WstG5Ny+N6RWNBH7Nzbkoock
         aRuJhkgLNmOJodfC32FgmRLY1Z/x1a1Qjmix9l2b/WAnoZH9hwpH/HitHSpKOdtulT/m
         BD2v8C30r6AFnKRA3PRX0izeGCgOCwWmiGRA5lGLVKO1gxDC1wHzQdFW6rvutk938G/g
         IkAuZzxDDIlGjzyyHrgioXAprOaR9udZGhXJ15uUCxYOqFx5u/krcpvPkrjvCVlX58Tj
         umk6YSjO7IzcVKH+fMnlo4gW4wrnUUM0chcyN09wkDMyPt91b66XttxfJR9aIYIOnwcv
         KF8g==
X-Gm-Message-State: AO0yUKX3F0GU+4LxJAYsV4J2xmS1itOML5jIuVQjAX09nHq8mtcfSPmE
        8LU9c0ho+E7GXhZ7n7s8HziyTBzdc2rwrqSKVhXUjg==
X-Google-Smtp-Source: AK7set+Y1fwvfOdhcp8ps7/hB2cFnwNpfmS3RD7cFF670/6JNHoxxKK6FNeecOJDr1opNO05RhxeefX77wgr6EZlyuw=
X-Received: by 2002:ac8:5d8b:0:b0:3de:8cbe:47af with SMTP id
 d11-20020ac85d8b000000b003de8cbe47afmr509962qtx.9.1679331122765; Mon, 20 Mar
 2023 09:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com> <20230320033810.980165-7-irogers@google.com>
 <ZBiAVI6q36shEKF4@kernel.org>
In-Reply-To: <ZBiAVI6q36shEKF4@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 09:51:51 -0700
Message-ID: <CAP-5=fXwdkQtxXiv_boUiUFm6dDN1paW6+d1ks01xhXFnfMGdw@mail.gmail.com>
Subject: Re: [PATCH v4 06/22] perf map: Move map list node into symbol
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 8:48=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Mar 19, 2023 at 08:37:54PM -0700, Ian Rogers escreveu:
> > Using a perf map as a list node is only done in symbol. Move the
> > list_node struct into symbol as a single pointer to the map. This
> > makes reference count behavior more obvious and easy to check.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/map.h    |  5 +--
> >  tools/perf/util/symbol.c | 90 ++++++++++++++++++++++++++--------------
> >  2 files changed, 60 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 3dcfe06db6b3..2879cae05ee0 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -16,10 +16,7 @@ struct maps;
> >  struct machine;
> >
> >  struct map {
> > -     union {
> > -             struct rb_node  rb_node;
> > -             struct list_head node;
> > -     };
> > +     struct rb_node          rb_node;
> >       u64                     start;
> >       u64                     end;
> >       bool                    erange_warned:1;
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index a458aa8b87bb..2676a163e237 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -48,6 +48,11 @@ static bool symbol__is_idle(const char *name);
> >  int vmlinux_path__nr_entries;
> >  char **vmlinux_path;
> >
> > +struct map_list_node {
> > +     struct list_head node;
> > +     struct map *map;
> > +};
> > +
> >  struct symbol_conf symbol_conf =3D {
> >       .nanosecs               =3D false,
> >       .use_modules            =3D true,
> > @@ -1219,16 +1224,22 @@ struct kcore_mapfn_data {
> >  static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
> >  {
> >       struct kcore_mapfn_data *md =3D data;
> > -     struct map *map;
> > +     struct map_list_node *list_node;
> > +
> > +     list_node =3D malloc(sizeof(*list_node));
> > +     if (list_node =3D=3D NULL)
> > +             return -ENOMEM;
>
> So this is open coding map_list_node__new(), can we have it defined
> right after the struct map_list_node definition?
>
> I've applied the 1-5 patches in this series to my local branch, testing
> now.

Thanks Arnaldo. Done for v5 as a wrapper of malloc as each call site
modifies the map in unique ways.

Ian

> - Arnaldo
>
> >
> > -     map =3D map__new2(start, md->dso);
> > -     if (map =3D=3D NULL)
> > +     list_node->map =3D map__new2(start, md->dso);
> > +     if (list_node->map =3D=3D NULL) {
> > +             free(list_node);
> >               return -ENOMEM;
> > +     }
> >
> > -     map->end =3D map->start + len;
> > -     map->pgoff =3D pgoff;
> > +     list_node->map->end =3D list_node->map->start + len;
> > +     list_node->map->pgoff =3D pgoff;
> >
> > -     list_add(&map->node, &md->maps);
> > +     list_add(&list_node->node, &md->maps);
> >
> >       return 0;
> >  }
> > @@ -1264,12 +1275,19 @@ int maps__merge_in(struct maps *kmaps, struct m=
ap *new_map)
> >                                * |new.............| -> |new..|       |n=
ew..|
> >                                *       |old....|    ->       |old....|
> >                                */
> > -                             struct map *m =3D map__clone(new_map);
> > +                             struct map_list_node *m;
> >
> > +                             m =3D malloc(sizeof(*m));
> >                               if (!m)
> >                                       return -ENOMEM;
> >
> > -                             m->end =3D old_map->start;
> > +                             m->map =3D map__clone(new_map);
> > +                             if (!m->map) {
> > +                                     free(m);
> > +                                     return -ENOMEM;
> > +                             }
> > +
> > +                             m->map->end =3D old_map->start;
> >                               list_add_tail(&m->node, &merged);
> >                               new_map->pgoff +=3D old_map->end - new_ma=
p->start;
> >                               new_map->start =3D old_map->end;
> > @@ -1299,10 +1317,13 @@ int maps__merge_in(struct maps *kmaps, struct m=
ap *new_map)
> >       }
> >
> >       while (!list_empty(&merged)) {
> > -             old_map =3D list_entry(merged.next, struct map, node);
> > -             list_del_init(&old_map->node);
> > -             maps__insert(kmaps, old_map);
> > -             map__put(old_map);
> > +             struct map_list_node *old_node;
> > +
> > +             old_node =3D list_entry(merged.next, struct map_list_node=
, node);
> > +             list_del_init(&old_node->node);
> > +             maps__insert(kmaps, old_node->map);
> > +             map__put(old_node->map);
> > +             free(old_node);
> >       }
> >
> >       if (new_map) {
> > @@ -1317,7 +1338,7 @@ static int dso__load_kcore(struct dso *dso, struc=
t map *map,
> >  {
> >       struct maps *kmaps =3D map__kmaps(map);
> >       struct kcore_mapfn_data md;
> > -     struct map *old_map, *new_map, *replacement_map =3D NULL, *next;
> > +     struct map *old_map, *replacement_map =3D NULL, *next;
> >       struct machine *machine;
> >       bool is_64_bit;
> >       int err, fd;
> > @@ -1378,11 +1399,12 @@ static int dso__load_kcore(struct dso *dso, str=
uct map *map,
> >       /* Find the kernel map using the '_stext' symbol */
> >       if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &s=
text)) {
> >               u64 replacement_size =3D 0;
> > +             struct map_list_node *new_node;
> >
> > -             list_for_each_entry(new_map, &md.maps, node) {
> > -                     u64 new_size =3D new_map->end - new_map->start;
> > +             list_for_each_entry(new_node, &md.maps, node) {
> > +                     u64 new_size =3D new_node->map->end - new_node->m=
ap->start;
> >
> > -                     if (!(stext >=3D new_map->start && stext < new_ma=
p->end))
> > +                     if (!(stext >=3D new_node->map->start && stext < =
new_node->map->end))
> >                               continue;
> >
> >                       /*
> > @@ -1392,40 +1414,43 @@ static int dso__load_kcore(struct dso *dso, str=
uct map *map,
> >                        * falls within more than one in the list.
> >                        */
> >                       if (!replacement_map || new_size < replacement_si=
ze) {
> > -                             replacement_map =3D new_map;
> > +                             replacement_map =3D new_node->map;
> >                               replacement_size =3D new_size;
> >                       }
> >               }
> >       }
> >
> >       if (!replacement_map)
> > -             replacement_map =3D list_entry(md.maps.next, struct map, =
node);
> > +             replacement_map =3D list_entry(md.maps.next, struct map_l=
ist_node, node)->map;
> >
> >       /* Add new maps */
> >       while (!list_empty(&md.maps)) {
> > -             new_map =3D list_entry(md.maps.next, struct map, node);
> > -             list_del_init(&new_map->node);
> > -             if (new_map =3D=3D replacement_map) {
> > -                     map->start      =3D new_map->start;
> > -                     map->end        =3D new_map->end;
> > -                     map->pgoff      =3D new_map->pgoff;
> > -                     map->map_ip     =3D new_map->map_ip;
> > -                     map->unmap_ip   =3D new_map->unmap_ip;
> > +             struct map_list_node *new_node;
> > +
> > +             new_node =3D list_entry(md.maps.next, struct map_list_nod=
e, node);
> > +             list_del_init(&new_node->node);
> > +             if (new_node->map =3D=3D replacement_map) {
> > +                     map->start      =3D new_node->map->start;
> > +                     map->end        =3D new_node->map->end;
> > +                     map->pgoff      =3D new_node->map->pgoff;
> > +                     map->map_ip     =3D new_node->map->map_ip;
> > +                     map->unmap_ip   =3D new_node->map->unmap_ip;
> >                       /* Ensure maps are correctly ordered */
> >                       map__get(map);
> >                       maps__remove(kmaps, map);
> >                       maps__insert(kmaps, map);
> >                       map__put(map);
> > -                     map__put(new_map);
> > +                     map__put(new_node->map);
> >               } else {
> >                       /*
> >                        * Merge kcore map into existing maps,
> >                        * and ensure that current maps (eBPF)
> >                        * stay intact.
> >                        */
> > -                     if (maps__merge_in(kmaps, new_map))
> > +                     if (maps__merge_in(kmaps, new_node->map))
> >                               goto out_err;
> >               }
> > +             free(new_node);
> >       }
> >
> >       if (machine__is(machine, "x86_64")) {
> > @@ -1462,9 +1487,12 @@ static int dso__load_kcore(struct dso *dso, stru=
ct map *map,
> >
> >  out_err:
> >       while (!list_empty(&md.maps)) {
> > -             map =3D list_entry(md.maps.next, struct map, node);
> > -             list_del_init(&map->node);
> > -             map__put(map);
> > +             struct map_list_node *list_node;
> > +
> > +             list_node =3D list_entry(md.maps.next, struct map_list_no=
de, node);
> > +             list_del_init(&list_node->node);
> > +             map__put(list_node->map);
> > +             free(list_node);
> >       }
> >       close(fd);
> >       return -EINVAL;
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
>
> --
>
> - Arnaldo
