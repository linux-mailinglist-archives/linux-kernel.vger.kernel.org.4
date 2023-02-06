Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0868C21F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBFPrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBFPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:47:30 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D72B0BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:47:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p26so35304890ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7HjN4TzQBq2ZZA76IO3M8MJUDcxOHaJ2gZPxRuGZEM=;
        b=lBPxmxlGU8fXgZEHTO0EE4dPwW1BhWuWnRA1kq0u1rwRukE654nexeKjDe8i554Nb5
         /FqT7ZDXOA9tpzoFofMgM1evs8OaLAh9gOqtxXNDvjkflbB7L9t9ycnkEceeas6BY/4T
         xPBarlNgk0miyUUsa7afXR8FsMDAAvsfZfkZ5/bX71oYYx7QYE6TxT92vb84nlHoTpiy
         EhSsE5c7Mzk0THZ8+CaIQoH+w+RAK2i9kLYtygveAs4CNWPaHlq5codHe2FkuxZVTst2
         4FFA0Odfv/klllyfbBxj6OYya8S5erlP9Td1/h4blF9Y2FCVAew913DqNGNgJQIN5SNb
         Rjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7HjN4TzQBq2ZZA76IO3M8MJUDcxOHaJ2gZPxRuGZEM=;
        b=fYaM2q2FlDP0eUlWAg/PiJJpe8raC+SpaL1vPFjtePJTB0+Sse5mDp45qYLfz8Lb2N
         CkOFr6V4u03M4g3qjsmAb+a6k4gJCLUMhLPpGl6RnbwySDtL38KBPDjPIfylqS1CC7rt
         d/dw9+JR27EV8aYFYN4LM54kni8rpQ0lHCoEzSacNp3/vPzdrywUGDt9m1CbvuEiHPyn
         Cl7GxL5vJOqk4jikYCnCJhp/aEaiisN5wzqz7uYmI8288vl6fOCGygi8SgJISIM609lY
         MyvIatPxu3j3IAm3L6RWCrFc2v2qlQynAMV5FK+7ohPVldIdfLK/Da46RK3Nm54CetBI
         ZKxw==
X-Gm-Message-State: AO0yUKVsN5bPINeHR3gUulROgYrg59FmXulFC5WWFymYbNRYeMcZp3Ct
        urHeungKlGOmAFxuS2Etz36Xu3l0LCrX6iZm
X-Google-Smtp-Source: AK7set9mPQd0MhkTQkAz8wEqWB2fDfP1ODpQprC+1QK0YualSEn/XjJWrwROk16wMPdL1WpD4j4sHw==
X-Received: by 2002:adf:cc84:0:b0:2c3:e5d5:5d77 with SMTP id p4-20020adfcc84000000b002c3e5d55d77mr5118903wrj.68.1675697688552;
        Mon, 06 Feb 2023 07:34:48 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5084000000b002c3db0eec5fsm7386805wrt.62.2023.02.06.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 07:34:48 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS),
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH] thermal: Remove core header inclusion from drivers
Date:   Mon,  6 Feb 2023 16:34:29 +0100
Message-Id: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the name states "thermal_core.h" is the header file for the core
components of the thermal framework.

Too many drivers are including it. Hopefully the recent cleanups
helped to self encapsulate the code a bit more and prevented the
drivers to need this header.

Remove this inclusion in every place where it is possible.

Some other drivers did a confusion with the core header and the one
exported in linux/thermal.h. They include the former instead of the
latter. The changes also fix this.

The tegra/soctherm driver still remains as it uses an internal
function which need to be replaced.

The Intel HFI driver uses the netlink internal framework core and
should be changed to prevent to deal with the internals.

No functional changes

[ Applies to thermal/linux-next or linux-pm/linux-next ]

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/amlogic_thermal.c           | 1 -
 drivers/thermal/armada_thermal.c            | 2 --
 drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -
 drivers/thermal/hisi_thermal.c              | 3 +--
 drivers/thermal/imx8mm_thermal.c            | 1 -
 drivers/thermal/imx_sc_thermal.c            | 1 -
 drivers/thermal/intel/intel_hfi.c           | 3 ++-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
 drivers/thermal/qoriq_thermal.c             | 1 -
 drivers/thermal/rcar_gen3_thermal.c         | 1 -
 drivers/thermal/samsung/exynos_tmu.c        | 3 +--
 drivers/thermal/st/stm_thermal.c            | 1 -
 drivers/thermal/tegra/tegra30-tsensor.c     | 1 -
 drivers/thermal/uniphier_thermal.c          | 2 --
 14 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index d30cb791e63c..9235fda4ec1e 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -28,7 +28,6 @@
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 
-#include "thermal_core.h"
 #include "thermal_hwmon.h"
 
 #define TSENSOR_CFG_REG1			0x4
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 83a4080bffc7..36653f692c80 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -19,8 +19,6 @@
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
 
-#include "thermal_core.h"
-
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
 #define PMU_TM_DISABLE_OFFS		0
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 3d0710c6e004..23918bb76ae6 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
-#include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
 #define BCM2835_TS_TSENSCTL			0x00
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 45226cab466e..62c67942293e 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -16,8 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
-
-#include "thermal_core.h"
+#include <linux/thermal.h>
 
 #define HI6220_TEMP0_LAG			(0x0)
 #define HI6220_TEMP0_TH				(0x4)
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index d247b48696cb..72b5d6f319c1 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#include "thermal_core.h"
 #include "thermal_hwmon.h"
 
 #define TER			0x0	/* TMU enable */
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 378f574607f7..f32e59e74623 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#include "thermal_core.h"
 #include "thermal_hwmon.h"
 
 #define IMX_SC_MISC_FUNC_GET_TEMP	13
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 6e604bda2b93..c69db6c90869 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -40,10 +40,11 @@
 
 #include <asm/msr.h>
 
-#include "../thermal_core.h"
 #include "intel_hfi.h"
 #include "thermal_interrupt.h"
 
+#include "../thermal_netlink.h"
+
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
 #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index e2429676d0d2..101c75d0e13f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -15,7 +15,6 @@
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 
-#include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
 #define QPNP_TM_REG_DIG_MAJOR		0x01
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d111e218f362..431c29c0898a 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -13,7 +13,6 @@
 #include <linux/thermal.h>
 #include <linux/units.h>
 
-#include "thermal_core.h"
 #include "thermal_hwmon.h"
 
 #define SITES_MAX		16
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 4ef927437842..0fd2fd077638 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -17,7 +17,6 @@
 #include <linux/sys_soc.h>
 #include <linux/thermal.h>
 
-#include "thermal_core.h"
 #include "thermal_hwmon.h"
 
 /* Register offsets */
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 37465af59262..527d1eb0663a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -20,11 +20,10 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/thermal.h>
 
 #include <dt-bindings/thermal/thermal_exynos.h>
 
-#include "../thermal_core.h"
-
 /* Exynos generic registers */
 #define EXYNOS_TMU_REG_TRIMINFO		0x0
 #define EXYNOS_TMU_REG_CONTROL		0x20
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index e7834ccc7976..735401958f01 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -19,7 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
-#include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
 /* DTS register offsets */
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 0ffe37ce7df7..b3218b71b6d9 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -28,7 +28,6 @@
 
 #include <soc/tegra/fuse.h>
 
-#include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
 #define TSENSOR_SENSOR0_CONFIG0				0x0
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index f8ab2ca76184..47801841b3f5 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -17,8 +17,6 @@
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 
-#include "thermal_core.h"
-
 /*
  * block registers
  * addresses are the offset from .block_base
-- 
2.34.1

