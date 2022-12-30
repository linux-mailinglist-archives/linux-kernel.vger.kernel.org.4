Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773F659626
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiL3IOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiL3IOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:14:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69C5192B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKcxZEuFQAuAVN1fDLHfDtQJh2W3Whfhs8zJpFzcCak=; b=jETa2IMTXRHLMYIFcEgHxbxej1
        6upl737hSk1SkbOJmq4z/v+XT8Wbzj8iwsdp/ZHZBBfsrybBSuL1PxSea7MiUd34vTJE2sMu6pnMD
        WBLbw7arNFYYgCEx9UwyfuD4nMyzvGy5Z36FXeMERSRcEWUMshZ+34CEdlsBcqn9Tj2Ngzr8cTWpH
        EOvEC/T28uIAmY2BbQBNaBWA8QuXxdTdQ6yVHceT2MxAi69QzRvdYvyMDahCrAtLjSEuRq+MtrN66
        YsNN/yjI64IfQ6dUbMDg5RL8/uNkKrL/vhrxMdSc0ELwdXjGN/JRs4xGi3Zp8s1/lS/w2XvsB9p+N
        QwxJJrdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pBAXB-00ARil-UI; Fri, 30 Dec 2022 08:14:33 +0000
Date:   Fri, 30 Dec 2022 08:14:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: huge_memory: convert split_huge_pages_all() to use a
 folio
Message-ID: <Y66d6edbCgs6QgMj@casper.infradead.org>
References: <20221229122503.149083-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229122503.149083-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 08:25:03PM +0800, Kefeng Wang wrote:
> -			if (!PageHead(page) || PageHuge(page) || !PageLRU(page))
> +			if (!folio_test_large(folio)
> +				|| folio_test_hugetlb(folio)
> +				|| !folio_test_lru(folio))
>  				goto next;

That is a completely illegible way of indenting this code!  There's
no visual cue when the condition stops and when the next statement
begins.  Try one of these:

			if (!folio_test_large(folio) ||
			    folio_test_hugetlb(folio) ||
			    !folio_test_lru(folio))
				goto next;

			if (!folio_test_large(folio) ||
					folio_test_hugetlb(folio) ||
					!folio_test_lru(folio))
				goto next;

