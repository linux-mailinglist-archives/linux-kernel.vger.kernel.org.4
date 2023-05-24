Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D870EEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbjEXHHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239796AbjEXHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E84B6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:00 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxmCND6qgUOL8dSwqTz+jvdhC0vJDN9Q/b7YApMcna0=;
        b=UqSy0m3N8Wqw9BX3M7onpKiverK90EhM6obouvh6WE77o1fYsssDtYGcukRNa2uQOs6y3v
        lMXPYkGzRUdutJjZY2p0zykh7P3Lef0opyP21vN9qbaEJFxGh/nWNZoVl2iepcrzjmOkuN
        eocA83ihRgF8Sp5hgQRSQKMMTe5PTJhxAvs3Bp3zh0ah9Ms9multYarnqFd2Y2yqu8jd2z
        zUurqJnHxKHW8o8KVVc505hfygDLPmOvcLrKpzUaCmIzCEYcUORyUR1nYviCLcJUCEVYF1
        F4SVLVmjFnNNPKj1crknpWxcSoUhOWOAH0RFfu1UE48J9jZgcU/INczn9zjH9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxmCND6qgUOL8dSwqTz+jvdhC0vJDN9Q/b7YApMcna0=;
        b=aXODCXcf92QefXn6aVZ7336BGvru5y8XgcoqyIDc1SfIGCvQxyXffdu+85D9MO1L2K4ODv
        I9FQh/rssYnDUfCA==
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
Subject: [PATCH v7 05/21] timer: Split next timer interrupt logic
Date:   Wed, 24 May 2023 09:06:13 +0200
Message-Id: <20230524070629.6377-6-anna-maria@linutronix.de>
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

Logic for getting next timer interrupt (no matter of recalculated or
already stored in base->next_expiry) is split into a separate function
"next_timer_interrupt()" to make it available for new call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 59f2e15733ab..1a61977f9efa 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1908,6 +1908,14 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	return base->next_expiry;
+}
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1934,9 +1942,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		return expires;
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
-	nextevt = base->next_expiry;
+
+	nextevt = next_timer_interrupt(base);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
-- 
2.30.2

