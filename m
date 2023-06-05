Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7F722A73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjFEPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjFEPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757CF1;
        Mon,  5 Jun 2023 08:08:31 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6w8b+H38nB35U6zyxY6nQhPl5ZOw2Hhn62YucR+QBU=;
        b=IqO7TKvNrN2T+F4MZu7H4XdvBACYaD6PyTYYcClr2MxkPFDHqhmbSfLkjkKMe3t3T3bRSE
        DLbG0ID8a4v3YCzbApSUg7upRnHMwx1HdxiaAIDOiU1aux/Gc6MwLGFnD1IrO7Lpn/q8m3
        rX6Gjg52bt3MN69cpeXLJhw/PIoJdLnRRrtxasqZDWBJlwolrT2N/1uOp5SxJxd2y5dlee
        0vOZIK+BNIfQ8jtg/TpGqiRGtnX/L3Q8xOI6+3iJBvGl4ZPGLv9BQBT6Qn8Pn8cvCWGkzh
        kPi7ZP/RSjuIXFcpt+YMS4I2KEBcBUlxfe+ZIEC2zfaqcj/7169XE620jNbTXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6w8b+H38nB35U6zyxY6nQhPl5ZOw2Hhn62YucR+QBU=;
        b=jsWaV6pLG6gMZNE1SeZm3/H3piue8qdy+iUqI8FdoLCBkdPoao00sdGq302lcr2TTXjssG
        sTrCKZOBEppxPFCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Document sys_clock_getres() correctly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.356427330@linutronix.de>
References: <20230425183313.356427330@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770919.404.14552512930116138988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4898e5d912108c8a865ffb3fc0230559b40ca361
Gitweb:        https://git.kernel.org/tip/4898e5d912108c8a865ffb3fc0230559b40ca361
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:37 +02:00

posix-timers: Document sys_clock_getres() correctly

The decades old comment about Posix clock resolution is confusing at best.

Remove it and add a proper explanation to sys_clock_getres().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.356427330@linutronix.de

---
 kernel/time/posix-timers.c | 81 +++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8153374..c9896ff 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -67,14 +67,6 @@ static const struct k_clock clock_realtime, clock_monotonic;
  *	    to implement others.  This structure defines the various
  *	    clocks.
  *
- * RESOLUTION: Clock resolution is used to round up timer and interval
- *	    times, NOT to report clock times, which are reported with as
- *	    much resolution as the system can muster.  In some cases this
- *	    resolution may depend on the underlying clock hardware and
- *	    may not be quantifiable until run time, and only then is the
- *	    necessary code is written.	The standard says we should say
- *	    something about this issue in the documentation...
- *
  * FUNCTIONS: The CLOCKs structure defines possible functions to
  *	    handle various clock functions.
  *
@@ -1198,6 +1190,79 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
 	return err;
 }
 
+/**
+ * sys_clock_getres - Get the resolution of a clock
+ * @which_clock:	The clock to get the resolution for
+ * @tp:			Pointer to a a user space timespec64 for storage
+ *
+ * POSIX defines:
+ *
+ * "The clock_getres() function shall return the resolution of any
+ * clock. Clock resolutions are implementation-defined and cannot be set by
+ * a process. If the argument res is not NULL, the resolution of the
+ * specified clock shall be stored in the location pointed to by res. If
+ * res is NULL, the clock resolution is not returned. If the time argument
+ * of clock_settime() is not a multiple of res, then the value is truncated
+ * to a multiple of res."
+ *
+ * Due to the various hardware constraints the real resolution can vary
+ * wildly and even change during runtime when the underlying devices are
+ * replaced. The kernel also can use hardware devices with different
+ * resolutions for reading the time and for arming timers.
+ *
+ * The kernel therefore deviates from the POSIX spec in various aspects:
+ *
+ * 1) The resolution returned to user space
+ *
+ *    For CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME, CLOCK_TAI,
+ *    CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALAREM and CLOCK_MONOTONIC_RAW
+ *    the kernel differentiates only two cases:
+ *
+ *    I)  Low resolution mode:
+ *
+ *	  When high resolution timers are disabled at compile or runtime
+ *	  the resolution returned is nanoseconds per tick, which represents
+ *	  the precision at which timers expire.
+ *
+ *    II) High resolution mode:
+ *
+ *	  When high resolution timers are enabled the resolution returned
+ *	  is always one nanosecond independent of the actual resolution of
+ *	  the underlying hardware devices.
+ *
+ *	  For CLOCK_*_ALARM the actual resolution depends on system
+ *	  state. When system is running the resolution is the same as the
+ *	  resolution of the other clocks. During suspend the actual
+ *	  resolution is the resolution of the underlying RTC device which
+ *	  might be way less precise than the clockevent device used during
+ *	  running state.
+ *
+ *   For CLOCK_REALTIME_COARSE and CLOCK_MONOTONIC_COARSE the resolution
+ *   returned is always nanoseconds per tick.
+ *
+ *   For CLOCK_PROCESS_CPUTIME and CLOCK_THREAD_CPUTIME the resolution
+ *   returned is always one nanosecond under the assumption that the
+ *   underlying scheduler clock has a better resolution than nanoseconds
+ *   per tick.
+ *
+ *   For dynamic POSIX clocks (PTP devices) the resolution returned is
+ *   always one nanosecond.
+ *
+ * 2) Affect on sys_clock_settime()
+ *
+ *    The kernel does not truncate the time which is handed in to
+ *    sys_clock_settime(). The kernel internal timekeeping is always using
+ *    nanoseconds precision independent of the clocksource device which is
+ *    used to read the time from. The resolution of that device only
+ *    affects the presicion of the time returned by sys_clock_gettime().
+ *
+ * Returns:
+ *	0		Success. @tp contains the resolution
+ *	-EINVAL		@which_clock is not a valid clock ID
+ *	-EFAULT		Copying the resolution to @tp faulted
+ *	-ENODEV		Dynamic POSIX clock is not backed by a device
+ *	-EOPNOTSUPP	Dynamic POSIX clock does not support getres()
+ */
 SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 		struct __kernel_timespec __user *, tp)
 {
