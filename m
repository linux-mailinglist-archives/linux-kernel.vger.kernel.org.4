Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8A60CE31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiJYOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7B93BB;
        Tue, 25 Oct 2022 06:59:28 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjVAw8MhbYxCC7wINXEcQMmNl7FSEGbHT8j9jxIsmGY=;
        b=mcYLXutmXzSR9ZuMfSpPMy8mQSASFUo61PQ7SHQrKWDUi8VnIlN2rlivC+NIYxUL+jWhXo
        XukDXg7bgvlqbKnay6xYfaddDvjB4JzoR/3at5ZyWY6B4aY9vzMijr17r1FPG2M/OxmEw7
        P5jo7g0efgIjCM9NQhOJOak/NtBguBLHDt/WfOXVVHpOG8cRa+GPW+HIfQ8BDobKRsj4U+
        jLlgMSxzHk+oh2E29A/B26h8puv9BNJP3ky9uFDl9CpHkcqUJZaZPAmbD1Qux2dh2Bq5ya
        l/f0ifnZi1PXLK5lEq/OBOtQmqjfd7z3NH6HtT/s0Xjl7RJejjmCnHkNrOpFkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjVAw8MhbYxCC7wINXEcQMmNl7FSEGbHT8j9jxIsmGY=;
        b=HlRzm2pHphXnjc98iqPYLFBQ1DfuNTeMTrE2jFII10yIqd6mRgG+TLp3EnVl/OalcwMbou
        CI+wEHaGio7wslCA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v3 12/17] timer: Check if timers base is handled already
Date:   Tue, 25 Oct 2022 15:58:45 +0200
Message-Id: <20221025135850.51044-13-anna-maria@linutronix.de>
In-Reply-To: <20221025135850.51044-1-anna-maria@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the conversion of the NOHZ timer placement to a pull at expiry
time model, the per CPU timer bases with non pinned timers are no
longer handled only by the local CPU. In case a remote CPU already
expires the non pinned timers base of the local cpu, nothing more
needs to be done by the local CPU. A check at the begin of the expire
timers routine is required, because timer base lock is dropped before
executing the timer callback function.

This is a preparatory work, but has no functional impact right now.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index bce2f87d5e70..0790ec8efe82 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1913,6 +1913,9 @@ static inline void __run_timers(struct timer_base *base)
 
 	lockdep_assert_held(&base->lock);
 
+	if (!!base->running_timer)
+		return;
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
-- 
2.30.2

