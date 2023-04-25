Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864D46EDFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjDYKFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 06:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjDYKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:05:10 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DECC11;
        Tue, 25 Apr 2023 03:05:07 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5D1B624E2D6;
        Tue, 25 Apr 2023 18:04:57 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 18:04:57 +0800
Received: from localhost.localdomain (113.72.145.137) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 18:04:56 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] watchdog: starfive: Fix the probe return error if PM and early_enable are both disabled
Date:   Tue, 25 Apr 2023 18:04:56 +0800
Message-ID: <20230425100456.32718-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the starfive watchdog driver uses 'pm_runtime_put_sync()' as probe
return value at last and 'early_enable' is disabled, it could return the
error '-ENOSYS' if the CONFIG_PM is disabled, but the driver should works
normally.

Add a check to make sure the PM is enabled and then use
'pm_runtime_put_sync()' as return value when 'early_enable' is disabled.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---

Hi, Guenter and Wim,

This patch fixes the issue of StarFive watchdog driver and rebases on
the master branch of linux-next.

Thanks.
 
---
 drivers/watchdog/starfive-wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 1995cceca51e..51e487e09960 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -492,7 +492,8 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 		goto err_exit;
 
 	if (!early_enable)
-		return pm_runtime_put_sync(&pdev->dev);
+		if (pm_runtime_enabled(&pdev->dev))
+			return pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 
-- 
2.25.1

