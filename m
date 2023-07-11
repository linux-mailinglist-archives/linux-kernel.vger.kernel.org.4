Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FBA74ECB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjGKL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGKL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:28:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C411D;
        Tue, 11 Jul 2023 04:28:00 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R0drX2DJDzqVrV;
        Tue, 11 Jul 2023 19:27:24 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 19:27:58 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <zhengyejian1@huawei.com>
Subject: [PATCH v3] ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()
Date:   Tue, 11 Jul 2023 19:27:52 +0800
Message-ID: <20230711112752.2595316-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710104625.421c851a@gandalf.local.home>
References: <20230710104625.421c851a@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As comments in ftrace_process_locs(), there may be NULL pointers in
mcount_loc section:
 > Some architecture linkers will pad between
 > the different mcount_loc sections of different
 > object files to satisfy alignments.
 > Skip any NULL pointers.

After commit 20e5227e9f55 ("ftrace: allow NULL pointers in mcount_loc"),
NULL pointers will be accounted when allocating ftrace pages but skipped
before adding into ftrace pages, this may result in some pages not being
used. Then after commit 706c81f87f84 ("ftrace: Remove extra helper
functions"), warning may occur at:
  WARN_ON(pg->next);

To fix it, only warn for case that no pointers skipped but pages not used
up, then free those unused pages after releasing ftrace_lock.

Fixes: 706c81f87f84 ("ftrace: Remove extra helper functions")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
Changes v2 -> v3: https://lore.kernel.org/all/20230711201630.1837109-1-zhengyejian1@huawei.com/
  - Check NULL for 'pg->next' before assigning it to variable 'pg_unuse'

Changes v1 -> v2: https://lore.kernel.org/all/20230710104625.421c851a@gandalf.local.home/
  - As suggested by Steve, only warn for case that no pointers skipped
    but pages not used up then free those unused pages. But I move the
    free process after releasing ftrace_lock.

 kernel/trace/ftrace.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3740aca79fe7..e43e21a3d5fd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6473,7 +6473,9 @@ static int ftrace_process_locs(struct module *mod,
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
+	struct ftrace_page *pg_unuse = NULL;
 	struct dyn_ftrace *rec;
+	unsigned long skipped = 0;
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
@@ -6536,8 +6538,10 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -6551,8 +6555,10 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	/* We should have used all pages */
-	WARN_ON(pg->next);
+	if (pg->next) {
+		pg_unuse = pg->next;
+		pg->next = NULL;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -6574,6 +6580,20 @@ static int ftrace_process_locs(struct module *mod,
  out:
 	mutex_unlock(&ftrace_lock);
 
+	/* We should have used all pages unless we skipped some */
+	if (pg_unuse) {
+		WARN_ON(!skipped);
+		while (pg_unuse) {
+			pg = pg_unuse;
+			pg_unuse = pg->next;
+			if (pg->records) {
+				free_pages((unsigned long)pg->records, pg->order);
+				ftrace_number_of_pages -= 1 << pg->order;
+			}
+			kfree(pg);
+			ftrace_number_of_groups--;
+		}
+	}
 	return ret;
 }
 
-- 
2.25.1

