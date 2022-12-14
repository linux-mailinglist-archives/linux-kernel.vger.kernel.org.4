Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0408264CE99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiLNREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLNREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:04:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2A12AD3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gOpGhv6UKz7VHR3jMFGZw2EISvCY2AuNGxNyyrkNXxA=; b=a0+L0Q0/xdslYVEnG3wV0PLkbV
        w2MST8acNOJgFLkYs124lEDIZDn1yO+vxjDFs5Iv4K5iSkHIgcvNW+tPvYbJB8XNGVvUjK5Areghc
        duAsWRMQwVo4ObmiFjxgCBrQ2DRj+k+CXmK6XDAN/b+OnLaJoTVeWmRTkAhkMMgKYS5x4fLfkDqoq
        dLyxrp6e4/YQeisgHYNgge4iKFNMEMwNfX7yHVJ3ogsNt//Ep6P3voubw8H5O6DyIVaWFisBzUnRD
        RyO8VuSn00gmggOhzseEzT7BSFJSuv44tpGI6N6pCF2T/UJgYc945Xm7epcNg+ceOmzbh5G8Tn40i
        6nZqWbnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5VB1-00DR0S-U5; Wed, 14 Dec 2022 17:04:15 +0000
Date:   Wed, 14 Dec 2022 17:04:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, gerald.schaefer@linux.ibm.com
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in
 set_compound_order
Message-ID: <Y5oCD0gFV+Cq1JqJ@casper.infradead.org>
References: <20221213234505.173468-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213234505.173468-1-npache@redhat.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:45:05PM -0700, Nico Pache wrote:
> Since commit 1378a5ee451a ("mm: store compound_nr as well as
> compound_order") the page[1].compound_nr must be explicitly set to 0 if
> calling set_compound_order(page, 0).
> 
> This can lead to bugs if the caller of set_compound_order(page, 0) forgets
> to explicitly set compound_nr=0. An example of this is commit ba9c1201beaa
> ("mm/hugetlb: clear compound_nr before freeing gigantic pages")
> 
> Collapse these calls into the set_compound_order by utilizing branchless
> bitmaths [1].
> 
> [1] https://graphics.stanford.edu/~seander/bithacks.html#ConditionalSetOrClearBitsWithoutBranching
> 
> V2: slight changes to commit log and remove extra '//' in the comments

We don't usually use // comments anywhere in the kernel other than
the SPDX header.

>  static inline void set_compound_order(struct page *page, unsigned int order)
>  {
> +	unsigned long shift = (1U << order);

Shift is a funny name for this variable.  order is the shift.  this is 'nr'.

>  	page[1].compound_order = order;
>  #ifdef CONFIG_64BIT
> -	page[1].compound_nr = 1U << order;
> +	// Branchless conditional:
> +	// order  > 0 --> compound_nr = shift
> +	// order == 0 --> compound_nr = 0
> +	page[1].compound_nr = shift ^ (-order  ^ shift) & shift;

Can the compiler see through this?  Before, the compiler sees:

	page[1].compound_order = 0;
	page[1].compound_nr = 1U << 0;
...
	page[1].compound_nr = 0;

and it can eliminate the first store.  Now the compiler sees:

	unsigned long shift = (1U << 0);
	page[1].compound_order = order;
	page[1].compound_nr = shift ^ (0  ^ shift) & shift;

Does it do the maths at compile-time, knowing that order is 0 at this
callsite and deducing that it can just store a 0?

I think it might, since shift is constant-1,

	page[1].compound_nr = 1 ^ (0 ^ 1) & 1;
->	page[1].compound_nr = 1 ^ 1 & 1;
->	page[1].compound_nr = 0 & 1;
->	page[1].compound_nr = 0;

But you should run it through the compiler and check the assembly
output for __destroy_compound_gigantic_page().

