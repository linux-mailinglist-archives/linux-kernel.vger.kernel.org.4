Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5792870FF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjEXUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEXUlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:41:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C010B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:41:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561f10b6139so14153437b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684960867; x=1687552867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaeuqwRXMmjwIv+MzH1VKtLd8xBGD/U8uHJPJ3TiuKw=;
        b=b2oYxAQqtU8lrdsYWg6PDR59VUfe7xzKzDJbfxNCli96hM18KUxeur87MzSzyj7sbX
         zf9KqAoWarqU+0hAayr5B6cvS8wFOmrulCxntn9QjlWk6q1UBb5Vhy0wYrb7yaxneP28
         7TVbWk3Q9R6wXBXTlYRYMEOw7HF9j2yN5e/vHkmYT4IfaBll9VZOu4jlKVfr6Y7eMBdm
         bC3ZNxzxSwuxBUlQujA8qOGkA2jmej3AQ8vGQyp7auZixplwNNGvxsEHHvfjhDsHdR/p
         Hxv+BX8BwaXBAfudRfF7pcZnNMPoklAkU+xqH60mBM+o+llpFzf90b2LVX/Ee7Qvi4Os
         KcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684960867; x=1687552867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaeuqwRXMmjwIv+MzH1VKtLd8xBGD/U8uHJPJ3TiuKw=;
        b=UhURDBVxoDbgFZyHw2kvE/++oBN7KhE23Aou+9rhYpXTdhlNn+tTKOenJ6v5vEVcTv
         3OkMZlnYbAgYefHUn48bGd5yfEK+xGd8dcB4JMwaIbNS65UpkYh+j/3VlcYlHT+QdXBF
         3k8zLpr9/6+a6COYxUGJY3zoss/yGy8D0Kcz2pU9aRz8si4RBSJWe1SewfKN2iiNmmNo
         mJrZdsSqcQ3xY3AV1lDeRNKGnBeLOIFpiLh8sPW6ghmOttnx08kiKhr0sr4A7DvjB4S7
         Bw7SRBM4q9tFTXzNUO58ReNc9lkkUgtcM6qmZ6H1PN1UrzTSElQhMWAFx6wEaysmEoJ4
         fZFA==
X-Gm-Message-State: AC+VfDy7PqEuw82A1uvWVgnABxumwKmQNl10izR/97TQKhAB3Z9vwh0u
        CjmEIDmg+V8RSXYkX0Ohgvh5Po5HORNQ3Vafn22a+/rI7tKwYk11llwTNg==
X-Google-Smtp-Source: ACHHUZ4vsyhloQdsa7Qaf624yhT2vvr5oHRywPWiSMcBfyEWln0VwqyYUWUyaZZ2GrLBFCN7sHf3tSrDPfIS0jL1b54=
X-Received: by 2002:a0d:d890:0:b0:561:4bcc:464f with SMTP id
 a138-20020a0dd890000000b005614bcc464fmr21350731ywe.36.1684960866564; Wed, 24
 May 2023 13:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 May 2023 13:40:52 -0700
Message-ID: <CAJuCfpHLdmtzAvhk94vLmkDNBAO8xJMFEdnXy8j=0KGovmmC_w@mail.gmail.com>
Subject: Re: [PATCH] mm: deduct the number of pages reclaimed by madvise from workingset
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
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

On Wed, May 24, 2023 at 2:13=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> The pages reclaimed by madvise_pageout are made of inactive and dropped f=
rom LRU
> forcefully, which lead to the coming up refault pages possess a large ref=
ault
> distance than it should be. These could affect the accuracy of thrashing =
when
> madvise_pageout is used as a common way of memory reclaiming as ANDROID d=
oes now.

Doesn't workingset_eviction() in the following call chain already
handle nonresident page aging?:

reclaim_pages
  reclaim_folio_list
    shrink_folio_list
      __remove_mapping
        workingset_eviction
          workingset_age_nonresident


>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/swap.h | 2 +-
>  mm/madvise.c         | 4 ++--
>  mm/vmscan.c          | 8 +++++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2787b84..0312142 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -428,7 +428,7 @@ extern unsigned long mem_cgroup_shrink_node(struct me=
m_cgroup *mem,
>  extern int vm_swappiness;
>  long remove_mapping(struct address_space *mapping, struct folio *folio);
>
> -extern unsigned long reclaim_pages(struct list_head *page_list);
> +extern unsigned long reclaim_pages(struct mm_struct *mm, struct list_hea=
d *page_list);
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim_mode;
>  extern int sysctl_min_unmapped_ratio;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b6ea204..61c8d7b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -420,7 +420,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>  huge_unlock:
>                 spin_unlock(ptl);
>                 if (pageout)
> -                       reclaim_pages(&page_list);
> +                       reclaim_pages(mm, &page_list);
>                 return 0;
>         }
>
> @@ -516,7 +516,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>         arch_leave_lazy_mmu_mode();
>         pte_unmap_unlock(orig_pte, ptl);
>         if (pageout)
> -               reclaim_pages(&page_list);
> +               reclaim_pages(mm, &page_list);
>         cond_resched();
>
>         return 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 20facec..048c10b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2741,12 +2741,14 @@ static unsigned int reclaim_folio_list(struct lis=
t_head *folio_list,
>         return nr_reclaimed;
>  }
>
> -unsigned long reclaim_pages(struct list_head *folio_list)
> +unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *foli=
o_list)

You would also need to change Damon usage of reclaim_pages() here:
https://elixir.bootlin.com/linux/v6.4-rc1/source/mm/damon/paddr.c#L253

>  {
>         int nid;
>         unsigned int nr_reclaimed =3D 0;
>         LIST_HEAD(node_folio_list);
>         unsigned int noreclaim_flag;
> +       struct lruvec *lruvec;
> +       struct mem_cgroup *memcg =3D get_mem_cgroup_from_mm(mm);
>
>         if (list_empty(folio_list))
>                 return nr_reclaimed;
> @@ -2764,10 +2766,14 @@ unsigned long reclaim_pages(struct list_head *fol=
io_list)
>                 }
>
>                 nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NO=
DE_DATA(nid));
> +               lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> +               workingset_age_nonresident(lruvec, -nr_reclaimed);
>                 nid =3D folio_nid(lru_to_folio(folio_list));
>         } while (!list_empty(folio_list));
>
>         nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NODE_DATA(=
nid));
> +       lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> +       workingset_age_nonresident(lruvec, -nr_reclaimed);
>
>         memalloc_noreclaim_restore(noreclaim_flag);
>
> --
> 1.9.1
>
