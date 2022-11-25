Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93601638421
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKYGyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKYGyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:54:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD72B609
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:54:51 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJQZd1Nw0zRnvL;
        Fri, 25 Nov 2022 14:54:17 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 14:54:49 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 14:54:49 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <naoya.horiguchi@nec.com>
CC:     <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <pizhenwei@bytedance.com>, <linux-mm@kvack.org>,
        <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/1] mm/memory-failure.c: Cleanup in unpoison_memory
Date:   Fri, 25 Nov 2022 14:54:44 +0800
Message-ID: <20221125065444.3462681-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

If freeit it true, the value of ret must be zero, there is no need to
check the value of freeit after label unlock_mutex.

We can drop variable freeit to do this cleanup.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/memory-failure.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2e62940c7bae..c77a9e37e27e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2338,7 +2338,6 @@ int unpoison_memory(unsigned long pfn)
 	struct page *page;
 	struct page *p;
 	int ret = -EBUSY;
-	int freeit = 0;
 	unsigned long count = 1;
 	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
@@ -2413,10 +2412,9 @@ int unpoison_memory(unsigned long pfn)
 				goto unlock_mutex;
 			}
 		}
-		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
-		if (freeit) {
+		if (TestClearPageHWPoison(p)) {
 			put_page(page);
 			ret = 0;
 		}
@@ -2424,7 +2422,7 @@ int unpoison_memory(unsigned long pfn)
 
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
-	if (!ret || freeit) {
+	if (!ret) {
 		if (!huge)
 			num_poisoned_pages_sub(pfn, 1);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
-- 
2.25.1

