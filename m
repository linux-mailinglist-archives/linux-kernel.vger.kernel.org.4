Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985025BA77F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIPHbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPHbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:31:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7B67C9C;
        Fri, 16 Sep 2022 00:30:58 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTQcc44YFzlVxM;
        Fri, 16 Sep 2022 15:26:56 +0800 (CST)
Received: from kwepemm600006.china.huawei.com (7.193.23.105) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 15:30:57 +0800
Received: from huawei.com (10.44.142.108) by kwepemm600006.china.huawei.com
 (7.193.23.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:30:56 +0800
From:   <luolongjun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <sangyan@huawei.com>, <luanjianhai@huawei.com>,
        <zhuling8@huawei.com>, <lizongwu@huawei.com>,
        Longjun Luo <luolongjun@huawei.com>
Subject: [PATCH] uprobe: add UPROBE_ALTER_PC flag for uprobe handlers
Date:   Fri, 16 Sep 2022 15:28:46 +0800
Message-ID: <20220916072846.2145735-1-luolongjun@huawei.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.44.142.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longjun Luo <luolongjun@huawei.com>

Within uprobe handlers, the pc register could be
modified. In this situation, there is no need to
do a single stepping. Just like the kprobe, we
skip it.

Signed-off-by: Longjun Luo <luolongjun@huawei.com>
---
 include/linux/uprobes.h |  5 +++--
 kernel/events/uprobes.c | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..0670fecbe1ce 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -22,8 +22,9 @@ struct inode;
 struct notifier_block;
 struct page;
 
-#define UPROBE_HANDLER_REMOVE		1
-#define UPROBE_HANDLER_MASK		1
+#define UPROBE_HANDLER_REMOVE   0x1
+#define UPROBE_ALTER_PC         0x2
+#define UPROBE_HANDLER_MASK     0x3 /* (UPROBE_HANDLER_REMOVE | UPROBE_ALTER_PC) */
 
 #define MAX_URETPROBE_DEPTH		64
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2eaa327f8158..d01a668fecae 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2064,10 +2064,16 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 	return uprobe;
 }
 
-static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
+/*
+ * The return value of handler_chain tags events that happen during
+ * calling handlers. If UPROBE_ALTER_PC happens, we must skip the
+ * single stepping.
+ */
+static int handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
+	int all_events = 0;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
@@ -2084,6 +2090,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			need_prep = true;
 
 		remove &= rc;
+		all_events |= rc;
 	}
 
 	if (need_prep && !remove)
@@ -2094,6 +2101,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		unapply_uprobe(uprobe, current->mm);
 	}
 	up_read(&uprobe->register_rwsem);
+	return all_events;
 }
 
 static void
@@ -2183,7 +2191,7 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int is_swbp;
+	int is_swbp, all_events;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == get_trampoline_vaddr())
@@ -2235,7 +2243,9 @@ static void handle_swbp(struct pt_regs *regs)
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
 		goto out;
 
-	handler_chain(uprobe, regs);
+	all_events = handler_chain(uprobe, regs);
+	if (all_events & UPROBE_ALTER_PC)
+		goto out;
 
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
-- 
2.37.3

