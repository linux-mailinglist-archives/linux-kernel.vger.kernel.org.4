Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CBC7470B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGDMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGDMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:19:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109E10CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:19:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QwMKK5Zqnz1HCsQ;
        Tue,  4 Jul 2023 20:19:01 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 20:19:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [RFC PATCH] mm: memory-failure: add missing set_mce_nospec() for memory_failure()
Date:   Tue, 4 Jul 2023 20:19:48 +0800
Message-ID: <20230704121948.1331846-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

If memory_failure() succeeds to hwpoison a page, the set_mce_nospec() is
expected to be called to prevent speculative access to the page by marking
it not-present. Add such missing call to set_mce_nospec() in async memory
failure handling scene.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e245191e6b04..c7f88c4042d4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -63,6 +63,7 @@
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
 #include <linux/sysctl.h>
+#include <linux/set_memory.h>
 #include "swap.h"
 #include "internal.h"
 #include "ras/ras_event.h"
@@ -2407,7 +2408,9 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
 		else
-			memory_failure(entry.pfn, entry.flags);
+			if (!memory_failure(entry.pfn, entry.flags))
+				if (!entry.flags & MF_SW_SIMULATED)
+					set_mce_nospec(entry.pfn);
 	}
 }
 
-- 
2.33.0

