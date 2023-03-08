Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52E6AFF7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCHHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHHKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:10:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C540E9;
        Tue,  7 Mar 2023 23:10:47 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PWk3B528JzrST2;
        Wed,  8 Mar 2023 15:09:58 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:10:44 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Add ftrace_page to list after the index is calculated
Date:   Wed, 8 Mar 2023 15:08:44 +0800
Message-ID: <20230308070844.58180-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported follow problem:

 BUG: KASAN: use-after-free in lookup_rec
 Read of size 8 at addr ffff000199270ff0 by task modprobe

 CPU: 2 Comm: modprobe
 Hardware name: QEMU KVM Virtual Machine
 Call trace:
  kasan_report
  __asan_load8
  lookup_rec
  ftrace_location
  arch_check_ftrace_location
  check_kprobe_address_safe
  register_kprobe.part.0
  register_kprobe

This happened when lookup_rec accessing pg->records[pg->index - 1].
The accessed position is not a valid records address, it has -16 offset
to the last allocated records page.

In ftrace_process_locs, ftrace_page will be added to ftrace_pages_start
list fist, then its pg->index will be calculated. Before pg->index++,
pg->index == 0.

lookup_rec iterates the whole list if it doesn't find a record. When
there is a page with pg->index == 0, getting pg->records[-1].ip causes
this problem.

Add ftrace_page to the ftrace_pages_start list after pg->index is
calculated, to fix this.

Fixes: 3208230983a0 ("ftrace: Remove usage of "freed" records")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/trace/ftrace.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..a258c48ad91e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6804,28 +6804,14 @@ static int ftrace_process_locs(struct module *mod,
 
 	mutex_lock(&ftrace_lock);
 
+	if (WARN_ON(mod && !ftrace_pages))
+		goto out;
+
 	/*
 	 * Core and each module needs their own pages, as
 	 * modules will free them when they are removed.
 	 * Force a new page to be allocated for modules.
 	 */
-	if (!mod) {
-		WARN_ON(ftrace_pages || ftrace_pages_start);
-		/* First initialization */
-		ftrace_pages = ftrace_pages_start = start_pg;
-	} else {
-		if (!ftrace_pages)
-			goto out;
-
-		if (WARN_ON(ftrace_pages->next)) {
-			/* Hmm, we have free pages? */
-			while (ftrace_pages->next)
-				ftrace_pages = ftrace_pages->next;
-		}
-
-		ftrace_pages->next = start_pg;
-	}
-
 	p = start;
 	pg = start_pg;
 	while (p < end) {
@@ -6855,6 +6841,21 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages */
 	WARN_ON(pg->next);
 
+	/* Add pages to ftrace_pages list */
+	if (!mod) {
+		WARN_ON(ftrace_pages || ftrace_pages_start);
+		/* First initialization */
+		ftrace_pages_start = start_pg;
+	} else {
+		if (WARN_ON(ftrace_pages->next)) {
+			/* Hmm, we have free pages? */
+			while (ftrace_pages->next)
+				ftrace_pages = ftrace_pages->next;
+		}
+
+		ftrace_pages->next = start_pg;
+	}
+
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
 
-- 
2.17.1

