Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ECD619AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiKDO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKDO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:57:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042A2EF24
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:55 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SYFJLwFPZaNWscBGLUeDFCSexiFqWz1WiWI/WoTB14=;
        b=HepTyuV7cID1C6WhAFE5nDOjWovpqnf2mAD+QoOGGtwSB2pzdpjQpFbtanayuzYfIxZBlj
        DpjP8aKCE+zvmVQ7CEQRmzL3mQfgMC8fOS+nNb7FCdGVHb3PgPEOKF7TAzFpYQtHWtZuKC
        FTHIXytnit5sNnDqSc7ulMD9nSDY/bOydhleEbiRAYfLgoM0T7II3MAsghJGPVlz18fK37
        r7UCrr6jiNtGfBAjzjgBrjdsuFKWlcNcD5/IiyyQ8TDuAJhUEsTmjDdjjjcxllUt829kyr
        +iVxsJiyAMhktP2JMtuqtNIcF0TZ4kKKobS4qg4SMfbSm5fzWRtdZufUlc3UoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SYFJLwFPZaNWscBGLUeDFCSexiFqWz1WiWI/WoTB14=;
        b=y36jNLIMEgsBqxw3naxkOK6Uo0wMHAOxboaACW0IAppPXCX8uFHWUmBI9B1Zl7G/MZG7aj
        FA/TKfCCFzaIsyCw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v4 02/16] timer: Move store of next event into __next_timer_interrupt()
Date:   Fri,  4 Nov 2022 15:57:23 +0100
Message-Id: <20221104145737.71236-3-anna-maria@linutronix.de>
In-Reply-To: <20221104145737.71236-1-anna-maria@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both call sides of __next_timer_interrupt() store return value directly in
base->next_expiry. Move the store into __next_timer_interrupt() and to make
purpose more clear, rename function to next_expiry_recalc().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4: rename function as suggested by Frederic Weisbecker
---
 kernel/time/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..2fd5de648d7c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1571,8 +1571,10 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
 /*
  * Search the first expiring timer in the various clock levels. Caller must
  * hold base->lock.
+ *
+ * Store next expiry time in base->next_expiry.
  */
-static unsigned long __next_timer_interrupt(struct timer_base *base)
+static void next_expiry_recalc(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
@@ -1638,10 +1640,11 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		clk += adj;
 	}
 
+	base->next_expiry = next;
 	base->next_expiry_recalc = false;
 	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 
-	return next;
+	return;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1701,7 +1704,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 	nextevt = base->next_expiry;
 
 	/*
@@ -1784,7 +1787,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
 		base->clk++;
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
-- 
2.30.2

