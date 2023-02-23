Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0136A13F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBWXqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:46:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9236FC9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:46:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so987638pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677195988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUsoETvpcOqiI6sggxMzGrA7yADLPKc9REkQGUWXyIY=;
        b=igwJZZBd/7G2tpJHLBI9j/0I/4gIhm8JvRoToGo/WGOiCm/npZgYMVJxmgdCbh1hPM
         zokYeHhHBAPhWggGsfrk6/CkVAeoA7ssIsJCbXKhSttBgPAJmsCSRmqLbvcEieuOQ/So
         MR6Xuqq30UwHSxl7sjWBFvEwuzWGIyEmNphDnGSKxEIQnmVnT5bNmhqHuQahoGRlQCNv
         CLOU10q09fBIy/ZP+8lztgKgOH6EKgwTD+aVWzYWj9v0x6bUDVFOpvgXmQ5ESNeP3x3+
         M0VU0xLPSw0obQHO3hkdrL0Bn4OUkxYAYfvIboXmmS5ZBg4ZU9bkMo1bpxQ1XGCK3qoy
         R1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677195988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUsoETvpcOqiI6sggxMzGrA7yADLPKc9REkQGUWXyIY=;
        b=NfNItHNxzEMgdRVv56tsoeeztLetsELXpWvpkWsGe2WqXlBTMk4LSLVaca7EtA2Qw1
         8FHQ4cxdbtKntpY/4M//4pkXpx2omnrbe3ofDRD/tuFD9IyU/NCOkDrVRxOTKeZornqG
         AjXOHAAJl4FjTow3Ot93fUFjLaNBmrU7R9k4ZG68sKEKUe5f1ZZPtd15nnGCjNldamlN
         Sno4BAZuLylU8SU6ibX62fZma9+ojG7RbI8Iv1Al3Pe40OSauyQ1NIsuX8EndVd70iNx
         H13H2ImG6Um+LNyB7JT2IBbde1aUMRk5x0IfUWBASSRoYGd7zlQnIr97g0nTYYVV+Vft
         56Mw==
X-Gm-Message-State: AO0yUKXxF2A4wf94UR1NzD7zKlLKJPM4F1LYBPD+l+O9eCJ33viGXrWw
        PN7zTdFK9CO5s0rqw2/LpPs=
X-Google-Smtp-Source: AK7set8bIWofM3SorkwUKjw3N5BkXFgXlakZ6DuEJndggtAGtfKcdDg7oAScOvZ7rQwrvBJxIJ+Q0g==
X-Received: by 2002:a17:90b:164f:b0:230:8ec4:3c0c with SMTP id il15-20020a17090b164f00b002308ec43c0cmr13403479pjb.18.1677195987892;
        Thu, 23 Feb 2023 15:46:27 -0800 (PST)
Received: from google.com ([2620:15c:211:201:be5:a687:1e9d:ec53])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b0023317104415sm253000pjt.17.2023.02.23.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:46:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 23 Feb 2023 15:46:25 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 4/6] zsmalloc: rework compaction algorithm
Message-ID: <Y/f60c25V4oiIeMN@google.com>
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

Good point.

> should not reinsert the destination page between iterations.
> By doing so, the most optimal page will continue to be used
> and its usage ratio will increase, reducing internal
> fragmentation. The destination page should only be reinserted
> into the fullness list if:
> - It becomes full
> - No source page is available.

I think that's really better option, yeah.

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

Hmm, I preferred the old loop structure. Did you see any problem
to keep old code structure?

Can't we just add checking logic whether destination zspage page
is full after migrate_zspage and the putback if it is. Otherwise,
keep continuing with the source zspage or new zspage we completely
migrate all zpages in the zspage. If there is no more source zspages
in the list, we can break the loop and then putback the dest zspage
into right class group at out of end loop.

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
> +		}
>  
> +		if (!dst_zspage) {
> +			spin_unlock(&pool->lock);
> +			cond_resched();
> +			spin_lock(&pool->lock);
> +		}
> +	}
> +out:
>  	spin_unlock(&pool->lock);
>  
>  	return pages_freed;
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
