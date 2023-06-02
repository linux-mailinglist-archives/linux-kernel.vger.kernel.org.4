Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7071F9E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjFBGIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjFBGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBD1AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1067636FB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70ABC433D2;
        Fri,  2 Jun 2023 06:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685686126;
        bh=/8Fx5MgOM8Y3VrkJfY+HxO7JcKDJ80iHzD29KFbu03k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pb8Ubp3R6tgB8H6vTQGgCH3tzWuD6oyOcOcf3ttcPYGj23huLTU0fHliTjPjmoDmF
         S4sDcA7+EXMHvkpmS2kTOOaf7woygcNK+jA12+b7X5QQn0szOwPe7nv1VasWWku++E
         UaXf2nCcQW9R7RPcQCvN+Vl2ItI34SvfzRqE7Oz6PN2Z6HAMyHFwrLD3Mre4s+HI5V
         i5geif2esZ7rlS9IwLkVV4zoMMyWTSJpV2EgoMIPRVWak7g5haPUTAw13YWgILQsnE
         cXzWowOFTIyJeUX6ayuvHs7T7t38btPgaZnC8Dvls9o7WHVEcOeh5hS/530SQ4Z5NX
         c+w75go6yxWew==
Date:   Thu, 1 Jun 2023 23:08:43 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH -V3 4/5] swap: remove get/put_swap_device() in
 __swap_duplicate()
Message-ID: <ZHmHa44QogoLgWfA@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-5-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529061355.125791-5-ying.huang@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:13:54PM +0800, Huang Ying wrote:
> __swap_duplicate() is called by
> 
> - swap_shmem_alloc(): the folio in swap cache is locked.
> 
> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
>   swap_duplicate(): the page table lock is held.
> 
> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>   get/put_swap_device() in __read_swap_cache_async() already.
> 
> So, it's safe to remove get/put_swap_device() in __swap_duplicate().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> ---
>  mm/swapfile.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e9cce775fb25..4dbaea64635d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3264,9 +3264,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>  	unsigned char has_cache;
>  	int err;
>  
> -	p = get_swap_device(entry);
> -	if (!p)
> -		return -EINVAL;
> +	p = swp_swap_info(entry);
>  
>  	offset = swp_offset(entry);
>  	ci = lock_cluster_or_swap_info(p, offset);
> @@ -3313,7 +3311,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>  
>  unlock_out:
>  	unlock_cluster_or_swap_info(p, ci);
> -	put_swap_device(p);
>  	return err;
>  }
>  
> -- 
> 2.39.2
>

Reviewed-by: Chris Li (Google) <chrisl@kernel.org>

Chris
 
