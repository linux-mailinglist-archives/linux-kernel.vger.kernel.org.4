Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12E70E46B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjEWSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEWSQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:16:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B2E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:16:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae50da739dso50563575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684865799; x=1687457799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ5fia4Cx4BXIfSXjznek5W92IJMv6cKHgCdNN+QqpA=;
        b=naNu43vyS3rr1H6NbStcToGepCNSckBHON8vGS313VY0wx8WcCsEa0TQSKti7o++vo
         zyz6TvaHCYzgV3uvz8S8p4jCQzlEh8KtD4ff/8nYEGqOLrv8zpLVWuRcWbXOKXR9Jx7Q
         7Gl5Zu8s6dxdHonDNnbWlEu339TPy44RXe4Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684865799; x=1687457799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ5fia4Cx4BXIfSXjznek5W92IJMv6cKHgCdNN+QqpA=;
        b=aaQ/vFdLw4h2tCGTn9yoaQJZT9H+X3lJX0sNwWgR/Cg88T5H9gjmlGeEldMZTIHgEP
         84C1OMc39O0U9rXhJrFoRrMpSpyEdvUjwx+qBeU2aSfuyKko/SW0lKX0sUFhJtkFTDWZ
         TBbNxoK80rzBLZ45+eDdMSh1+MZkaJpltwTkPxAS2Nl1ImOH+HbIagIDEOo7260U/3Y6
         GWqXTtm7qHGs+XEsCKcW82DyUhTE1tZ7u/SdiNYjU+fsiMSkoXUjM2P+SxMKBtEGOVua
         3H9rdd0rW+6PoVPzFLRL2vjHegS5yNYgwXqQua1rn83ricsQ+A05SQi7JRAr6sUJWqy0
         B8Dg==
X-Gm-Message-State: AC+VfDxJD6UeW7+5RrsdWfPw6Yg22B6mmWBqHkdo0kZX+VFbLUzn356K
        SpfnKDUx1KYVDpiYT00ksMz0EA==
X-Google-Smtp-Source: ACHHUZ5AmVI8feXYWRnurX6nVEXxdS6k5jOGlRGucKBzCNPWf2h0kObLst2NZo6XFAlqtVjQcJjCIQ==
X-Received: by 2002:a17:902:ced0:b0:1af:babd:7b57 with SMTP id d16-20020a170902ced000b001afbabd7b57mr7027805plg.25.1684865799028;
        Tue, 23 May 2023 11:16:39 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:c15:ee34:1a22:4174])
        by smtp.gmail.com with ESMTPSA id jh14-20020a170903328e00b001a4fe00a8d4sm7126997plb.90.2023.05.23.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 11:16:38 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     audit@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>
Subject: [PATCH] audit: check syscall bitmap on entry to avoid extra work
Date:   Tue, 23 May 2023 11:16:24 -0700
Message-Id: <20230523181624.19932-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently audit subsystem arms itself as long as there are rules present,
which means that on every syscall exit all rules are evaluated, even
if they don't match the syscall to begin with. For setups where
there are no rules that can match any syscall, this means that
the CPU price needs to be paid when it's not necessary.

This patch introduces a bitmap for syscalls that is maintained
when rules are inserted and removed. For every syscall we maintain
a bit indicating whether it needs to be audited at all, which is then
checked at syscall entry. If the are no rules matching a syscall,
extra cost of checking all the rules is avoided.

Consider the following set of 10 audit rules as a benchmark:

    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/0 -F key=BENCH0
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/1 -F key=BENCH1
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/2 -F key=BENCH2
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/3 -F key=BENCH3
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/4 -F key=BENCH4
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/5 -F key=BENCH5
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/6 -F key=BENCH6
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/7 -F key=BENCH7
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/8 -F key=BENCH8
    -a always,exit -F arch=b64 -S unlinkat,linkat,renameat,openat,renameat2 -F perm=wa -F dir=/tmp/audit-bench/9 -F key=BENCH9

We can use the following benchmark to run unrelated syscalls:

    #include <sys/stat.h>
    #include <unistd.h>
    #include <stdio.h>

    #define GETPID_COUNT 100 * 1000
    #define STAT_COUNT 100 * 1000

    pid_t bench_getpid()
    {
        pid_t pid;

        for (int i = 0; i < GETPID_COUNT; i++)
        {
            pid = getpid();
        }

        return pid;
    }

    struct stat bench_stat()
    {
        struct stat statbuf;

        for (int i = 0; i < STAT_COUNT; i++)
        {
            stat("/etc/passwd", &statbuf);
        }

        return statbuf;
    }

    int main()
    {
        pid_t pid = bench_getpid();
        struct stat statbuf = bench_stat();

        printf("pid = %d, size = %d\n", pid, statbuf.st_size);
    }

Here we run 100k `getpid()` calls and 100k `stat()` calls, which are not
covered by any of the audit rules installed on the system.

When running without any rules present, but with auditd running, flamegraphs
show ~5% of CPU time spent in audit_* code. If we install the rules mentioned
above, this number jumps to ~24%. With this patch applied, the number is once
again down to 5%, which is what one would expect.

There's extra cost of maintaining the bitmap when rules are changed,
but it's negligible compared to CPU savings from cheaper syscalls.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 include/linux/audit.h | 21 +++++++++++++++++++++
 kernel/auditfilter.c  | 32 ++++++++++++++++++++++++++++----
 kernel/auditsc.c      | 27 +++++++++++----------------
 3 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 31086a72e32a..e99428052321 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_AUDIT_H_
 #define _LINUX_AUDIT_H_
 
+#include <linux/bitmap.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/audit_arch.h>
@@ -399,6 +400,22 @@ static inline void audit_ptrace(struct task_struct *t)
 		__audit_ptrace(t);
 }
 
+static inline int audit_in_mask(const struct audit_krule *rule, unsigned long val)
+{
+	int word, bit;
+
+	if (val > 0xffffffff)
+		return false;
+
+	word = AUDIT_WORD(val);
+	if (word >= AUDIT_BITMASK_SIZE)
+		return false;
+
+	bit = AUDIT_BIT(val);
+
+	return rule->mask[word] & bit;
+}
+
 				/* Private API (for audit.c only) */
 extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
 extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
@@ -573,6 +590,10 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 
 extern int audit_n_rules;
 extern int audit_signals;
+
+extern int audit_n_syscall_rules;
+extern int audit_syscall_rules[NR_syscalls];
+extern DECLARE_BITMAP(audit_syscalls_bitmap, NR_syscalls);
 #else /* CONFIG_AUDITSYSCALL */
 static inline int audit_alloc(struct task_struct *task)
 {
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 42d99896e7a6..3c7ea1a3faf1 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -943,7 +943,7 @@ static inline int audit_add_rule(struct audit_entry *entry)
 	struct list_head *list;
 	int err = 0;
 #ifdef CONFIG_AUDITSYSCALL
-	int dont_count = 0;
+	int syscall_nr, dont_count = 0;
 
 	/* If any of these, don't count towards total */
 	switch(entry->rule.listnr) {
@@ -1007,9 +1007,21 @@ static inline int audit_add_rule(struct audit_entry *entry)
 		list_add_tail_rcu(&entry->list, list);
 	}
 #ifdef CONFIG_AUDITSYSCALL
-	if (!dont_count)
+	if (!dont_count) {
 		audit_n_rules++;
 
+		if (entry->rule.listnr == AUDIT_FILTER_EXIT) {
+			audit_n_syscall_rules++;
+
+			for (syscall_nr = 0; syscall_nr < NR_syscalls; syscall_nr++) {
+				if (!audit_in_mask(&entry->rule, syscall_nr))
+					continue;
+				if (++audit_syscall_rules[syscall_nr] == 1)
+					set_bit(syscall_nr, audit_syscalls_bitmap);
+			}
+		}
+	}
+
 	if (!audit_match_signal(entry))
 		audit_signals++;
 #endif
@@ -1026,7 +1038,7 @@ int audit_del_rule(struct audit_entry *entry)
 	struct list_head *list;
 	int ret = 0;
 #ifdef CONFIG_AUDITSYSCALL
-	int dont_count = 0;
+	int syscall_nr, dont_count = 0;
 
 	/* If any of these, don't count towards total */
 	switch(entry->rule.listnr) {
@@ -1054,9 +1066,21 @@ int audit_del_rule(struct audit_entry *entry)
 		audit_remove_mark_rule(&e->rule);
 
 #ifdef CONFIG_AUDITSYSCALL
-	if (!dont_count)
+	if (!dont_count) {
 		audit_n_rules--;
 
+		if (entry->rule.listnr == AUDIT_FILTER_EXIT) {
+			audit_n_syscall_rules--;
+
+			for (syscall_nr = 0; syscall_nr < NR_syscalls; syscall_nr++) {
+				if (!audit_in_mask(&entry->rule, syscall_nr))
+					continue;
+				if (--audit_syscall_rules[syscall_nr] == 0)
+					clear_bit(syscall_nr, audit_syscalls_bitmap);
+			}
+		}
+	}
+
 	if (!audit_match_signal(entry))
 		audit_signals--;
 #endif
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index addeed3df15d..eb8296474bb2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -86,6 +86,15 @@ int audit_n_rules;
 /* determines whether we collect data for signals sent */
 int audit_signals;
 
+/* number of syscall related audit rules */
+int audit_n_syscall_rules;
+
+/* number of rules per syscall */
+int audit_syscall_rules[NR_syscalls];
+
+/* bitmap for checking whether a syscall is audited */
+DECLARE_BITMAP(audit_syscalls_bitmap, NR_syscalls);
+
 struct audit_aux_data {
 	struct audit_aux_data	*next;
 	int			type;
@@ -790,22 +799,6 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	return AUDIT_STATE_BUILD;
 }
 
-static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
-{
-	int word, bit;
-
-	if (val > 0xffffffff)
-		return false;
-
-	word = AUDIT_WORD(val);
-	if (word >= AUDIT_BITMASK_SIZE)
-		return false;
-
-	bit = AUDIT_BIT(val);
-
-	return rule->mask[word] & bit;
-}
-
 /**
  * __audit_filter_op - common filter helper for operations (syscall/uring/etc)
  * @tsk: associated task
@@ -2025,6 +2018,8 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 		return;
 
 	context->dummy = !audit_n_rules;
+	if (!context->dummy && audit_n_syscall_rules == audit_n_rules)
+		context->dummy = !test_bit(major, audit_syscalls_bitmap);
 	if (!context->dummy && state == AUDIT_STATE_BUILD) {
 		context->prio = 0;
 		if (auditd_test_task(current))
-- 
2.40.1

