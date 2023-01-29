Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559F667FCAA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjA2Dj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2DjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:39:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43EE2068F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 19:39:24 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P4H7x6YHlzJrPk;
        Sun, 29 Jan 2023 11:37:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 11:39:22 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2] mm/migrate: Continue to migrate for non-hugetlb folios
Date:   Sun, 29 Jan 2023 11:39:10 +0800
Message-ID: <20230129033910.1327277-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_hugetlbs returns -ENOMEM when no enough hugetlb,
however there may be free non-hugetlb folios available,
so continue to migrate for non-hugetlb folios.

Nowdays the only negtive return value of migrate_hugetlbs
is -ENOMEM, keep compatible for coming negtive return value
instead of ignore return value.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>

---
v1 --> v2: modify changelog and comment. thanks Huang Ying.
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b971edbf32fc..68927aa06f9b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1939,7 +1939,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
 				     mode, reason, &stats, &ret_folios);
-	if (rc_gather < 0)
+	/* There may be free non-hugetlb folios available, continue to migrate. */
+	if (rc_gather < 0 && rc_gather != -ENOMEM)
 		goto out;
 again:
 	nr_pages = 0;
-- 
2.25.1

