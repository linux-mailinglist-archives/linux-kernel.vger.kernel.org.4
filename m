Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E19E660B7F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjAGBbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGBbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:31:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31806699E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iUFnnXUqgMwIg2qA00uRPnlekCgES3Ipud2o4OQ0dCQ=; b=PZfCfbmCnVy4+gQSFnFUcJt1rB
        z/1suDbY3soWCF+/jGKRCigg9n5MToaGpmfusJOKoloSbH1q0mQmDkPoaMbAXIDAIYLWhfnv0SgFd
        kJDFqJ/YxFRS14jjuTSDAdMj6nGUpyy6EsuFa84bQPnvNUDGyFE8KzVzA/Q7v4yLGAspw9EJ+M63R
        b1G1TGHL3wScfi3nhgbE3U/EU02CgoPXgXGCqwdDCONtJVc2uQZsGUi3+je3ocwRPMzJXz6z7YGiy
        gOvRpiljOwSeWIzzmD1QoK6toPMJZipQDY6zj+TmIVyhVCj2k+zUhJpSHFFxaIntC4F4afVArzp6k
        kvfXRDuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDy32-000AF3-GX; Sat, 07 Jan 2023 01:31:00 +0000
Date:   Sat, 7 Jan 2023 01:31:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
 <Y7jGyH9Atv3sPjcZ@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7jGyH9Atv3sPjcZ@monkey>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:11:36PM -0800, Mike Kravetz wrote:
> On 01/03/23 13:13, Sidhartha Kumar wrote:
> > @@ -3477,15 +3477,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> >  	mutex_lock(&target_hstate->resize_lock);
> >  	for (i = 0; i < pages_per_huge_page(h);
> >  				i += pages_per_huge_page(target_hstate)) {
> > -		subpage = nth_page(page, i);
> > -		folio = page_folio(subpage);
> > +		subpage = folio_page(folio, i);
> > +		subfolio = page_folio(subpage);
> 
> No problems with the code, but I am not in love with the name subfolio.
> I know it is patterned after 'subpage'.  For better or worse, the term
> subpage is used throughout the kernel.  This would be the first usage of
> the term 'subfolio'.
> 
> Matthew do you have any comments on the naming?  It is local to hugetlb,
> but I would hate to see use of the term subfolio based on its introduction
> here.

I'm really not a fan of it either.  I intended to dive into this patch
and understand the function it's modifying, in the hopes of suggesting
a better name and/or method.

Since I haven't done that yet, maybe "new" or "dest" names work?
