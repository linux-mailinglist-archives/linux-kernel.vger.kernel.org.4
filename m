Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22F6A6E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCAOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCAOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DBE241E9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:04 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOCDJ0nGoVQscn5FVoqed4VCDME+xrNe/Iu7/rdK+w0=;
        b=vVYQJSb9yVianAUa97TQoewFr+qTYrLwvmDerfNVM54QBpb6Asw+XvHxhSxUyuG8zUS4/8
        2ILd7xEeSICxqzuQAROg2Pd+xnjftEkTW4yjSBmrHwQVUYhMVdIISb/rxGn9kmN9OsSvE3
        t93Hklqifm0acmfPUhdOiheIyDSNxfWS1pbfDkC9EtHzk5SmwfTFv3eGk88siM1YhA1zEp
        1cRCrf6fYJbmj9JrMog1nRWsZYga0avUVdi2KUD6ulMUe5eh3IOfjb9kY3jWTWPRDLml9C
        ExGMz8hthVqwPS3LA5h5r7l8pnn2SzEtgOeL+iSxJIXg7bjKL1zvEZR2F5oFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOCDJ0nGoVQscn5FVoqed4VCDME+xrNe/Iu7/rdK+w0=;
        b=z4koYsck+hd+4bABjdVaOyloe9V3/a0wwqXl5oOBDAzih9YRhwXlbBqREIzjgDc6HjydLP
        Qx+i7ASmmkRCAZCA==
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
Subject: [PATCH v5 01/18] tick-sched: Warn when next tick seems to be in the past
Date:   Wed,  1 Mar 2023 15:17:27 +0100
Message-Id: <20230301141744.16063-2-anna-maria@linutronix.de>
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

When the next tick is in the past, the delta between basemono and the next
tick gets negativ. But the next tick should never be in the past. The
negative effect of a wrong next tick might be a stop of the tick and timers
might expire late.

To prevent expensive debugging when changing underlying code, add a
WARN_ON_ONCE into this code path.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..7ffdc7ba19b4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -826,6 +826,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * If the tick is due in the next period, keep it ticking or
 	 * force prod the timer.
 	 */
+	WARN_ON_ONCE(basemono > next_tick);
+
 	delta = next_tick - basemono;
 	if (delta <= (u64)TICK_NSEC) {
 		/*
-- 
2.30.2

