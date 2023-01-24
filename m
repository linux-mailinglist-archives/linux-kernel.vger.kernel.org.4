Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E2679E22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjAXQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAXQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:01:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5372716
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hkh5K4jyAqgzmiFmFW2WqeTxVkkPEbaiESIFph5SX84=; b=VTgexlACJsRFoRVYF+HcNVD6vI
        Jfq7HG/1/yy9FJxu+FsgoHh7PziiZO+mPlmav5vO3e19WDSCFjNteLwdBwMeGdYO0ysTqJyWn4eSR
        DFec/qTuOJXWGal4t/DjpOVR5div5KjuaCpSOmR5YeQxuIYtJR4ceJyA5bgcyCp2EXjChcav2bzEG
        0I8oGuiQnacigcIPfuKwySh7rE9jCdCBAho0lzxIPK+svC5i9BYNQoHDw1ZPhqyplJ+StoWxzF4sa
        NLrgKl7Oytdpn/7WK/wGtMydRkurhykTTccY90Nj95Sg0DwDzdCVHlSJ4bJnBR8BP+0Y/oPoZJx72
        MJ+u+NXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKLjl-005AlI-Tb; Tue, 24 Jan 2023 16:01:30 +0000
Date:   Tue, 24 Jan 2023 16:01:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, markhemm@googlemail.com,
        hughd@google.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V5,2/2] mm: shmem: implement
 POSIX_FADV_[WILL|DONT]NEED for shmem
Message-ID: <Y9AA2cJf+J2MHRKN@casper.infradead.org>
References: <cover.1648706231.git.quic_charante@quicinc.com>
 <c2f7242faffd41f46120f82079256ece26b92bf0.1648706231.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f7242faffd41f46120f82079256ece26b92bf0.1648706231.git.quic_charante@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:08:21PM +0530, Charan Teja Kalla wrote:
> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> +				loff_t end, struct list_head *list)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start);
> +	struct page *page;
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, page, end) {
> +		if (xas_retry(&xas, page))
> +			continue;
> +		if (xa_is_value(page))
> +			continue;
> +
> +		if (!get_page_unless_zero(page))
> +			continue;
> +		if (isolate_lru_page(page)) {
> +			put_page(page);
> +			continue;
> +		}
> +		put_page(page);
> +
> +		if (PageUnevictable(page) || page_mapcount(page) > 1) {
> +			putback_lru_page(page);
> +			continue;
> +		}
> +
> +		/*
> +		 * Prepare the page to be passed to the reclaim_pages().
> +		 * VM couldn't reclaim the page unless we clear PG_young.
> +		 * Also, to ensure that the pages are written before
> +		 * reclaiming, page is set to dirty.
> +		 * Since we are not clearing the pte_young in the mapped
> +		 * page pte's, its reclaim may not be attempted.
> +		 */
> +		ClearPageReferenced(page);
> +		test_and_clear_page_young(page);
> +		list_add(&page->lru, list);
> +		if (need_resched()) {
> +			xas_pause(&xas);
> +			cond_resched_rcu();
> +		}
> +	}
> +	rcu_read_unlock();
> +}

This entire function needs to be converted to use folios instead of
pages if you're refreshing this patchset for current kernels.

