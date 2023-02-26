Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26416A3451
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 22:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBZV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 16:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 16:57:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8182710A81
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 13:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0783460C4C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 21:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14353C433EF;
        Sun, 26 Feb 2023 21:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677448655;
        bh=bq5sqXumtr7dE+wB1cCv2agmN87geA04zTmv9SMOTzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sTWY33hbvW7D2ItwwBXT/lfpCkmq/JeiJL0r2nTNIOCcBIosuMAgKzXULvGCuLccL
         DyKYbaGxdkeUPSw6xYcZXQDN6o7hD5RLQII0SJPglEqspgQz+lTrNCA8qdh/JyZf3B
         GWWsFIRMmhkBIt5STP7Gf5bJhUkZtv1YXdLo6leE=
Date:   Sun, 26 Feb 2023 13:57:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Taejoon Song <taejoon.song@lge.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, yjay.kim@lge.com,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/zswap: try to avoid worst-case scenario on same
 element pages
Message-Id: <20230226135734.6ba10ed872bc14802937c7ea@linux-foundation.org>
In-Reply-To: <20230205190036.1730134-1-taejoon.song@lge.com>
References: <20230205190036.1730134-1-taejoon.song@lge.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Feb 2023 04:00:36 +0900 Taejoon Song <taejoon.song@lge.com> wrote:

> The worst-case scenario on finding same element pages is that almost all
> elements are same at the first glance but only last few elements are
> different.
> 
> Since the same element tends to be grouped from the beginning of the
> pages, if we check the first element with the last element before
> looping through all elements, we might have some chances to quickly
> detect non-same element pages.
> 
> 1. Test is done under LG webOS TV (64-bit arch)
> 2. Dump the swap-out pages (~819200 pages)
> 3. Analyze the pages with simple test script which counts the iteration
>    number and measures the speed at off-line
> 
> Under 64-bit arch, the worst iteration count is PAGE_SIZE / 8 bytes =
> 512.  The speed is based on the time to consume page_same_filled()
> function only.  The result, on average, is listed as below:
> 
>                                    Num of Iter    Speed(MB/s)
> Looping-Forward (Orig)                 38            99265
> Looping-Backward                       36           102725
> Last-element-check (This Patch)        33           125072
> 
> The result shows that the average iteration count decreases by 13% and
> the speed increases by 25% with this patch.  This patch does not
> increase the overall time complexity, though.
> 
> I also ran simpler version which uses backward loop. Just looping
> backward also makes some improvement, but less than this patch.

Seems a nice change.

> This patch was already applied to zram on mainline v5.6-rc1:
> https://lkml.org/lkml/2019/12/3/1422

I redid this a little:

A similar change has already been made to zram in 90f82cbfe502 ("zram: try
to avoid worst-case scenario on same element pages").

> ...
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1073,15 +1073,23 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  
>  static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
>  {
> -	unsigned int pos;
>  	unsigned long *page;
> +	unsigned long val;
> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
>  
>  	page = (unsigned long *)ptr;
> -	for (pos = 1; pos < PAGE_SIZE / sizeof(*page); pos++) {
> -		if (page[pos] != page[0])
> +	val = page[0];
> +
> +	if (val != page[last_pos])
> +		return 0;
> +
> +	for (pos = 1; pos < last_pos; pos++) {
> +		if (val != page[pos])
>  			return 0;
>  	}
> -	*value = page[0];
> +
> +	*value = val;
> +
>  	return 1;
>  }

