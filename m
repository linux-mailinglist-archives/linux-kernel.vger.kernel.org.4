Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D215B3CB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIIQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIIQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:11:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C3D5733
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:11:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-324ec5a9e97so24547727b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=H8x/XM6uf9GNJ3IYrM179zXxz1ytCDaEsM8slNACmxA=;
        b=bm1FOIwt0xPcS44lKFw20V/2FDGaluKQMr5RC/lv3kNt2CPd2qLKAgKO08lxAtII6u
         PqklGnQVjl04fCksXY7P6fDFkNnDl8WYpxKvWT4cYx3ZkcilSVu+h2Aa6BrXe55muS1Q
         agwNdalHUuz0PeBqka58ITIOXvnpT9SNeecbgghP1pdGggGAydoTvqHCpmNM9m0z/Ypb
         fWpqtc3wWWhY39E/EicXhVnsQm904qYgi9g1ZHZrJV15Rdnfrn7Ug3poT5uJ1TyVxIrs
         O9pd33EAGvLIIFPhsJ7pXSeH1VXZczvL3gB1yaSelr3tpJ7jNqnRpd0+Oyvi9CJLfpKx
         kbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H8x/XM6uf9GNJ3IYrM179zXxz1ytCDaEsM8slNACmxA=;
        b=em42q7SkgRseuDKGfnZlLs1rUtSXmpJhJht4IcBoNFdUZ6ae4muvKFOjt4V2O6dOQ1
         GKscI+9Fk/jlNDHPGZQ3oztTWiolSptvZuqev+ViuVYAtx90rW1qOuuUTsXQ5ZjevU1V
         lAbDhY1Xu4LFMs6c1sgpMcyb4tnu5LzRc33z/IZYuaYchfUkMpNwk7ybAPgkmAcGg93j
         isBdK/j1bepSq5TGsWvu8Jp7vV/55EuD1bynK+1yoMQB1aBbBN4szJWelVJDKMxa6Fy6
         RyTucCmO3TUnz3//v67nTIY8By2CqI8MDXF2ygmw3LYjJq9pMjbKoI+jTxkM9Uvavp6R
         Hgfg==
X-Gm-Message-State: ACgBeo16RnVOJP5owmX80pbUISfSNmVJ9O5KxlPgHJ5KEfandLoMIRhz
        H6l81CDChPlKNd7WwNFXPKtVwnl28tC04cZlN90JMA==
X-Google-Smtp-Source: AA6agR5l3NZBiyBjZVBHRaW8gCnmEWnPaAr7lbOsOW2FwXMOgi2wrQrtA9QsGncMTjIGt3R0HYfTWoumi/nvScrttCI=
X-Received: by 2002:a0d:f904:0:b0:345:4639:8253 with SMTP id
 j4-20020a0df904000000b0034546398253mr12696848ywf.438.1662739873041; Fri, 09
 Sep 2022 09:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-21-surenb@google.com>
 <54df2224-feca-52ed-567b-a82bb9d711da@linux.ibm.com>
In-Reply-To: <54df2224-feca-52ed-567b-a82bb9d711da@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Sep 2022 09:11:02 -0700
Message-ID: <CAJuCfpGRN244-Z3v6+sj7zJ9NGftA8ejq7FpnfyWWyGqJgvOPg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 20/28] mm: introduce per-VMA lock statistics
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
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

On Fri, Sep 9, 2022 at 7:29 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:35, Suren Baghdasaryan a =C3=A9crit :
> > Add a new CONFIG_PER_VMA_LOCK_STATS config option to dump extra
> > statistics about handling page fault under VMA lock.
> >
>
> Why not making this a default when per VMA lock are enabled?

Good idea. If no objections I'll make that change.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/vm_event_item.h | 6 ++++++
> >  include/linux/vmstat.h        | 6 ++++++
> >  mm/Kconfig.debug              | 8 ++++++++
> >  mm/vmstat.c                   | 6 ++++++
> >  4 files changed, 26 insertions(+)
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> > index f3fc36cd2276..a325783ed05d 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -150,6 +150,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWP=
OUT,
> >  #ifdef CONFIG_X86
> >               DIRECT_MAP_LEVEL2_SPLIT,
> >               DIRECT_MAP_LEVEL3_SPLIT,
> > +#endif
> > +#ifdef CONFIG_PER_VMA_LOCK_STATS
> > +             VMA_LOCK_SUCCESS,
> > +             VMA_LOCK_ABORT,
> > +             VMA_LOCK_RETRY,
> > +             VMA_LOCK_MISS,
> >  #endif
> >               NR_VM_EVENT_ITEMS
> >  };
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index bfe38869498d..0c2611899cfc 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -131,6 +131,12 @@ static inline void vm_events_fold_cpu(int cpu)
> >  #define count_vm_vmacache_event(x) do {} while (0)
> >  #endif
> >
> > +#ifdef CONFIG_PER_VMA_LOCK_STATS
> > +#define count_vm_vma_lock_event(x) count_vm_event(x)
> > +#else
> > +#define count_vm_vma_lock_event(x) do {} while (0)
> > +#endif
> > +
> >  #define __count_zid_vm_events(item, zid, delta) \
> >       __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
> >
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index ce8dded36de9..075642763a03 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -207,3 +207,11 @@ config PTDUMP_DEBUGFS
> >         kernel.
> >
> >         If in doubt, say N.
> > +
> > +
> > +config PER_VMA_LOCK_STATS
> > +     bool "Statistics for per-vma locks"
> > +     depends on PER_VMA_LOCK
> > +     help
> > +       Statistics for per-vma locks.
> > +       If in doubt, say N.
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 90af9a8572f5..3f3804c846a6 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1411,6 +1411,12 @@ const char * const vmstat_text[] =3D {
> >       "direct_map_level2_splits",
> >       "direct_map_level3_splits",
> >  #endif
> > +#ifdef CONFIG_PER_VMA_LOCK_STATS
> > +     "vma_lock_success",
> > +     "vma_lock_abort",
> > +     "vma_lock_retry",
> > +     "vma_lock_miss",
> > +#endif
> >  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
> >  };
> >  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMC=
G */
>
