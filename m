Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60256FD826
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjEJH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbjEJH2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:28:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75277ABB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:28:38 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmrO3nNzYfXwzb1RvZTjX+af+BCpvVn7WiRHJl4Z/10=;
        b=mvB7jTUKw6TbLLm/JjP67bf9H1aDe/htU4cLAtTBDVcV8AyNpJnF8naF5oeCUujE1QYyAW
        2CB9qg4CK0AZ01fPu3hJLVyZ5v/oKFRl0PDvwk/ymODIMB9y7QxY45dJZ57BVds+u91Rxf
        BVovJhT7F3uNszu5Qg9IKvLYEx0gz2Va9NTZGKNNMjeANIBfFphB0krM+RzFn0srjgZsyK
        GxoMtEuvvP1sqdgd25lWWPLbJS9RQVxwd9go+mf5bzBVlOkkOnN15Y/qSio1zbJ/1AjXv5
        FaHRuscukbg7VCrhvNC6OdVtOwaFVW8MzuuS6/V3E41lGkO2n/z09QQCWFIqvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmrO3nNzYfXwzb1RvZTjX+af+BCpvVn7WiRHJl4Z/10=;
        b=GeXvSHgEdrNVDfMalhmVSusi6PEvIuF42l/5bOphUg+Arq6I5oadIIE7EXPBkYOe78lQJR
        Fc6ASt1z3n4mAEAw==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v6 02/21] timer: Do not IPI for deferrable timers
Date:   Wed, 10 May 2023 09:27:58 +0200
Message-Id: <20230510072817.116056-3-anna-maria@linutronix.de>
In-Reply-To: <20230510072817.116056-1-anna-maria@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferrable timers do not prevent CPU from going idle and are not taken into
account on idle path. Sending an IPI to a remote CPU when a new first
deferrable timer was enqueued will wake up the remote CPU and but nothing
will be done regarding the deferrable timers.

Drop IPI completely when a new first deferrable timer was enqueued.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v6: new patch
---
 kernel/time/timer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..6e251e3cf659 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -571,18 +571,15 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk,
 static void
 trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
-	if (!is_timers_nohz_active())
-		return;
-
 	/*
-	 * TODO: This wants some optimizing similar to the code below, but we
-	 * will do that when we switch from push to pull for deferrable timers.
+	 * Deferrable timers do not prevent CPU from going idle and are not
+	 * taken into account on idle path. An IPI when a new deferrable
+	 * timer is enqueued will wake up the remote CPU but nothing will
+	 * be done with the deferrable timer base. Therefore skip remote
+	 * IPI for deferrable timers completely.
 	 */
-	if (timer->flags & TIMER_DEFERRABLE) {
-		if (tick_nohz_full_cpu(base->cpu))
-			wake_up_nohz_cpu(base->cpu);
+	if (!is_timers_nohz_active() || timer->flags & TIMER_DEFERRABLE)
 		return;
-	}
 
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
-- 
2.30.2

