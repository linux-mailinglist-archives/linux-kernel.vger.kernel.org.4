Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E684A6EE7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjDYStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjDYStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7554617A2D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:13 -0700 (PDT)
Message-ID: <20230425183313.356427330@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1Xn/v0a0tIvMqOVlnVw+J+mD2M0Fh0VwHZA2QXNtc10=;
        b=Ipw+A1ZPKhuzFMXkdR00YXoHKH0mbjlYJHCHO4CumRcL4l6uBeP0jd8QWbXW37AcOt8BXV
        FuQem7OiaOUrAa+YZzcFqlgnrlbidtj3817/Nzr6sVQBwDcTr7iV6V4ZLj7sz9ISh7zJZi
        ov+05vndaVUANu3Ob1uhsMcTZcW2akqF8ubyjpSsa4C7BFxJM+nSlSMklwVdp2hPEJ7mc4
        WFNlFAUCoQmn3noKfIXfzzLJy9CgnzXn/gkRY/vDfXIknUfsDI57mfDRxwv/FENaEDoaI4
        xiZA6gOJuZSSrX+rjr97I0n7hjKwTxo8FNXoD1I6hLXYJDHDRmeDISrgJuTS7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1Xn/v0a0tIvMqOVlnVw+J+mD2M0Fh0VwHZA2QXNtc10=;
        b=lCXWxrPGHJQfT0LfecpBoJZUukXSftDdkkBGJfaEsSwbkrwR2ODRvkXmZZDLVf9o3PPvZY
        WYUP3+89N9pAo/Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [patch 10/20] posix-timers: Document sys_clock_getres() correctly
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decades old comment about Posix clock resolution is confusing at best.

Remove it and add a proper explanation to sys_clock_getres().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 kernel/time/posix-timers.c |   81 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -67,14 +67,6 @@ static const struct k_clock clock_realti
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
@@ -1204,6 +1196,79 @@ SYSCALL_DEFINE2(clock_adjtime, const clo
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

