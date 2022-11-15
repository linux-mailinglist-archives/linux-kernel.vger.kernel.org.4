Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C94629606
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKOKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiKOKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:35:08 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12C3BE14;
        Tue, 15 Nov 2022 02:35:05 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF9uUSd007385;
        Tue, 15 Nov 2022 11:34:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=HLBKIxDJ1tRcZyoNfttTGe1qEPeSc6nSh3foOBB6cro=;
 b=GEbuPTCGYHmarJUuEhB0UaqkGXC+SDLn8pi9BKJFsxHbT2//1u/a+0JcfVR2e5LLFWNP
 WJy/QVQK9jy7XaLDZUo9BeKJC+PSB2wvReUPBDpSBJkjwNNqYsm79yx7158JU1TV9mv/
 /j7t7QXGuLe5PSO+yS55p7hOzCPE9YKCUOQUVXPzu8k5rC35iAYer6joMmutMUyz4sNM
 qszdo3mSKajgb0UiRkVZSn6qc9jeX4lzJP3t5Tl5slaa12T4IdQaZ3g7Ovgw9ABaFHFO
 5a7yAjoIsLgyMnPnT71kPNBtKJHBg4DNdUpmektkpVdfLO63/3oIPYctYH5SgJXYeD7t DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ktq2ynedw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 11:34:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B614100034;
        Tue, 15 Nov 2022 11:34:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13A9A21A206;
        Tue, 15 Nov 2022 11:34:32 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Tue, 15 Nov
 2022 11:34:31 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] iio: adc: stm32-adc: smart calibration support
Date:   Tue, 15 Nov 2022 11:31:21 +0100
Message-ID: <20221115103124.70074-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115103124.70074-1-olivier.moysan@foss.st.com>
References: <20221115103124.70074-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_05,2022-11-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add smart calibration support for STM32MP1.
- STM32MP15x: both linear & offset calibration are supported
- STM32MP13x: Only offset calibration is supported

Linear calibration:
Linear calibration is SoC dependent and does not change over time
so it can be done only once.
Linear calibration may have already been done in u-boot.
Skip calibration execution if calibration data are already available.
Save calibration factors in private data and restore them from private
data on next ADC start.

Offset calibration:
This calibration may vary over time, depending on temperature or voltage.
Run offset single-ended and differential calibration on each ADC start,
as it is not time consuming. This calibration do not need to be saved.
So, remove calfact_s and calfact_d value and bitfields that are no
longer used.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.h |   1 +
 drivers/iio/adc/stm32-adc.c      | 108 +++++++++++++++----------------
 2 files changed, 53 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 9d6dfa1c03fa..73b2c2e91c08 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -142,6 +142,7 @@
 #define STM32H7_LINCALRDYW3		BIT(24)
 #define STM32H7_LINCALRDYW2		BIT(23)
 #define STM32H7_LINCALRDYW1		BIT(22)
+#define STM32H7_LINCALRDYW_MASK		GENMASK(27, 22)
 #define STM32H7_ADCALLIN		BIT(16)
 #define STM32H7_BOOST			BIT(8)
 #define STM32H7_ADSTP			BIT(4)
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 8d03d21a33d6..2b2b55eb130e 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -119,16 +119,12 @@ struct stm32_adc_trig_info {
 
 /**
  * struct stm32_adc_calib - optional adc calibration data
- * @calfact_s: Calibration offset for single ended channels
- * @calfact_d: Calibration offset in differential
  * @lincalfact: Linearity calibration factor
- * @calibrated: Indicates calibration status
+ * @lincal_saved: Indicates that linear calibration factors are saved
  */
 struct stm32_adc_calib {
-	u32			calfact_s;
-	u32			calfact_d;
 	u32			lincalfact[STM32H7_LINCALFACT_NUM];
-	bool			calibrated;
+	bool			lincal_saved;
 };
 
 /**
@@ -165,8 +161,6 @@ struct stm32_adc_vrefint {
  * @extsel:		trigger selection register & bitfield
  * @res:		resolution selection register & bitfield
  * @difsel:		differential mode selection register & bitfield
- * @calfact_s:		single-ended calibration factors register & bitfield
- * @calfact_d:		differential calibration factors register & bitfield
  * @smpr:		smpr1 & smpr2 registers offset array
  * @smp_bits:		smpr1 & smpr2 index and bitfields
  * @or_vddcore:		option register & vddcore bitfield
@@ -186,8 +180,6 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs extsel;
 	const struct stm32_adc_regs res;
 	const struct stm32_adc_regs difsel;
-	const struct stm32_adc_regs calfact_s;
-	const struct stm32_adc_regs calfact_d;
 	const u32 smpr[2];
 	const struct stm32_adc_regs *smp_bits;
 	const struct stm32_adc_regs or_vddcore;
@@ -525,10 +517,6 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 		    STM32H7_EXTSEL_SHIFT },
 	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
 	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK},
-	.calfact_s = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_S_MASK,
-		       STM32H7_CALFACT_S_SHIFT },
-	.calfact_d = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_D_MASK,
-		       STM32H7_CALFACT_D_SHIFT },
 	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
 	.smp_bits = stm32h7_smp_bits,
 };
@@ -550,10 +538,6 @@ static const struct stm32_adc_regspec stm32mp13_adc_regspec = {
 		    STM32H7_EXTSEL_SHIFT },
 	.res = { STM32H7_ADC_CFGR, STM32MP13_RES_MASK, STM32MP13_RES_SHIFT },
 	.difsel = { STM32MP13_ADC_DIFSEL, STM32MP13_DIFSEL_MASK},
-	.calfact_s = { STM32MP13_ADC_CALFACT, STM32MP13_CALFACT_S_MASK,
-		       STM32MP13_CALFACT_S_SHIFT },
-	.calfact_d = { STM32MP13_ADC_CALFACT, STM32MP13_CALFACT_D_MASK,
-		       STM32MP13_CALFACT_D_SHIFT },
 	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
 	.smp_bits = stm32h7_smp_bits,
 	.or_vddcore = { STM32MP13_ADC2_OR, STM32MP13_OP0 },
@@ -575,10 +559,6 @@ static const struct stm32_adc_regspec stm32mp1_adc_regspec = {
 		    STM32H7_EXTSEL_SHIFT },
 	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
 	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK},
-	.calfact_s = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_S_MASK,
-		       STM32H7_CALFACT_S_SHIFT },
-	.calfact_d = { STM32H7_ADC_CALFACT, STM32H7_CALFACT_D_MASK,
-		       STM32H7_CALFACT_D_SHIFT },
 	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
 	.smp_bits = stm32h7_smp_bits,
 	.or_vddcore = { STM32MP1_ADC2_OR, STM32MP1_VDDCOREEN },
@@ -1000,9 +980,6 @@ static int stm32h7_adc_read_selfcalib(struct iio_dev *indio_dev)
 	int i, ret;
 	u32 lincalrdyw_mask, val;
 
-	if (!adc->cfg->has_linearcal)
-		goto skip_linearcal;
-
 	/* Read linearity calibration */
 	lincalrdyw_mask = STM32H7_LINCALRDYW6;
 	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
@@ -1024,15 +1001,7 @@ static int stm32h7_adc_read_selfcalib(struct iio_dev *indio_dev)
 
 		lincalrdyw_mask >>= 1;
 	}
-
-skip_linearcal:
-	/* Read offset calibration */
-	val = stm32_adc_readl(adc, adc->cfg->regs->calfact_s.reg);
-	adc->cal.calfact_s = (val & adc->cfg->regs->calfact_s.mask);
-	adc->cal.calfact_s >>= adc->cfg->regs->calfact_s.shift;
-	adc->cal.calfact_d = (val & adc->cfg->regs->calfact_d.mask);
-	adc->cal.calfact_d >>= adc->cfg->regs->calfact_d.shift;
-	adc->cal.calibrated = true;
+	adc->cal.lincal_saved = true;
 
 	return 0;
 }
@@ -1048,13 +1017,6 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
 	int i, ret;
 	u32 lincalrdyw_mask, val;
 
-	val = (adc->cal.calfact_s << adc->cfg->regs->calfact_s.shift) |
-		(adc->cal.calfact_d << adc->cfg->regs->calfact_d.shift);
-	stm32_adc_writel(adc, adc->cfg->regs->calfact_s.reg, val);
-
-	if (!adc->cfg->has_linearcal)
-		return 0;
-
 	lincalrdyw_mask = STM32H7_LINCALRDYW6;
 	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
 		/*
@@ -1116,19 +1078,20 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
 /**
  * stm32h7_adc_selfcalib() - Procedure to calibrate ADC
  * @indio_dev: IIO device instance
+ * @do_lincal: linear calibration request flag
  * Note: Must be called once ADC is out of power down.
+ *
+ * Run offset calibration unconditionally.
+ * Run linear calibration if requested & supported.
  */
-static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
+static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev, int do_lincal)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	int ret;
 	u32 msk = STM32H7_ADCALDIF;
 	u32 val;
 
-	if (adc->cal.calibrated)
-		return true;
-
-	if (adc->cfg->has_linearcal)
+	if (adc->cfg->has_linearcal && do_lincal)
 		msk |= STM32H7_ADCALLIN;
 	/* ADC must be disabled for calibration */
 	stm32h7_adc_disable(indio_dev);
@@ -1172,6 +1135,33 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 	return ret;
 }
 
+/**
+ * stm32h7_adc_check_selfcalib() - Check linear calibration status
+ * @indio_dev: IIO device instance
+ *
+ * Used to check if linear calibration has been done.
+ * Return true if linear calibration factors are already saved in private data
+ * or if a linear calibration has been done at boot stage.
+ */
+static int stm32h7_adc_check_selfcalib(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 val;
+
+	if (adc->cal.lincal_saved)
+		return true;
+
+	/*
+	 * Check if linear calibration factors are available in ADC registers,
+	 * by checking that all LINCALRDYWx bits are set.
+	 */
+	val = stm32_adc_readl(adc, STM32H7_ADC_CR) & STM32H7_LINCALRDYW_MASK;
+	if (val == STM32H7_LINCALRDYW_MASK)
+		return true;
+
+	return false;
+}
+
 /**
  * stm32h7_adc_prepare() - Leave power down mode to enable ADC.
  * @indio_dev: IIO device instance
@@ -1186,16 +1176,20 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
-	int calib, ret;
+	int lincal_done = false;
+	int ret;
 
 	ret = stm32h7_adc_exit_pwr_down(indio_dev);
 	if (ret)
 		return ret;
 
-	ret = stm32h7_adc_selfcalib(indio_dev);
+	if (adc->cfg->has_linearcal)
+		lincal_done = stm32h7_adc_check_selfcalib(indio_dev);
+
+	/* Always run offset calibration. Run linear calibration only once */
+	ret = stm32h7_adc_selfcalib(indio_dev, !lincal_done);
 	if (ret < 0)
 		goto pwr_dwn;
-	calib = ret;
 
 	stm32_adc_int_ch_enable(indio_dev);
 
@@ -1205,13 +1199,15 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
 	if (ret)
 		goto ch_disable;
 
-	/* Either restore or read calibration result for future reference */
-	if (calib)
-		ret = stm32h7_adc_restore_selfcalib(indio_dev);
-	else
-		ret = stm32h7_adc_read_selfcalib(indio_dev);
-	if (ret)
-		goto disable;
+	if (adc->cfg->has_linearcal) {
+		if (!adc->cal.lincal_saved)
+			ret = stm32h7_adc_read_selfcalib(indio_dev);
+		else
+			ret = stm32h7_adc_restore_selfcalib(indio_dev);
+
+		if (ret)
+			goto disable;
+	}
 
 	if (adc->cfg->has_presel)
 		stm32_adc_writel(adc, STM32H7_ADC_PCSEL, adc->pcsel);
-- 
2.25.1

