Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78A60B412
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiJXR1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiJXR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:27:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D2382747
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:02:34 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwwSL75lwzmVMr;
        Mon, 24 Oct 2022 21:11:14 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 21:16:05 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 21:16:05 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: fix pcp count beyond pcp high in pcplist allocation
Date:   Mon, 24 Oct 2022 21:41:46 +0800
Message-ID: <20221024134146.3442393-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowadays there are several orders in pcplist, Function __rmqueue_pcplist
would alloc pcp batch pages to refill pcplist, when list of target order
if empty meanwhile other lists is not all empty, that result in pcp count
beyond pcp high after allocation. This behaviour can be easily observed by
adding debugging information in __rmqueue_pcplist.

Fix this by recalculate the batch pages to be allocated.

Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39f846d098f5..93e18b6de2f3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3742,6 +3742,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 	do {
 		if (list_empty(list)) {
 			int batch = READ_ONCE(pcp->batch);
+			int high = READ_ONCE(pcp->high);
 			int alloced;
 
 			/*
@@ -3753,6 +3754,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			 */
 			if (batch > 1)
 				batch = max(batch >> order, 2);
+			batch = min(batch, (high - pcp->count) >> order);
 			alloced = rmqueue_bulk(zone, order,
 					batch, list,
 					migratetype, alloc_flags);
-- 
2.25.1

