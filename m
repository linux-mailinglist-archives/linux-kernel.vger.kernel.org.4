Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0B636453
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiKWPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiKWPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:45:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6CB193F0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6eE8Qd8mDLx/Y2cYwBF7qMn+RB+S43WwvbsxuHk7jug=; b=imMVHw6Nv6x+ZbwXlZ2FtbyM8z
        9d1b/hnNt1/QMW4GgWyBgJ+jhWZ8VZGH3JRm0y59UZDWcjG0FV+7PNHibFOHcQM5MAW6sSgcAugAx
        vN9C8mCgNWXFFXeNOGVaBUVZyk1S4WL1ZIqMWIil8IB7fSWTtHIGWZyvps1XDLB+WiE6gI18ql7KD
        4+vGPhPeDhbf25iSgRiPLEUxerz2FlVjNnF8i6vN2/ft6eIYtdgbIcmXdS4kd6TsN+iZMYiGvfUHe
        FSQ1y7hjXlg/++rof3FluywZsuSJVvtlzpyNFbZ3FeudRpNXQgVg9nb9D9HNe31r0r0QZ/Kt0qB94
        +Dn8TcCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxrvt-007m3D-VQ; Wed, 23 Nov 2022 15:45:06 +0000
Date:   Wed, 23 Nov 2022 15:45:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     wonder_rock@126.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/page_alloc: merge two get_pfnblock_migratetype()
 into one
Message-ID: <Y35AAV2H4xiPZYed@casper.infradead.org>
References: <20221123134043.33896-1-wonder_rock@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123134043.33896-1-wonder_rock@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:40:43PM +0800, wonder_rock@126.com wrote:
> From: Deyan Wang <wonder_rock@126.com>
> 
> It is safe to get_pfnblock_migratetype() in critical section,
> so just call get_pfnblock_migratetype() once.

No, you don't understand.  zone->lock is HOT and we want to avoid
calling get_pfnblock_migratetype() under the lock, if we can avoid it.
Which we usually can.

> Signed-off-by: Deyan Wang <wonder_rock@126.com>
> ---
>  mm/page_alloc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6652df1f5cc8..c7ba9d65d1c0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1704,13 +1704,8 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>  	if (!free_pages_prepare(page, order, true, fpi_flags))
>  		return;
>  
> -	migratetype = get_pfnblock_migratetype(page, pfn);
> -
>  	spin_lock_irqsave(&zone->lock, flags);
> -	if (unlikely(has_isolate_pageblock(zone) ||
> -		is_migrate_isolate(migratetype))) {
> -		migratetype = get_pfnblock_migratetype(page, pfn);
> -	}
> +	migratetype = get_pfnblock_migratetype(page, pfn);
>  	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
> -- 
> 2.25.1
> 
> 
