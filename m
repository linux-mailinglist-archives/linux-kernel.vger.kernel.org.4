Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4076C4954
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCVLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:38:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE22C64F;
        Wed, 22 Mar 2023 04:38:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1F2120D14;
        Wed, 22 Mar 2023 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679485116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACmf/e6GIqWgaiPzBNT4x7+Kv9jhlsP3bBI1WXiL5sQ=;
        b=XkC+hBDP49DG9KapLMUn6yj/98rHMFj5kGMMw0VFNmL5Hz4juw+9zhPhVFrs4DtrkA2aqC
        Zvunu5IOqgA0eBM25BHbf+C5cozKTb18fzC3ptVp7GDjQX2y3cOiJ371yheex4mMR853zf
        ZHLJbLLF1hbeG13yisFzfhnWgVEoanE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679485116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACmf/e6GIqWgaiPzBNT4x7+Kv9jhlsP3bBI1WXiL5sQ=;
        b=9S0qNlnP2O19sv9CyAM3LZu7cViiQHMM77jSkLNC6ivxHw9kmUw4glf35QHY2lmYWqKwGr
        IQ5/FN6/Q/L02sDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9D2613416;
        Wed, 22 Mar 2023 11:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id leajLLzoGmTfPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 11:38:36 +0000
Message-ID: <b142ad8b-36a2-7d96-1fb0-2b1e82634fc5@suse.cz>
Date:   Wed, 22 Mar 2023 12:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/14] mm/page_alloc: add helper for checking if
 check_pages_enabled
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
 <20230321170513.2401534-3-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230321170513.2401534-3-rppt@kernel.org>
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
> Instead of duplicating long static_branch_enabled(&check_pages_enabled)
> wrap it in a helper function is_check_pages_enabled()
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 87d760236dba..e1149d54d738 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -245,6 +245,11 @@ EXPORT_SYMBOL(init_on_free);
>  /* perform sanity checks on struct pages being allocated or freed */
>  static DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
>  
> +static inline bool is_check_pages_enabled(void)
> +{
> +	return static_branch_unlikely(&check_pages_enabled);
> +}
> +
>  static bool _init_on_alloc_enabled_early __read_mostly
>  				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
>  static int __init early_init_on_alloc(char *buf)
> @@ -1443,7 +1448,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		for (i = 1; i < (1 << order); i++) {
>  			if (compound)
>  				bad += free_tail_pages_check(page, page + i);
> -			if (static_branch_unlikely(&check_pages_enabled)) {
> +			if (is_check_pages_enabled()) {
>  				if (unlikely(free_page_is_bad(page + i))) {
>  					bad++;
>  					continue;
> @@ -1456,7 +1461,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		page->mapping = NULL;
>  	if (memcg_kmem_online() && PageMemcgKmem(page))
>  		__memcg_kmem_uncharge_page(page, order);
> -	if (static_branch_unlikely(&check_pages_enabled)) {
> +	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
>  			bad++;
>  		if (bad)
> @@ -2366,7 +2371,7 @@ static int check_new_page(struct page *page)
>  
>  static inline bool check_new_pages(struct page *page, unsigned int order)
>  {
> -	if (static_branch_unlikely(&check_pages_enabled)) {
> +	if (is_check_pages_enabled()) {
>  		for (int i = 0; i < (1 << order); i++) {
>  			struct page *p = page + i;
>  

