Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA86AC21F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCFODS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCFODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:03:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DA212B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:03:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C068E1FDF9;
        Mon,  6 Mar 2023 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678111391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYnoqEXRVg+qMdr+nCTEH9NvoiErpUcpOCA1haXbDNw=;
        b=p8VodS8jKgqg95OpLwdeeP4M0upBsUSA0EPLP3tQ5uRZAvppX0Q0fOMrlE/YIYoomrPyOr
        OU2aGTMvvGBvuSHIYkLqXbE4aV2Zgj1zpDJOKFBuh8jYlmfMdfTSd5hw8h5i2XLly6J73e
        +Kp/wfIvetaZ/0q2hEyS9ozZXCSQsz0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A426F13513;
        Mon,  6 Mar 2023 14:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h0Q2JZ/yBWSpdgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 14:03:11 +0000
Date:   Mon, 6 Mar 2023 15:03:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] mm, vmalloc: fix high order __GFP_NOFAIL allocations
Message-ID: <ZAXynvdNqcI0f6Us@dhcp22.suse.cz>
References: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
 <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
 <ZAXZMz0n+CpWPVqy@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAXZMz0n+CpWPVqy@pc636>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-03-23 13:14:43, Uladzislau Rezki wrote:
[...]
> Some questions:
> 
> 1. Could you please add a comment why you want the bulk_gfp without
> the __GFP_NOFAIL(bulk path)?

The bulk allocator is not documented to fully support __GFP_NOFAIL
semantic IIRC. While it uses alloc_pages as fallback I didn't want
to make any assumptions based on the current implementation. At least
that is my recollection. If we do want to support NOFAIL by the batch
allocator then we can drop the special casing here.

> 2. Could you please add a comment why a high order pages do not want
> __GFP_NOFAIL? You have already explained.

See below
> 3. Looking at the patch:
> 
> <snip>
> +       } else {
> +               alloc_gfp &= ~__GFP_NOFAIL;
> +               nofail = true;
> <snip>
> 
> if user does not want to go with __GFP_NOFAIL flag why you force it in
> case a high order allocation fails and you switch to 0 order allocations? 

Not intended. The above should have been else if (gfp & __GFP_NOFAIL).
Thanks for catching that!

This would be the full patch with the description:
--- 
From 3ccfaa15bf2587b8998c129533a0404fedf5a484 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 6 Mar 2023 09:15:17 +0100
Subject: [PATCH] mm, vmalloc: fix high order __GFP_NOFAIL allocations

Gao Xiang has reported that the page allocator complains about high
order __GFP_NOFAIL request coming from the vmalloc core:

 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
 kvmalloc_node+0x156/0x1a0 mm/util.c:606
 kvmalloc include/linux/slab.h:737 [inline]
 kvmalloc_array include/linux/slab.h:755 [inline]
 kvcalloc include/linux/slab.h:760 [inline]

it seems that I have completely missed high order allocation backing
vmalloc areas case when implementing __GFP_NOFAIL support. This means
that [k]vmalloc at al. can allocate higher order allocations with
__GFP_NOFAIL which can trigger OOM killer for non-costly orders easily
or cause a lot of reclaim/compaction activity if those requests cannot
be satisfied.

Fix the issue by falling back to zero order allocations for __GFP_NOFAIL
requests if the high order request fails.

Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ef910bf349e1..bef6cf2b4d46 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2883,6 +2883,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	gfp_t alloc_gfp = gfp;
+	bool nofail = false;
 	struct page *page;
 	int i;
 
@@ -2893,6 +2895,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
+		/* bulk allocator doesn't support nofail req. officially */
 		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
 
 		while (nr_allocated < nr_pages) {
@@ -2931,20 +2934,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
+	} else if (gfp & __GFP_NOFAIL) {
+		/*
+		 * Higher order nofail allocations are really expensive and
+		 * potentially dangerous (pre-mature OOM, disruptive reclaim
+		 * and compaction etc.
+		 */
+		alloc_gfp &= ~__GFP_NOFAIL;
+		nofail = true;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
-
 	while (nr_allocated < nr_pages) {
 		if (fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)
-			page = alloc_pages(gfp, order);
+			page = alloc_pages(alloc_gfp, order);
 		else
-			page = alloc_pages_node(nid, gfp, order);
-		if (unlikely(!page))
-			break;
+			page = alloc_pages_node(nid, alloc_gfp, order);
+		if (unlikely(!page)) {
+			if (!nofail)
+				break;
+
+			/* fall back to the zero order allocations */
+			alloc_gfp |= __GFP_NOFAIL;
+			order = 0;
+			continue;
+		}
+
 		/*
 		 * Higher order allocations must be able to be treated as
 		 * indepdenent small pages by callers (as they can with
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
