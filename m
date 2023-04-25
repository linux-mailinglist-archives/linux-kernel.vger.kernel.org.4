Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9726ED971
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 02:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjDYA56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 20:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDYA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 20:57:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E5AAD19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 17:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682384275; x=1713920275;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=2jOX8zM/BhFh+OOJY9lMykjg+FyxEAxRob4zzveLMug=;
  b=Q5YWOab80g69Y9jLNZDn6LEQ8TlIAV8EefjiTbXvzntakDN9X60suh65
   zXjoIcqX4kF8MCORfKR8U8v96uUc2MUd/19ZTMloSnfXXa3sZkljrw7X7
   MXsiw3fCNV2zb8wodzB0XGx2N8iRIg/EYRIwD4CJ8HIyWrgcK/hofdMtu
   /vhhO8Sg+mXhyhYP1A84433ot1wgavFrcABsWG4njvRlyx7V4/OHwYPFs
   8moM1WVln0eOsNpTMbHKiMkVS9XfDa/T68WhCO6RTDyEU5AkE7lcHc4tN
   hn34mhT+89oGZJf/ZsOOusJVKqmu9uodCFkG0M5CUGxktj9CVh2Jzgo3s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="349415235"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="349415235"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="804839266"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="804839266"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:57:52 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 14/26] mm: compaction: simplify should_compact_retry()
References: <20230418191313.268131-1-hannes@cmpxchg.org>
        <20230418191313.268131-15-hannes@cmpxchg.org>
Date:   Tue, 25 Apr 2023 08:56:47 +0800
In-Reply-To: <20230418191313.268131-15-hannes@cmpxchg.org> (Johannes Weiner's
        message of "Tue, 18 Apr 2023 15:13:01 -0400")
Message-ID: <87v8hkkcds.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> The different branches for retry are unnecessarily complicated. There
> is really only three outcomes: progress, skipped, failed. Also, the
> retry counter only applies to loops that made progress, move it there.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 60 +++++++++++++++++--------------------------------
>  1 file changed, 20 insertions(+), 40 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c3b7dc479936..18fa2bbba44b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4608,7 +4608,6 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
>  {
> -	int max_retries = MAX_COMPACT_RETRIES;
>  	int min_priority;
>  	bool ret = false;
>  	int retries = *compaction_retries;
> @@ -4621,19 +4620,27 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  		return false;
>  
>  	/*
> -	 * Compaction managed to coalesce some page blocks, but the
> -	 * allocation failed presumably due to a race. Retry some.
> +	 * Compaction coalesced some page blocks, but the allocation
> +	 * failed, presumably due to a race. Retry a few times.
>  	 */
> -	if (compact_result == COMPACT_SUCCESS)
> -		(*compaction_retries)++;
> +	if (compact_result == COMPACT_SUCCESS) {
> +		int max_retries = MAX_COMPACT_RETRIES;
>  
> -	/*
> -	 * All zones were scanned completely and still no result. It
> -	 * doesn't really make much sense to retry except when the
> -	 * failure could be caused by insufficient priority
> -	 */
> -	if (compact_result == COMPACT_COMPLETE)
> -		goto check_priority;
> +		/*
> +		 * !costly requests are much more important than
> +		 * __GFP_RETRY_MAYFAIL costly ones because they are de
> +		 * facto nofail and invoke OOM killer to move on while
> +		 * costly can fail and users are ready to cope with
> +		 * that. 1/4 retries is rather arbitrary but we would
> +		 * need much more detailed feedback from compaction to
> +		 * make a better decision.
> +		 */
> +		if (order > PAGE_ALLOC_COSTLY_ORDER)
> +			max_retries /= 4;
> +
> +		ret = ++(*compaction_retries) <= MAX_COMPACT_RETRIES;
                                                 ~~~~~~~~~~~~~~~~~~~

Should be max_retries?

Best Regards,
Huang, Ying

> +		goto out;
> +	}
>  
>  	/*
>  	 * Compaction was skipped due to a lack of free order-0
> @@ -4645,35 +4652,8 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	}
>  
>  	/*
> -	 * If compaction backed due to being deferred, due to
> -	 * contended locks in async mode, or due to scanners meeting
> -	 * after a partial scan, retry with increased priority.
> -	 */
> -	if (compact_result == COMPACT_DEFERRED ||
> -	    compact_result == COMPACT_CONTENDED ||
> -	    compact_result == COMPACT_PARTIAL_SKIPPED)
> -		goto check_priority;
> -
> -	/*
> -	 * !costly requests are much more important than __GFP_RETRY_MAYFAIL
> -	 * costly ones because they are de facto nofail and invoke OOM
> -	 * killer to move on while costly can fail and users are ready
> -	 * to cope with that. 1/4 retries is rather arbitrary but we
> -	 * would need much more detailed feedback from compaction to
> -	 * make a better decision.
> -	 */
> -	if (order > PAGE_ALLOC_COSTLY_ORDER)
> -		max_retries /= 4;
> -	if (*compaction_retries <= max_retries) {
> -		ret = true;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Make sure there are attempts at the highest priority if we exhausted
> -	 * all retries or failed at the lower priorities.
> +	 * Compaction failed. Retry with increasing priority.
>  	 */
> -check_priority:
>  	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
>  			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
