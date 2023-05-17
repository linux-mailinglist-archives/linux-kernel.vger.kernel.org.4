Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225467069AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjEQNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjEQNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CC19BD;
        Wed, 17 May 2023 06:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA3D6435E;
        Wed, 17 May 2023 13:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C252C433EF;
        Wed, 17 May 2023 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329747;
        bh=kOiatuzHsXf6QCfoX/dn21WUzpfgb5KaOfzC26f90Zo=;
        h=From:To:Cc:Subject:Date:From;
        b=XHdoBVopIBFp9u3NUtzX8zsVUCrgJPg/GcgSg2H2tRYfaboEy+qNa2efQnFLRnTiZ
         RV8zuBCCNbIg+8I1i4wPMiMblmAbyfDt4sySoL9MseG4Vw1H1qcr5O6E078MDAZChN
         UB+1hJ3JE8W4twf5vYYzn1wSFvmZbdslrLVE65xMkBvsuCQtoxbRJHqomHmt5TDSlm
         ppx3jUpbCLVufS93I5hT5Qp/HkBoSyT6Ma+TQn1qd/v39HXL5TVYPns28GrQZP1quP
         olyGfnx7ZX3UgAMMtnxJpV5xW1aewJhKW8oGd2ZBKvtMqoMwWD2bx9g4d9jMKVi1q4
         n3BnP7qfBecSw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Song Liu <song@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-raid@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] raid6: neon: add missing prototypes
Date:   Wed, 17 May 2023 15:22:12 +0200
Message-Id: <20230517132220.937200-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The raid6 syndrome functions are generated for different sizes and have
no generic prototype, while in the inner functions have a prototype
in a header that cannot be included from the correct file. In both
cases, the compiler warns about missing prototypes:

lib/raid6/recov_neon_inner.c:27:6: warning: no previous prototype for '__raid6_2data_recov_neon' [-Wmissing-prototypes]
lib/raid6/recov_neon_inner.c:77:6: warning: no previous prototype for '__raid6_datap_recov_neon' [-Wmissing-prototypes]
lib/raid6/neon1.c:56:6: warning: no previous prototype for 'raid6_neon1_gen_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon1.c:86:6: warning: no previous prototype for 'raid6_neon1_xor_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon2.c:56:6: warning: no previous prototype for 'raid6_neon2_gen_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon2.c:97:6: warning: no previous prototype for 'raid6_neon2_xor_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon4.c:56:6: warning: no previous prototype for 'raid6_neon4_gen_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon4.c:119:6: warning: no previous prototype for 'raid6_neon4_xor_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon8.c:56:6: warning: no previous prototype for 'raid6_neon8_gen_syndrome_real' [-Wmissing-prototypes]
lib/raid6/neon8.c:163:6: warning: no previous prototype for 'raid6_neon8_xor_syndrome_real' [-Wmissing-prototypes]

Add a new header file that contains the prototypes for both to avoid
the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/raid6/neon.h             | 22 ++++++++++++++++++++++
 lib/raid6/neon.uc            |  1 +
 lib/raid6/recov_neon.c       |  8 +-------
 lib/raid6/recov_neon_inner.c |  1 +
 4 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 lib/raid6/neon.h

diff --git a/lib/raid6/neon.h b/lib/raid6/neon.h
new file mode 100644
index 000000000000..2ca41ee9b499
--- /dev/null
+++ b/lib/raid6/neon.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+void raid6_neon1_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs);
+void raid6_neon1_xor_syndrome_real(int disks, int start, int stop,
+				    unsigned long bytes, void **ptrs);
+void raid6_neon2_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs);
+void raid6_neon2_xor_syndrome_real(int disks, int start, int stop,
+				    unsigned long bytes, void **ptrs);
+void raid6_neon4_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs);
+void raid6_neon4_xor_syndrome_real(int disks, int start, int stop,
+				    unsigned long bytes, void **ptrs);
+void raid6_neon8_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs);
+void raid6_neon8_xor_syndrome_real(int disks, int start, int stop,
+				    unsigned long bytes, void **ptrs);
+void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dp,
+			      uint8_t *dq, const uint8_t *pbmul,
+			      const uint8_t *qmul);
+
+void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dq,
+			      const uint8_t *qmul);
+
+
diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
index b7c68030da4f..355270af0cd6 100644
--- a/lib/raid6/neon.uc
+++ b/lib/raid6/neon.uc
@@ -25,6 +25,7 @@
  */
 
 #include <arm_neon.h>
+#include "neon.h"
 
 typedef uint8x16_t unative_t;
 
diff --git a/lib/raid6/recov_neon.c b/lib/raid6/recov_neon.c
index d6fba8bf8c0a..1bfc14174d4d 100644
--- a/lib/raid6/recov_neon.c
+++ b/lib/raid6/recov_neon.c
@@ -8,6 +8,7 @@
 
 #ifdef __KERNEL__
 #include <asm/neon.h>
+#include "neon.h"
 #else
 #define kernel_neon_begin()
 #define kernel_neon_end()
@@ -19,13 +20,6 @@ static int raid6_has_neon(void)
 	return cpu_has_neon();
 }
 
-void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dp,
-			      uint8_t *dq, const uint8_t *pbmul,
-			      const uint8_t *qmul);
-
-void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dq,
-			      const uint8_t *qmul);
-
 static void raid6_2data_recov_neon(int disks, size_t bytes, int faila,
 		int failb, void **ptrs)
 {
diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
index 90eb80d43790..f9e7e8f5a151 100644
--- a/lib/raid6/recov_neon_inner.c
+++ b/lib/raid6/recov_neon_inner.c
@@ -5,6 +5,7 @@
  */
 
 #include <arm_neon.h>
+#include "neon.h"
 
 #ifdef CONFIG_ARM
 /*
-- 
2.39.2

