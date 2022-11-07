Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516F961FB61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiKGR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiKGR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:29:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE1D2DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:29:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so7328988wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUX5wkpwN8zL5/uJRNeccKjsPP/B2qlR2/KDWqYNiM4=;
        b=pqBGiTYfcBFJqNr8tDtfWk3jvCGI5s9YXawmOSInZi0O2sGpowSdPmdVW1uE+rrVEL
         iS9VUEaVAbYwLuAICHDfodGZW2L/AyLEGdrKT79VdSMjbPQ9qT4c6GZUEKHc/ObyGWtn
         N8MBrpnGlJMFfZYGgxzALB69EKAS2OANUDnd/6kYNV3/nDrqkdL5UWoVSVUCU63aAc28
         V+JtzHNVPyDzPyOyvSXOh4bVrt+AZ5Dk1IT/mdb5ct5z0m+VJxMdq8alt+8bowuFD/WZ
         ikimyF29gtPWuGSRn8qpkRIL+mZD5tAuEGnLD9na9uyptOLzsb4AuazWFj65BeqWKckQ
         /AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUX5wkpwN8zL5/uJRNeccKjsPP/B2qlR2/KDWqYNiM4=;
        b=mBuMBnlIrjapeJ0VQlOqQRVXl/CjI4S3RsCesRfiu87tJn4RVJkccZ9/QJzFrn+H26
         q87OYGOWD443nZ8pxZ+lweBZENBZ654ZheoI06FF9CJIZfwAf314831YzdiHMcfDzVCW
         qhwjJLQjaEeEfgUmsXeXHD1/6rz0DmJRxkdb3IhojBHt25Z7tKzdmMGKFCw+Ic/9JiSH
         6IlLila91DzncPoM1li5Y5MiqimlsNOYavzI1hGxOEiEfK6bzC28CnKRsPIS2FxXZ6q4
         qXmOKJgYh+meO7+CeiAJ3NbFrB3Q1UtqdIF/PpiBcMiGQUqvVz69LIBIfw7+G3MnY/B0
         yNwg==
X-Gm-Message-State: ACrzQf0BkYOf+repEbJGbhQevxm9IaePnqR33t31/79RfM3ObcRRpicy
        VfElzX92i15sAou0Lr+PLytv9w==
X-Google-Smtp-Source: AMsMyM72ZA74Klabcot79eR9g6E6J0hISSevIALy9nqeZDI3ZDeP022Nmnolf/O6XSc8Req1nxdSbw==
X-Received: by 2002:a05:600c:818:b0:3cf:7385:7609 with SMTP id k24-20020a05600c081800b003cf73857609mr28177045wmp.186.1667842176333;
        Mon, 07 Nov 2022 09:29:36 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:9e3a:7162:292d:1065])
        by smtp.gmail.com with ESMTPSA id n1-20020a1ca401000000b003cf66a2d433sm11831751wme.33.2022.11.07.09.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:29:35 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     j-keerthy@ti.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v2] gpio: davinci: add support of module build
Date:   Mon,  7 Nov 2022 18:29:21 +0100
Message-Id: <20221107172921.514125-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Added module build support for the davinci gpio driver

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
v1->v2:
Keep postcore_initcall() instead of using module_init() 

 drivers/gpio/Kconfig        |  2 +-
 drivers/gpio/gpio-davinci.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a01af1180616..f8bace51c2d0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -219,7 +219,7 @@ config GPIO_CLPS711X
 	  Say yes here to support GPIO on CLPS711X SoCs.
 
 config GPIO_DAVINCI
-	bool "TI Davinci/Keystone GPIO support"
+	tristate "TI Davinci/Keystone GPIO support"
 	default y if ARCH_DAVINCI
 	depends on (ARM || ARM64) && (ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_K3)
 	help
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 59c4c48d8296..5ddac03dac8a 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -730,3 +730,14 @@ static int __init davinci_gpio_drv_reg(void)
 	return platform_driver_register(&davinci_gpio_driver);
 }
 postcore_initcall(davinci_gpio_drv_reg);
+
+static void __exit davinci_gpio_exit(void)
+{
+	platform_driver_unregister(&davinci_gpio_driver);
+}
+module_exit(davinci_gpio_exit);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("DAVINCI GPIO driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gpio-davinci");
-- 
2.25.1

