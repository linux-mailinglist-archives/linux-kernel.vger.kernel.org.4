Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63955634E87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiKWD6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKWD6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:58:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE3C656F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:58:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so16238318pfz.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqMP70LRlh5Jd8wsQoL6S/btce+HcGngTAhh45D7tCY=;
        b=BG8Nbnc69eedIhFmOpmB/urVgGyPR4LlJ79aCi0+c6F+XkXLkPkT44JnA++Nb4uF6N
         nLIBpCY2XsGfdprNauRVPS+iNnV7nu3ZVT5QoS41vPWIyveZpfPcrnWz6t31q3uDRje2
         hGg7dBODU67l7TWxUSwHzWMELoanYoXoIQSw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqMP70LRlh5Jd8wsQoL6S/btce+HcGngTAhh45D7tCY=;
        b=xEczwKVcR32xjN1nM5DT8bwfNvaN3oa2BjO3I1zaBEvYWDhP7+I7JD3wd4gBM1YsMz
         NIt1Y9joOKcWk0kXHX9oEKIWicUaNbkaQGg1o5MFU5iAEYu0Mn5DC6+VRwlXBchpBqP9
         QSkk2eNl7lN8ZfLodB7ZeMOs+REULTgwKBK0cfc08EnHiRHt8o2D/6RHIqVIuS8Z8rE2
         KGZydEreAz166OoTUSnxbh/ZRpueK/JQLkrN1GGUOfUjb3YIy0KvGslSCPF2rVWLHOpV
         Ao0UElK/ClEXnYw/lHpVw8pP8LymJtPPj6UUvJJ9Krdmf1g8eYb0H3eDopGLrT9aSY8P
         udXg==
X-Gm-Message-State: ANoB5pl8o0lttZqZnGx3zU3pWXiZc5UvLJsuJWYxP2065bGTjvSrsrWF
        kFUDSak3gl6uj7qlAJgrT5r6qQ==
X-Google-Smtp-Source: AA0mqf6nj4CwJyIsIAHJm3jBJNlvWYbYgKXDWoWItzDNm2EnpFNscAkY8r3qprwjPuBYonKnLiIDrg==
X-Received: by 2002:a65:60c7:0:b0:476:aad3:90e2 with SMTP id r7-20020a6560c7000000b00476aad390e2mr6038117pgv.217.1669175914415;
        Tue, 22 Nov 2022 19:58:34 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:b570:e8d2:6522:6054])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090ae51500b0021894e92f82sm330530pjy.36.2022.11.22.19.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 19:58:33 -0800 (PST)
Date:   Wed, 23 Nov 2022 12:58:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y32aZCYlAzONnaC4@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
> +#ifdef CONFIG_ZPOOL
> +	/* Move the zspage to front of pool's LRU */
> +	if (mm == ZS_MM_WO) {
> +		if (!list_empty(&zspage->lru))
> +			list_del(&zspage->lru);
> +		list_add(&zspage->lru, &pool->lru);
> +	}
> +#endif

Just an idea.

Have you considered having size class LRU instead of pool LRU?

Evicting pages from different classes can have different impact on the
system, in theory. For instance, ZS_FULL zspage in class size 3264
(bytes) holds 5 compressed objects per-zspage, which are 5 compressed
swapped out pages. While zspage in a class size 176 (bytes) holds 93
compressed objects (swapped pages). Both zspages consist of 4
non-contiguous 0-order physical pages, so when we free zspage from these
classes we release 4 physical pages. However, in terms of major
page faults evicting a page from size class 3264 looks better than from
a size class 176: 5 major page faults vs 93 major page faults.

Does this make sense?
