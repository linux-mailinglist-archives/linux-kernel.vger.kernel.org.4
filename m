Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF0608F3D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJVTeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:34:19 -0400
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8022B10EE70
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 12:34:17 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id ADE8A2363
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 20:34:15 +0100 (IST)
Received: (qmail 2763 invoked from network); 22 Oct 2022 19:34:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2022 19:34:15 -0000
Date:   Sat, 22 Oct 2022 20:34:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: prep_compound_tail() clear page->private
Message-ID: <20221022193413.ihgfs5ipy3la3c6a@techsingularity.net>
References: <1c4233bb-4e4d-5969-fbd4-96604268a285@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1c4233bb-4e4d-5969-fbd4-96604268a285@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 12:51:06AM -0700, Hugh Dickins wrote:
> Although page allocation always clears page->private in the first page
> or head page of an allocation, it has never made a point of clearing
> page->private in the tails (though 0 is often what is already there).
> 
> But now commit 71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t
> during THP split") issues a warning when page_tail->private is found to
> be non-0 (unless it's swapcache).
> 
> Change that warning to dump page_tail (which also dumps head), instead
> of just the head: so far we have seen dead000000000122, dead000000000003,
> dead000000000001 or 0000000000000002 in the raw output for tail private.
> 

The intent behind dumping the head was because I expected we'd be mid-split
and the head page was more meaningful but your patch also works.

> We could just delete the warning, but today's consensus appears to want
> page->private to be 0, unless there's a good reason for it to be set:

This was also on purpose. I suspected the warning would create a few new
reports but if page->private should be 0 then it's better to start catching
it now instead of later. At least we're still in an early rc kernel.

> so now clear it in prep_compound_tail() (more general than just for THP;
> but not for high order allocation, which makes no pass down the tails).
> 
> Fixes: 71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t during THP split")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: <stable@vger.kernel.org>

Thanks Hugh.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
