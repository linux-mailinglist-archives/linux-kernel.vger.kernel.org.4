Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D064BD19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiLMTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiLMTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C111274D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 353BBB815B1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6C6C433EF;
        Tue, 13 Dec 2022 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670959133;
        bh=TnGFtpo/Gv6B9vWS/Wf+h/ZzAKUAJ0Ui+Kiqz4jbn+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWAKTsGuzWZbpFnlq/Ya+YL1ixTLq31LqywtwQUjkK1tyhWceH4KXHLwdQoa1ss6F
         JR766RqxBcp3uYEOZjSRggwmyJUciPFnsK7DeH9uCOD2H7y8Pp5a5rGI1f7/9sRwTj
         btehXRDmlEJZWxCf82CkB1n1OSY0GHxC0an+2zobCA4R81RK97DMM2TrTSBYpqgxry
         c6eLSdg69Y46jZaoEgP78R44IofwHRJU9CNPIPvR6knuUlAessUYZ9L8zHOByJETQa
         2Yins9gTJyEfS+Ml7zQJbCxTI5ism0KQBlPrEaKcTFwZlx8p4OS7sGXYwpIUQ7WAiz
         g2RxbaBH+etyw==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        vishal.moola@gmail.com
Subject: Re: [PATCH -next 4/8] mm: damon: add temporary damon_get_folio()
Date:   Tue, 13 Dec 2022 19:18:51 +0000
Message-Id: <20221213191851.138660-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y5iO6VSsyDiQQ2mk@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 14:40:41 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 13, 2022 at 05:27:31PM +0800, Kefeng Wang wrote:
> > -struct page *damon_get_page(unsigned long pfn)
> > +struct folio *damon_get_folio(unsigned long pfn)
> >  {
> > -	struct page *page = pfn_to_online_page(pfn);
> > +	struct folio *folio = pfn_to_online_folio(pfn);
> >  
> > -	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
> > +	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
> >  		return NULL;
> 
> Well, this is awkward.  I asked Vishal to think about exactly this problem
> and we were going to talk about it after we're both back from vacation
> in January.  But I guess we're going to do this in public instead ...
> 
> Specifically, what should the semantics be for a putative
> damon_get_folio() when it encounters a tail page?  Should it return
> the containing folio, or should it return NULL?  And if the semantics
> change here to return the containing folio, what adjustments need to
> be made to the callers?

I'd prefer to simply keep the original behavior, returning NULL, for now unless
someone complaints.


Thanks,
SJ
