Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8E60DE89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiJZKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZKC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:02:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB59187B;
        Wed, 26 Oct 2022 03:02:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3ABF91F8B3;
        Wed, 26 Oct 2022 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666778574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vR6f3Clxj5CrL08Ju/vI52Uneo3/xjRAjpwZPragrGg=;
        b=bz4318npD5LKv6OgOsEgmjuAojToyggPbdIHJs+iX/3aAH9iloZt/lD4hEnPq2JA4M9/HV
        vfPa7c11Rx6zwnA5+IwCiNsiojNpcQRnIs/pnktGoXBljMw7Lx9Cjm25l90IkoGBfBgb5O
        0y4PbMiSoOsh31BaS0/kWFuTCsfhwGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666778574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vR6f3Clxj5CrL08Ju/vI52Uneo3/xjRAjpwZPragrGg=;
        b=Y45GjEJ0tLrfb/Pq4dg6Qwyowx3FC6E9SSohCtxbtu8IXqD7Hex+wvaUeRyo4Lg/n28+SS
        /+6dFeKiTCxAFOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12EC913A77;
        Wed, 26 Oct 2022 10:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IYvhA84FWWOEcwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Oct 2022 10:02:54 +0000
Message-ID: <a2e15c0d-dd0f-dcf1-ca53-c37333bdfe99@suse.cz>
Date:   Wed, 26 Oct 2022 12:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3] mempool: Do not use ksize() for poisoning
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221025233421.you.825-kees@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221025233421.you.825-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 01:36, Kees Cook wrote:
> Nothing appears to be using ksize() within the kmalloc-backed mempools
> except the mempool poisoning logic. Use the actual pool size instead
> of the ksize() to avoid needing any special handling of the memory as
> needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/lkml/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> v3: remove ksize() calls instead of adding kmalloc_roundup_size() calls (vbabka)
> v2: https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
> v1: https://lore.kernel.org/lkml/20220923202822.2667581-14-keescook@chromium.org/
> ---
>  mm/mempool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 96488b13a1ef..54204065037d 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -58,7 +58,7 @@ static void check_element(mempool_t *pool, void *element)
>  {
>  	/* Mempools backed by slab allocator */
>  	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
> -		__check_element(pool, element, ksize(element));
> +		__check_element(pool, element, (size_t)pool->pool_data);
>  	} else if (pool->free == mempool_free_pages) {
>  		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;
> @@ -81,7 +81,7 @@ static void poison_element(mempool_t *pool, void *element)
>  {
>  	/* Mempools backed by slab allocator */
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
> -		__poison_element(element, ksize(element));
> +		__poison_element(element, (size_t)pool->pool_data);
>  	} else if (pool->alloc == mempool_alloc_pages) {
>  		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;
> @@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  static void kasan_unpoison_element(mempool_t *pool, void *element)
>  {
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -		kasan_unpoison_range(element, __ksize(element));
> +		kasan_unpoison_range(element, (size_t)pool->pool_data);
>  	else if (pool->alloc == mempool_alloc_pages)
>  		kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
>  				     false);

