Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6664228D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiLEFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiLEFRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:17:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857664F4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:17:22 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8EE761FE23;
        Mon,  5 Dec 2022 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670217439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkNfxgC2YLQFMqZWOCiI4CofWeHNYOS5cHbeZCuOgxA=;
        b=bxfN2QEfHcDB6jcvA6Wx/2dTWKWUlUA99Yw2I9nfIkI7mRWEcBdgORsndIgqnnhAs56kji
        4zphG/heMjBtYcr/sZ/cnEsw68x2mD/+KYtMJtvuHRnZKUPsg6dj/nRs/fQJcxCTIHzCGZ
        kWeIOi9qLo9mhPEN4ZlA//hrulgDjfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670217439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkNfxgC2YLQFMqZWOCiI4CofWeHNYOS5cHbeZCuOgxA=;
        b=oxYT2yGr53qaMbC4k+gOaMLS8YL+8v1TTxRUugf7fKtuzlV8Ng+dby43xVhmTvcFzFAyYU
        SKsGIm5EAfLFRRCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BF90D13411;
        Mon,  5 Dec 2022 05:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id TYJxHNx+jWO4awAAGKfGzw
        (envelope-from <neilb@suse.de>); Mon, 05 Dec 2022 05:17:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Linux-MM" <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>
Subject: Re: [PATCH 3/6] mm/page_alloc: Explicitly record high-order atomic
 allocations in alloc_flags
In-reply-to: <20221129151701.23261-4-mgorman@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>,
 <20221129151701.23261-4-mgorman@techsingularity.net>
Date:   Mon, 05 Dec 2022 16:17:12 +1100
Message-id: <167021743246.8267.14900064704332224542@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mel,
 thanks a lot for doing this!
 I tried reviewing it but "HIGHATOMIC" is new to me and I quickly got
 lost :-(
 Maybe one day I'll work it out - now that several names are more
 meaningful, it will likely be easier.

Thanks,
NeilBrown

On Wed, 30 Nov 2022, Mel Gorman wrote:
> A high-order ALLOC_HARDER allocation is assumed to be atomic. While that
> is accurate, it changes later in the series. In preparation, explicitly
> record high-order atomic allocations in gfp_to_alloc_flags().
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/internal.h   |  1 +
>  mm/page_alloc.c | 19 +++++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/internal.h b/mm/internal.h
> index d503e57a57a1..9a9d9b5ee87f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -754,6 +754,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone =
*zone,
>  #else
>  #define ALLOC_NOFRAGMENT	  0x0
>  #endif
> +#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAI=
M set */
> =20
>  enum ttu_flags;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index da746e9eb2cf..e2b65767dda0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3710,7 +3710,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zon=
e, struct zone *zone,
>  		 * reserved for high-order atomic allocation, so order-0
>  		 * request should skip it.
>  		 */
> -		if (order > 0 && alloc_flags & ALLOC_HARDER)
> +		if (alloc_flags & ALLOC_HIGHATOMIC)
>  			page =3D __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  		if (!page) {
>  			page =3D __rmqueue(zone, order, migratetype, alloc_flags);
> @@ -4028,8 +4028,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned in=
t order, unsigned long mark,
>  			return true;
>  		}
>  #endif
> -		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
> +		if ((alloc_flags & ALLOC_HIGHATOMIC) &&
> +		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
>  			return true;
> +		}
>  	}
>  	return false;
>  }
> @@ -4291,7 +4293,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int o=
rder, int alloc_flags,
>  			 * If this is a high-order atomic allocation then check
>  			 * if the pageblock should be reserved for the future
>  			 */
> -			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
> +			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
>  				reserve_highatomic_pageblock(page, zone, order);
> =20
>  			return page;
> @@ -4818,7 +4820,7 @@ static void wake_all_kswapds(unsigned int order, gfp_=
t gfp_mask,
>  }
> =20
>  static inline unsigned int
> -gfp_to_alloc_flags(gfp_t gfp_mask)
> +gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  {
>  	unsigned int alloc_flags =3D ALLOC_WMARK_MIN | ALLOC_CPUSET;
> =20
> @@ -4844,8 +4846,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
>  		 * if it can't schedule.
>  		 */
> -		if (!(gfp_mask & __GFP_NOMEMALLOC))
> +		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>  			alloc_flags |=3D ALLOC_HARDER;
> +
> +			if (order > 0)
> +				alloc_flags |=3D ALLOC_HIGHATOMIC;
> +		}
> +
>  		/*
>  		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
>  		 * comment for __cpuset_node_allowed().
> @@ -5053,7 +5060,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int o=
rder,
>  	 * kswapd needs to be woken up, and to avoid the cost of setting up
>  	 * alloc_flags precisely. So we do that now.
>  	 */
> -	alloc_flags =3D gfp_to_alloc_flags(gfp_mask);
> +	alloc_flags =3D gfp_to_alloc_flags(gfp_mask, order);
> =20
>  	/*
>  	 * We need to recalculate the starting point for the zonelist iterator
> --=20
> 2.35.3
>=20
>=20
