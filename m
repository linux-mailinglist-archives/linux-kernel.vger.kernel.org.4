Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F660CE26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiJYN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJYN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C13BB;
        Tue, 25 Oct 2022 06:59:24 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9KrkHTSRk9elfiy6IejGCtNRlCE++/FB5CiuBByAlk=;
        b=Tf/9SYQHSN3IMkZcm9kCZ3W33EouF/PiE/b3UwATQokC0EG5MUmZFfaAaIw39OPEAGAF5q
        iQr76ZtsG8TfY63OCJJ3O9/tzgpnPH07vtmiA6dFcZC+Zyz2G9+V6BNpVSUU13v2T/+fxv
        9nM/6qUrpyyQz2Ig9L0SRTlljVnV2GkKK8t+BTNSU/awtJpdbuAC+MIpV7a/G25MbhV/QP
        IU0hjTK/jGQbmg3rOHBUHtaK6HRgecu0ArBIpH/i01KKv4LXgf1/cyqxu2a4UyXAdPVykw
        1ZhmDzeWXqPKo1EArrzyXdnWCBaaBnFQ/8TC5YsmdQYrIIqVEq/L4DeGGba4pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9KrkHTSRk9elfiy6IejGCtNRlCE++/FB5CiuBByAlk=;
        b=OOxPYlfB3OREmJmPIE3ZC4Fnc8ctFR4lOH9DY2WH8sgffZSKb7Qg8OSTwLzHciSDREJlBN
        tiS+6dl2kh8Hd1Bg==
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
Subject: [PATCH v3 04/17] timer: Split next timer interrupt logic
Date:   Tue, 25 Oct 2022 15:58:37 +0200
Message-Id: <20221025135850.51044-5-anna-maria@linutronix.de>
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

Logic for getting next timer interrupt (no matter of recalculated or
already stored in base->next_expiry) is split into a separate function
"next_timer_interrupt()" to make it available for new call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7695c733dfa5..f34bc75ff848 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1681,6 +1681,15 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+
+static unsigned long next_timer_interrupt(struct timer_base *base)
+{
+	if (base->next_expiry_recalc)
+		__next_timer_interrupt(base);
+
+	return base->next_expiry;
+}
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1703,9 +1712,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		return expires;
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		__next_timer_interrupt(base);
-	nextevt = base->next_expiry;
+
+	nextevt = next_timer_interrupt(base);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
-- 
2.30.2

