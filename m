Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5056865E815
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAEJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjAEJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:43:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B6479F5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C032AB81A29
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D730C433F1;
        Thu,  5 Jan 2023 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672911831;
        bh=xk1y0PNrseh0gfuyYl1OAwYL8s7WC1qYIROo2bur1vA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSyAQtiNY121quJjcDB1/aD7gGRdHulbZWPvCgwYTntvaK1Y0FQ5mxMcEeA2HwwxX
         f3Brl0T3UZGTjCTLPhU8u+8kidWiXU4OHXJCks6D8GP6oZuIAdpI3M3TxRzUwvv/yH
         41sIQxhNVrDtvo1u7GFm2kZtvS3ZqUebKnZ7Rrk87yQAjEoxO2yJY01eJ7SD8BG1Hh
         eUJMK3HHzySkWOx5V0T0dlAG/aKr01AAefrfW3qUMWHYouRAxVFZuapZJ2k+Ts7bQX
         Zm8gLFwCRZ2vvBpcX6ajRNwtl2hWMhiYXZas8SX2Xt0rsmClFl+sz+P/4Gf309fB+i
         cOmN/7HAxbtbw==
Date:   Thu, 5 Jan 2023 11:43:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Repalce with deferred_pages_enabled()
 wherever applicable
Message-ID: <Y7ab0VbU4gBLHqI7@kernel.org>
References: <20230105082506.241529-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105082506.241529-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:55:06PM +0530, Anshuman Khandual wrote:
> Instead of directly accessing static deferred_pages, replace such instances
> with the helper deferred_pages_enabled(). No functional change is intended.
> 
> Cc; Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> This applies on v6.2-rc2.
> 
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..232d0323047b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4244,7 +4244,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			 * Watermark failed for this zone, but see if we can
>  			 * grow this zone if it contains deferred pages.
>  			 */
> -			if (static_branch_unlikely(&deferred_pages)) {
> +			if (deferred_pages_enabled()) {
>  				if (_deferred_grow_zone(zone, order))
>  					goto try_this_zone;
>  			}
> @@ -4293,7 +4293,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  		} else {
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  			/* Try again if zone has deferred pages */
> -			if (static_branch_unlikely(&deferred_pages)) {
> +			if (deferred_pages_enabled()) {
>  				if (_deferred_grow_zone(zone, order))
>  					goto try_this_zone;
>  			}
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
