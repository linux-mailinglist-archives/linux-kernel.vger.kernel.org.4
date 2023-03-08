Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8660A6B0098
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCHINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCHIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:12:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F5DA0B28
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:12:48 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWlPG1NkyzKqJm;
        Wed,  8 Mar 2023 16:10:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 16:12:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 2/3] mm/damon/paddr: minor refactor of damon_pa_mark_accessed_or_deactivate()
Date:   Wed, 8 Mar 2023 16:33:10 +0800
Message-ID: <20230308083311.120951-3-wangkefeng.wang@huawei.com>
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

Omit one line by unified folio_put(), and make code more clear.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0db724aec5cb..b22f6fbb5816 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -268,16 +268,15 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		if (!folio)
 			continue;
 
-		if (damos_pa_filter_out(s, folio)) {
-			folio_put(folio);
-			continue;
-		}
+		if (damos_pa_filter_out(s, folio))
+			goto put_folio;
 
 		if (mark_accessed)
 			folio_mark_accessed(folio);
 		else
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
+put_folio:
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
-- 
2.35.3

