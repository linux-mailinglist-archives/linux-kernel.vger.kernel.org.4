Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E0619AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiKDO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiKDO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:57:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76DA2EF67
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:55 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfKpQBhTGidhSKvCEygfZZ4AX4EB6wM0N8LXrGnUD24=;
        b=Li15vs6HYf2iWUIGpE4I1OaOJmwT7R+ogU+5n+djOv+2u2zdPW7B4EQp6vAiS9RuJOlFId
        enH2ahXusKWnGN+ALobtamjmrupAMOAXNBXnXu1CCxGlzPKMFvh7/+It5kKUnLPh6aSTTE
        Yzu+y9b7+n74NxalFS69SPWHKNaM2UOVzOxu0irdhf7EDkw5YfHQ/U3O4/QmBXzUghf0t4
        wcq+r9MBiobk9xeDuxt/QzBrCxR6DkuVrW4uET+VO1ffPunu8QrkIvV5SXzmQrW4z7yO2u
        DqtONqF9xIhaTzOodPOx2f1VxME4m8tTvzsX36KicLE5b0T86UdFKXy/Jh4MHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfKpQBhTGidhSKvCEygfZZ4AX4EB6wM0N8LXrGnUD24=;
        b=/ldAXVLBpjPFC9LLcqYeRHoQ5QvVVt44qSu/1rWNPnSiE+Cp1FRl8h2wIXyzbaE1eR9iWy
        wE8xaPJVKR6jhuAg==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v4 03/16] timer: Split next timer interrupt logic
Date:   Fri,  4 Nov 2022 15:57:24 +0100
Message-Id: <20221104145737.71236-4-anna-maria@linutronix.de>
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

Logic for getting next timer interrupt (no matter of recalculated or
already stored in base->next_expiry) is split into a separate function
"next_timer_interrupt()" to make it available for new call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2fd5de648d7c..4547d2efcb86 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1681,6 +1681,15 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+
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
@@ -1703,9 +1712,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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

