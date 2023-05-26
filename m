Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE6713035
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjEZXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEZXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:03:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB3CE7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:03:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b00f9c4699so9222925ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685142204; x=1687734204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfueZcPSyhu8TUF72Af0Wy3gIHyGRRQDvcS9MbJqSWg=;
        b=FCDdoQ9T8cOC+RkskAGYsQtH7vWGpY6mvdDgDRWXSznwYAzGQeArsJ0h4TD9ZRfuUv
         yVQAVvSxZtaMsIpBbNFo13x2jWrt77QIk1HpIN8gVaJeoRzLNg0THfazoRNrF8whNF+n
         YsssqI+tYp3DwHvFnl0m3ZxArQM+WNitB5eilp++plop6Np0NiEWgJbK4D1OsgORBaHL
         VQh1JlnWwIrJgEyE0wViwe6uw1zNXJWf1dFvsOBkTEGiHnW3yIRdc2wg/GbszCFDfV2r
         lFE/ujraQDyD1rCrJT9l3mNy4RrGBzy1QJ5DT2IWuUvf9uO1BRvMaJt6BwUBU+cVQFIz
         DEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685142204; x=1687734204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfueZcPSyhu8TUF72Af0Wy3gIHyGRRQDvcS9MbJqSWg=;
        b=KGfgFKs7h02ZKG1VDFrL+xRfB1hNl1CpoJI2veroMqk7Ta8uj7rww36lYee1Xbgte+
         KhHHloqcaOkdABOCdNnyMAgR3grWW8K3ULGcJruub0Ufm7Jp/zDADsQQZJ2JqiMmCxAX
         OqjAqvoA47O6saiN4tyhQZCj9ypgbxHNjfE7XQBwHIGy56pxhgVlv9D/2xawicZBHdLr
         4KPDZBK02OY/ACvKKF6Ny7hn+4UFVUTyODnj4Fle1NEVxQQwhuWtL3DKRN+NmrYTgvOy
         IyqoPMV1T38E68WpwpflU8+LfBWX04udQguw/g2NdAU94v4EKRYMD3A5q39K/2YQMAxO
         GWZg==
X-Gm-Message-State: AC+VfDxl+Brh1PIS7Fy+Moo0pU1FhEFMHPFbiSFNXliBeW7cOye3Oiqz
        cA56B33dTxXpojAVehHaB7s=
X-Google-Smtp-Source: ACHHUZ78TNaOLqLX0ixU7AqAVQaXmPIDSeHFWpC76lP5bkJGQVTH2iMH//nx9dUMBRPpUX9H5ep8GA==
X-Received: by 2002:a17:902:b18f:b0:1ad:fc06:d7c0 with SMTP id s15-20020a170902b18f00b001adfc06d7c0mr3813622plr.1.1685142204347;
        Fri, 26 May 2023 16:03:24 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:730f:f44f:d34b:ecf6])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b001a5260a6e6csm3724191pln.206.2023.05.26.16.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 16:03:23 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 26 May 2023 16:03:21 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv4] mm: skip CMA pages when they are not available
Message-ID: <ZHE6uTZOVuYayet2@google.com>
References: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:36:03PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> This patch fixes unproductive reclaiming of CMA pages by skipping them when they
> are not available for current context. It is arise from bellowing OOM issue, which
> caused by large proportion of MIGRATE_CMA pages among free pages.
> 
> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
> ...
> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: update commit message and fix build error when CONFIG_CMA is not set
> v3,v4: update code and comments
> ---
> ---
>  mm/vmscan.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd6637f..20facec 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2193,6 +2193,26 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
>  
>  }
>  
> +#ifdef CONFIG_CMA
> +/*
> + * It is waste of effort to scan and reclaim CMA pages if it is not available
> + * for current allocation context
> + */
> +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> +{
> +	if (!current_is_kswapd() &&

The function is called by isolate_lru_folios which is used by both background
and direct reclaims at the same time. And sc->reclaim_idx below to filter
unproductive reclaim out is used for both cases but why does the cma is considering
only direct reclaim path?


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
> -- 
> 1.9.1
> 
