Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B4723BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjFFI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjFFI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004410C0;
        Tue,  6 Jun 2023 01:26:30 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9b5YqzWkrWpXL93oJftbhWypTcUcmLfV94k37z2BXA=;
        b=iyAN4HYQnCFZ1OMqSzXKhm5nArjBPbiLIeGoDXJ8xlGPHbW5B7etvAQx0gX7dUNGdEQrbS
        6JmgCgKjxbb05ndEYASMAexVXMZ6cB2yYE1QsqN/5D9B+lqYKrju1BXi7b1XKQTHz2Sx2G
        qmXKPgFpkk+c9dhDhYRt8ALuMTbeZUJsMg1qRUfsi6MtKG0UUTH+6YQM+F5O77u+tmghCC
        5+pBhP434M4fbVV/MZq/dWj6ge0yrypuzugT/pRzAol2uQuJJw7AAhqopjQr71v0zY6DaK
        qAnI89jf81n3KOr62wC0I/ounmpU1XbYa9djD3ske/2zMEOY7bkigYGbNUlZug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9b5YqzWkrWpXL93oJftbhWypTcUcmLfV94k37z2BXA=;
        b=slFDmFkEEDu/eM+qoTKnAu4dbq4/CTMrsnxXPPmPhPeMKqn3asQbc27lAqeDkehhgsDTXf
        pUk14JpFC+BwImCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: hexagon: remove redundant
 arch_atomic_cmpxchg
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-4-mark.rutland@arm.com>
References: <20230605070124.3741859-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998520.404.12435529106127036312.tip-bot2@tip-bot2>
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

Commit-ID:     a7bafa7969da1c0e9c342c792d8224078d1c491c
Gitweb:        https://git.kernel.org/tip/a7bafa7969da1c0e9c342c792d8224078d1c491c
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:13 +02:00

locking/atomic: hexagon: remove redundant arch_atomic_cmpxchg

Hexagon's implementation of arch_atomic_cmpxchg() is identical to its
implementation of arch_cmpxchg(). Have it define arch_atomic_cmpxchg()
in terms of arch_cmpxchg(), matching what it does for arch_atomic_xchg()
and arch_xchg().

At the same time, remove the kerneldoc comments for hexagon's
arch_atomic_xchg() and arch_atomic_cmpxchg(). The arch_atomic_*()
namespace is shared by all architectures and the API should be
documented centrally, and the comments aren't all that helpful as-is.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-4-mark.rutland@arm.com
---
 arch/hexagon/include/asm/atomic.h | 46 ++----------------------------
 1 file changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 6e94f8d..738857e 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -36,49 +36,11 @@ static inline void arch_atomic_set(atomic_t *v, int new)
  */
 #define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
-/**
- * arch_atomic_xchg - atomic
- * @v: pointer to memory to change
- * @new: new value (technically passed in a register -- see xchg)
- */
-#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), (new)))
-
-
-/**
- * arch_atomic_cmpxchg - atomic compare-and-exchange values
- * @v: pointer to value to change
- * @old:  desired old value to match
- * @new:  new value to put in
- *
- * Parameters are then pointer, value-in-register, value-in-register,
- * and the output is the old value.
- *
- * Apparently this is complicated for archs that don't support
- * the memw_locked like we do (or it's broken or whatever).
- *
- * Kind of the lynchpin of the rest of the generically defined routines.
- * Remember V2 had that bug with dotnew predicate set by memw_locked.
- *
- * "old" is "expected" old val, __oldval is actual old value
- */
-static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	int __oldval;
+#define arch_atomic_xchg(v, new)					\
+	(arch_xchg(&((v)->counter), (new)))
 
-	asm volatile(
-		"1:	%0 = memw_locked(%1);\n"
-		"	{ P0 = cmp.eq(%0,%2);\n"
-		"	  if (!P0.new) jump:nt 2f; }\n"
-		"	memw_locked(%1,P0) = %3;\n"
-		"	if (!P0) jump 1b;\n"
-		"2:\n"
-		: "=&r" (__oldval)
-		: "r" (&v->counter), "r" (old), "r" (new)
-		: "memory", "p0"
-	);
-
-	return __oldval;
-}
+#define arch_atomic_cmpxchg(v, old, new)				\
+	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
 #define ATOMIC_OP(op)							\
 static inline void arch_atomic_##op(int i, atomic_t *v)			\
