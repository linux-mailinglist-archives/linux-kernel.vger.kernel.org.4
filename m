Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF170EEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbjEXHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbjEXHHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717597
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:01 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT6/GGqloCM8AGirZHb7HkPsMCoi/5vNo/Me8IGb/1s=;
        b=eDOksZ3MxO3qy4i6Bs04pCvfZX2q4ptoyUl8Gz9gFNZZ62vh9WtXJ8X/Gwz3WGaoJI1T0+
        HxRoMNjSX9N28K3ON3+VFKnTlTVLQHXOyo0WCYhiqAwhFYDt07vDucYIUREQ6R5/L9eaZD
        hJrojJXN0AiogwBML0Z6TJMUZLfblqsmGlGSt7JxsIT8DTS4BB00hEVHniXIDTUWtZB2SQ
        0PHEJlfhLLOd7D5QHqrRrK5Q/xs+piZGI6AK4rQkFzTcH0Al1IU35AQHSZsCZrApPVfPNp
        ZIX1EJrj/BRqoTiD1Ycru7o0IyAyGkrIjwdTfDSlEtP1rQjiaCAyT6Xl3StEpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT6/GGqloCM8AGirZHb7HkPsMCoi/5vNo/Me8IGb/1s=;
        b=rpUktC55F0DExnhjdnVJx9htvbxzw/S5B8SGXzwmH03itM5CtNS4u5pdK8Skp2dwzk6wOa
        c91OzWG/HZ3IZlDQ==
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
Subject: [PATCH v7 09/21] timer: add_timer_on(): Make sure TIMER_PINNED flag is set
Date:   Wed, 24 May 2023 09:06:17 +0200
Message-Id: <20230524070629.6377-10-anna-maria@linutronix.de>
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

