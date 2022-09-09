Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAE5B3257
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIIIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIIIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F312F732;
        Fri,  9 Sep 2022 01:52:41 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzhFnEtc5sIlfFVBis6jc6sQ3LRVmoS/RHCgVfYWGlE=;
        b=g8IBSQY+Z95ITwD7jXQH3+4GeWrWSIujCgbaYPp1SMBiYCWzHKxxXjimuyELGHIdz+5GlS
        ir+VaRC6pCUC7ssGfDGiBnNW1ATZDLDz4w6uAs5P2jKeOQn8dJ74trbE56vDMiwL2PEgZ2
        yCaGAqpRdF3cnSqrIBfz8JAQuUoOcNql9ZlhA9Xg9WUrQ2L3l+NkxTD7/jhGNDqomWLb7y
        9gXcxH8YdVyumj5CBfjtCNv6DLUX2/A3a9o/ARHR+kkOROhls395zGTb3TPDqNbMFIaGRa
        ztdrDacEslKg4gEvTwX4wt+ob+uEwuQ/gVBlhfXK145SecYewWEhPRT1tsWedg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzhFnEtc5sIlfFVBis6jc6sQ3LRVmoS/RHCgVfYWGlE=;
        b=x9K8ZG2Q1PLzmNUNOn7ZUFYbCGlv60f3JzRUNlOC+mS1dVYe/UWcV14Fn9It291ujgrBad
        9KxWdORdT1Ne/0DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add a x86_pmu::limit_period static_call
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.640658334@infradead.org>
References: <20220829101321.640658334@infradead.org>
MIME-Version: 1.0
Message-ID: <166271355870.401.10235621280856927361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     08b3068fab207e3c7d79799d434e1d648524cac6
Gitweb:        https://git.kernel.org/tip/08b3068fab207e3c7d79799d434e1d648524cac6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 May 2022 21:28:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:03 +02:00

perf/x86: Add a x86_pmu::limit_period static_call

Avoid a branch and indirect call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.640658334@infradead.org
---
 arch/x86/events/core.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1e90bc7..05830bb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -72,8 +72,9 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_set_period, *x86_pmu.set_period);
-DEFINE_STATIC_CALL_NULL(x86_pmu_update,     *x86_pmu.update);
+DEFINE_STATIC_CALL_NULL(x86_pmu_set_period,   *x86_pmu.set_period);
+DEFINE_STATIC_CALL_NULL(x86_pmu_update,       *x86_pmu.update);
+DEFINE_STATIC_CALL_NULL(x86_pmu_limit_period, *x86_pmu.limit_period);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
 DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
@@ -1396,8 +1397,7 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
-	if (x86_pmu.limit_period)
-		x86_pmu.limit_period(event, &left);
+	static_call_cond(x86_pmu_limit_period)(event, &left);
 
 	this_cpu_write(pmc_prev_left[idx], left);
 
@@ -2024,6 +2024,7 @@ static void x86_pmu_static_call_update(void)
 
 	static_call_update(x86_pmu_set_period, x86_pmu.set_period);
 	static_call_update(x86_pmu_update, x86_pmu.update);
+	static_call_update(x86_pmu_limit_period, x86_pmu.limit_period);
 
 	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
 	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
