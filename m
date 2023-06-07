Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904277267B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjFGRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjFGRpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:45:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305F1BFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:45:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b23f04e333so8602965ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686159934; x=1688751934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEHz2ZoKgSyxNB1AeUKqmQu+HCPGQ2ML++3OH4j+o7Y=;
        b=rFwImea/OOEo/0t4Q+mAr1zCkoA8LoFl8bbw94y42DLLnSvH1pSjKAgRF3GooBY/c0
         pNtCc8NjjwqhV4+14Xtl0Z7zh28EzajitRvHvBYbxTDwi21L/J4XROhMYzEIk0D5oI0S
         IxcgQN0OBJKbP0wT3JFRo6g3ZMrWBPCOA0tm0nIiab0NatPd/iYtMDctRO5yf1Q+PSfb
         uVifLBThQVvXfA7WwnYizYdVhhovoTCAUi0ETxlbs1b7eK03yIU5hGxONHJTc0QqjypP
         KNRqdjpILdxqX5hqOtz4ECxBpRgFkC9ubtpUAUNw5xLaUOiIo+6fS82Fc9vYqevKGFsn
         EY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159934; x=1688751934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEHz2ZoKgSyxNB1AeUKqmQu+HCPGQ2ML++3OH4j+o7Y=;
        b=EkV8hx+cN0SXh0SNLOAix4PKJH/nIr5NYm+EftoJDOVxYTxI0tGmTLD3fVBaGd+Ip7
         qfiDNh8aX7run2dSwZ3lBc8JGDBlOirV5plOGp7B3C36GH4NFZc3ox9Z8wD9JIoC/Y8K
         c0nUW8S1ElPG1YnRMewZ+8s7lBGW4DHXhsbmLOpjwHp1vkLSDaY3yFYeVtUJ5BKpIjVn
         UeNylpugIBIVARhI/kaCZgryVRDQDJGa7gNd9nZk9pLxJIaYJ1U2GPfZIQqalScT4O7U
         kdYVUbr0C7iOyDT8eYEs7g9B/JwhSYeYSlEaO1WdCZHjHwnFnj8FauyAVNFFz4yAvuCg
         0YWg==
X-Gm-Message-State: AC+VfDxLnd7Pod3AHz8CThVFKKnrkhCCJpU8DC5WaLDC1tx4LEAZqMui
        nYxihg75IPet6k/byhbvIUw=
X-Google-Smtp-Source: ACHHUZ58Y6XNgIIhNBrPN7yClCVvnBcR7oCRQ9QnbUohlQCTzrZ0qLJvr2/Br7MnQjJVX9r/zW6T5g==
X-Received: by 2002:a17:902:dacc:b0:1ac:8837:de9 with SMTP id q12-20020a170902dacc00b001ac88370de9mr3030728plx.3.1686159934539;
        Wed, 07 Jun 2023 10:45:34 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:b727:cbb8:689a:5510])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001afd821c057sm10697262plg.58.2023.06.07.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:45:33 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 7 Jun 2023 10:45:31 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, senozhatsky@chromium.org,
        yosryahmed@google.com, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH v2 4/7] mm: zswap: remove page reclaim logic from
 zsmalloc
Message-ID: <ZIDCO2dAOHFM5mhS@google.com>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:56:08PM +0200, Domenico Cerasuolo wrote:
> With the recent enhancement to zswap enabling direct page writeback, the
> need for the shrink code in zsmalloc has become obsolete. As a result,
> this commit removes the page reclaim logic from zsmalloc entirely.
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zsmalloc.c | 393 ++------------------------------------------------
>  1 file changed, 13 insertions(+), 380 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 02f7f414aade..75386283dba0 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -107,21 +107,8 @@
>   */
>  #define OBJ_ALLOCATED_TAG 1
>  
> -#ifdef CONFIG_ZPOOL
> -/*
> - * The second least-significant bit in the object's header identifies if the
> - * value stored at the header is a deferred handle from the last reclaim
> - * attempt.
> - *
> - * As noted above, this is valid because we have room for two bits.
> - */
> -#define OBJ_DEFERRED_HANDLE_TAG	2
> -#define OBJ_TAG_BITS	2
> -#define OBJ_TAG_MASK	(OBJ_ALLOCATED_TAG | OBJ_DEFERRED_HANDLE_TAG)
> -#else
>  #define OBJ_TAG_BITS	1
>  #define OBJ_TAG_MASK	OBJ_ALLOCATED_TAG
> -#endif /* CONFIG_ZPOOL */
>  
>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
> @@ -227,12 +214,6 @@ struct link_free {
>  		 * Handle of allocated object.
>  		 */
>  		unsigned long handle;
> -#ifdef CONFIG_ZPOOL
> -		/*
> -		 * Deferred handle of a reclaimed object.
> -		 */
> -		unsigned long deferred_handle;
> -#endif
>  	};
>  };
>  
> @@ -250,13 +231,6 @@ struct zs_pool {
>  	/* Compact classes */
>  	struct shrinker shrinker;
>  
> -#ifdef CONFIG_ZPOOL
> -	/* List tracking the zspages in LRU order by most recently added object */
> -	struct list_head lru;
> -	struct zpool *zpool;
> -	const struct zpool_ops *zpool_ops;
> -#endif
> -
>  #ifdef CONFIG_ZSMALLOC_STAT
>  	struct dentry *stat_dentry;
>  #endif
> @@ -279,13 +253,6 @@ struct zspage {
>  	unsigned int freeobj;
>  	struct page *first_page;
>  	struct list_head list; /* fullness list */
> -
> -#ifdef CONFIG_ZPOOL
> -	/* links the zspage to the lru list in the pool */
> -	struct list_head lru;
> -	bool under_reclaim;
> -#endif
> -
>  	struct zs_pool *pool;
>  	rwlock_t lock;
>  };
> @@ -393,14 +360,7 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
>  	 * different contexts and its caller must provide a valid
>  	 * gfp mask.
>  	 */
> -	struct zs_pool *pool = zs_create_pool(name);
> -
> -	if (pool) {
> -		pool->zpool = zpool;
> -		pool->zpool_ops = zpool_ops;
> -	}
> -
> -	return pool;
> +	return zs_create_pool(name);
>  }
>  
>  static void zs_zpool_destroy(void *pool)
> @@ -422,27 +382,6 @@ static void zs_zpool_free(void *pool, unsigned long handle)
>  	zs_free(pool, handle);
>  }
>  
> -static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
> -
> -static int zs_zpool_shrink(void *pool, unsigned int pages,
> -			unsigned int *reclaimed)
> -{
> -	unsigned int total = 0;
> -	int ret = -EINVAL;
> -
> -	while (total < pages) {
> -		ret = zs_reclaim_page(pool, 8);
> -		if (ret < 0)
> -			break;
> -		total++;
> -	}
> -
> -	if (reclaimed)
> -		*reclaimed = total;
> -
> -	return ret;
> -}
> -
>  static void *zs_zpool_map(void *pool, unsigned long handle,
>  			enum zpool_mapmode mm)
>  {
> @@ -481,7 +420,7 @@ static struct zpool_driver zs_zpool_driver = {
>  	.malloc_support_movable = true,
>  	.malloc =		  zs_zpool_malloc,
>  	.free =			  zs_zpool_free,
> -	.shrink =		  zs_zpool_shrink,
> +	.shrink =		  NULL,

You can simply delete the line instead since the NULL is default behavior.

Other than that, Super nice. Thanks, Domenico!

Acked-by: Minchan Kim <minchan@kernel.org>
