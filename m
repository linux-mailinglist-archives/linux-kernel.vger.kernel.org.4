Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6E5723BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbjFFI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjFFI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089AE7C;
        Tue,  6 Jun 2023 01:26:29 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdqjaakNoaRTFy2P+Eoh6qcETaNLB2hDDFpUN+s1lDo=;
        b=CZuROeAYhB02M2QNyZJWAngU52+vIwE2tn6Gy5zykHAm+GehOsysOA0FZapOWq+BqE7xos
        X44hhPunBL9RWgl4CpomWMe3Sy2K4AfBGCeM88NT+uqZsxPU8S383NWs3//5TKM/J6Zwt7
        AE3BDuEt/hSIBip1ctoWThcdCckrA6xWyYWxcRHNo0YQ0/52TTC1JKNnCeugwhsdbdynpI
        Btc4Uqui5V85O6whTyt65V6lCodI+Lo8wB0I6xArVqn/o66WaBYobQf5/EUtyWkhIYu/ka
        zH40e0nzXrycXv0rUgHvnkiu1/3yW76PKYm2blDqsLc0pBQrxfAZ8B8GNYD2yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdqjaakNoaRTFy2P+Eoh6qcETaNLB2hDDFpUN+s1lDo=;
        b=Swl6RJAaUGu/1tIjh5d9blX/TfWO1b7HQcS9K7iqpRTJDy+UwlZJjmuGA35SWg4nvpP1UH
        /TJVtVxcIZf3CyCA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: arm: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-7-mark.rutland@arm.com>
References: <20230605070124.3741859-7-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998408.404.6855790470395642860.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d6cd3664806fbe8313b8e04b042d40e8135ca459
Gitweb:        https://git.kernel.org/tip/d6cd3664806fbe8313b8e04b042d40e8135ca459
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:15 +02:00

locking/atomic: arm: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/arm.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-7-mark.rutland@arm.com
---
 arch/arm/include/asm/atomic.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 9458d47..f0e3b01 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -197,6 +197,16 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 	return val;							\
 }
 
+#define arch_atomic_add_return			arch_atomic_add_return
+#define arch_atomic_sub_return			arch_atomic_sub_return
+#define arch_atomic_fetch_add			arch_atomic_fetch_add
+#define arch_atomic_fetch_sub			arch_atomic_fetch_sub
+
+#define arch_atomic_fetch_and			arch_atomic_fetch_and
+#define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
+#define arch_atomic_fetch_or			arch_atomic_fetch_or
+#define arch_atomic_fetch_xor			arch_atomic_fetch_xor
+
 static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
@@ -212,8 +222,6 @@ static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 }
 #define arch_atomic_cmpxchg arch_atomic_cmpxchg
 
-#define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
-
 #endif /* __LINUX_ARM_ARCH__ */
 
 #define ATOMIC_OPS(op, c_op, asm_op)					\
