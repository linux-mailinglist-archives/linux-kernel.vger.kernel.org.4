Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0948E60D4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiJYTkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiJYTka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:40:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40360CA7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:40:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g16so7464312pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHrI51VyLmEbdkMQPFyPFqHTbu3szjBEsqryLz11l/Q=;
        b=KI6W4uH4hjHvEV9PtWI7rfTLnLrATRV5KtpQAaVnspwMWnoOLD/v7F3kjtsxHAqer4
         hcg7E9X24iKmosbb1AxXvtVNpCn/x9djDQOSgSwSuKvNIPLcU+XqH7yRqwb+spJX4LEl
         h8fmqi8uIZLeugiji3Dkf3Mmg/u91DdfKHKhPSMcvPqxrGbDlqGu/8hWiit8oAIg5V7G
         QhptPcoqeT1Yk49vIiJiT2FoWoQ3mI4TC6QE2hh6A1MSLpOAtarxYbwWaARenBtVCB7A
         Q2a2v83ABsAMuMCWmFQBjmGPi6tE73V0xJFTqAJCC59QSBJjA3Gal0nFSLI8csDK3qGg
         779g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHrI51VyLmEbdkMQPFyPFqHTbu3szjBEsqryLz11l/Q=;
        b=LrVCHYwLaztVRDPRBnJkTFfbkt4B58Jg40mWJ/7cMnvrCYC5DZ6Di2we4/+BtZJKI3
         QGWITFakrDEyxCLhK36swQGZu1DHtQ1gHb4oVAfLz944HB+9VFZYfcrY9KscM77xN21R
         lKSA7W48XMIHzc1zyHj0++L4dfsKCVgkN7SxaRD+ZVrvq0u8s+h/WfwciyfZc/36NjaG
         r+HcQDqiuZJ284NrhSDJLm8o5E2utq12grLuIeSFk2+/WrIp/6j+qFuev2JHDEwmlbDx
         vajQremTDLANIdJ3BcdXvkOk8mN0k6CoHj2UjqXI+ckKjjFDnP5f95WgCX0jNXkU2O23
         kYqw==
X-Gm-Message-State: ACrzQf0N7ZKlGvFoy+lFXOsz+YU1uLJ5sVHyaZ+yNni0ZnH8166CGYxa
        DNw1BkwGE97nciUtifVhdpTUmyJt3SO6tCHbD5c9m8kU
X-Google-Smtp-Source: AMsMyM4W6iPBtifLFZppSjzLfqp4yMDTHrdLV1eKapE0x2M1LEv7DbpdxN0ssd9LBoOOW2mnisGdkIKvVPfO4i55u/E=
X-Received: by 2002:a63:8a42:0:b0:460:58ec:cc66 with SMTP id
 y63-20020a638a42000000b0046058eccc66mr34066355pgd.195.1666726828776; Tue, 25
 Oct 2022 12:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221025170519.314511-1-hannes@cmpxchg.org>
In-Reply-To: <20221025170519.314511-1-hannes@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 Oct 2022 12:40:15 -0700
Message-ID: <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Direct reclaim stats are useful for identifying a potential source for
> application latency, as well as spotting issues with kswapd. However,
> khugepaged currently distorts the picture: as a kernel thread it
> doesn't impose allocation latencies on userspace, and it explicitly
> opts out of kswapd reclaim. Its activity showing up in the direct
> reclaim stats is misleading. Counting it as kswapd reclaim could also
> cause confusion when trying to understand actual kswapd behavior.
>
> Break out khugepaged from the direct reclaim counters into new
> pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
>
> Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
>
> pgsteal_kswapd 1342185
> pgsteal_direct 0
> pgsteal_khugepaged 3623
> pgscan_kswapd 1345025
> pgscan_direct 0
> pgscan_khugepaged 3623

There are other kernel threads or works may allocate memory then
trigger memory reclaim, there may be similar problems for them and
someone may try to add a new stat. So how's about we make the stats
more general, for example, call it "pg{steal|scan}_kthread"?

>
> Reported-by: Eric Bergen <ebergen@meta.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 +++++
>  include/linux/khugepaged.h              |  6 +++++
>  include/linux/vm_event_item.h           |  3 +++
>  mm/khugepaged.c                         |  5 +++++
>  mm/memcontrol.c                         |  8 +++++--
>  mm/vmscan.c                             | 30 ++++++++++++++++++-------
>  mm/vmstat.c                             |  3 +++
>  7 files changed, 51 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index dc254a3cb956..74cec76be9f2 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1488,12 +1488,18 @@ PAGE_SIZE multiple when read back.
>           pgscan_direct (npn)
>                 Amount of scanned pages directly  (in an inactive LRU list)
>
> +         pgscan_khugepaged (npn)
> +               Amount of scanned pages by khugepaged  (in an inactive LRU list)
> +
>           pgsteal_kswapd (npn)
>                 Amount of reclaimed pages by kswapd
>
>           pgsteal_direct (npn)
>                 Amount of reclaimed pages directly
>
> +         pgsteal_khugepaged (npn)
> +               Amount of reclaimed pages by khugepaged
> +
>           pgfault (npn)
>                 Total number of page faults incurred
>
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 70162d707caf..f68865e19b0b 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -15,6 +15,7 @@ extern void __khugepaged_exit(struct mm_struct *mm);
>  extern void khugepaged_enter_vma(struct vm_area_struct *vma,
>                                  unsigned long vm_flags);
>  extern void khugepaged_min_free_kbytes_update(void);
> +extern bool current_is_khugepaged(void);
>  #ifdef CONFIG_SHMEM
>  extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>                                    bool install_pmd);
> @@ -57,6 +58,11 @@ static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
>  static inline void khugepaged_min_free_kbytes_update(void)
>  {
>  }
> +
> +static inline bool current_is_khugepaged(void)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  #endif /* _LINUX_KHUGEPAGED_H */
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 3518dba1e02f..7f5d1caf5890 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -40,10 +40,13 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>                 PGREUSE,
>                 PGSTEAL_KSWAPD,
>                 PGSTEAL_DIRECT,
> +               PGSTEAL_KHUGEPAGED,
>                 PGDEMOTE_KSWAPD,
>                 PGDEMOTE_DIRECT,
> +               PGDEMOTE_KHUGEPAGED,
>                 PGSCAN_KSWAPD,
>                 PGSCAN_DIRECT,
> +               PGSCAN_KHUGEPAGED,
>                 PGSCAN_DIRECT_THROTTLE,
>                 PGSCAN_ANON,
>                 PGSCAN_FILE,
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4734315f7940..36318ebbf50d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2528,6 +2528,11 @@ void khugepaged_min_free_kbytes_update(void)
>         mutex_unlock(&khugepaged_mutex);
>  }
>
> +bool current_is_khugepaged(void)
> +{
> +       return kthread_func(current) == khugepaged;
> +}
> +
>  static int madvise_collapse_errno(enum scan_result r)
>  {
>         /*
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2d8549ae1b30..a17a5cfa6a55 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -661,8 +661,10 @@ static const unsigned int memcg_vm_event_stat[] = {
>         PGPGOUT,
>         PGSCAN_KSWAPD,
>         PGSCAN_DIRECT,
> +       PGSCAN_KHUGEPAGED,
>         PGSTEAL_KSWAPD,
>         PGSTEAL_DIRECT,
> +       PGSTEAL_KHUGEPAGED,
>         PGFAULT,
>         PGMAJFAULT,
>         PGREFILL,
> @@ -1574,10 +1576,12 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
>         /* Accumulated memory events */
>         seq_buf_printf(&s, "pgscan %lu\n",
>                        memcg_events(memcg, PGSCAN_KSWAPD) +
> -                      memcg_events(memcg, PGSCAN_DIRECT));
> +                      memcg_events(memcg, PGSCAN_DIRECT) +
> +                      memcg_events(memcg, PGSCAN_KHUGEPAGED));
>         seq_buf_printf(&s, "pgsteal %lu\n",
>                        memcg_events(memcg, PGSTEAL_KSWAPD) +
> -                      memcg_events(memcg, PGSTEAL_DIRECT));
> +                      memcg_events(memcg, PGSTEAL_DIRECT) +
> +                      memcg_events(memcg, PGSTEAL_KHUGEPAGED));
>
>         for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
>                 if (memcg_vm_event_stat[i] == PGPGIN ||
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04d8b88e5216..8ceae125bbf7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -54,6 +54,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/ctype.h>
>  #include <linux/debugfs.h>
> +#include <linux/khugepaged.h>
>
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -1047,6 +1048,22 @@ void drop_slab(void)
>                 drop_slab_node(nid);
>  }
>
> +static int reclaimer_offset(void)
> +{
> +       BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD != 1);
> +       BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD != 2);
> +       BUILD_BUG_ON(PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD != 1);
> +       BUILD_BUG_ON(PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD != 2);
> +       BUILD_BUG_ON(PGSCAN_DIRECT - PGSCAN_KSWAPD != 1);
> +       BUILD_BUG_ON(PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD != 2);
> +
> +       if (current_is_kswapd())
> +               return 0;
> +       if (current_is_khugepaged())
> +               return 2;
> +       return 1;
> +}
> +
>  static inline int is_page_cache_freeable(struct folio *folio)
>  {
>         /*
> @@ -1599,10 +1616,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>                       (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>                       &nr_succeeded);
>
> -       if (current_is_kswapd())
> -               __count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
> -       else
> -               __count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> +       __count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
>
>         return nr_succeeded;
>  }
> @@ -2475,7 +2489,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>                                      &nr_scanned, sc, lru);
>
>         __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
> -       item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> +       item = PGSCAN_KSWAPD + reclaimer_offset();
>         if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_scanned);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> @@ -2492,7 +2506,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>         move_folios_to_lru(lruvec, &folio_list);
>
>         __mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> -       item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> +       item = PGSTEAL_KSWAPD + reclaimer_offset();
>         if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, nr_reclaimed);
>         __count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> @@ -4857,7 +4871,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>                         break;
>         }
>
> -       item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> +       item = PGSCAN_KSWAPD + reclaimer_offset();
>         if (!cgroup_reclaim(sc)) {
>                 __count_vm_events(item, isolated);
>                 __count_vm_events(PGREFILL, sorted);
> @@ -5015,7 +5029,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>         if (walk && walk->batched)
>                 reset_batch_size(lruvec, walk);
>
> -       item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> +       item = PGSTEAL_KSWAPD + reclaimer_offset();
>         if (!cgroup_reclaim(sc))
>                 __count_vm_events(item, reclaimed);
>         __count_memcg_events(memcg, item, reclaimed);
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b2371d745e00..1ea6a5ce1c41 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1271,10 +1271,13 @@ const char * const vmstat_text[] = {
>         "pgreuse",
>         "pgsteal_kswapd",
>         "pgsteal_direct",
> +       "pgsteal_khugepaged",
>         "pgdemote_kswapd",
>         "pgdemote_direct",
> +       "pgdemote_khugepaged",
>         "pgscan_kswapd",
>         "pgscan_direct",
> +       "pgscan_khugepaged",
>         "pgscan_direct_throttle",
>         "pgscan_anon",
>         "pgscan_file",
> --
> 2.38.1
>
>
