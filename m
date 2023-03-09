Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A76B2530
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCINWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCINVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:21:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBEE8AB6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:21:34 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7653F660301A;
        Thu,  9 Mar 2023 13:21:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678368093;
        bh=ldHXW19jlSTRYyH5WBpqiCYhhBV+psP18BsDgYHhh9c=;
        h=From:To:Cc:Subject:Date:From;
        b=IBMJpfisS7whkQpD/k8VireP5Hs0dDOUGl4S7ZJLe7gUqz2oQUHPX2c++Iw5Wikf7
         4XnMOclMG6RxTt1PAsYtmcgXEAayT3th9yC3hMHhiIhPHMnecQGLAU1j4H7PHua/jn
         rtsn6stv7GeI0y+ynN2N4E619/IyDChsLoXhu33Mjl4j+mLF+6P+VLvMW13dwHVheq
         Gh2tWZ0vMzFaw6kicgGToy0GJoDVdAoWaX8zF9eG9jyd4UIMyjHueIn69qZ1JExiox
         gv6DokypVRy0OWm+dBqsNzKX9WFcVNqNai9k7EBhX+aFMg/y/0d3Ug++ZbBC1x1rOc
         Vp42agSkDNRmA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     walter.chang@mediatek.con
Cc:     sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, macro@orcam.me.uk, jstultz@google.com,
        krzysztof.kozlowski@linaro.org, wsd_upstream@mediatek.com,
        stanley.chu@mediatek.com, Chun-hung.Wu@mediatek.com,
        Freddy.Hsin@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH RFC] RFC: clocksource: timer-mediatek: Add means to register as platform_driver
Date:   Thu,  9 Mar 2023 14:21:19 +0100
Message-Id: <20230309132119.175650-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is not meant to be picked!

As some parties have some interest [1] in converting timers to
modules (for the sake of GKI), which IMO is quite tricky and hard
to do, I started some (quite fast) research on how could this be
achieved: not like that, for sure!

This kind of timers are obviously started early in the kernel init
process and as far as I saw (rightfully) even before pure_initcall,
or actually, better said, even before *any* initcall.

I fully acknowledge that this, as it is right now, is a quite big
hack... though, this actually compiles and actually... works if
timer-mediatek is compiled as built-in (so, in a way, I achieved
nothing), but the addition of the pure_initcall() there may be an
idea for others to experiment with initializing system timers at
a later stage.

This commit is practically one of the last steps involved in the
conversion, but it's meant as a conversation piece for the
interested parties.

Last thing last, after performing this research, I'm not sure
that pursuing modularization for timers is really worth it,
but I may be ignoring something :-)

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20230214105412.5856-5-walter.chang@mediatek.com/
---
 drivers/clocksource/timer-mediatek.c | 40 ++++++++++++++++++++++++++--
 include/linux/clocksource.h          |  8 ++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 7bcb4a3f26fb..eda7f60475b6 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -13,6 +13,7 @@
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
+#include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
 #include "timer-of.h"
@@ -337,5 +338,40 @@ static int __init mtk_gpt_init(struct device_node *node)
 
 	return 0;
 }
-TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
-TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
+
+static int mtk_timer_probe(struct platform_device *pdev)
+{
+	int (*mtk_timer_init)(struct device_node *node);
+
+	mtk_timer_init = device_get_match_data(&pdev->dev);
+	if (!mtk_timer_init)
+		return -EINVAL;
+
+	return mtk_timer_init(pdev->dev.of_node);
+}
+
+static const struct of_device_id timer_mediatek_of_match[] __timer_of_section = {
+	{ .compatible = "mediatek,mt6577-timer", .data = mtk_gpt_init },
+	{ .compatible = "mediatek,mt6765-timer", .data = mtk_syst_init },
+#ifdef MODULE
+	{ /* sentinel */ }
+#endif
+};
+MODULE_DEVICE_TABLE(of, timer_mediatek_of_match);
+
+static struct platform_driver timer_mediatek_driver __maybe_unused = {
+	.driver = {
+		.name = "mediatek-timer",
+		.of_match_table = timer_mediatek_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = mtk_timer_probe,
+};
+
+#ifdef MODULE
+static int __init timer_mediatek_init(void)
+{
+	return platform_driver_register(&timer_mediatek_driver);
+}
+pure_initcall(timer_mediatek_init)
+#endif
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..a5d61a1099e4 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -279,6 +279,14 @@ extern int clocksource_mmio_init(void __iomem *, const char *,
 
 extern int clocksource_i8253_init(void);
 
+#if defined(CONFIG_OF) && !defined(MODULE)
+ #define __timer_of_section				\
+	 __used __section("__timer_of_table")		\
+	 __aligned(__alignof__(struct of_device_id))
+#else
+ #define __timer_of_section
+#endif
+
 #define TIMER_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1_RET(timer, name, compat, fn)
 
-- 
2.39.2

