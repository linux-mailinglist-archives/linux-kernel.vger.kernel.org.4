Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2A5B8DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiINRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:07:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0961646A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663175246; x=1694711246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cO8ZrUUTk9o5bkCObqrDLv3GAv3OQRS1eXg4wLMX1+c=;
  b=hIX/e7BVrIoD0YXvXZ2x7INQSvvg74Zn3W46lvi3lxnwBVq8u1ViCRu1
   P3DgWuP4+WtFzam3e/RSlwJn7+UzQqkR8gtDsXX+6i5J3tjbMiRssKkC8
   wuOt18/0VepKC4DGRZ8+hBCJcUEBDhP/Dq+OwmD7GCH2JnP5qIPoJLT9B
   u8TOD8pqyqKGAzz1r9SxpepdfC+C9vZsstOSQKOtPKXNIlVc0n8PsUGZE
   eCdSqU2oPKQ5TUWVgU9c20Xih+CTTcWYcisdGS5aT32NpcTkDXShbeWVX
   szQbRuIgNGHPb0W1Qvvlydu5epAWrMqKOvVIACv5Qki1Er6Xs8JyVblc3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324742854"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324742854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 10:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="612576772"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2022 10:07:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4650F7; Wed, 14 Sep 2022 20:07:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] Revert "kernel.h: Split out might_sleep() and friends"
Date:   Wed, 14 Sep 2022 20:07:39 +0300
Message-Id: <20220914170739.34600-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e076cfdb3293a31b7d6cfc8d4a65355b0c9f82f4.
---
 include/linux/kernel.h      |  99 ++++++++++++++++++++++++++++++++-
 include/linux/might_sleep.h | 108 ------------------------------------
 2 files changed, 98 insertions(+), 109 deletions(-)
 delete mode 100644 include/linux/might_sleep.h

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d2d34aeafd8a..76e98c19368b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -24,7 +24,6 @@
 #include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/math.h>
-#include <linux/might_sleep.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
 #include <linux/panic.h>
@@ -92,6 +91,104 @@
 struct completion;
 struct user;
 
+#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
+
+extern int __cond_resched(void);
+# define might_resched() __cond_resched()
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+
+extern int __cond_resched(void);
+
+DECLARE_STATIC_CALL(might_resched, __cond_resched);
+
+static __always_inline void might_resched(void)
+{
+	static_call_mod(might_resched)();
+}
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+extern int dynamic_might_resched(void);
+# define might_resched() dynamic_might_resched()
+
+#else
+
+# define might_resched() do { } while (0)
+
+#endif /* CONFIG_PREEMPT_* */
+
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+extern void __might_resched(const char *file, int line, unsigned int offsets);
+extern void __might_sleep(const char *file, int line);
+extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_migrate(const char *file, int line);
+
+/**
+ * might_sleep - annotation for functions that can sleep
+ *
+ * this macro will print a stack trace if it is executed in an atomic
+ * context (spinlock, irq-handler, ...). Additional sections where blocking is
+ * not allowed can be annotated with non_block_start() and non_block_end()
+ * pairs.
+ *
+ * This is a useful debugging help to be able to catch problems early and not
+ * be bitten later when the calling function happens to sleep when it is not
+ * supposed to.
+ */
+# define might_sleep() \
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
+/**
+ * cant_sleep - annotation for functions that cannot sleep
+ *
+ * this macro will print a stack trace if it is executed with preemption enabled
+ */
+# define cant_sleep() \
+	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
+# define sched_annotate_sleep()	(current->task_state_change = 0)
+
+/**
+ * cant_migrate - annotation for functions that cannot migrate
+ *
+ * Will print a stack trace if executed in code which is migratable
+ */
+# define cant_migrate()							\
+	do {								\
+		if (IS_ENABLED(CONFIG_SMP))				\
+			__cant_migrate(__FILE__, __LINE__);		\
+	} while (0)
+
+/**
+ * non_block_start - annotate the start of section where sleeping is prohibited
+ *
+ * This is on behalf of the oom reaper, specifically when it is calling the mmu
+ * notifiers. The problem is that if the notifier were to block on, for example,
+ * mutex_lock() and if the process which holds that mutex were to perform a
+ * sleeping memory allocation, the oom reaper is now blocked on completion of
+ * that memory allocation. Other blocking calls like wait_event() pose similar
+ * issues.
+ */
+# define non_block_start() (current->non_block_count++)
+/**
+ * non_block_end - annotate the end of section where sleeping is prohibited
+ *
+ * Closes a section opened by non_block_start().
+ */
+# define non_block_end() WARN_ON(current->non_block_count-- == 0)
+#else
+  static inline void __might_resched(const char *file, int line,
+				     unsigned int offsets) { }
+static inline void __might_sleep(const char *file, int line) { }
+# define might_sleep() do { might_resched(); } while (0)
+# define cant_sleep() do { } while (0)
+# define cant_migrate()		do { } while (0)
+# define sched_annotate_sleep() do { } while (0)
+# define non_block_start() do { } while (0)
+# define non_block_end() do { } while (0)
+#endif
+
+#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
+
 #if defined(CONFIG_MMU) && \
 	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
 #define might_fault() __might_fault(__FILE__, __LINE__)
diff --git a/include/linux/might_sleep.h b/include/linux/might_sleep.h
deleted file mode 100644
index 9b752d50e00b..000000000000
--- a/include/linux/might_sleep.h
+++ /dev/null
@@ -1,108 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_MIGHT_SLEEP_H
-#define _LINUX_MIGHT_SLEEP_H
-
-#include <linux/kconfig.h>
-#include <linux/static_call.h>
-
-#include <asm/bug.h>
-#include <asm/current.h>
-
-#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
-
-extern int __cond_resched(void);
-# define might_resched() __cond_resched()
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
-extern int __cond_resched(void);
-
-DECLARE_STATIC_CALL(might_resched, __cond_resched);
-
-static __always_inline void might_resched(void)
-{
-	static_call_mod(might_resched)();
-}
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-
-extern int dynamic_might_resched(void);
-# define might_resched() dynamic_might_resched()
-
-#else
-
-# define might_resched() do { } while (0)
-
-#endif /* CONFIG_PREEMPT_* */
-
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void __might_resched(const char *file, int line, unsigned int offsets);
-extern void __might_sleep(const char *file, int line);
-extern void __cant_sleep(const char *file, int line, int preempt_offset);
-extern void __cant_migrate(const char *file, int line);
-
-/**
- * might_sleep - annotation for functions that can sleep
- *
- * this macro will print a stack trace if it is executed in an atomic
- * context (spinlock, irq-handler, ...). Additional sections where blocking is
- * not allowed can be annotated with non_block_start() and non_block_end()
- * pairs.
- *
- * This is a useful debugging help to be able to catch problems early and not
- * be bitten later when the calling function happens to sleep when it is not
- * supposed to.
- */
-# define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
-/**
- * cant_sleep - annotation for functions that cannot sleep
- *
- * this macro will print a stack trace if it is executed with preemption enabled
- */
-# define cant_sleep() \
-	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
-# define sched_annotate_sleep()	(current->task_state_change = 0)
-
-/**
- * cant_migrate - annotation for functions that cannot migrate
- *
- * Will print a stack trace if executed in code which is migratable
- */
-# define cant_migrate()							\
-	do {								\
-		if (IS_ENABLED(CONFIG_SMP))				\
-			__cant_migrate(__FILE__, __LINE__);		\
-	} while (0)
-
-/**
- * non_block_start - annotate the start of section where sleeping is prohibited
- *
- * This is on behalf of the oom reaper, specifically when it is calling the mmu
- * notifiers. The problem is that if the notifier were to block on, for example,
- * mutex_lock() and if the process which holds that mutex were to perform a
- * sleeping memory allocation, the oom reaper is now blocked on completion of
- * that memory allocation. Other blocking calls like wait_event() pose similar
- * issues.
- */
-# define non_block_start() (current->non_block_count++)
-/**
- * non_block_end - annotate the end of section where sleeping is prohibited
- *
- * Closes a section opened by non_block_start().
- */
-# define non_block_end() WARN_ON(current->non_block_count-- == 0)
-#else
-static inline void __might_resched(const char *file, int line, unsigned int offsets) { }
-static inline void __might_sleep(const char *file, int line) { }
-# define might_sleep() do { might_resched(); } while (0)
-# define cant_sleep() do { } while (0)
-# define cant_migrate()		do { } while (0)
-# define sched_annotate_sleep() do { } while (0)
-# define non_block_start() do { } while (0)
-# define non_block_end() do { } while (0)
-#endif
-
-#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
-
-#endif	/* _LINUX_MIGHT_SLEEP_H */
-- 
2.35.1

