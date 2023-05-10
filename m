Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4E6FD82D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjEJH3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjEJH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:29:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0439F76B7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:28:52 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9e5Gmxnr1gXDBGeNuKaFQxHbcIQ5VBb6TocWugW/4Y=;
        b=MsGQx0Yn3nDgmGDCgRTElTTqZq5ZVBm+O7aBs6cBZdJknN2UAh8Ajtml5XCjiRL37fd9aA
        mDvQQoTfrX7iNDzNPyK0xRzsyAXIU6hxXY9cYZ/SjNrBdYG5NHaPEvVyvnLgnE6lzsyH+o
        snjJEoKNWPO5NiCgQ3EIHH/cuTR5G7bmVdpupfGHzHxAi1DlFq3Wjv/FKNMLmTjPzry9V3
        lOg7lmtYGf09MkVzfXygW975sZ2AJHWxzR5ESxFRgolceaY1LBecEzprVWZIbHbsnC4PNJ
        qfl145y85d64c5FC8crX+XBHSvuC2VDKJFBf5or4Vr+5H5lGDLbIYZ79fxy4Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9e5Gmxnr1gXDBGeNuKaFQxHbcIQ5VBb6TocWugW/4Y=;
        b=qvE78fBh2zFxbasIL6LECFfoBK/7Ck0cpmzzkaXxBbikGdZke+zlN3OF2P17nIZTFOQ6A6
        w7Op04FsBJ62r3DQ==
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
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v6 08/21] workqueue: Use global variant for add_timer()
Date:   Wed, 10 May 2023 09:28:04 +0200
Message-Id: <20230510072817.116056-9-anna-maria@linutronix.de>
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

The implementation of the NOHZ pull at expiry model will change the timer
bases per CPU. Timers, that have to expire on a specific CPU, require the
TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
dropped. This is required for call sites which use the timer alternately as
pinned and not pinned timer like workqueues do.

Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
v6:
  - New patch: As v6 provides unconditially setting TIMER_PINNED flag in
    add_timer_on() workqueue requires new add_timer_global() variant.
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4666a1a92a31..5c529f19e709 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1682,7 +1682,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(cpu != WORK_CPU_UNBOUND))
 		add_timer_on(timer, cpu);
 	else
-		add_timer(timer);
+		add_timer_global(timer);
 }
 
 /**
-- 
2.30.2

