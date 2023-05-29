Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA50371478E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjE2J6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjE2J6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:58:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF88A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:58:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E35C1FE51;
        Mon, 29 May 2023 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685354283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBY/iJ08Nu3iXyfntMKOqtt/CWtCEdUoszCM6hJfmPg=;
        b=PPzlHT0r6UKDru+neNsxLvxs2sWPhhkxdjZfwOARBuxmZs20PghVw3RWh0y9NwX1ZW0kW1
        VjYY9elMVj+RD8KOIiKQuT0n0jYETvPye71bZnzZOIc1qGH9Q54tu3NSbmIA+lz/MXG2JQ
        dfxGCJ4ZwbIfv9gfWLAc9nkGehiAH+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685354283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBY/iJ08Nu3iXyfntMKOqtt/CWtCEdUoszCM6hJfmPg=;
        b=YHmoj+1YiTKT0ypOg2WeZQS1k2xqgwAfZch8QUH0s5hWVLxu0FQrOv7SBy2TZJUex4LInk
        E3rlaS6PW5bcqIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 114FA1332D;
        Mon, 29 May 2023 09:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8COHAyt3dGTJcQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 29 May 2023 09:58:03 +0000
Message-ID: <266b9815-104e-864c-688f-955581954e48@suse.cz>
Date:   Mon, 29 May 2023 11:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/5] mm: compaction: remove compaction result helpers
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-2-hannes@cmpxchg.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230519123959.77335-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 14:39, Johannes Weiner wrote:
> The compaction result helpers encode quirks that are specific to the
> allocator's retry logic. E.g. COMPACT_SUCCESS and COMPACT_COMPLETE
> actually represent failures that should be retried upon, and so on. I
> frequently found myself pulling up the helper implementation in order
> to understand and work on the retry logic. They're not quite clean
> abstractions; rather they split the retry logic into two locations.
> 
> Remove the helpers and inline the checks. Then comment on the result
> interpretations directly where the decision making happens.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Since the usage of helpers never proliferated outside of
should_compact_retry() with the exception of tracepoint, I guess it makes
sense to remove them.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/compaction.h     | 92 ----------------------------------
>  include/trace/events/mmflags.h |  4 +-
>  mm/page_alloc.c                | 30 ++++++-----
>  3 files changed, 19 insertions(+), 107 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index a6e512cfb670..1f0328a2ba48 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -95,78 +95,6 @@ extern enum compact_result compaction_suitable(struct zone *zone, int order,
>  extern void compaction_defer_reset(struct zone *zone, int order,
>  				bool alloc_success);
>  
> -/* Compaction has made some progress and retrying makes sense */
> -static inline bool compaction_made_progress(enum compact_result result)
> -{
> -	/*
> -	 * Even though this might sound confusing this in fact tells us
> -	 * that the compaction successfully isolated and migrated some
> -	 * pageblocks.
> -	 */
> -	if (result == COMPACT_SUCCESS)
> -		return true;
> -
> -	return false;
> -}
> -
> -/* Compaction has failed and it doesn't make much sense to keep retrying. */
> -static inline bool compaction_failed(enum compact_result result)
> -{
> -	/* All zones were scanned completely and still not result. */
> -	if (result == COMPACT_COMPLETE)
> -		return true;
> -
> -	return false;
> -}
> -
> -/* Compaction needs reclaim to be performed first, so it can continue. */
> -static inline bool compaction_needs_reclaim(enum compact_result result)
> -{
> -	/*
> -	 * Compaction backed off due to watermark checks for order-0
> -	 * so the regular reclaim has to try harder and reclaim something.
> -	 */
> -	if (result == COMPACT_SKIPPED)
> -		return true;
> -
> -	return false;
> -}
> -
> -/*
> - * Compaction has backed off for some reason after doing some work or none
> - * at all. It might be throttling or lock contention. Retrying might be still
> - * worthwhile, but with a higher priority if allowed.
> - */
> -static inline bool compaction_withdrawn(enum compact_result result)
> -{
> -	/*
> -	 * If compaction is deferred for high-order allocations, it is
> -	 * because sync compaction recently failed. If this is the case
> -	 * and the caller requested a THP allocation, we do not want
> -	 * to heavily disrupt the system, so we fail the allocation
> -	 * instead of entering direct reclaim.
> -	 */
> -	if (result == COMPACT_DEFERRED)
> -		return true;
> -
> -	/*
> -	 * If compaction in async mode encounters contention or blocks higher
> -	 * priority task we back off early rather than cause stalls.
> -	 */
> -	if (result == COMPACT_CONTENDED)
> -		return true;
> -
> -	/*
> -	 * Page scanners have met but we haven't scanned full zones so this
> -	 * is a back off in fact.
> -	 */
> -	if (result == COMPACT_PARTIAL_SKIPPED)
> -		return true;
> -
> -	return false;
> -}
> -
> -
>  bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>  					int alloc_flags);
>  
> @@ -185,26 +113,6 @@ static inline enum compact_result compaction_suitable(struct zone *zone, int ord
>  	return COMPACT_SKIPPED;
>  }
>  
> -static inline bool compaction_made_progress(enum compact_result result)
> -{
> -	return false;
> -}
> -
> -static inline bool compaction_failed(enum compact_result result)
> -{
> -	return false;
> -}
> -
> -static inline bool compaction_needs_reclaim(enum compact_result result)
> -{
> -	return false;
> -}
> -
> -static inline bool compaction_withdrawn(enum compact_result result)
> -{
> -	return true;
> -}
> -
>  static inline void kcompactd_run(int nid)
>  {
>  }
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index b63e7c0fbbe5..1478b9dd05fa 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -223,8 +223,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
>  #define compact_result_to_feedback(result)	\
>  ({						\
>  	enum compact_result __result = result;	\
> -	(compaction_failed(__result)) ? COMPACTION_FAILED : \
> -		(compaction_withdrawn(__result)) ? COMPACTION_WITHDRAWN : COMPACTION_PROGRESS; \
> +	(__result == COMPACT_COMPLETE) ? COMPACTION_FAILED : \
> +		(__result == COMPACT_SUCCESS) ? COMPACTION_PROGRESS : COMPACTION_WITHDRAWN; \
>  })
>  
>  #define COMPACTION_FEEDBACK		\
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b..5a84a0bebc37 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3768,35 +3768,39 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	if (fatal_signal_pending(current))
>  		return false;
>  
> -	if (compaction_made_progress(compact_result))
> +	/*
> +	 * Compaction managed to coalesce some page blocks, but the
> +	 * allocation failed presumably due to a race. Retry some.
> +	 */
> +	if (compact_result == COMPACT_SUCCESS)
>  		(*compaction_retries)++;
>  
>  	/*
> -	 * compaction considers all the zone as desperately out of memory
> -	 * so it doesn't really make much sense to retry except when the
> +	 * All zones were scanned completely and still no result. It
> +	 * doesn't really make much sense to retry except when the
>  	 * failure could be caused by insufficient priority
>  	 */
> -	if (compaction_failed(compact_result))
> +	if (compact_result == COMPACT_COMPLETE)
>  		goto check_priority;
>  
>  	/*
> -	 * compaction was skipped because there are not enough order-0 pages
> -	 * to work with, so we retry only if it looks like reclaim can help.
> +	 * Compaction was skipped due to a lack of free order-0
> +	 * migration targets. Continue if reclaim can help.
>  	 */
> -	if (compaction_needs_reclaim(compact_result)) {
> +	if (compact_result == COMPACT_SKIPPED) {
>  		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
>  		goto out;
>  	}
>  
>  	/*
> -	 * make sure the compaction wasn't deferred or didn't bail out early
> -	 * due to locks contention before we declare that we should give up.
> -	 * But the next retry should use a higher priority if allowed, so
> -	 * we don't just keep bailing out endlessly.
> +	 * If compaction backed due to being deferred, due to
> +	 * contended locks in async mode, or due to scanners meeting
> +	 * after a partial scan, retry with increased priority.
>  	 */
> -	if (compaction_withdrawn(compact_result)) {
> +	if (compact_result == COMPACT_DEFERRED ||
> +	    compact_result == COMPACT_CONTENDED ||
> +	    compact_result == COMPACT_PARTIAL_SKIPPED)
>  		goto check_priority;
> -	}
>  
>  	/*
>  	 * !costly requests are much more important than __GFP_RETRY_MAYFAIL

