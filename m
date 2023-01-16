Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC25366B7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAPHNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjAPHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:12:57 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4EC642
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:12:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VZdrEag_1673853166;
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VZdrEag_1673853166)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 15:12:51 +0800
From:   Shawn Wang <shawnwang@linux.alibaba.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, james.morse@arm.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/resctrl: Only show tasks' pids in current pid namespace
Date:   Mon, 16 Jan 2023 15:12:46 +0800
Message-Id: <20230116071246.97717-1-shawnwang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing a task id to the "tasks" file in an rdtgroup,
rdtgroup_tasks_write() treats the pid as a number in the current pid
namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
the list of global pids from the init namespace. If current pid namespace
is not the init namespace, pids in "tasks" will be confusing and incorrect.

To be more robust, let the "tasks" file only show pids in the current pid
namespace.

Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5993da21d822..9e97ae24c159 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -718,11 +718,15 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
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
2.27.0

