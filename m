Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2B6C5098
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCVQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:27:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C84ECD8;
        Wed, 22 Mar 2023 09:27:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 928B720FDA;
        Wed, 22 Mar 2023 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679502422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPf3gy+C+ST6lBwKBIf0DHjU4XxrVv5WH4FZzVHoFDk=;
        b=c+U/k0zNjArhSJC4nSLOEObzjJsvBepOGZeXLsL9ClGbyB2nIHnKL96CDjQT4E6Jgg50BB
        PloBLci0Ve21wU9cW9BDRyQBeu7kNuTkzDh2VJ7YbkV8/pzmTQFp9DAZqFX7jr3GLVoFmi
        IeB9Njluar6A9zouxCzjYjqVDqNvWjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679502422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPf3gy+C+ST6lBwKBIf0DHjU4XxrVv5WH4FZzVHoFDk=;
        b=miZ1lUmFk0SrifduUnebSgEbatvkjCRDyXQY8tbyBjtLPq+tb+6cXpJwM9bjGfM0P3Q6KI
        fGCxLsSi8OmYrYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C51213416;
        Wed, 22 Mar 2023 16:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pFWXFVYsG2TibgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 16:27:02 +0000
Message-ID: <801211fd-558c-a07d-e84a-aa7f997d8c92@suse.cz>
Date:   Wed, 22 Mar 2023 17:27:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/14] mm: call {ptlock,pgtable}_cache_init() directly
 from mm_core_init()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-9-rppt@kernel.org>
 <ff403707-a61b-8b87-4d8d-5aecaa574be3@gmail.com>
 <ZBrTtQKe7SowXSKb@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZBrTtQKe7SowXSKb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 11:08, Mike Rapoport wrote:
> On Wed, Mar 22, 2023 at 12:06:18PM +0300, Sergei Shtylyov wrote:
>> On 3/21/23 8:05 PM, Mike Rapoport wrote:
>> 
>> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> > 
>> > and drop pgtable_init() as it has no real value and it's name is
>> 
>>    Its name.
> 
> oops :)
> 
> Andrew, can you replace this patch with the updated version, please?
>  
> From 52420723c9bfa84aa48f666330e96f9e5b2f3248 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Sat, 18 Mar 2023 13:55:28 +0200
> Subject: [PATCH v3] mm: call {ptlock,pgtable}_cache_init() directly from
>  mm_core_init()
> 
> and drop pgtable_init() as it has no real value and its name is
> misleading.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 6 ------
>  mm/mm_init.c       | 3 ++-
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2d7f095136fc..c3c67d8bc833 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2782,12 +2782,6 @@ static inline bool ptlock_init(struct page *page) { return true; }
>  static inline void ptlock_free(struct page *page) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
> -static inline void pgtable_init(void)
> -{
> -	ptlock_cache_init();
> -	pgtable_cache_init();
> -}
> -
>  static inline bool pgtable_pte_page_ctor(struct page *page)
>  {
>  	if (!ptlock_init(page))
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index bba73f1fb277..f1475413394d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2584,7 +2584,8 @@ void __init mm_core_init(void)
>  	 */
>  	page_ext_init_flatmem_late();
>  	kmemleak_init();
> -	pgtable_init();
> +	ptlock_cache_init();
> +	pgtable_cache_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
>  	/* If no deferred init page_ext now, as vmap is fully initialized */

