Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE668D52E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjBGLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBGLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:09:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64339CD2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:09:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF42F6131F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2695C433D2;
        Tue,  7 Feb 2023 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675768146;
        bh=mvrKzmSVoOCwU53QtQIouMJvK9TPygmAN88fteUFBPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fs4G9i1i81rN0OYBH+EGKBpThz7iyeTa8jodg2hwsHaQo7kNO9FbvlCW9ah07VFpR
         6qb6V5yKTYaTUWhqT8EI1uppyRCwHTcUmDBiVYVid713r/+ekzt6Ul16wzd9I/5dkk
         RLOD3e42ghPRwi25pSKkpMvYWGkRX0il4+6Xgm60ow+zJGISagQdUgnaM3jtf1b+VT
         atYlPtQwyz1Soxs3FeQ8NtCow4CYdeBjjDhWzRicLEGJEmt5uAET8kAWezODq0XzWA
         n+RHiH/nEktfRHzAbJaf3EnmBb3xOj7tt8YGN/ZLmY3oPiag88XChvOI+0ssTBKosM
         F/uD1iu65305g==
Date:   Tue, 7 Feb 2023 13:08:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Aaron Thompson <dev@aaront.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm: Always release pages to the buddy allocator
 in memblock_free_late()."
Message-ID: <Y+IxRqcxMrH7r7iw@kernel.org>
References: <20230207082151.1303-1-dev@aaront.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207082151.1303-1-dev@aaront.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:21:51AM +0000, Aaron Thompson wrote:
> This reverts commit 115d9d77bb0f9152c60b6e8646369fa7f6167593.
> 
> The pages being freed by memblock_free_late() have already been
> initialized, but if they are in the deferred init range,
> __free_one_page() might access nearby uninitialized pages when trying to
> coalesce buddies. This can, for example, trigger this BUG:
> 
>   BUG: unable to handle page fault for address: ffffe964c02580c8
>   RIP: 0010:__list_del_entry_valid+0x3f/0x70
>    <TASK>
>    __free_one_page+0x139/0x410
>    __free_pages_ok+0x21d/0x450
>    memblock_free_late+0x8c/0xb9
>    efi_free_boot_services+0x16b/0x25c
>    efi_enter_virtual_mode+0x403/0x446
>    start_kernel+0x678/0x714
>    secondary_startup_64_no_verify+0xd2/0xdb
>    </TASK>
> 
> A proper fix will be more involved so revert this change for the time
> being.
> 
> Fixes: 115d9d77bb0f ("mm: Always release pages to the buddy allocator in memblock_free_late().")
> Signed-off-by: Aaron Thompson <dev@aaront.org>
> ---
>  mm/memblock.c                     | 8 +-------
>  tools/testing/memblock/internal.h | 4 ----
>  2 files changed, 1 insertion(+), 11 deletions(-)

Applied, thanks!
 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 685e30e6d27c..d036c7861310 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1640,13 +1640,7 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>  	end = PFN_DOWN(base + size);
>  
>  	for (; cursor < end; cursor++) {
> -		/*
> -		 * Reserved pages are always initialized by the end of
> -		 * memblock_free_all() (by memmap_init() and, if deferred
> -		 * initialization is enabled, memmap_init_reserved_pages()), so
> -		 * these pages can be released directly to the buddy allocator.
> -		 */
> -		__free_pages_core(pfn_to_page(cursor), 0);
> +		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
>  		totalram_pages_inc();
>  	}
>  }
> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
> index 85973e55489e..fdb7f5db7308 100644
> --- a/tools/testing/memblock/internal.h
> +++ b/tools/testing/memblock/internal.h
> @@ -15,10 +15,6 @@ bool mirrored_kernelcore = false;
>  
>  struct page {};
>  
> -void __free_pages_core(struct page *page, unsigned int order)
> -{
> -}
> -
>  void memblock_free_pages(struct page *page, unsigned long pfn,
>  			 unsigned int order)
>  {
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
