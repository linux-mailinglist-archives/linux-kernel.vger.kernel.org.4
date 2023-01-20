Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC54675B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjATRaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjATRaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:30:15 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D43DBE4;
        Fri, 20 Jan 2023 09:29:58 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id e19so1050628qvw.13;
        Fri, 20 Jan 2023 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jDf3LZYSGD10CXbLn9VSOx3el1JLvQsxMhmvdG1KmzM=;
        b=NHHYwI5DI1KfNqdGYj10G+aJzDOMKGHgxZ86Lp7KvwyzMt9nT9rT0FHXzQLDoo5rOF
         apnQybKHZGsBPM0PVQ3yEOcrjEF3ypSwyrz9Ao/Ed5mRArCsbQPr/mjuCtYird3JCuCS
         1Dlq3bZTFf3sm4naj3wEjav+dMJf5bsSwRzHSutmN5Nzs8MqbFok2cS04ot2ue7h1R0k
         d8HqZ3n6IrGxHgPwXt4zIn4G8KRmAdwYhcI5tbUy9W4B6vjQ/XpJLEmQKG+LC9tiBrBR
         Z4chUen79vt4fRAO0uT4zK5oyV3FnK9uLyYZ+tzCx3n1cX+IopLs0fmBBFg2HBfwX9kh
         bcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDf3LZYSGD10CXbLn9VSOx3el1JLvQsxMhmvdG1KmzM=;
        b=jeSZm7aaNXKH34XOvri4xMMpkKZRAQBDfEG3CYK4qRV6Xq1OkPH6xmfEKZmfr+Jzjx
         jBUCoOY5y57r4l6HQwLM/aF59OuZXHPLpo2JvMELOSVP8BTbTv8Vl57mZIqJo+IYg80x
         M56bLFN1fwr9sOvdKmIK+CEpQyMORrxZyngDF9DMmYHvAO05XHpIUO47+E6XH8KL8KWd
         qTJ3mDL6abEukJepYkR1PpAJF+gZ/UNdXnjNvPFcI6HyaJCwrm5fTNI6/mhOpq9e/oHx
         h+KgeGHCih+VCV7HUg9cHkUBD/WBsnCmgZ48xNVnqud3f7Q/E/S1jvNiEBRjYZoadjdd
         VXlQ==
X-Gm-Message-State: AFqh2krgQ6iSFltn3NeVT4JuL6eQ4heH7+3lQRutLVkk+nczLDsAARb+
        pzW88SpABC1iASKBOQUEQZD1yRhsXqUuujanu4aUidQcceM/ZA==
X-Google-Smtp-Source: AMrXdXs9I7hLGgERQ16Om2J3BW2CeFc8fhwM0XSdIRTwGoxG/U59jw1HSZUzuOao5T9AKXE55MYvOCC+ol2cDQRXQ9k=
X-Received: by 2002:ad4:4f25:0:b0:535:664b:7713 with SMTP id
 fc5-20020ad44f25000000b00535664b7713mr88354qvb.8.1674235797174; Fri, 20 Jan
 2023 09:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20230117195959.29768-1-nphamcs@gmail.com> <20230117195959.29768-2-nphamcs@gmail.com>
 <Y8qmaqpAFko+gI3h@bfoster>
In-Reply-To: <Y8qmaqpAFko+gI3h@bfoster>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 20 Jan 2023 09:29:46 -0800
Message-ID: <CAKEwX=OS-ra+hVQ=ZF1ZcUdKPEjh3+KJJNC6Cmwkudk8FY9TiQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] workingset: refactor LRU refault to expose refault
 recency check
To:     Brian Foster <bfoster@redhat.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-api@vger.kernel.org, kernel-team@meta.com
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

 On Fri, Jan 20, 2023 at 6:33 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Tue, Jan 17, 2023 at 11:59:57AM -0800, Nhat Pham wrote:
> > In preparation for computing recently evicted pages in cachestat,
> > refactor workingset_refault and lru_gen_refault to expose a helper
> > function that would test if an evicted page is recently evicted.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
>
> Hi Nhat,
>
> I'm not terribly familiar with the workingset management code, but a few
> thoughts now that I've stared at it a bit...
>
> >  include/linux/swap.h |   1 +
> >  mm/workingset.c      | 129 ++++++++++++++++++++++++++++++-------------
> >  2 files changed, 92 insertions(+), 38 deletions(-)
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
> > index 79585d55c45d..006482c4e0bd 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -244,6 +244,33 @@ static void *lru_gen_eviction(struct folio *folio)
> >       return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> >  }
> >
> > +/*
> > + * Test if the folio is recently evicted.
> > + *
> > + * As a side effect, also populates the references with
> > + * values unpacked from the shadow of the evicted folio.
> > + */
> > +static bool lru_gen_test_recent(void *shadow, bool file, bool *workingset)
> > +{
> > +     struct mem_cgroup *eviction_memcg;
> > +     struct lruvec *lruvec;
> > +     struct lru_gen_struct *lrugen;
> > +     unsigned long min_seq;
> > +
>
> Extra whitespace looks a bit funny here.
>
> > +     int memcgid;
> > +     struct pglist_data *pgdat;
> > +     unsigned long token;
> > +
> > +     unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
> > +     eviction_memcg = mem_cgroup_from_id(memcgid);
> > +
> > +     lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> > +     lrugen = &lruvec->lrugen;
> > +
> > +     min_seq = READ_ONCE(lrugen->min_seq[file]);
> > +     return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
>
> I think this might be more readable without the double negative.

Hmm indeed. I was just making sure that I did not mess up Yu's
original logic here (by just wrapping it in a parentheses and
negate the whole thing), but if I understand it correctly it's just
an equality check. I'll fix it in the next version to make it cleaner.

>
> Also it looks like this logic is pulled from lru_gen_refault(). Any
> reason the caller isn't refactored to use this helper, similar to how
> workingset_refault() is modified? It seems like a potential landmine to
> duplicate the logic here for cachestat purposes and somewhere else for
> actual workingset management.

In V2, it is actually refactored analogously as well - but we had a discussion
about it here:

https://lkml.org/lkml/2022/12/5/1321

>
> > +}
> > +
> >  static void lru_gen_refault(struct folio *folio, void *shadow)
> >  {
> >       int hist, tier, refs;
> > @@ -306,6 +333,11 @@ static void *lru_gen_eviction(struct folio *folio)
> >       return NULL;
> >  }
> >
> > +static bool lru_gen_test_recent(void *shadow, bool file, bool *workingset)
> > +{
> > +     return true;
> > +}
>
> I guess this is a no-op for !MGLRU but given the context (i.e. special
> treatment for "recent" refaults), perhaps false is a more sane default?

Hmm, fair point. Let me fix that in the next version.

>
> > +
> >  static void lru_gen_refault(struct folio *folio, void *shadow)
> >  {
> >  }
> > @@ -373,40 +405,31 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
> >                               folio_test_workingset(folio));
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
> > -     bool file = folio_is_file_lru(folio);
> >       struct mem_cgroup *eviction_memcg;
> >       struct lruvec *eviction_lruvec;
> >       unsigned long refault_distance;
> >       unsigned long workingset_size;
> > -     struct pglist_data *pgdat;
> > -     struct mem_cgroup *memcg;
> > -     unsigned long eviction;
> > -     struct lruvec *lruvec;
> >       unsigned long refault;
> > -     bool workingset;
> > +
> >       int memcgid;
> > -     long nr;
> > +     struct pglist_data *pgdat;
> > +     unsigned long eviction;
> >
> > -     if (lru_gen_enabled()) {
> > -             lru_gen_refault(folio, shadow);
> > -             return;
> > -     }
> > +     if (lru_gen_enabled())
> > +             return lru_gen_test_recent(shadow, file, workingset);
>
> Hmm.. so this function is only called by workingset_refault() when
> lru_gen_enabled() == false, otherwise it calls into lru_gen_refault(),
> which as noted above duplicates some of the recency logic.
>
> I'm assuming this lru_gen_test_recent() call is so filemap_cachestat()
> can just call workingset_test_recent(). That seems reasonable, but makes
> me wonder...

You're right. It's a bit clunky...

>
> >
> > -     unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
> > +     unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
> >       eviction <<= bucket_order;
> >
> > -     rcu_read_lock();
> >       /*
> >        * Look up the memcg associated with the stored ID. It might
> >        * have been deleted since the folio's eviction.
> > @@ -425,7 +448,8 @@ void workingset_refault(struct folio *folio, void *shadow)
> >        */
> >       eviction_memcg = mem_cgroup_from_id(memcgid);
> >       if (!mem_cgroup_disabled() && !eviction_memcg)
> > -             goto out;
> > +             return false;
> > +
> >       eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> >       refault = atomic_long_read(&eviction_lruvec->nonresident_age);
> >
> > @@ -447,21 +471,6 @@ void workingset_refault(struct folio *folio, void *shadow)
> >        */
> >       refault_distance = (refault - eviction) & EVICTION_MASK;
> >
> > -     /*
> > -      * The activation decision for this folio is made at the level
> > -      * where the eviction occurred, as that is where the LRU order
> > -      * during folio reclaim is being determined.
> > -      *
> > -      * However, the cgroup that will own the folio is the one that
> > -      * is actually experiencing the refault event.
> > -      */
> > -     nr = folio_nr_pages(folio);
> > -     memcg = folio_memcg(folio);
> > -     pgdat = folio_pgdat(folio);
> > -     lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > -
> > -     mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
> > -
> >       mem_cgroup_flush_stats_delayed();
> >       /*
> >        * Compare the distance to the existing workingset size. We
> > @@ -483,8 +492,51 @@ void workingset_refault(struct folio *folio, void *shadow)
> >                                                    NR_INACTIVE_ANON);
> >               }
> >       }
> > -     if (refault_distance > workingset_size)
> > +
> > +     return refault_distance <= workingset_size;
> > +}
> > +
> > +/**
> > + * workingset_refault - Evaluate the refault of a previously evicted folio.
> > + * @folio: The freshly allocated replacement folio.
> > + * @shadow: Shadow entry of the evicted folio.
> > + *
> > + * Calculates and evaluates the refault distance of the previously
> > + * evicted folio in the context of the node and the memcg whose memory
> > + * pressure caused the eviction.
> > + */
> > +void workingset_refault(struct folio *folio, void *shadow)
> > +{
> > +     bool file = folio_is_file_lru(folio);
> > +     struct pglist_data *pgdat;
> > +     struct mem_cgroup *memcg;
> > +     struct lruvec *lruvec;
> > +     bool workingset;
> > +     long nr;
> > +
> > +     if (lru_gen_enabled()) {
> > +             lru_gen_refault(folio, shadow);
> > +             return;
> > +     }
>
> ... if perhaps this should call workingset_test_recent() a bit earlier,
> since it also covers the lru_gen_*() case..? That may or may not be
> cleaner. It _seems like_ it might produce a bit more consistent logic,
> but just a thought and I could easily be missing details.

Hmm you mean before/in place of the lru_gen_refault call?
workingset_test_recent only covers lru_gen_test_recent,
not the rest of the logic of lru_gen_refault I believe.


>
> > +
> > +     rcu_read_lock();
> > +
> > +     nr = folio_nr_pages(folio);
> > +     memcg = folio_memcg(folio);
> > +     pgdat = folio_pgdat(folio);
> > +     lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > +
> > +     if (!workingset_test_recent(shadow, file, &workingset)) {
> > +             /*
> > +              * The activation decision for this folio is made at the level
> > +              * where the eviction occurred, as that is where the LRU order
> > +              * during folio reclaim is being determined.
> > +              *
> > +              * However, the cgroup that will own the folio is the one that
> > +              * is actually experiencing the refault event.
> > +              */
>
> IIUC, this comment is explaining the difference between using the
> eviction lru (based on the shadow entry) to calculate recency vs. the
> lru for the current folio to process the refault. If so, perhaps it
> should go right above the workingset_test_recent() call? (Then the if
> braces could go away as well..).

You're right! I think it should go above `nr = folio_nr_pages(folio);` call.

>
> >               goto out;
> > +     }
> >
> >       folio_set_active(folio);
> >       workingset_age_nonresident(lruvec, nr);
> > @@ -498,6 +550,7 @@ void workingset_refault(struct folio *folio, void *shadow)
> >               mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
> >       }
> >  out:
> > +     mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
>
> Why not just leave this up earlier in the function (i.e. before the
> recency check) as it was originally?

Let me double check, but I think this is a relic from the old (and incorrect)
version of workingset code.

Originally, mod_lruvec_state uses the lruvec computed from a variable
(pgdat) that was unpacked from the shadow. So this mod_lruvec_state
has to go after the unpack_shadow call (which has been moved inside
of workingset_test_recent).

This is actually wrong - we actually want the pgdat from the folio. It
has been fixed in a separate patch:

https://lore.kernel.org/all/20230104222944.2380117-1-nphamcs@gmail.com/T/#u

But I didn't update it here. Let me stare at it a bit more to make sure,
and then fix it in the next version. It should not change the behavior,
but it should be cleaner.

>
> Brian
>
> >       rcu_read_unlock();
> >  }
> >
> > --
> > 2.30.2
> >
>
