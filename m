Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04696439AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLEXtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLEXtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:49:39 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012C64C8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:49:37 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id m5so4453353uah.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldNCDX/APtWVkIDjTqA4OBk1LuXyTxcfhfZyvH0Ni2g=;
        b=RtbFU+VptCoVMwYp/9anhqVtRxjzIpSgurgnR3UUHtESxVF+O+ny/vbUm57kY0xgNp
         FwSVBpLyTzRh8LfcLcaynRTeXlgkGIuudO+jvb9xXpx6y+YqvtIsFmqzlpfRD5GhK2/j
         ZbJ/vH3oKKXMSPwyDtUSeOANh5hMZDq2lGvfMT04FrJ2zPo0ktDKx8LbmFTujezFTpE5
         fT+9lIwMVg0yPpy3Uq8ysO3IYRV8cuwd30wRevtPTE0rxh2wyKXSZ5xOZ3zkiJX7iffa
         o50EKtEOuD9nOyQVCLfs1DUU3yupoHkCsHOBPGWiWqnVcL6cyTYd56J/RA4Tw0j+l6gO
         i5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldNCDX/APtWVkIDjTqA4OBk1LuXyTxcfhfZyvH0Ni2g=;
        b=DnqiolM/NXykr9ECiYGitpUtlPKx6G1DTi1FMJQDXdGqBlKWy0LkrRscTTY9DpbtBn
         DxSa7YAw6grQgGYpJSqTOSlDfL9Euxs+6MuimZCOco1oXjy/G+PB48JsiPg/dtrwl2ex
         vJEFsf4uvCbd7+jRolBcroLPnXQDL8BrKpayI/+MJaZss6jOfmk2M7D1TYHlEEn3jr/R
         t1K1dqhyUXC+AoIfK6uQGn2OVe59kEvN6OXY9bUD7aT85uTTfwD4FEMPUXudIkA63Kg8
         cj9GZG3ZmMCMzSjc/5Z8yZhTu5BITbgzUaSGZFqXp3DyIlBUYm4t6B5jcaE+kH3GlmZw
         n/Yw==
X-Gm-Message-State: ANoB5pk5rd2N09JnW3oWxpC6RYXyCzkQDEUhe5qadSIP7szwGo6T94j9
        /fHjc4CCUp3cO3YmfDhKP2MyTji/9GWQCRemo2izbG1wG7QsKA==
X-Google-Smtp-Source: AA0mqf7eHzYF3qJPbgjyqywlKuykP0mrWTOTufXeNzSWSHZsnY+hlLkqylq5ISEM9jmyEmJRVSEcVypadzRGWtsgq+Q=
X-Received: by 2002:ab0:5517:0:b0:409:5403:c18 with SMTP id
 t23-20020ab05517000000b0040954030c18mr38761352uaa.51.1670284176750; Mon, 05
 Dec 2022 15:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-3-nphamcs@gmail.com>
In-Reply-To: <20221205175140.1543229-3-nphamcs@gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 5 Dec 2022 16:49:00 -0700
Message-ID: <CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] workingset: refactor LRU refault to expose refault
 recency check
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
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

On Mon, Dec 5, 2022 at 10:51 AM Nhat Pham <nphamcs@gmail.com> wrote:
>
> In preparation for computing recently evicted pages in cachestat,
> refactor workingset_refault and lru_gen_refault to expose a helper
> function that would test if an evicted page is recently evicted.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/swap.h |   1 +
>  mm/workingset.c      | 143 +++++++++++++++++++++++++++++--------------
>  2 files changed, 99 insertions(+), 45 deletions(-)
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
> index 79585d55c45d..44b331ce3040 100644
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
> +       struct pglist_data **pgdat, unsigned long *token, bool *workingset)
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
> +       return !((*token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> +}

Nit: not refactoring actually looks cleaner to me -- there are only a
few lines of duplicated code and you can get rid of 4 parameters
including the unused workingset in the next patch.
