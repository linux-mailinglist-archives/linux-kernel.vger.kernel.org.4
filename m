Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70131656AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiL0MQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiL0MOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF80F2F;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAOa34tc7kBV+mchywOyvV8HysVruET6BguhI5CRWGU=;
        b=OJr4P1Shj3ZlAiZ9xlChqHUsSzwayvujzQ1psrD4ZL3g9PH7NL3i3STU6QwsznOTtjVFL9
        l0TcLI+APhEmMrIV52hlTuqFc6Im5SRo6Ti1EbmG+O86rkKQcTMFKy3Ol/0pF9R13xPeTA
        A5LUmm3lMv4DIPrwvubfPUzrUXI1X/TsUlGAJmtUnbBNPdME8s0qDOscObRuM1WeQYT349
        gCbjIyua94Pce3ffhS+Rn6p2HHq8kIN3PNrOR/QHASvJjWkU/ua0KXh3HQ0finiT3xLEiP
        T6VYV6hPNlzYdXPzpuvHOKH2lMy7FXCtf8yXQK2zWM8Mu9xBjdttrm99taODgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAOa34tc7kBV+mchywOyvV8HysVruET6BguhI5CRWGU=;
        b=aGi57LfKsdmBq5J8i+JzjvrUi9Xo1But+Z4+O0onWAHuluBh6lEB5W+NPAOkKBXRIK9tzQ
        Q3O7fRzsDHcsE2AQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Use ELF auxiliary vector for
 extensible rseq
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-6-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-6-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323207.4906.10658635695375494462.tip-bot2@tip-bot2>
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

Commit-ID:     03f5c0272d1b59343144e199becc911dae52c37e
Gitweb:        https://git.kernel.org/tip/03f5c0272d1b59343144e199becc911dae52c37e
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:07 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:11 +01:00

selftests/rseq: Use ELF auxiliary vector for extensible rseq

Use the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE to detect the RSEQ
features supported by the kernel.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-6-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-abi.h |  5 ++-
 tools/testing/selftests/rseq/rseq.c     | 67 +++++++++++++++++++++---
 tools/testing/selftests/rseq/rseq.h     | 18 ++++--
 3 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a8c44d9..00ac846 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -146,6 +146,11 @@ struct rseq_abi {
 	 *     this thread.
 	 */
 	__u32 flags;
+
+	/*
+	 * Flexible array member at end of structure, after last feature field.
+	 */
+	char end[];
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 376a73f..1e8e326 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -28,6 +28,8 @@
 #include <limits.h>
 #include <dlfcn.h>
 #include <stddef.h>
+#include <sys/auxv.h>
+#include <linux/auxvec.h>
 
 #include "../kselftest.h"
 #include "rseq.h"
@@ -36,20 +38,38 @@ static const ptrdiff_t *libc_rseq_offset_p;
 static const unsigned int *libc_rseq_size_p;
 static const unsigned int *libc_rseq_flags_p;
 
-/* Offset from the thread pointer to the rseq area.  */
+/* Offset from the thread pointer to the rseq area. */
 ptrdiff_t rseq_offset;
 
-/* Size of the registered rseq area.  0 if the registration was
-   unsuccessful.  */
+/*
+ * Size of the registered rseq area. 0 if the registration was
+ * unsuccessful.
+ */
 unsigned int rseq_size = -1U;
 
 /* Flags used during rseq registration.  */
 unsigned int rseq_flags;
 
+/*
+ * rseq feature size supported by the kernel. 0 if the registration was
+ * unsuccessful.
+ */
+unsigned int rseq_feature_size = -1U;
+
 static int rseq_ownership;
+static int rseq_reg_success;	/* At least one rseq registration has succeded. */
+
+/* Allocate a large area for the TLS. */
+#define RSEQ_THREAD_AREA_ALLOC_SIZE	1024
+
+/* Original struct rseq feature size is 20 bytes. */
+#define ORIG_RSEQ_FEATURE_SIZE		20
+
+/* Original struct rseq allocation size is 32 bytes. */
+#define ORIG_RSEQ_ALLOC_SIZE		32
 
 static
-__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
+__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"), aligned(RSEQ_THREAD_AREA_ALLOC_SIZE))) = {
 	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
@@ -84,10 +104,16 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
-	if (rc)
+	rc = sys_rseq(&__rseq_abi, rseq_size, 0, RSEQ_SIG);
+	if (rc) {
+		if (RSEQ_READ_ONCE(rseq_reg_success)) {
+			/* Incoherent success/failure within process. */
+			abort();
+		}
 		return -1;
+	}
 	assert(rseq_current_cpu_raw() >= 0);
+	RSEQ_WRITE_ONCE(rseq_reg_success, 1);
 	return 0;
 }
 
@@ -99,12 +125,28 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, rseq_size, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
 }
 
+static
+unsigned int get_rseq_feature_size(void)
+{
+	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
+
+	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
+	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+
+	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
+	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+	if (auxv_rseq_feature_size)
+		return auxv_rseq_feature_size;
+	else
+		return ORIG_RSEQ_FEATURE_SIZE;
+}
+
 static __attribute__((constructor))
 void rseq_init(void)
 {
@@ -117,16 +159,24 @@ void rseq_init(void)
 		rseq_offset = *libc_rseq_offset_p;
 		rseq_size = *libc_rseq_size_p;
 		rseq_flags = *libc_rseq_flags_p;
+		rseq_feature_size = get_rseq_feature_size();
+		if (rseq_feature_size > rseq_size)
+			rseq_feature_size = rseq_size;
 		return;
 	}
 	rseq_ownership = 1;
 	if (!rseq_available()) {
 		rseq_size = 0;
+		rseq_feature_size = 0;
 		return;
 	}
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
-	rseq_size = sizeof(struct rseq_abi);
 	rseq_flags = 0;
+	rseq_feature_size = get_rseq_feature_size();
+	if (rseq_feature_size == ORIG_RSEQ_FEATURE_SIZE)
+		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+	else
+		rseq_size = RSEQ_THREAD_AREA_ALLOC_SIZE;
 }
 
 static __attribute__((destructor))
@@ -136,6 +186,7 @@ void rseq_exit(void)
 		return;
 	rseq_offset = 0;
 	rseq_size = -1U;
+	rseq_feature_size = -1U;
 	rseq_ownership = 0;
 }
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 6f75133..95adc1e 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -47,14 +47,24 @@
 
 #include "rseq-thread-pointer.h"
 
-/* Offset from the thread pointer to the rseq area.  */
+/* Offset from the thread pointer to the rseq area. */
 extern ptrdiff_t rseq_offset;
-/* Size of the registered rseq area.  0 if the registration was
-   unsuccessful.  */
+
+/*
+ * Size of the registered rseq area. 0 if the registration was
+ * unsuccessful.
+ */
 extern unsigned int rseq_size;
-/* Flags used during rseq registration.  */
+
+/* Flags used during rseq registration. */
 extern unsigned int rseq_flags;
 
+/*
+ * rseq feature size supported by the kernel. 0 if the registration was
+ * unsuccessful.
+ */
+extern unsigned int rseq_feature_size;
+
 static inline struct rseq_abi *rseq_get_abi(void)
 {
 	return (struct rseq_abi *) ((uintptr_t) rseq_thread_pointer() + rseq_offset);
