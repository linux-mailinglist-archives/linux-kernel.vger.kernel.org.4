Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00866BDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAPMWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAPMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:22:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84351C311
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:22:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r30so2883316wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4y5LfL78WILrtujXRb1FwmCXWCEQAtyVf2y66yO4ls=;
        b=gbgrzGoal61+t6N/z+/W7mH3d1FOqHh0KMupT9ZRsOL0zoa1zMYG7139GlDQVp3B20
         2atwALu+o/Cm/xhCcaCJnPT0fkcRvp5weAFVcxSXjA29FRONI5hNGTlN0ji4pKR0pf7k
         BszUrDMuLtEngamytgUisdQCEBhOAYHXANfbwhcPOVvCiFtyQvQJwTw/IKo6yjn8bU8o
         x97Ip0swXjSvmqFFpmAfpf5C7BnyjOClzO1f65ZCjA1QV91/vIvNyroJoKk13fnoILT0
         0G3zVb2x+cXZ0/scLBQNutZa4aneEc5aO79DzQeLP/a/O9Sv6oEb8KwCWOQQ5hL+LcKH
         XnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4y5LfL78WILrtujXRb1FwmCXWCEQAtyVf2y66yO4ls=;
        b=s3Sd6ktwrRgk9MqflePzx5yJxYbWhFIYon+Ppv0uG9E1dc86LLUqKfTjIFVkQztx9S
         QhYa04h8T5cvB5Nzd5WHzoLAbDzdIhlZeW8z7H4zrkZ1E4NhwrygL/VZFPKZZTy6tuGP
         y6XNqdLKKhIkmfTvdN34rk22E0JbCkMrHybmx+AqNvETww+vjvb0yYEBCd0CCe9eUf8g
         e+Kyi4MNGdyW9vGqWowD9lB86B+Nv1SKX1Jl7/48tX2uau+hlw3ehSwD0yWk0ILG17X8
         Gru2gahcZuRMHFJWxI34bd0laQgBR6tmvxW7U/3FGPuO7Nh9vM2iH1s5+OZNfhxoMFmy
         y7Rw==
X-Gm-Message-State: AFqh2kok87iIemXc+0L3Mgy7K1jDUZ9O3nutx/7tiH+ec19whSmrycKu
        ullL+DeJyuE2N+YtaKjw51c=
X-Google-Smtp-Source: AMrXdXvocpZ1IQEaKW/83o0w0+L/+PqKFkAqKgsz4HoyqGIk216czdoHevJBevuSKf6ss998NdFhPA==
X-Received: by 2002:a5d:4ace:0:b0:2bb:dca3:b29 with SMTP id y14-20020a5d4ace000000b002bbdca30b29mr21887657wrs.36.1673871730173;
        Mon, 16 Jan 2023 04:22:10 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm26207750wrq.70.2023.01.16.04.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:22:09 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:22:08 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 1/7] mm/vmalloc.c: add used_map into vmap_block to
 track space of vmap_block
Message-ID: <Y8VBcDkz2s2XVpjK@lucifer>
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

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
