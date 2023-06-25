Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5673D374
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFYTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjFYTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:50:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C481B9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9+HzIBQVGlFL8xfvIAScJgtvtZfx8ZXXDTZw1yHSK9M=; b=AGHDvpUN7zqMYZix6hbEiMUtWu
        /eINrp0No4beHCF+ZzOOM4MjwYRYpD9UTEKPGlQB5m0BKiXs1lPSrj/4TvA1e5l21z+oNs7Hh3ETK
        F+DwAWIVPJVLw/b3CyHF30bSdzHSQrQxnPKt2v4EqUSWRF4XMAs4eZt9gBcb1sfMU7CdvVo/fSunQ
        ddAR61Ug5JOXgYWeo4WiVW1AEqQ2FThiab64Gwi6GbcTSLiayt4rxzEQkbq7j4i4IZKi0EphOlWog
        zIF9Ws3ILuSyVGWXN2qQ9bD++8+KWMKWImWPZDAzaxAeSnbzMFPJmsEntdQcbRgb36Nypcbiz1uI+
        7A7KK0dw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDVkP-0010Ph-W0; Sun, 25 Jun 2023 19:50:10 +0000
Date:   Sun, 25 Jun 2023 20:50:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: remove unneeded page state check in
 shake_page()
Message-ID: <ZJiacZIkvIv1P3AK@casper.infradead.org>
References: <20230625113430.2310385-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625113430.2310385-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 07:34:30PM +0800, Miaohe Lin wrote:
> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
> are not shrunk now. This check can be added back when a lightweight range
> based shrinker is available.

On further review, I think you've misunderstood the entire situation
here and no patch should be applied.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
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
> -- 
> 2.27.0
> 
> 
