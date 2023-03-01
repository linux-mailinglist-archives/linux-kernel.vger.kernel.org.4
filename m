Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09016A66C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCADru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCADro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:47:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002B31E07
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:47:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso362697pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKaH6/REh8ekLOwaOfXspdYFMio8EvWqkz99kuz6IQE=;
        b=VOEtrUmxmdEdwI97eTsL2Q/5ZOlXccqm5SRwKlGdhKwWWqUpcfNjF6TJ/wec7+3UUb
         mQpFLbS8BhEQSan8xb7d/M7cKeGn2diTQO5LGUES6dqE2cf4DidOCe6k99fGHhOVL9gA
         AwMMTMOEmN8PvsmZPetjn9grZOo2cjkCtssYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKaH6/REh8ekLOwaOfXspdYFMio8EvWqkz99kuz6IQE=;
        b=i1dXSiMzdHmXwWixUs+JWYP/hMVbwDdHL1i2jnYn7zaOTuS4tOn1wjqAXEY1zMefCu
         TEirPf/s7vJbzeZIY2AoSPFRyj7URWpFM3R7m8me6Vk8DVS+LjTapDRz8qw+Df4YblZ8
         TYBUBJ/cL/F5lcE74CCyKukqi/dq+u0o4kLVxAWoUU4fdAG4ZUP8vrysf5q7PA7zj9E9
         MMOLbAdsciokSDB025ZmxY9JPREHNBadjTuC92qYxoXtKLP5gaXoNtm4LQqwZU6O3RFy
         zOxUIzcebQap9K7+qdrl4wXkH6+qRbOe4q2f0+/G75KYdbxEeAh/xkYbUvuHMFjgNYJP
         Ek8Q==
X-Gm-Message-State: AO0yUKWZKFSHNVbOZhD+v3b12u9Hh6yAlFM/S4ziwGFvw6dMCua3uWQX
        q7ZbQmsTgADdbLNaWcWparztxA==
X-Google-Smtp-Source: AK7set9Hb5hlwN0O5/09KWBEa+JZ33qHhguPe+JmIMOBDRTQ16JU5ENHH/Ajl41Tyc/StXo8G0r8HQ==
X-Received: by 2002:a17:90b:4b91:b0:22b:fd64:c48e with SMTP id lr17-20020a17090b4b9100b0022bfd64c48emr6063712pjb.14.1677642428676;
        Tue, 28 Feb 2023 19:47:08 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090ae50c00b002376d85844dsm6799915pjy.51.2023.02.28.19.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:47:08 -0800 (PST)
Date:   Wed, 1 Mar 2023 12:47:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 4/6] zsmalloc: rework compaction algorithm
Message-ID: <Y/7KtwtAyAfuyJ0d@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-5-senozhatsky@chromium.org>
 <Y/6K5+pC+nXvDsjq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/6K5+pC+nXvDsjq@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/28 15:14), Minchan Kim wrote:
> So, how about this on top of your patch?
> 

Looks good. Let me pick it up.

> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index eacf9e32da5c..4dfc910f5d89 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -2223,40 +2223,33 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  	 * as well as zpage allocation/free
>  	 */
>  	spin_lock(&pool->lock);
> -	while (1) {
> +	while (zs_can_compact(class)) {
> +		int ret;
> +
>  		if (!dst_zspage) {
>  			dst_zspage = isolate_dst_zspage(class);
>  			if (!dst_zspage)
> -				goto out;
> +				break;
>  			migrate_write_lock(dst_zspage);
>  			cc.d_page = get_first_page(dst_zspage);
>  		}
>  
> -		if (!zs_can_compact(class)) {
> -			putback_zspage(class, dst_zspage);
> -			migrate_write_unlock(dst_zspage);
> -			goto out;
> -		}
> -
>  		src_zspage = isolate_src_zspage(class);
> -		if (!src_zspage) {
> -			putback_zspage(class, dst_zspage);
> -			migrate_write_unlock(dst_zspage);
> -			goto out;
> -		}
> +		if (!src_zspage)
> +			break;
>  
>  		migrate_write_lock_nested(src_zspage);
> -
>  		cc.obj_idx = 0;
>  		cc.s_page = get_first_page(src_zspage);
> +
>  		migrate_zspage(pool, class, &cc);
> +		ret = putback_zspage(class, src_zspage);
> +		migrate_write_unlock(src_zspage);
>  
> -		if (putback_zspage(class, src_zspage) == ZS_INUSE_RATIO_0) {
> -			migrate_write_unlock(src_zspage);
> +		if (ret == ZS_INUSE_RATIO_0) {
>  			free_zspage(pool, class, src_zspage);
>  			pages_freed += class->pages_per_zspage;
> -		} else {
> -			migrate_write_unlock(src_zspage);
> +			src_zspage = NULL;
>  		}
>  
>  		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
> @@ -2264,14 +2257,22 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  			putback_zspage(class, dst_zspage);
>  			migrate_write_unlock(dst_zspage);
>  			dst_zspage = NULL;
> -		}
>  
> -		if (!dst_zspage) {
>  			spin_unlock(&pool->lock);
>  			cond_resched();
>  			spin_lock(&pool->lock);
>  		}
>  	}
> +
> +	if (src_zspage) {
> +		putback_zspage(class, src_zspage);
> +		migrate_write_unlock(src_zspage);
> +	}
> +
> +	if (dst_zspage) {
> +		putback_zspage(class, dst_zspage);
> +		migrate_write_unlock(dst_zspage);
> +	}
>  out:
>  	spin_unlock(&pool->lock);
>  
