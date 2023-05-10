Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8166FD824
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjEJH2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjEJH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:28:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C287AA7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:28:37 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQ3NXQMtig0Ydn+DZ27wQ54KKOjUtVfs2xndfW98O6U=;
        b=D1z8D7w3JzNIOBDodikGpgba/haCLy1TxmxP/1wSCOZKJuKDVD8q6m1tAVemn7SY1VMWfX
        6inJI1GFRSek4B7U+lxGZiw87qltifNke3JPTbMUysJgKWHviXMFJyHEtcUVC+7ILLMW9h
        nmo1GduNR6p9ELH1LAs8wPS+1y1Zy4qGBabcXVgtpq96Pi5Rm6DGeX8uMQFlHKifa2b268
        qMRrYVXrF9NhOdDFIgse2Mhu5ZVo0Qtzo+AeyfIiUILGHXgxGjQmSVsjpP++ZaEKDKBBCq
        Q6gSE/tTo6gXH2v+zwCnuTMQQbfceTvYFc7Sg815OQlx8zkCGzNMBQ5jMKOM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQ3NXQMtig0Ydn+DZ27wQ54KKOjUtVfs2xndfW98O6U=;
        b=gouTsahUwW0QIcMnc5t/uebABITaHYIEOsA+7sqa8xzzd0gbx4fXMQfK0n2Cp3y0Ht/nMd
        AFCfNmzT2tNM68Aw==
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
Subject: [PATCH v6 01/21] tick-sched: Warn when next tick seems to be in the past
Date:   Wed, 10 May 2023 09:27:57 +0200
Message-Id: <20230510072817.116056-2-anna-maria@linutronix.de>
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
index 52254679ec48..62836490ba4d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -831,6 +831,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
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

