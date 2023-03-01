Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2B6A6E36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCAOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCAOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2732FCC3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:07 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTQzvJTD2qoYsldLldPQ4blVqjcabsGVyHc0OvLoC/I=;
        b=SmV1bpGLnAae9OlLTD1SsP39Ud6P4rQIb994A1U9VKBb/SJZl6xNzz1ZYJzP5wRqB3IT9Z
        35oxpmI1i+UnVHUhbtz89fgJJASZ9e11ITJJcn9IKFO4+ePY5Fd7fQ/Q4Ksw2vXeYD7ZMJ
        C+8R7Le8DvWN4n7o6ZJmMbnomaYq+0XUjXwTHt7umvwdQrZ+x9kDq4qc7fArljDpEmkPsU
        iXgSD9upMvchB1VTV//NTrwRNrWxjDxqJLDRJq2IxRbaI1a3Nk/G7ugV3gmeYWqIV9xkN/
        S1Djvqv53WKQGJwBjlNyDTNfSpsxWXf7dhMyiIfc2WE39VTfXW4dhZPfb3NHYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTQzvJTD2qoYsldLldPQ4blVqjcabsGVyHc0OvLoC/I=;
        b=Zyfi9TyrvM+Yp7g0q5mAPA+mQMbBrNyodh5McLxyN6tsfNnYQCU1aSEhKwu3kzMjUejJi2
        Njzexu+OoLjhKFBw==
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
Subject: [PATCH v5 08/18] timers: Create helper function to forward timer base clk
Date:   Wed,  1 Mar 2023 15:17:34 +0100
Message-Id: <20230301141744.16063-9-anna-maria@linutronix.de>
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

The logic for forwarding timer base clock is splitted into a separte
function to make it accessible for other call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v5: New patch to simplify next patch
---
 kernel/time/timer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d3e1776b505b..1629ccf24dd0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1921,6 +1921,21 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
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
@@ -1952,15 +1967,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
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

