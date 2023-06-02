Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE73171FC9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjFBIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjFBIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:51:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482F1722
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:51:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by xavier.telenet-ops.be with bizsmtp
        id 48qo2A0041tRZS8018qoDF; Fri, 02 Jun 2023 10:51:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50UO-00BhYB-SP;
        Fri, 02 Jun 2023 10:50:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50Uh-00APxV-Vr;
        Fri, 02 Jun 2023 10:50:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/7] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
Date:   Fri,  2 Jun 2023 10:50:37 +0200
Message-Id: <3d2a2f4e553489392d871108797c3be08f88300b.1685692810.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685692810.git.geert+renesas@glider.be>
References: <cover.1685692810.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
The first issue was seen with the rcar-sysc driver in the BSP, as the
BSP contains modifications to the resume sequence of various PM Domains.

v3:
  - Add Acked-by, Reviewed-by,
  - Add comment about not using timekeeping, and its impact,

v2:
  - New.
---
 include/linux/iopoll.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 0417360a6db9b0d6..19a7b00baff43595 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -74,6 +74,10 @@
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val.
  *
+ * This macro does not rely on timekeeping.  Hence it is safe to call even when
+ * timekeeping is suspended, at the expense of an underestimation of wall clock
+ * time, which is rather minimal with a non-zero delay_us.
+ *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
  */
@@ -81,22 +85,30 @@
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

