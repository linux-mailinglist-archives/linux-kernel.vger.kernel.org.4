Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC5723BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjFFI12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbjFFI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E7FE5E;
        Tue,  6 Jun 2023 01:26:26 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039982;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVDJKw0h36cHDibWeATrGhuXpgCUKyzQWlzjEydLh2s=;
        b=xOvyIjNdgxmYGbaeDC1QnCF97EjCdDcr1JVxOrf1dLtJgd/GvdRg3N8JqGidJYuJNg9zD+
        Ef3WKwGFAASHlXFjJeN7kstc/3a4JA29Nd3IE8eOXF+x3CxOoMN8Og68MPJyxYsfEKwym5
        dRt9iKsVHt6EVY0LlCDfar8fk8RYRccqw9AR3+Q9XzOpFhwztalyE0dhXYD3HHiB0oJTvO
        jLoWeRCRp3FmWUAhTGVfRYAw7cMBkci99TDmqxyjexWvRREtYjP4s5uZv3N5FeVe8VHRNZ
        +L6i4/hf9YPG0SeQo/BfuR8nXwSnKmzZRR9hoQN4ZdsrbToIge084CuppE7r/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039982;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVDJKw0h36cHDibWeATrGhuXpgCUKyzQWlzjEydLh2s=;
        b=zBu558pBIV01czc0LkZFFLve6c3CxRZB4cr5SxW7ix4/nmxXunEz5E9ZOBHNPpjX1Fflmf
        dtcjP3oA+XAWcsAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: x86: add preprocessor symbols
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-13-mark.rutland@arm.com>
References: <20230605070124.3741859-13-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998182.404.4072857844390908185.tip-bot2@tip-bot2>
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

Commit-ID:     5bef003538ae8621c95ac6ebfd37324373fae37d
Gitweb:        https://git.kernel.org/tip/5bef003538ae8621c95ac6ebfd37324373fae37d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:17 +02:00

locking/atomic: x86: add preprocessor symbols

Some atomics can be implemented in several different ways, e.g.
FULL/ACQUIRE/RELEASE ordered atomics can be implemented in terms of
RELAXED atomics, and ACQUIRE/RELEASE/RELAXED can be implemented in terms
of FULL ordered atomics. Other atomics are optional, and don't exist in
some configurations (e.g. not all architectures implement the 128-bit
cmpxchg ops).

Subsequent patches will require that architectures define a preprocessor
symbol for any atomic (or ordering variant) which is optional. This will
make the fallback ifdeffery more robust, and simplify future changes.

Add the required definitions to arch/x86.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-13-mark.rutland@arm.com
---
 arch/x86/include/asm/cmpxchg_64.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 3e6e3ee..44b08b5 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -45,11 +45,13 @@ static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 n
 {
 	return __arch_cmpxchg128(ptr, old, new, LOCK_PREFIX);
 }
+#define arch_cmpxchg128 arch_cmpxchg128
 
 static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
 {
 	return __arch_cmpxchg128(ptr, old, new,);
 }
+#define arch_cmpxchg128_local arch_cmpxchg128_local
 
 #define __arch_try_cmpxchg128(_ptr, _oldp, _new, _lock)			\
 ({									\
@@ -75,11 +77,13 @@ static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, 
 {
 	return __arch_try_cmpxchg128(ptr, oldp, new, LOCK_PREFIX);
 }
+#define arch_try_cmpxchg128 arch_try_cmpxchg128
 
 static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
 {
 	return __arch_try_cmpxchg128(ptr, oldp, new,);
 }
+#define arch_try_cmpxchg128_local arch_try_cmpxchg128_local
 
 #define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
 
