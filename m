Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D407656AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiL0MPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiL0MOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A4BCE;
        Tue, 27 Dec 2022 04:13:50 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oge8BJUdIiR8BP1GUdyWN8bXPtoIk/0R250b97qS1F4=;
        b=NhtCsqJEvC22vJr6hO6dsxKp1d6McUdSfCRCUhacaErQrGfN3Ak8JHF5QGYcBEeM3NnwFJ
        ApK6SJhhwcCDeRRYdmGQkG9Q6z/Z6DfIMBU7eBRKRLNtD+jVNEDzfALsHCC//8LMt35s/k
        0mDbuMKI3H366ONDkEBzdemeOsHTbLuA3rKdmYQ7E1pe6onw/wA+BXdJkW+4pYNvp1hf90
        KAcP+JHDCHgIo0oi5ZeGJJ2IvGAgXr49v8hUmTmxueLd6nxTEvCabxI0cqboJS8c3Qf6Lz
        HgmtrbOQAbf7sZWgU4Qxp6EtrrgF+MfL/sAu/VaHsqnPvoVZDeDcL7HWpgGkOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oge8BJUdIiR8BP1GUdyWN8bXPtoIk/0R250b97qS1F4=;
        b=9g4gbHJfFxeydysTiPp9iXcU/GvO35iQdSKqTeArghjAoNfU8HKg+UTDMK28FGDhNjC1Ut
        hiVgYqFEbXC1VyAA==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cputime: remove cputime_to_nsecs fallback
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221220070705.2958959-1-npiggin@gmail.com>
References: <20221220070705.2958959-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-ID: <167214322823.4906.12017382437888947820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c89970202a1153b2fc230e89f90c180bd5bcbcef
Gitweb:        https://git.kernel.org/tip/c89970202a1153b2fc230e89f90c180bd5bcbcef
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Tue, 20 Dec 2022 17:07:05 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:17 +01:00

cputime: remove cputime_to_nsecs fallback

The archs that use cputime_to_nsecs() internally provide their own
definition and don't need the fallback. cputime_to_usecs() unused except
in this fallback, and is not defined anywhere.

This removes the final remnant of the cputime_t code from the kernel.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/r/20221220070705.2958959-1-npiggin@gmail.com
---
 arch/s390/kernel/idle.c       |  2 +-
 arch/s390/kernel/vtime.c      |  2 +-
 include/linux/sched/cputime.h |  9 ---------
 kernel/sched/cputime.c        |  4 ++++
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 4bf1ee2..a6bbcea 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -12,9 +12,9 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
-#include <linux/sched/cputime.h>
 #include <trace/events/power.h>
 #include <asm/cpu_mf.h>
+#include <asm/cputime.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
 #include "entry.h"
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 9436f30..e0a88dc 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -7,13 +7,13 @@
  */
 
 #include <linux/kernel_stat.h>
-#include <linux/sched/cputime.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/timex.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <asm/alternative.h>
+#include <asm/cputime.h>
 #include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index ce3c582..5f8fd5b 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -8,15 +8,6 @@
  * cputime accounting APIs:
  */
 
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-#include <asm/cputime.h>
-
-#ifndef cputime_to_nsecs
-# define cputime_to_nsecs(__ct)	\
-	(cputime_to_usecs(__ct) * NSEC_PER_USEC)
-#endif
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern bool task_cputime(struct task_struct *t,
 			 u64 *utime, u64 *stime);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 95fc778..af7952f 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -3,6 +3,10 @@
  * Simple CPU accounting cgroup controller
  */
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+ #include <asm/cputime.h>
+#endif
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 /*
