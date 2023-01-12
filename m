Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E1667855
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbjALO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbjALO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:58:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3421A631A0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:44:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v30so27114815edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PS+94AhsHF4SxeSpIBy4eHLkesUY6soqDZJHYUTxL3A=;
        b=UBGXdTJSUaVfMSAqn+HmlJ31eCe5vqgvz6N+UKxfLvVg+wC0jYDCrbkIZ3vgDidgEF
         rT2kBBkOM79BRdMnlyPtEb7cqb4qmk1INuH38AC5G6lH0YfYvgEOC/xeLVJRXUe3HQUz
         xWuMNAfSYd1vBennGumSFahxxrGgcT2gchWoYqAdc4Nns1ZsB57SRBeltGwfsc5fZb86
         DnRdM96MFSkOhvdjRwKqMNQxjkpoNZD4d8EY80mfqJ1T8zXkRCOr4jMD/51frI6vO8Th
         wgMkfmk/dU4IoPVYKRJdooXEOslHTZqce28jdkDWQs0xOIPe18JLgmhkR17xM7bx7khU
         WICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS+94AhsHF4SxeSpIBy4eHLkesUY6soqDZJHYUTxL3A=;
        b=hd8/SuXO5RKTICnkgmQsMZNCiwoZhkAVRWGdLGYrKks1vj1dkXiN8nNTHLdRSH/ZQW
         Ze4emjTPEiAeWW5woziiKmglxq5moMt9s6W3nXwt823sd0xaxehI2vnIB1kCp/uBLvoQ
         zT/8A3qpbdU9FruKtLXjASlitueB1BjzMvBOmmo9V0eErEMCqDJA9s4QHnalGzFRAeCb
         ZHMN0Md8vEKHqs9bv9J2ISCS7bFLrAoROHP14OMSeeEzTsKIt30hRZkC7XQ5JdjFW/W5
         /uFC/0YDwuBZlXN9wfMuffWgMc7BjMKChqQGOpCL5mSzpKUQuFQ/ILvZ87IdEc8Khoc4
         O4gg==
X-Gm-Message-State: AFqh2kqGSH9/jchZmF76tvnlp9m18LEVZISzQ8tVfW4djPIfqgK9U6rI
        PBuDUlebbTvrMSLkQA+6XE0=
X-Google-Smtp-Source: AMrXdXsAVpsbC8kapFV2tYELtxpA2szkvOka0Eczlkjr8R3hNSquFs80xbd0C3PUAjziQzjxBs2TdQ==
X-Received: by 2002:a05:6402:3784:b0:46b:eadf:8d34 with SMTP id et4-20020a056402378400b0046beadf8d34mr63624262edb.7.1673534651337;
        Thu, 12 Jan 2023 06:44:11 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id ti11-20020a170907c20b00b007c10bb5b4b8sm7432416ejc.224.2023.01.12.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:44:10 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Jan 2023 15:44:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fixes
Message-ID: <Y8AcuX1o8aOSp7oj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-01-12

   # HEAD: f3cb80804b8295323919e031281768ba3bf5f8da time: Fix various kernel-doc problems

- Fix various DocBook formatting errors in kernel/time/ that
  generated (justified) warnings during a kernel-doc build.

 Thanks,

	Ingo

------------------>
Randy Dunlap (1):
      time: Fix various kernel-doc problems


 kernel/time/tick-oneshot.c | 4 ++--
 kernel/time/time.c         | 8 ++++----
 kernel/time/timekeeping.c  | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 475ecceda768..5e2c2c26b3cc 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -18,7 +18,7 @@
 #include "tick-internal.h"
 
 /**
- * tick_program_event
+ * tick_program_event - program the CPU local timer device for the next event
  */
 int tick_program_event(ktime_t expires, int force)
 {
@@ -99,7 +99,7 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 }
 
 /**
- * tick_check_oneshot_mode - check whether the system is in oneshot mode
+ * tick_oneshot_mode_active - check whether the system is in oneshot mode
  *
  * returns 1 when either nohz or highres are enabled. otherwise 0.
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 526257b3727c..f4198af60fee 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -462,7 +462,7 @@ struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec)
 EXPORT_SYMBOL(ns_to_kernel_old_timeval);
 
 /**
- * set_normalized_timespec - set timespec sec and nsec parts and normalize
+ * set_normalized_timespec64 - set timespec sec and nsec parts and normalize
  *
  * @ts:		pointer to timespec variable to be set
  * @sec:	seconds to set
@@ -526,7 +526,7 @@ struct timespec64 ns_to_timespec64(s64 nsec)
 EXPORT_SYMBOL(ns_to_timespec64);
 
 /**
- * msecs_to_jiffies: - convert milliseconds to jiffies
+ * __msecs_to_jiffies: - convert milliseconds to jiffies
  * @m:	time in milliseconds
  *
  * conversion is done as follows:
@@ -541,12 +541,12 @@ EXPORT_SYMBOL(ns_to_timespec64);
  *   handling any 32-bit overflows.
  *   for the details see __msecs_to_jiffies()
  *
- * msecs_to_jiffies() checks for the passed in value being a constant
+ * __msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
  * code, __msecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at
  * runtime.
- * the _msecs_to_jiffies helpers are the HZ dependent conversion
+ * The _msecs_to_jiffies helpers are the HZ dependent conversion
  * routines found in include/linux/jiffies.h
  */
 unsigned long __msecs_to_jiffies(const unsigned int m)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f72b9f1de178..5579ead449f2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1590,10 +1590,10 @@ void __weak read_persistent_clock64(struct timespec64 *ts)
 /**
  * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
  *                                        from the boot.
+ * @wall_time:	  current time as returned by persistent clock
+ * @boot_offset:  offset that is defined as wall_time - boot_time
  *
  * Weak dummy function for arches that do not yet support it.
- * @wall_time:	- current time as returned by persistent clock
- * @boot_offset: - offset that is defined as wall_time - boot_time
  *
  * The default function calculates offset based on the current value of
  * local_clock(). This way architectures that support sched_clock() but don't
@@ -1701,7 +1701,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
-/**
+/*
  * We have three kinds of time sources to use for sleep time
  * injection, the preference order is:
  * 1) non-stop clocksource
@@ -1722,7 +1722,7 @@ bool timekeeping_rtc_skipresume(void)
 	return !suspend_timing_needed;
 }
 
-/**
+/*
  * 1) can be determined whether to use or not only when doing
  * timekeeping_resume() which is invoked after rtc_suspend(),
  * so we can't skip rtc_suspend() surely if system has 1).
