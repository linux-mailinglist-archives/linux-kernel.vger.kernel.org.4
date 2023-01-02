Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819665B3EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjABPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjABPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:12:49 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C338FE6;
        Mon,  2 Jan 2023 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1672672364;
        bh=NXjw6+rKKlfiUhcOC13HUdlVvOIiNsxG9TWj+5AVcIw=;
        h=From:To:Cc:Subject:Date:From;
        b=r5UT4MIPL/pFPmCMszOD5+rkZ6FAF+gPIqMWw+xNObFLDXaU5dEIECX4G5qNxSVou
         NRrFMJn9sf9dZRb4/DWw/tKk75H3GzNRczXAfQFZr1EWlVPXUKvXxjPqJB4BR4jgU5
         1MfD5fEv8tS1THB/ulXN+i+K+t3qmETRwq7N5grONjL2C8qIsnOSxEr3NIm673R383
         AOv1kKzusKsqYGOfLqwfMGm04BF4bQTWPPTy0VNkRuztC0WxSJH9eivZsCkPDeHAF9
         fdyaKiYvdlV84k3Sziil0EEjY46KIxZQAaOwuoE4mRMwJdizSESccDpu9hSW9me0wT
         h0mN/nL29MJVg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NlzrC6lcrzd3y;
        Mon,  2 Jan 2023 10:12:43 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <yujie.liu@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH for tip] sched: Fix concurrency ID handling of usermodehelper kthreads
Date:   Mon,  2 Jan 2023 10:12:16 -0500
Message-Id: <20230102151216.328117-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_mm_cid_after_execve does not expect NULL t->mm, but it may happen
if a usermodehelper kthread fails when attempting to execute a binary.

sched_mm_cid_fork can be issued from a usermodehelper kthread, which has
t->flags PF_KTHREAD set.

Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202212301353.5c959d72-yujie.liu@intel.com
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 048ec2417990..f99ee69867e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11343,8 +11343,8 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 	struct mm_struct *mm = t->mm;
 	unsigned long flags;
 
-	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
-
+	if (!mm)
+		return;
 	local_irq_save(flags);
 	t->mm_cid = mm_cid_get(mm);
 	t->mm_cid_active = 1;
@@ -11354,7 +11354,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 
 void sched_mm_cid_fork(struct task_struct *t)
 {
-	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm || t->mm_cid != -1);
+	WARN_ON_ONCE(!t->mm || t->mm_cid != -1);
 	t->mm_cid_active = 1;
 }
 #endif
-- 
2.25.1

