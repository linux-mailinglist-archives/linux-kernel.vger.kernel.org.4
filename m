Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04606A6E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCAOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCAOSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A02A6F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:05 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmOQM9bwoCoHle0ulyYXU2rtf5ilIqCMlhZV0ILFNe8=;
        b=Gel4Q84I4QAfdW72PCqmjGOQRsi7WJeEFby+cMdun2iQn7RO4ldqyf343ts5pEDP2DOsYB
        Ilu8sRRYfFX2tkNQsReEpd7By1ZHfZfODrLeAWW/2Eoc04LnVmWNWgEKfi3+69CJ+2SQ08
        MiUm290aeVF++k7Ma6nMtUgc+zfOqiiHFpTDOWAwjSRgMZR9aKowwbPVzOZtuP4MkY8//T
        BLhSoZaTozxF9MIgy2p223DqdGLXKmSCTfNz/V1rF52HfnOtBDPtrqyAC7bH0j9WxlAaca
        VEQF7pbb5sBc4kc6MHOMTt8ZpJo24x9ejlfCFi99C3tBnycRa1aas0GQOK5kCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmOQM9bwoCoHle0ulyYXU2rtf5ilIqCMlhZV0ILFNe8=;
        b=w9ilXrrOvxoN9BykI8dgrEiuqQtwQBSHRfGcZDg4tqdiN4MvkRJpS8KGuveiX2wjRnoSAw
        GnDfWAX7SSfs2WAg==
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
Subject: [PATCH v5 03/18] timer: Move store of next event into __next_timer_interrupt()
Date:   Wed,  1 Mar 2023 15:17:29 +0100
Message-Id: <20230301141744.16063-4-anna-maria@linutronix.de>
In-Reply-To: <20230301141744.16063-1-anna-maria@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
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
 kernel/time/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ffb94bc3852f..08e855727ff8 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1803,8 +1803,10 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
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
@@ -1870,10 +1872,11 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		clk += adj;
 	}
 
+	base->next_expiry = next;
 	base->next_expiry_recalc = false;
 	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 
-	return next;
+	return;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1937,7 +1940,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 	nextevt = base->next_expiry;
 
 	/*
@@ -2020,7 +2023,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
 		base->clk++;
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
-- 
2.30.2

