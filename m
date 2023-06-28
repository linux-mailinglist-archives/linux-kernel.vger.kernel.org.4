Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FB7407CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjF1BuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjF1BuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:50:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62D26A3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:50:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QrPcC2653zLmgr;
        Wed, 28 Jun 2023 09:48:11 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 09:50:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm: memory-failure: remove unneeded page state check in shake_page()
Date:   Wed, 28 Jun 2023 09:49:29 +0800
Message-ID: <20230628014929.3441386-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
are not shrunk now. This check can be added back when a lightweight range
based shrinker is available.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
v2:
  put TODO comment together with "if (PageSlab)" block per Naoya
  collect Acked-by tag per Naoya
---
 mm/memory-failure.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b663eca1f29..66e7b3ceaf2d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -372,17 +372,14 @@ void shake_page(struct page *p)
 {
 	if (PageHuge(p))
 		return;
-
-	if (!PageSlab(p)) {
-		lru_add_drain_all();
-		if (PageLRU(p) || is_free_buddy_page(p))
-			return;
-	}
-
 	/*
 	 * TODO: Could shrink slab caches here if a lightweight range-based
 	 * shrinker will be available.
 	 */
+	if (PageSlab(p))
+		return;
+
+	lru_add_drain_all();
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-- 
2.27.0

