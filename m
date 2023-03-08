Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8E6B0099
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCHINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCHIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:12:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E41A0B12
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:12:48 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWlPF3z9pzKqMt;
        Wed,  8 Mar 2023 16:10:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 16:12:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 1/3] mm/damon/paddr: minor refactor of damon_pa_pageout()
Date:   Wed, 8 Mar 2023 16:33:09 +0800
Message-ID: <20230308083311.120951-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
References: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omit three lines by unified folio_put(), and make code more clear.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dd9c33fbe805..0db724aec5cb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -238,21 +238,18 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		if (!folio)
 			continue;
 
-		if (damos_pa_filter_out(s, folio)) {
-			folio_put(folio);
-			continue;
-		}
+		if (damos_pa_filter_out(s, folio))
+			goto put_folio;
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
-		if (!folio_isolate_lru(folio)) {
-			folio_put(folio);
-			continue;
-		}
+		if (!folio_isolate_lru(folio))
+			goto put_folio;
 		if (folio_test_unevictable(folio))
 			folio_putback_lru(folio);
 		else
 			list_add(&folio->lru, &folio_list);
+put_folio:
 		folio_put(folio);
 	}
 	applied = reclaim_pages(&folio_list);
-- 
2.35.3

