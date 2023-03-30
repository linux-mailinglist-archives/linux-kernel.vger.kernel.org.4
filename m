Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0C6D02FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjC3LVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjC3LVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:21:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE369757;
        Thu, 30 Mar 2023 04:21:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso17553143pjz.5;
        Thu, 30 Mar 2023 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flDRWY0SXQRWGYI8uX7jYuDz+uuIEnYkNVcdxGhVOsI=;
        b=Mn71fKPWKew4GV3Y3GsROsed1zcfc+1BIcYGztLPKC0GctJCg+Dwvj2NH7evxApdsz
         6HqifP31lg3OxLHgGkqAbe/NPJj6XK1eZk/+YzRYJ+GMXMXrcx6pkVPdt8gB8AjOjtkC
         LtPTaESeeeQ5BIcQgq7EVfyls4FzwGBET244bz3hJ4VmK+lXYzlHm1Pb3cdRUpXJ6BUZ
         uOFFcrfG1p6yghsT8yHU1A6Zy4PnFklibtIq9phdquxIzA7LMs3WMChNVFFuswQLtnaa
         4JflHBRCBV/Wisnw1+n77WfcN/LgOXvaN7sFXZYwXfdSULUdVS/qkHY420hNMixUyWBM
         futQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flDRWY0SXQRWGYI8uX7jYuDz+uuIEnYkNVcdxGhVOsI=;
        b=W/DRZEIOpRcxggm3xk6Ms5wD5UjiGwkrqQBevnbLoIt/bHNjDFmlaMgFxCAA7JN7NP
         RusHmWckh30kDRiYZpXXJSBxE9G5Dr+SDyc77ldFfjxlR33lROo2u2VeezZIV+3I9Fhi
         IR819KhKc+11qyBxG15X5TdPbd+xgkrQgCRC0Wth7Mfqxoj9rFYs1MnlHm8tMiY4No3w
         pO4UI22fZ94s6D6Wtkzq2R8CkdhkF2mH+Xj4wc/TkGuEPEHD8l9co31Gc2m9Bexn/K+K
         R0OK3L0JaJCY7Eybl1ndgEhwZHXAhbuW/hMYXu8ZRQKTrn3kfWZPK/6qFL4G1rQ1oBks
         nzTQ==
X-Gm-Message-State: AAQBX9f+1C7gEJShCv5T2rp3DMjOYiZPJRVdevAAfiu9wKaMBbmL0XYs
        xC7emceP0xojMPVdGB5/L6yKRTXlKifIFA==
X-Google-Smtp-Source: AKy350ZQH0+bj83gJRvuR6lEKxOyEptMg+PH70Io+hn00pQpCUcPe9xlwLm811aChlIejNnY91Go5w==
X-Received: by 2002:a17:903:41cd:b0:1a1:b65a:2072 with SMTP id u13-20020a17090341cd00b001a1b65a2072mr29339568ple.59.1680175269202;
        Thu, 30 Mar 2023 04:21:09 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b0019f11a68c42sm24444851pld.297.2023.03.30.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:21:08 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 2/2] watchdog: loongson1_wdt: Implement restart handler
Date:   Thu, 30 Mar 2023 19:20:51 +0800
Message-Id: <20230330112051.551648-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330112051.551648-1-keguang.zhang@gmail.com>
References: <20230330112051.551648-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement restart handler for the Loongson-1 watchdog driver and
define the watchdog registers instead of including the legacy header.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: None
---
 drivers/watchdog/loongson1_wdt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index bb3d075c0633..a0b6fe62e516 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -7,7 +7,11 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
-#include <loongson1.h>
+
+/* Loongson 1 Watchdog Register Definitions */
+#define WDT_EN			0x0
+#define WDT_TIMER		0x4
+#define WDT_SET			0x8
 
 #define DEFAULT_HEARTBEAT	30
 
@@ -66,6 +70,18 @@ static int ls1x_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int ls1x_wdt_restart(struct watchdog_device *wdt_dev,
+			    unsigned long action, void *data)
+{
+	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+
+	writel(0x1, drvdata->base + WDT_EN);
+	writel(0x1, drvdata->base + WDT_TIMER);
+	writel(0x1, drvdata->base + WDT_SET);
+
+	return 0;
+}
+
 static const struct watchdog_info ls1x_wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity = "Loongson1 Watchdog",
@@ -77,6 +93,7 @@ static const struct watchdog_ops ls1x_wdt_ops = {
 	.stop = ls1x_wdt_stop,
 	.ping = ls1x_wdt_ping,
 	.set_timeout = ls1x_wdt_set_timeout,
+	.restart = ls1x_wdt_restart,
 };
 
 static void ls1x_clk_disable_unprepare(void *data)
-- 
2.34.1

