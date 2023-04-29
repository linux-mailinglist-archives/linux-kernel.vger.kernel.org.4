Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F96F2377
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbjD2HDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjD2HDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:03:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644632D48;
        Sat, 29 Apr 2023 00:03:07 -0700 (PDT)
Date:   Sat, 29 Apr 2023 07:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682751785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+9a0jU8B8/90tNatqhnjcr9My3vk7+4IJ5l3AkohgA=;
        b=Et5kqBDwv8pOGcohKK6HTvDO5/BXM5goi4Eulh2wKO4JK0uqyE8t20mEh9iCRvQnmBpqsj
        HwFzXt6CeOAiNkoj0NYG8osmhVmgwxrGjIZTJ33azQV1uFXeC7v36ppHWB3Ct+PDTjrJu6
        VMjowyfkKL8ciZWl2szH/spSLNb/kH+XPuzU7cADgnZEtk5JAsHtZBY05o7iF6PfHzj6Um
        0MVWiYyeljw77xrnNTwQzwHNGVUeVG+FhcjxG5DTej8Ge74iJ90da0TsTwZChgAHI5FzZh
        yQRopSTdfUn+FjqLhAZyf/4PynTmFXAg0ah5DktgzX49/CIkmKi7Ukwq+1rp1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682751785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+9a0jU8B8/90tNatqhnjcr9My3vk7+4IJ5l3AkohgA=;
        b=om1n8eq1b6V3M3/Oc3Y2/Nmgd3FU+MDDt8QioyWlc/Qk8ziPhQ/QL8FwGAyyUx62G9wqaS
        EBBctXfF/8S9xqBw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/arch: Wire up local_try_cmpxchg()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230405141710.3551-4-ubizjak@gmail.com>
References: <20230405141710.3551-4-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168275178476.404.15174955783286691332.tip-bot2@tip-bot2>
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

Commit-ID:     bdf02b98474827e83e7e9254904eb18eb85552cd
Gitweb:        https://git.kernel.org/tip/bdf02b98474827e83e7e9254904eb18eb85552cd
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Apr 2023 16:17:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 29 Apr 2023 08:52:25 +02:00

locking/arch: Wire up local_try_cmpxchg()

Implement target specific support for local_try_cmpxchg()
and local_cmpxchg() using typed C wrappers that call their
_local counterpart and provide additional checking of
their input arguments.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230405141710.3551-4-ubizjak@gmail.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/alpha/include/asm/local.h     | 12 ++++++++++--
 arch/loongarch/include/asm/local.h | 13 +++++++++++--
 arch/mips/include/asm/local.h      | 13 +++++++++++--
 arch/powerpc/include/asm/local.h   | 11 +++++++++++
 arch/x86/include/asm/local.h       | 13 +++++++++++--
 5 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index fab26a1..0fcaad6 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -52,8 +52,16 @@ static __inline__ long local_sub_return(long i, local_t * l)
 	return result;
 }
 
-#define local_cmpxchg(l, o, n) \
-	(cmpxchg_local(&((l)->a.counter), (o), (n)))
+static __inline__ long local_cmpxchg(local_t *l, long old, long new)
+{
+	return cmpxchg_local(&l->a.counter, old, new);
+}
+
+static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
+{
+	return try_cmpxchg_local(&l->a.counter, (s64 *)old, new);
+}
+
 #define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
 
 /**
diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 65fbbae..83e995b 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -56,8 +56,17 @@ static inline long local_sub_return(long i, local_t *l)
 	return result;
 }
 
-#define local_cmpxchg(l, o, n) \
-	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+static inline long local_cmpxchg(local_t *l, long old, long new)
+{
+	return cmpxchg_local(&l->a.counter, old, new);
+}
+
+static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
+{
+	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
+	return try_cmpxchg_local(&l->a.counter, __old, new);
+}
+
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 08366b1..5daf6fe 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -94,8 +94,17 @@ static __inline__ long local_sub_return(long i, local_t * l)
 	return result;
 }
 
-#define local_cmpxchg(l, o, n) \
-	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+static __inline__ long local_cmpxchg(local_t *l, long old, long new)
+{
+	return cmpxchg_local(&l->a.counter, old, new);
+}
+
+static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
+{
+	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
+	return try_cmpxchg_local(&l->a.counter, __old, new);
+}
+
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index bc4bd19..45492fb 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -90,6 +90,17 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
 	return t;
 }
 
+static __inline__ bool local_try_cmpxchg(local_t *l, long *po, long n)
+{
+	long o = *po, r;
+
+	r = local_cmpxchg(l, o, n);
+	if (unlikely(r != o))
+		*po = r;
+
+	return likely(r == o);
+}
+
 static __inline__ long local_xchg(local_t *l, long n)
 {
 	long t;
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 349a47a..56d4ef6 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -120,8 +120,17 @@ static inline long local_sub_return(long i, local_t *l)
 #define local_inc_return(l)  (local_add_return(1, l))
 #define local_dec_return(l)  (local_sub_return(1, l))
 
-#define local_cmpxchg(l, o, n) \
-	(cmpxchg_local(&((l)->a.counter), (o), (n)))
+static inline long local_cmpxchg(local_t *l, long old, long new)
+{
+	return cmpxchg_local(&l->a.counter, old, new);
+}
+
+static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
+{
+	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
+	return try_cmpxchg_local(&l->a.counter, __old, new);
+}
+
 /* Always has a lock prefix */
 #define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
 
