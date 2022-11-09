Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA56236BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKIWnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKIWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:42:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D91B9CC;
        Wed,  9 Nov 2022 14:42:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k7so45350pll.6;
        Wed, 09 Nov 2022 14:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb0Gs488yvsxkSMkYVmJzJWdckJ7k6xbmeU+rrY4bs0=;
        b=o814sDfrZd0iixpQ/zwFRvuqLuGxqhGS8tNbUNhT14+GIvjsr7fRW8qHjomICh/BKx
         oNUSXtVpudNvDeZFPQgBmzpDk/Z9fLtidJjqOkciv7yt4oqQds9NVc0PQtJovrIO+pJD
         M12bmMaCXsPgWQqZcjrI30P3LpjOJiu8e8RWV4o6DDTl5CFKITDZFiQGgkoK3yv1bm6n
         tH6/ONZ+nzgIItL0mr0ajpL4XTHdu68AzB57PJcKsefcA+I8WXk8JG7Tojdmk2X3NdKV
         TERT7I6Q7YguaXAH6aXDVpuZyufhLp5DPvR1uz1c9WQXmUW4dAL9MOn7Z7xrHGG+1g4T
         glEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb0Gs488yvsxkSMkYVmJzJWdckJ7k6xbmeU+rrY4bs0=;
        b=Yh+QhYHYTwoOrFfHGkeaXYf3sYLNvPMQ+fXpuAVYMbtcfxMmtLDBnoRI1z+rGDfOx9
         102xvoA7fY9/64eiY+rJCAFfVuTf/Ah9HmbZh1X5TatG7NxZQAaGMLR31W8CdAeigCMV
         fPj/YStpy98viGLVW9XGsFIEJeyctLTOSueJ02GW0JDeGAyPswft0NCU53htHyXXwXx0
         uSQS6T8QUKoj1Z4DWVj/I6V9IL7BtU5nXALKxIlU1sl0x1WAPOUBBJL304kwy/xV3r2Y
         BW6wG7NLp/4niTcLyNLcVF97yN1Eul//XBGhFgmXOKdDGm8GsDNkq96gBWRrc874secz
         T3OQ==
X-Gm-Message-State: ACrzQf2ngm4Ui7IR9q9P+FNAMqAQG/ZBQM35EhA0LSKLnlpApK0l34M2
        HrXrvaFH91wReGG+NXwa4co=
X-Google-Smtp-Source: AMsMyM7xvKjfaOnavQ4pZs96UPh6JtAjcrIYune70gaATIWK69KTslB4zqQP6cZTZEOhvlf57qXJKw==
X-Received: by 2002:a17:902:d38d:b0:186:9fc5:6c13 with SMTP id e13-20020a170902d38d00b001869fc56c13mr62900281pld.73.1668033776751;
        Wed, 09 Nov 2022 14:42:56 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id k17-20020a63ff11000000b0046f9f4a2de6sm7995042pgi.74.2022.11.09.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:42:56 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: wl1251: drop support for platform data
Date:   Wed,  9 Nov 2022 14:42:49 -0800
Message-Id: <20221109224250.2885119-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
References: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for configuring the device via platform data because
there are no users of wl1251_platform_data left in the mainline kernel.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 MAINTAINERS                                   |  1 -
 drivers/net/wireless/ti/Kconfig               |  8 ----
 .../net/wireless/ti/wilink_platform_data.c    | 35 ---------------
 drivers/net/wireless/ti/wl1251/sdio.c         |  8 +---
 drivers/net/wireless/ti/wl1251/spi.c          | 15 ++-----
 drivers/net/wireless/ti/wlcore/spi.c          |  1 -
 include/linux/wl12xx.h                        | 44 -------------------
 7 files changed, 4 insertions(+), 108 deletions(-)
 delete mode 100644 drivers/net/wireless/ti/wilink_platform_data.c
 delete mode 100644 include/linux/wl12xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 03ae061c5f6f..e51716599335 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20724,7 +20724,6 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl12xx
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl1251
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luca/wl12xx.git
 F:	drivers/net/wireless/ti/
-F:	include/linux/wl12xx.h
 
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
 M:	John Stultz <jstultz@google.com>
diff --git a/drivers/net/wireless/ti/Kconfig b/drivers/net/wireless/ti/Kconfig
index 7c0b17a76fe2..3fcd9e395f72 100644
--- a/drivers/net/wireless/ti/Kconfig
+++ b/drivers/net/wireless/ti/Kconfig
@@ -18,12 +18,4 @@ source "drivers/net/wireless/ti/wl18xx/Kconfig"
 # keep last for automatic dependencies
 source "drivers/net/wireless/ti/wlcore/Kconfig"
 
-config WILINK_PLATFORM_DATA
-	bool "TI WiLink platform data"
-	depends on WLCORE_SDIO || WL1251_SDIO
-	default y
-	help
-	Small platform data bit needed to pass data to the sdio modules.
-
-
 endif # WLAN_VENDOR_TI
diff --git a/drivers/net/wireless/ti/wilink_platform_data.c b/drivers/net/wireless/ti/wilink_platform_data.c
deleted file mode 100644
index 1de6a62d526f..000000000000
--- a/drivers/net/wireless/ti/wilink_platform_data.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * This file is part of wl12xx
- *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
- */
-
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/wl12xx.h>
-
-static struct wl1251_platform_data *wl1251_platform_data;
-
-int __init wl1251_set_platform_data(const struct wl1251_platform_data *data)
-{
-	if (wl1251_platform_data)
-		return -EBUSY;
-	if (!data)
-		return -EINVAL;
-
-	wl1251_platform_data = kmemdup(data, sizeof(*data), GFP_KERNEL);
-	if (!wl1251_platform_data)
-		return -ENOMEM;
-
-	return 0;
-}
-
-struct wl1251_platform_data *wl1251_get_platform_data(void)
-{
-	if (!wl1251_platform_data)
-		return ERR_PTR(-ENODEV);
-
-	return wl1251_platform_data;
-}
-EXPORT_SYMBOL(wl1251_get_platform_data);
diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index c9a4e9a43400..301bd0043a43 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -12,7 +12,6 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/platform_device.h>
-#include <linux/wl12xx.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
@@ -197,7 +196,6 @@ static int wl1251_sdio_probe(struct sdio_func *func,
 	struct wl1251 *wl;
 	struct ieee80211_hw *hw;
 	struct wl1251_sdio *wl_sdio;
-	const struct wl1251_platform_data *wl1251_board_data;
 	struct device_node *np = func->dev.of_node;
 
 	hw = wl1251_alloc_hw();
@@ -225,11 +223,7 @@ static int wl1251_sdio_probe(struct sdio_func *func,
 	wl->if_priv = wl_sdio;
 	wl->if_ops = &wl1251_sdio_ops;
 
-	wl1251_board_data = wl1251_get_platform_data();
-	if (!IS_ERR(wl1251_board_data)) {
-		wl->irq = wl1251_board_data->irq;
-		wl->use_eeprom = wl1251_board_data->use_eeprom;
-	} else if (np) {
+	if (np) {
 		wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
 		wl->irq = of_irq_get(np, 0);
 		if (wl->irq == -EPROBE_DEFER) {
diff --git a/drivers/net/wireless/ti/wl1251/spi.c b/drivers/net/wireless/ti/wl1251/spi.c
index 9df38726e8b0..08d9814b49c1 100644
--- a/drivers/net/wireless/ti/wl1251/spi.c
+++ b/drivers/net/wireless/ti/wl1251/spi.c
@@ -12,7 +12,6 @@
 #include <linux/swab.h>
 #include <linux/crc7.h>
 #include <linux/spi/spi.h>
-#include <linux/wl12xx.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
@@ -226,16 +225,13 @@ static const struct wl1251_if_operations wl1251_spi_ops = {
 
 static int wl1251_spi_probe(struct spi_device *spi)
 {
-	struct wl1251_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct device_node *np = spi->dev.of_node;
 	struct ieee80211_hw *hw;
 	struct wl1251 *wl;
 	int ret;
 
-	if (!np && !pdata) {
-		wl1251_error("no platform data");
+	if (!np)
 		return -ENODEV;
-	}
 
 	hw = wl1251_alloc_hw();
 	if (IS_ERR(hw))
@@ -259,14 +255,9 @@ static int wl1251_spi_probe(struct spi_device *spi)
 		goto out_free;
 	}
 
-	if (np) {
-		wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
-		wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);
-	} else if (pdata) {
-		wl->power_gpio = pdata->power_gpio;
-		wl->use_eeprom = pdata->use_eeprom;
-	}
+	wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
 
+	wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);
 	if (wl->power_gpio == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
 		goto out_free;
diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 7eae1ec2eb2b..2d2edddc77bd 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -14,7 +14,6 @@
 #include <linux/swab.h>
 #include <linux/crc7.h>
 #include <linux/spi/spi.h>
-#include <linux/wl12xx.h>
 #include <linux/platform_device.h>
 #include <linux/of_irq.h>
 #include <linux/regulator/consumer.h>
diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
deleted file mode 100644
index 03d61f1d23ab..000000000000
--- a/include/linux/wl12xx.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This file is part of wl12xx
- *
- * Copyright (C) 2009 Nokia Corporation
- *
- * Contact: Luciano Coelho <luciano.coelho@nokia.com>
- */
-
-#ifndef _LINUX_WL12XX_H
-#define _LINUX_WL12XX_H
-
-#include <linux/err.h>
-
-struct wl1251_platform_data {
-	int power_gpio;
-	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
-	int irq;
-	bool use_eeprom;
-};
-
-#ifdef CONFIG_WILINK_PLATFORM_DATA
-
-int wl1251_set_platform_data(const struct wl1251_platform_data *data);
-
-struct wl1251_platform_data *wl1251_get_platform_data(void);
-
-#else
-
-static inline
-int wl1251_set_platform_data(const struct wl1251_platform_data *data)
-{
-	return -ENOSYS;
-}
-
-static inline
-struct wl1251_platform_data *wl1251_get_platform_data(void)
-{
-	return ERR_PTR(-ENODATA);
-}
-
-#endif
-
-#endif
-- 
2.38.1.431.g37b22c650d-goog

