Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79065EB27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjAEMzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjAEMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:54:43 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EEE559CF;
        Thu,  5 Jan 2023 04:54:33 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305B7nRe015126;
        Thu, 5 Jan 2023 13:54:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=8xduQMbbSau/9M7iwwoKlhDQaquknObaYj5Sigtc8qQ=;
 b=ctkrOS6fXWLF9fF6B3OqDbbMmyl9AgDvoOtmuXe8DBN9gqFXABx1ZprKJmxU1t3jxWhf
 qHt5JE7Vw7IaKc4Tw90so9xhNB51932NB5wIAZA9nZtP92O4vibcgv3MgaTYHuVyh1af
 zHI3P7km1r/Zwj94dgHGC3FS58aGGYz4EC5H7a8TjtaoFExA/jLedlmBS7Zvo8PuUDn9
 YdGYf8djWYjZ6vgXwl0twy//imIFqANRAz6ZIHBYY7aCgfx9z8tgdgIbNfcjF0db+VRf
 +fjycuTHJgo1yBAH84Ys+/OkPcg/Dv/y6zbe2A5bZA2KuD+cvEKapG5BG8kYQqMZaoNe 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtbcq92ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 13:54:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5DE1B10002A;
        Thu,  5 Jan 2023 13:54:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 567BF237D6D;
        Thu,  5 Jan 2023 13:54:05 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 5 Jan
 2023 13:54:05 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: stm32-dfsdm: add id registers support
Date:   Thu, 5 Jan 2023 13:53:30 +0100
Message-ID: <20230105125331.328275-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of identification registers to STM32 DFSDM
to allow hardware capabilities discovery and configuration check.
The number of filters and channels, are read from registers,
when they are available.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
Changes in v2:
- Add and update comments
- Remove useless masks
---
 drivers/iio/adc/stm32-dfsdm-core.c | 99 +++++++++++++++++++++++++-----
 drivers/iio/adc/stm32-dfsdm.h      | 64 +++++++++++++------
 2 files changed, 128 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index a3d4de6ba4c2..0362df285a57 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -6,6 +6,7 @@
  * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -19,7 +20,15 @@
 
 #include "stm32-dfsdm.h"
 
+/**
+ * struct stm32_dfsdm_dev_data - DFSDM compatible configuration data
+ * @ipid: DFSDM identification number. Used only if hardware provides identification registers
+ * @num_filters: DFSDM number of filters. Unused if identification registers are available
+ * @num_channels: DFSDM number of channels. Unused if identification registers are available
+ * @regmap_cfg: SAI register map configuration pointer
+ */
 struct stm32_dfsdm_dev_data {
+	u32 ipid;
 	unsigned int num_filters;
 	unsigned int num_channels;
 	const struct regmap_config *regmap_cfg;
@@ -27,8 +36,6 @@ struct stm32_dfsdm_dev_data {
 
 #define STM32H7_DFSDM_NUM_FILTERS	4
 #define STM32H7_DFSDM_NUM_CHANNELS	8
-#define STM32MP1_DFSDM_NUM_FILTERS	6
-#define STM32MP1_DFSDM_NUM_CHANNELS	8
 
 static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
 {
@@ -75,8 +82,7 @@ static const struct regmap_config stm32mp1_dfsdm_regmap_cfg = {
 };
 
 static const struct stm32_dfsdm_dev_data stm32mp1_dfsdm_data = {
-	.num_filters = STM32MP1_DFSDM_NUM_FILTERS,
-	.num_channels = STM32MP1_DFSDM_NUM_CHANNELS,
+	.ipid = STM32MP15_IPIDR_NUMBER,
 	.regmap_cfg = &stm32mp1_dfsdm_regmap_cfg,
 };
 
@@ -295,6 +301,65 @@ static const struct of_device_id stm32_dfsdm_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 
+static int stm32_dfsdm_probe_identification(struct platform_device *pdev,
+					    struct dfsdm_priv *priv,
+					    const struct stm32_dfsdm_dev_data *dev_data)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	struct stm32_dfsdm *dfsdm = &priv->dfsdm;
+	const char *compat;
+	int ret, count = 0;
+	u32 id, val;
+
+	if (!dev_data->ipid) {
+		dfsdm->num_fls = dev_data->num_filters;
+		dfsdm->num_chs = dev_data->num_channels;
+		return 0;
+	}
+
+	ret = regmap_read(dfsdm->regmap, DFSDM_IPIDR, &id);
+	if (ret)
+		return ret;
+
+	if (id != dev_data->ipid) {
+		dev_err(&pdev->dev, "Unexpected IP version: 0x%x", id);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(np, child) {
+		ret = of_property_read_string(child, "compatible", &compat);
+		if (ret)
+			continue;
+		/* Count only child nodes with dfsdm compatible */
+		if (strstr(compat, "dfsdm"))
+			count++;
+	}
+
+	ret = regmap_read(dfsdm->regmap, DFSDM_HWCFGR, &val);
+	if (ret)
+		return ret;
+
+	dfsdm->num_fls = FIELD_GET(DFSDM_HWCFGR_NBF_MASK, val);
+	dfsdm->num_chs = FIELD_GET(DFSDM_HWCFGR_NBT_MASK, val);
+
+	if (count > dfsdm->num_fls) {
+		dev_err(&pdev->dev, "Unexpected child number: %d", count);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(dfsdm->regmap, DFSDM_VERR, &val);
+	if (ret)
+		return ret;
+
+	dev_dbg(&pdev->dev, "DFSDM version: %lu.%lu. %d channels/%d filters\n",
+		FIELD_GET(DFSDM_VERR_MAJREV_MASK, val),
+		FIELD_GET(DFSDM_VERR_MINREV_MASK, val),
+		dfsdm->num_chs, dfsdm->num_fls);
+
+	return 0;
+}
+
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
@@ -311,18 +376,6 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 	dev_data = of_device_get_match_data(&pdev->dev);
 
 	dfsdm = &priv->dfsdm;
-	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dev_data->num_filters,
-				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
-	if (!dfsdm->fl_list)
-		return -ENOMEM;
-
-	dfsdm->num_fls = dev_data->num_filters;
-	dfsdm->ch_list = devm_kcalloc(&pdev->dev, dev_data->num_channels,
-				      sizeof(*dfsdm->ch_list),
-				      GFP_KERNEL);
-	if (!dfsdm->ch_list)
-		return -ENOMEM;
-	dfsdm->num_chs = dev_data->num_channels;
 
 	ret = stm32_dfsdm_parse_of(pdev, priv);
 	if (ret < 0)
@@ -338,6 +391,20 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = stm32_dfsdm_probe_identification(pdev, priv, dev_data);
+	if (ret < 0)
+		return ret;
+
+	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dfsdm->num_fls,
+				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
+	if (!dfsdm->fl_list)
+		return -ENOMEM;
+
+	dfsdm->ch_list = devm_kcalloc(&pdev->dev, dfsdm->num_chs,
+				      sizeof(*dfsdm->ch_list), GFP_KERNEL);
+	if (!dfsdm->ch_list)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, dfsdm);
 
 	ret = stm32_dfsdm_clk_prepare_enable(dfsdm);
diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
index 4afc1f528b78..b64cfb42c549 100644
--- a/drivers/iio/adc/stm32-dfsdm.h
+++ b/drivers/iio/adc/stm32-dfsdm.h
@@ -13,25 +13,29 @@
 
 /*
  * STM32 DFSDM - global register map
- * ________________________________________________________
- * | Offset |                 Registers block             |
- * --------------------------------------------------------
- * | 0x000  |      CHANNEL 0 + COMMON CHANNEL FIELDS      |
- * --------------------------------------------------------
- * | 0x020  |                CHANNEL 1                    |
- * --------------------------------------------------------
- * | ...    |                .....                        |
- * --------------------------------------------------------
- * | 0x0E0  |                CHANNEL 7                    |
- * --------------------------------------------------------
- * | 0x100  |      FILTER  0 + COMMON  FILTER FIELDs      |
- * --------------------------------------------------------
- * | 0x200  |                FILTER  1                    |
- * --------------------------------------------------------
- * | 0x300  |                FILTER  2                    |
- * --------------------------------------------------------
- * | 0x400  |                FILTER  3                    |
- * --------------------------------------------------------
+ * __________________________________________________________
+ * | Offset    |             Registers block                |
+ * ----------------------------------------------------------
+ * | 0x000     |      CHANNEL 0 + COMMON CHANNEL FIELDS     |
+ * ----------------------------------------------------------
+ * | 0x020     |                CHANNEL 1                   |
+ * ----------------------------------------------------------
+ * | ...       |                 .....                      |
+ * ----------------------------------------------------------
+ * | 0x20 x n  |                CHANNEL n                   |
+ * ----------------------------------------------------------
+ * | 0x100     |      FILTER  0 + COMMON FILTER FIELDs      |
+ * ----------------------------------------------------------
+ * | 0x200     |                FILTER  1                   |
+ * ----------------------------------------------------------
+ * |           |                 .....                      |
+ * ----------------------------------------------------------
+ * | 0x100 x m |                FILTER  m                   |
+ * ----------------------------------------------------------
+ * |           |                 .....                      |
+ * ----------------------------------------------------------
+ * | 0x7F0-7FC |         Identification registers           |
+ * ----------------------------------------------------------
  */
 
 /*
@@ -231,6 +235,28 @@
 #define DFSDM_AWCFR_AWHTF_MASK	GENMASK(15, 8)
 #define DFSDM_AWCFR_AWHTF(v)	FIELD_PREP(DFSDM_AWCFR_AWHTF_MASK, v)
 
+/*
+ * Identification register definitions
+ */
+#define DFSDM_HWCFGR		0x7F0
+#define DFSDM_VERR		0x7F4
+#define DFSDM_IPIDR		0x7F8
+#define DFSDM_SIDR		0x7FC
+
+/* HWCFGR: Hardware configuration register */
+#define DFSDM_HWCFGR_NBT_SHIFT	0
+#define DFSDM_HWCFGR_NBT_MASK	GENMASK(7, 0)
+#define DFSDM_HWCFGR_NBF_SHIFT	8
+#define DFSDM_HWCFGR_NBF_MASK	GENMASK(15, 8)
+
+/* VERR: Version register */
+#define DFSDM_VERR_MINREV_SHIFT	0
+#define DFSDM_VERR_MINREV_MASK	GENMASK(3, 0)
+#define DFSDM_VERR_MAJREV_SHIFT	4
+#define DFSDM_VERR_MAJREV_MASK	GENMASK(7, 4)
+
+#define STM32MP15_IPIDR_NUMBER	0x00110031
+
 /* DFSDM filter order  */
 enum stm32_dfsdm_sinc_order {
 	DFSDM_FASTSINC_ORDER, /* FastSinc filter type */
-- 
2.25.1

