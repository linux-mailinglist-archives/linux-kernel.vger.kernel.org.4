Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B057230BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFEULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFEULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:11:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463699
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:11:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30aef0b8837so4374496f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685995874; x=1688587874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I03V9LL6wy3VgyRgg/zC0hcUQtAfkY257wxzzkjPoYM=;
        b=SgFJczamY7iJrnDAAUuSVGa6BF0kI4cEDyzxvkh92/wCJTbBVZ7lEMkoZG+0WOp3wG
         X98QrAaTnw/JQ/azOsxIcOG+/MQqf4XGvyHjuzmp7uoIGqlOpfABtUrIdpiSh9vQhklZ
         WpQIYQpSQVDFj8WKJsZ23n45sLWiByIHKLDKSctcNjHoPjmXWXYiBtYfksgqKBVJJIsg
         IKNsPKu/U8xH++ONujyhcU5xkyHL1Wxq1aEv+IvtxoOwGq99qFjYWUWrmhTS3zUCezy1
         6B/Qwdvjt8Yu9mZmwWBSCpnKRFEbBxkzHcbp841/vCQ5vFpfTgnCgTyzPz/UhEvx0Jid
         Regw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995874; x=1688587874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I03V9LL6wy3VgyRgg/zC0hcUQtAfkY257wxzzkjPoYM=;
        b=VNj1mpNxunQqcfwh6eDp5q8obcttdVH8wabNNzKAsJyJRwOU+T+LBpIZP2r3TyUNJR
         s67e0llwkSXMuhkXazHrZQXgnGSeYv7pHnbTR3cT3M8gKsc4Vv9httrajlCeuEyNkQwa
         vRmtRj3jCHVIYiGN68s4jG9GP6bLHyOjnZlmooa2IzfRZ1pJWedqAeIVZpx1C3p1rOZV
         JbSqFNkoi42GnnJOg9pjt/deZmZzNiYM6NfpSKdd6nalNjqbTlArLSjKGhjr0eVNegBR
         e5ihoxm9rm04EM/a3KaykMbjzTRA2YQIPDRbq17V1FWbo/mHQznh+mndMDUnG96FbowL
         171Q==
X-Gm-Message-State: AC+VfDytK0E9jkg0rCyafrLaq+WrvKlnTji+iZeq7LHHkKVTwVdRdyqR
        hDqS9DMVkdetobzJKTZJfIA=
X-Google-Smtp-Source: ACHHUZ4bLZOF1IBVo//4SCK+GhxHlyRdYeyhasaOzKLZ5t7VKCCAsHbyE9DiOpSZGG0crmKObyP1yw==
X-Received: by 2002:a5d:668c:0:b0:30d:5071:b033 with SMTP id l12-20020a5d668c000000b0030d5071b033mr16438wru.31.1685995873994;
        Mon, 05 Jun 2023 13:11:13 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h7-20020adff4c7000000b002f28de9f73bsm10539756wrp.55.2023.06.05.13.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:11:12 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/vmalloc: do not output a spurious warning when huge vmalloc() fails
Date:   Mon,  5 Jun 2023 21:11:07 +0100
Message-Id: <20230605201107.83298-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __vmalloc_area_node() we always warn_alloc() when an allocation
performed by vm_area_alloc_pages() fails unless it was due to a pending
fatal signal.

However, huge page allocations instigated either by vmalloc_huge() or
__vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
kvmalloc_node()) always falls back to order-0 allocations if the huge page
allocation fails.

This renders the warning useless and noisy, especially as all callers
appear to be aware that this may fallback. This has already resulted in at
least one bug report from a user who was confused by this (see link).

Therefore, simply update the code to only output this warning for order-0
pages when no fatal signal is pending.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vmalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ab606a80f475..e563f40ad379 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3149,11 +3149,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * allocation request, free them via vfree() if any.
 	 */
 	if (area->nr_pages != nr_small_pages) {
-		/* vm_area_alloc_pages() can also fail due to a fatal signal */
-		if (!fatal_signal_pending(current))
+		/*
+		 * vm_area_alloc_pages() can fail due to insufficient memory but
+		 * also:-
+		 *
+		 * - a pending fatal signal
+		 * - insufficient huge page-order pages
+		 *
+		 * Since we always retry allocations at order-0 in the huge page
+		 * case a warning for either is spurious.
+		 */
+		if (!fatal_signal_pending(current) && page_order == 0)
 			warn_alloc(gfp_mask, NULL,
-				"vmalloc error: size %lu, page order %u, failed to allocate pages",
-				area->nr_pages * PAGE_SIZE, page_order);
+				"vmalloc error: size %lu, failed to allocate pages",
+				area->nr_pages * PAGE_SIZE);
 		goto fail;
 	}
 
-- 
2.40.1

