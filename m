Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20946710DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbjEYNyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjEYNyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:54:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7E189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:54:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6bafd4782so4868181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685022848; x=1687614848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLEZRdqcCWpE4xyc1kmqZXFrPIoPVCRTH/D3PTcgmf4=;
        b=LITMVb+ohsmbbnOgQYinNMiwgZI+Vu9oEIG4dSqbWs6cV4BGXZ81XRDZ66RNYkGPcY
         d94i2HGWR/MShjHHwieUU9IgaHYfY4/RW2gCSITSQmvcZky6VJLfUFjjqAOMF5UMb0ag
         iUFvRKUnI5KPyy7Dwu6rFA+Gag9PIdFp9MtU2Aga8Zd07p9NVFjX8QD2g5BpPYjEKXaq
         HvI1qYu6JxRiWjSmGWP4bNvrWAG0blrQjmxw8Hqz47F27DBoaOqzUMBDiG297zBD7XZo
         sHt2BlLbM/6H9olL2RiHTj+9EGRL5laQenCRqX0NpdxesxF3qXh0QOfKqyTfc5VBMjUj
         /L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685022848; x=1687614848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLEZRdqcCWpE4xyc1kmqZXFrPIoPVCRTH/D3PTcgmf4=;
        b=VfkDiusIyZusgBHhmcGkEGFTQMj6XtHFG7/eRaj4UvovRyfo3ts2gz8rYQqqnwCq9M
         5yEgJkSogBaWIufeMNXSLEY5QEEh9SIhAqn36xLQJGlCtUugJGuAUBdSUpPdkwNziVty
         X28Y/4foXkIk+iXAO9xwwDizKWA0ZroCjcq+QWFaja0AaNosd07al5HwTKJ9MKm87ZLg
         olcmNgQmJq8RsvVktS/+LtvuheV5bafCuUoa1pZVVidQ2awcfSj1+AQV5BS05q/HMXzq
         jQ3YCR574SNWeAd6PKMvQImvrykB8P/tXE4Uswwfr2wE/XBL8sP85o8Oswz9lOGhsDwf
         aPWg==
X-Gm-Message-State: AC+VfDzm9/rmqKHv+kEU4nUzfs1RVmH2hVJKTlxUfKJa4l0MITVskVPx
        b3LBgk1MbOGxCukPtIQHyqMIMA==
X-Google-Smtp-Source: ACHHUZ55Ue38M3RU860aS455regVxF0q065zBCLs3j24DWS8tAv4nXVZwx3K4sGmBgc3RKH5Blqcag==
X-Received: by 2002:a05:622a:8a:b0:3f3:95a7:a5ac with SMTP id o10-20020a05622a008a00b003f395a7a5acmr29078052qtw.51.1685022848413;
        Thu, 25 May 2023 06:54:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id d10-20020ac8534a000000b003e69d6792f6sm412101qto.45.2023.05.25.06.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 06:54:07 -0700 (PDT)
Date:   Thu, 25 May 2023 09:54:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: deduct the number of pages reclaimed by madvise from
 workingset
Message-ID: <20230525135407.GA31865@cmpxchg.org>
References: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 05:12:54PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The pages reclaimed by madvise_pageout are made of inactive and dropped from LRU
> forcefully, which lead to the coming up refault pages possess a large refault
> distance than it should be. These could affect the accuracy of thrashing when
> madvise_pageout is used as a common way of memory reclaiming as ANDROID does now.

This alludes to, but doesn't explain, a real world usecase.

Yes, madvise_pageout() will record non-resident entries today. This
means refault and thrash detection is on for user-driven reclaim.

So why is that undesirable?

Today we measure and report the cost of reclaim and memory pressure
for physical memory shortages, cgroup limits, and user-driven cgroup
reclaim. Why should we not do the same for madv_pageout()? If the
userspace code that drives pageout has a bug and the result is extreme
thrashing, wouldn't you want to know that?

Please explain the idea here better.

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
> @@ -428,7 +428,7 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  extern int vm_swappiness;
>  long remove_mapping(struct address_space *mapping, struct folio *folio);
>  
> -extern unsigned long reclaim_pages(struct list_head *page_list);
> +extern unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *page_list);
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim_mode;
>  extern int sysctl_min_unmapped_ratio;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b6ea204..61c8d7b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -420,7 +420,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  huge_unlock:
>  		spin_unlock(ptl);
>  		if (pageout)
> -			reclaim_pages(&page_list);
> +			reclaim_pages(mm, &page_list);
>  		return 0;
>  	}
>  
> @@ -516,7 +516,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	arch_leave_lazy_mmu_mode();
>  	pte_unmap_unlock(orig_pte, ptl);
>  	if (pageout)
> -		reclaim_pages(&page_list);
> +		reclaim_pages(mm, &page_list);
>  	cond_resched();
>  
>  	return 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 20facec..048c10b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2741,12 +2741,14 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>  	return nr_reclaimed;
>  }
>  
> -unsigned long reclaim_pages(struct list_head *folio_list)
> +unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *folio_list)
>  {
>  	int nid;
>  	unsigned int nr_reclaimed = 0;
>  	LIST_HEAD(node_folio_list);
>  	unsigned int noreclaim_flag;
> +	struct lruvec *lruvec;
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>  
>  	if (list_empty(folio_list))
>  		return nr_reclaimed;
> @@ -2764,10 +2766,14 @@ unsigned long reclaim_pages(struct list_head *folio_list)
>  		}
>  
>  		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
> +		lruvec = &memcg->nodeinfo[nid]->lruvec;
> +		workingset_age_nonresident(lruvec, -nr_reclaimed);
>  		nid = folio_nid(lru_to_folio(folio_list));
>  	} while (!list_empty(folio_list));
>  
>  	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
> +	lruvec = &memcg->nodeinfo[nid]->lruvec;
> +	workingset_age_nonresident(lruvec, -nr_reclaimed);

The task might have moved cgroups in between, who knows what kind of
artifacts it will introduce if you wind back the wrong clock.

If there are reclaim passes that shouldn't participate in non-resident
tracking, that should be plumbed through the stack to __remove_mapping
(which already has that bool reclaimed param to not record entries).
