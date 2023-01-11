Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9566593E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjAKKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjAKKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:43:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52F2718;
        Wed, 11 Jan 2023 02:43:22 -0800 (PST)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NsPPG1V8GzRqq2;
        Wed, 11 Jan 2023 18:41:38 +0800 (CST)
Received: from huawei.com (10.44.142.108) by kwepemm600006.china.huawei.com
 (7.193.23.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 18:43:19 +0800
From:   <luolongjun@huawei.com>
To:     <eterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sangyan@huawei.com>, <luanjianhai@huawei.com>,
        <zhuling8@huawei.com>, <lizongwu@huawei.com>,
        <luolongjuna@gmail.com>, Longjun Luo <luolongjun@huawei.com>
Subject: [PATCH] uprobes: list all active uprobes in the system
Date:   Wed, 11 Jan 2023 18:42:24 +0800
Message-ID: <20230111104224.1934567-1-luolongjun@huawei.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.44.142.108]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Since uprobes will replace instructions in the process
memory, it is necessary to provide one way to list
all active uprobes. One can access this file through
/sys/kernel/debug/uprobes/list.

Output looks like this
=====================
inode+offset/ref_ctr_offset    4160760670+0x30a10/0x0
    ref                        1
    register_rwsem             (unlocked)
    consumer_rwsem             (unlocked)
    consumers-1
        handler                0xffffffffc03ee02e(handler) uprobe
        ret_handler            0x0000000000000000( )
        filter                 0xffffffffc03ee010(filter) uprobe
    consumers-2
        handler                0xffffffffc03e902e(handler_1) uprobe_1
        ret_handler            0x0000000000000000( )
        filter                 0xffffffffc03e9010(filter_1) uprobe_1

Signed-off-by: Longjun Luo <luolongjun@huawei.com>
---
 kernel/events/uprobes.c | 120 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..2fa9b910abc7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -27,6 +27,9 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/rbtree.h>
+#include <linux/debugfs.h>
+#include <linux/kallsyms.h>
 
 #include <linux/uprobes.h>
 
@@ -40,7 +43,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
  */
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
-static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
+static DECLARE_RWSEM(uprobes_treelock);	/* serialize rbtree access */
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -672,9 +675,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe *uprobe;
 
-	spin_lock(&uprobes_treelock);
+	down_read(&uprobes_treelock);
 	uprobe = __find_uprobe(inode, offset);
-	spin_unlock(&uprobes_treelock);
+	up_read(&uprobes_treelock);
 
 	return uprobe;
 }
@@ -704,9 +707,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 {
 	struct uprobe *u;
 
-	spin_lock(&uprobes_treelock);
+	down_write(&uprobes_treelock);
 	u = __insert_uprobe(uprobe);
-	spin_unlock(&uprobes_treelock);
+	up_write(&uprobes_treelock);
 
 	return u;
 }
@@ -938,9 +941,9 @@ static void delete_uprobe(struct uprobe *uprobe)
 	if (WARN_ON(!uprobe_is_active(uprobe)))
 		return;
 
-	spin_lock(&uprobes_treelock);
+	down_write(&uprobes_treelock);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
-	spin_unlock(&uprobes_treelock);
+	up_write(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);
 }
@@ -1301,7 +1304,7 @@ static void build_probe_list(struct inode *inode,
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	spin_lock(&uprobes_treelock);
+	down_read(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
 	if (n) {
 		for (t = n; t; t = rb_prev(t)) {
@@ -1319,7 +1322,7 @@ static void build_probe_list(struct inode *inode,
 			get_uprobe(u);
 		}
 	}
-	spin_unlock(&uprobes_treelock);
+	up_read(&uprobes_treelock);
 }
 
 /* @vma contains reference counter, not the probed instruction. */
@@ -1410,9 +1413,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	spin_lock(&uprobes_treelock);
+	down_read(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
-	spin_unlock(&uprobes_treelock);
+	up_read(&uprobes_treelock);
 
 	return !!n;
 }
@@ -2357,3 +2360,98 @@ void __init uprobes_init(void)
 
 	BUG_ON(register_die_notifier(&uprobe_exception_nb));
 }
+
+#ifdef CONFIG_DEBUG_FS
+
+static void *uprobe_seq_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t num = *pos;
+	struct rb_node *rbp;
+
+	down_read(&uprobes_treelock);
+	for (rbp = rb_first(&uprobes_tree); rbp; rbp = rb_next(rbp)) {
+		if (num-- == 0)
+			return rbp;
+	}
+
+	return NULL;
+}
+
+static void *uprobe_seq_next(struct seq_file *f, void *v, loff_t *pos)
+{
+	++*pos;
+	return (void *)rb_next(v);
+}
+
+static void uprobe_seq_stop(struct seq_file *f, void *v)
+{
+	up_read(&uprobes_treelock);
+}
+
+static int show_uprobe(struct seq_file *m, void *v)
+{
+	struct uprobe *uprobe = rb_entry_safe(v, struct uprobe, rb_node);
+	struct uprobe_consumer *con;
+	char *modname, namebuf[KSYM_NAME_LEN];
+	const char *sym;
+	unsigned int cnt = 1;
+
+	seq_printf(m, "inode+offset/ref_ctr_offset    %lu+0x%llx/0x%llx\n",
+		uprobe->inode->i_ino, uprobe->offset, uprobe->ref_ctr_offset);
+	seq_printf(m, "    ref                        %u\n",
+		refcount_read(&uprobe->ref));
+	seq_printf(m, "    register_rwsem             %s\n",
+		rwsem_is_locked(&uprobe->register_rwsem)?"(locked)":"(unlocked)");
+	seq_printf(m, "    consumer_rwsem             %s\n",
+		rwsem_is_locked(&uprobe->consumer_rwsem)?"(locked)":"(unlocked)");
+
+	/* lock consumer_rwsem when hold uprobes_treelock */
+	down_read(&uprobe->consumer_rwsem);
+	for (con = uprobe->consumers; con; con = con->next, cnt++) {
+		seq_printf(m, "    consumers-%u\n", cnt);
+
+		modname = NULL;
+		sym = kallsyms_lookup((unsigned long)con->handler, NULL, NULL,
+			&modname, namebuf);
+		seq_printf(m, "        handler                0x%px(%s) %s\n",
+			con->handler, (sym ? sym : " "), (modname ? modname : " "));
+
+		modname = NULL;
+		sym = kallsyms_lookup((unsigned long)con->ret_handler, NULL, NULL,
+			&modname, namebuf);
+		seq_printf(m, "        ret_handler            0x%px(%s) %s\n",
+			con->ret_handler, (sym ? sym : " "), (modname ? modname : " "));
+
+		modname = NULL;
+		sym = kallsyms_lookup((unsigned long)con->filter, NULL, NULL,
+			&modname, namebuf);
+		seq_printf(m, "        filter                 0x%px(%s) %s\n",
+			con->filter, (sym ? sym : " "), (modname ? modname : " "));
+	}
+	up_read(&uprobe->consumer_rwsem);
+
+	return 0;
+}
+
+static const struct seq_operations uprobes_sops = {
+	.start = uprobe_seq_start,
+	.next  = uprobe_seq_next,
+	.stop  = uprobe_seq_stop,
+	.show  = show_uprobe,
+};
+
+DEFINE_SEQ_ATTRIBUTE(uprobes);
+
+static int __init debugfs_uprobe_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("uprobes", NULL);
+
+	debugfs_create_file("list", 0400, dir, NULL, &uprobes_fops);
+
+	return 0;
+}
+late_initcall(debugfs_uprobe_init);
+
+#endif /* CONFIG_DEBUG_FS */
-- 
2.38.1

