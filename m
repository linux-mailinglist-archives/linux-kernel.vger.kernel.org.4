Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719F5EE227
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiI1QnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiI1Qmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:42:50 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF10E10B0;
        Wed, 28 Sep 2022 09:42:43 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SBfi3K020608;
        Wed, 28 Sep 2022 18:41:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=s+jtP4svesW16jc3HLPoLtSIG0T6cKtUpNvYRGfocOo=;
 b=zyejaazzfWLdpy87vv3OTLmhxvDsme4qkn/OXLuaWjKepkCPRaxQyZI6kJ+xVyddU08k
 yZR+xMX9zjg2swttDIkK9+eGP6gH8E7A+REphMJkr3ewGf7OsT3lnst4oLycX+eHjC9R
 Zao3uRk2q9VaUqZvQJiBT+mfu5wOGICZ25KPJ6lYNd8osViguc7Zm9wEBjOlHLeGx+14
 kTxDuaU1vdRQc3Uot6fE6sKtt6aoe776bwi349wV1PodYiNUKbgEBbREoh5J4lHn7QfC
 nv9pPYu3eMIfeGTofEWhOQAlKEbM0sI9sh3MXtXNw5ZxfydcrR5kkcHNHYKMSIAqxLCC Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsqamj87d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 18:41:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2DA810002A;
        Wed, 28 Sep 2022 18:41:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BDA1723C6B2;
        Wed, 28 Sep 2022 18:41:53 +0200 (CEST)
Received: from localhost (10.75.127.118) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 18:41:53 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/8] iio: adc: stm32-adc: add stm32mp13 support
Date:   Wed, 28 Sep 2022 18:41:09 +0200
Message-ID: <20220928164114.48339-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928164114.48339-1-olivier.moysan@foss.st.com>
References: <20220928164114.48339-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 ADC support for STM32MP13x SOCs family.

On STM32MP13x, each ADC peripheral has a single ADC block.
These ADC peripherals, ADC1 and ADC2, are fully independent.
This introduces changes in common registers handling.

Some features such as boost mode, channel preselection and
linear calibration are not supported by the STM32MP13x ADC.
Add diversity management for these features.

The STM32MP13x ADC introduces registers and bitfield variants
on existing features such as calibration factors and internal
channels. Add register diversity management.

Add also support of new internal channels VDDCPU and VDDQ_DDR.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c |  21 +++
 drivers/iio/adc/stm32-adc-core.h |  32 +++++
 drivers/iio/adc/stm32-adc.c      | 212 +++++++++++++++++++++++++++----
 3 files changed, 237 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 81d5db91c67b..6564aa61b595 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -322,6 +322,16 @@ static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
 	.eocie_msk = STM32H7_EOCIE,
 };
 
+/* STM32MP13 common registers definitions */
+static const struct stm32_adc_common_regs stm32mp13_adc_common_regs = {
+	.csr = STM32H7_ADC_CSR,
+	.ccr = STM32H7_ADC_CCR,
+	.eoc_msk = { STM32H7_EOC_MST},
+	.ovr_msk = { STM32H7_OVR_MST},
+	.ier = STM32H7_ADC_IER,
+	.eocie_msk = STM32H7_EOCIE,
+};
+
 static const unsigned int stm32_adc_offset[STM32_ADC_MAX_ADCS] = {
 	0, STM32_ADC_OFFSET, STM32_ADC_OFFSET * 2,
 };
@@ -868,6 +878,14 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.num_irqs = 2,
 };
 
+static const struct stm32_adc_priv_cfg stm32mp13_adc_priv_cfg = {
+	.regs = &stm32mp13_adc_common_regs,
+	.clk_sel = stm32h7_adc_clk_sel,
+	.max_clk_rate_hz = 75000000,
+	.ipid = STM32MP13_IPIDR_NUMBER,
+	.num_irqs = 1,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{
 		.compatible = "st,stm32f4-adc-core",
@@ -878,6 +896,9 @@ static const struct of_device_id stm32_adc_of_match[] = {
 	}, {
 		.compatible = "st,stm32mp1-adc-core",
 		.data = (void *)&stm32mp1_adc_priv_cfg
+	}, {
+		.compatible = "st,stm32mp13-adc-core",
+		.data = (void *)&stm32mp13_adc_priv_cfg
 	}, {
 	},
 };
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 2118ef63843d..658fef4308ac 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -112,6 +112,11 @@
 #define STM32MP1_ADC_IPDR		0x3F8
 #define STM32MP1_ADC_SIDR		0x3FC
 
+/* STM32MP13 - Registers for each ADC instance */
+#define STM32MP13_ADC_DIFSEL		0xB0
+#define STM32MP13_ADC_CALFACT		0xB4
+#define STM32MP13_ADC2_OR		0xC8
+
 /* STM32H7 - common registers for all ADC instances */
 #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
 #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
@@ -161,6 +166,10 @@ enum stm32h7_adc_dmngt {
 	STM32H7_DMNGT_DMA_CIRC,		/* DMA circular mode */
 };
 
+/* STM32H7_ADC_DIFSEL - bit fields */
+#define STM32H7_DIFSEL_SHIFT		0
+#define STM32H7_DIFSEL_MASK		GENMASK(19, 0)
+
 /* STM32H7_ADC_CALFACT - bit fields */
 #define STM32H7_CALFACT_D_SHIFT		16
 #define STM32H7_CALFACT_D_MASK		GENMASK(26, 16)
@@ -210,7 +219,30 @@ enum stm32h7_adc_dmngt {
 /* STM32MP1_ADC_SIDR - bit fields */
 #define STM32MP1_SIDR_MASK		GENMASK(31, 0)
 
+/* STM32MP13_ADC_CFGR specific bit fields */
+#define STM32MP13_DMAEN			BIT(0)
+#define STM32MP13_DMACFG		BIT(1)
+#define STM32MP13_DFSDMCFG		BIT(2)
+#define STM32MP13_RES_SHIFT		3
+#define STM32MP13_RES_MASK		GENMASK(4, 3)
+
+/* STM32MP13_ADC_DIFSEL - bit fields */
+#define STM32MP13_DIFSEL_SHIFT		0
+#define STM32MP13_DIFSEL_MASK		GENMASK(18, 0)
+
+/* STM32MP13_ADC_CALFACT - bit fields */
+#define STM32MP13_CALFACT_D_SHIFT	16
+#define STM32MP13_CALFACT_D_MASK	GENMASK(22, 16)
+#define STM32MP13_CALFACT_S_SHIFT	0
+#define STM32MP13_CALFACT_S_MASK	GENMASK(6, 0)
+
+/* STM32MP13_ADC2_OR - bit fields */
+#define STM32MP13_OP2			BIT(2)
+#define STM32MP13_OP1			BIT(1)
+#define STM32MP13_OP0			BIT(0)
+
 #define STM32MP15_IPIDR_NUMBER		0x00110005
+#define STM32MP13_IPIDR_NUMBER		0x00110006
 
 /**
  * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3cda529f081d..362db64bbd69 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -82,6 +82,8 @@ enum stm32_adc_extsel {
 enum stm32_adc_int_ch {
 	STM32_ADC_INT_CH_NONE = -1,
 	STM32_ADC_INT_CH_VDDCORE,
+	STM32_ADC_INT_CH_VDDCPU,
+	STM32_ADC_INT_CH_VDDQ_DDR,
 	STM32_ADC_INT_CH_VREFINT,
 	STM32_ADC_INT_CH_VBAT,
 	STM32_ADC_INT_CH_NB,
@@ -99,6 +101,8 @@ struct stm32_adc_ic {
 
 static const struct stm32_adc_ic stm32_adc_ic[STM32_ADC_INT_CH_NB] = {
 	{ "vddcore", STM32_ADC_INT_CH_VDDCORE },
+	{ "vddcpu", STM32_ADC_INT_CH_VDDCPU },
+	{ "vddq_ddr", STM32_ADC_INT_CH_VDDQ_DDR },
 	{ "vrefint", STM32_ADC_INT_CH_VREFINT },
 	{ "vbat", STM32_ADC_INT_CH_VBAT },
 };
@@ -160,9 +164,14 @@ struct stm32_adc_vrefint {
  * @exten:		trigger control register & bitfield
  * @extsel:		trigger selection register & bitfield
  * @res:		resolution selection register & bitfield
+ * @difsel:		differential mode selection register & bitfield
+ * @calfact_s:		single-ended calibration factors register & bitfield
+ * @calfact_d:		differential calibration factors register & bitfield
  * @smpr:		smpr1 & smpr2 registers offset array
  * @smp_bits:		smpr1 & smpr2 index and bitfields
- * @or_vdd:		option register & vddcore bitfield
+ * @or_vddcore:		option register & vddcore bitfield
+ * @or_vddcpu:		option register & vddcpu bitfield
+ * @or_vddq_ddr:	option register & vddq_ddr bitfield
  * @ccr_vbat:		common register & vbat bitfield
  * @ccr_vref:		common register & vrefint bitfield
  */
@@ -176,9 +185,14 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs exten;
 	const struct stm32_adc_regs extsel;
 	const struct stm32_adc_regs res;
+	const struct stm32_adc_regs difsel;
+	const struct stm32_adc_regs calfact_s;
+	const struct stm32_adc_regs calfact_d;
 	const u32 smpr[2];
 	const struct stm32_adc_regs *smp_bits;
-	const struct stm32_adc_regs or_vdd;
+	const struct stm32_adc_regs or_vddcore;
+	const struct stm32_adc_regs or_vddcpu;
+	const struct stm32_adc_regs or_vddq_ddr;
 	const struct stm32_adc_regs ccr_vbat;
 	const struct stm32_adc_regs ccr_vref;
 };
@@ -192,6 +206,9 @@ struct stm32_adc;
  * @trigs:		external trigger sources
  * @clk_required:	clock is required
  * @has_vregready:	vregready status flag presence
+ * @has_boostmode:	boost mode support flag
+ * @has_linearcal:	linear calibration support flag
+ * @has_presel:		channel preselection support flag
  * @prepare:		optional prepare routine (power-up, enable)
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
@@ -206,6 +223,9 @@ struct stm32_adc_cfg {
 	struct stm32_adc_trig_info	*trigs;
 	bool clk_required;
 	bool has_vregready;
+	bool has_boostmode;
+	bool has_linearcal;
+	bool has_presel;
 	int (*prepare)(struct iio_dev *);
 	void (*start_conv)(struct iio_dev *, bool dma);
 	void (*stop_conv)(struct iio_dev *);
@@ -312,6 +332,13 @@ static const struct stm32_adc_info stm32h7_adc_info = {
 	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
 };
 
+/* stm32mp13 can have up to 19 channels */
+static const struct stm32_adc_info stm32mp13_adc_info = {
+	.max_channels = 19,
+	.resolutions = stm32f4_adc_resolutions,
+	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
+};
+
 /*
  * stm32f4_sq - describe regular sequence registers
  * - L: sequence len (register & bit field)
@@ -497,8 +524,43 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
 		    STM32H7_EXTSEL_SHIFT },
 	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
+	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK},
+	.calfact_s = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_S_MASK,
+		       STM32H7_CALFACT_S_SHIFT },
+	.calfact_d = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_D_MASK,
+		       STM32H7_CALFACT_D_SHIFT },
+	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
+	.smp_bits = stm32h7_smp_bits,
+};
+
+/* STM32MP13 programmable sampling time (ADC clock cycles, rounded down) */
+static const unsigned int stm32mp13_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
+	2, 6, 12, 24, 47, 92, 247, 640,
+};
+
+static const struct stm32_adc_regspec stm32mp13_adc_regspec = {
+	.dr = STM32H7_ADC_DR,
+	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
+	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
+	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
+	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
+	.sqr = stm32h7_sq,
+	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
+	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
+		    STM32H7_EXTSEL_SHIFT },
+	.res = { STM32H7_ADC_CFGR, STM32MP13_RES_MASK, STM32MP13_RES_SHIFT },
+	.difsel = { STM32MP13_ADC_DIFSEL, STM32MP13_DIFSEL_MASK},
+	.calfact_s = { STM32MP13_ADC_CALFACT, STM32MP13_CALFACT_S_MASK,
+		       STM32MP13_CALFACT_S_SHIFT },
+	.calfact_d = { STM32MP13_ADC_CALFACT, STM32MP13_CALFACT_D_MASK,
+		       STM32MP13_CALFACT_D_SHIFT },
 	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
 	.smp_bits = stm32h7_smp_bits,
+	.or_vddcore = { STM32MP13_ADC2_OR, STM32MP13_OP0 },
+	.or_vddcpu = { STM32MP13_ADC2_OR, STM32MP13_OP1 },
+	.or_vddq_ddr = { STM32MP13_ADC2_OR, STM32MP13_OP2 },
+	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
+	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
 };
 
 static const struct stm32_adc_regspec stm32mp1_adc_regspec = {
@@ -512,9 +574,14 @@ static const struct stm32_adc_regspec stm32mp1_adc_regspec = {
 	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
 		    STM32H7_EXTSEL_SHIFT },
 	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
+	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK},
+	.calfact_s = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_S_MASK,
+		       STM32H7_CALFACT_S_SHIFT },
+	.calfact_d = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_D_MASK,
+		       STM32H7_CALFACT_D_SHIFT },
 	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
 	.smp_bits = stm32h7_smp_bits,
-	.or_vdd = { STM32MP1_ADC2_OR, STM32MP1_VDDCOREEN },
+	.or_vddcore = { STM32MP1_ADC2_OR, STM32MP1_VDDCOREEN },
 	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
 	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
 };
@@ -675,8 +742,18 @@ static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
 		switch (i) {
 		case STM32_ADC_INT_CH_VDDCORE:
 			dev_dbg(&indio_dev->dev, "Enable VDDCore\n");
-			stm32_adc_set_bits(adc, adc->cfg->regs->or_vdd.reg,
-					   adc->cfg->regs->or_vdd.mask);
+			stm32_adc_set_bits(adc, adc->cfg->regs->or_vddcore.reg,
+					   adc->cfg->regs->or_vddcore.mask);
+			break;
+		case STM32_ADC_INT_CH_VDDCPU:
+			dev_dbg(&indio_dev->dev, "Enable VDDCPU\n");
+			stm32_adc_set_bits(adc, adc->cfg->regs->or_vddcpu.reg,
+					   adc->cfg->regs->or_vddcpu.mask);
+			break;
+		case STM32_ADC_INT_CH_VDDQ_DDR:
+			dev_dbg(&indio_dev->dev, "Enable VDDQ_DDR\n");
+			stm32_adc_set_bits(adc, adc->cfg->regs->or_vddq_ddr.reg,
+					   adc->cfg->regs->or_vddq_ddr.mask);
 			break;
 		case STM32_ADC_INT_CH_VREFINT:
 			dev_dbg(&indio_dev->dev, "Enable VREFInt\n");
@@ -702,8 +779,16 @@ static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
 
 		switch (i) {
 		case STM32_ADC_INT_CH_VDDCORE:
-			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vdd.reg,
-					   adc->cfg->regs->or_vdd.mask);
+			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vddcore.reg,
+					   adc->cfg->regs->or_vddcore.mask);
+			break;
+		case STM32_ADC_INT_CH_VDDCPU:
+			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vddcpu.reg,
+					   adc->cfg->regs->or_vddcpu.mask);
+			break;
+		case STM32_ADC_INT_CH_VDDQ_DDR:
+			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vddq_ddr.reg,
+					   adc->cfg->regs->or_vddq_ddr.mask);
 			break;
 		case STM32_ADC_INT_CH_VREFINT:
 			stm32_adc_clr_bits_common(adc, adc->cfg->regs->ccr_vref.reg,
@@ -801,6 +886,7 @@ static void stm32h7_adc_stop_conv(struct iio_dev *indio_dev)
 	if (ret)
 		dev_warn(&indio_dev->dev, "stop failed\n");
 
+	/* STM32H7_DMNGT_MASK covers STM32MP13_DMAEN & STM32MP13_DMACFG */
 	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32H7_DMNGT_MASK);
 }
 
@@ -811,6 +897,17 @@ static void stm32h7_adc_irq_clear(struct iio_dev *indio_dev, u32 msk)
 	stm32_adc_set_bits(adc, adc->cfg->regs->isr_eoc.reg, msk);
 }
 
+static void stm32mp13_adc_start_conv(struct iio_dev *indio_dev, bool dma)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	if (dma)
+		stm32_adc_set_bits(adc, STM32H7_ADC_CFGR,
+				   STM32MP13_DMAEN | STM32MP13_DMACFG);
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
+}
+
 static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
@@ -821,7 +918,8 @@ static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
 
-	if (adc->common->rate > STM32H7_BOOST_CLKRATE)
+	if (adc->cfg->has_boostmode &&
+	    adc->common->rate > STM32H7_BOOST_CLKRATE)
 		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_BOOST);
 
 	/* Wait for startup time */
@@ -843,7 +941,8 @@ static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 
 static void stm32h7_adc_enter_pwr_down(struct stm32_adc *adc)
 {
-	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_BOOST);
+	if (adc->cfg->has_boostmode)
+		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_BOOST);
 
 	/* Setting DEEPPWD disables ADC vreg and clears ADVREGEN */
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
@@ -901,6 +1000,9 @@ static int stm32h7_adc_read_selfcalib(struct iio_dev *indio_dev)
 	int i, ret;
 	u32 lincalrdyw_mask, val;
 
+	if (!adc->cfg->has_linearcal)
+		goto skip_linearcal;
+
 	/* Read linearity calibration */
 	lincalrdyw_mask = STM32H7_LINCALRDYW6;
 	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
@@ -923,12 +1025,13 @@ static int stm32h7_adc_read_selfcalib(struct iio_dev *indio_dev)
 		lincalrdyw_mask >>= 1;
 	}
 
+skip_linearcal:
 	/* Read offset calibration */
-	val = stm32_adc_readl(adc, STM32H7_ADC_CALFACT);
-	adc->cal.calfact_s = (val & STM32H7_CALFACT_S_MASK);
-	adc->cal.calfact_s >>= STM32H7_CALFACT_S_SHIFT;
-	adc->cal.calfact_d = (val & STM32H7_CALFACT_D_MASK);
-	adc->cal.calfact_d >>= STM32H7_CALFACT_D_SHIFT;
+	val = stm32_adc_readl(adc, adc->cfg->regs->calfact_s.reg);
+	adc->cal.calfact_s = (val & adc->cfg->regs->calfact_s.mask);
+	adc->cal.calfact_s >>= adc->cfg->regs->calfact_s.shift;
+	adc->cal.calfact_d = (val & adc->cfg->regs->calfact_d.mask);
+	adc->cal.calfact_d >>= adc->cfg->regs->calfact_d.shift;
 	adc->cal.calibrated = true;
 
 	return 0;
@@ -945,9 +1048,12 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
 	int i, ret;
 	u32 lincalrdyw_mask, val;
 
-	val = (adc->cal.calfact_s << STM32H7_CALFACT_S_SHIFT) |
-		(adc->cal.calfact_d << STM32H7_CALFACT_D_SHIFT);
-	stm32_adc_writel(adc, STM32H7_ADC_CALFACT, val);
+	val = (adc->cal.calfact_s << adc->cfg->regs->calfact_s.shift) |
+		(adc->cal.calfact_d << adc->cfg->regs->calfact_d.shift);
+	stm32_adc_writel(adc, adc->cfg->regs->calfact_s.reg, val);
+
+	if (!adc->cfg->has_linearcal)
+		return 0;
 
 	lincalrdyw_mask = STM32H7_LINCALRDYW6;
 	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
@@ -1016,11 +1122,13 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	int ret;
-	u32 val;
+	u32 val, msk = STM32H7_ADCALDIF;
 
 	if (adc->cal.calibrated)
 		return true;
 
+	if (adc->cfg->has_linearcal)
+		msk |= STM32H7_ADCALLIN;
 	/* ADC must be disabled for calibration */
 	stm32h7_adc_disable(indio_dev);
 
@@ -1029,8 +1137,7 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 	 * - Offset calibration for single ended inputs
 	 * - No linearity calibration (do it later, before reading it)
 	 */
-	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
-	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALLIN);
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, msk);
 
 	/* Start calibration, then wait for completion */
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
@@ -1048,8 +1155,7 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 	 * - Linearity calibration (needs to be done only once for single/diff)
 	 *   will run simultaneously with offset calibration.
 	 */
-	stm32_adc_set_bits(adc, STM32H7_ADC_CR,
-			   STM32H7_ADCALDIF | STM32H7_ADCALLIN);
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, msk);
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
 	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
 					   !(val & STM32H7_ADCAL), 100,
@@ -1060,8 +1166,7 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 	}
 
 out:
-	stm32_adc_clr_bits(adc, STM32H7_ADC_CR,
-			   STM32H7_ADCALDIF | STM32H7_ADCALLIN);
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, msk);
 
 	return ret;
 }
@@ -1093,7 +1198,7 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
 
 	stm32_adc_int_ch_enable(indio_dev);
 
-	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
+	stm32_adc_writel(adc, adc->cfg->regs->difsel.reg, adc->difsel);
 
 	ret = stm32h7_adc_enable(indio_dev);
 	if (ret)
@@ -1107,7 +1212,8 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
 	if (ret)
 		goto disable;
 
-	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, adc->pcsel);
+	if (adc->cfg->has_presel)
+		stm32_adc_writel(adc, STM32H7_ADC_PCSEL, adc->pcsel);
 
 	return 0;
 
@@ -1125,7 +1231,8 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 
-	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
+	if (adc->cfg->has_presel)
+		stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
 	stm32h7_adc_disable(indio_dev);
 	stm32_adc_int_ch_disable(adc);
 	stm32h7_adc_enter_pwr_down(adc);
@@ -1857,7 +1964,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	adc->pcsel |= BIT(chan->channel);
 	if (differential) {
 		/* pre-build diff channels mask */
-		adc->difsel |= BIT(chan->channel);
+		adc->difsel |= BIT(chan->channel) & adc->cfg->regs->difsel.mask;
 		/* Also add negative input to pre-selected channels */
 		adc->pcsel |= BIT(chan->channel2);
 	}
@@ -1998,6 +2105,35 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
 		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
+			/* Check internal channel availability */
+			switch (i) {
+			case STM32_ADC_INT_CH_VDDCORE:
+				if (!adc->cfg->regs->or_vddcore.reg)
+					dev_warn(&indio_dev->dev,
+						 "%s channel not available\n", ch_name);
+				break;
+			case STM32_ADC_INT_CH_VDDCPU:
+				if (!adc->cfg->regs->or_vddcpu.reg)
+					dev_warn(&indio_dev->dev,
+						 "%s channel not available\n", ch_name);
+				break;
+			case STM32_ADC_INT_CH_VDDQ_DDR:
+				if (!adc->cfg->regs->or_vddq_ddr.reg)
+					dev_warn(&indio_dev->dev,
+						 "%s channel not available\n", ch_name);
+				break;
+			case STM32_ADC_INT_CH_VREFINT:
+				if (!adc->cfg->regs->ccr_vref.reg)
+					dev_warn(&indio_dev->dev,
+						 "%s channel not available\n", ch_name);
+				break;
+			case STM32_ADC_INT_CH_VBAT:
+				if (!adc->cfg->regs->ccr_vbat.reg)
+					dev_warn(&indio_dev->dev,
+						 "%s channel not available\n", ch_name);
+				break;
+			}
+
 			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
 				adc->int_ch[i] = chan;
 				break;
@@ -2435,6 +2571,9 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.regs = &stm32h7_adc_regspec,
 	.adc_info = &stm32h7_adc_info,
 	.trigs = stm32h7_adc_trigs,
+	.has_boostmode = true,
+	.has_linearcal = true,
+	.has_presel = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2448,6 +2587,9 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.adc_info = &stm32h7_adc_info,
 	.trigs = stm32h7_adc_trigs,
 	.has_vregready = true,
+	.has_boostmode = true,
+	.has_linearcal = true,
+	.has_presel = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2457,10 +2599,24 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.ts_vrefint_ns = 4300,
 };
 
+static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
+	.regs = &stm32mp13_adc_regspec,
+	.adc_info = &stm32mp13_adc_info,
+	.trigs = stm32h7_adc_trigs,
+	.start_conv = stm32mp13_adc_start_conv,
+	.stop_conv = stm32h7_adc_stop_conv,
+	.prepare = stm32h7_adc_prepare,
+	.unprepare = stm32h7_adc_unprepare,
+	.smp_cycles = stm32mp13_adc_smp_cycles,
+	.irq_clear = stm32h7_adc_irq_clear,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_cfg },
 	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
 	{ .compatible = "st,stm32mp1-adc", .data = (void *)&stm32mp1_adc_cfg },
+	{ .compatible = "st,stm32mp13-adc",
+	  .data = (void *)&stm32mp13_adc_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
-- 
2.25.1

