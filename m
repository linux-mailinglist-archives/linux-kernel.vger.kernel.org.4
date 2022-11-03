Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38269618935
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKCUFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKCUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:04:58 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79020351;
        Thu,  3 Nov 2022 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505896;
        bh=E6RcMkjsd/Od/lksd45vKyIwR9BhuP5azuYFnx2swzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6BPr6TyhLIlplDdaf8ROM+uNS6dRPUxZ15S2NoMRMthbNtnSzzLjNLXRkEJa4pRj
         UYhQWlRZ7pGwONxdH7buT2PfPNExRcsD5ggI6CcG+6B2F1Zb6HwuOg64IR30ZANHB2
         w1XNz58LaLKk6V3vND3RiqQh3nRBb4eJEWYMuZyp2a1cXGsjUyB2GppJER82/qIrL7
         ytQ2P6PZygGF+DKyR9VcSVdyOU5DYbkRkqnzsd4tiqJRZTOTfuyD8Cx1y6D1wy9tgN
         75aRJMj1WhvtT9b7ioGta5dMXmEd2hKmbfjCYlfG9afVKjw7HXyc7hR4k+d9n+drIc
         BG0V06u0j+lHg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F9430sWzfDX;
        Thu,  3 Nov 2022 16:04:56 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v5 04/24] selftests/rseq: Use ELF auxiliary vector for extensible rseq
Date:   Thu,  3 Nov 2022 16:03:39 -0400
Message-Id: <20221103200359.328736-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE to detect the RSEQ
features supported by the kernel.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h |  5 ++
 tools/testing/selftests/rseq/rseq.c     | 68 ++++++++++++++++++++++---
 tools/testing/selftests/rseq/rseq.h     | 18 +++++--
 3 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a8c44d9af71f..00ac846d85b0 100644
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
index 4177f9507bbe..c1c691eca904 100644
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
+/* Orignal struct rseq allocation size is 32 bytes. */
+#define ORIG_RSEQ_ALLOC_SIZE		32
 
 static
-__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
+__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"), aligned(RSEQ_THREAD_AREA_ALLOC_SIZE))) = {
 	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
@@ -84,10 +104,18 @@ int rseq_register_current_thread(void)
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
+		rseq_size = 0;
+		rseq_feature_size = 0;
 		return -1;
+	}
 	assert(rseq_current_cpu_raw() >= 0);
+	RSEQ_WRITE_ONCE(rseq_reg_success, 1);
 	return 0;
 }
 
@@ -99,12 +127,28 @@ int rseq_unregister_current_thread(void)
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
@@ -117,14 +161,21 @@ void rseq_init(void)
 		rseq_offset = *libc_rseq_offset_p;
 		rseq_size = *libc_rseq_size_p;
 		rseq_flags = *libc_rseq_flags_p;
+		rseq_feature_size = get_rseq_feature_size();
+		if (rseq_feature_size > rseq_size)
+			rseq_feature_size = rseq_size;
 		return;
 	}
 	if (!rseq_available())
 		return;
 	rseq_ownership = 1;
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
@@ -134,6 +185,7 @@ void rseq_exit(void)
 		return;
 	rseq_offset = 0;
 	rseq_size = -1U;
+	rseq_feature_size = -1U;
 	rseq_ownership = 0;
 }
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 6f7513384bf5..95adc1e1b0db 100644
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
-- 
2.25.1

