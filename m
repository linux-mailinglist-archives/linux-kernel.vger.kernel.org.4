Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3587117CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjEYUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjEYUDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:03:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8A95
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wpxyri5QnO4o8eJL1iBJ+bBGxFcvRJYujLYE4FKIc/s=; b=pYASl3Q22Il5PUMRGkdedUxu5F
        ZHbPfqMCSnP7X3ZZQW7YCt/M5m0CXxSopDVUfZ+F48jFfRxVEeeFxcULusJntEv1nuFvwThDW9jHe
        TMz6V8uolnc/aSTX4YDYeUe0eKX4+IvqSDnnHfkJn4CsE7sFZF3ZYFTNxU4j3am8Mos6uS1EL4tU0
        J8CXfIij2xSc9C1O5JpeiNaQVTXjTuqyIpGDEqKlEC0Ug8ua1N3mE6BS3iejyFxQplqz2I01kDC67
        qcOTUHGsPpRutvJzj/22Q3xdanbaFkfZI1AlYUMNqrkIKSnU59Rkn8BP+nKHWS7TdetBrnV6MsijK
        tNXzy+Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2HBK-00Chf7-0Q; Thu, 25 May 2023 20:03:30 +0000
Date:   Thu, 25 May 2023 21:03:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv4] mm: skip CMA pages when they are not available
Message-ID: <ZG+/EW9NzGsAcGfF@casper.infradead.org>
References: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:36:03PM +0800, zhaoyang.huang wrote:
> +#ifdef CONFIG_CMA
> +/*
> + * It is waste of effort to scan and reclaim CMA pages if it is not available
> + * for current allocation context
> + */
> +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> +{
> +	if (!current_is_kswapd() &&
> +			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
> +			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA)
> +		return true;
> +	return false;
> +}
> +#else
> +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
>   *
> @@ -2239,7 +2259,8 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx) {
> +		if (folio_zonenum(folio) > sc->reclaim_idx ||
> +				skip_cma(folio, sc)) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
>  			goto move;

I have no idea if what this patch is trying to accomplish is correct,
but I no longer object to how it is doing it.
