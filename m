Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4A6C50B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCVQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCVQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:29:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE65F23D;
        Wed, 22 Mar 2023 09:29:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF2AE20FDA;
        Wed, 22 Mar 2023 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679502518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6vAAV/wj63OsAjSy7yFyFAgl0fs9PXhYMFIC+OAOOU=;
        b=JnLdPGHlbmbjpxXYPOHBcnibyd88EewIBifavp5c89MBEg9k4Ahs6V7MI2REZzNvpQjU/5
        Y9OuEgKha5fA/8ZJ38eHAmxqKHaePsSNYBrHjIB8AswYMhnEwnctqXSdEdJQciVwg8/td5
        RxW5HxQWg8UPzUbyy9me1RXCxxMpDv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679502518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6vAAV/wj63OsAjSy7yFyFAgl0fs9PXhYMFIC+OAOOU=;
        b=mShwyCECdMwN1COY/7ZAyv+JDHin+aW447qLgGBst3HdqC9p5XtPFlo0vEwqAOT8N5JkLo
        eUDMEoVD06/V+YBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C242B13416;
        Wed, 22 Mar 2023 16:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oam1LrYsG2TFbwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 16:28:38 +0000
Message-ID: <3ad34178-25f1-b076-e833-2f277ec38df8@suse.cz>
Date:   Wed, 22 Mar 2023 17:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/14] mm: move init_mem_debugging_and_hardening() to
 mm/mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-10-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321170513.2401534-10-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 18:05, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> init_mem_debugging_and_hardening() is only called from mm_core_init().
> 
> Move it close to the caller, make it static and rename it to
> mem_debugging_and_hardening_init() for consistency with surrounding
> convention.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h |  1 -
>  mm/internal.h      |  8 ++++
>  mm/mm_init.c       | 91 +++++++++++++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c    | 95 ----------------------------------------------
>  4 files changed, 98 insertions(+), 97 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c3c67d8bc833..2fecabb1a328 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3394,7 +3394,6 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
>  				   unsigned long address, unsigned long size,
>  				   pte_fn_t fn, void *data);
>  
> -extern void __init init_mem_debugging_and_hardening(void);
>  #ifdef CONFIG_PAGE_POISONING
>  extern void __kernel_poison_pages(struct page *page, int numpages);
>  extern void __kernel_unpoison_pages(struct page *page, int numpages);
> diff --git a/mm/internal.h b/mm/internal.h
> index 2a925de49393..4750e3a7fd0d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -204,6 +204,14 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>  
>  extern char * const zone_names[MAX_NR_ZONES];
>  
> +/* perform sanity checks on struct pages being allocated or freed */
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
> +
> +static inline bool is_check_pages_enabled(void)
> +{
> +	return static_branch_unlikely(&check_pages_enabled);
> +}
> +
>  /*
>   * Structure for holding the mostly immutable allocation parameters passed
>   * between functions involved in allocations, including the alloc_pages*
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f1475413394d..43f6d3ed24ef 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2531,6 +2531,95 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  	__free_pages_core(page, order);
>  }
>  
> +static bool _init_on_alloc_enabled_early __read_mostly
> +				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
> +static int __init early_init_on_alloc(char *buf)
> +{
> +
> +	return kstrtobool(buf, &_init_on_alloc_enabled_early);
> +}
> +early_param("init_on_alloc", early_init_on_alloc);
> +
> +static bool _init_on_free_enabled_early __read_mostly
> +				= IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON);
> +static int __init early_init_on_free(char *buf)
> +{
> +	return kstrtobool(buf, &_init_on_free_enabled_early);
> +}
> +early_param("init_on_free", early_init_on_free);
> +
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
> +
> +/*
> + * Enable static keys related to various memory debugging and hardening options.
> + * Some override others, and depend on early params that are evaluated in the
> + * order of appearance. So we need to first gather the full picture of what was
> + * enabled, and then make decisions.
> + */
> +static void __init mem_debugging_and_hardening_init(void)
> +{
> +	bool page_poisoning_requested = false;
> +	bool want_check_pages = false;
> +
> +#ifdef CONFIG_PAGE_POISONING
> +	/*
> +	 * Page poisoning is debug page alloc for some arches. If
> +	 * either of those options are enabled, enable poisoning.
> +	 */
> +	if (page_poisoning_enabled() ||
> +	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
> +	      debug_pagealloc_enabled())) {
> +		static_branch_enable(&_page_poisoning_enabled);
> +		page_poisoning_requested = true;
> +		want_check_pages = true;
> +	}
> +#endif
> +
> +	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> +	    page_poisoning_requested) {
> +		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> +			"will take precedence over init_on_alloc and init_on_free\n");
> +		_init_on_alloc_enabled_early = false;
> +		_init_on_free_enabled_early = false;
> +	}
> +
> +	if (_init_on_alloc_enabled_early) {
> +		want_check_pages = true;
> +		static_branch_enable(&init_on_alloc);
> +	} else {
> +		static_branch_disable(&init_on_alloc);
> +	}
> +
> +	if (_init_on_free_enabled_early) {
> +		want_check_pages = true;
> +		static_branch_enable(&init_on_free);
> +	} else {
> +		static_branch_disable(&init_on_free);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_KMSAN) &&
> +	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
> +		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
> +
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +	if (debug_pagealloc_enabled()) {
> +		want_check_pages = true;
> +		static_branch_enable(&_debug_pagealloc_enabled);
> +
> +		if (debug_guardpage_minorder())
> +			static_branch_enable(&_debug_guardpage_enabled);
> +	}
> +#endif
> +
> +	/*
> +	 * Any page debugging or hardening option also enables sanity checking
> +	 * of struct pages being allocated or freed. With CONFIG_DEBUG_VM it's
> +	 * enabled already.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DEBUG_VM) && want_check_pages)
> +		static_branch_enable(&check_pages_enabled);
> +}
> +
>  /* Report memory auto-initialization states for this boot. */
>  static void __init report_meminit(void)
>  {
> @@ -2570,7 +2659,7 @@ void __init mm_core_init(void)
>  	 * bigger than MAX_ORDER unless SPARSEMEM.
>  	 */
>  	page_ext_init_flatmem();
> -	init_mem_debugging_and_hardening();
> +	mem_debugging_and_hardening_init();
>  	kfence_alloc_pool();
>  	report_meminit();
>  	kmsan_init_shadow();
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1276bfe7a30..2f333c26170c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -240,31 +240,6 @@ EXPORT_SYMBOL(init_on_alloc);
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
>  EXPORT_SYMBOL(init_on_free);
>  
> -/* perform sanity checks on struct pages being allocated or freed */
> -static DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
> -
> -static inline bool is_check_pages_enabled(void)
> -{
> -	return static_branch_unlikely(&check_pages_enabled);
> -}
> -
> -static bool _init_on_alloc_enabled_early __read_mostly
> -				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
> -static int __init early_init_on_alloc(char *buf)
> -{
> -
> -	return kstrtobool(buf, &_init_on_alloc_enabled_early);
> -}
> -early_param("init_on_alloc", early_init_on_alloc);
> -
> -static bool _init_on_free_enabled_early __read_mostly
> -				= IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON);
> -static int __init early_init_on_free(char *buf)
> -{
> -	return kstrtobool(buf, &_init_on_free_enabled_early);
> -}
> -early_param("init_on_free", early_init_on_free);
> -
>  /*
>   * A cached value of the page's pageblock's migratetype, used when the page is
>   * put on a pcplist. Used to avoid the pageblock migratetype lookup when
> @@ -798,76 +773,6 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>  				unsigned int order, int migratetype) {}
>  #endif
>  
> -/*
> - * Enable static keys related to various memory debugging and hardening options.
> - * Some override others, and depend on early params that are evaluated in the
> - * order of appearance. So we need to first gather the full picture of what was
> - * enabled, and then make decisions.
> - */
> -void __init init_mem_debugging_and_hardening(void)
> -{
> -	bool page_poisoning_requested = false;
> -	bool want_check_pages = false;
> -
> -#ifdef CONFIG_PAGE_POISONING
> -	/*
> -	 * Page poisoning is debug page alloc for some arches. If
> -	 * either of those options are enabled, enable poisoning.
> -	 */
> -	if (page_poisoning_enabled() ||
> -	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
> -	      debug_pagealloc_enabled())) {
> -		static_branch_enable(&_page_poisoning_enabled);
> -		page_poisoning_requested = true;
> -		want_check_pages = true;
> -	}
> -#endif
> -
> -	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> -	    page_poisoning_requested) {
> -		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -			"will take precedence over init_on_alloc and init_on_free\n");
> -		_init_on_alloc_enabled_early = false;
> -		_init_on_free_enabled_early = false;
> -	}
> -
> -	if (_init_on_alloc_enabled_early) {
> -		want_check_pages = true;
> -		static_branch_enable(&init_on_alloc);
> -	} else {
> -		static_branch_disable(&init_on_alloc);
> -	}
> -
> -	if (_init_on_free_enabled_early) {
> -		want_check_pages = true;
> -		static_branch_enable(&init_on_free);
> -	} else {
> -		static_branch_disable(&init_on_free);
> -	}
> -
> -	if (IS_ENABLED(CONFIG_KMSAN) &&
> -	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
> -		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
> -
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -	if (debug_pagealloc_enabled()) {
> -		want_check_pages = true;
> -		static_branch_enable(&_debug_pagealloc_enabled);
> -
> -		if (debug_guardpage_minorder())
> -			static_branch_enable(&_debug_guardpage_enabled);
> -	}
> -#endif
> -
> -	/*
> -	 * Any page debugging or hardening option also enables sanity checking
> -	 * of struct pages being allocated or freed. With CONFIG_DEBUG_VM it's
> -	 * enabled already.
> -	 */
> -	if (!IS_ENABLED(CONFIG_DEBUG_VM) && want_check_pages)
> -		static_branch_enable(&check_pages_enabled);
> -}
> -
>  static inline void set_buddy_order(struct page *page, unsigned int order)
>  {
>  	set_page_private(page, order);

