Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267596F5FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjECUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjECUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:14:36 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DB83DD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683144810;
        bh=JFXZOyA+MaNEabXquELDZyqKe3MTOQ5kU8hAyTwsfD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrCr7ZuXd3PMW6ZxxHvWngAtYnCBERRMuBbL2ZvXwVMNToqyE6ua+a1WXPpMq4C5D
         tiHKI+b2KnOKmSRV66aCPm9zymztYhXt5tBZOp2xU2LFBe/K6xhIfFQSkzq6Pk+ZlM
         /uvd4QHnPxI1DJIO8hQKR0smpMWuKMHp0QUMXOZBUpQ9i8yUJLFaNR6gabtu76C762
         +kUZu0zJUnd6iO7qRBaHc1OHDw300e0U+furA4wS1I0d0MQfvhbcQcMJCzJozcXWnU
         O3+oCCQbC4j2AeLk7TOy1r8qhmfVxHWn9A9BBxQJ+jPvT60FWmCNsHhtXZIwwzX+DX
         j6AACQLfsdXqg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBSnP6S1lz11ht;
        Wed,  3 May 2023 16:13:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 2/3] selftests/rseq: Fix arm64 buggy load-acquire/store-release macros
Date:   Wed,  3 May 2023 16:13:23 -0400
Message-Id: <20230503201324.1587003-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503201324.1587003-1-mathieu.desnoyers@efficios.com>
References: <20230503201324.1587003-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 load-acquire/store-release macros from the Linux kernel rseq
selftests are buggy. Remplace them by a working implementation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/testing/selftests/rseq/rseq-arm64.h | 58 ++++++++++++-----------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 85b90977e7e6..21e1626a7235 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -27,59 +27,61 @@
 
 #define rseq_smp_load_acquire(p)						\
 __extension__ ({								\
-	__typeof(*p) ____p1;							\
-	switch (sizeof(*p)) {							\
+	union { rseq_unqual_scalar_typeof(*(p)) __val; char __c[sizeof(*(p))]; } __u; \
+	switch (sizeof(*(p))) {							\
 	case 1:									\
-		asm volatile ("ldarb %w0, %1"					\
-			: "=r" (*(__u8 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldarb %w0, %1"				\
+			: "=r" (*(__u8 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	case 2:									\
-		asm volatile ("ldarh %w0, %1"					\
-			: "=r" (*(__u16 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldarh %w0, %1"				\
+			: "=r" (*(__u16 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	case 4:									\
-		asm volatile ("ldar %w0, %1"					\
-			: "=r" (*(__u32 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldar %w0, %1"				\
+			: "=r" (*(__u32 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	case 8:									\
-		asm volatile ("ldar %0, %1"					\
-			: "=r" (*(__u64 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldar %0, %1"				\
+			: "=r" (*(__u64 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	}									\
-	____p1;									\
+	(rseq_unqual_scalar_typeof(*(p)))__u.__val;				\
 })
 
 #define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
 
 #define rseq_smp_store_release(p, v)						\
 do {										\
-	switch (sizeof(*p)) {							\
+	union { rseq_unqual_scalar_typeof(*(p)) __val; char __c[sizeof(*(p))]; } __u = \
+		{ .__val = (rseq_unqual_scalar_typeof(*(p))) (v) };		\
+	switch (sizeof(*(p))) {							\
 	case 1:									\
-		asm volatile ("stlrb %w1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u8)v)					\
+		__asm__ __volatile__ ("stlrb %w1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u8 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	case 2:									\
-		asm volatile ("stlrh %w1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u16)v)				\
+		__asm__ __volatile__ ("stlrh %w1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u16 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	case 4:									\
-		asm volatile ("stlr %w1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u32)v)				\
+		__asm__ __volatile__ ("stlr %w1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u32 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	case 8:									\
-		asm volatile ("stlr %1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u64)v)				\
+		__asm__ __volatile__ ("stlr %1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u64 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	}									\
-- 
2.25.1

