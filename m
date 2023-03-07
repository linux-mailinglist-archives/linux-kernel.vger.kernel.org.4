Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0921D6ADF00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCGMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCGMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:43:34 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0CC49892
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:43:32 -0800 (PST)
Received: from fabio-Precision-3551.. (unknown [IPv6:2804:14c:485:4b69:479c:7535:eb9:ae35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5CF4D85B1E;
        Tue,  7 Mar 2023 13:43:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1678193009;
        bh=QZATXNgCvjsN1UDwyI8/mzKko22hR/juVJM5m31ZcHg=;
        h=From:To:Cc:Subject:Date:From;
        b=m1lEIUAqCzb/yrdw5Pzj3nVbdT0QKbpDJo0RfrCaWG6s5VE+OjugoB6jJ8s+NAg3y
         KKtd0XwGpYE6G20GC1dlhsGIsp95TnEUqDuE4KS+7uyY1pjEg6YT5gMWUsKEFAR5QU
         X9FdnnTeWsRiUp9tTjSXEKGLYwKLREBEel56fa4nzWarsgqiWE3qXbwr4i2ov0zC2H
         Fv/RzcQ15DVL0LgK0pGaeoinqDKIRwnpi/CvIGMM173qUoZDnxjOCEiFMr26mAVGKB
         c5VDQ5kDUiaj1M2GXrErUFOnLEwHFxHVG5HumoNJAwmdNkxa+U6QugHUooR0D1kYpe
         eaafZ4HE4Z/RQ==
From:   Fabio Estevam <festevam@denx.de>
To:     daniel.lezcano@linaro.org
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] clocksource/drivers/timer-imx-gpt: Remove non-DT function
Date:   Tue,  7 Mar 2023 09:43:13 -0300
Message-Id: <20230307124313.708255-1-festevam@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mxc_timer_init() was originally only used by non-DT i.MX platforms.

i.MX has already been converted to be a DT-only platform.

Remove the unused mxc_timer_init() function.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/clocksource/timer-imx-gpt.c | 19 -------------------
 include/soc/imx/timer.h             |  7 -------
 2 files changed, 26 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 7b2c70f2f353..ca3e4cbc80c6 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -420,25 +420,6 @@ static int __init _mxc_timer_init(struct imx_timer *imxtm)
 	return mxc_clockevent_init(imxtm);
 }
 
-void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
-{
-	struct imx_timer *imxtm;
-
-	imxtm = kzalloc(sizeof(*imxtm), GFP_KERNEL);
-	BUG_ON(!imxtm);
-
-	imxtm->clk_per = clk_get_sys("imx-gpt.0", "per");
-	imxtm->clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
-
-	imxtm->base = ioremap(pbase, SZ_4K);
-	BUG_ON(!imxtm->base);
-
-	imxtm->type = type;
-	imxtm->irq = irq;
-
-	_mxc_timer_init(imxtm);
-}
-
 static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type type)
 {
 	struct imx_timer *imxtm;
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
index b888d5076b4d..25f29c6bbd0b 100644
--- a/include/soc/imx/timer.h
+++ b/include/soc/imx/timer.h
@@ -13,11 +13,4 @@ enum imx_gpt_type {
 	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
 };
 
-/*
- * This is a stop-gap solution for clock drivers like imx1/imx21 which call
- * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
- * when these legacy non-DT support is converted or dropped.
- */
-void mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type);
-
 #endif  /* __SOC_IMX_TIMER_H__ */
-- 
2.34.1

