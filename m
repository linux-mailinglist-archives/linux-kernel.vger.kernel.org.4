Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C267CBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjAZNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjAZNOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AD69536
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:38 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCux2O024619;
        Thu, 26 Jan 2023 13:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=a2bA49cvuyD381/1p9ghOoEE1TksbHTn3fwVaM0YUgM=;
 b=X+tD3xUD2B3Ahn2Ffjsg5LjSjuFq0yxgbuSXJPATGdtNQaQ/0gOXk62e6brKTtzWu6CE
 PNiiWdyoW2sbgsjG/ObeJdk+QaND5+Q3azGgbS4pVmRoflJPJtaQVdx8kfP+sqsFV0hJ
 i4l6Lw6sPQHGJ/DGcEzs88frVDVG3txbjO3gGJIkO9k/r9fR3rkuzHCyQKPCE9myveoL
 9gNlhUiwlmA0uEKpOIgxRoH8hDksY4Z/57J365CWTohbHViyRgCNQcYjHtrixePrptNN
 Q0cWpQaONa/XZfRuK6ITQE2ztMC2OYjodXl5//yCLmHHW7mn9Llp0f/rkpeYHJR/6Chq ng== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsymrh0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q3rPFD022554;
        Thu, 26 Jan 2023 13:14:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6cmga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDEVSd47907112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE3C420040;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A6120043;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 6/8] lib/zlib: Split deflate and inflate states for DFLTCC
Date:   Thu, 26 Jan 2023 14:14:26 +0100
Message-Id: <20230126131428.1222214-7-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRFowJ6KceT2uAYw4Ig1yUQiCA0jdj2v
X-Proofpoint-ORIG-GUID: VRFowJ6KceT2uAYw4Ig1yUQiCA0jdj2v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently deflate and inflate both use a common state struct. There are
several variables in this struct that we don't need for inflate, and
more may be coming in the future. Therefore split them in two separate
structs.
Apart from that, introduce separate headers for dfltcc_deflate and
dfltcc_inflate.

This commit is based on:
  https://github.com/zlib-ng/zlib-ng/commit/c592b1b

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_deflate/deflate.c       |  4 +--
 lib/zlib_dfltcc/dfltcc.c         | 25 ++-------------
 lib/zlib_dfltcc/dfltcc.h         | 52 ++++++--------------------------
 lib/zlib_dfltcc/dfltcc_deflate.c | 35 ++++++++++++++++-----
 lib/zlib_dfltcc/dfltcc_deflate.h | 21 +++++++++++++
 lib/zlib_dfltcc/dfltcc_inflate.c | 10 +++++-
 lib/zlib_dfltcc/dfltcc_inflate.h | 37 +++++++++++++++++++++++
 lib/zlib_inflate/inflate.c       |  2 +-
 8 files changed, 110 insertions(+), 76 deletions(-)
 create mode 100644 lib/zlib_dfltcc/dfltcc_deflate.h
 create mode 100644 lib/zlib_dfltcc/dfltcc_inflate.h

diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index f30d6b8a69b2..3a1d8d34182e 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -54,7 +54,7 @@
 
 /* architecture-specific bits */
 #ifdef CONFIG_ZLIB_DFLTCC
-#  include "../zlib_dfltcc/dfltcc.h"
+#  include "../zlib_dfltcc/dfltcc_deflate.h"
 #else
 #define DEFLATE_RESET_HOOK(strm) do {} while (0)
 #define DEFLATE_HOOK(strm, flush, bstate) 0
@@ -106,7 +106,7 @@ typedef struct deflate_workspace {
     deflate_state deflate_memory;
 #ifdef CONFIG_ZLIB_DFLTCC
     /* State memory for s390 hardware deflate */
-    struct dfltcc_state dfltcc_memory;
+    struct dfltcc_deflate_state dfltcc_memory;
 #endif
     Byte *window_memory;
     Pos *prev_memory;
diff --git a/lib/zlib_dfltcc/dfltcc.c b/lib/zlib_dfltcc/dfltcc.c
index 782f76e9d4da..ac6ac9739f5b 100644
--- a/lib/zlib_dfltcc/dfltcc.c
+++ b/lib/zlib_dfltcc/dfltcc.c
@@ -23,37 +23,18 @@ char *oesc_msg(
     }
 }
 
-void dfltcc_reset(
-    z_streamp strm,
-    uInt size
-)
-{
-    struct dfltcc_state *dfltcc_state =
-        (struct dfltcc_state *)((char *)strm->state + size);
-    struct dfltcc_qaf_param *param =
-        (struct dfltcc_qaf_param *)&dfltcc_state->param;
-
+void dfltcc_reset_state(struct dfltcc_state *dfltcc_state) {
     /* Initialize available functions */
     if (is_dfltcc_enabled()) {
-        dfltcc(DFLTCC_QAF, param, NULL, NULL, NULL, NULL, NULL);
-        memmove(&dfltcc_state->af, param, sizeof(dfltcc_state->af));
+        dfltcc(DFLTCC_QAF, &dfltcc_state->param, NULL, NULL, NULL, NULL, NULL);
+        memmove(&dfltcc_state->af, &dfltcc_state->param, sizeof(dfltcc_state->af));
     } else
         memset(&dfltcc_state->af, 0, sizeof(dfltcc_state->af));
 
     /* Initialize parameter block */
     memset(&dfltcc_state->param, 0, sizeof(dfltcc_state->param));
     dfltcc_state->param.nt = 1;
-
-    /* Initialize tuning parameters */
-    if (zlib_dfltcc_support == ZLIB_DFLTCC_FULL_DEBUG)
-        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK_DEBUG;
-    else
-        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
-    dfltcc_state->block_size = DFLTCC_BLOCK_SIZE;
-    dfltcc_state->block_threshold = DFLTCC_FIRST_FHT_BLOCK_SIZE;
-    dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
     dfltcc_state->param.ribm = DFLTCC_RIBM;
 }
-EXPORT_SYMBOL(dfltcc_reset);
 
 MODULE_LICENSE("GPL");
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index 1f63094366e9..b96232bdd44d 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -93,64 +93,32 @@ static_assert(sizeof(struct dfltcc_param_v0) == 1536);
 struct dfltcc_state {
     struct dfltcc_param_v0 param;      /* Parameter block */
     struct dfltcc_qaf_param af;        /* Available functions */
+    char msg[64];                      /* Buffer for strm->msg */
+};
+
+/*
+ *  Extension of inflate_state and deflate_state for DFLTCC.
+ */
+struct dfltcc_deflate_state {
+    struct dfltcc_state common;        /* Parameter block */
     uLong level_mask;                  /* Levels on which to use DFLTCC */
     uLong block_size;                  /* New block each X bytes */
     uLong block_threshold;             /* New block after total_in > X */
     uLong dht_threshold;               /* New block only if avail_in >= X */
-    char msg[64];                      /* Buffer for strm->msg */
 };
 
 #define ALIGN_UP(p, size) (__typeof__(p))(((uintptr_t)(p) + ((size) - 1)) & ~((size) - 1))
 /* Resides right after inflate_state or deflate_state */
 #define GET_DFLTCC_STATE(state) ((struct dfltcc_state *)((char *)(state) + ALIGN_UP(sizeof(*state), 8)))
 
-/* External functions */
-int dfltcc_can_deflate(z_streamp strm);
-int dfltcc_deflate(z_streamp strm,
-                   int flush,
-                   block_state *result);
-void dfltcc_reset(z_streamp strm, uInt size);
-int dfltcc_can_inflate(z_streamp strm);
-typedef enum {
-    DFLTCC_INFLATE_CONTINUE,
-    DFLTCC_INFLATE_BREAK,
-    DFLTCC_INFLATE_SOFTWARE,
-} dfltcc_inflate_action;
-dfltcc_inflate_action dfltcc_inflate(z_streamp strm,
-                                     int flush, int *ret);
+void dfltcc_reset_state(struct dfltcc_state *dfltcc_state);
+
 static inline int is_dfltcc_enabled(void)
 {
 return (zlib_dfltcc_support != ZLIB_DFLTCC_DISABLED &&
         test_facility(DFLTCC_FACILITY));
 }
 
-#define DEFLATE_RESET_HOOK(strm) \
-    dfltcc_reset((strm), sizeof(deflate_state))
-
-#define DEFLATE_HOOK dfltcc_deflate
-
-#define DEFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_deflate((strm)))
-
 #define DEFLATE_DFLTCC_ENABLED() is_dfltcc_enabled()
 
-#define INFLATE_RESET_HOOK(strm) \
-    dfltcc_reset((strm), sizeof(struct inflate_state))
-
-#define INFLATE_TYPEDO_HOOK(strm, flush) \
-    if (dfltcc_can_inflate((strm))) { \
-        dfltcc_inflate_action action; \
-\
-        RESTORE(); \
-        action = dfltcc_inflate((strm), (flush), &ret); \
-        LOAD(); \
-        if (action == DFLTCC_INFLATE_CONTINUE) \
-            break; \
-        else if (action == DFLTCC_INFLATE_BREAK) \
-            goto inf_leave; \
-    }
-
-#define INFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_inflate((strm)))
-
-#define INFLATE_NEED_UPDATEWINDOW(strm) (!dfltcc_can_inflate((strm)))
-
 #endif /* DFLTCC_H */
diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index d4c92f99808e..80924f067c24 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -2,11 +2,13 @@
 
 #include "../zlib_deflate/defutil.h"
 #include "dfltcc_util.h"
-#include "dfltcc.h"
+#include "dfltcc_deflate.h"
 #include <asm/setup.h>
 #include <linux/export.h>
 #include <linux/zutil.h>
 
+#define GET_DFLTCC_DEFLATE_STATE(state) ((struct dfltcc_deflate_state *)GET_DFLTCC_STATE(state))
+
 /*
  * Compress.
  */
@@ -15,7 +17,7 @@ int dfltcc_can_deflate(
 )
 {
     deflate_state *state = (deflate_state *)strm->state;
-    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+    struct dfltcc_deflate_state *dfltcc_state = GET_DFLTCC_DEFLATE_STATE(state);
 
     /* Check for kernel dfltcc command line parameter */
     if (zlib_dfltcc_support == ZLIB_DFLTCC_DISABLED ||
@@ -28,15 +30,32 @@ int dfltcc_can_deflate(
         return 0;
 
     /* Unsupported hardware */
-    if (!is_bit_set(dfltcc_state->af.fns, DFLTCC_GDHT) ||
-            !is_bit_set(dfltcc_state->af.fns, DFLTCC_CMPR) ||
-            !is_bit_set(dfltcc_state->af.fmts, DFLTCC_FMT0))
+    if (!is_bit_set(dfltcc_state->common.af.fns, DFLTCC_GDHT) ||
+            !is_bit_set(dfltcc_state->common.af.fns, DFLTCC_CMPR) ||
+            !is_bit_set(dfltcc_state->common.af.fmts, DFLTCC_FMT0))
         return 0;
 
     return 1;
 }
 EXPORT_SYMBOL(dfltcc_can_deflate);
 
+void dfltcc_reset_deflate_state(z_streamp strm) {
+    deflate_state *state = (deflate_state *)strm->state;
+    struct dfltcc_deflate_state *dfltcc_state = GET_DFLTCC_DEFLATE_STATE(state);
+
+    dfltcc_reset_state(&dfltcc_state->common);
+
+    /* Initialize tuning parameters */
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_FULL_DEBUG)
+        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK_DEBUG;
+    else
+        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
+    dfltcc_state->block_size = DFLTCC_BLOCK_SIZE;
+    dfltcc_state->block_threshold = DFLTCC_FIRST_FHT_BLOCK_SIZE;
+    dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
+}
+EXPORT_SYMBOL(dfltcc_reset_deflate_state);
+
 static void dfltcc_gdht(
     z_streamp strm
 )
@@ -104,8 +123,8 @@ int dfltcc_deflate(
 )
 {
     deflate_state *state = (deflate_state *)strm->state;
-    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
-    struct dfltcc_param_v0 *param = &dfltcc_state->param;
+    struct dfltcc_deflate_state *dfltcc_state = GET_DFLTCC_DEFLATE_STATE(state);
+    struct dfltcc_param_v0 *param = &dfltcc_state->common.param;
     uInt masked_avail_in;
     dfltcc_cc cc;
     int need_empty_block;
@@ -244,7 +263,7 @@ int dfltcc_deflate(
     } while (cc == DFLTCC_CC_AGAIN);
 
     /* Translate parameter block to stream */
-    strm->msg = oesc_msg(dfltcc_state->msg, param->oesc);
+    strm->msg = oesc_msg(dfltcc_state->common.msg, param->oesc);
     state->bi_valid = param->sbb;
     if (state->bi_valid == 0)
         state->bi_buf = 0; /* Avoid accessing next_out */
diff --git a/lib/zlib_dfltcc/dfltcc_deflate.h b/lib/zlib_dfltcc/dfltcc_deflate.h
new file mode 100644
index 000000000000..be44b43833b1
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc_deflate.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: Zlib
+#ifndef DFLTCC_DEFLATE_H
+#define DFLTCC_DEFLATE_H
+
+#include "dfltcc.h"
+
+/* External functions */
+int dfltcc_can_deflate(z_streamp strm);
+int dfltcc_deflate(z_streamp strm,
+                   int flush,
+                   block_state *result);
+void dfltcc_reset_deflate_state(z_streamp strm);
+
+#define DEFLATE_RESET_HOOK(strm) \
+    dfltcc_reset_deflate_state((strm))
+
+#define DEFLATE_HOOK dfltcc_deflate
+
+#define DEFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_deflate((strm)))
+
+#endif /* DFLTCC_DEFLATE_H */
diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index fb60b5a6a1cb..a16f416c8811 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -2,7 +2,7 @@
 
 #include "../zlib_inflate/inflate.h"
 #include "dfltcc_util.h"
-#include "dfltcc.h"
+#include "dfltcc_inflate.h"
 #include <asm/setup.h>
 #include <linux/export.h>
 #include <linux/zutil.h>
@@ -32,6 +32,14 @@ int dfltcc_can_inflate(
 }
 EXPORT_SYMBOL(dfltcc_can_inflate);
 
+void dfltcc_reset_inflate_state(z_streamp strm) {
+    struct inflate_state *state = (struct inflate_state *)strm->state;
+    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+
+    dfltcc_reset_state(dfltcc_state);
+}
+EXPORT_SYMBOL(dfltcc_reset_inflate_state);
+
 static int dfltcc_was_inflate_used(
     z_streamp strm
 )
diff --git a/lib/zlib_dfltcc/dfltcc_inflate.h b/lib/zlib_dfltcc/dfltcc_inflate.h
new file mode 100644
index 000000000000..98d4bc42e526
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc_inflate.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: Zlib
+#ifndef DFLTCC_INFLATE_H
+#define DFLTCC_INFLATE_H
+
+#include "dfltcc.h"
+
+/* External functions */
+void dfltcc_reset_inflate_state(z_streamp strm);
+int dfltcc_can_inflate(z_streamp strm);
+typedef enum {
+    DFLTCC_INFLATE_CONTINUE,
+    DFLTCC_INFLATE_BREAK,
+    DFLTCC_INFLATE_SOFTWARE,
+} dfltcc_inflate_action;
+dfltcc_inflate_action dfltcc_inflate(z_streamp strm,
+                                     int flush, int *ret);
+#define INFLATE_RESET_HOOK(strm) \
+    dfltcc_reset_inflate_state((strm))
+
+#define INFLATE_TYPEDO_HOOK(strm, flush) \
+    if (dfltcc_can_inflate((strm))) { \
+        dfltcc_inflate_action action; \
+\
+        RESTORE(); \
+        action = dfltcc_inflate((strm), (flush), &ret); \
+        LOAD(); \
+        if (action == DFLTCC_INFLATE_CONTINUE) \
+            break; \
+        else if (action == DFLTCC_INFLATE_BREAK) \
+            goto inf_leave; \
+    }
+
+#define INFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_inflate((strm)))
+
+#define INFLATE_NEED_UPDATEWINDOW(strm) (!dfltcc_can_inflate((strm)))
+
+#endif /* DFLTCC_DEFLATE_H */
diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
index ee39b5eb71f7..d1efad69f02b 100644
--- a/lib/zlib_inflate/inflate.c
+++ b/lib/zlib_inflate/inflate.c
@@ -17,7 +17,7 @@
 
 /* architecture-specific bits */
 #ifdef CONFIG_ZLIB_DFLTCC
-#  include "../zlib_dfltcc/dfltcc.h"
+#  include "../zlib_dfltcc/dfltcc_inflate.h"
 #else
 #define INFLATE_RESET_HOOK(strm) do {} while (0)
 #define INFLATE_TYPEDO_HOOK(strm, flush) do {} while (0)
-- 
2.34.1

