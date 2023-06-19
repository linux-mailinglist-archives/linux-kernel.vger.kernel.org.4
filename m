Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE17349DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFSCAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFSCAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:00:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088CE44
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 19:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687140020; x=1718676020;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=oR4P0GMr2zpplJmRIjn6et1iR6kpZud+0pyoFilsgp4=;
  b=WklpBN7y6CCwf3QruJuVHgB3t3gy5P5+GrcXMoZ5NQ7IRhALKv9G4UdH
   mjK2NIR3GoWPrYgjAtFrxwt8YuV8+AlNE5thyfScvrEq9vrbKbuAYBcHl
   A7Mn5n3Wppq+541jvxdJJSpnreQkeFFyk1NAF7KZQq5CYzHiFYUvpGRqT
   +UtNxvtvvS3KY3KEsZRBMe3VS4SjbjF0z2CZq7PdSomEA0U8w9WpyjvU9
   Gb7VqJNa4YDoxxt+vxr+C/hhQi9640OShi7YnFAaeRolOusdBDS7PlqSf
   j4c1/dtC2sRFkN/MXv6/SgI8GW5md2ZSWAqfwZhETe3PsLlQtHr9/DOsE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="359534614"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="359534614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 18:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="663812323"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="663812323"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 18:59:38 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] Revert "mm/migrate: __unmap_and_move() push
 good newpage to LRU"
References: <20230618065824.1365750-1-yosryahmed@google.com>
Date:   Mon, 19 Jun 2023 09:57:58 +0800
In-Reply-To: <20230618065824.1365750-1-yosryahmed@google.com> (Yosry Ahmed's
        message of "Sun, 18 Jun 2023 06:58:24 +0000")
Message-ID: <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yosry,

Yosry Ahmed <yosryahmed@google.com> writes:

> This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.
>
> That commit made sure we immediately add the new page to the LRU before
> remove_migration_ptes() is called in migrate_move_folio() (used to be
> __unmap_and_move() back then), such that the rmap walk will rebuild the
> correct mlock_count for the page again. This was needed because the
> mlock_count was lost when the page is isolated. This is no longer the
> case since mlock_count no longer overlays page->lru.
>
> Revert the commit (the code was foliated afterward the commit, so the
> revert is updated as such).
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/migrate.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..68f693731865 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
>  	if (unlikely(!is_lru))
>  		goto out_unlock_both;

The patch itself looks good to me!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

And, it seems that we can remove the above 2 lines and "out_unlock_both"
label now.  That can make the code simpler a little.  Right?

Best Regards,
Huang, Ying

> -	/*
> -	 * When successful, push dst to LRU immediately: so that if it
> -	 * turns out to be an mlocked page, remove_migration_ptes() will
> -	 * automatically build up the correct dst->mlock_count for it.
> -	 *
> -	 * We would like to do something similar for the old page, when
> -	 * unsuccessful, and other cases when a page has been temporarily
> -	 * isolated from the unevictable LRU: but this case is the easiest.
> -	 */
> -	folio_add_lru(dst);
> -	if (page_was_mapped)
> -		lru_add_drain();
> -
>  	if (page_was_mapped)
>  		remove_migration_ptes(src, dst, false);
>  
> @@ -1301,9 +1288,16 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
>  	/*
>  	 * If migration is successful, decrease refcount of dst,
>  	 * which will not free the page because new page owner increased
> -	 * refcounter.
> +	 * refcounter. As well, if it is LRU folio, add the folio to LRU
> +	 * list in here. Use the old state of the isolated source folio to
> +	 * determine if we migrated a LRU folio. dst was already unlocked
> +	 * and possibly modified by its owner - don't rely on the folio
> +	 * state.
>  	 */
> -	folio_put(dst);
> +	if (unlikely(!is_lru))
> +		folio_put(dst);
> +	else
> +		folio_putback_lru(dst);
>  
>  	/*
>  	 * A folio that has been migrated has all references removed
