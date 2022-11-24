Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F203637117
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiKXDc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXDcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:32:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2C1C412
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:32:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so342756pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BBzplv4usyuEIMVAm0qSmS4cJi8RTr3YYpBQBevHpg=;
        b=Cj7WMrasPvkvyAb/qeIh9ngQl6+RCuho//7eFZusoZVJ+Dg6U4nya27EHYYL9dHEOt
         wp3QavtAJPimFmg+vgztmtcV0c0QobHpI/wSh5hI6++bBO3RJwFp6wEXjjjBh+MaOGZa
         p41Qf5Kc/CgTRiL31j8YucyoUcuQminmXTDRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BBzplv4usyuEIMVAm0qSmS4cJi8RTr3YYpBQBevHpg=;
        b=gLkAgmwUiwsRiKwcYu1vbIV+BdD+BabO6dg3npRj3qNOOS40yvzRv4B0L8YPbHewOI
         UgmgMKzs6tLdRAEaB6ymJovKpDxpFuXUnpqqHpZ3WuHklgdxjPAtB/n0D0eneX0T8pnS
         mJC1yRwmwMGELhWQBL2rzy0U1zcRjbY9O6FsrcYgQGPDxSFGd5rOZuoAbQ8A7grRwnwV
         PFur3sL9i0ly/uZ+QyAE+SF6ATKMUiA54UEnkfhKFUe6V2jPEDnKwHGlbFoaA6jdRIu/
         7PZL1UJLLAG3WlzK5cquPHqoDSd2uCsdklZ2FxixClwZkz9xxMy43ZBxD2UnA7EJkvJj
         rAnQ==
X-Gm-Message-State: ANoB5pkXXXToY7ylHZxeDA+afAkots7vXexS38nu+0tz0QvU5+9KevCf
        AXXbueMkVD0DGbj2vSifqv8hdg==
X-Google-Smtp-Source: AA0mqf4fe4gZPOdvRZh5wCh+8bjwt8ps/uLJ8zufhsVLYPfKWMDwdrHoEcEuOPcAieWUxRD0uL3SqQ==
X-Received: by 2002:a17:903:264c:b0:186:6fde:e9f5 with SMTP id je12-20020a170903264c00b001866fdee9f5mr17083278plb.139.1669260770615;
        Wed, 23 Nov 2022 19:32:50 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:438d:8b02:662d:50b3])
        by smtp.gmail.com with ESMTPSA id f11-20020a65550b000000b00460c67afbd5sm122401pgr.7.2022.11.23.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:32:50 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:32:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
Message-ID: <Y37l3Xxb172q632L@google.com>
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
 <Y3w/DFTAypX7L2mp@cmpxchg.org>
 <Y3xCTr6ikbtcUr/y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xCTr6ikbtcUr/y@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/22 12:30), Sergey Senozhatsky wrote:
> zswap_frontswap_load() should be called from preemptible
> context (we even call mutex_lock() there) and it does not
> look like we need to do GFP_ATOMIC allocaion for temp
> buffer. The same applies to zswap_writeback_entry().
> 
> Use GFP_KERNEL for temporary buffer allocation in both
> cases.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---

Folks, how do we want to proceed with this? One of the hunks here
conflicts with https://lore.kernel.org/lkml/20221119001536.2086599-2-nphamcs@gmail.com/

Do we want to remove conflicting hunk from "[PATCH 1/6] zswap: fix writeback
lock ordering for zsmalloc" and pick this patch up?

> diff --git a/mm/zpool.c b/mm/zpool.c
> index 68facc193496..f46c0d5e766c 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -387,6 +387,13 @@ bool zpool_evictable(struct zpool *zpool)
>   * zpool_can_sleep_mapped - Test if zpool can sleep when do mapped.
>   * @zpool:	The zpool to test
>   *
> + * Some allocators enter non-preemptible context in ->map() callback (e.g.
> + * disable pagefaults) and exit that context in ->unmap(), which limits what
> + * we can do with the mapped object. For instance, we cannot wait for
> + * asynchronous crypto API to decompress such an object or take mutexes
> + * since those will call into the scheduler. This function tells us whether
> + * we use such an allocator.
> + *
>   * Returns: true if zpool can sleep; false otherwise.
>   */
>  bool zpool_can_sleep_mapped(struct zpool *zpool)
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2d48fd59cc7a..3019f0bde194 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -958,7 +958,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  	};
>  
>  	if (!zpool_can_sleep_mapped(pool)) {
> -		tmp = kmalloc(PAGE_SIZE, GFP_ATOMIC);
> +		tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  		if (!tmp)
>  			return -ENOMEM;
>  	}
> @@ -1311,7 +1311,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	}
>  
>  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> -		tmp = kmalloc(entry->length, GFP_ATOMIC);
> +		tmp = kmalloc(entry->length, GFP_KERNEL);
>  		if (!tmp) {
>  			ret = -ENOMEM;
>  			goto freeentry;
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 
