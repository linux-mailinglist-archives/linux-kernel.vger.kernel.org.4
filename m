Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477685F559B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJENhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJENhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:37:03 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF0B7AC29;
        Wed,  5 Oct 2022 06:37:00 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295CYB8k012957;
        Wed, 5 Oct 2022 15:36:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=UVV9GcPEqUZ1X3c4vAmDfjbu0XaSHf4BjqKBIxVbEPE=;
 b=nhNmn9zQyTth6SMBIbgASeVOmHDKkv7RAYhkHVD+M85wotXlgrl7HqVrqxA8lLSzYTAj
 H9+EIEpKb4kI4/JoXyr7fNEqToX5OT5LseQ+4GjGQ9h7zZA7MrmsMVDquXoqL7dSSkdW
 VgwrROCJ9vzoXc23+Q+f39J2YX9Q38hryyfRydkSYlRi+OdvxCzzxDXgZUHYIFjzMDjv
 iEkYcqWXi1V+5g7/EY/6Uq10hOFRq/Bd7JzLEo0pbuD9qeasNq6Nutg3JnFbc3dJyVns
 tufcZjOueEtcu2wqqmDOwCP7HHgf+RQG/xnIYc9Y+rpkP4Ib1A8ZMcv15prJxu8gKQjW 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxcw27hwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 15:36:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 97C2210003A;
        Wed,  5 Oct 2022 15:36:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91CD622A6C3;
        Wed,  5 Oct 2022 15:36:06 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 5 Oct
 2022 15:36:06 +0200
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
Subject: [PATCH v2 4/8] iio: adc: stm32: manage min sampling time on all internal channels
Date:   Wed, 5 Oct 2022 15:31:16 +0200
Message-ID: <20221005133120.50483-5-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005133120.50483-1-olivier.moysan@foss.st.com>
References: <20221005133120.50483-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force minimum sampling time for all internal channels according
to datasheet requirement. This value can be increased through
DT st,min-sample-time-ns property.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 362db64bbd69..10eb0acc9327 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -215,7 +215,7 @@ struct stm32_adc;
  * @unprepare:		optional unprepare routine (disable, power-down)
  * @irq_clear:		routine to clear irqs
  * @smp_cycles:		programmable sampling time (ADC clock cycles)
- * @ts_vrefint_ns:	vrefint minimum sampling time in ns
+ * @ts_int_ch:		pointer to array of internal channels minimum sampling time in ns
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
@@ -232,7 +232,7 @@ struct stm32_adc_cfg {
 	void (*unprepare)(struct iio_dev *);
 	void (*irq_clear)(struct iio_dev *indio_dev, u32 msk);
 	const unsigned int *smp_cycles;
-	const unsigned int ts_vrefint_ns;
+	const unsigned int *ts_int_ch;
 };
 
 /**
@@ -1909,14 +1909,15 @@ static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
 {
 	const struct stm32_adc_regs *smpr = &adc->cfg->regs->smp_bits[channel];
 	u32 period_ns, shift = smpr->shift, mask = smpr->mask;
-	unsigned int smp, r = smpr->reg;
+	unsigned int i, smp, r = smpr->reg;
 
 	/*
-	 * For vrefint channel, ensure that the sampling time cannot
+	 * For internal channels, ensure that the sampling time cannot
 	 * be lower than the one specified in the datasheet
 	 */
-	if (channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT])
-		smp_ns = max(smp_ns, adc->cfg->ts_vrefint_ns);
+	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
+		if (channel == adc->int_ch[i] && adc->int_ch[i] != STM32_ADC_INT_CH_NONE)
+			smp_ns = max(smp_ns, adc->cfg->ts_int_ch[i]);
 
 	/* Determine sampling time (ADC clock cycles) */
 	period_ns = NSEC_PER_SEC / adc->common->rate;
@@ -2567,6 +2568,9 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.irq_clear = stm32f4_adc_irq_clear,
 };
 
+const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
+static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
+
 static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.regs = &stm32h7_adc_regspec,
 	.adc_info = &stm32h7_adc_info,
@@ -2580,8 +2584,12 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.unprepare = stm32h7_adc_unprepare,
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
+	.ts_int_ch = stm32_adc_min_ts_h7,
 };
 
+const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
+static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
+
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.regs = &stm32mp1_adc_regspec,
 	.adc_info = &stm32h7_adc_info,
@@ -2596,9 +2604,12 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.unprepare = stm32h7_adc_unprepare,
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
-	.ts_vrefint_ns = 4300,
+	.ts_int_ch = stm32_adc_min_ts_mp1,
 };
 
+const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
+static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
+
 static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.regs = &stm32mp13_adc_regspec,
 	.adc_info = &stm32mp13_adc_info,
@@ -2609,6 +2620,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.unprepare = stm32h7_adc_unprepare,
 	.smp_cycles = stm32mp13_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
+	.ts_int_ch = stm32_adc_min_ts_mp13,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.25.1

