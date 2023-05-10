Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5236FDE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjEJNXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjEJNXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:23:41 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257961B7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:23:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:cc75:d8ef:4074:8af9])
        by andre.telenet-ops.be with bizsmtp
        id v1PG2900T3l7qvk011PGsd; Wed, 10 May 2023 15:23:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwjme-001nDl-DW;
        Wed, 10 May 2023 15:23:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwjmm-00F6qN-4j;
        Wed, 10 May 2023 15:23:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
Date:   Wed, 10 May 2023 15:23:14 +0200
Message-Id: <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1683722688.git.geert+renesas@glider.be>
References: <cover.1683722688.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_poll_timeout_atomic() uses ktime_get() to implement the timeout
feature, just like its non-atomic counterpart.  However, there are
several issues with this, due to its use in atomic contexts:

  1. When called in the s2ram path (as typically done by clock or PM
     domain drivers), timekeeping may be suspended, triggering the
     WARN_ON(timekeeping_suspended) in ktime_get():

	WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_get+0x28/0x78

     Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
     rid of that warning.  However, that would break timeout handling,
     as (at least on systems with an ARM architectured timer), the time
     returned by ktime_get_mono_fast_ns() does not advance while
     timekeeping is suspended.
     Interestingly, (on the same ARM systems) the time returned by
     ktime_get() does advance while timekeeping is suspended, despite
     the warning.

  2. Depending on the actual clock source, and especially before a
     high-resolution clocksource (e.g. the ARM architectured timer)
     becomes available, time may not advance in atomic contexts, thus
     breaking timeout handling.

Fix this by abandoning the idea that one can rely on timekeeping to
implement timeout handling in all atomic contexts, and switch from a
global time-based to a locally-estimated timeout handling.  In most
(all?) cases the timeout condition is exceptional and an error
condition, hence any additional delays due to underestimating wall clock
time are irrelevant.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Alternatively, one could use a mixed approach (use both
ktime_get_mono_fast_ns() and a local (under)estimate, and timeout on the
earliest occasion), but I think that would complicate things without
much gain.

v2:
  - New.
---
 include/linux/iopoll.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 0417360a6db9b0d6..bb2e1d9117e96679 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -81,22 +81,30 @@
 					delay_before_read, args...) \
 ({ \
 	u64 __timeout_us = (timeout_us); \
+	s64 __left_ns = __timeout_us * NSEC_PER_USEC; \
 	unsigned long __delay_us = (delay_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	if (delay_before_read && __delay_us) \
+	u64 __delay_ns = __delay_us * NSEC_PER_USEC; \
+	if (delay_before_read && __delay_us) { \
 		udelay(__delay_us); \
+		if (__timeout_us) \
+			__left_ns -= __delay_ns; \
+	} \
 	for (;;) { \
 		(val) = op(args); \
 		if (cond) \
 			break; \
-		if (__timeout_us && \
-		    ktime_compare(ktime_get(), __timeout) > 0) { \
+		if (__timeout_us && __left_ns < 0) { \
 			(val) = op(args); \
 			break; \
 		} \
-		if (__delay_us) \
+		if (__delay_us) { \
 			udelay(__delay_us); \
+			if (__timeout_us) \
+				__left_ns -= __delay_ns; \
+		} \
 		cpu_relax(); \
+		if (__timeout_us) \
+			__left_ns--; \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.34.1

