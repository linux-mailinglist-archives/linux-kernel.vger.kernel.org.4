Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D17372EF90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjFMWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjFMWjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EF129;
        Tue, 13 Jun 2023 15:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753BB619E3;
        Tue, 13 Jun 2023 22:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57074C433C0;
        Tue, 13 Jun 2023 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695950;
        bh=NlxvWeh/iI/fmUa5V59cQyuKBcW8FcsJJPOT32TM0xM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AG9o1FVak06Frs3imw4TZ+ctWP3IXbtyxSJvvijaE9TOVKfTe/zO5VcC1BpdYInIK
         whO+Yw/dkbnFJqfto4qkaW53dmc88a+CN+yTf+XixqvxxdBCLEWFay8OGy5rkzSkkc
         DBEBmu327BO1RFwsk58uEObOAlYT/rxdv4s+HhNxbD5XVvVBD1BnI/xfg5GuTJsuFv
         Xv0AJ+6FmKMFZbBIVQzPD4KCL/nwYDL8aHzq2s7YtYDL0sJT9xsXsMVVOvwJpmUhmm
         ZeLWMNk1wzi2Gjq/ujV8tyLYcapL/frvulIjGKoI9YU8AJxgie/l1/2AvXvD5YAjT5
         TOqZwTYZ1gSzQ==
Message-ID: <d5bd569d-b20e-f9c7-d839-93011dde380b@kernel.org>
Date:   Tue, 13 Jun 2023 17:39:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] nios2: Fix flush_dcache_page() for usage from irq
 context
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20230524152633.203927-1-deller@gmx.de>
 <20230524152633.203927-3-deller@gmx.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230524152633.203927-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

Thanks for the patch. Does it need a Fixes tag?

Dinh

On 5/24/23 10:26, Helge Deller wrote:
> Since at least kernel 6.1, flush_dcache_page() is called with IRQs
> disabled, e.g. from aio_complete().
> 
> But the current implementation for flush_dcache_page() on NIOS2
> unintentionally re-enables IRQs, which may lead to deadlocks.
> 
> Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
> for the flush_dcache_mmap_*lock() macros instead.
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   arch/nios2/include/asm/cacheflush.h | 4 ++++
>   arch/nios2/mm/cacheflush.c          | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
> index d0b71dd71287..a37242662809 100644
> --- a/arch/nios2/include/asm/cacheflush.h
> +++ b/arch/nios2/include/asm/cacheflush.h
> @@ -48,5 +48,9 @@ extern void invalidate_dcache_range(unsigned long start, unsigned long end);
> 
>   #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
>   #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
> +#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
> +		xa_lock_irqsave(&mapping->i_pages, flags)
> +#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
> +		xa_unlock_irqrestore(&mapping->i_pages, flags)
> 
>   #endif /* _ASM_NIOS2_CACHEFLUSH_H */
> diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
> index 6aa9257c3ede..35f3b599187f 100644
> --- a/arch/nios2/mm/cacheflush.c
> +++ b/arch/nios2/mm/cacheflush.c
> @@ -75,11 +75,12 @@ static void flush_aliases(struct address_space *mapping, struct page *page)
>   {
>   	struct mm_struct *mm = current->active_mm;
>   	struct vm_area_struct *mpnt;
> +	unsigned long flags;
>   	pgoff_t pgoff;
> 
>   	pgoff = page->index;
> 
> -	flush_dcache_mmap_lock(mapping);
> +	flush_dcache_mmap_lock_irqsave(mapping, flags);
>   	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
>   		unsigned long offset;
> 
> @@ -92,7 +93,7 @@ static void flush_aliases(struct address_space *mapping, struct page *page)
>   		flush_cache_page(mpnt, mpnt->vm_start + offset,
>   			page_to_pfn(page));
>   	}
> -	flush_dcache_mmap_unlock(mapping);
> +	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
>   }
> 
>   void flush_cache_all(void)
> --
> 2.38.1
> 
