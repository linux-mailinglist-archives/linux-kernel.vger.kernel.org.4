Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1873D572
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFZA6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFZA6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 20:58:11 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 17:58:03 PDT
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B605E66
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:58:03 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:52:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687740749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoYCAJIdfBs09Y+PhvXcvipTrQRMfcPWXBW4aaEX1D4=;
        b=tfsfO6MiSP9RvTHVaGudEvTI07o3baUhBqbh56J/KDWzBNu8X55HX4j6b6R2AKA75oSBP1
        +Q8+F4nXxkhGnX2O3vUKT6LetaF3iHmrMV1MgbjjjBlPkIvYq+fRS324yHW97j5W79iVDr
        3YrbLWuFJvT+GZV8vkAig0AtLEXGL/8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: memory-failure: remove unneeded page state check in
 shake_page()
Message-ID: <20230626005221.GA353339@ik1-406-35019.vs.sakura.ne.jp>
References: <20230625113430.2310385-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230625113430.2310385-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 07:34:30PM +0800, Miaohe Lin wrote:
> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
> are not shrunk now. This check can be added back when a lightweight range
> based shrinker is available.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

This looks to me a good cleanup because the result of
"if (PageLRU(p) || is_free_buddy_page(p))" check is not used, so the check
itself is unneeded.

> ---
>  mm/memory-failure.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5b663eca1f29..92f951df3e87 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -373,11 +373,10 @@ void shake_page(struct page *p)
>  	if (PageHuge(p))
>  		return;
>  
> -	if (!PageSlab(p)) {
> -		lru_add_drain_all();
> -		if (PageLRU(p) || is_free_buddy_page(p))
> -			return;
> -	}
> +	if (PageSlab(p))
> +		return;
> +
> +	lru_add_drain_all();
>  
>  	/*
>  	 * TODO: Could shrink slab caches here if a lightweight range-based

I think that this TODO comment can be put together with "if (PageSlab)" block.

Thanks,
Naoya Horiguchi
