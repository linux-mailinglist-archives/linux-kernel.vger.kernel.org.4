Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E272465E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjFFOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjFFOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6F10E0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:41 -0700 (PDT)
Message-ID: <20230606142031.761271959@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ob/W6MhzxScgyFPIMc+gvNg8o5xjqBQZWBN/IorB7bE=;
        b=SCvoCkSp2EBNPlg9q940g+JrZP6pzFOgz7FFTWpU46jD5cHmKxKnhMZjnbZ9xoPZCpn3ae
        FVI578SMgJamC3rLpuuE0d9oufWTkLhmu/h29m2mbczYj9XIo0jczpnqU4XebflDkC2Fdl
        xI7TfXR/VSOru+FfjXi95UcYj6t8ucuEJeBkHeGzzET9MmOCCDx9JdYA7BDNvIE1ufK3gL
        hZU043m7L2kxkfuozb1a5r3cYXeS0+IorFh837i9kxsGH85T+cx/k6J/lQxkF5kkaE8McZ
        T36BXvfzeE6X7FZpYYioGrJE1f7S/Ffhxf5c98hWVriw05GhCegVxf2GeNks9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ob/W6MhzxScgyFPIMc+gvNg8o5xjqBQZWBN/IorB7bE=;
        b=nQFBQ5ePLWCt0uAyyP09UUBBGlfIp/c+ObKLOPQeUWXRW/gOnELQ77dt6uEmoAQmjmauIu
        NfATje6SDz2RZGDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 13/45] posix-cpu-timers: Replace old expiry retrieval in
 posix_cpu_timer_set()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:39 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the split out __posix_cpu_timer_get() function which does already the
right thing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -609,6 +609,8 @@ static void cpu_timer_fire(struct k_itim
 	}
 }
 
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now);
+
 /*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
@@ -680,29 +682,9 @@ static int posix_cpu_timer_set(struct k_
 	else
 		now = cpu_clock_sample_group(clkid, p, !sigev_none);
 
-	if (old) {
-		if (old_expires == 0) {
-			old->it_value.tv_sec = 0;
-			old->it_value.tv_nsec = 0;
-		} else {
-			/*
-			 * Update the timer in case it has overrun already.
-			 * If it has, we'll report it as having overrun and
-			 * with the next reloaded timer already ticking,
-			 * though we are swallowing that pending
-			 * notification here to install the new setting.
-			 */
-			u64 exp = bump_cpu_timer(timer, now);
-
-			if (now < exp) {
-				old_expires = exp - now;
-				old->it_value = ns_to_timespec64(old_expires);
-			} else {
-				old->it_value.tv_nsec = 1;
-				old->it_value.tv_sec = 0;
-			}
-		}
-	}
+	/* Retrieve the previous expiry value if requested. */
+	if (old && old_expires)
+		__posix_cpu_timer_get(timer, old, now);
 
 	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {

