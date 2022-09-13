Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37E5B7D20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIMWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiIMWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188F31DE4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77EBC6162D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF9FC433D6;
        Tue, 13 Sep 2022 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663108544;
        bh=tvZFJ19+7tC+yu/Q+tS0Oet4y1JWCFDLzkm3xc5ISec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=shY4cMFf9JEUO3QY7+OHeNlkkL6PvhyuJJ5bX6bIp7BmczA8wjg+7MDA3QhA4+rZ0
         pZRIiLErwp4u6ZF2R0g6YnlrOjoHQIn2J5R2i6JE6qplilvAAgkHHifpe3aiVIbZ5t
         4lxFiShLcNam2mzZT5a/rfXukORDzDArAVkRjwyg=
Date:   Tue, 13 Sep 2022 15:35:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: Re: [PATCH 1/2] mm: fix logic error of bulkfree_pcp_prepare
Message-Id: <20220913153543.c8094b34fe9ddabba4599e7a@linux-foundation.org>
In-Reply-To: <1663049446-22310-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1663049446-22310-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 14:10:45 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> free_pages_check return 0 when result is ok while bulkfree_pcp_prepare
> treat it as false wrongly.

It's called check_free_page().

And that's a poor name because the name doesn't communicate what a
true/false return value means - was the page good or bad?

So I'd propose this renaming:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/page_alloc.c: rename check_free_page() to free_page_is_bad()
Date: Tue Sep 13 03:20:48 PM PDT 2022

The name "check_free_page()" provides no information regarding its return
value when the page is indeed found to be bad.

Renaming it to "free_page_is_bad()" makes it clear that a `true' return
value means the page was bad.

And make it return a bool, not an int.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/mm/page_alloc.c~a
+++ a/mm/page_alloc.c
@@ -1290,20 +1290,20 @@ static const char *page_bad_reason(struc
 	return bad_reason;
 }
 
-static void check_free_page_bad(struct page *page)
+static void free_page_bad_report(struct page *page)
 {
 	bad_page(page,
 		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
 }
 
-static inline int check_free_page(struct page *page)
+static inline bool free_page_bad(struct page *page)
 {
 	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
-		return 0;
+		return false;
 
 	/* Something has gone sideways, find it */
-	check_free_page_bad(page);
-	return 1;
+	free_page_bad_report(page);
+	return true;
 }
 
 static int free_tail_pages_check(struct page *head_page, struct page *page)
@@ -1436,7 +1436,7 @@ static __always_inline bool free_pages_p
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-			if (unlikely(check_free_page(page + i))) {
+			if (unlikely(free_page_bad(page + i))) {
 				bad++;
 				continue;
 			}
@@ -1448,7 +1448,7 @@ static __always_inline bool free_pages_p
 	if (memcg_kmem_enabled() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
 	if (check_free)
-		bad += check_free_page(page);
+		bad += free_page_bad(page);
 	if (bad)
 		return false;
 
@@ -1510,7 +1510,7 @@ static bool free_pcp_prepare(struct page
 static bool bulkfree_pcp_prepare(struct page *page)
 {
 	if (debug_pagealloc_enabled_static())
-		return check_free_page(page);
+		return free_page_bad(page);
 	else
 		return false;
 }
@@ -1531,7 +1531,7 @@ static bool free_pcp_prepare(struct page
 
 static bool bulkfree_pcp_prepare(struct page *page)
 {
-	return check_free_page(page);
+	return free_page_bad(page);
 }
 #endif /* CONFIG_DEBUG_VM */
 
_

And bulkfree_pcp_prepare() is pretty bad as well - how about we
document the dang return value?

--- a/mm/page_alloc.c~b
+++ a/mm/page_alloc.c
@@ -1507,6 +1507,7 @@ static bool free_pcp_prepare(struct page
 	return free_pages_prepare(page, order, true, FPI_NONE);
 }
 
+/* return true if this page has an inappropriate state */
 static bool bulkfree_pcp_prepare(struct page *page)
 {
 	if (debug_pagealloc_enabled_static())
_

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1424,7 +1424,7 @@ static bool free_pcp_prepare(struct page *page, unsigned int order)
>  static bool bulkfree_pcp_prepare(struct page *page)
>  {
>  	if (debug_pagealloc_enabled_static())
> -		return check_free_page(page);
> +		return !check_free_page(page);
>  	else
>  		return false;
>  }
> @@ -1445,7 +1445,7 @@ static bool free_pcp_prepare(struct page *page, unsigned int order)
>  
>  static bool bulkfree_pcp_prepare(struct page *page)
>  {
> -	return check_free_page(page);
> +	return !check_free_page(page);
>  }
>  #endif /* CONFIG_DEBUG_VM */

And after clarifying these things, your patch seems incorrect.

free_pcppages_bulk() does

			if (bulkfree_pcp_prepare(page))
				continue;

in other words, it leaks the page if it was found to be messed up?
