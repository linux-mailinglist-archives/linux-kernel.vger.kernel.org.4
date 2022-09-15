Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276A5B9C72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiION5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiION46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:56:58 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128199B6E;
        Thu, 15 Sep 2022 06:56:56 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FAnXa1009079;
        Thu, 15 Sep 2022 15:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=1Xm/mfoQjs1H/EX/Br7susGlvvak70eEpiGUWaULtQU=;
 b=TqitLs880FwJU4yGQ5USqr3c+vMhe6zgBdY35jiE/g3x1l5RXTTxmQBCLdB55n0N6IM1
 ei/Cd969hHwbmY/lSBW9r6RakPOY8fuIYEGwvrMC5T39k8A6YIxI/iWSKWi1o5eXwkJr
 XTRJIYAh3ya/KjwrcDG+XxgfIa1tU5Guv4cMlg7a592mcjQ2Pi7rnQT+tS/j+dvy9gnO
 BsWR/XgNWv4pQoe+/TkloMMJHCJSIlIGKXVdibYkS092apXUwwhCUERQakIRCCxaa+kQ
 nMRY3KKAA4bkj1AjU3IG/jBGSw+9z7fOrYAtB8X76KUwCaVvtAqMrZM01ZfzVDdTTf/k Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jjxxawq6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:55:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D4F310002A;
        Thu, 15 Sep 2022 15:55:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3DD0C22FA28;
        Thu, 15 Sep 2022 15:55:55 +0200 (CEST)
Received: from localhost (10.75.127.116) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Thu, 15 Sep
 2022 15:55:55 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/1] iio: adc: stm32-adc: add id registers support
Date:   Thu, 15 Sep 2022 15:54:52 +0200
Message-ID: <20220915135452.1712453-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of identification registers to STM32 ADC.

By default the ADC hardware instance number is retrieved from
the compatible configuration data. Get the available ADC number
per ADC block, from hardware configuration register,
when this register exists.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 59 ++++++++++++++++++++++++++++++--
 drivers/iio/adc/stm32-adc-core.h | 31 +++++++++++++++++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 1ce52af3fe8b..81d5db91c67b 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
@@ -62,6 +63,7 @@ struct stm32_adc_priv;
  * @regs:	common registers for all instances
  * @clk_sel:	clock selection routine
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
+ * @ipid:	adc identification number
  * @has_syscfg: SYSCFG capability flags
  * @num_irqs:	number of interrupt lines
  * @num_adcs:   maximum number of ADC instances in the common registers
@@ -70,6 +72,7 @@ struct stm32_adc_priv_cfg {
 	const struct stm32_adc_common_regs *regs;
 	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
 	u32 max_clk_rate_hz;
+	u32 ipid;
 	unsigned int has_syscfg;
 	unsigned int num_irqs;
 	unsigned int num_adcs;
@@ -78,6 +81,7 @@ struct stm32_adc_priv_cfg {
 /**
  * struct stm32_adc_priv - stm32 ADC core private data
  * @irq:		irq(s) for ADC block
+ * @nb_adc_max:		actual maximum number of instance per ADC block
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
  * @bclk:		bus clock common for all ADCs, depends on part used
@@ -95,6 +99,7 @@ struct stm32_adc_priv_cfg {
  */
 struct stm32_adc_priv {
 	int				irq[STM32_ADC_MAX_ADCS];
+	unsigned int			nb_adc_max;
 	struct irq_domain		*domain;
 	struct clk			*aclk;
 	struct clk			*bclk;
@@ -354,7 +359,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
 	 * before invoking the interrupt handler (e.g. call ISR only for
 	 * IRQ-enabled ADCs).
 	 */
-	for (i = 0; i < priv->cfg->num_adcs; i++) {
+	for (i = 0; i < priv->nb_adc_max; i++) {
 		if ((status & priv->cfg->regs->eoc_msk[i] &&
 		     stm32_adc_eoc_enabled(priv, i)) ||
 		     (status & priv->cfg->regs->ovr_msk[i]))
@@ -424,7 +429,7 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 	int hwirq;
 	unsigned int i;
 
-	for (hwirq = 0; hwirq < STM32_ADC_MAX_ADCS; hwirq++)
+	for (hwirq = 0; hwirq < priv->nb_adc_max; hwirq++)
 		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
 	irq_domain_remove(priv->domain);
 
@@ -642,6 +647,49 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 	return 0;
 }
 
+static int stm32_adc_probe_identification(struct platform_device *pdev,
+					  struct stm32_adc_priv *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	const char *compat;
+	int ret, count = 0;
+	u32 id, val;
+
+	if (!priv->cfg->ipid)
+		return 0;
+
+	id = FIELD_GET(STM32MP1_IPIDR_MASK,
+		       readl_relaxed(priv->common.base + STM32MP1_ADC_IPDR));
+	if (id != priv->cfg->ipid) {
+		dev_err(&pdev->dev, "Unexpected IP version: 0x%x", id);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(np, child) {
+		ret = of_property_read_string(child, "compatible", &compat);
+		if (ret)
+			continue;
+		/* Count child nodes with stm32 adc compatible */
+		if (strstr(compat, "st,stm32") && strstr(compat, "adc"))
+			count++;
+	}
+
+	val = readl_relaxed(priv->common.base + STM32MP1_ADC_HWCFGR0);
+	priv->nb_adc_max = FIELD_GET(STM32MP1_ADCNUM_MASK, val);
+	if (count > priv->nb_adc_max) {
+		dev_err(&pdev->dev, "Unexpected child number: %d", count);
+		return -EINVAL;
+	}
+
+	val = readl_relaxed(priv->common.base + STM32MP1_ADC_VERR);
+	dev_dbg(&pdev->dev, "ADC version: %lu.%lu\n",
+		FIELD_GET(STM32MP1_MAJREV_MASK, val),
+		FIELD_GET(STM32MP1_MINREV_MASK, val));
+
+	return 0;
+}
+
 static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct stm32_adc_priv *priv;
@@ -661,6 +709,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	priv->cfg = (const struct stm32_adc_priv_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
+	priv->nb_adc_max = priv->cfg->num_adcs;
 	spin_lock_init(&priv->common.lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -703,6 +752,10 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_stop;
 
+	ret = stm32_adc_probe_identification(pdev, priv);
+	if (ret < 0)
+		goto err_hw_stop;
+
 	ret = regulator_get_voltage(priv->vref);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
@@ -811,8 +864,8 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.clk_sel = stm32h7_adc_clk_sel,
 	.max_clk_rate_hz = 36000000,
 	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
+	.ipid = STM32MP15_IPIDR_NUMBER,
 	.num_irqs = 2,
-	.num_adcs = 2,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index faedf7a49555..2118ef63843d 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -24,6 +24,7 @@
  * | 0x300  |         Master & Slave common regs          |
  * --------------------------------------------------------
  */
+/* Maximum ADC instances number per ADC block for all supported SoCs */
 #define STM32_ADC_MAX_ADCS		3
 #define STM32_ADC_OFFSET		0x100
 #define STM32_ADCX_COMN_OFFSET		0x300
@@ -105,6 +106,12 @@
 /* STM32MP1 - ADC2 instance option register */
 #define STM32MP1_ADC2_OR		0xD0
 
+/* STM32MP1 - Identification registers */
+#define STM32MP1_ADC_HWCFGR0		0x3F0
+#define STM32MP1_ADC_VERR		0x3F4
+#define STM32MP1_ADC_IPDR		0x3F8
+#define STM32MP1_ADC_SIDR		0x3FC
+
 /* STM32H7 - common registers for all ADC instances */
 #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
 #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
@@ -181,6 +188,30 @@ enum stm32h7_adc_dmngt {
 /* STM32MP1_ADC2_OR - bit fields */
 #define STM32MP1_VDDCOREEN		BIT(0)
 
+/* STM32MP1_ADC_HWCFGR0 - bit fields */
+#define STM32MP1_ADCNUM_SHIFT		0
+#define STM32MP1_ADCNUM_MASK		GENMASK(3, 0)
+#define STM32MP1_MULPIPE_SHIFT		4
+#define STM32MP1_MULPIPE_MASK		GENMASK(7, 4)
+#define STM32MP1_OPBITS_SHIFT		8
+#define STM32MP1_OPBITS_MASK		GENMASK(11, 8)
+#define STM32MP1_IDLEVALUE_SHIFT	12
+#define STM32MP1_IDLEVALUE_MASK	GENMASK(15, 12)
+
+/* STM32MP1_ADC_VERR - bit fields */
+#define STM32MP1_MINREV_SHIFT		0
+#define STM32MP1_MINREV_MASK		GENMASK(3, 0)
+#define STM32MP1_MAJREV_SHIFT		4
+#define STM32MP1_MAJREV_MASK		GENMASK(7, 4)
+
+/* STM32MP1_ADC_IPDR - bit fields */
+#define STM32MP1_IPIDR_MASK		GENMASK(31, 0)
+
+/* STM32MP1_ADC_SIDR - bit fields */
+#define STM32MP1_SIDR_MASK		GENMASK(31, 0)
+
+#define STM32MP15_IPIDR_NUMBER		0x00110005
+
 /**
  * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
  * @base:		control registers base cpu addr
-- 
2.25.1

