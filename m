Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290C73D12B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFYNcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFYNcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:32:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902BCE40
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iQKsxGf0wGFzeonsn1JR0DJPTitXKOWsG26LbyalNmU=; b=YPft3+6PHj814dmedSwtgiZgux
        Id/GrgPDfoaHMe4bnj+y6+RH57Xz0W6cRTfW9b178w8BSjicIu0cYUTnr9UDJfBhmfv33YNJcEFy4
        5MlDg2Z6vi0o6L9dXP4Tn6rvDa/H+bmD1B/aeKzlLcDtYivorBZUZxaQXPIT6meIrHKe7UcPxk3sL
        8dInKPw8+Kf3NumsWczIRs+Jw36gPqDMmGCQPw4xQNT6/fzBpcAi5iM1WIUYnP0cbGTQlM2rfi4av
        8JfqgCI/Brn/Zb5rXHmSZuBPvbu65mqBya8kZZoNNPU/rwl76pv+Lk6F56afm/Bpo94g4maPg+nil
        BqntyrQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDPql-000lZ1-4b; Sun, 25 Jun 2023 13:32:19 +0000
Date:   Sun, 25 Jun 2023 14:32:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: remove unneeded page state check in
 shake_page()
Message-ID: <ZJhB45caQYmG+fwp@casper.infradead.org>
References: <20230625113430.2310385-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625113430.2310385-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 07:34:30PM +0800, Miaohe Lin wrote:
> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
> are not shrunk now. This check can be added back when a lightweight range
> based shrinker is available.

I think your logic is faulty.  Based on the reasoning above, this patch
should be:

> -	if (!PageSlab(p)) {
> -		lru_add_drain_all();
> -		if (PageLRU(p) || is_free_buddy_page(p))
> -			return;
> -	}
> +	if (PageSlab(p))
> +		return;
> +
> +	lru_add_drain_all();
+	if (PageLRU(p) || is_free_buddy_page(p))
+		return;

but maybe it's the description that is wrong.
