Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46596733E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjASInF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjASInC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:43:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833835B477
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:42:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2073D612BF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16584C433EF;
        Thu, 19 Jan 2023 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674117778;
        bh=LI6M/IodIDraG4vo0tg2WqsUpGHdn0SKKJzyG9vr+tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOuixRcRgj/7x446d+Ap8L7MWaHxeIl0r71eppXqqUevWV8MuS9Rw0+bF0RX5+Qlx
         h57Wfn5V3LeXtpdhrJCWJCDYWjJJgghC7Rr5MKg60Lx/2mQRi0bpkBhuPkReUDOunw
         2ve8jGS6OjKFanEUZ+yPzmdeVzKStoF6J4AVrn0y3nVzQvNpeG0p9wSxZTjneczSMa
         6I4IByf3wUv0DPoo+GtGHMLSDq+xR1yhlTmmLxRnLv4Xp8595wcxneK+w7S7OuUeKs
         fZQpZrVs2tqaw8o2KVougEhYtEWmTDD2Z/AWKdSTN1tMYec0cZdt9eEH+tA/WEYdef
         MSVlshASIw6ew==
Date:   Thu, 19 Jan 2023 10:42:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/page_ext: init page_ext early if there are no
 deferred struct pages
Message-ID: <Y8kChUgGCikoDziP@kernel.org>
References: <20230118155251.2522985-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118155251.2522985-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:52:51PM +0000, Pasha Tatashin wrote:
> page_ext must be initialized after all struct pages are initialized.
> Therefore, page_ext is initialized after page_alloc_init_late(), and
> can optionally be initialized earlier via early_page_ext kernel
> parameter which as a side effect also disables deferred struct pages.
> 
> Allow to automatically init page_ext early when there are no deferred
> struct pages in order to be able to use page_ext during kernel boot
> and track for example page allocations early.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/page_ext.h | 2 ++
>  init/main.c              | 6 +++---
>  mm/page_alloc.c          | 6 +++++-
>  mm/page_ext.c            | 2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> Changelog:
> v2: Fixed build issue with CONFIG_PAGE_EXTENSION=n
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index 67314f648aeb..bc2e39090a1f 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -29,6 +29,8 @@ struct page_ext_operations {
>  	bool need_shared_flags;
>  };
>  
> +extern bool deferred_struct_pages;
> +
>  #ifdef CONFIG_PAGE_EXTENSION
>  
>  /*
> diff --git a/init/main.c b/init/main.c
> index e1c3911d7c70..64cd2ff051c4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -855,8 +855,8 @@ static void __init mm_init(void)
>  	pgtable_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
> -	/* Should be run after vmap initialization */
> -	if (early_page_ext_enabled())
> +	/* If no deferred init page_ext now, as vmap is fully initialized */
> +	if (!deferred_struct_pages)
>  		page_ext_init();
>  	/* Should be run before the first non-init thread is created */
>  	init_espfix_bsp();
> @@ -1628,7 +1628,7 @@ static noinline void __init kernel_init_freeable(void)
>  	padata_init();
>  	page_alloc_init_late();
>  	/* Initialize page ext after all struct pages are initialized. */
> -	if (!early_page_ext_enabled())
> +	if (deferred_struct_pages)
>  		page_ext_init();
>  
>  	do_basic_setup();
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 99ebb08dc3f2..717f12e83b85 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -430,6 +430,8 @@ EXPORT_SYMBOL(nr_online_nodes);
>  
>  int page_group_by_mobility_disabled __read_mostly;
>  
> +bool deferred_struct_pages __meminitdata;
> +
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  /*
>   * During boot we initialize deferred pages on-demand, as needed, but once
> @@ -6803,8 +6805,10 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  		if (context == MEMINIT_EARLY) {
>  			if (overlap_memmap_init(zone, &pfn))
>  				continue;
> -			if (defer_init(nid, pfn, zone_end_pfn))
> +			if (defer_init(nid, pfn, zone_end_pfn)) {
> +				deferred_struct_pages = true;
>  				break;
> +			}
>  		}
>  
>  		page = pfn_to_page(pfn);
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index e2c22ffdbb81..dc1626be458b 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -92,7 +92,7 @@ unsigned long page_ext_size;
>  static unsigned long total_usage;
>  static struct page_ext *lookup_page_ext(const struct page *page);
>  
> -bool early_page_ext;
> +bool early_page_ext __meminitdata;
>  static int __init setup_early_page_ext(char *str)
>  {
>  	early_page_ext = true;
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Sincerely yours,
Mike.
