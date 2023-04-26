Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680E6EF0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjDZJM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbjDZJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701F420A;
        Wed, 26 Apr 2023 02:12:33 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eM36TJpgcoXwBaDtDewnQoNdWERy6CUBCU4RH+0AfPM=;
        b=eT5HzHEzHfzcJhNZlNh+qVC7I7keTnmhqpUUK0TN/A2Z5XchjO91vSVF5VsfcT3FWk4D8k
        P+Z1UzWVR60MXRFMeW2DKIRNNUMhxEjKct3AOubKXeXySUfmechCtWZt9iH9YN2r4T2vjS
        6bFoOdBMdsgP5i6gHyFuutTQo/3kRyTYtpucDs5C+Eeczj2H7486a+/m/a1DHoIv5UO2UI
        9QUuvYYb1RymOQm4qMlP2/7m6Xst03tpY8itlwjlmmKAu/ralL30E1HBYf7ClRYAa097wR
        FNXkvJ8ik+svGyvKwfXMOlqtT5f3rCEZAllJV/vdMEVyVSUhq+d4BO35hsQrpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eM36TJpgcoXwBaDtDewnQoNdWERy6CUBCU4RH+0AfPM=;
        b=q1QMDmNp33+ZRQcXfO41EToHZFzSUGCykqhq+FaQpR8Wb+71JlT8FdPCmnELZ3NYB8buO3
        KANZa7TmyrWG1uAw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix finding alwon timer
Cc:     Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230412064142.12726-1-tony@atomide.com>
References: <20230412064142.12726-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <168250035092.404.8314422191902400268.tip-bot2@tip-bot2>
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

Commit-ID:     8d7aac5153f21108365137b76e395dcf9bb3a800
Gitweb:        https://git.kernel.org/tip/8d7aac5153f21108365137b76e395dcf9bb3a800
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Wed, 12 Apr 2023 09:41:41 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:14 +02:00

clocksource/drivers/timer-ti-dm: Fix finding alwon timer

Clean-up commit b6999fa1c847 ("clocksource/drivers/timer-ti-dm: Use
of_address_to_resource()") caused a regression where pa is never set
making all related SoCs fail to boot. Let's fix this by setting pa
if found.

Fixes: b6999fa1c847 ("clocksource/drivers/timer-ti-dm: Use of_address_to_resource()")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230412064142.12726-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 3b98a3c..4fa68f6 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -261,8 +261,10 @@ static void __init dmtimer_systimer_assign_alwon(void)
 		if (of_address_to_resource(np, 0, &res))
 			continue;
 
+		pa = res.start;
+
 		/* Quirky omap3 boards must use dmtimer12 */
-		if (quirk_unreliable_oscillator && res.start == 0x48318000)
+		if (quirk_unreliable_oscillator && pa == 0x48318000)
 			continue;
 
 		of_node_put(np);
