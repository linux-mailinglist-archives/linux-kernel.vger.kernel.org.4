Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7316566BDBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjAPMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjAPMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:23:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9E1C311
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:23:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id h12-20020a05600c314c00b003da50afcb33so3535120wmo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzVbLgeUpcjwkukSky12/coeX/uL5XuAwdrAE7qmZlI=;
        b=JHarUTNJDlQ3rXhXR7YfKt2bN91AsVR7viB76eiTNokKADDPvI6axpXlvWmGNfWs/D
         hi3Iy829cKym9ysHJHdyKN2u6a4lpNxeB+1BDS+ecMjS6mahD8XgToq3rZNQXO33bHoo
         Od3s8T/nWXdF8zRU+KF2P/WC1ExZw15C+wOFz/UHT1HwMc84Duv1qIisK8blfWEqHVp3
         zCJX/Gb80z8A4Yh+q6o682w+cbydUbhGBRnaZuEb8TgGZAzNmm8NXMWvE7+I4qKg0lwM
         aJBx9zAinr5Usiw+jjmgSqBGtT30xDD57inqeoa6+PD7lask22KHBVPT1M5ruyYWLgDO
         ftNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzVbLgeUpcjwkukSky12/coeX/uL5XuAwdrAE7qmZlI=;
        b=PkBeBCbAwUsocxYFc9S0Ya6IETHhGwDDd8mnkcaRfnrKDJgDClGAlUTA+FVvANBgAL
         FHZsIdvHpQinNRL7TjkYtgOkY02bS+GH5r4JwGM1L1obC6rH4aztu8Xx6R+mK6IB37+a
         k3dnbn7kNqzBKlwjMGMem6StsYru2KPMkbhRoL9Hlo8YCexJcBFiUa8LIp5Qbt53r8Fh
         7IyOS44JL7OxHUAWaV0RApZOae+EM5ZfoxkFgeIL0b4HTJvCz+VdEy642BdcGqh3Ia3u
         H0E3KWZhYXlN2fyPGZNYfgDWNZ6qhwSsepqEiRcKC6y3e8DwWXzn46uOiqQZo4T2Ex6a
         rKeg==
X-Gm-Message-State: AFqh2ko1aBpcfa+Wh4gbekFxIrufsxbiKrnIJYHLGgpaWXCSAaZQ7X0c
        Was3koDwMFm8pkFtWRQr0ws=
X-Google-Smtp-Source: AMrXdXuazm1a6oi2az1b1VRuoyTd7u0YQdTZqoESLmnMfGqtgyTdQnkLRySiWBaVqtgkfWCORQmgHw==
X-Received: by 2002:a05:600c:540c:b0:3d9:922b:b148 with SMTP id he12-20020a05600c540c00b003d9922bb148mr57932980wmb.27.1673871786402;
        Mon, 16 Jan 2023 04:23:06 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003b4fe03c881sm12799096wmi.48.2023.01.16.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:23:05 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:23:04 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y8VBqEzlvyDgxj83@lucifer>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-3-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:16AM +0800, Baoquan He wrote:
> Through vmalloc API, a virtual kernel area is reserved for physical
> address mapping. And vmap_area is used to track them, while vm_struct
> is allocated to associate with the vmap_area to store more information
> and passed out.
>
> However, area reserved via vm_map_ram() is an exception. It doesn't have
> vm_struct to associate with vmap_area. And we can't recognize the
> vmap_area with '->vm == NULL' as a vm_map_ram() area because the normal
> freeing path will set va->vm = NULL before unmapping, please see
> function remove_vm_area().
>
> Meanwhile, there are two kinds of handling for vm_map_ram area. One is
> the whole vmap_area being reserved and mapped at one time through
> vm_map_area() interface; the other is the whole vmap_area with
> VMAP_BLOCK_SIZE size being reserved, while mapped into split regions
> with smaller size via vb_alloc().
>
> To mark the area reserved through vm_map_ram(), add flags field into
> struct vmap_area. Bit 0 indicates this is vm_map_ram area created
> through vm_map_ram() interface, while bit 1 marks out the type of
> vm_map_ram area which makes use of vmap_block to manage split regions
> via vb_alloc/free().
>
> This is a preparatoin for later use.
>

Small typo here :)

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/vmalloc.h |  1 +
>  mm/vmalloc.c            | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..69250efa03d1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -76,6 +76,7 @@ struct vmap_area {
>  		unsigned long subtree_max_size; /* in "free" tree */
>  		struct vm_struct *vm;           /* in "busy" tree */
>  	};
> +	unsigned long flags; /* mark type of vm_map_ram area */
>  };
>
>  /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d6ff058ef4d0..ab4825050b5c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1589,7 +1589,8 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
>  static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
> -				int node, gfp_t gfp_mask)
> +				int node, gfp_t gfp_mask,
> +				unsigned long va_flags)
>  {
>  	struct vmap_area *va;
>  	unsigned long freed;
> @@ -1635,6 +1636,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_start = addr;
>  	va->va_end = addr + size;
>  	va->vm = NULL;
> +	va->flags = va_flags;
>
>  	spin_lock(&vmap_area_lock);
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> @@ -1913,6 +1915,10 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>
>  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
>
> +#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
> +#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> +#define VMAP_FLAGS_MASK		0x3
> +
>  struct vmap_block_queue {
>  	spinlock_t lock;
>  	struct list_head free;
> @@ -1988,7 +1994,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
> -					node, gfp_mask);
> +					node, gfp_mask,
> +					VMAP_RAM|VMAP_BLOCK);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2297,7 +2304,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  	} else {
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
> -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> +				VMALLOC_START, VMALLOC_END,
> +				node, GFP_KERNEL, VMAP_RAM);
>  		if (IS_ERR(va))
>  			return NULL;
>
> @@ -2537,7 +2545,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
> --
> 2.34.1
>

Other than that typo,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
