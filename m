Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2086665E700
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjAEIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjAEIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:45:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E88ED4D488
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:45:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74DC91063;
        Thu,  5 Jan 2023 00:45:44 -0800 (PST)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D55D3F71A;
        Thu,  5 Jan 2023 00:45:00 -0800 (PST)
Message-ID: <da2a3cec-3cd3-cafb-b872-477c7376c60e@arm.com>
Date:   Thu, 5 Jan 2023 14:14:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm/page_alloc: invert logic for early page initialisation
 checks
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230104191805.2535864-1-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230104191805.2535864-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 00:48, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Rename early_page_uninitialised() to early_page_initialised() and invert
> its logic to make the code more readable.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  mm/page_alloc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..a881f2d42b2c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -443,15 +443,15 @@ static inline bool deferred_pages_enabled(void)
>  	return static_branch_unlikely(&deferred_pages);
>  }
>  
> -/* Returns true if the struct page for the pfn is uninitialised */
> -static inline bool __meminit early_page_uninitialised(unsigned long pfn)
> +/* Returns true if the struct page for the pfn is initialised */
> +static inline bool __meminit early_page_initialised(unsigned long pfn)
>  {
>  	int nid = early_pfn_to_nid(pfn);
>  
>  	if (node_online(nid) && pfn >= NODE_DATA(nid)->first_deferred_pfn)
> -		return true;
> +		return false;
>  
> -	return false;
> +	return true;
>  }
>  
>  /*
> @@ -498,9 +498,9 @@ static inline bool deferred_pages_enabled(void)
>  	return false;
>  }
>  
> -static inline bool early_page_uninitialised(unsigned long pfn)
> +static inline bool early_page_initialised(unsigned long pfn)
>  {
> -	return false;
> +	return true;
>  }
>  
>  static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> @@ -1641,7 +1641,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
>  	pg_data_t *pgdat;
>  	int nid, zid;
>  
> -	if (!early_page_uninitialised(pfn))
> +	if (early_page_initialised(pfn))
>  		return;
>  
>  	nid = early_pfn_to_nid(pfn);
> @@ -1804,7 +1804,7 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
>  void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
> -	if (early_page_uninitialised(pfn))
> +	if (!early_page_initialised(pfn))
>  		return;
>  	if (!kmsan_memblock_free_pages(page, order)) {
>  		/* KMSAN will take care of these pages. */
