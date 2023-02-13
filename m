Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57404694F36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBMS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189A26A0;
        Mon, 13 Feb 2023 10:26:23 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBmUJrckZ3jPDtiTD3AqLJ/uLCnF2ZRbzYInXqOzvMw=;
        b=rUjgeukuMEpVvKWuwwA9C80WW336APoSNvDOt1zeOQ8yI1EqEama5b6FyJ++Rgdrey30Eh
        aHTi9ZAkVJk9r0y+ujwOoIOw9NhlTwhuGGNq4U5qLrHZxWqSo5zeURN4DJmdy3w58KmSSo
        m3SILJWk8TEqbNWmW6hY2v9umFt4Vxq2FI1j8a+Nne12PoerYpImsjvgj/gikHXpLQvdCj
        kpuqh5b4ksR2nhSurbrQntvg4sB3bOXdS6rRp8ZUzM83deNhNdG872o7hlSPy947YQvjiv
        dTi0LLHLSAvLN4zsBzUgM1gR2fCERjfl6HnV/j9RFyGbGQq8Nv2jhQdYM6cckg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBmUJrckZ3jPDtiTD3AqLJ/uLCnF2ZRbzYInXqOzvMw=;
        b=/QCd5M0X/yP7bWsoB6wGo56T891EAdmjaINo2/+noj2KkvE3Fol194BQ/DHkSRaP+Xv29v
        rl5XyiEBRgugYVBw==
From:   "tip-bot2 for Yangtao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-sun4i: Add CLOCK_EVT_FEAT_DYNIRQ
Cc:     Yangtao Li <frank.li@vivo.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230209040239.24710-1-frank.li@vivo.com>
References: <20230209040239.24710-1-frank.li@vivo.com>
MIME-Version: 1.0
Message-ID: <167631278133.4906.4239222579373773162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5ccb51b06c8bfcfca99d3f68e671eead7318301d
Gitweb:        https://git.kernel.org/tip/5ccb51b06c8bfcfca99d3f68e671eead7318301d
Author:        Yangtao Li <frank.li@vivo.com>
AuthorDate:    Thu, 09 Feb 2023 12:02:39 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/timer-sun4i: Add CLOCK_EVT_FEAT_DYNIRQ

Add CLOCK_EVT_FEAT_DYNIRQ to allow the IRQ could be runtime set affinity
to the cores that needs wake up, otherwise saying core0 has to send
IPI to wakeup core1. With CLOCK_EVT_FEAT_DYNIRQ set, when broadcast
timer could wake up the cores, IPI is not needed.

After enabling this feature, especially the scene where cpuidle is
enabled can benefit.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Link: https://lore.kernel.org/r/20230209040239.24710-1-frank.li@vivo.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index e5a70aa..7bdcc60 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -144,7 +144,8 @@ static struct timer_of to = {
 	.clkevt = {
 		.name = "sun4i_tick",
 		.rating = 350,
-		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+				CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown = sun4i_clkevt_shutdown,
 		.set_state_periodic = sun4i_clkevt_set_periodic,
 		.set_state_oneshot = sun4i_clkevt_set_oneshot,
