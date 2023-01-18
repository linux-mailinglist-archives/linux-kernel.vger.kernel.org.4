Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22345672AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjARVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjARVkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F23C24
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7456E61A51
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6621C433EF;
        Wed, 18 Jan 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674078017;
        bh=2tAKOt79uiNmuO0lejd8tlNauoCaC8FnJweuqfL+Ks4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ShoGBD/snhYeqkfSgFYNfejuER0iDFtULuGGqQaEiiaaOPA5EIG44pPxP1LKH1bwa
         EHtHlu9h60nsEK7Lfi/yaBRbE00HwcDRy/DTk93WCDG8JzC1x/8UTwRg9hCBVKBPWJ
         1NUtPf3QXe5JmcWCX97ivH5ChO6BRVKRy6mu0xj4=
Date:   Wed, 18 Jan 2023 13:40:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/cma: Fix potential memory loss on
 cma_declare_contiguous_nid
Message-Id: <20230118134017.c9b6e1cf0beae8e5c3bdfd8c@linux-foundation.org>
In-Reply-To: <20230118080523.44522-1-ppbuk5246@gmail.com>
References: <20230118080523.44522-1-ppbuk5246@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 17:05:23 +0900 Levi Yun <ppbuk5246@gmail.com> wrote:

> Suppose, memblock_alloc_ranged_nid with highmem_start is success
> when cma_declare_contiguous_nid is called with !fixed
> in the system 32-bit system with PHYS_ADDR_T_64BIT enabled
> with memblock.bottom_up == false.
> 
> But, Next trial to memblock_alloc_range_nid to allocate in
> [SIZE_4G, limits) nullifies former success allocated addr and
> it retries to memblock_alloc_ragne_nid again.
> 
> In this situation, first success address area is lost.
> 
> By changing order of allocation (SIZE_4G, high_memory and base) and
> checking whether allocated prevents potential memory lost.
> 

The changelog is hard to follow.  I redid it as below - please review
and correct if needed?


From: Levi Yun <ppbuk5246@gmail.com>
Subject: mm/cma: fix potential memory loss on cma_declare_contiguous_nid
Date: Wed, 18 Jan 2023 17:05:23 +0900

Suppose memblock_alloc_range_nid() with highmem_start succeeds when
cma_declare_contiguous_nid is called with !fixed on a 32-bit system with
PHYS_ADDR_T_64BIT enabled with memblock.bottom_up == false.

But the next trial to memblock_alloc_range_nid() to allocate in [SIZE_4G,
limits) nullifies former successfully allocated addr and it retries
memblock_alloc_ragne_nid().

In this situation, the first successfully allocated address area is lost.

Change the order of allocation (SIZE_4G, high_memory and base) and check
whether the allocated succeeded to prevent potential memory loss.

Link: https://lkml.kernel.org/r/20230118080523.44522-1-ppbuk5246@gmail.com
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/cma.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/mm/cma.c~mm-cma-fix-potential-memory-loss-on-cma_declare_contiguous_nid
+++ a/mm/cma.c
@@ -331,18 +331,6 @@ int __init cma_declare_contiguous_nid(ph
 		phys_addr_t addr = 0;
 
 		/*
-		 * All pages in the reserved area must come from the same zone.
-		 * If the requested region crosses the low/high memory boundary,
-		 * try allocating from high memory first and fall back to low
-		 * memory in case of failure.
-		 */
-		if (base < highmem_start && limit > highmem_start) {
-			addr = memblock_alloc_range_nid(size, alignment,
-					highmem_start, limit, nid, true);
-			limit = highmem_start;
-		}
-
-		/*
 		 * If there is enough memory, try a bottom-up allocation first.
 		 * It will place the new cma area close to the start of the node
 		 * and guarantee that the compaction is moving pages out of the
@@ -359,6 +347,18 @@ int __init cma_declare_contiguous_nid(ph
 		}
 #endif
 
+		/*
+		 * All pages in the reserved area must come from the same zone.
+		 * If the requested region crosses the low/high memory boundary,
+		 * try allocating from high memory first and fall back to low
+		 * memory in case of failure.
+		 */
+		if (!addr && base < highmem_start && limit > highmem_start) {
+			addr = memblock_alloc_range_nid(size, alignment,
+					highmem_start, limit, nid, true);
+			limit = highmem_start;
+		}
+
 		if (!addr) {
 			addr = memblock_alloc_range_nid(size, alignment, base,
 					limit, nid, true);
_

