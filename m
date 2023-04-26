Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4436B6EF0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbjDZJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbjDZJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D284496;
        Wed, 26 Apr 2023 02:12:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXREl/1bmbiXbNsXCjOEmqqeut0cSRsTmJ4GkEHgJZ4=;
        b=oDBVCu8TYB8Knr6Qehs5GPM5KrEA/FRzNBTP61AvHSWqif/1ZPFLgwyCSq3dKUSVE0J5NN
        DX46GzQLTkMo4SBQBHlaHBb3I+Ff2A9gq5eteVmL2dMO8Mkm9FzWvSLo25ycHvOYrOAodG
        vmXOyELzixl6gMEmH96zh9QDw0OF8n/rJLV01n5kdLN6Gh32iW7rm5n/rzyhfe0WjqPR5E
        Aa8rrJiDbmwRLD8tUlADVs7utTkLXEmsefs6hRRacFug34oMjfIXe257yN8yvbXfV4v9Kf
        XuvfUTEo0SXrJ4VENrsvj+o548VjTgLDfKDoRXM91qXJoD2QEuhTdUbnQdK4nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXREl/1bmbiXbNsXCjOEmqqeut0cSRsTmJ4GkEHgJZ4=;
        b=3hy56a64hlYEqH6YkP78QsI6HnAX7VW/PzJDCKnyxF395KLfza6ESAxhmMoWnLtWq00acx
        JmvvXiyk0kL5reDg==
From:   "tip-bot2 for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Use
 of_address_to_resource()
Cc:     Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230319163220.226273-1-robh@kernel.org>
References: <20230319163220.226273-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <168250035290.404.6276091333899871488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0fabf9f3a0c1ca44e01c5c4dccacfe69143413c5
Gitweb:        https://git.kernel.org/tip/0fabf9f3a0c1ca44e01c5c4dccacfe69143413c5
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Sun, 19 Mar 2023 11:32:20 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/timer-ti-dm: Use of_address_to_resource()

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230319163220.226273-1-robh@kernel.org
---
 drivers/clocksource/timer-ti-dm-systimer.c | 57 +++++++++------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 632523c..3b98a3c 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -251,24 +251,22 @@ static void __init dmtimer_systimer_assign_alwon(void)
 		counter_32k = -ENODEV;
 
 	for_each_matching_node(np, dmtimer_match_table) {
+		struct resource res;
 		if (!dmtimer_is_preferred(np))
 			continue;
 
-		if (of_property_read_bool(np, "ti,timer-alwon")) {
-			const __be32 *addr;
-
-			addr = of_get_address(np, 0, NULL, NULL);
-			pa = of_translate_address(np, addr);
-			if (pa) {
-				/* Quirky omap3 boards must use dmtimer12 */
-				if (quirk_unreliable_oscillator &&
-				    pa == 0x48318000)
-					continue;
-
-				of_node_put(np);
-				break;
-			}
-		}
+		if (!of_property_read_bool(np, "ti,timer-alwon"))
+			continue;
+
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		/* Quirky omap3 boards must use dmtimer12 */
+		if (quirk_unreliable_oscillator && res.start == 0x48318000)
+			continue;
+
+		of_node_put(np);
+		break;
 	}
 
 	/* Usually no need for dmtimer clocksource if we have counter32 */
@@ -285,24 +283,22 @@ static void __init dmtimer_systimer_assign_alwon(void)
 static u32 __init dmtimer_systimer_find_first_available(void)
 {
 	struct device_node *np;
-	const __be32 *addr;
 	u32 pa = 0;
 
 	for_each_matching_node(np, dmtimer_match_table) {
+		struct resource res;
 		if (!dmtimer_is_preferred(np))
 			continue;
 
-		addr = of_get_address(np, 0, NULL, NULL);
-		pa = of_translate_address(np, addr);
-		if (pa) {
-			if (pa == clocksource || pa == clockevent) {
-				pa = 0;
-				continue;
-			}
-
-			of_node_put(np);
-			break;
-		}
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		if (res.start == clocksource || res.start == clockevent)
+			continue;
+
+		pa = res.start;
+		of_node_put(np);
+		break;
 	}
 
 	return pa;
@@ -812,7 +808,7 @@ err_out_free:
  */
 static int __init dmtimer_systimer_init(struct device_node *np)
 {
-	const __be32 *addr;
+	struct resource res;
 	u32 pa;
 
 	/* One time init for the preferred timer configuration */
@@ -826,8 +822,9 @@ static int __init dmtimer_systimer_init(struct device_node *np)
 		return -EINVAL;
 	}
 
-	addr = of_get_address(np, 0, NULL, NULL);
-	pa = of_translate_address(np, addr);
+
+	of_address_to_resource(np, 0, &res);
+	pa = (u32)res.start;
 	if (!pa)
 		return -EINVAL;
 
