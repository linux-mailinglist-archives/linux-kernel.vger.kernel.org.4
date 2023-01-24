Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D576795C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjAXKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjAXKva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:51:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C01BC1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:51:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 108A021A1D;
        Tue, 24 Jan 2023 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674557488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czUpody6ENC92ZT3Go+G1Ofmisw9/IxxFIe8l7uPtOY=;
        b=0vpQGOsCUOJsL3cUn0+tjOQwCgOfTLM/88+PCU+YWsioUNH+bGUFUi94C9e8oHzwcfJ7Cp
        wm8cUfCb2M3G+8xf0zxTzMjyVyiKR0d16UmNO0ODVZHhfN6rddy/2EYz4ZieI8IpxCuG9Q
        lMd69505WYC2o9yZSekzoj6Hdz+DsAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674557488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czUpody6ENC92ZT3Go+G1Ofmisw9/IxxFIe8l7uPtOY=;
        b=7gQ0KA93bG+KpxdKvZX7Y4KabBZdtwjFqvbR+yMk432DUslbTOPRK05mp80Q18EhCD9Yh7
        JagZ5dEJ7PoyWzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA27413487;
        Tue, 24 Jan 2023 10:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MXA5MC+4z2OvAwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Jan 2023 10:51:27 +0000
Message-ID: <dffcae23-7389-1bfe-723c-9109bd6a0bda@suse.cz>
Date:   Tue, 24 Jan 2023 11:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] mm/page_ext: init page_ext early if there are no
 deferred struct pages
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org,
        akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230118155251.2522985-1-pasha.tatashin@soleen.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230118155251.2522985-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 16:52, Pasha Tatashin wrote:
> page_ext must be initialized after all struct pages are initialized.
> Therefore, page_ext is initialized after page_alloc_init_late(), and
> can optionally be initialized earlier via early_page_ext kernel
> parameter which as a side effect also disables deferred struct pages.
> 
> Allow to automatically init page_ext early when there are no deferred
> struct pages in order to be able to use page_ext during kernel boot
> and track for example page allocations early.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/page_ext.h | 2 ++
>  init/main.c              | 6 +++---
>  mm/page_alloc.c          | 6 +++++-
>  mm/page_ext.c            | 2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> Changelog:
> v2: Fixed build issue with CONFIG_PAGE_EXTENSION=n
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index 67314f648aeb..bc2e39090a1f 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -29,6 +29,8 @@ struct page_ext_operations {
>  	bool need_shared_flags;
>  };
>  
> +extern bool deferred_struct_pages;
> +
>  #ifdef CONFIG_PAGE_EXTENSION
>  
>  /*
> diff --git a/init/main.c b/init/main.c
> index e1c3911d7c70..64cd2ff051c4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -855,8 +855,8 @@ static void __init mm_init(void)
>  	pgtable_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
> -	/* Should be run after vmap initialization */
> -	if (early_page_ext_enabled())
> +	/* If no deferred init page_ext now, as vmap is fully initialized */
> +	if (!deferred_struct_pages)
>  		page_ext_init();
>  	/* Should be run before the first non-init thread is created */
>  	init_espfix_bsp();
> @@ -1628,7 +1628,7 @@ static noinline void __init kernel_init_freeable(void)
>  	padata_init();
>  	page_alloc_init_late();
>  	/* Initialize page ext after all struct pages are initialized. */
> -	if (!early_page_ext_enabled())
> +	if (deferred_struct_pages)
>  		page_ext_init();
>  
>  	do_basic_setup();
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 99ebb08dc3f2..717f12e83b85 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -430,6 +430,8 @@ EXPORT_SYMBOL(nr_online_nodes);
>  
>  int page_group_by_mobility_disabled __read_mostly;
>  
> +bool deferred_struct_pages __meminitdata;
> +
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  /*
>   * During boot we initialize deferred pages on-demand, as needed, but once
> @@ -6803,8 +6805,10 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  		if (context == MEMINIT_EARLY) {
>  			if (overlap_memmap_init(zone, &pfn))
>  				continue;
> -			if (defer_init(nid, pfn, zone_end_pfn))
> +			if (defer_init(nid, pfn, zone_end_pfn)) {
> +				deferred_struct_pages = true;
>  				break;
> +			}
>  		}
>  
>  		page = pfn_to_page(pfn);
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index e2c22ffdbb81..dc1626be458b 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -92,7 +92,7 @@ unsigned long page_ext_size;
>  static unsigned long total_usage;
>  static struct page_ext *lookup_page_ext(const struct page *page);
>  
> -bool early_page_ext;
> +bool early_page_ext __meminitdata;
>  static int __init setup_early_page_ext(char *str)
>  {
>  	early_page_ext = true;

