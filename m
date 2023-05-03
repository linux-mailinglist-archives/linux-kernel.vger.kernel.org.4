Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7976F53B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjECIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjECIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:53:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA740E9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:53:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-959a3e2dd27so941808466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683103980; x=1685695980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbaAQ5UWf5QMYXvokGZmB71CDacil8tkLbI7wOrpl80=;
        b=Mxc2JCREE1yPHrD1YutRLpWerZjanLYglyXectkAajv+vGFjCFjVon+/cuIVG2lqYG
         AvBMg9a0frcRzu4xyDO08YhORm1wporFKAGPJu+/qvKnf2D+SGnJ97sPlAMDkIY57Ubv
         IoMSuTbLlDsvoCKfP+1vONSYT4IOkVAxBZenIDCdKBMQ3SpT+Rr1RUVmj+i4OS46I3ro
         08ZQWmHjb+R2AswP26CLJE7jEW0gJJyjgbvcxSYu6BKJJmizPL7E45f8nRF0FG5k8Mqt
         foeHu56la/jy3m0su/xTMX2pNY3KdU66A2I5jzZ7SzNTu6v+p0TYxTrvkM6uD+TCJWga
         mRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683103980; x=1685695980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbaAQ5UWf5QMYXvokGZmB71CDacil8tkLbI7wOrpl80=;
        b=AjDiZuAlOjkQlkIJuTZYXuUJc6IehEDUmDFJLXEPJuhGiuV8OKOu7/hJFukGYLCGmy
         9k29WKekxKId60wQ9XgPHowVSLZP+Z2gWuGqNCzHjhqJERs3XzwIa+4QQUmQEaFqwbLk
         nFb0K8gk5vBQZvvXMhRA1W9S4wDczP4zAxvdJB5vsMRwpj7N+fui8AezwmcFzqv4OCMC
         yuWcZYohqzFm4adDalzUfTjI3+fp8lzJNp9wwz7OgAlzcrqzbg6TuSSlIRUSUUQmjeRR
         zbitui1zbb6jivPoC48+JftQUPAy2Bf0DhrKTkPbmf5Ls+Jxnftpb5HxrkUE+C5FrEBr
         dVUA==
X-Gm-Message-State: AC+VfDwzErbyAQ9cNKQTYRJVIdhJNWvtlD3az/annTxb1PdYghOtZ1jZ
        KVXX4Y0/bdzXQiXRkjCk596xisqzv3ET+ffOOTab3A==
X-Google-Smtp-Source: ACHHUZ7PuEUATe/1giIF1EdKEXipkccdXkYVo+3JX0K5LcbIyR19TSYZhd2ZMEaZUr5444r5qjoFRdXoehdgkyjLeG4=
X-Received: by 2002:a17:907:6d25:b0:961:8fcd:53c6 with SMTP id
 sa37-20020a1709076d2500b009618fcd53c6mr2390114ejc.66.1683103980340; Wed, 03
 May 2023 01:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132406.2540811-1-yosryahmed@google.com>
 <20230428132406.2540811-3-yosryahmed@google.com> <ZFIgUfPrinUKLIVI@dhcp22.suse.cz>
In-Reply-To: <ZFIgUfPrinUKLIVI@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 3 May 2023 01:52:23 -0700
Message-ID: <CAJD7tkbdFOf_6fddRZRj8aKBTqvDqKfwMB8A=boDcK6N-14G8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: dump memory.stat during cgroup OOM for v1
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
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

On Wed, May 3, 2023 at 1:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 28-04-23 13:24:06, Yosry Ahmed wrote:
> > Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> > OOM") made sure we dump all the stats in memory.stat during a cgroup
> > OOM, but it also introduced a slight behavioral change. The code used t=
o
> > print the non-hierarchical v1 cgroup stats for the entire cgroup
> > subtree, now it only prints the v2 cgroup stats for the cgroup under
> > OOM.
> >
> > For cgroup v1 users, this introduces a few problems:
> > (a) The non-hierarchical stats of the memcg under OOM are no longer
> > shown.
> > (b) A couple of v1-only stats (e.g. pgpgin, pgpgout) are no longer
> > shown.
> > (c) We show the list of cgroup v2 stats, even in cgroup v1. This list o=
f
> > stats is not tracked with v1 in mind. While most of the stats seem to b=
e
> > working on v1, there may be some stats that are not fully or correctly
> > tracked.
> >
> > Although OOM log is not set in stone, we should not change it for no
> > reason. When upgrading the kernel version to a version including
> > commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> > OOM"), these behavioral changes are noticed in cgroup v1.
> >
> > The fix is simple. Commit c8713d0b2312 ("mm: memcontrol: dump memory.st=
at
> > during cgroup OOM") separated stats formatting from stats display for
> > v2, to reuse the stats formatting in the OOM logs. Do the same for v1.
> >
> > Move the v2 specific formatting from memory_stat_format() to
> > memcg_stat_format(), add memcg1_stat_format() for v1, and make
> > memory_stat_format() select between them based on cgroup version.
> > Since memory_stat_show() now works for both v1 & v2, drop
> > memcg_stat_show().
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks

Thanks Michal!

>
> > ---
> >  mm/memcontrol.c | 60 ++++++++++++++++++++++++++++---------------------
> >  1 file changed, 35 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5922940f92c9..2b492f8d540c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1551,7 +1551,7 @@ static inline unsigned long memcg_page_state_outp=
ut(struct mem_cgroup *memcg,
> >       return memcg_page_state(memcg, item) * memcg_page_state_unit(item=
);
> >  }
> >
> > -static void memory_stat_format(struct mem_cgroup *memcg, struct seq_bu=
f *s)
> > +static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf=
 *s)
> >  {
> >       int i;
> >
> > @@ -1604,6 +1604,17 @@ static void memory_stat_format(struct mem_cgroup=
 *memcg, struct seq_buf *s)
> >       WARN_ON_ONCE(seq_buf_has_overflowed(s));
> >  }
> >
> > +static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_bu=
f *s);
> > +
> > +static void memory_stat_format(struct mem_cgroup *memcg, struct seq_bu=
f *s)
> > +{
> > +     if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +             memcg_stat_format(memcg, s);
> > +     else
> > +             memcg1_stat_format(memcg, s);
> > +     WARN_ON_ONCE(seq_buf_has_overflowed(s));
> > +}
> > +
> >  #define K(x) ((x) << (PAGE_SHIFT-10))
> >  /**
> >   * mem_cgroup_print_oom_context: Print OOM information relevant to
> > @@ -4078,9 +4089,8 @@ static const unsigned int memcg1_events[] =3D {
> >       PGMAJFAULT,
> >  };
> >
> > -static int memcg_stat_show(struct seq_file *m, void *v)
> > +static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_bu=
f *s)
> >  {
> > -     struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> >       unsigned long memory, memsw;
> >       struct mem_cgroup *mi;
> >       unsigned int i;
> > @@ -4095,18 +4105,18 @@ static int memcg_stat_show(struct seq_file *m, =
void *v)
> >               if (memcg1_stats[i] =3D=3D MEMCG_SWAP && !do_memsw_accoun=
t())
> >                       continue;
> >               nr =3D memcg_page_state_local(memcg, memcg1_stats[i]);
> > -             seq_printf(m, "%s %lu\n", memcg1_stat_names[i],
> > +             seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
> >                          nr * memcg_page_state_unit(memcg1_stats[i]));
> >       }
> >
> >       for (i =3D 0; i < ARRAY_SIZE(memcg1_events); i++)
> > -             seq_printf(m, "%s %lu\n", vm_event_name(memcg1_events[i])=
,
> > -                        memcg_events_local(memcg, memcg1_events[i]));
> > +             seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events=
[i]),
> > +                            memcg_events_local(memcg, memcg1_events[i]=
));
> >
> >       for (i =3D 0; i < NR_LRU_LISTS; i++)
> > -             seq_printf(m, "%s %lu\n", lru_list_name(i),
> > -                        memcg_page_state_local(memcg, NR_LRU_BASE + i)=
 *
> > -                        PAGE_SIZE);
> > +             seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
> > +                            memcg_page_state_local(memcg, NR_LRU_BASE =
+ i) *
> > +                            PAGE_SIZE);
> >
> >       /* Hierarchical information */
> >       memory =3D memsw =3D PAGE_COUNTER_MAX;
> > @@ -4114,11 +4124,11 @@ static int memcg_stat_show(struct seq_file *m, =
void *v)
> >               memory =3D min(memory, READ_ONCE(mi->memory.max));
> >               memsw =3D min(memsw, READ_ONCE(mi->memsw.max));
> >       }
> > -     seq_printf(m, "hierarchical_memory_limit %llu\n",
> > -                (u64)memory * PAGE_SIZE);
> > +     seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
> > +                    (u64)memory * PAGE_SIZE);
> >       if (do_memsw_account())
> > -             seq_printf(m, "hierarchical_memsw_limit %llu\n",
> > -                        (u64)memsw * PAGE_SIZE);
> > +             seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
> > +                            (u64)memsw * PAGE_SIZE);
> >
> >       for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++) {
> >               unsigned long nr;
> > @@ -4126,19 +4136,19 @@ static int memcg_stat_show(struct seq_file *m, =
void *v)
> >               if (memcg1_stats[i] =3D=3D MEMCG_SWAP && !do_memsw_accoun=
t())
> >                       continue;
> >               nr =3D memcg_page_state(memcg, memcg1_stats[i]);
> > -             seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
> > +             seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i]=
,
> >                          (u64)nr * memcg_page_state_unit(memcg1_stats[i=
]));
> >       }
> >
> >       for (i =3D 0; i < ARRAY_SIZE(memcg1_events); i++)
> > -             seq_printf(m, "total_%s %llu\n",
> > -                        vm_event_name(memcg1_events[i]),
> > -                        (u64)memcg_events(memcg, memcg1_events[i]));
> > +             seq_buf_printf(s, "total_%s %llu\n",
> > +                            vm_event_name(memcg1_events[i]),
> > +                            (u64)memcg_events(memcg, memcg1_events[i])=
);
> >
> >       for (i =3D 0; i < NR_LRU_LISTS; i++)
> > -             seq_printf(m, "total_%s %llu\n", lru_list_name(i),
> > -                        (u64)memcg_page_state(memcg, NR_LRU_BASE + i) =
*
> > -                        PAGE_SIZE);
> > +             seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
> > +                            (u64)memcg_page_state(memcg, NR_LRU_BASE +=
 i) *
> > +                            PAGE_SIZE);
> >
> >  #ifdef CONFIG_DEBUG_VM
> >       {
> > @@ -4153,12 +4163,10 @@ static int memcg_stat_show(struct seq_file *m, =
void *v)
> >                       anon_cost +=3D mz->lruvec.anon_cost;
> >                       file_cost +=3D mz->lruvec.file_cost;
> >               }
> > -             seq_printf(m, "anon_cost %lu\n", anon_cost);
> > -             seq_printf(m, "file_cost %lu\n", file_cost);
> > +             seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
> > +             seq_buf_printf(s, "file_cost %lu\n", file_cost);
> >       }
> >  #endif
> > -
> > -     return 0;
> >  }
> >
> >  static u64 mem_cgroup_swappiness_read(struct cgroup_subsys_state *css,
> > @@ -4998,6 +5006,8 @@ static int mem_cgroup_slab_show(struct seq_file *=
m, void *p)
> >  }
> >  #endif
> >
> > +static int memory_stat_show(struct seq_file *m, void *v);
> > +
> >  static struct cftype mem_cgroup_legacy_files[] =3D {
> >       {
> >               .name =3D "usage_in_bytes",
> > @@ -5030,7 +5040,7 @@ static struct cftype mem_cgroup_legacy_files[] =
=3D {
> >       },
> >       {
> >               .name =3D "stat",
> > -             .seq_show =3D memcg_stat_show,
> > +             .seq_show =3D memory_stat_show,
> >       },
> >       {
> >               .name =3D "force_empty",
> > --
> > 2.40.1.495.gc816e09b53d-goog
>
> --
> Michal Hocko
> SUSE Labs
