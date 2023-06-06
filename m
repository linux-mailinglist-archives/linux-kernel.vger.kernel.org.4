Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99E723BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjFFI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjFFI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC96E6E;
        Tue,  6 Jun 2023 01:26:27 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAVGDg6SAPhX//KaQQfqWqsT/V97QwEj108aI0HPC10=;
        b=1TDFtIBF+z69REZIrnSsI2esQ1TkjvvtcrDYhJMBBuixMiWuSfLiHaP4S28DmH6GqQS3ej
        ebdvmNoZQrCAV3iA1EL1LepnyRJlKIpXZyLS/0KwpmHlE9FD8DJ9TcY7Ihl2Lfya8GyfeU
        0WtvWb/FcP+knKT4c/c/C567MzsczL3fuUcYHPLxhwC3kBFjL413KVDB3gJ2rbKa0/0fuY
        v4snH9J9ou6RkCXRVj4RPriZvzkonI2+cPdyyzbJExRWRAt4AyZwoi3/f4r8Y94cvbe8Lg
        JFTjHEZ9Q6sgZBNDSc4oa9MRrAlI7Dj+pdLPOvByMSEMQQVyQhURR9p5H6w1uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAVGDg6SAPhX//KaQQfqWqsT/V97QwEj108aI0HPC10=;
        b=yZkHfUl9+V8caF9IKaQl1tNPnQTmwqhfzYyeJMrrSwy7Zs4cSihJ6kd2onSCqA7g5P2F8h
        QpqNb44k/g6hSrDQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: hexagon: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-8-mark.rutland@arm.com>
References: <20230605070124.3741859-8-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998369.404.1163390053424911788.tip-bot2@tip-bot2>
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

Commit-ID:     8ad17f2183fd7e37ceafddbdff334a3e2608cc84
Gitweb:        https://git.kernel.org/tip/8ad17f2183fd7e37ceafddbdff334a3e2608cc84
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:15 +02:00

locking/atomic: hexagon: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/hexagon.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-8-mark.rutland@arm.com
---
 arch/hexagon/include/asm/atomic.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index ad6c111..5c84400 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -91,6 +91,11 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define arch_atomic_add_return			arch_atomic_add_return
+#define arch_atomic_sub_return			arch_atomic_sub_return
+#define arch_atomic_fetch_add			arch_atomic_fetch_add
+#define arch_atomic_fetch_sub			arch_atomic_fetch_sub
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
@@ -98,6 +103,10 @@ ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
 
+#define arch_atomic_fetch_and			arch_atomic_fetch_and
+#define arch_atomic_fetch_or			arch_atomic_fetch_or
+#define arch_atomic_fetch_xor			arch_atomic_fetch_xor
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
