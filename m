Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF9267D2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjAZRIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjAZRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:08:48 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14804C07;
        Thu, 26 Jan 2023 09:08:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id r14so1917235qvx.4;
        Thu, 26 Jan 2023 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xa2N7Ivh7dt7l8G2gaP7xy0D45O0idREEQejp58kyY=;
        b=KfXi+HE0YksbS0l42GwHifDlm23mRKMFrrSURr01IMR9ArF9XRysIljCM8DlydjnNB
         jWk451dIU3wOuikcys5ESTKA0b9trbFzqZ8ctw9/LAiHXC2ovf+bgxGnrJvyMCkVo7pm
         p+m0eAO09K8UUADuOnT3LNe1N3tV+kbNhTVU9oAEJSoTLrvrqaqQkPlUvX4L23iG6mL7
         WCwSs8869xpjn7aU7i48PXtb2vJiex7Eq8YHQuj6DpvbR+76r/ufI1zqDAiB+vkoiNGm
         /O5VpClS83TEoxvHMI13G+enmGJzGQWvBo7YAlKzljWsmHvy3SLeBldTrTv2WFPn9qbR
         ZHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xa2N7Ivh7dt7l8G2gaP7xy0D45O0idREEQejp58kyY=;
        b=YBF40unknytdJsbiVqe5KD5H9tvKb2W5srUnoEWW+isowJBQ4RNx5gnCdyIM1l+/UX
         ZA9b9x8SsHhyudGhxIyUU3fWAcK4vBymBg5Z9dP4s2kDW8BlszZY2HvuBjekocnN7fuZ
         L8IN5bNsXMETKyaL9jDmihD9wUWyTOj7PeHqpyB9HOnGGIcRfnPsjO4B+mfoDR824Fna
         ZTXEWnbGnTEh1+J+/N5Vr/DwtW7/BRTCMB1rjVu2Vw570RNcwTwYJ7cs2YtBswfNKph9
         r0vmaCqX2C2fPgr+8MNX3CDxzcbcJwUdHbJ1Di7xFenw8t7PVRGaimCskuFODO5Ezznr
         8SyQ==
X-Gm-Message-State: AFqh2kreImARwBtB6Wny1HypvQh4eFw9snZHH5D9hbxQfwrrWsyyqGEm
        vJfsnSzMfxPfdoh51H2OsoNWyVz7OXQfyK47rchqxI0cQOU=
X-Google-Smtp-Source: AMrXdXt5QJSbsB4oqgWPTVg7geEsV9QGTheG7aGVF0OlUCn9aTsqx0JJmb888T1MXJzJIEX1JUvM3Fq0Lbajb0G3lrw=
X-Received: by 2002:a05:6214:5f82:b0:534:252f:b091 with SMTP id
 ls2-20020a0562145f8200b00534252fb091mr1660515qvb.130.1674752922880; Thu, 26
 Jan 2023 09:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20230124021118.154078-1-nphamcs@gmail.com> <20230124021118.154078-2-nphamcs@gmail.com>
 <CAOUHufYz+FmxQ8yoocbV8LP05HGU=cRoqJE1-bQa0KyLofJYhQ@mail.gmail.com>
In-Reply-To: <CAOUHufYz+FmxQ8yoocbV8LP05HGU=cRoqJE1-bQa0KyLofJYhQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 26 Jan 2023 09:08:32 -0800
Message-ID: <CAKEwX=PWs2iPG4zgLAw2M=PVsewAf35hsY2qu7K_pHkvHR=iTQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] workingset: refactor LRU refault to expose refault
 recency check
To:     Yu Zhao <yuzhao@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 1:13 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jan 23, 2023 at 7:11 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > In preparation for computing recently evicted pages in cachestat,
> > refactor workingset_refault and lru_gen_refault to expose a helper
> > function that would test if an evicted page is recently evicted.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/swap.h |   1 +
> >  mm/workingset.c      | 142 +++++++++++++++++++++++++++++--------------
> >  2 files changed, 97 insertions(+), 46 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index a18cf4b7c724..dae6f6f955eb 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
> >  }
> >
> >  /* linux/mm/workingset.c */
> > +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
> >  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
> >  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
> >  void workingset_refault(struct folio *folio, void *shadow);
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 79585d55c45d..2f2d94867366 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> >         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> >  }
> >
> > +/*
> > + * Test if the folio is recently evicted.
> > + *
> > + * As a side effect, also populates the references with
> > + * values unpacked from the shadow of the evicted folio.
> > + */
> > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > +               struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > +{
> > +       struct mem_cgroup *eviction_memcg;
> > +       struct lruvec *lruvec;
> > +       struct lru_gen_struct *lrugen;
> > +       unsigned long min_seq;
> > +
> > +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> > +
> > +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > +       lrugen = &lruvec->lrugen;
> > +
> > +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> > +       return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
> > +}
> > +
> >  static void lru_gen_refault(struct folio *folio, void *shadow)
> >  {
> >         int hist, tier, refs;
> > @@ -258,23 +282,22 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
> >         int type = folio_is_file_lru(folio);
> >         int delta = folio_nr_pages(folio);
> >
> > -       unpack_shadow(shadow, &memcg_id, &pgdat, &token, &workingset);
> > -
> > -       if (pgdat != folio_pgdat(folio))
> > -               return;
> > -
> >         rcu_read_lock();
> >
> > +       if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
> > +                       &workingset))
> > +               goto unlock;
> > +
> >         memcg = folio_memcg_rcu(folio);
> >         if (memcg_id != mem_cgroup_id(memcg))
> >                 goto unlock;
> >
> > +       if (pgdat != folio_pgdat(folio))
> > +               return;
> > +
> >         lruvec = mem_cgroup_lruvec(memcg, pgdat);
> >         lrugen = &lruvec->lrugen;
> > -
> >         min_seq = READ_ONCE(lrugen->min_seq[type]);
> > -       if ((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)))
> > -               goto unlock;
> >
> >         hist = lru_hist_from_seq(min_seq);
> >         /* see the comment in folio_lru_refs() */
> > @@ -306,6 +329,12 @@ static void *lru_gen_eviction(struct folio *folio)
> >         return NULL;
> >  }
> >
> > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > +               struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > +{
> > +       return false;
> > +}
> > +
> >  static void lru_gen_refault(struct folio *folio, void *shadow)
> >  {
> >  }
> > @@ -373,40 +402,31 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
> >                                 folio_test_workingset(folio));
> >  }
> >
> > -/**
> > - * workingset_refault - Evaluate the refault of a previously evicted folio.
> > - * @folio: The freshly allocated replacement folio.
> > - * @shadow: Shadow entry of the evicted folio.
> > +/*
> > + * Test if the folio is recently evicted by checking if
> > + * refault distance of shadow exceeds workingset size.
> >   *
> > - * Calculates and evaluates the refault distance of the previously
> > - * evicted folio in the context of the node and the memcg whose memory
> > - * pressure caused the eviction.
> > + * As a side effect, populate workingset with the value
> > + * unpacked from shadow.
> >   */
> > -void workingset_refault(struct folio *folio, void *shadow)
> > +bool workingset_test_recent(void *shadow, bool file, bool *workingset)
> >  {
> > -       bool file = folio_is_file_lru(folio);
> >         struct mem_cgroup *eviction_memcg;
> >         struct lruvec *eviction_lruvec;
> >         unsigned long refault_distance;
> >         unsigned long workingset_size;
> > -       struct pglist_data *pgdat;
> > -       struct mem_cgroup *memcg;
> > -       unsigned long eviction;
> > -       struct lruvec *lruvec;
> >         unsigned long refault;
> > -       bool workingset;
> >         int memcgid;
> > -       long nr;
> > +       struct pglist_data *pgdat;
> > +       unsigned long eviction;
> >
> > -       if (lru_gen_enabled()) {
> > -               lru_gen_refault(folio, shadow);
> > -               return;
> > -       }
> > +       if (lru_gen_enabled())
> > +               lru_gen_test_recent(shadow, file, &memcgid, &pgdat, &eviction,
> > +                       workingset);
>
> Missing "return", which was correctly handled in your v2, btw.

Oops copy-paste hazard. I'll fix this...
