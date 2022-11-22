Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5779B6348A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiKVUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiKVUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:40:29 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF5B7EBEE;
        Tue, 22 Nov 2022 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149595;
        bh=mUoAzurDGmqt1I+v51UkeZo8hWHaq3S1k8cv4Ik8vPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2RpRc6I8zhiXCCrvLB8u6ULY1yP/N2xiM8McKNhutO2vPiTQ+BiNaFoV0xc4XWSq
         rzGXIzBsJeRxS7ELpkxInwG43LsQkvYFoHR2sMBcOwakt0YgraYsnx5TqA3IFPiO8W
         mXA9kYV9y9OwL/8k9b07OePMKifwbg2LN4w5u1WkBHhdcHFWZ7ZSSChwaIfItrTd9I
         evAm56L3hUDRnQH9vdLpe8F79qfWuKufdUC0ofWqY9LiHUKIVrM08PB1M2BUqnvKbI
         rmQtKg2q/VIc9giGNQDdGBZAYYdAE4c4nhC6wtbS38A9R60BXAxzXKhJnm9YKNhdC+
         sqW1graDFJQEg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2g4L77zXTc;
        Tue, 22 Nov 2022 15:39:55 -0500 (EST)
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
Subject: [PATCH 27/30] selftests/rseq: Implement mm_numa_cid accessors in headers
Date:   Tue, 22 Nov 2022 15:39:29 -0500
Message-Id: <20221122203932.231377-28-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h       |  9 ++++++++
 tools/testing/selftests/rseq/rseq-arm-bits.h  |  8 +++----
 tools/testing/selftests/rseq/rseq-arm.h       | 12 +++++++++++
 .../testing/selftests/rseq/rseq-arm64-bits.h  |  8 +++----
 tools/testing/selftests/rseq/rseq-arm64.h     | 12 +++++++++++
 .../selftests/rseq/rseq-bits-template.h       | 10 +++++++++
 tools/testing/selftests/rseq/rseq-mips-bits.h |  8 +++----
 tools/testing/selftests/rseq/rseq-mips.h      | 12 +++++++++++
 tools/testing/selftests/rseq/rseq-ppc-bits.h  |  8 +++----
 tools/testing/selftests/rseq/rseq-ppc.h       | 12 +++++++++++
 .../testing/selftests/rseq/rseq-riscv-bits.h  |  8 +++----
 tools/testing/selftests/rseq/rseq-riscv.h     | 12 +++++++++++
 tools/testing/selftests/rseq/rseq-s390-bits.h |  8 +++----
 tools/testing/selftests/rseq/rseq-s390.h      | 12 +++++++++++
 tools/testing/selftests/rseq/rseq-x86-bits.h  | 16 +++++++-------
 tools/testing/selftests/rseq/rseq-x86.h       | 21 +++++++++++++++----
 tools/testing/selftests/rseq/rseq.h           | 10 +++++++++
 17 files changed, 150 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index fb4ec8a75dd4..11f7df6bf329 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -164,6 +164,15 @@ struct rseq_abi {
 	 */
 	__u32 mm_cid;
 
+	/*
+	 * Restartable sequences mm_numa_cid field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This field
+	 * should only be read by the thread which registered this data
+	 * structure. Aligned on 32-bit. Contains the current thread's
+	 * NUMA-aware concurrency ID (allocated uniquely within a memory map).
+	 */
+	__u32 mm_numa_cid;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq-arm-bits.h b/tools/testing/selftests/rseq/rseq-arm-bits.h
index 4f03cb395462..025a4e3cd91d 100644
--- a/tools/testing/selftests/rseq/rseq-arm-bits.h
+++ b/tools/testing/selftests/rseq/rseq-arm-bits.h
@@ -8,7 +8,7 @@
 #include "rseq-bits-template.h"
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -288,10 +288,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -500,6 +500,6 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 8414fc3eac15..1b414d308aae 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -167,6 +167,18 @@ do {									\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-numa-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-arm64-bits.h b/tools/testing/selftests/rseq/rseq-arm64-bits.h
index cc7226b1efe1..68881d111f04 100644
--- a/tools/testing/selftests/rseq/rseq-arm64-bits.h
+++ b/tools/testing/selftests/rseq/rseq-arm64-bits.h
@@ -9,7 +9,7 @@
 #include "rseq-bits-template.h"
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -246,10 +246,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -387,6 +387,6 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 85b90977e7e6..3a77c09c78ae 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -224,6 +224,18 @@ do {										\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-numa-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-arm64-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-bits-template.h b/tools/testing/selftests/rseq/rseq-bits-template.h
index 65698d6a6cf9..2632eea2f0f6 100644
--- a/tools/testing/selftests/rseq/rseq-bits-template.h
+++ b/tools/testing/selftests/rseq/rseq-bits-template.h
@@ -25,6 +25,16 @@
 # else
 #  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
 # endif
+#elif defined(RSEQ_TEMPLATE_MM_NUMA_CID)
+# define RSEQ_TEMPLATE_CPU_ID_OFFSET	RSEQ_MM_NUMA_CID_OFFSET
+# define RSEQ_TEMPLATE_CPU_ID_FIELD	mm_numa_cid
+# ifdef RSEQ_TEMPLATE_MO_RELEASE
+#  define RSEQ_TEMPLATE_SUFFIX		_release_mm_numa_cid
+# elif defined (RSEQ_TEMPLATE_MO_RELAXED)
+#  define RSEQ_TEMPLATE_SUFFIX		_relaxed_mm_numa_cid
+# else
+#  error "Never use <rseq-bits-template.h> directly; include <rseq.h> instead."
+# endif
 #elif defined (RSEQ_TEMPLATE_CPU_ID_NONE)
 # ifdef RSEQ_TEMPLATE_MO_RELEASE
 #  define RSEQ_TEMPLATE_SUFFIX		_release
diff --git a/tools/testing/selftests/rseq/rseq-mips-bits.h b/tools/testing/selftests/rseq/rseq-mips-bits.h
index 6c48af4d0944..360d4d55a5ad 100644
--- a/tools/testing/selftests/rseq/rseq-mips-bits.h
+++ b/tools/testing/selftests/rseq/rseq-mips-bits.h
@@ -8,7 +8,7 @@
 #include "rseq-bits-template.h"
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -261,10 +261,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -457,6 +457,6 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 50b950cf9585..87dde8ad6cf6 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -172,6 +172,18 @@ do {									\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-numa-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-mips-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-ppc-bits.h b/tools/testing/selftests/rseq/rseq-ppc-bits.h
index 98e69eae1e62..ca040bd9ecfd 100644
--- a/tools/testing/selftests/rseq/rseq-ppc-bits.h
+++ b/tools/testing/selftests/rseq/rseq-ppc-bits.h
@@ -9,7 +9,7 @@
 #include "rseq-bits-template.h"
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -283,10 +283,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -449,6 +449,6 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index dc9190facee9..41f2f5d4e44f 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -229,6 +229,18 @@ do {									\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-numa-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-ppc-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
index de31a0143139..6e066df95389 100644
--- a/tools/testing/selftests/rseq/rseq-riscv-bits.h
+++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
@@ -3,7 +3,7 @@
 #include "rseq-bits-template.h"
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __always_inline
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -272,10 +272,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __always_inline
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -405,6 +405,6 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 17932a79e066..75c846ea1d12 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -189,6 +189,18 @@ do {									\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-riscv-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-s390-bits.h b/tools/testing/selftests/rseq/rseq-s390-bits.h
index 0cf17d9f170a..9b31e0899eb8 100644
--- a/tools/testing/selftests/rseq/rseq-s390-bits.h
+++ b/tools/testing/selftests/rseq/rseq-s390-bits.h
@@ -3,7 +3,7 @@
 #include "rseq-bits-template.h"
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -274,10 +274,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 /* s390 is TSO. */
 static inline __attribute__((always_inline))
@@ -469,6 +469,6 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 46c92598acc7..27e06d979484 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -154,6 +154,18 @@ do {									\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-s390-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-s390-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-x86-bits.h b/tools/testing/selftests/rseq/rseq-x86-bits.h
index fdf5ef398393..8d7c529330ee 100644
--- a/tools/testing/selftests/rseq/rseq-x86-bits.h
+++ b/tools/testing/selftests/rseq/rseq-x86-bits.h
@@ -10,7 +10,7 @@
 #ifdef __x86_64__
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -328,10 +328,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -517,12 +517,12 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #elif defined(__i386__)
 
 #if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
@@ -784,10 +784,10 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t ex
 }
 
 #endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID))
 
 static inline __attribute__((always_inline))
 int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
@@ -986,7 +986,7 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t
 }
 
 #endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
-	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID) || defined(RSEQ_TEMPLATE_MM_NUMA_CID)) */
 
 #endif
 
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index fb65ef54b0fb..1c7d1801904b 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -26,10 +26,11 @@
  * address through a "r" input operand.
  */
 
-/* Offset of cpu_id, rseq_cs, and mm_cid fields in struct rseq. */
-#define RSEQ_CPU_ID_OFFSET	4
-#define RSEQ_CS_OFFSET		8
-#define RSEQ_MM_CID_OFFSET	24
+/* Offset of cpu_id, rseq_cs, mm_cid, and mm_numa_cid fields in struct rseq. */
+#define RSEQ_CPU_ID_OFFSET		4
+#define RSEQ_CS_OFFSET			8
+#define RSEQ_MM_CID_OFFSET		24
+#define RSEQ_MM_NUMA_CID_OFFSET		28
 
 #ifdef __x86_64__
 
@@ -225,6 +226,18 @@ do {									\
 #undef RSEQ_TEMPLATE_MO_RELEASE
 #undef RSEQ_TEMPLATE_MM_CID
 
+/* Per-mm-numa-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_NUMA_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-x86-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_NUMA_CID
+
 /* APIs which are not based on cpu ids. */
 
 #define RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index b6095c2a5da6..6b682abf39b0 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -215,6 +215,16 @@ static inline uint32_t rseq_current_mm_cid(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->mm_cid);
 }
 
+static inline bool rseq_mm_numa_cid_available(void)
+{
+	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, mm_numa_cid);
+}
+
+static inline uint32_t rseq_current_mm_numa_cid(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->mm_numa_cid);
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
-- 
2.25.1

