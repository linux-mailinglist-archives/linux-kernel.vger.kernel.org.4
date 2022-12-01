Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3963EA7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLAHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLAHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:47:25 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82721819
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:47:24 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NN7P975TvzJp3K;
        Thu,  1 Dec 2022 15:43:57 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 15:47:22 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <dhowells@redhat.com>, <christophe.jaillet@wanadoo.fr>
CC:     <linux-kernel@vger.kernel.org>, Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH] watch_queue: Fix error return code in watch_queue_set_size()
Date:   Thu, 1 Dec 2022 16:07:25 +0800
Message-ID: <1669882045-41842-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code -ENOMEM instead of 0.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 kernel/watch_queue.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd..fe6e19c 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -274,19 +274,25 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error;
 
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
-	if (!pages)
+	if (!pages) {
+		ret = -ENOMEM;
 		goto error;
+	}
 
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
-		if (!pages[i])
+		if (!pages[i]) {
+			ret = -ENOMEM;
 			goto error_p;
+		}
 		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
 
 	bitmap = bitmap_alloc(nr_notes, GFP_KERNEL);
-	if (!bitmap)
+	if (!bitmap) {
+		ret = -ENOMEM;
 		goto error_p;
+	}
 
 	bitmap_fill(bitmap, nr_notes);
 	wqueue->notes = pages;
-- 
1.8.3.1

