Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE066485DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLIPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLIPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C79326E8;
        Fri,  9 Dec 2022 07:47:26 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlIa5O5WDWxLlkwZolilJxqo+96OivdxfR42QRJR7Rs=;
        b=vKVVdR18ORO4yhbFN4+XEeHyhvTX6l8kpMue/9L9sH5xVB2TiQ1zmB3fxe5HLBN760A1PG
        1kr5IIXnSZWt9ZomT5Ut3tI/owS6HgbfzVyEPLql5bCiP2fvorRn2zg5vzuJvrHcdaZ70N
        wh8tRoTrPwkuYLhq9JePKZLQas2Sck5jcGWpTdXQ/+sXEQhXWiZLE1S1ChuubltP9qc+rn
        5V9t64tgTbP5V9qOhNf1Nnx2ZnB0BsGUOQczm8IdqVajeyAkFrv9Q6ixON973qaUR9J9J1
        q9gtKYacrQVeVy7dOXnhvAmQog3wXru6GhwosmnvdlXzOrOS39cPxefAujXBhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlIa5O5WDWxLlkwZolilJxqo+96OivdxfR42QRJR7Rs=;
        b=n+BXsLChIFNQfSTWHWDM8PIFH9yEstupJc6dyEegLtqxen9IEzz2qpB11zx4kByJNL/LFE
        fjTSQDCp64TOFvBQ==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix warning for
 omap_timer_match
Cc:     kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028103526.40319-1-tony@atomide.com>
References: <20221028103526.40319-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <167060084310.4906.5137830750682530203.tip-bot2@tip-bot2>
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

Commit-ID:     9688498b1648aa98a3ee45d9f07763c099f6fb12
Gitweb:        https://git.kernel.org/tip/9688498b1648aa98a3ee45d9f07763c099f6fb12
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 28 Oct 2022 13:35:26 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:16:46 +01:00

clocksource/drivers/timer-ti-dm: Fix warning for omap_timer_match

We can now get a warning for 'omap_timer_match' defined but not used.
Let's fix this by dropping of_match_ptr for omap_timer_match.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20221028103526.40319-1-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index cad29de..00af1a8 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1258,7 +1258,7 @@ static struct platform_driver omap_dm_timer_driver = {
 	.remove = omap_dm_timer_remove,
 	.driver = {
 		.name   = "omap_timer",
-		.of_match_table = of_match_ptr(omap_timer_match),
+		.of_match_table = omap_timer_match,
 		.pm = &omap_dm_timer_pm_ops,
 	},
 };
