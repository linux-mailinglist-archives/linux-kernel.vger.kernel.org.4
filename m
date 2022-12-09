Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B836485D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLIPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiLIPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BEC32BB7;
        Fri,  9 Dec 2022 07:47:24 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOOwBJNPMAhOXpq3k36p3Lw74niqTkZH1cWby86RAfo=;
        b=UKagibPQG/UNh7JwBRo1dMDPx8+F6KpkV+cA4ir+kzUUVpBKlP7d9g7ByWWzEgUS+sLjrd
        y/n+XSuSg5OTzBntRp8SKD8dWoRgUQ5rta4pSh4ZdzU+vfervRzjNYJ9hY2ShKW7yQp+K6
        +RN+Fu5E/RmWI9V/2y0VtW1FR6m4zpt+MS+osOX/Xl8h9oHTaKf5jZnss3/tR1fkBb78zd
        mPTQc2cIuz82tXAdbw0hNSoIq3qBZ57vLnx7/SjxZ5wUBR4TkaHMOX7j0+yDzRhzeYV+w5
        ZPkAlc/k1Y+AEOyhFBQBai8JhMnTsZe5syKwUb8jzEdIsefvn50hyWTVftKYzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOOwBJNPMAhOXpq3k36p3Lw74niqTkZH1cWby86RAfo=;
        b=AJevUmf6gvbvuqB242D1DcE3nvJA38+vTkuqJbyItclvGF4e5spcnDTScfnW/g7N13F6L7
        5ir069NSomt1kWDw==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Use
 kstrtobool() instead of strtobool()
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf430bb12e12eb225ab1206db0be64b755ddafbdc=2E16673?=
 =?utf-8?q?36095=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Cf430bb12e12eb225ab1206db0be64b755ddafbdc=2E166733?=
 =?utf-8?q?6095=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <167060084243.4906.1276129889140707311.tip-bot2@tip-bot2>
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

Commit-ID:     4238568744c0a150d8901e7847092a0f871c938d
Gitweb:        https://git.kernel.org/tip/4238568744c0a150d8901e7847092a0f871c938d
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Tue, 01 Nov 2022 22:13:58 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:17:34 +01:00

clocksource/drivers/arm_arch_timer: Use kstrtobool() instead of strtobool()

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/f430bb12e12eb225ab1206db0be64b755ddafbdc.1667336095.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e2920da..1695c56 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -18,6 +18,7 @@
 #include <linux/clocksource.h>
 #include <linux/clocksource_ids.h>
 #include <linux/interrupt.h>
+#include <linux/kstrtox.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
@@ -97,7 +98,7 @@ static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EV
 
 static int __init early_evtstrm_cfg(char *buf)
 {
-	return strtobool(buf, &evtstrm_enable);
+	return kstrtobool(buf, &evtstrm_enable);
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
 
