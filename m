Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACB71F9CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjFBFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjFBFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FF19A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F8264C5A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B96C433D2;
        Fri,  2 Jun 2023 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685685198;
        bh=JkCLgSoY6/mH3spjDh4/wCaWaV2J+a3C8TmXVA/eMyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DaxkSclIHjvLETuxnwisvEI5KvnhgJQMGKhGZ9VfWO0jiKgAQkOGCNcgZdl575Ary
         MJxCkBoGiAfGkzMOmjG/FkX+Hli+uK856rdeTB8edZQk1/EwytR+p151JNP12e5vA2
         XukY8epZx3dPSVQoyYOs+6oIe9gjtMkgLuWpOgYFFnzbeSnCaoyKhDRNZNH0imk/XZ
         Klsg2cnIFa/QYnBCvXDumnVKLUd4WGDngBD6zB1eZ1pZ15iYPkvGqzGmxxkMHj8gV8
         OWNREb8KjvKc1wEgxk0cj78OFdVEYfBQm0pm0kPX/cQgCv7p/qvSmSspSGoVsX+SZ8
         2FW3MyqRMq28g==
Date:   Thu, 1 Jun 2023 22:53:16 -0700
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
Subject: Re: [PATCH -V3 1/5] swap: Remove get/put_swap_device() in
 __swap_count()
Message-ID: <ZHmDzF4sPxlqUMBE@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529061355.125791-2-ying.huang@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:13:51PM +0800, Huang Ying wrote:
> get/put_swap_device() are added to __swap_count() in commit
> eb085574a752 ("mm, swap: fix race between swapoff and some swap
> operations").  Later, in commit 2799e77529c2 ("swap: fix
> do_swap_page() race with swapoff"), get/put_swap_device() are added to
> do_swap_page().  And they enclose the only call site of
> __swap_count().  So, it's safe to remove get/put_swap_device() in
> __swap_count() now.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>

Reviewed-By: Chris Li (Google) <chrisl@kernel.org>

Chris

> ---
>  mm/swapfile.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 274bbf797480..8419cba9c192 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1432,16 +1432,10 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
>  
>  int __swap_count(swp_entry_t entry)
>  {
> -	struct swap_info_struct *si;
> +	struct swap_info_struct *si = swp_swap_info(entry);
>  	pgoff_t offset = swp_offset(entry);
> -	int count = 0;
>  
> -	si = get_swap_device(entry);
> -	if (si) {
> -		count = swap_count(si->swap_map[offset]);
> -		put_swap_device(si);
> -	}
> -	return count;
> +	return swap_count(si->swap_map[offset]);
>  }
>  
>  /*
> -- 
> 2.39.2
> 
