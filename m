Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFA694F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBMS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBMS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A51BFF;
        Mon, 13 Feb 2023 10:26:27 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBWvgNTJo25uP/2ad9ZRdoH5JQeMmDUIVt6IVzS64KI=;
        b=yAxNxePdPYPgsBgflAjiRpNJUiqoKxpGp1M1/H93touCv8WAsHPBtUagLStCAhpoRErUVw
        SHEoW5Vt6pL8sD2rYhCRp5MTX2hDFgVVOsO5XFcjGXe3JDcvDJfW/wHL5YnJiSyrYBG95A
        ONZY2JYpg64y20kcL0wjHc7tPnzZcpC8C6aliOc7BpBjAubgmnDC6oJElns0wDZwWycxL7
        R4Xig8ycn0LJhgMnZkOk1WWZq31V6KhMmBzWoBXsMBEEFO8SFbRWAWMNcRliOH5Oq7zUHy
        IimFfV/G2HZIS2vGVC3axkE8qQfa/+5z5kdvpg5EzaKFYK7Q0RwnzoX9IcC/DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBWvgNTJo25uP/2ad9ZRdoH5JQeMmDUIVt6IVzS64KI=;
        b=tiaH3FD/xWc4HCxGSEnVmMJ15/oZadFJcxVBrHgH9OdFsgj1IzY4GTEvEqE7xzaT/MtEWc
        oy20w9UqB5Yn4bBQ==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Select
 driver only on ARM
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230203130537.1921608-2-claudiu.beznea@microchip.com>
References: <20230203130537.1921608-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <167631278298.4906.7137477742048963876.tip-bot2@tip-bot2>
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

Commit-ID:     d19c8b2ed176c6aaf3dfefd149c740f73ce4875e
Gitweb:        https://git.kernel.org/tip/d19c8b2ed176c6aaf3dfefd149c740f73ce4875e
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Fri, 03 Feb 2023 15:05:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/timer-microchip-pit64b: Select driver only on ARM

Microchip PIT64B is currently available on ARM based devices. Thus
select it only for ARM. This allows implementing delay timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230203130537.1921608-2-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 45085ab..ac22c1a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -706,7 +706,7 @@ config INGENIC_OST
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
-	depends on OF
+	depends on OF && ARM
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
