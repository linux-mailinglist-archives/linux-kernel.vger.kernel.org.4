Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C026FD82F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjEJH3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjEJH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:29:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B57D8C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:28:56 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT6/GGqloCM8AGirZHb7HkPsMCoi/5vNo/Me8IGb/1s=;
        b=2Mqiuo92z48phqeRXqWoUMsZPEFrzIhRVT+J1YshgWz2+4P5b0LOYTvyGZNPUacrQPW48v
        Z7kIMwxy5G2iejQIhaNULoIdStlvO7o6vUpR93xf70jDDcfA+wrTJUua0n+Rn9v4Rq2sE/
        pyw7HGciP4RjJowBhZob4+L3wNVRygHGARQV6i4FKn82r/W+mANXqfck9Gp6tGIkCm6zfY
        zYrx15iXJ2PRmdN2uZ3WlZmi3YV0AD9oGDQKDN8HN39PfysngFvs3EAj48ntPDTt0l4JsT
        qxAQ2/xArJL5MNJyTUXUkHAk4xtb0Mfv6dQU9pvMSFWgxlcF7yP7E9xbezfzPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT6/GGqloCM8AGirZHb7HkPsMCoi/5vNo/Me8IGb/1s=;
        b=oTESrKHaMqa70qHNvL8JepL8nZJkSya/Ea+0tjziXKVDAwcT7cKPQBsgFKvRQlfPqEk502
        7tq0z6BFiVGrC5BQ==
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
Subject: [PATCH v6 09/21] timer: add_timer_on(): Make sure TIMER_PINNED flag is set
Date:   Wed, 10 May 2023 09:28:05 +0200
Message-Id: <20230510072817.116056-10-anna-maria@linutronix.de>
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

When adding a timer to the timer wheel using add_timer_on(), it is an
implicitly pinned timer. With the timer pull at expiry time model in place,
TIMER_PINNED flag is required to make sure timers end up in proper base.

Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ab9a8bb11a8a..b7599216d183 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1281,7 +1281,10 @@ EXPORT_SYMBOL(add_timer_global);
  * @timer:	The timer to be started
  * @cpu:	The CPU to start it on
  *
- * Same as add_timer() except that it starts the timer on the given CPU.
+ * Same as add_timer() except that it starts the timer on the given CPU and
+ * the TIMER_PINNED flag is set. When timer shouldn't be a pinned timer in
+ * the next round, add_timer_global() should be used instead as it unsets
+ * the TIMER_PINNED flag.
  *
  * See add_timer() for further details.
  */
@@ -1295,6 +1298,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
+	/* Make sure timer flags have TIMER_PINNED flag set */
+	timer->flags |= TIMER_PINNED;
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*
-- 
2.30.2

