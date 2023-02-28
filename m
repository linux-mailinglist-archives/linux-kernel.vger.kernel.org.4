Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFD6A63B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjB1XO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjB1XOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:14:54 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF871717E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:14:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n6so10758284plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677626090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKJlhnCff5sNnYAeJlixRN9YIHYvvlU48QM4lr2nN4Y=;
        b=L5FrJGgkVEevxRepHVOTmUx3GaOP0U5GsRZlH4bqXkei6mJcLx9/uGq/JKZnzuDIdJ
         h0RAHGdTn1QLSvjSXMR6wGLJF+NWg/WQjjzpnKoyeFUH/ajZjXVeELBmgDKKNQGhFeU3
         VyGdWQo4Ad9i/W01RC0YThtv8z6h1Po4uwQJJfcjkaHqfg2yPJW8wA6xua9n2nVpFIPg
         Pd/FMcKV38YstjyCD6jl9kwtYcWE/C77HuZNRjrczcTdhXG2PsSkckE4ncE3u2upWpiD
         QietehTRZhbwL9uYW0hNuM5vvkI7WRW8rsVsuEw8R+qMWjmuz4UZm1WRu4ozgq2fkuUA
         sPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677626090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKJlhnCff5sNnYAeJlixRN9YIHYvvlU48QM4lr2nN4Y=;
        b=SeyTpboBdN9z45tuRiAF1CuQP2awA5TK53zuQHJwFZl3JgpDR8wtXBiKRIqRJiSXO/
         cAmO9ckZN/MlA3zaYNIQlnFb6ILwfommyKwZxjfw1x6BQbp0+Zqq3YpBJapprB7KXN95
         KDhd8kd8gUt0SM4ADAq7x6wgN2ikEExfOSDazi5CyJNm4vxnHwokvzz5FmWaza6qMlz3
         vt/8YysWPmtGbHdV0j6Oyc04Q3XIlMqBFZae+hGHh32JTvhr2LuvkQeO74Tjl05dyEhI
         9M1FD1yszsdKj0pVppx9kjMFzdYrW67xlnAJGJv3JYNf4azRMARDBJhwLsmDNlo45QtI
         59gg==
X-Gm-Message-State: AO0yUKVszxKl40aqMe4VlfLscUIgFoYoCZ8iRDAeYBD/jSBu9BM0MG39
        88gRT03xA6H4rPyhCFDOJjg=
X-Google-Smtp-Source: AK7set+uQEKJGMvciIQ9HGglTcsr6kDKy3GcYCT6m79r97G8wkVUPwGQIa6gzRrj5oEIsENq7XKUew==
X-Received: by 2002:a17:903:2447:b0:19c:c9da:a62e with SMTP id l7-20020a170903244700b0019cc9daa62emr5013045pls.54.1677626090194;
        Tue, 28 Feb 2023 15:14:50 -0800 (PST)
Received: from google.com ([2620:15c:211:201:639:82f5:b510:3494])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001994fc55998sm7002311plj.217.2023.02.28.15.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:14:49 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Feb 2023 15:14:47 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 4/6] zsmalloc: rework compaction algorithm
Message-ID: <Y/6K5+pC+nXvDsjq@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-5-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223030451.543162-5-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:04:49PM +0900, Sergey Senozhatsky wrote:
> The zsmalloc compaction algorithm has the potential to
> waste some CPU cycles, particularly when compacting pages
> within the same fullness group. This is due to the way it
> selects the head page of the fullness list for source and
> destination pages, and how it reinserts those pages during
> each iteration. The algorithm may first use a page as a
> migration destination and then as a migration source,
> leading to an unnecessary back-and-forth movement of
> objects.
> 
> Consider the following fullness list:
> 
> PageA PageB PageC PageD PageE
> 
> During the first iteration, the compaction algorithm will
> select PageA as the source and PageB as the destination.
> All of PageA's objects will be moved to PageB, and then
> PageA will be released while PageB is reinserted into the
> fullness list.
> 
> PageB PageC PageD PageE
> 
> During the next iteration, the compaction algorithm will
> again select the head of the list as the source and destination,
> meaning that PageB will now serve as the source and PageC as
> the destination. This will result in the objects being moved
> away from PageB, the same objects that were just moved to PageB
> in the previous iteration.
> 
> To prevent this avalanche effect, the compaction algorithm
> should not reinsert the destination page between iterations.
> By doing so, the most optimal page will continue to be used
> and its usage ratio will increase, reducing internal
> fragmentation. The destination page should only be reinserted
> into the fullness list if:
> - It becomes full
> - No source page is available.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 82 ++++++++++++++++++++++++---------------------------
>  1 file changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 1a92ebe338eb..eacf9e32da5c 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1786,15 +1786,14 @@ struct zs_compact_control {
>  	int obj_idx;
>  };
>  
> -static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
> -				struct zs_compact_control *cc)
> +static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
> +			   struct zs_compact_control *cc)
>  {
>  	unsigned long used_obj, free_obj;
>  	unsigned long handle;
>  	struct page *s_page = cc->s_page;
>  	struct page *d_page = cc->d_page;
>  	int obj_idx = cc->obj_idx;
> -	int ret = 0;
>  
>  	while (1) {
>  		handle = find_alloced_obj(class, s_page, &obj_idx);
> @@ -1807,10 +1806,8 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
>  		}
>  
>  		/* Stop if there is no more space */
> -		if (zspage_full(class, get_zspage(d_page))) {
> -			ret = -ENOMEM;
> +		if (zspage_full(class, get_zspage(d_page)))
>  			break;
> -		}
>  
>  		used_obj = handle_to_obj(handle);
>  		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
> @@ -1823,8 +1820,6 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
>  	/* Remember last position in this iteration */
>  	cc->s_page = s_page;
>  	cc->obj_idx = obj_idx;
> -
> -	return ret;
>  }
>  
>  static struct zspage *isolate_src_zspage(struct size_class *class)
> @@ -2228,57 +2223,56 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  	 * as well as zpage allocation/free
>  	 */
>  	spin_lock(&pool->lock);
> -	while ((src_zspage = isolate_src_zspage(class))) {
> -		/* protect someone accessing the zspage(i.e., zs_map_object) */
> -		migrate_write_lock(src_zspage);
> -
> -		if (!zs_can_compact(class))
> -			break;
> -
> -		cc.obj_idx = 0;
> -		cc.s_page = get_first_page(src_zspage);
> -
> -		while ((dst_zspage = isolate_dst_zspage(class))) {
> -			migrate_write_lock_nested(dst_zspage);
> -
> +	while (1) {
> +		if (!dst_zspage) {
> +			dst_zspage = isolate_dst_zspage(class);
> +			if (!dst_zspage)
> +				goto out;
> +			migrate_write_lock(dst_zspage);
>  			cc.d_page = get_first_page(dst_zspage);
> -			/*
> -			 * If there is no more space in dst_page, resched
> -			 * and see if anyone had allocated another zspage.
> -			 */
> -			if (!migrate_zspage(pool, class, &cc))
> -				break;
> +		}
>  
> +		if (!zs_can_compact(class)) {
>  			putback_zspage(class, dst_zspage);
>  			migrate_write_unlock(dst_zspage);
> -			dst_zspage = NULL;
> -			if (spin_is_contended(&pool->lock))
> -				break;
> +			goto out;

just break instead of goto

>  		}
>  
> -		/* Stop if we couldn't find slot */
> -		if (dst_zspage == NULL)
> -			break;
> +		src_zspage = isolate_src_zspage(class);
> +		if (!src_zspage) {
> +			putback_zspage(class, dst_zspage);
> +			migrate_write_unlock(dst_zspage);
> +			goto out;

just break instead of goto

> +		}
>  
> -		putback_zspage(class, dst_zspage);
> -		migrate_write_unlock(dst_zspage);
> +		migrate_write_lock_nested(src_zspage);
> +
> +		cc.obj_idx = 0;
> +		cc.s_page = get_first_page(src_zspage);
> +		migrate_zspage(pool, class, &cc);
>  
>  		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
>  			migrate_write_unlock(src_zspage);
>  			free_zspage(pool, class, src_zspage);
>  			pages_freed += class->pages_per_zspage;
> -		} else
> +		} else {
>  			migrate_write_unlock(src_zspage);

So here, migratre_wirite_unlock(src_zspage) is done in both conditions
we we could change like this.

ret = putback_zspage(class, src_zspage);
migrate_write_unlock(src_zspage);
if (ret == ZS_INUSE_RATIO_0 or ZS_EMPTY) {
    free_zspage();
    xxx
}
    

> -		spin_unlock(&pool->lock);
> -		cond_resched();
> -		spin_lock(&pool->lock);
> -	}
> +		}
>  
> -	if (src_zspage) {
> -		putback_zspage(class, src_zspage);
> -		migrate_write_unlock(src_zspage);
> -	}
> +		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
> +		    || spin_is_contended(&pool->lock)) {
> +			putback_zspage(class, dst_zspage);
> +			migrate_write_unlock(dst_zspage);
> +			dst_zspage = NULL;

			spin_unlock(&pool->lock);
            cond_resched()
			spin_lock(&pool->lock);
> +		}
>  
> +		if (!dst_zspage) {

Then we could remove the condition logic, here.

> +			spin_unlock(&pool->lock);
> +			cond_resched();
> +			spin_lock(&pool->lock);
> +		}
> +	}
> +out:
>  	spin_unlock(&pool->lock);
>  
>  	return pages_freed;

So, how about this on top of your patch?


diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index eacf9e32da5c..4dfc910f5d89 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2223,40 +2223,33 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	spin_lock(&pool->lock);
-	while (1) {
+	while (zs_can_compact(class)) {
+		int ret;
+
 		if (!dst_zspage) {
 			dst_zspage = isolate_dst_zspage(class);
 			if (!dst_zspage)
-				goto out;
+				break;
 			migrate_write_lock(dst_zspage);
 			cc.d_page = get_first_page(dst_zspage);
 		}
 
-		if (!zs_can_compact(class)) {
-			putback_zspage(class, dst_zspage);
-			migrate_write_unlock(dst_zspage);
-			goto out;
-		}
-
 		src_zspage = isolate_src_zspage(class);
-		if (!src_zspage) {
-			putback_zspage(class, dst_zspage);
-			migrate_write_unlock(dst_zspage);
-			goto out;
-		}
+		if (!src_zspage)
+			break;
 
 		migrate_write_lock_nested(src_zspage);
-
 		cc.obj_idx = 0;
 		cc.s_page = get_first_page(src_zspage);
+
 		migrate_zspage(pool, class, &cc);
+		ret = putback_zspage(class, src_zspage);
+		migrate_write_unlock(src_zspage);
 
-		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
-			migrate_write_unlock(src_zspage);
+		if (ret == ZS_INUSE_RATIO_0) {
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
-		} else {
-			migrate_write_unlock(src_zspage);
+			src_zspage = NULL;
 		}
 
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
@@ -2264,14 +2257,22 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			putback_zspage(class, dst_zspage);
 			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
-		}
 
-		if (!dst_zspage) {
 			spin_unlock(&pool->lock);
 			cond_resched();
 			spin_lock(&pool->lock);
 		}
 	}
+
+	if (src_zspage) {
+		putback_zspage(class, src_zspage);
+		migrate_write_unlock(src_zspage);
+	}
+
+	if (dst_zspage) {
+		putback_zspage(class, dst_zspage);
+		migrate_write_unlock(dst_zspage);
+	}
 out:
 	spin_unlock(&pool->lock);
 
