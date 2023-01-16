Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938E66BD01
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjAPLj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAPLjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:39:54 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114F1F4B2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:39:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so42300502lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JggCD+IgH4kg5EYbvhAMqXcJgvTK6zOEGFmEBxsdv90=;
        b=ZIvcWSLEiMNyb/a5eDKtn67l7WZ9GeHXI7gTjLSrUUKCnQbu92kERrSQm3wK4TU9DJ
         tOnUxd1xgppr9Z5oVVBvNmN+CTDyNQnsrBOKFjnqgVYLrJpo3FyL6eijBlB1m8qXngBi
         6RoXWMf01yre7LrVn4pywJ1Ll7OYlrvc9duYFcEbLTXB4xGLzziVszJ27EZ9cgThp/ar
         2voEMh3/hN/mBmWllxqIyhMHNLHTAl2lGEjtxip2Em4/dOZ8mS3c0hhBtO8OeD3+KKn7
         0pc2jrUAOQwkI38VcbzGhqdjQ39rPlc8JLY/tEVbBQNHMjrsFqDsCyD2rNoSNs/pm3QH
         Ckeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JggCD+IgH4kg5EYbvhAMqXcJgvTK6zOEGFmEBxsdv90=;
        b=5prkQkYf/cxhIbczkOPAe6DAscflEcZBMZO9yP9EIy1lMOo34TN7thleqRWHPirFH4
         rNRDHGlzlgZpWp2l8vAzyPjeGe+vedL9FPaI1h6K9GT6AWLjNnl3lnMiuPOtdK4CXkJJ
         sQiInbWpnJ8UqniSOHPBcTRR/WjGDkQhNbOi1VVnAPa9ZpVH8Epg9k6ApykUI/4K9CAy
         tfEexPxwWmWAKZjIXpUK2IA6s53s7a3NBygypx79Nom3rOLISpNYq+it1LL73j1/s9DN
         rOG8InUQE7yqun3RylJQiqaynL4WzHdS8xta9jMiBtEoBVg54/gpnRk6XytrKzK0WsA/
         PkUg==
X-Gm-Message-State: AFqh2krCrvrDEAOpEkJdj+SiwcCYwKEHVPQ4Tr1/E5YmP3nlT5724D0H
        tJAwmt3mCX718Kke74KIMhk=
X-Google-Smtp-Source: AMrXdXsCX0lgfeYQwVQNTlVoKTkqRg5XCY27bkNgu8CbGYSSpGFuiO6uVQDjcjttbO5KlhA1yVbd5A==
X-Received: by 2002:a05:6512:2a89:b0:4b9:f5e5:8fbd with SMTP id dt9-20020a0565122a8900b004b9f5e58fbdmr24277599lfb.52.1673869189537;
        Mon, 16 Jan 2023 03:39:49 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b004cb02ed464esm4960444lfo.196.2023.01.16.03.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:39:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 12:39:46 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 1/7] mm/vmalloc.c: add used_map into vmap_block to
 track space of vmap_block
Message-ID: <Y8U3glCIflbxUHWl@pc636>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-2-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:15AM +0800, Baoquan He wrote:
> In one vmap_block area, there could be three types of regions: region
> being used which is allocated through vb_alloc(), dirty region which
> is freed via vb_free() and free region. Among them, only used region
> has available data. While there's no way to track those used regions
> currently.
> 
> Here, add bitmap field used_map into vmap_block, and set/clear it during
> allocation or freeing regions of vmap_block area.
> 
> This is a preparatoin for later use.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 428e0bee5c9c..d6ff058ef4d0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1922,6 +1922,7 @@ struct vmap_block {
>  	spinlock_t lock;
>  	struct vmap_area *va;
>  	unsigned long free, dirty;
> +	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
>  	unsigned long dirty_min, dirty_max; /*< dirty range */
>  	struct list_head free_list;
>  	struct rcu_head rcu_head;
> @@ -1998,10 +1999,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	vb->va = va;
>  	/* At least something should be left free */
>  	BUG_ON(VMAP_BBMAP_BITS <= (1UL << order));
> +	bitmap_zero(vb->used_map, VMAP_BBMAP_BITS);
>  	vb->free = VMAP_BBMAP_BITS - (1UL << order);
>  	vb->dirty = 0;
>  	vb->dirty_min = VMAP_BBMAP_BITS;
>  	vb->dirty_max = 0;
> +	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
>  
>  	vb_idx = addr_to_vb_idx(va->va_start);
> @@ -2111,6 +2114,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
>  		pages_off = VMAP_BBMAP_BITS - vb->free;
>  		vaddr = vmap_block_vaddr(vb->va->va_start, pages_off);
>  		vb->free -= 1UL << order;
> +		bitmap_set(vb->used_map, pages_off, (1UL << order));
>  		if (vb->free == 0) {
>  			spin_lock(&vbq->lock);
>  			list_del_rcu(&vb->free_list);
> @@ -2144,6 +2148,9 @@ static void vb_free(unsigned long addr, unsigned long size)
>  	order = get_order(size);
>  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
>  	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
> +	spin_lock(&vb->lock);
> +	bitmap_clear(vb->used_map, offset, (1UL << order));
> +	spin_unlock(&vb->lock);
>  
>  	vunmap_range_noflush(addr, addr + size);
>  
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
