Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6A7468E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGDFYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjGDFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:24:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C408E52;
        Mon,  3 Jul 2023 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hgDOe718j7PFvCpJQd59expryvQV5xbxa5ErU2Tl+0g=; b=vvkUhJYxFKhGLRj1eLEAWrEuiE
        TaSOVGomfPOyTrZF6X2dkZfVmMNdFCKxMWAJ0fQzEPLcPdPfLwPCf+tTJyow78fK2LYYsZKKam1wq
        iraiVXOuh3qbuuU20tji+7dilsg2RxRoYrntnH17ONMNGS6bRZq8dX2muwVNz8PZaRCuL9Thz7Zlt
        nuB9Z1sEJx/4P0O20+IPs1zZYj0CZKWqlBV1yPLpR7HtEoZh8/cGvcnxzMlXp9zEz3zz9jxFK1iHn
        GmYdTmO381xpgbIJAPN+PZCBKgyzAOv3ZJiVR9K+pHuU1+M2+gC1TSc19AtS6kG810SUY4NpyrOCF
        sZQYXn9g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGYWE-00CCEU-2d;
        Tue, 04 Jul 2023 05:24:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/3] time: add kernel-doc in time.c
Date:   Mon,  3 Jul 2023 22:24:05 -0700
Message-ID: <20230704052405.5089-3-rdunlap@infradead.org>
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

Add kernel-doc for all APIs that do not already have it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 kernel/time/time.c |  169 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 158 insertions(+), 11 deletions(-)

diff -- a/kernel/time/time.c b/kernel/time/time.c
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -365,11 +365,14 @@ SYSCALL_DEFINE1(adjtimex_time32, struct
 }
 #endif
 
-/*
- * Convert jiffies to milliseconds and back.
+/**
+ * jiffies_to_msecs - Convert jiffies to milliseconds
+ * @j: jiffies value
  *
  * Avoid unnecessary multiplications/divisions in the
- * two most common HZ cases:
+ * two most common HZ cases.
+ *
+ * Return: milliseconds value
  */
 unsigned int jiffies_to_msecs(const unsigned long j)
 {
@@ -388,6 +391,12 @@ unsigned int jiffies_to_msecs(const unsi
 }
 EXPORT_SYMBOL(jiffies_to_msecs);
 
+/**
+ * jiffies_to_usecs - Convert jiffies to microseconds
+ * @j: jiffies value
+ *
+ * Return: microseconds value
+ */
 unsigned int jiffies_to_usecs(const unsigned long j)
 {
 	/*
@@ -408,8 +417,15 @@ unsigned int jiffies_to_usecs(const unsi
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
 
-/*
+/**
  * mktime64 - Converts date to seconds.
+ * @year0: year to convert
+ * @mon0: month to convert
+ * @day: day to convert
+ * @hour: hour to convert
+ * @min: minute to convert
+ * @sec: second to convert
+ *
  * Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
@@ -427,6 +443,8 @@ EXPORT_SYMBOL(jiffies_to_usecs);
  *
  * An encoding of midnight at the end of the day as 24:00:00 - ie. midnight
  * tomorrow - (allowable under ISO 8601) is supported.
+ *
+ * Return: seconds since the epoch time for the given input date
  */
 time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 		const unsigned int day, const unsigned int hour,
@@ -471,8 +489,7 @@ EXPORT_SYMBOL(ns_to_kernel_old_timeval);
  * Set seconds and nanoseconds field of a timespec variable and
  * normalize to the timespec storage format
  *
- * Note: The tv_nsec part is always in the range of
- *	0 <= tv_nsec < NSEC_PER_SEC
+ * Note: The tv_nsec part is always in the range of 0 <= tv_nsec < NSEC_PER_SEC.
  * For negative values only the tv_sec field is negative !
  */
 void set_normalized_timespec64(struct timespec64 *ts, time64_t sec, s64 nsec)
@@ -501,7 +518,7 @@ EXPORT_SYMBOL(set_normalized_timespec64)
  * ns_to_timespec64 - Convert nanoseconds to timespec64
  * @nsec:       the nanoseconds value to be converted
  *
- * Returns the timespec64 representation of the nsec parameter.
+ * Return: the timespec64 representation of the nsec parameter.
  */
 struct timespec64 ns_to_timespec64(s64 nsec)
 {
@@ -548,6 +565,8 @@ EXPORT_SYMBOL(ns_to_timespec64);
  * runtime.
  * The _msecs_to_jiffies helpers are the HZ dependent conversion
  * routines found in include/linux/jiffies.h
+ *
+ * Return: jiffies value
  */
 unsigned long __msecs_to_jiffies(const unsigned int m)
 {
@@ -560,6 +579,12 @@ unsigned long __msecs_to_jiffies(const u
 }
 EXPORT_SYMBOL(__msecs_to_jiffies);
 
+/**
+ * __usecs_to_jiffies: - convert microseconds to jiffies
+ * @u:	time in milliseconds
+ *
+ * Return: jiffies value
+ */
 unsigned long __usecs_to_jiffies(const unsigned int u)
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
@@ -568,7 +593,10 @@ unsigned long __usecs_to_jiffies(const u
 }
 EXPORT_SYMBOL(__usecs_to_jiffies);
 
-/*
+/**
+ * timespec64_to_jiffies - convert a timespec64 value to jiffies
+ * @value: pointer to &struct timespec64
+ *
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
  * resolution values don't fall on second boundaries.  I.e. the line:
@@ -582,8 +610,9 @@ EXPORT_SYMBOL(__usecs_to_jiffies);
  *
  * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
  * value to a scaled second value.
+ *
+ * Return: jiffies value
  */
-
 unsigned long
 timespec64_to_jiffies(const struct timespec64 *value)
 {
@@ -601,6 +630,11 @@ timespec64_to_jiffies(const struct times
 }
 EXPORT_SYMBOL(timespec64_to_jiffies);
 
+/**
+ * jiffies_to_timespec64 - convert jiffies value to &struct timespec64
+ * @jiffies: jiffies value
+ * @value: pointer to &struct timespec64
+ */
 void
 jiffies_to_timespec64(const unsigned long jiffies, struct timespec64 *value)
 {
@@ -618,6 +652,13 @@ EXPORT_SYMBOL(jiffies_to_timespec64);
 /*
  * Convert jiffies/jiffies_64 to clock_t and back.
  */
+
+/**
+ * jiffies_to_clock_t - Convert jiffies to clock_t
+ * @x: jiffies value
+ *
+ * Return: jiffies converted to clock_t (CLOCKS_PER_SEC)
+ */
 clock_t jiffies_to_clock_t(unsigned long x)
 {
 #if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
@@ -632,6 +673,12 @@ clock_t jiffies_to_clock_t(unsigned long
 }
 EXPORT_SYMBOL(jiffies_to_clock_t);
 
+/**
+ * clock_t_to_jiffies - Convert clock_t to jiffies
+ * @x: clock_t value
+ *
+ * Return: clock_t value converted to jiffies
+ */
 unsigned long clock_t_to_jiffies(unsigned long x)
 {
 #if (HZ % USER_HZ)==0
@@ -649,6 +696,12 @@ unsigned long clock_t_to_jiffies(unsigne
 }
 EXPORT_SYMBOL(clock_t_to_jiffies);
 
+/**
+ * jiffies_64_to_clock_t - Convert jiffies_64 to clock_t
+ * @x: jiffies_64 value
+ *
+ * Return: jiffies_64 value converted to 64-bit "clock_t" (CLOCKS_PER_SEC)
+ */
 u64 jiffies_64_to_clock_t(u64 x)
 {
 #if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
@@ -671,6 +724,12 @@ u64 jiffies_64_to_clock_t(u64 x)
 }
 EXPORT_SYMBOL(jiffies_64_to_clock_t);
 
+/**
+ * nsec_to_clock_t - Convert nsec value to clock_t
+ * @x: nsec value
+ *
+ * Return: nsec value converted to 64-bit "clock_t" (CLOCKS_PER_SEC)
+ */
 u64 nsec_to_clock_t(u64 x)
 {
 #if (NSEC_PER_SEC % USER_HZ) == 0
@@ -687,6 +746,12 @@ u64 nsec_to_clock_t(u64 x)
 #endif
 }
 
+/**
+ * jiffies64_to_nsecs - Convert jiffies64 to nanoseconds
+ * @j: jiffies64 value
+ *
+ * Return: nanoseconds value
+ */
 u64 jiffies64_to_nsecs(u64 j)
 {
 #if !(NSEC_PER_SEC % HZ)
@@ -697,6 +762,12 @@ u64 jiffies64_to_nsecs(u64 j)
 }
 EXPORT_SYMBOL(jiffies64_to_nsecs);
 
+/**
+ * jiffies64_to_msecs - Convert jiffies64 to milliseconds
+ * @j: jiffies64 value
+ *
+ * Return: milliseconds value
+ */
 u64 jiffies64_to_msecs(const u64 j)
 {
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
@@ -719,6 +790,8 @@ EXPORT_SYMBOL(jiffies64_to_msecs);
  * note:
  *   NSEC_PER_SEC = 10^9 = (5^9 * 2^9) = (1953125 * 512)
  *   ULLONG_MAX ns = 18446744073.709551615 secs = about 584 years
+ *
+ * Return: nsecs converted to jiffies64 value
  */
 u64 nsecs_to_jiffies64(u64 n)
 {
@@ -750,6 +823,8 @@ EXPORT_SYMBOL(nsecs_to_jiffies64);
  * note:
  *   NSEC_PER_SEC = 10^9 = (5^9 * 2^9) = (1953125 * 512)
  *   ULLONG_MAX ns = 18446744073.709551615 secs = about 584 years
+ *
+ * Return: nsecs converted to jiffies value
  */
 unsigned long nsecs_to_jiffies(u64 n)
 {
@@ -757,10 +832,16 @@ unsigned long nsecs_to_jiffies(u64 n)
 }
 EXPORT_SYMBOL_GPL(nsecs_to_jiffies);
 
-/*
- * Add two timespec64 values and do a safety check for overflow.
+/**
+ * timespec64_add_safe - Add two timespec64 values and do a safety check
+ * for overflow.
+ * @lhs: first (left) timespec64 to add
+ * @rhs: second (right) timespec64 to add
+ *
  * It's assumed that both values are valid (>= 0).
  * And, each timespec64 is in normalized form.
+ *
+ * Return: sum of @lhs + @rhs
  */
 struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
 				const struct timespec64 rhs)
@@ -778,6 +859,15 @@ struct timespec64 timespec64_add_safe(co
 	return res;
 }
 
+/**
+ * get_timespec64 - get user's time value into kernel space
+ * @ts: destination &struct timespec64
+ * @uts: user's time value as &struct __kernel_timespec
+ *
+ * Handles compat or 32-bit modes.
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int get_timespec64(struct timespec64 *ts,
 		   const struct __kernel_timespec __user *uts)
 {
@@ -801,6 +891,14 @@ int get_timespec64(struct timespec64 *ts
 }
 EXPORT_SYMBOL_GPL(get_timespec64);
 
+/**
+ * put_timespec64 - convert timespec64 value to __kernel_timespec format and
+ * 		    copy the latter to userspace
+ * @ts: input &struct timespec64
+ * @uts: user's &struct __kernel_timespec
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int put_timespec64(const struct timespec64 *ts,
 		   struct __kernel_timespec __user *uts)
 {
@@ -839,6 +937,15 @@ static int __put_old_timespec32(const st
 	return copy_to_user(cts, &ts, sizeof(ts)) ? -EFAULT : 0;
 }
 
+/**
+ * get_old_timespec32 - get user's old-format time value into kernel space
+ * @ts: destination &struct timespec64
+ * @uts: user's old-format time value (&struct old_timespec32)
+ *
+ * Handles X86_X32_ABI compatibility conversion.
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int get_old_timespec32(struct timespec64 *ts, const void __user *uts)
 {
 	if (COMPAT_USE_64BIT_TIME)
@@ -848,6 +955,16 @@ int get_old_timespec32(struct timespec64
 }
 EXPORT_SYMBOL_GPL(get_old_timespec32);
 
+/**
+ * put_old_timespec32 - convert timespec64 value to &struct old_timespec32 and
+ * 			copy the latter to userspace
+ * @ts: input &struct timespec64
+ * @uts: user's &struct old_timespec32
+ *
+ * Handles X86_X32_ABI compatibility conversion.
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int put_old_timespec32(const struct timespec64 *ts, void __user *uts)
 {
 	if (COMPAT_USE_64BIT_TIME)
@@ -857,6 +974,13 @@ int put_old_timespec32(const struct time
 }
 EXPORT_SYMBOL_GPL(put_old_timespec32);
 
+/**
+ * get_itimerspec64 - get user's &struct __kernel_itimerspec into kernel space
+ * @it: destination &struct itimerspec64
+ * @uit: user's &struct __kernel_itimerspec
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct __kernel_itimerspec __user *uit)
 {
@@ -872,6 +996,14 @@ int get_itimerspec64(struct itimerspec64
 }
 EXPORT_SYMBOL_GPL(get_itimerspec64);
 
+/**
+ * put_itimerspec64 - convert &struct itimerspec64 to __kernel_itimerspec format
+ * 		      and copy the latter to userspace
+ * @it: input &struct itimerspec64
+ * @uit: user's &struct __kernel_itimerspec
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int put_itimerspec64(const struct itimerspec64 *it,
 			struct __kernel_itimerspec __user *uit)
 {
@@ -887,6 +1019,13 @@ int put_itimerspec64(const struct itimer
 }
 EXPORT_SYMBOL_GPL(put_itimerspec64);
 
+/**
+ * get_old_itimerspec32 - get user's &struct old_itimerspec32 into kernel space
+ * @its: destination &struct itimerspec64
+ * @uits: user's &struct old_itimerspec32
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int get_old_itimerspec32(struct itimerspec64 *its,
 			const struct old_itimerspec32 __user *uits)
 {
@@ -898,6 +1037,14 @@ int get_old_itimerspec32(struct itimersp
 }
 EXPORT_SYMBOL_GPL(get_old_itimerspec32);
 
+/**
+ * put_old_itimerspec32 - convert &struct itimerspec64 to &struct
+ *			  old_itimerspec32 and copy the latter to userspace
+ * @its: input &struct itimerspec64
+ * @uits: user's &struct old_itimerspec32
+ *
+ * Return: %0 on success or negative errno on error
+ */
 int put_old_itimerspec32(const struct itimerspec64 *its,
 			struct old_itimerspec32 __user *uits)
 {
