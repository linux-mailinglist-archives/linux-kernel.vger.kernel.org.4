Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7468D892
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjBGNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjBGNKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:10:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745543A5B8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:10:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso13121176wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs0D/uL734o+xZJ1+R+eowXhinuSgJTcIA+zKAafmzQ=;
        b=ERG5E/37F6FKQsGTyQsxN9KcFtI0nFxQLC3D7yR48cKsyBip781TV32hE8UwbMuZu4
         cWQtyMfBPXflRE/x9iSNK1/SE/3iD0SKINAClMeo7DhJ6rGOJ40b2QN69SFoDH3s1dml
         2dB0pMvB5A5LI5C13oXVSErxPCmadVkE5HG0bJc0aCTYQrsfaS5jDzJxKmBJ1EdhuetU
         KlqUqkjw8GEswd9CpfgwFaJWMaZJTzXHFJgOQincd7LdfhebfMnrlKRybg9d+8DcBVBm
         k1Smv2U6p9tZbkizAv97ZlgnwwD30MUEwg2LnGyIzAZH2Vs6jcPHCzjfmACQR5koRzS0
         94Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs0D/uL734o+xZJ1+R+eowXhinuSgJTcIA+zKAafmzQ=;
        b=oVS5QpxdpyB5To9CvO4UvvilyWPXCiJDi6wIOctKNYkL8MMTnHpi62ESJ9/KWPJLGS
         9jCv9CRli+KxO7vO3SbDgbjq2fs7NacpIhSXS2fVNe3yZ5uEI4PZlJX4nNIxiyx8r704
         /htib6jAgc6T02bEyVyrJqsGu6sbDtXZmXLi5Wu7bm6QW600PSKuc2cS+zIZgyP9OAuC
         HKJXpJhKrR/VB7wvKtTKsyzmyIZOWUexi8nTFsR//aNiaRzDrj4glgkk6aC5DsNYXYvv
         Ia8GQbFN6JiK+ZtjJhJtihO1CnFdMTW9h6NuDxqzItqpEvxCB40GBHvolZs23oE1ov6C
         lLXw==
X-Gm-Message-State: AO0yUKXiGgVDfNpdrECPs3csmvzL7s2yZqnXkcFROxgOyH3WWxOqksfk
        zjUMrY2oHFmtCf7o9cAMClTPKg==
X-Google-Smtp-Source: AK7set+VqjfHILD76dsrZPIh515FQCoP7zav5wehXlO/DGG3kLRpXd3uhj+9P7NS2nhBhIRqSLcLkg==
X-Received: by 2002:a05:600c:2a08:b0:3db:1d7e:c429 with SMTP id w8-20020a05600c2a0800b003db1d7ec429mr2979363wme.40.1675775401698;
        Tue, 07 Feb 2023 05:10:01 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id g24-20020a7bc4d8000000b003df30c94850sm17987385wmk.25.2023.02.07.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:10:01 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v13 1/6] thermal: drivers: mediatek: Relocate driver to mediatek folder
Date:   Tue,  7 Feb 2023 14:09:53 +0100
Message-Id: <20230207130958.608305-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207130958.608305-1-bchihi@baylibre.com>
References: <20230207130958.608305-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add MediaTek proprietary folder to upstream more thermal zone and cooler
drivers, relocate the original thermal controller driver to it, and rename it
as "auxadc_thermal.c" to show its purpose more clearly.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/Kconfig                       | 14 ++++---------
 drivers/thermal/Makefile                      |  2 +-
 drivers/thermal/mediatek/Kconfig              | 21 +++++++++++++++++++
 drivers/thermal/mediatek/Makefile             |  1 +
 .../auxadc_thermal.c}                         |  2 +-
 5 files changed, 28 insertions(+), 12 deletions(-)
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..d35f63daca3b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -412,16 +412,10 @@ config DA9062_THERMAL
 	  zone.
 	  Compatible with the DA9062 and DA9061 PMICs.
 
-config MTK_THERMAL
-	tristate "Temperature sensor driver for mediatek SoCs"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on NVMEM || NVMEM=n
-	depends on RESET_CONTROLLER
-	default y
-	help
-	  Enable this option if you want to have support for thermal management
-	  controller present in Mediatek SoCs
+menu "Mediatek thermal drivers"
+depends on ARCH_MEDIATEK || COMPILE_TEST
+source "drivers/thermal/mediatek/Kconfig"
+endmenu
 
 config AMLOGIC_THERMAL
 	tristate "Amlogic Thermal Support"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..766ce38ff4f3 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -55,7 +55,7 @@ obj-y				+= st/
 obj-y				+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
-obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-y				+= mediatek/
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
new file mode 100644
index 000000000000..7558a847d4e9
--- /dev/null
+++ b/drivers/thermal/mediatek/Kconfig
@@ -0,0 +1,21 @@
+config MTK_THERMAL
+	tristate "MediaTek thermal drivers"
+	depends on THERMAL_OF
+	help
+	  This is the option for MediaTek thermal software solutions.
+	  Please enable corresponding options to get temperature
+	  information from thermal sensors or turn on throttle
+	  mechaisms for thermal mitigation.
+
+if MTK_THERMAL
+
+config MTK_SOC_THERMAL
+	tristate "AUXADC temperature sensor driver for MediaTek SoCs"
+	depends on HAS_IOMEM
+	help
+	  Enable this option if you want to get SoC temperature
+	  information for MediaTek platforms.
+	  This driver configures thermal controllers to collect
+	  temperature via AUXADC interface.
+
+endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
new file mode 100644
index 000000000000..53e86e30b26f
--- /dev/null
+++ b/drivers/thermal/mediatek/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTK_SOC_THERMAL)	+= auxadc_thermal.o
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
similarity index 99%
rename from drivers/thermal/mtk_thermal.c
rename to drivers/thermal/mediatek/auxadc_thermal.c
index 8440692e3890..b4ef57fa9183 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -23,7 +23,7 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
-#include "thermal_hwmon.h"
+#include "../thermal_hwmon.h"
 
 /* AUXADC Registers */
 #define AUXADC_CON1_SET_V	0x008
-- 
2.34.1

