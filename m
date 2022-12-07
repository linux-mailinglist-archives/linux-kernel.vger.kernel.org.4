Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5076464CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLGXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLGXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:11:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63EB7E433
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3nhWzv5kOP+18jCYMyraj01yZ+JzMJWApOTFLI0bTRQ=; b=FydI6eJmQWybADU8AzYClMtvWI
        SnV3+4iqHL0dfU3JsO4kIyiOIzhsBjCoIDcDB9ZU8kq+/6jqiV873YLqBv20a+QNvSp3gufk52pXJ
        n5hz2ZaCEa1kRf2XVtabRlFLisEWFTkg8ZQ4k5/a25kZd0ypoghg4ZyGkg6Oo51UpDIL+eRL7rCA0
        FIDfahjK0fo9IWnsqv7tY6tEt0+/b4tJK2L9WR6L0pPmOKVdM7Bm/1ORVWMsYEZYTeruKLWswHKbN
        +MZJPOhdIoHKVATjNIopJBJtTCi0S/7moEs4YRGj02+5eHtVV5hXaW7Pt/oy1kO/k8eo2R/oHNJAG
        /wrO69pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p33Zo-006IWy-KV; Wed, 07 Dec 2022 23:11:44 +0000
Date:   Wed, 7 Dec 2022 23:11:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v2 3/3] mm/swap: Convert deactivate_page() to
 folio_deactivate()
Message-ID: <Y5EdsKDGFEvVVKkZ@casper.infradead.org>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
 <20221207230152.22938-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207230152.22938-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:01:52PM -0800, Vishal Moola (Oracle) wrote:
> +++ b/include/linux/swap.h
> @@ -409,7 +409,7 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> -extern void deactivate_page(struct page *page);
> +extern void folio_deactivate(struct folio *folio);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);

Using 'extern' on function prototypes is now unfashionable; you can drop
it if you respin this patch.

