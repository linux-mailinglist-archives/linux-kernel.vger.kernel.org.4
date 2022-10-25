Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2388260CE19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiJYN7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJYN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1917EF36;
        Tue, 25 Oct 2022 06:59:23 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qg194zTnM1JYpSXcqxwvHVSZ+y39iQ+5387UWMyWJM0=;
        b=i74phoyzJ529cxBcKmjz7fM1pp+F2ytguqNCUXKngOtOhAl5ikabmbj0G2xsBlh+oMOx7d
        yZT1v59aOeghY/7nlmWWXhWmxf/CxeZwhAeAzIf7uMtePetZ0wvpUl2UQXIGluFq4PiMoa
        h/3WVY41ZuhxuacCiTr5dpASf/0BCLRW7xldXsJwqApek8jYwtqCoNhHUSYTbL1XK7fXyj
        V63XrkfcsCp/s5dwzrDUMwrAGi2uD1def+NDKWvDM/d/2OCme+2uW0JLBlwxHi0V7d+SL2
        GssFArUyQNGg3cWKl9NZu4xROF7UlTYGF9Bo43zwvgr0yXUsYCfEpyu4qlgXSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qg194zTnM1JYpSXcqxwvHVSZ+y39iQ+5387UWMyWJM0=;
        b=dms6+CSWDUlibiggCdS5Fp5rB/0PriZtqDiV/BUtimWZoMauPplPbqXMjtu3bHU8hadOy7
        vP4cY8PJNSmuXnDg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v3 02/17] tick-sched: Warn when next tick seems to be in the past
Date:   Tue, 25 Oct 2022 15:58:35 +0200
Message-Id: <20221025135850.51044-3-anna-maria@linutronix.de>
In-Reply-To: <20221025135850.51044-1-anna-maria@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

