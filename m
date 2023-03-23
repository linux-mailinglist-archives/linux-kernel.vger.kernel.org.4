Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB706C5CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCWCvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWCvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:51:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CCF1F5F7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:50:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u5so21044413plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679539840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sevPZAbnJXpK9Gw6YJPfGdmbozGF7BL49NEd8f9V3sk=;
        b=K5LxBdjOseL5I6aPTCQj7mHOFrhSOsgr2H7aLFrf3+iTBz1SkiH4drMDXKHspvKHh8
         ir6NY0BHV8wzZRqr650A4n50Ym2RANG1n/zMZhHfw7eDFqvxaybOS0tVKj0afXgNNty9
         4FkQ8U5F3eCHQg/1XCLNrw77GyKdkYgfi4r9pgVAEyeBxxM+bt9vHBOMTtMEbSs8teuK
         KvYZC+jMljwWjA9ITNIU24u2lrxtVOMULqQ2rOQty9YzonegtQUwUxSKSZ07f4Zcr9re
         iqLoFVUKUtCzpZ38vrKLQtjm/ugteQnfeZYWuFaFk3YzeHWXPCPI4gd3uwg85IcIWht4
         /Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679539840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sevPZAbnJXpK9Gw6YJPfGdmbozGF7BL49NEd8f9V3sk=;
        b=0iGy9rYeIz2CTT0UFNhPMxpD0wb3H26Bd07FXDx2Vs/Yst1WWJ9VJxYFCXS5FAwpsi
         ZZUO5AziSrIHJvdINDXYGG4NTtST0xVh2H/y7lAbBU4Sm1PIW9iRq8ybFt8wZFhr0MWU
         IJApMgGFSCfBzjchWZJnYYjSf956ts7xBwjW42ynHj7LxUe/npvlWu9iB10wyEUPrqBd
         L6XswAd0R8NMlDynbqJxXDmYsKkwzVMBtoiW7lXQXkX49vnokmDhMdcoqLzFxoJjUQt5
         GAU5ZCPVRSQoEquuC8MRmGdQhLH9IvP/iZL1pNV+P/IU1s7HGmmcx/012SRZJpKW3S1b
         AwJA==
X-Gm-Message-State: AO0yUKUc2HW1Iv7TnjnBxkjyK9g4IrblgdXrAuxOt2BiLK3QMTRnuzQi
        UDCbConzLqyQjV+KqLYz4lFPcA==
X-Google-Smtp-Source: AK7set9U4IRnF/3MjkmcN7a8fucFYk3GEpd0H73YEk0MoZDAs7wkYLfugtcMCG/5Ztti3TGfqLA+og==
X-Received: by 2002:a17:90b:17cb:b0:23f:5fe7:25a1 with SMTP id me11-20020a17090b17cb00b0023f5fe725a1mr6179466pjb.13.1679539840378;
        Wed, 22 Mar 2023 19:50:40 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a2ec700b0023b5528b8d4sm221002pjs.19.2023.03.22.19.50.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Mar 2023 19:50:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: kfence: fix handling discontiguous page
Date:   Thu, 23 Mar 2023 10:50:03 +0800
Message-Id: <20230323025003.94447-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct pages could be discontiguous when the kfence pool is allocated
via alloc_contig_pages() with CONFIG_SPARSEMEM and !CONFIG_SPARSEMEM_VMEMMAP.
So, the iteration should use nth_page().

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index d66092dd187c..1065e0568d05 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -556,7 +556,7 @@ static unsigned long kfence_init_pool(void)
 	 * enters __slab_free() slow-path.
 	 */
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
-		struct slab *slab = page_slab(&pages[i]);
+		struct slab *slab = page_slab(nth_page(pages, i));
 
 		if (!i || (i % 2))
 			continue;
@@ -602,7 +602,7 @@ static unsigned long kfence_init_pool(void)
 
 reset_slab:
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
-		struct slab *slab = page_slab(&pages[i]);
+		struct slab *slab = page_slab(nth_page(pages, i));
 
 		if (!i || (i % 2))
 			continue;
-- 
2.11.0

