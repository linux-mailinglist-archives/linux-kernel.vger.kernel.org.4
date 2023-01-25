Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5A67BDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbjAYVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjAYVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:13:46 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8D7A9B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:13:37 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d66so21072663vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1nnGEuKKkDGSq1WmxosoaK0D1FohFPeB383P/IXUAg=;
        b=CcWiG7BHedadfBKBk+HAhiO4vDglOmcdQXzynTfuKA6qPgTYgRfEzB+kFHcgrMLZJP
         J5VIwbS5mADkLR0BjZW6WDKfB6ljKeObUJ/i8bbl5yRYRSCGsUZrErumXTHHnTCImwQ3
         LT1qV/A3G2uA1lD5P2tnY6sejYKH4ivzstIxeCNXVPCORrZPpuziYCqvZ8y/wBcyIFjr
         FMev4qyhkip6P4DtwoqrigQEqBZ+PECcR6jhNVzYBe4DiIfyBI1e0JfD72pvwSKZIZTV
         IMEQU+5zriiPIeoUo2A3XiRbV6vNeQCa7JPWiu70dvBubF9oej5dobizU386rnv8o7CG
         TzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1nnGEuKKkDGSq1WmxosoaK0D1FohFPeB383P/IXUAg=;
        b=kaeKtfF8h0sg25FdKJutv9hB28teG6QnxwIH+Qq0AU8Cz8urZ0h2AdE+a84Wm7K/Vr
         0s7Co0rZkulIdABIXzy2pHHVrMu3NO5S6Fi7zJMhM35eKG4ZNBei2lFMA2Qjq07IrN17
         mGS57PB1JbRMIvPn23nfdwyLkYxpQ2Fq4JwpcZBKS4MnKOicjl3FsYOetiwnNaqZp+Ip
         pcsPB7Ts72vm5DKTw8eI+cQbIXFQpMgz1TZ5Nonh0OAx43hl5SiXLdPbbhc53kLGKSvl
         VYuoldIMRMrE1p9Frfxo5ijFLcWH1lhiPw8X8n1LyJDdUItfdD8RuZQaAiPXGtMAyQ+0
         gO6w==
X-Gm-Message-State: AFqh2kqmk81PHw4uuE+UU7fI9tbkXVp9x11VrnDHcR2yTC9AF6TFj0Gc
        jBor1ExiRWi5/0FxVUeJ/DiE6lY4NzKf18o2QK++VA==
X-Google-Smtp-Source: AMrXdXt6YoKcTFxrHffLK6kUMgFVjJX89HAI9O5bzW7f5KR45XY2fbmgFm0W1W4KWBZbSO1iEqG3pUI+WItBVOKIKaA=
X-Received: by 2002:a67:f650:0:b0:3d3:db6b:e761 with SMTP id
 u16-20020a67f650000000b003d3db6be761mr4775930vso.46.1674681216795; Wed, 25
 Jan 2023 13:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20230124021118.154078-1-nphamcs@gmail.com> <20230124021118.154078-2-nphamcs@gmail.com>
In-Reply-To: <20230124021118.154078-2-nphamcs@gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 25 Jan 2023 14:13:00 -0700
Message-ID: <CAOUHufYz+FmxQ8yoocbV8LP05HGU=cRoqJE1-bQa0KyLofJYhQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] workingset: refactor LRU refault to expose refault
 recency check
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 23, 2023 at 7:11 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> In preparation for computing recently evicted pages in cachestat,
> refactor workingset_refault and lru_gen_refault to expose a helper
> function that would test if an evicted page is recently evicted.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/swap.h |   1 +
>  mm/workingset.c      | 142 +++++++++++++++++++++++++++++--------------
>  2 files changed, 97 insertions(+), 46 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a18cf4b7c724..dae6f6f955eb 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
>  }
>
>  /* linux/mm/workingset.c */
> +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
>  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
>  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
>  void workingset_refault(struct folio *folio, void *shadow);
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 79585d55c45d..2f2d94867366 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
>         return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
>  }
>
> +/*
> + * Test if the folio is recently evicted.
> + *
> + * As a side effect, also populates the references with
> + * values unpacked from the shadow of the evicted folio.
> + */
> +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> +               struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> +{
> +       struct mem_cgroup *eviction_memcg;
> +       struct lruvec *lruvec;
> +       struct lru_gen_struct *lrugen;
> +       unsigned long min_seq;
> +
> +       unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> +       eviction_memcg = mem_cgroup_from_id(*memcgid);
> +
> +       lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> +       lrugen = &lruvec->lrugen;
> +
> +       min_seq = READ_ONCE(lrugen->min_seq[file]);
> +       return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
> +}
> +
>  static void lru_gen_refault(struct folio *folio, void *shadow)
>  {
>         int hist, tier, refs;
> @@ -258,23 +282,22 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
>         int type = folio_is_file_lru(folio);
>         int delta = folio_nr_pages(folio);
>
> -       unpack_shadow(shadow, &memcg_id, &pgdat, &token, &workingset);
> -
> -       if (pgdat != folio_pgdat(folio))
> -               return;
> -
>         rcu_read_lock();
>
> +       if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
> +                       &workingset))
> +               goto unlock;
> +
>         memcg = folio_memcg_rcu(folio);
>         if (memcg_id != mem_cgroup_id(memcg))
>                 goto unlock;
>
> +       if (pgdat != folio_pgdat(folio))
> +               return;
> +
>         lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         lrugen = &lruvec->lrugen;
> -
>         min_seq = READ_ONCE(lrugen->min_seq[type]);
> -       if ((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)))
> -               goto unlock;
>
>         hist = lru_hist_from_seq(min_seq);
>         /* see the comment in folio_lru_refs() */
> @@ -306,6 +329,12 @@ static void *lru_gen_eviction(struct folio *folio)
>         return NULL;
>  }
>
> +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> +               struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> +{
> +       return false;
> +}
> +
>  static void lru_gen_refault(struct folio *folio, void *shadow)
>  {
>  }
> @@ -373,40 +402,31 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
>                                 folio_test_workingset(folio));
>  }
>
> -/**
> - * workingset_refault - Evaluate the refault of a previously evicted folio.
> - * @folio: The freshly allocated replacement folio.
> - * @shadow: Shadow entry of the evicted folio.
> +/*
> + * Test if the folio is recently evicted by checking if
> + * refault distance of shadow exceeds workingset size.
>   *
> - * Calculates and evaluates the refault distance of the previously
> - * evicted folio in the context of the node and the memcg whose memory
> - * pressure caused the eviction.
> + * As a side effect, populate workingset with the value
> + * unpacked from shadow.
>   */
> -void workingset_refault(struct folio *folio, void *shadow)
> +bool workingset_test_recent(void *shadow, bool file, bool *workingset)
>  {
> -       bool file = folio_is_file_lru(folio);
>         struct mem_cgroup *eviction_memcg;
>         struct lruvec *eviction_lruvec;
>         unsigned long refault_distance;
>         unsigned long workingset_size;
> -       struct pglist_data *pgdat;
> -       struct mem_cgroup *memcg;
> -       unsigned long eviction;
> -       struct lruvec *lruvec;
>         unsigned long refault;
> -       bool workingset;
>         int memcgid;
> -       long nr;
> +       struct pglist_data *pgdat;
> +       unsigned long eviction;
>
> -       if (lru_gen_enabled()) {
> -               lru_gen_refault(folio, shadow);
> -               return;
> -       }
> +       if (lru_gen_enabled())
> +               lru_gen_test_recent(shadow, file, &memcgid, &pgdat, &eviction,
> +                       workingset);

Missing "return", which was correctly handled in your v2, btw.
