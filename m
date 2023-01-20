Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD1674CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjATFsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjATFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:48:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD111664
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HRjwOCVzwM/JW0nRSbGXBKRTYmFcFNAcwf5tRy6Wjq8=; b=ZScI6oZlQ7OMuf2sCUd8I7tW18
        LTf13QwNry53D3aVeuvTAMDXP20zG98bna3DYZQKwZhKRBxPGFDj3n5oIMBVqKkqOexJKfedtrfMT
        RwJ6T3l9A40J7bzI3nh/rkWXqu5QkqJb9jAGPWnOFRvxVWZXfBKMk1QS0AqJchv5WQstfd30k2jSL
        hQMW2QSwVSC3vHWERzQP2qyIHaccG4KPimx4Qq1R2/dBv4JZdb3LT17Oc3sLFg3EnE0XYx/5Zd3SA
        QjBZLV76VGJy4VATUcQiun3SY9grv09T50xsz9/zou0N3h6YY2wGcVqRngqHBPD7qGB5fsGBXELzl
        3lq72dvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIkGQ-001hrA-Na; Fri, 20 Jan 2023 05:48:35 +0000
Date:   Fri, 20 Jan 2023 05:48:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
Subject: Re: [PATCH 3/9] mm/hugetlb: convert putback_active_hugepage to take
 in a folio
Message-ID: <Y8orMisdXzaUI0t8@casper.infradead.org>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-4-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119211446.54165-4-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:14:40PM -0800, Sidhartha Kumar wrote:
> -void putback_active_hugepage(struct page *page)
> +void putback_active_hugetlb_folio(struct folio *folio)

Maybe call this folio_putback_active_hugetlb()?  It fits better
with folio_putback_lru().

> +++ b/mm/migrate.c
> @@ -151,7 +151,7 @@ void putback_movable_pages(struct list_head *l)
>  
>  	list_for_each_entry_safe(page, page2, l, lru) {
>  		if (unlikely(PageHuge(page))) {
> -			putback_active_hugepage(page);
> +			putback_active_hugetlb_folio(page_folio(page));
>  			continue;
>  		}
>  		list_del(&page->lru);

Maybe we need a patch first to convert this loop from an iteration of
page->lru to folio->lru to avoid that call to page_folio()?

