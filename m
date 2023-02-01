Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB9685CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjBABmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjBABl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:41:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5D55288
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:41:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 78so11404130pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mqcP5wX07QsbZjQzYUbztxcqm0gjg5B8nUyBqOjE+M=;
        b=Jvh88UZO9x/F4Aah44N/+34h6FNZezocFk5pVA5bh5CVS8Yn+FiDB7DjM1h380Me8x
         /3ZC+i1mdHUb9iYbCd7r13hmhAdrRzsdPjFN7vpauNVaermZTudUKiWFREy2FmbxVRQy
         N8Uz046npf+6o7GEDNPein8Bz1ADWWzGjH8wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mqcP5wX07QsbZjQzYUbztxcqm0gjg5B8nUyBqOjE+M=;
        b=P2bEzhsmV1OfRcxKuRpRPVW4QjXC/CGfsygYeSP8pN45LyOx14JYvEEhcfD3LqrgXr
         Izhfpp153gOLpQaLpNqfDpYHseIhvRqFJ58n3KfACDhtlbRIxaIZ7WNFvAjr/H+7eTQJ
         xCRUoN0mo1crQ7VDsZqz51JBF88WURV0/iD+Z8ai+QSFRJAax1CU/IawJxMzqa3NA18P
         o8Jq8gSrhAXLdkaiSyFM1BmAfW/Po41ErJl7rq3AfL4A7MjFGjrmDyyyVZ67fZTtEHgl
         QZdtOG1SgKiG693EF0+M+50k5r8rT12ee6zaKd9LxkgUfWo8ryLrjqJUnJfUcKIuBKko
         5XXw==
X-Gm-Message-State: AO0yUKXN/QQzgzgdfa/CJkp81AqS2wtZ5pzXLCV6rCaLiRAEuIEJ3cZD
        MEAz+yf12k61BSg9mOrC+j8ibw==
X-Google-Smtp-Source: AK7set8svARnOqeK8vfgSPH1APinATDmvibDOWZUZNEmvZTTrmN+cm2fWSE0VMJ+ib07J84tr7dKAA==
X-Received: by 2002:a05:6a00:1d9a:b0:592:6313:20fb with SMTP id z26-20020a056a001d9a00b00592631320fbmr568890pfw.30.1675215714093;
        Tue, 31 Jan 2023 17:41:54 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s41-20020a056a0017a900b005871b73e27dsm7674381pfg.33.2023.01.31.17.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:41:53 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:41:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: fix a race with deferred_handles storing
Message-ID: <Y9nDXBt2OR3hg5X7@google.com>
References: <20230110231701.326724-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110231701.326724-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/10 15:17), Nhat Pham wrote:
[..]
>  #ifdef CONFIG_ZPOOL
> +static void restore_freelist(struct zs_pool *pool, struct size_class *class,
> +		struct zspage *zspage)
> +{
> +	unsigned int obj_idx = 0;
> +	unsigned long handle, off = 0; /* off is within-page offset */
> +	struct page *page = get_first_page(zspage);
> +	struct link_free *prev_free = NULL;
> +	void *prev_page_vaddr = NULL;
> +
> +	/* in case no free object found */
> +	set_freeobj(zspage, (unsigned int)(-1UL));

I'm not following this. I see how -1UL works for link_free, but this
cast of -1UL to 4 bytes looks suspicious.

> +	while (page) {
> +		void *vaddr = kmap_atomic(page);
> +		struct page *next_page;
> +
> +		while (off < PAGE_SIZE) {
> +			void *obj_addr = vaddr + off;
> +
> +			/* skip allocated object */
> +			if (obj_allocated(page, obj_addr, &handle)) {
> +				obj_idx++;
> +				off += class->size;
> +				continue;
> +			}
> +
> +			/* free deferred handle from reclaim attempt */
> +			if (obj_stores_deferred_handle(page, obj_addr, &handle))
> +				cache_free_handle(pool, handle);
> +
> +			if (prev_free)
> +				prev_free->next = obj_idx << OBJ_TAG_BITS;
> +			else /* first free object found */
> +				set_freeobj(zspage, obj_idx);
> +
> +			prev_free = (struct link_free *)vaddr + off / sizeof(*prev_free);
> +			/* if last free object in a previous page, need to unmap */
> +			if (prev_page_vaddr) {
> +				kunmap_atomic(prev_page_vaddr);
> +				prev_page_vaddr = NULL;
> +			}
> +
> +			obj_idx++;
> +			off += class->size;
> +		}
> +
> +		/*
> +		 * Handle the last (full or partial) object on this page.
> +		 */
> +		next_page = get_next_page(page);
> +		if (next_page) {
> +			if (!prev_free || prev_page_vaddr) {
> +				/*
> +				 * There is no free object in this page, so we can safely
> +				 * unmap it.
> +				 */
> +				kunmap_atomic(vaddr);
> +			} else {
> +				/* update prev_page_vaddr since prev_free is on this page */
> +				prev_page_vaddr = vaddr;
> +			}

A polite and gentle nit: I'd appreciate it if we honored kernel coding
styles in zsmalloc a little bit more. Comments, function declarations, etc.
I'm personally very happy with https://github.com/vivien/vim-linux-coding-style
