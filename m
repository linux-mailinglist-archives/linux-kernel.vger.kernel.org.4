Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACAA66B9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjAPJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjAPJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:06:01 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A51632C;
        Mon, 16 Jan 2023 01:04:30 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G4WFYW020822;
        Mon, 16 Jan 2023 10:03:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=BZO4szZsrUWg/3PIM8P/YrC7I74jhBQFAVGjF3sgEB8=;
 b=xyLGJibn4bT+IrpXVumZ+WnkZYsEjJyRH5CKDH1ANhl3L8df7+fKED3C64ddzurO6ltp
 ZvJynw4L5fy8Z0eqXGTkJKO6XKzJE5fU5dsKZKCm5DqomHZ8O8rPevIVMYMpAQ9ytGd4
 VXfFXCfqV7MKkCn3WDhWUvVwpBqB8JIhRq2OATvgqYbRd5/+sLEHIbc6CtLlb710ay4j
 E7Fhxpc9jWsmaJCBkHtQInRP5rAlDvBH9a4q0fadCBu12XVKhzSIOYisjBECKfJUfy8q
 hIM4FRsvwnE43Op+51je5nSwvBkyUf64g4zDmVy0fxy0JwHnUghFFBfbBaev9dPcYkqx sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n3jpqrvad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 10:03:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 99F41100034;
        Mon, 16 Jan 2023 10:03:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9265B210598;
        Mon, 16 Jan 2023 10:03:49 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 16 Jan
 2023 10:03:49 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: stm32: add oversampling support
Date:   Mon, 16 Jan 2023 10:03:33 +0100
Message-ID: <20230116090333.33492-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_06,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
STM32F4 ADC has no oversampling feature.

The current support of the oversampling feature aims at increasing
the data SNR, without changing the data resolution.
As the oversampling by itself increases data resolution,
a right shift is applied to keep initial resolution.
Only the oversampling ratio corresponding to a power of two are
supported here, to get a direct link between right shift and
oversampling ratio. (2exp(n) ratio <=> n right shift)

The oversampling ratio is shared by all channels, whatever channel type.
(e.g. single ended or differential).

Oversampling can be configured using IIO ABI:
- in_voltage_oversampling_ratio_available
- in_voltage_oversampling_ratio

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.h |  16 ++++
 drivers/iio/adc/stm32-adc.c      | 144 +++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 73b2c2e91c08..86a98286eeb3 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -91,6 +91,7 @@
 #define STM32H7_ADC_IER			0x04
 #define STM32H7_ADC_CR			0x08
 #define STM32H7_ADC_CFGR		0x0C
+#define STM32H7_ADC_CFGR2		0x10
 #define STM32H7_ADC_SMPR1		0x14
 #define STM32H7_ADC_SMPR2		0x18
 #define STM32H7_ADC_PCSEL		0x1C
@@ -160,6 +161,14 @@
 #define STM32H7_DMNGT_SHIFT		0
 #define STM32H7_DMNGT_MASK		GENMASK(1, 0)
 
+/* STM32H7_ADC_CFGR2 bit fields */
+#define STM32H7_OVSR_SHIFT		16 /* Correspond to OSVR field in datasheet */
+#define STM32H7_OVSR_MASK		GENMASK(25, 16)
+#define STM32H7_OVSR_BITS		10
+#define STM32H7_OVSS_SHIFT		5
+#define STM32H7_OVSS_MASK		GENMASK(8, 5)
+#define STM32H7_ROVSE			BIT(0)
+
 enum stm32h7_adc_dmngt {
 	STM32H7_DMNGT_DR_ONLY,		/* Regular data in DR only */
 	STM32H7_DMNGT_DMA_ONESHOT,	/* DMA one shot mode */
@@ -226,6 +235,13 @@ enum stm32h7_adc_dmngt {
 #define STM32MP13_RES_SHIFT		3
 #define STM32MP13_RES_MASK		GENMASK(4, 3)
 
+/* STM32MP13_ADC_CFGR2 bit fields */
+#define STM32MP13_OVSR_SHIFT		2
+#define STM32MP13_OVSR_MASK		GENMASK(4, 2)
+#define STM32MP13_OVSR_BITS		3
+#define STM32MP13_OVSS_SHIFT		5
+#define STM32MP13_OVSS_MASK		GENMASK(8, 5)
+
 /* STM32MP13_ADC_DIFSEL - bit fields */
 #define STM32MP13_DIFSEL_MASK		GENMASK(18, 0)
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 45d4e79f8e55..17050875f23d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -6,6 +6,7 @@
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -13,6 +14,7 @@
 #include <linux/dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/timer/stm32-lptim-trigger.h>
 #include <linux/iio/timer/stm32-timer-trigger.h>
 #include <linux/iio/trigger.h>
@@ -27,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/util_macros.h>
 
 #include "stm32-adc-core.h"
 
@@ -202,11 +205,13 @@ struct stm32_adc;
  * @has_boostmode:	boost mode support flag
  * @has_linearcal:	linear calibration support flag
  * @has_presel:		channel preselection support flag
+ * @has_oversampling:	oversampling support flag
  * @prepare:		optional prepare routine (power-up, enable)
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
  * @unprepare:		optional unprepare routine (disable, power-down)
  * @irq_clear:		routine to clear irqs
+ * @set_ovs:		routine to set oversampling configuration
  * @smp_cycles:		programmable sampling time (ADC clock cycles)
  * @ts_int_ch:		pointer to array of internal channels minimum sampling time in ns
  */
@@ -219,11 +224,13 @@ struct stm32_adc_cfg {
 	bool has_boostmode;
 	bool has_linearcal;
 	bool has_presel;
+	bool has_oversampling;
 	int (*prepare)(struct iio_dev *);
 	void (*start_conv)(struct iio_dev *, bool dma);
 	void (*stop_conv)(struct iio_dev *);
 	void (*unprepare)(struct iio_dev *);
 	void (*irq_clear)(struct iio_dev *indio_dev, u32 msk);
+	void (*set_ovs)(struct iio_dev *indio_dev, u32 ovs_idx);
 	const unsigned int *smp_cycles;
 	const unsigned int *ts_int_ch;
 };
@@ -255,6 +262,7 @@ struct stm32_adc_cfg {
  * @num_diff:		number of differential channels
  * @int_ch:		internal channel indexes array
  * @nsmps:		number of channels with optional sample time
+ * @ovs_idx:		current oversampling ratio index (in oversampling array)
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -282,6 +290,7 @@ struct stm32_adc {
 	u32			num_diff;
 	int			int_ch[STM32_ADC_INT_CH_NB];
 	int			nsmps;
+	int			ovs_idx;
 };
 
 struct stm32_adc_diff_channel {
@@ -293,12 +302,24 @@ struct stm32_adc_diff_channel {
  * struct stm32_adc_info - stm32 ADC, per instance config data
  * @max_channels:	Number of channels
  * @resolutions:	available resolutions
+ * @oversampling:	available oversampling ratios
  * @num_res:		number of available resolutions
+ * @num_ovs:		number of available oversampling ratios
  */
 struct stm32_adc_info {
 	int max_channels;
 	const unsigned int *resolutions;
+	const unsigned int *oversampling;
 	const unsigned int num_res;
+	const unsigned int num_ovs;
+};
+
+static const unsigned int stm32h7_adc_oversampling_avail[] = {
+1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
+};
+
+static const unsigned int stm32mp13_adc_oversampling_avail[] = {
+1, 2, 4, 8, 16, 32, 64, 128, 256
 };
 
 static const unsigned int stm32f4_adc_resolutions[] = {
@@ -322,14 +343,18 @@ static const unsigned int stm32h7_adc_resolutions[] = {
 static const struct stm32_adc_info stm32h7_adc_info = {
 	.max_channels = STM32_ADC_CH_MAX,
 	.resolutions = stm32h7_adc_resolutions,
+	.oversampling = stm32h7_adc_oversampling_avail,
 	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
+	.num_ovs = ARRAY_SIZE(stm32h7_adc_oversampling_avail),
 };
 
 /* stm32mp13 can have up to 19 channels */
 static const struct stm32_adc_info stm32mp13_adc_info = {
 	.max_channels = 19,
 	.resolutions = stm32f4_adc_resolutions,
+	.oversampling = stm32mp13_adc_oversampling_avail,
 	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
+	.num_ovs = ARRAY_SIZE(stm32mp13_adc_oversampling_avail),
 };
 
 /*
@@ -889,6 +914,44 @@ static void stm32mp13_adc_start_conv(struct iio_dev *indio_dev, bool dma)
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
 }
 
+static void stm32h7_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 ovsr_bits, bits, msk = STM32H7_ROVSE;
+
+	msk |= STM32H7_OVSR_MASK | STM32H7_OVSS_MASK;
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
+
+	if (!ovs_idx)
+		return;
+
+	bits = STM32H7_ROVSE;
+	ovsr_bits = (1 << ovs_idx) - 1;
+	bits |= ovsr_bits << STM32H7_OVSR_SHIFT;
+	bits |= ovs_idx << STM32H7_OVSS_SHIFT;
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
+}
+
+static void stm32mp13_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 bits, msk = STM32H7_ROVSE;
+
+	msk |= STM32MP13_OVSR_MASK | STM32MP13_OVSS_MASK;
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
+
+	if (!ovs_idx)
+		return;
+
+	bits = STM32H7_ROVSE;
+	if (ovs_idx - 1)
+		bits |= (ovs_idx - 1) << STM32MP13_OVSR_SHIFT;
+	bits |= ovs_idx << STM32MP13_OVSS_SHIFT;
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
+}
+
 static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
@@ -1461,6 +1524,71 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int stm32_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	int nb = adc->cfg->adc_info->num_ovs;
+	u32 idx;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		if (val2) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		for (idx = 0; idx < nb; idx++)
+			if (adc->cfg->adc_info->oversampling[idx] == val)
+				break;
+
+		if (idx >= nb) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			goto err;
+
+		adc->cfg->set_ovs(indio_dev, idx);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+
+		adc->ovs_idx = idx;
+
+err:
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int stm32_adc_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				const int **vals, int *type, int *length, long m)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*length = adc->cfg->adc_info->num_ovs;
+		*vals = adc->cfg->adc_info->oversampling;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -1503,6 +1631,10 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = adc->cfg->adc_info->oversampling[adc->ovs_idx];
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -1679,6 +1811,8 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info stm32_adc_iio_info = {
 	.read_raw = stm32_adc_read_raw,
+	.write_raw = stm32_adc_write_raw,
+	.read_avail = stm32_adc_read_avail,
 	.validate_trigger = stm32_adc_validate_trigger,
 	.hwfifo_set_watermark = stm32_adc_set_watermark,
 	.update_scan_mode = stm32_adc_update_scan_mode,
@@ -1972,6 +2106,10 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
 					 BIT(IIO_CHAN_INFO_OFFSET);
+	if (adc->cfg->has_oversampling) {
+		chan->info_mask_shared_by_all |= BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		chan->info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+	}
 	chan->scan_type.sign = 'u';
 	chan->scan_type.realbits = adc->cfg->adc_info->resolutions[adc->res];
 	chan->scan_type.storagebits = 16;
@@ -2598,6 +2736,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.has_boostmode = true,
 	.has_linearcal = true,
 	.has_presel = true,
+	.has_oversampling = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2605,6 +2744,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_h7,
+	.set_ovs = stm32h7_adc_set_ovs,
 };
 
 const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
@@ -2618,6 +2758,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.has_boostmode = true,
 	.has_linearcal = true,
 	.has_presel = true,
+	.has_oversampling = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2625,6 +2766,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp1,
+	.set_ovs = stm32h7_adc_set_ovs,
 };
 
 const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
@@ -2634,6 +2776,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.regs = &stm32mp13_adc_regspec,
 	.adc_info = &stm32mp13_adc_info,
 	.trigs = stm32h7_adc_trigs,
+	.has_oversampling = true,
 	.start_conv = stm32mp13_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2641,6 +2784,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.smp_cycles = stm32mp13_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp13,
+	.set_ovs = stm32mp13_adc_set_ovs,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.25.1

