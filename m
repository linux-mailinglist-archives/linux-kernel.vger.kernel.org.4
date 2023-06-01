Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E4871EF30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjFAQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114AB128
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BCE6470E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06630C433D2;
        Thu,  1 Jun 2023 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685637384;
        bh=droKvnpJtGwDMk3s7ygRzUTVgIsGYvJ6043PaQ6GXZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bn447S6Xe6mwY6EV97eRrL2cw8eRHSFmVBH4/dBgMkV0UAYMSVOrSXsASTC6ZQhWV
         /bFOYMlLNq5TXHucDvDxZQt+ho2OaKY1hI/hbpTFvTSPFg6DwLaFVgy1KH1/gWmOGw
         K5V2QHuA0A6Kk7/9LhzVWRYVu6Wmh8WBeFs+xlcDV5iB/OTg/Xuu0slQ7ogIuA5QZd
         Q9270cvUClV1yv0DxO9Zpjb9KOwirV5zbZnLBEGoXEgzOBGXS3XOSOXc5u3Z2R/Vm7
         Fjnc4QcMXmFf1EalgHXsPuuOw8LAfITwqmq8zSyp+z/nSUAD2dzF7HjLf+3MWJRxX6
         xvAPg5xtVsbqw==
Date:   Thu, 1 Jun 2023 19:35:56 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/mm_init.c: do not calculate memmap and reserved
 pages for empty zone
Message-ID: <20230601163556.GF395338@kernel.org>
References: <20230601063536.26882-2-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601063536.26882-2-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:35:36AM +0000, Haifeng Xu wrote:
> For empty zone, it's unnecessary to account for pages used by memmap.
> Also, the pages reserved in dma zone can be ignored.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/mm_init.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 232efac9a929..b82718d596c3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1543,6 +1543,13 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		size = zone->spanned_pages;
>  		freesize = zone->present_pages;
>  
> +		if (!size) {
> +			nr_kernel_pages += 0;
> +			nr_all_pages += 0;

Please drop these, they are nops anyway.

> +			zone_init_internals(zone, j, nid, 0);
> +			continue;
> +		}
> +
>  		/*
>  		 * Adjust freesize so that it accounts for how much memory
>  		 * is used by this zone for memmap. This affects the watermark
> @@ -1579,10 +1586,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		 * And all highmem pages will be managed by the buddy system.
>  		 */
>  		zone_init_internals(zone, j, nid, freesize);
> -
> -		if (!size)
> -			continue;
> -
>  		setup_usemap(zone);
>  		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
>  	}
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
