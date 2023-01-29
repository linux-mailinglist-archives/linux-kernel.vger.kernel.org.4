Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CD67FC78
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjA2CzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2CzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:55:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D591C58E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:55:11 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P4G5b31CnzJqMP;
        Sun, 29 Jan 2023 10:50:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 10:55:09 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] mm/migrate: Continue to migrate for small pages
Date:   Sun, 29 Jan 2023 10:54:04 +0800
Message-ID: <20230129025404.1262745-1-chenwandun@huawei.com>
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

migrate_hugetlbs returns -ENOMEM when no enough huge page,
however maybe there are still free small pages, so continue
to migrate for small pages.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/migrate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b971edbf32fc..c9d0d2058036 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1939,7 +1939,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
 				     mode, reason, &stats, &ret_folios);
-	if (rc_gather < 0)
+	/* Maybe there are free small pages, continue to migrate.
+	 * Nowdays the only negtive return value of migrate_hugetlbs
+	 * is -ENOMEM, keep compatible for coming negtive return
+	 * value instead of ignore return value.
+	 */
+	if (rc_gather < 0 && rc_gather != -ENOMEM)
 		goto out;
 again:
 	nr_pages = 0;
-- 
2.25.1

