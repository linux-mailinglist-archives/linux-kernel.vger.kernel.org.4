Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B221716D39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjE3TKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjE3TJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:09:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8CF7;
        Tue, 30 May 2023 12:09:46 -0700 (PDT)
Date:   Tue, 30 May 2023 19:09:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685473784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UBxyMMs76JFCfUryB7BK2Z8JyAjzcmL7jqz+WLRUB0k=;
        b=eijmGDk9ONkTaPajSZN3plzuLTPCppeURI+6LCtbwNkkANG4tJEzt/blBA2XnbDVG/DYgR
        aQM7BjIpRmfF+wOg/ZYgFJhrSaFwYrYe+60afF3DhkJ3OVEWW245DFE60KhRf/htVRO0ZR
        O/BehYYZsD7MTITtI3sHISEG5McCafVymJq3NiiycWuvYQnQYHukKVLTZ/G9FXQQHsoFrP
        yNt4jDghjRZ3GYZ4TZkIEyvWjVxUU/evzx+2DRX/p0qhM1qSJrND7n7Q7J+xbivSPzWW6X
        pjaeX4zPm4Y6GWxEaqzL0XTlL0WIJ+HtQpP0rMkYyLhk41SIjJLUpGrP5LR2tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685473784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UBxyMMs76JFCfUryB7BK2Z8JyAjzcmL7jqz+WLRUB0k=;
        b=64715TD/evBFVkDxhOhsG7dzj0XSO52ZRjqOhPZHkHpFG1LPzxO3Y2GYKINuJcLJ9TLogB
        NVmV07n18IWyxfBQ==
From:   "tip-bot2 for Shawn Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Only show tasks' pid in current pid namespace
Cc:     Shawn Wang <shawnwang@linux.alibaba.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168547378404.404.9447142948180425278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2997d94b5dd0e8b10076f5e0b6f18410c73e28bd
Gitweb:        https://git.kernel.org/tip/2997d94b5dd0e8b10076f5e0b6f18410c73e28bd
Author:        Shawn Wang <shawnwang@linux.alibaba.com>
AuthorDate:    Mon, 15 May 2023 14:04:48 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 May 2023 20:57:39 +02:00

x86/resctrl: Only show tasks' pid in current pid namespace

When writing a task id to the "tasks" file in an rdtgroup,
rdtgroup_tasks_write() treats the pid as a number in the current pid
namespace. But when reading the "tasks" file, rdtgroup_tasks_show() shows
the list of global pids from the init namespace, which is confusing and
incorrect.

To be more robust, let the "tasks" file only show pids in the current pid
namespace.

Fixes: e02737d5b826 ("x86/intel_rdt: Add tasks files")
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/all/20230116071246.97717-1-shawnwang@linux.alibaba.com/
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6ad33f3..61cdd9b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -726,11 +726,15 @@ unlock:
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
