Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8FB615AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKBDmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKBDmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:42:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7152926ADB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:42:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q9so198395pfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo23rdptXeonGeV+R+rAP3rUmFYr9yR6UUbFic0TMHM=;
        b=Ej7aSHjtyIcfBIc+mXwGkpDPO/8iWJd7WvOMKVWE7hrCgZlw4b1fV14PjOH/sqi9Ky
         wnr7vwVt2ZDmK1TGnqgdOOQ4GN1Fmd/cv1wdliqW+KcABkCoMKjLQ3g7x01FizZH6HD3
         5x/CFyTc7nUU+7RAJG0dswlsWc9Z+xc3laUiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo23rdptXeonGeV+R+rAP3rUmFYr9yR6UUbFic0TMHM=;
        b=Y342bTdrPkDfw5O911UljnVREuOT9BEVHJBwJeosTz8NVu3KNWJ6pX822M2rIR6/16
         79KaLCHHum5DdOEOA3h3WZO3/edbUe+UP5NUB3FjmvlE3tSFhwiH2D+daKdUhdkbVbTf
         QVT0l0w2/4OhyYA+/eEroHP1xxQadWQxOCGOj28ehmvGcloKEZUK7Y8XTNRtRKd/dAL5
         xwL+9sIYpSr9Kf6huCZkmOm1svoF7f1v6sdKYzqvaPKDMzG7IC3W43SZ6bxwg3mfBBeb
         vQbfu9h0oSdPuFlqYMfLAF0+33M65jvYxHcW3Xs5jLwKvwDb2ydn2GDenq1zdWO+G73B
         bZbQ==
X-Gm-Message-State: ACrzQf0rMWjG9H0t9FCSZk8TU5wlgqw+se7l7Jrt3kHq1rGv1aJOp8Hh
        hZ3wQIu1MY6JefcFKa/LIjlWzA==
X-Google-Smtp-Source: AMsMyM5bZXD48076Ge2HXaXwzUt1HHHf5Ug7/VXNl31WPVwEIU4kov8PXoyBU4VaX/MbTOVpkAxAcQ==
X-Received: by 2002:a63:501f:0:b0:46f:a711:c455 with SMTP id e31-20020a63501f000000b0046fa711c455mr15000744pgb.402.1667360532351;
        Tue, 01 Nov 2022 20:42:12 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f558:dfb0:7cb7:44d9])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a1bc100b0020dda7efe61sm318368pjr.5.2022.11.01.20.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 20:42:11 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:42:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y2HnDi4K7lxKkptY@google.com>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027182736.513530-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/27 11:27), Nhat Pham wrote:
[..]
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
> +	if (!pool->ops || !pool->ops->evict || list_empty(&pool->lru) ||
> +			retries == 0) {
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
> +		/* Lock backing pages into place */
> +		lock_zspage(zspage);

Does this call into the scheduler under pool->lock spinlock?
