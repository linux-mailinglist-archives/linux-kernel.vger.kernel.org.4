Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8D63328D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiKVCAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiKVCAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:00:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A447E1BF9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:00:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so15920143pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GgGmvs1Ahyu1NYakfF+wQ+EN1WPJgC73ojob9sWD98=;
        b=dsoyxVjsPJfZziaOkScC4QipgGCf6lVyEbE1SA654Cz0zY8WMRj6lwljMm+u6ZCsQO
         WRrTsQbqydqD8J5efIQlZ4gypoMnATwKKygGkpiPbP/JCY/LOZXUgVZfo8I8V6XnZ+Up
         Gb6OF+tlx/vNAV44rRH3EYtLQgIQNRRKdShs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GgGmvs1Ahyu1NYakfF+wQ+EN1WPJgC73ojob9sWD98=;
        b=qYjPlIkmXfnogc0106Eddl+uGrdvCFtG01bQlyL+Fo79hwY5506mGdqtwiBOBOHCa3
         hTF1U2DR7uCz1Bmpolp1XuroZ7IUUwRZ0viiZQVhGToNEtQH979U/SutSvyX7ftlqxvd
         WV7J4AA0RNZ/bolZilYmR0pjeGoUs39zzZq7k0xCN5N3JDC82ANmI94Y7YFWOcwXGM05
         c5K8uDdtvGFOTyZFIwtn9muK4TGwOCtxQIJ8t6Vfdi2pnrXz6717SrCy3nmOOYd4HdXm
         SsYRCv6pAA2MDCXCHnlgg2SPhV0SaFtiH4oEeAe9HvwVVLcrh75K0EHMITFka9TLLwAG
         DzIg==
X-Gm-Message-State: ANoB5pnmw2Sk/oEeGjZqlE+2VlSzOP1IUw5xlrmkAV0YIXL8t91JP7Xw
        mgWWuED4wE6vOGVYUFZpMOvXfA==
X-Google-Smtp-Source: AA0mqf6JDSNeMlNvF1qrQEZMqBsk4ekWK1mjYFEz9mL/IzY8wFaO4iJifcFUMt5P9r1RcbptHaucPQ==
X-Received: by 2002:a17:90a:708a:b0:20a:eaab:137 with SMTP id g10-20020a17090a708a00b0020aeaab0137mr23591043pjk.206.1669082442001;
        Mon, 21 Nov 2022 18:00:42 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id p67-20020a625b46000000b0056bd59eaef0sm9327024pfb.4.2022.11.21.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:00:41 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:00:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3wtREWjDI3UeYWF@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> +{
> +	int i, obj_idx, ret = 0;
> +	unsigned long handle;
> +	struct zspage *zspage;
> +	struct page *page;
> +	enum fullness_group fullness;
> +
> +	/* Lock LRU and fullness list */
> +	spin_lock(&pool->lock);
> +	if (list_empty(&pool->lru)) {
> +		spin_unlock(&pool->lock);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < retries; i++) {
> +		struct size_class *class;
> +
> +		zspage = list_last_entry(&pool->lru, struct zspage, lru);
> +		list_del(&zspage->lru);
> +
> +		/* zs_free may free objects, but not the zspage and handles */
> +		zspage->under_reclaim = true;
> +
> +		class = zspage_class(pool, zspage);
> +		fullness = get_fullness_group(class, zspage);
> +
> +		/* Lock out object allocations and object compaction */
> +		remove_zspage(class, zspage, fullness);
> +
> +		spin_unlock(&pool->lock);
> +
> +		/* Lock backing pages into place */
> +		lock_zspage(zspage);
> +
> +		obj_idx = 0;
> +		page = zspage->first_page;

A nit: we usually call get_first_page() in such cases.

> +		while (1) {
> +			handle = find_alloced_obj(class, page, &obj_idx);
> +			if (!handle) {
> +				page = get_next_page(page);
> +				if (!page)
> +					break;
> +				obj_idx = 0;
> +				continue;
> +			}
> +
> +			/*
> +			 * This will write the object and call zs_free.
> +			 *
> +			 * zs_free will free the object, but the
> +			 * under_reclaim flag prevents it from freeing
> +			 * the zspage altogether. This is necessary so
> +			 * that we can continue working with the
> +			 * zspage potentially after the last object
> +			 * has been freed.
> +			 */
> +			ret = pool->zpool_ops->evict(pool->zpool, handle);
> +			if (ret)
> +				goto next;
> +
> +			obj_idx++;
> +		}
