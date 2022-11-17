Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7454562E7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiKQWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiKQWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:15:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC674CC0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:15:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b21so2905171plc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+rCsV5xsoe3YaW2+ZL6bhCv4e9AU/LzIWH2zi7pT+E=;
        b=de8kXYaeuUUFyDxBuZ8N9Itz1hzGQA+CbOUNN8k4fgM8wN0Tib7RipSMV1i7JdgJ0/
         bZuygE0uXtCeWZwDb4doQDuagJMYHrQybMgD+XE1O8e1WXR66umAr+9SkxyqW2rz1GCi
         iTMD5ikKdTmpPYooemuKyLRwCQ1bIN5SMpuROKSoLsIICklfh2M0IDLPAjEIU0yLZ/wL
         DtJGU6ckrvqFkSpQpfVPirM+ZpJYXfo6uS6GxY3hkzdejcSApS+Lab+QvTUaJNXTURFk
         EW3JP//MFKXQG8A+FVUnPSVl/16I9pkUe1cHKgi8qiqmYWsV3mBPEUawQpxdwK8KYhy/
         LJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+rCsV5xsoe3YaW2+ZL6bhCv4e9AU/LzIWH2zi7pT+E=;
        b=KI5TIVL4KGsAF2w2+11izguY6WI0wknmpN/DMgP597iUyJv4qu6vDZiQTaU5eDow7q
         byw5KU0PGh0ti77dIwkHhj3PkPwdsMXdN8qhrvfk5S7kLeCbhBhRe3CWkscSevlqk13c
         o0Z61Zh0AxhNIft3xxcYRiqPodT1JJPkM1ZRQcPapAaQojf3piLINAcsgFnYNDsu6jWU
         iLg2oFaMntk7/c/CWdiqCyrfT8o9N6d07vI/ckD+o3aaN4cMkYeCSDp3qPRvRl2rqoWc
         5HV6d7kpNg8jDnIJCPlcP1dC0/CAKaBj/kKRAJvo7H+JWxtw6EWelHK561bI7yg0bF4s
         2hbQ==
X-Gm-Message-State: ANoB5pkyh5LtLOckpqivjPEdnP0IoYgafjghSdTkJMS28flcWJhuvO4T
        PSTh6YU7waITtnUOamw+B1Z6Qvc8W5Y=
X-Google-Smtp-Source: AA0mqf64SqKfsQcBAnKS3C7bXsL9Ae3TY0Tb7LsEMKMU08oJXdeFsNoPxvf3n9ZgQeBdgRoq19/kag==
X-Received: by 2002:a17:903:234d:b0:186:9405:290a with SMTP id c13-20020a170903234d00b001869405290amr4613078plh.133.1668723314318;
        Thu, 17 Nov 2022 14:15:14 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6bbc:b70a:8f80:710d])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709027c9300b0017f9db0236asm1921367pll.82.2022.11.17.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:15:13 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 17 Nov 2022 14:15:11 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3ayb4kx/m3oDsSN@google.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117163839.230900-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:38:37AM -0800, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 326faa751f0a..2557b55ec767 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -239,6 +239,11 @@ struct zs_pool {
>  	/* Compact classes */
>  	struct shrinker shrinker;
> 
> +#ifdef CONFIG_ZPOOL
> +	/* List tracking the zspages in LRU order by most recently added object */
> +	struct list_head lru;
> +#endif
> +
>  #ifdef CONFIG_ZSMALLOC_STAT
>  	struct dentry *stat_dentry;
>  #endif
> @@ -260,6 +265,12 @@ struct zspage {
>  	unsigned int freeobj;
>  	struct page *first_page;
>  	struct list_head list; /* fullness list */
> +
> +#ifdef CONFIG_ZPOOL
> +	/* links the zspage to the lru list in the pool */
> +	struct list_head lru;
> +#endif
> +
>  	struct zs_pool *pool;
>  #ifdef CONFIG_COMPACTION
>  	rwlock_t lock;
> @@ -352,6 +363,18 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
>  	kmem_cache_free(pool->zspage_cachep, zspage);
>  }
> 
> +#ifdef CONFIG_ZPOOL
> +/* Moves the zspage to the front of the zspool's LRU */
> +static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
> +{
> +	assert_spin_locked(&pool->lock);
> +
> +	if (!list_empty(&zspage->lru))
> +		list_del(&zspage->lru);
> +	list_add(&zspage->lru, &pool->lru);
> +}
> +#endif
> +
>  /* pool->lock(which owns the handle) synchronizes races */
>  static void record_obj(unsigned long handle, unsigned long obj)
>  {
> @@ -953,6 +976,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
>  	}
> 
>  	remove_zspage(class, zspage, ZS_EMPTY);
> +#ifdef CONFIG_ZPOOL
> +	list_del(&zspage->lru);
> +#endif
>  	__free_zspage(pool, class, zspage);
>  }
> 
> @@ -998,6 +1024,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>  		off %= PAGE_SIZE;
>  	}
> 
> +#ifdef CONFIG_ZPOOL
> +	INIT_LIST_HEAD(&zspage->lru);
> +#endif
> +
>  	set_freeobj(zspage, 0);
>  }
> 
> @@ -1418,6 +1448,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  		fix_fullness_group(class, zspage);
>  		record_obj(handle, obj);
>  		class_stat_inc(class, OBJ_USED, 1);
> +
> +#ifdef CONFIG_ZPOOL
> +		/* Move the zspage to front of pool's LRU */
> +		move_to_front(pool, zspage);
> +#endif
>  		spin_unlock(&pool->lock);
> 
>  		return handle;
> @@ -1444,6 +1479,10 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> 
>  	/* We completely set up zspage so mark them as movable */
>  	SetZsPageMovable(pool, zspage);
> +#ifdef CONFIG_ZPOOL
> +	/* Move the zspage to front of pool's LRU */
> +	move_to_front(pool, zspage);
> +#endif
>  	spin_unlock(&pool->lock);

Why do we move the zspage in the alloc instead of accessor?

Isn't zs_map_object better place since it's clear semantic
that user start to access the object?

If you are concerning unnecessary churning, can we do that
only for WO access?

Yeah, it is still weird layering since allocator couldn't know
what user will do over the this access(will keep or discard)
so the lru in the allocator is not a good design but I just
want to make little more sense.
