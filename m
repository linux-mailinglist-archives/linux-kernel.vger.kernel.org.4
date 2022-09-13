Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276F5B691A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIMH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIMH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:58:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31E9BB48C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:58:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1BD106F;
        Tue, 13 Sep 2022 00:58:49 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1BC23F73B;
        Tue, 13 Sep 2022 00:58:40 -0700 (PDT)
Message-ID: <a0e30ae4-7241-aca1-7824-e40d9a848a15@arm.com>
Date:   Tue, 13 Sep 2022 13:28:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/16] mm/page_alloc: make zone_pcp_update() static
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-3-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 14:54, Miaohe Lin wrote:
> Since commit b92ca18e8ca5 ("mm/page_alloc: disassociate the pcp->high
> from pcp->batch"), zone_pcp_update() is only used in mm/page_alloc.c.
> Move zone_pcp_update() up to avoid forward declaration and then make
> it static. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/internal.h   |  1 -
>  mm/page_alloc.c | 22 +++++++++++-----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 4e5f3d0d5538..2424fcde6538 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -367,7 +367,6 @@ extern int user_min_free_kbytes;
>  extern void free_unref_page(struct page *page, unsigned int order);
>  extern void free_unref_page_list(struct list_head *list);
>  
> -extern void zone_pcp_update(struct zone *zone, int cpu_online);
>  extern void zone_pcp_reset(struct zone *zone);
>  extern void zone_pcp_disable(struct zone *zone);
>  extern void zone_pcp_enable(struct zone *zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4b97a03fa2dd..2deac2fe3372 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7238,6 +7238,17 @@ void __meminit setup_zone_pageset(struct zone *zone)
>  	zone_set_pageset_high_and_batch(zone, 0);
>  }
>  
> +/*
> + * The zone indicated has a new number of managed_pages; batch sizes and percpu
> + * page high values need to be recalculated.
> + */
> +static void zone_pcp_update(struct zone *zone, int cpu_online)
> +{
> +	mutex_lock(&pcp_batch_high_lock);
> +	zone_set_pageset_high_and_batch(zone, cpu_online);
> +	mutex_unlock(&pcp_batch_high_lock);
> +}
> +
>  /*
>   * Allocate per cpu pagesets and initialize them.
>   * Before this call only boot pagesets were available.
> @@ -9469,17 +9480,6 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  }
>  EXPORT_SYMBOL(free_contig_range);
>  
> -/*
> - * The zone indicated has a new number of managed_pages; batch sizes and percpu
> - * page high values need to be recalculated.
> - */
> -void zone_pcp_update(struct zone *zone, int cpu_online)
> -{
> -	mutex_lock(&pcp_batch_high_lock);
> -	zone_set_pageset_high_and_batch(zone, cpu_online);
> -	mutex_unlock(&pcp_batch_high_lock);
> -}
> -
>  /*
>   * Effectively disable pcplists for the zone by setting the high limit to 0
>   * and draining all cpus. A concurrent page freeing on another CPU that's about
