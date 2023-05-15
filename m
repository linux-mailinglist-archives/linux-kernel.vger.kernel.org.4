Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7C70241B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjEOGIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbjEOGHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:07:36 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB630EF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:04:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ViakDq3_1684130688;
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0ViakDq3_1684130688)
          by smtp.aliyun-inc.com;
          Mon, 15 May 2023 14:04:52 +0800
From:   Shawn Wang <shawnwang@linux.alibaba.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/resctrl: Only show tasks' pid in current pid namespace
Date:   Mon, 15 May 2023 14:04:48 +0800
Message-Id: <20230515060448.50446-1-shawnwang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing a task id to the "tasks" file in an rdtgroup,
rdtgroup_tasks_write() treats the pid as a number in the current pid
namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
the list of global pids from the init namespace, which is confusing and
incorrect.

To be more robust, let the "tasks" file only show pids in the current pid
namespace.

Link: https://lore.kernel.org/all/20230116071246.97717-1-shawnwang@linux.alibaba.com/
Fixes: e02737d5b826 ("x86/intel_rdt: Add tasks files")
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v1:
- Update commit message and commit tags.

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6ad33f355861..61cdd9b1bb6d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -726,11 +726,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 {
 	struct task_struct *p, *t;
+	pid_t pid;
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r))
-			seq_printf(s, "%d\n", t->pid);
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+			pid = task_pid_vnr(t);
+			if (pid)
+				seq_printf(s, "%d\n", pid);
+		}
 	}
 	rcu_read_unlock();
 }
-- 
2.31.1

