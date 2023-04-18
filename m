Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D906E6D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjDRUTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDRUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:19:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432093E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25C6635EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A15BC433D2;
        Tue, 18 Apr 2023 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681849154;
        bh=818LBOx4Bv0tTU4R6fF/F8RgUh8+pLOLseVWoDF04Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxSWuETwBuSPN7KR5ksPL4CeNNoZaPHeQX9xFxsbjuYNY5Ibx/tYwBgIBdeXos4eL
         vPl28hymPjO/NUqY86TbVyQWGIB/CmkfSreKYBqT8iNF8khdSUiLIdE8IzNfimQcsq
         0bN1VLPGn4Ep/JH8ndPdU71z/NImVpjwWdQxQrS2dcpLHVBLhQC4etDmwIIhNzJbQ8
         84h3wrJ1IjbkrHmI0PAt62hXXRb9+VpGeAMGdVwz0tEiGK+g1l4rVbpCjKKNsh3cgD
         uyxfXEY+DqY0UpASqoouTKWRLY3yN2FsBocpC8eSkpukcgNyZQqcOc6cJresUq6vMu
         bMp6aAz/r716A==
Date:   Tue, 18 Apr 2023 23:18:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        Vineet Gupta <vgupta@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] [v2] mm: make arch_has_descending_max_zone_pfns() static
Message-ID: <ZD77Mh58MVMVdLrT@kernel.org>
References: <20230415081904.969049-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415081904.969049-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 10:18:20AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang produces a build failure on x86 for some randconfig builds
> after a change that moves around code to mm/mm_init.c:
> 
> Cannot find symbol for section 2: .text.
> mm/mm_init.o: failed
> 
> I have not been able to figure out why this happens, but the __weak
> annotation on arch_has_descending_max_zone_pfns() is the trigger here.
> 
> Removing the weak function in favor of an open-coded Kconfig option
> check avoids the problem and becomes clearer as well as better to
> optimize by the compiler.
> 
> Fixes: 9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
> Cc: llvm@lists.linux.dev
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2: fix logic bug reported-by: kernel test robot <oliver.sang@intel.com>,
> see https://lore.kernel.org/oe-lkp/202304151422.5e4d380b-oliver.sang@intel.com
> ---
>  arch/arc/mm/init.c | 5 -----
>  include/linux/mm.h | 1 -
>  mm/mm_init.c       | 4 ++--
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index ce4e939a7f07..2b89b6c53801 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -74,11 +74,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  		base, TO_MB(size), !in_use ? "Not used":"");
>  }
>  
> -bool arch_has_descending_max_zone_pfns(void)
> -{
> -	return !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
> -}
> -
>  /*
>   * First memory setup routine called from setup_arch()
>   * 1. setup swapper's mm @init_mm
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 63acf4a598fe..75d8adce0aee 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3061,7 +3061,6 @@ extern void setup_per_cpu_pageset(void);
>  extern int min_free_kbytes;
>  extern int watermark_boost_factor;
>  extern int watermark_scale_factor;
> -extern bool arch_has_descending_max_zone_pfns(void);
>  
>  /* nommu.c */
>  extern atomic_long_t mmap_pages_allocated;
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 35302b7bca83..7f7f9c677854 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1754,9 +1754,9 @@ static void __init free_area_init_memoryless_node(int nid)
>   * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
>   * such cases we allow max_zone_pfn sorted in the descending order
>   */
> -bool __weak arch_has_descending_max_zone_pfns(void)
> +static bool arch_has_descending_max_zone_pfns(void)
>  {
> -	return false;
> +	return IS_ENABLED(CONFIG_ARC) && !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
>  }
>  
>  /**
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
