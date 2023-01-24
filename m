Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A167990A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjAXNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjAXNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:17:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F445229
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:17:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b7so13858831wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbG1VUJ5DCdqW4qKVLb28pqzoz5xr35SQ4g7vLEm4Sc=;
        b=HsOffWvbDcnd8huZicXYTVp9PMK8+3GkWV2bBS5qYnTquiZs31oZwtOKNKAy/6glna
         8o+xXHmjVyzolHN/kgsLTeYTbuBjNaLlCSgPpYUvtTSIWVfhW1namk40gwYLUobxKjW9
         UfvUBp9efU2T9WYYTOfNZWmR1+NtEmvuCCWiHgUuBe+c1Q3SWHLBlsydRY30F+gJsYi8
         I5QWwyEW71KvhVNTkQL866BNUy/40BEszqzOoqctwLUx0gbhlO4j71Nt13RJcGVBlx03
         +ctMyO32o8ihiZtw7LAl5UKYG4vteM3kvHye6waXxNjfcPO3rBQ4yq+XlfJJGZf76QEd
         IAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbG1VUJ5DCdqW4qKVLb28pqzoz5xr35SQ4g7vLEm4Sc=;
        b=klCKxFlSCBL7dzGiBcq/ExC9Cvo4QR95K2tjwFJl2uho2dxKtWqUbNoGb8ntIk9UQM
         u+aRDtRiknG4BeraKC76oS9Y5M6llD+BnRrDtDbJ/99WyPZqZaMWlR8lQIQJQ6+kUE1x
         HldMjG1n50EzmO+9ZHBUEVlCKGBvpyuzrBqbfeKoUgiLeMbzXFV7ZEWJ3efA3/tW+EIX
         RpY+sceEGnomkTZiwa/r8LW5QNfCj2YjKdXCZG8zzj+9S6s3K6ENvnIdBHoI+sT6gjQG
         4Sf+7S5FC1xYrzLRhSED1g4Uc9M1k+fHr/DKIXI/W1ZWGlBR/AOL8N6KNnBGhEL4c1PO
         ZSlA==
X-Gm-Message-State: AO0yUKUhsKU1jabMFKY9dVJiIlORjBr49Yoru9ymzfp8Zi/+7ZvQSdm4
        PHofw40zMocgbgkksNeqlgW6uA==
X-Google-Smtp-Source: AK7set+vEkto6LwyUQvRQPih1O8ez4C6gcSMIx1VwLi+U88x8djEiit6DYvHKH0C0Knqxm0WgdJCbQ==
X-Received: by 2002:a05:6000:5:b0:2bf:ae2f:c6ff with SMTP id h5-20020a056000000500b002bfae2fc6ffmr2466799wrx.31.1674566238435;
        Tue, 24 Jan 2023 05:17:18 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfb5ebf8cfsm49427wrp.21.2023.01.24.05.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:17:18 -0800 (PST)
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
Subject: [PATCH v11 1/6] thermal/drivers/mediatek: Relocate driver to mediatek folder
Date:   Tue, 24 Jan 2023 14:17:12 +0100
Message-Id: <20230124131717.128660-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124131717.128660-1-bchihi@baylibre.com>
References: <20230124131717.128660-1-bchihi@baylibre.com>
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

From: Balsam CHIHI <bchihi@baylibre.com>

Add MediaTek proprietary folder to upstream more thermal zone and cooler
drivers, relocate the original thermal controller driver to it, and rename it
as "auxadc_thermal.c" to show its purpose more clearly.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
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
index eaeb2b2ee6e9..4cd7ab707315 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -416,16 +416,10 @@ config DA9062_THERMAL
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
index 60f0dfa9aae2..1c460d189bd7 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -56,7 +56,7 @@ obj-y				+= st/
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
index 9a8b107900e9..90ae6b5c530e 100644
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

