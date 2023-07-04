Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AF7468E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGDFYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGDFYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:24:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F65E49;
        Mon,  3 Jul 2023 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ATUS35pTWGGIbN1gecgRrYg2fY7uuWWpFqHk1R/svhg=; b=dEmavBcxYytSqqvsUB+4lX3vj8
        dys2oB3OfSBO7JL7C3FaIoH3Ymz/0G7TuJuDTs0Olzn6sXQdINzf1aOZlVbriKSPretJeuvrQKViT
        JBQVUooozAgfMdeMaKHUTaaU34evLZgucZWobYuHP0MLiVcApzBGjNZzypMPJXDZjIvCnnWILRYwE
        nURzxdHMvL39Q7mrMzTn24mNXOQwkQEgQe1hkTZT/lP+SKsd2MCIOKcZ/DohuC7axk1TVkoU0kdh5
        JBTjp0YkEEYbfAam6Z7zlZ44Cz5YBaRz0+0ldAc7NpZGvVonkpbQY2b9Iw3qGHLJ4PyfRLKQPswOK
        uLdQHywQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGYWE-00CCEU-1L;
        Tue, 04 Jul 2023 05:24:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/3] jiffies: add kernel-doc for all APIs
Date:   Mon,  3 Jul 2023 22:24:04 -0700
Message-ID: <20230704052405.5089-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704052405.5089-1-rdunlap@infradead.org>
References: <20230704052405.5089-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc notation in <linux/jiffies.h> for interfaces that
don't already have it (i.e. most interfaces).

Fix some formatting and typos in other comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 include/linux/jiffies.h |  197 +++++++++++++++++++++++++++++++++-----
 1 file changed, 176 insertions(+), 21 deletions(-)

diff -- a/include/linux/jiffies.h b/include/linux/jiffies.h
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -72,9 +72,15 @@ extern int register_refined_jiffies(long
 #endif
 
 /*
- * The 64-bit value is not atomic - you MUST NOT read it
+ * The 64-bit value is not atomic on 32-bit systems - you MUST NOT read it
  * without sampling the sequence number in jiffies_lock.
  * get_jiffies_64() will do this for you as appropriate.
+ *
+ * jiffies and jiffies_64 are at the same address for little-endian systems
+ * and for 64-bit big-endian systems.
+ * On 32-bit big-endian systems, jiffies is the lower 32 bits of jiffies_64
+ * (i.e., at address @jiffies_64 + 4).
+ * See arch/ARCH/kernel/vmlinux.lds.S
  */
 extern u64 __cacheline_aligned_in_smp jiffies_64;
 extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
@@ -82,6 +88,14 @@ extern unsigned long volatile __cachelin
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
 #else
+/**
+ * get_jiffies_64 - read the 64-bit non-atomic jiffies_64 value
+ *
+ * When BITS_PER_LONG < 64, this uses sequence number sampling using
+ * jiffies_lock to protect the 64-bit read.
+ *
+ * Return: current 64-bit jiffies value
+ */
 static inline u64 get_jiffies_64(void)
 {
 	return (u64)jiffies;
@@ -89,39 +103,76 @@ static inline u64 get_jiffies_64(void)
 #endif
 
 /*
- *	These inlines deal with timer wrapping correctly. You are 
- *	strongly encouraged to use them
+ *	These inlines deal with timer wrapping correctly. You are
+ *	strongly encouraged to use them:
  *	1. Because people otherwise forget
  *	2. Because if the timer wrap changes in future you won't have to
  *	   alter your driver code.
- *
- * time_after(a,b) returns true if the time a is after time b.
+ */
+
+/**
+ * time_after - returns true if the time a is after time b.
+ * @a: first comparable as unsigned long
+ * @b: second comparable as unsigned long
  *
  * Do this with "<0" and ">=0" to only test the sign of the result. A
  * good compiler would generate better code (and a really good compiler
  * wouldn't care). Gcc is currently neither.
+ *
+ * Return: %true is time a is after time b, otherwise %false.
  */
 #define time_after(a,b)		\
 	(typecheck(unsigned long, a) && \
 	 typecheck(unsigned long, b) && \
 	 ((long)((b) - (a)) < 0))
+/**
+ * time_before - returns true if the time a is before time b.
+ * @a: first comparable as unsigned long
+ * @b: second comparable as unsigned long
+ *
+ * Return: %true is time a is before time b, otherwise %false.
+ */
 #define time_before(a,b)	time_after(b,a)
 
+/**
+ * time_after_eq - returns true if the time a is after or the same as time b.
+ * @a: first comparable as unsigned long
+ * @b: second comparable as unsigned long
+ *
+ * Return: %true is time a is after or the same as time b, otherwise %false.
+ */
 #define time_after_eq(a,b)	\
 	(typecheck(unsigned long, a) && \
 	 typecheck(unsigned long, b) && \
 	 ((long)((a) - (b)) >= 0))
+/**
+ * time_before_eq - returns true if the time a is before or the same as time b.
+ * @a: first comparable as unsigned long
+ * @b: second comparable as unsigned long
+ *
+ * Return: %true is time a is before or the same as time b, otherwise %false.
+ */
 #define time_before_eq(a,b)	time_after_eq(b,a)
 
-/*
- * Calculate whether a is in the range of [b, c].
+/**
+ * time_in_range - Calculate whether a is in the range of [b, c].
+ * @a: time to test
+ * @b: beginning of the range
+ * @c: end of the range
+ *
+ * Return: %true is time a is in the range [b, c], otherwise %false.
  */
 #define time_in_range(a,b,c) \
 	(time_after_eq(a,b) && \
 	 time_before_eq(a,c))
 
-/*
- * Calculate whether a is in the range of [b, c).
+/**
+ * time_in_range_open - Calculate whether a is in the range of [b, c).
+ * @a: time to test
+ * @b: beginning of the range
+ * @c: end of the range
+ *
+ * Return: %true is time a is in the range [b, c), otherwise %false.
  */
 #define time_in_range_open(a,b,c) \
 	(time_after_eq(a,b) && \
@@ -129,45 +180,138 @@ static inline u64 get_jiffies_64(void)
 
 /* Same as above, but does so with platform independent 64bit types.
  * These must be used when utilizing jiffies_64 (i.e. return value of
- * get_jiffies_64() */
+ * get_jiffies_64()). */
+
+/**
+ * time_after64 - returns true if the time a is after time b.
+ * @a: first comparable as __u64
+ * @b: second comparable as __u64
+ *
+ * This must be used when utilizing jiffies_64 (i.e. return value of
+ * get_jiffies_64()).
+ *
+ * Return: %true is time a is after time b, otherwise %false.
+ */
 #define time_after64(a,b)	\
 	(typecheck(__u64, a) &&	\
 	 typecheck(__u64, b) && \
 	 ((__s64)((b) - (a)) < 0))
+/**
+ * time_before64 - returns true if the time a is before time b.
+ * @a: first comparable as __u64
+ * @b: second comparable as __u64
+ *
+ * This must be used when utilizing jiffies_64 (i.e. return value of
+ * get_jiffies_64()).
+ *
+ * Return: %true is time a is before time b, otherwise %false.
+ */
 #define time_before64(a,b)	time_after64(b,a)
 
+/**
+ * time_after_eq64 - returns true if the time a is after or the same as time b.
+ * @a: first comparable as __u64
+ * @b: second comparable as __u64
+ *
+ * This must be used when utilizing jiffies_64 (i.e. return value of
+ * get_jiffies_64()).
+ *
+ * Return: %true is time a is after or the same as time b, otherwise %false.
+ */
 #define time_after_eq64(a,b)	\
 	(typecheck(__u64, a) && \
 	 typecheck(__u64, b) && \
 	 ((__s64)((a) - (b)) >= 0))
+/**
+ * time_before_eq64 - returns true if the time a is before or the same as time b.
+ * @a: first comparable as __u64
+ * @b: second comparable as __u64
+ *
+ * This must be used when utilizing jiffies_64 (i.e. return value of
+ * get_jiffies_64()).
+ *
+ * Return: %true is time a is before or the same as time b, otherwise %false.
+ */
 #define time_before_eq64(a,b)	time_after_eq64(b,a)
 
+/**
+ * time_in_range64 - Calculate whether a is in the range of [b, c].
+ * @a: time to test
+ * @b: beginning of the range
+ * @c: end of the range
+ *
+ * Return: %true is time a is in the range [b, c], otherwise %false.
+ */
 #define time_in_range64(a, b, c) \
 	(time_after_eq64(a, b) && \
 	 time_before_eq64(a, c))
 
 /*
- * These four macros compare jiffies and 'a' for convenience.
+ * These eight macros compare jiffies[_64] and 'a' for convenience.
  */
 
-/* time_is_before_jiffies(a) return true if a is before jiffies */
+/**
+ * time_is_before_jiffies - return true if a is before jiffies
+ * @a: time (unsigned long) to compare to jiffies
+ *
+ * Return: %true is time a is before jiffies, otherwise %false.
+ */
 #define time_is_before_jiffies(a) time_after(jiffies, a)
+/**
+ * time_is_before_jiffies64 - return true if a is before jiffies_64
+ * @a: time (__u64) to compare to jiffies_64
+ *
+ * Return: %true is time a is before jiffies_64, otherwise %false.
+ */
 #define time_is_before_jiffies64(a) time_after64(get_jiffies_64(), a)
 
-/* time_is_after_jiffies(a) return true if a is after jiffies */
+/**
+ * time_is_after_jiffies - return true if a is after jiffies
+ * @a: time (unsigned long) to compare to jiffies
+ *
+ * Return: %true is time a is after jiffies, otherwise %false.
+ */
 #define time_is_after_jiffies(a) time_before(jiffies, a)
+/**
+ * time_is_after_jiffies64 - return true if a is after jiffies_64
+ * @a: time (__u64) to compare to jiffies_64
+ *
+ * Return: %true is time a is after jiffies_64, otherwise %false.
+ */
 #define time_is_after_jiffies64(a) time_before64(get_jiffies_64(), a)
 
-/* time_is_before_eq_jiffies(a) return true if a is before or equal to jiffies*/
+/**
+ * time_is_before_eq_jiffies - return true if a is before or equal to jiffies
+ * @a: time (unsigned long) to compare to jiffies
+ *
+ * Return: %true is time a is before or the same as jiffies, otherwise %false.
+ */
 #define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)
+/**
+ * time_is_before_eq_jiffies64 - return true if a is before or equal to jiffies_64
+ * @a: time (__u64) to compare to jiffies_64
+ *
+ * Return: %true is time a is before or the same jiffies_64, otherwise %false.
+ */
 #define time_is_before_eq_jiffies64(a) time_after_eq64(get_jiffies_64(), a)
 
-/* time_is_after_eq_jiffies(a) return true if a is after or equal to jiffies*/
+/**
+ * time_is_after_eq_jiffies - return true if a is after or equal to jiffies
+ * @a: time (unsigned long) to compare to jiffies
+ *
+ * Return: %true is time a is after or the same as jiffies, otherwise %false.
+ */
 #define time_is_after_eq_jiffies(a) time_before_eq(jiffies, a)
+/**
+ * time_is_after_eq_jiffies64 - return true if a is after or equal to jiffies_64
+ * @a: time (__u64) to compare to jiffies_64
+ *
+ * Return: %true is time a is after or the same as jiffies_64, otherwise %false.
+ */
 #define time_is_after_eq_jiffies64(a) time_before_eq64(get_jiffies_64(), a)
 
 /*
- * Have the 32 bit jiffies value wrap 5 minutes after boot
+ * Have the 32-bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
@@ -278,7 +422,7 @@ extern unsigned long preset_lpj;
 #if BITS_PER_LONG < 64
 # define MAX_SEC_IN_JIFFIES \
 	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
-#else	/* take care of overflow on 64 bits machines */
+#else	/* take care of overflow on 64-bit machines */
 # define MAX_SEC_IN_JIFFIES \
 	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
 
@@ -290,6 +434,12 @@ extern unsigned long preset_lpj;
 extern unsigned int jiffies_to_msecs(const unsigned long j);
 extern unsigned int jiffies_to_usecs(const unsigned long j);
 
+/**
+ * jiffies_to_nsecs - Convert jiffies to nanoseconds
+ * @j: jiffies value
+ *
+ * Return: nanoseconds value
+ */
 static inline u64 jiffies_to_nsecs(const unsigned long j)
 {
 	return (u64)jiffies_to_usecs(j) * NSEC_PER_USEC;
@@ -353,12 +503,14 @@ static inline unsigned long _msecs_to_ji
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
- * code, __msecs_to_jiffies() is called if the value passed does not
+ * code. __msecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at
  * runtime.
- * the HZ range specific helpers _msecs_to_jiffies() are called both
+ * The HZ range specific helpers _msecs_to_jiffies() are called both
  * directly here and from __msecs_to_jiffies() in the case where
  * constant folding is not possible.
+ *
+ * Return: jiffies value
  */
 static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
@@ -400,12 +552,14 @@ static inline unsigned long _usecs_to_ji
  *
  * usecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
- * code, __usecs_to_jiffies() is called if the value passed does not
+ * code. __usecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at
  * runtime.
- * the HZ range specific helpers _usecs_to_jiffies() are called both
+ * The HZ range specific helpers _usecs_to_jiffies() are called both
  * directly here and from __msecs_to_jiffies() in the case where
  * constant folding is not possible.
+ *
+ * Return: jiffies value
  */
 static __always_inline unsigned long usecs_to_jiffies(const unsigned int u)
 {
@@ -422,6 +576,7 @@ extern unsigned long timespec64_to_jiffi
 extern void jiffies_to_timespec64(const unsigned long jiffies,
 				  struct timespec64 *value);
 extern clock_t jiffies_to_clock_t(unsigned long x);
+
 static inline clock_t jiffies_delta_to_clock_t(long delta)
 {
 	return jiffies_to_clock_t(max(0L, delta));
