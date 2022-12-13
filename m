Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2964B798
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiLMOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiLMOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:40:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079531E717
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FQag/jd2GO3yImxnyVKI+1I/10Zv1F9ZtlVjYTPl/hk=; b=LvNd3B7Y+1FKup7/J0jsz0gQCT
        vtacOOldquFFwwc67FE95SWaH6CgmDTgn8wiVwoEcrY1z9awxnM1z3DgeyrEpiXSqn2A0FzhiHY2j
        EB3U3lxlZvaKUqN3N5kxTFPlwcBwfOZQe1k1s3rQrAVvvq4PLvE+EBMyFklsvBSEZp1uRkl+6ZXnk
        ftW88Gg2M6sI99+G0W3E4PN/BOOilZfgiicCE4ozaAqmIQ3KoBSeEtLHC0+7UewnE8sDXqJBcp/Kl
        1vu7JdoPJwVWQqEbyVVmCQXd5bMNYI0byAVfuWOM693g2s+k8nYtZQ+ZRHpOW7OHbLSu4nua01UiN
        0msfGlxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p56SX-00CJ9w-UA; Tue, 13 Dec 2022 14:40:42 +0000
Date:   Tue, 13 Dec 2022 14:40:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        vishal.moola@gmail.com
Subject: Re: [PATCH -next 4/8] mm: damon: add temporary damon_get_folio()
Message-ID: <Y5iO6VSsyDiQQ2mk@casper.infradead.org>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213092735.187924-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:27:31PM +0800, Kefeng Wang wrote:
> -struct page *damon_get_page(unsigned long pfn)
> +struct folio *damon_get_folio(unsigned long pfn)
>  {
> -	struct page *page = pfn_to_online_page(pfn);
> +	struct folio *folio = pfn_to_online_folio(pfn);
>  
> -	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
> +	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
>  		return NULL;

Well, this is awkward.  I asked Vishal to think about exactly this problem
and we were going to talk about it after we're both back from vacation
in January.  But I guess we're going to do this in public instead ...

Specifically, what should the semantics be for a putative
damon_get_folio() when it encounters a tail page?  Should it return
the containing folio, or should it return NULL?  And if the semantics
change here to return the containing folio, what adjustments need to
be made to the callers?
