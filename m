Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6C70EEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbjEXHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbjEXHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41819C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:03 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69v6KAzJ3Kkk+I5jf4FnTJ5YhbczmyAfH/JLKYuJ49U=;
        b=WML/DefTybhtSenrVmJjckwFy5HhArUrPp5NzIJCOlVIS+tsDYpGGz6XtAL/Tjej+iS+eX
        rNbbfqXomGylr1TyXGNF9C7oSeCfGOkYaCL6sd1BAOaFGieZNgZw+gx3W72RrGrsEqcGLc
        j41YELXuAC9lwkibcnANeJAr2yPbqNP9bpeigvcmY9yC12BVpQNQFx7PrtdJqmvtPCaA9q
        yZUPwZjmnH+97vj8H5kp0G1Ce7qmOae3ftU+CRjdlMHVs2P6sddNhWkRxPuKSsTu5Dd7cM
        UGNTTHsaFHXiDV0x82Y1FRDIPj9ryBiaIHna/DBFGClomSc/MPfLR+bRKzgpFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69v6KAzJ3Kkk+I5jf4FnTJ5YhbczmyAfH/JLKYuJ49U=;
        b=c1N1GlFettzOJ4SoyCIpwPS+BzrT4zoXcaFKud66e1Fyr8PpCx/7gD+aeuKM8PYcvWUASH
        RMvesJu/2iq35MAA==
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
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v7 11/21] timers: Create helper function to forward timer base clk
Date:   Wed, 24 May 2023 09:06:19 +0200
Message-Id: <20230524070629.6377-12-anna-maria@linutronix.de>
In-Reply-To: <20230524070629.6377-1-anna-maria@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for forwarding timer base clock is split into a separate function
to make it accessible for other call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v6: s/splitted/split
v5: New patch to simplify next patch
---
 kernel/time/timer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 749b1570bdcd..fcff03757641 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1956,6 +1956,21 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
 	return base->next_expiry;
 }
 
+/*
+ * Forward base clock is done only when @basej is past base->clk, otherwise
+ * base-clk might be rewind.
+ */
+static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
+			     unsigned long basej)
+{
+	if (time_after(basej, base->clk)) {
+		if (time_after(nextevt, basej))
+			base->clk = basej;
+		else if (time_after(nextevt, base->clk))
+			base->clk = nextevt;
+	}
+}
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1987,15 +2002,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
-	 * base. We can only do that when @basej is past base->clk
-	 * otherwise we might rewind base->clk.
+	 * base.
 	 */
-	if (time_after(basej, base->clk)) {
-		if (time_after(nextevt, basej))
-			base->clk = basej;
-		else if (time_after(nextevt, base->clk))
-			base->clk = nextevt;
-	}
+	forward_base_clk(base, nextevt, basej);
 
 	/*
 	 * Base is idle if the next event is more than a tick away. Also
-- 
2.30.2

