Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF8652328
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiLTOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiLTOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:52:07 -0500
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FFD1C92F;
        Tue, 20 Dec 2022 06:52:00 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[61.152.193.32])
        by rmsmtp-lg-appmail-06-12084 (RichMail) with SMTP id 2f3463a1c9c00b2-87199;
        Tue, 20 Dec 2022 22:42:09 +0800 (CST)
X-RM-TRANSID: 2f3463a1c9c00b2-87199
From:   Kevin Lu <luminlong@139.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, navada@ti.com, peeyush@ti.com,
        Kevin Lu <luminlong@139.com>
Subject: [PATCH] ALSA SoC: Texas Instruments TAS2781 Audio Smart Amp
Date:   Tue, 20 Dec 2022 22:42:03 +0800
Message-Id: <20221220144203.2194-1-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS2781 driver implements a flexible and configurable register setting
for one, two, even multiple TAS2781 chips. All the register setting are in
a bin file. Almost no specific register setting can be found in the code.

Signed-off-by: Kevin Lu <luminlong@139.com>
---
 sound/soc/codecs/Kconfig       |   13 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tas2781-dsp.c | 2483 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2781-dsp.h |  213 +++
 sound/soc/codecs/tas2781-i2c.c | 2143 +++++++++++++++++++++++++++
 sound/soc/codecs/tas2781.h     |  208 +++
 6 files changed, 5062 insertions(+)
 create mode 100644 sound/soc/codecs/tas2781-dsp.c
 create mode 100644 sound/soc/codecs/tas2781-dsp.h
 create mode 100644 sound/soc/codecs/tas2781-i2c.c
 create mode 100644 sound/soc/codecs/tas2781.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7022e6286..31d2d9594 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -222,6 +222,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2764
 	imply SND_SOC_TAS2770
 	imply SND_SOC_TAS2780
+	imply SND_SOC_TAS2781
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1573,6 +1574,18 @@ config SND_SOC_TAS2780
 	  Enable support for Texas Instruments TAS2780 high-efficiency
 	  digital input mono Class-D audio power amplifiers.
 
+config SND_SOC_TAS2781
+	tristate "Texas Instruments TAS2781 speaker amplifier"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Enable support for Texas Instruments TAS2781 Smart Amplifier
+	  Digital input mono Class-D and DSP-inside audio power amplifiers.
+	  Note the TAS2781 driver implements a flexible and configurable
+	  register setting, for one, two, even multiple TAS2781 chips.
+	  All the register setting are in a bin file. Almost no specific
+	  register setting can be found in the code.
+
 config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9170ee144..088fed9e7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -354,6 +354,7 @@ snd-soc-tas2552-objs := tas2552.o
 snd-soc-tas2562-objs := tas2562.o
 snd-soc-tas2764-objs := tas2764.o
 snd-soc-tas2780-objs := tas2780.o
+snd-soc-tas2781-objs :=	tas2781-i2c.o tas2781-dsp.o
 # Mux
 snd-soc-simple-mux-objs := simple-mux.o
 
@@ -604,6 +605,7 @@ obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS2562)	+= snd-soc-tas2562.o
 obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
+obj-$(CONFIG_SND_SOC_TAS2781)	+= snd-soc-tas2781.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2781-dsp.c b/sound/soc/codecs/tas2781-dsp.c
new file mode 100644
index 000000000..56c7efd30
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.c
@@ -0,0 +1,2483 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable register setting
+ * for one, two, even multiple TAS2781 chips. All the register setting are in
+ * a bin file. Almost no specific register setting can be found in the code.
+ *
+ * Author: Shenghao Ding <shenghao-ding@ti.com>
+ *         Kevin Lu <kevin-lu@ti.com>
+ */
+
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/string.h>
+#include <linux/crc8.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+
+#include "tas2781.h"
+
+#define TAS2781_CAL_BIN_PATH	("/lib/firmware/")
+
+#define ERROR_PRAM_CRCCHK			(0x0000000)
+#define ERROR_YRAM_CRCCHK			(0x0000001)
+#define BINFILEDOCVER				(0)
+#define DRVFWVER					(1)
+#define	PPC_DRIVER_CRCCHK			(0x00000200)
+
+#define TAS2781_SA_COEFF_SWAP_REG	TASDEVICE_REG(0, 0x35, 0x2c)
+#define TAS2781_YRAM_BOOK1			(140)
+#define TAS2781_YRAM1_PAGE			(42)
+#define TAS2781_YRAM1_START_REG		(88)
+
+#define TAS2781_YRAM2_START_PAGE	(43)
+#define TAS2781_YRAM2_END_PAGE		(49)
+#define TAS2781_YRAM2_START_REG		(8)
+#define TAS2781_YRAM2_END_REG		(127)
+
+#define TAS2781_YRAM3_PAGE			(50)
+#define TAS2781_YRAM3_START_REG		(8)
+#define TAS2781_YRAM3_END_REG		(27)
+
+/*should not include B0_P53_R44-R47 */
+#define TAS2781_YRAM_BOOK2			(0)
+#define TAS2781_YRAM4_START_PAGE	(50)
+#define TAS2781_YRAM4_END_PAGE		(60)
+
+#define TAS2781_YRAM5_PAGE			(61)
+#define TAS2781_YRAM5_START_REG		(8)
+#define TAS2781_YRAM5_END_REG		(27)
+
+#define TASDEVICE_MAXPROGRAM_NUM_KERNEL			(5)
+#define TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS	(64)
+#define TASDEVICE_MAXCONFIG_NUM_KERNEL			(10)
+#define MAIN_ALL_DEVICES_1X				(0x01)
+#define MAIN_DEVICE_A_1X				(0x02)
+#define MAIN_DEVICE_B_1X				(0x03)
+#define MAIN_DEVICE_C_1X				(0x04)
+#define MAIN_DEVICE_D_1X				(0x05)
+#define COEFF_DEVICE_A_1X				(0x12)
+#define COEFF_DEVICE_B_1X				(0x13)
+#define COEFF_DEVICE_C_1X				(0x14)
+#define COEFF_DEVICE_D_1X				(0x15)
+#define PRE_DEVICE_A_1X					(0x22)
+#define PRE_DEVICE_B_1X					(0x23)
+#define PRE_DEVICE_C_1X					(0x24)
+#define PRE_DEVICE_D_1X					(0x25)
+
+struct TYCRC {
+	unsigned char mnOffset;
+	unsigned char mnLen;
+};
+
+const unsigned int BinFileformatVerInfo[][2] = {
+	{0x100, 0x100},
+	{0x110, 0x200},
+	{0x200, 0x300},
+	{0x210, 0x310},
+	{0x230, 0x320},
+	{0x300, 0x400}
+};
+
+const char *devicefamily[1] = {
+	"TAS Devices" };
+
+const char *devicelist[TASDEVICE_DSP_TAS_MAX_DEVICE] = {
+	"TAS2555",
+	"TAS2555 Stereo",
+	"TAS2557 Mono",
+	"TAS2557 Dual Mono",
+	"TAS2559",
+	"TAS2563",
+	NULL,
+	"TAS2563 Dual Mono",
+	"TAS2563 Quad",
+	"TAS2563 2.1",
+	"TAS2781",
+	"TAS2781 Stereo",
+	"TAS2781 2.1",
+	"TAS2781 Quad"
+};
+
+const char deviceNumber[TASDEVICE_DSP_TAS_MAX_DEVICE] = {
+	1, 2, 1, 2, 1, 1, 0, 2, 4, 3, 1, 2, 3, 4
+};
+
+static int fw_parse_block_data_kernel(struct TFirmware *pFirmware,
+	struct TBlock *pBlock, const struct firmware *pFW, int offset)
+{
+	const unsigned char *pData = pFW->data;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mnType = SMS_HTONL(pData[offset],
+			pData[offset + 1], pData[offset + 2],
+			pData[offset + 3]);
+	offset  += 4;
+
+	if (offset + 1 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mbPChkSumPresent error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mbPChkSumPresent = pData[offset];
+	offset++;
+
+	if (offset + 1 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mnPChkSum error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mnPChkSum = pData[offset];
+	offset++;
+
+	if (offset + 1 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mbYChkSumPresent error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mbYChkSumPresent = pData[offset];
+	offset++;
+
+	if (offset + 1 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mnYChkSum error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mnYChkSum = pData[offset];
+	offset++;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: blk_size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->blk_size = SMS_HTONL(pData[offset],
+			pData[offset + 1], pData[offset + 2],
+			pData[offset + 3]);
+	offset  += 4;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: nSublocks error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->nSublocks = SMS_HTONL(pData[offset],
+		pData[offset + 1], pData[offset + 2], pData[offset + 3]);
+	offset  += 4;
+
+	pBlock->mpData = kzalloc(pBlock->blk_size, GFP_KERNEL);
+	if (pBlock->mpData == NULL) {
+		offset = -1;
+		goto out;
+	}
+	memcpy(pBlock->mpData, &pData[offset], pBlock->blk_size);
+	offset  += pBlock->blk_size;
+out:
+	return offset;
+}
+
+static int fw_parse_data_kernel(struct TFirmware *pFirmware,
+	struct TData *pImageData, const struct firmware *pFW, int offset)
+{
+	const unsigned char *pData = pFW->data;
+	unsigned int nBlock;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pImageData->mnBlocks = SMS_HTONL(pData[offset],
+		pData[offset + 1], pData[offset + 2], pData[offset + 3]);
+	offset  += 4;
+
+	pImageData->mpBlocks =
+		kcalloc(pImageData->mnBlocks, sizeof(struct TBlock),
+			GFP_KERNEL);
+	if (pImageData->mpBlocks == NULL) {
+		dev_err(pFirmware->dev, "%s: FW memory failed!\n", __func__);
+		goto out;
+	}
+
+	for (nBlock = 0; nBlock < pImageData->mnBlocks; nBlock++) {
+		offset = fw_parse_block_data_kernel(pFirmware,
+			&(pImageData->mpBlocks[nBlock]), pFW, offset);
+		if (offset < 0) {
+			offset = -1;
+			goto out;
+		}
+	}
+out:
+	return offset;
+}
+
+int fw_parse_program_data_kernel(struct tasdevice_priv *tas_dev,
+	struct TFirmware *pFirmware,
+	const struct firmware *pFW, int offset)
+{
+	struct TProgram *pProgram;
+	const unsigned char *buf = pFW->data;
+	unsigned int  nProgram = 0;
+
+	for (nProgram = 0; nProgram < pFirmware->mnPrograms; nProgram++) {
+		pProgram = &(pFirmware->mpPrograms[nProgram]);
+		if (offset + 64 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		memcpy(pProgram->mpName, &buf[offset], 64);
+		offset  += 64;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnAppMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnAppMode = buf[offset];
+		offset++;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPDMI2SMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnPDMI2SMode = buf[offset];
+		offset++;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnISnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnISnsPD = buf[offset];
+		offset++;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnVSnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnVSnsPD = buf[offset];
+		offset++;
+		//skip 3-byte reserved
+		offset  += 3;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPowerLDG error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnPowerLDG = buf[offset];
+		offset++;
+
+		offset = fw_parse_data_kernel(pFirmware, &(pProgram->mData),
+			pFW, offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+int fw_parse_configuration_data_kernel(
+	struct tasdevice_priv *tas_dev,
+	struct TFirmware *pFirmware, const struct firmware *pFW, int offset)
+{
+	const unsigned char *pData = pFW->data;
+
+	unsigned int nConfiguration;
+	struct TConfiguration *pConfiguration;
+
+	for (nConfiguration = 0; nConfiguration < pFirmware->mnConfigurations;
+		nConfiguration++) {
+		pConfiguration =
+			&(pFirmware->mpConfigurations[nConfiguration]);
+		if (offset + 64 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		memcpy(pConfiguration->mpName, &pData[offset], 64);
+		offset  += 64;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnDevice_orientation error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnDevice_orientation = pData[offset];
+		offset++;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnDevices error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnDevices = pData[offset + 1];
+		offset  += 1;
+
+		if (offset + 2 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mProgram error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mProgram = SMS_HTONS(pData[offset],
+			pData[offset + 1]);
+		offset  += 2;
+
+		if (offset + 4 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnSamplingRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnSamplingRate = SMS_HTONL(pData[offset],
+			pData[offset + 1], pData[offset + 2],
+			pData[offset + 3]);
+		offset  += 4;
+
+		if (offset + 2 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrc error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnPLLSrc = SMS_HTONS(pData[offset],
+			pData[offset + 1]);
+		offset  += 2;
+
+		if (offset + 2 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnFsRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnFsRate = SMS_HTONS(pData[offset],
+			pData[offset + 1]);
+		offset  += 2;
+
+		if (offset + 4 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrcRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnPLLSrcRate = SMS_HTONL(pData[offset],
+			pData[offset + 1], pData[offset + 2],
+			pData[offset + 3]);
+		offset  += 4;
+		offset = fw_parse_data_kernel(pFirmware,
+			&(pConfiguration->mData), pFW, offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+int fw_parse_variable_header_kernel(struct tasdevice_priv *tas_dev,
+	const struct firmware *pFW, int offset)
+{
+	struct TFirmware *pFirmware = tas_dev->mpFirmware;
+	struct tasdevice_dspfw_hdr *pFw_hdr = &(pFirmware->fw_hdr);
+	const unsigned char *buf = pFW->data;
+	struct TProgram *pProgram;
+	struct TConfiguration *pConfiguration;
+	unsigned int  nProgram = 0, nConfiguration = 0;
+	unsigned short maxConf = TASDEVICE_MAXCONFIG_NUM_KERNEL;
+
+	if (offset + 2 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_hdr->mnDeviceFamily = SMS_HTONS(buf[offset], buf[offset + 1]);
+	if (pFw_hdr->mnDeviceFamily != 0) {
+		dev_err(tas_dev->dev, "ERROR:%s:not TAS device\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 2;
+	if (offset + 2 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnDevice error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_hdr->mnDevice = SMS_HTONS(buf[offset], buf[offset + 1]);
+	if (pFw_hdr->mnDevice >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		pFw_hdr->mnDevice == 6) {
+		dev_err(tas_dev->dev, "ERROR:%s: not support device %d\n",
+			__func__, pFw_hdr->mnDevice);
+		offset = -1;
+		goto out;
+	}
+	offset  += 2;
+	pFw_hdr->ndev = deviceNumber[pFw_hdr->mnDevice];
+
+	if (pFw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"%s: ndev(%u) in dspbin dismatch ndev(%u) in DTS\n",
+			__func__, pFw_hdr->ndev, tas_dev->ndev);
+		offset = -1;
+		goto out;
+	}
+
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnPrograms error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFirmware->mnPrograms = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+
+	if (pFirmware->mnPrograms == 0 || pFirmware->mnPrograms >
+		TASDEVICE_MAXPROGRAM_NUM_KERNEL) {
+		dev_err(tas_dev->dev, "%s: mnPrograms is invalid\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	if (offset + 4 * TASDEVICE_MAXPROGRAM_NUM_KERNEL > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mpPrograms error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	pFirmware->mpPrograms =
+		kcalloc(pFirmware->mnPrograms,
+		sizeof(struct TProgram), GFP_KERNEL);
+	if (pFirmware->mpPrograms == NULL) {
+		dev_err(tas_dev->dev, "%s: mpPrograms memory failed!\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	for (nProgram = 0; nProgram < pFirmware->mnPrograms; nProgram++) {
+		pProgram = &(pFirmware->mpPrograms[nProgram]);
+		pProgram->prog_size = SMS_HTONL(buf[offset], buf[offset + 1],
+			buf[offset + 2], buf[offset + 3]);
+		pFirmware->cfg_start_offset  += pProgram->prog_size;
+		offset  += 4;
+	}
+	offset  += (4 * (5 - nProgram));
+
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	pFirmware->mnConfigurations = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	maxConf = (pFw_hdr->ndev >= 4) ?
+		TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS :
+		TASDEVICE_MAXCONFIG_NUM_KERNEL;
+	if (pFirmware->mnConfigurations == 0 ||
+		pFirmware->mnConfigurations > maxConf) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations is invalid\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	if (offset + 4 * maxConf > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mpConfigurations error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	pFirmware->mpConfigurations = kcalloc(pFirmware->mnConfigurations,
+		sizeof(struct TConfiguration), GFP_KERNEL);
+	if (pFirmware->mpConfigurations == NULL) {
+		offset = -1;
+		goto out;
+	}
+
+	for (nConfiguration = 0; nConfiguration < pFirmware->mnPrograms;
+		nConfiguration++) {
+		pConfiguration =
+			&(pFirmware->mpConfigurations[nConfiguration]);
+		pConfiguration->cfg_size = SMS_HTONL(buf[offset],
+			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+	}
+
+	offset  += (4 * (maxConf - nConfiguration));
+	pFirmware->prog_start_offset = offset;
+	pFirmware->cfg_start_offset  += offset;
+out:
+	return offset;
+}
+
+int tasdevice_load_block_kernel(struct tasdevice_priv *pTAS2781,
+	struct TBlock *pBlock)
+{
+	int nResult = 0;
+
+	unsigned char *pData = pBlock->mpData;
+	unsigned int i = 0, length = 0;
+	const unsigned int blk_size = pBlock->blk_size;
+	unsigned char dev_idx = 0;
+	struct tasdevice_dspfw_hdr *pFw_hdr = &(pTAS2781->mpFirmware->fw_hdr);
+	struct tasdevice_fw_fixed_hdr *pFw_fixed_hdr = &(pFw_hdr->mnFixedHdr);
+
+	if (pFw_fixed_hdr->mnPPCVersion >= PPC3_VERSION) {
+		switch (pBlock->mnType) {
+		case MAIN_ALL_DEVICES_1X:
+			dev_idx = 0|0x80;
+			break;
+		case MAIN_DEVICE_A_1X:
+			dev_idx = 1|0x80;
+			break;
+		case COEFF_DEVICE_A_1X:
+		case PRE_DEVICE_A_1X:
+			dev_idx = 1|0xC0;
+			break;
+		case MAIN_DEVICE_B_1X:
+			dev_idx = 2|0x80;
+			break;
+		case COEFF_DEVICE_B_1X:
+		case PRE_DEVICE_B_1X:
+			dev_idx = 2|0xC0;
+			break;
+		case MAIN_DEVICE_C_1X:
+			dev_idx = 3|0x80;
+			break;
+		case COEFF_DEVICE_C_1X:
+		case PRE_DEVICE_C_1X:
+			dev_idx = 3|0xC0;
+			break;
+		case MAIN_DEVICE_D_1X:
+			dev_idx = 4|0x80;
+			break;
+		case COEFF_DEVICE_D_1X:
+		case PRE_DEVICE_D_1X:
+			dev_idx = 4|0xC0;
+			break;
+		default:
+			dev_info(pTAS2781->dev,
+				"%s: TAS2781 load block: Other Type = 0x%02x\n",
+				__func__, pBlock->mnType);
+			break;
+		}
+	} else {
+		switch (pBlock->mnType) {
+		case MAIN_ALL_DEVICES:
+			dev_idx = 0|0x80;
+			break;
+		case MAIN_DEVICE_A:
+			dev_idx = 1|0x80;
+			break;
+		case COEFF_DEVICE_A:
+		case PRE_DEVICE_A:
+			dev_idx = 1|0xC0;
+			break;
+		case MAIN_DEVICE_B:
+			dev_idx = 2|0x80;
+			break;
+		case COEFF_DEVICE_B:
+		case PRE_DEVICE_B:
+			dev_idx = 2|0xC0;
+			break;
+		case MAIN_DEVICE_C:
+			dev_idx = 3|0x80;
+			break;
+		case COEFF_DEVICE_C:
+		case PRE_DEVICE_C:
+			dev_idx = 3|0xC0;
+			break;
+		case MAIN_DEVICE_D:
+			dev_idx = 4|0x80;
+			break;
+		case COEFF_DEVICE_D:
+		case PRE_DEVICE_D:
+			dev_idx = 4|0xC0;
+			break;
+		default:
+			dev_info(pTAS2781->dev,
+				"%s: TAS2781 load block: Other Type = 0x%02x\n",
+				__func__,
+				pBlock->mnType);
+			break;
+		}
+	}
+
+	for (i = 0; i < pBlock->nSublocks; i++) {
+		int rc = tasdevice_process_block(pTAS2781, pData + length,
+			dev_idx, blk_size - length);
+		if (rc < 0) {
+			dev_err(pTAS2781->dev,
+				"%s: ERROR:%u %u sublock write error\n",
+				__func__, length, blk_size);
+			break;
+		}
+		length  += (unsigned int)rc;
+		if (blk_size < length) {
+			dev_err(pTAS2781->dev,
+				"%s: ERROR:%u %u out of memory\n",
+				__func__, length, blk_size);
+			break;
+		}
+	}
+
+	return nResult;
+}
+
+int fw_parse_variable_header_git(struct tasdevice_priv *tas_dev,
+	const struct firmware *pFW, int offset)
+{
+	const unsigned char *buf = pFW->data;
+	struct TFirmware *pFirmware = tas_dev->mpFirmware;
+	struct tasdevice_dspfw_hdr *pFw_hdr = &(pFirmware->fw_hdr);
+	int i = strlen((char *)&buf[offset]);
+
+	i++;
+
+	if (offset + i > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	pFw_hdr->mpDescription = kmemdup(&buf[offset], i, GFP_KERNEL);
+	if (pFw_hdr->mpDescription == NULL)
+		goto out;
+	offset  += i;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_hdr->mnDeviceFamily = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (pFw_hdr->mnDeviceFamily != 0) {
+		dev_err(tas_dev->dev, "ERROR:%s: not TAS device\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_hdr->mnDevice = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (pFw_hdr->mnDevice >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		pFw_hdr->mnDevice == 6) {
+		dev_err(tas_dev->dev, "ERROR:%s: not support device %d\n",
+			__func__, pFw_hdr->mnDevice);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	pFw_hdr->ndev = deviceNumber[pFw_hdr->mnDevice];
+	if (pFw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"%s: ndev(%u) in dspbin dismatch ndev(%u) in DTS\n",
+			__func__, pFw_hdr->ndev,
+			tas_dev->ndev);
+		offset = -1;
+	}
+
+out:
+	return offset;
+}
+
+int fw_parse_variable_header_cal(struct tasdevice_priv *tas_dev,
+	struct TFirmware *pCalFirmware, const struct firmware *pFW, int offset)
+{
+	const unsigned char *buf = pFW->data;
+	struct tasdevice_dspfw_hdr *pFw_hdr = &(pCalFirmware->fw_hdr);
+	int i = strlen((char *)&buf[offset]);
+
+	i++;
+
+	if (offset + i > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	pFw_hdr->mpDescription = kmemdup(&buf[offset], i, GFP_KERNEL);
+	if (pFw_hdr->mpDescription == NULL)
+		goto out;
+	offset  += i;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnDeviceFamily error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_hdr->mnDeviceFamily = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (pFw_hdr->mnDeviceFamily != 0) {
+		dev_err(tas_dev->dev, "ERROR:%s: not TAS device\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnDevice error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_hdr->mnDevice = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (pFw_hdr->mnDevice >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		pFw_hdr->mnDevice == 6) {
+		dev_err(tas_dev->dev, "ERROR:%s: not support device %d\n",
+			__func__, pFw_hdr->mnDevice);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	pFw_hdr->ndev = deviceNumber[pFw_hdr->mnDevice];
+	if (pFw_hdr->ndev != 1) {
+		dev_err(tas_dev->dev,
+			"%s: calbin must be 1, but currently ndev(%u)\n",
+			__func__, pFw_hdr->ndev);
+		offset = -1;
+	}
+
+out:
+	return offset;
+}
+
+static inline void tas2781_clear_Calfirmware(struct TFirmware
+	*mpCalFirmware)
+{
+	int i = 0;
+	unsigned int nBlock = 0;
+
+	if (mpCalFirmware->mpCalibrations) {
+		struct TCalibration *pCalibration;
+
+		for (i = 0; i < mpCalFirmware->mnCalibrations; i++) {
+			pCalibration = &(mpCalFirmware->mpCalibrations[i]);
+			if (pCalibration) {
+				struct TData *pImageData =
+					&(pCalibration->mData);
+
+				if (pImageData->mpBlocks) {
+					struct TBlock *pBlock;
+
+					for (nBlock = 0; nBlock <
+						pImageData->mnBlocks;
+						nBlock++) {
+						pBlock =
+						&(pImageData->mpBlocks[nBlock]);
+						kfree(pBlock->mpData);
+					}
+				kfree(pImageData->mpBlocks);
+				}
+				kfree(pCalibration->mpDescription);
+			}
+		}
+		kfree(mpCalFirmware->mpCalibrations);
+	}
+	kfree(mpCalFirmware);
+}
+
+static int fw_parse_block_data(struct TFirmware *pFirmware,
+	struct TBlock *pBlock, const struct firmware *pFW, int offset)
+{
+	unsigned char *pData = (unsigned char *)pFW->data;
+	int n;
+
+	if (offset + 4 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mnType error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mnType = SMS_HTONL(pData[offset],
+		pData[offset + 1], pData[offset + 2], pData[offset + 3]);
+	offset  += 4;
+
+	if (pFirmware->fw_hdr.mnFixedHdr.mnDriverVersion >=
+		PPC_DRIVER_CRCCHK) {
+		if (offset + 1 > pFW->size) {
+			dev_err(pFirmware->dev, "%s: mbPChkSumPresent error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pBlock->mbPChkSumPresent = pData[offset];
+		offset++;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(pFirmware->dev, "%s: mnPChkSum error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pBlock->mnPChkSum = pData[offset];
+		offset++;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(pFirmware->dev, "%s: mbYChkSumPresent error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pBlock->mbYChkSumPresent = pData[offset];
+		offset++;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(pFirmware->dev, "%s: mnYChkSum error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pBlock->mnYChkSum = pData[offset];
+		offset++;
+	} else {
+		pBlock->mbPChkSumPresent = 0;
+		pBlock->mbYChkSumPresent = 0;
+	}
+	if (offset + 4 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mnCommands error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mnCommands = SMS_HTONL(pData[offset],
+		pData[offset + 1], pData[offset + 2], pData[offset + 3]);
+	offset  += 4;
+
+	n = pBlock->mnCommands * 4;
+	if (offset + n > pFW->size) {
+		dev_err(pFirmware->dev,
+			"%s: File Size(%u) error offset = %d n = %d\n",
+			__func__, pFW->size, offset, n);
+		offset = -1;
+		goto out;
+	}
+	pBlock->mpData = kmemdup(&pData[offset], n, GFP_KERNEL);
+	if (pBlock->mpData == NULL) {
+		offset = -1;
+		goto out;
+	}
+	offset  += n;
+out:
+	return offset;
+}
+
+static int fw_parse_data(struct TFirmware *pFirmware,
+	struct TData *pImageData, const struct firmware *pFW, int offset)
+{
+	const unsigned char *pData = (unsigned char *)pFW->data;
+	int n = 0;
+	unsigned int nBlock;
+
+	if (offset + 64 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mpName error\n", __func__);
+		n = -1;
+		goto out;
+	}
+	memcpy(pImageData->mpName, &pData[offset], 64);
+	offset  += 64;
+
+	n = strlen((char *)&pData[offset]);
+	n++;
+	if (offset + n > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mpDescription error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pImageData->mpDescription = kmemdup(pData, n, GFP_KERNEL);
+	if (pImageData->mpDescription == NULL)
+		goto out;
+	offset  += n;
+
+	if (offset + 2 > pFW->size) {
+		dev_err(pFirmware->dev, "%s: mnBlocks error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pImageData->mnBlocks = SMS_HTONS(pData[offset], pData[offset + 1]);
+	offset  += 2;
+
+	pImageData->mpBlocks =
+		kcalloc(pImageData->mnBlocks, sizeof(struct TBlock),
+			GFP_KERNEL);
+	if (pImageData->mpBlocks == NULL) {
+		dev_err(pFirmware->dev, "%s: FW memory failed!\n", __func__);
+		goto out;
+	}
+	for (nBlock = 0; nBlock < pImageData->mnBlocks; nBlock++) {
+		offset = fw_parse_block_data(pFirmware,
+			&(pImageData->mpBlocks[nBlock]), pFW, offset);
+		if (offset < 0) {
+			offset = -1;
+			goto out;
+		}
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_calibration_data(struct tasdevice_priv *tas_dev,
+	struct TFirmware *pFirmware, const struct firmware *pFW, int offset)
+{
+	unsigned char *pData = (unsigned char *)pFW->data;
+	unsigned int n = 0;
+	unsigned int nCalibration = 0;
+	struct TCalibration *pCalibration = NULL;
+
+	if (offset + 2 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnCalibrations error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFirmware->mnCalibrations = SMS_HTONS(pData[offset],
+		pData[offset + 1]);
+	offset  += 2;
+
+	if (pFirmware->mnCalibrations != 1) {
+		dev_err(tas_dev->dev,
+			"%s: only support one calibraiton(%d)!\n",
+			__func__, pFirmware->mnCalibrations);
+		goto out;
+	}
+
+	pFirmware->mpCalibrations =
+		kcalloc(pFirmware->mnCalibrations, sizeof(struct TCalibration),
+			GFP_KERNEL);
+	if (pFirmware->mpCalibrations == NULL) {
+		dev_err(tas_dev->dev, "%s: mpCalibrations memory failed!\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	for (nCalibration = 0; nCalibration < pFirmware->mnCalibrations;
+		nCalibration++) {
+		if (offset + 64 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpCalibrations error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pCalibration = &(pFirmware->mpCalibrations[nCalibration]);
+		memcpy(pCalibration->mpName, &pData[offset], 64);
+		offset  += 64;
+
+		n = strlen((char *)&pData[offset]);
+		n++;
+		if (offset + n > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpDescription error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pCalibration->mpDescription = kmemdup(&pData[offset], n,
+			GFP_KERNEL);
+		if (pCalibration->mpDescription == NULL) {
+			offset = -1;
+			goto out;
+		}
+		offset  += n;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnProgram error, offset = %d\n", __func__,
+				offset);
+			offset = -1;
+			goto out;
+		}
+		pCalibration->mnProgram = pData[offset];
+		offset++;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnConfiguration error, offset = %d\n",
+				__func__,
+				offset);
+			offset = -1;
+			goto out;
+		}
+		pCalibration->mnConfiguration = pData[offset];
+		offset++;
+
+		offset = fw_parse_data(pFirmware, &(pCalibration->mData), pFW,
+			offset);
+		if (offset < 0)
+			goto out;
+	}
+
+out:
+
+	return offset;
+}
+
+static int fw_parse_program_data(struct tasdevice_priv *tas_dev,
+	struct TFirmware *pFirmware, const struct firmware *pFW, int offset)
+{
+	struct TProgram *pProgram;
+	unsigned char *buf = (unsigned char *)pFW->data;
+	int nProgram = 0;
+
+	if (offset + 2 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFirmware->mnPrograms = SMS_HTONS(buf[offset], buf[offset + 1]);
+	offset  += 2;
+
+	if (pFirmware->mnPrograms == 0) {
+		dev_err(tas_dev->dev, "%s: mnPrograms is null, maybe calbin\n",
+			__func__);
+		//Do not "offset = -1;", because of calbin
+		goto out;
+	}
+
+	pFirmware->mpPrograms =
+		kcalloc(pFirmware->mnPrograms, sizeof(struct TProgram),
+			GFP_KERNEL);
+	if (pFirmware->mpPrograms == NULL) {
+		offset = -1;
+		goto out;
+	}
+	for (nProgram = 0; nProgram < pFirmware->mnPrograms; nProgram++) {
+		int n = 0;
+
+		pProgram = &(pFirmware->mpPrograms[nProgram]);
+		if (offset + 64 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
+			offset = -1;
+			goto out;
+		}
+		memcpy(pProgram->mpName, &buf[offset], 64);
+		offset  += 64;
+
+		n = strlen((char *)&buf[offset]);
+		n++;
+		if (offset + n > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpDescription error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mpDescription = kmemdup(&buf[offset], n, GFP_KERNEL);
+		if (pProgram->mpDescription == NULL) {
+			offset = -1;
+			goto out;
+		}
+
+		offset  += n;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnAppMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnAppMode = buf[offset];
+		offset++;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPDMI2SMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnPDMI2SMode = buf[offset];
+		offset++;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnISnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnISnsPD = buf[offset];
+		offset++;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnVSnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnVSnsPD = buf[offset];
+		offset++;
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPowerLDG error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pProgram->mnPowerLDG = buf[offset];
+		offset++;
+
+		offset = fw_parse_data(pFirmware, &(pProgram->mData), pFW,
+			offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_configuration_data(
+	struct tasdevice_priv *tas_dev,
+	struct TFirmware *pFirmware,
+	const struct firmware *pFW, int offset)
+{
+	unsigned char *pData = (unsigned char *)pFW->data;
+	int n;
+	unsigned int nConfiguration;
+	struct TConfiguration *pConfiguration;
+
+	if (offset + 2 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFirmware->mnConfigurations = SMS_HTONS(pData[offset],
+		pData[offset + 1]);
+	offset  += 2;
+
+	if (pFirmware->mnConfigurations == 0) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations is zero\n",
+			__func__);
+		//Do not "offset = -1;", because of calbin
+		goto out;
+	}
+	pFirmware->mpConfigurations =
+		kcalloc(pFirmware->mnConfigurations,
+				sizeof(struct TConfiguration), GFP_KERNEL);
+
+	for (nConfiguration = 0; nConfiguration < pFirmware->mnConfigurations;
+		nConfiguration++) {
+		pConfiguration =
+			&(pFirmware->mpConfigurations[nConfiguration]);
+		if (offset + 64 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: File Size error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		memcpy(pConfiguration->mpName, &pData[offset], 64);
+		offset  += 64;
+
+		n = strlen((char *)&pData[offset]);
+		n++;
+		if (offset + n > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mpDescription error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mpDescription = kmemdup(&pData[offset], n,
+			GFP_KERNEL);
+
+		if (pConfiguration->mpDescription == NULL) {
+			dev_err(tas_dev->dev, "%s: FW memory failed!\n",
+				__func__);
+			goto out;
+		}
+		offset  += n;
+		if (offset + 2 > pFW->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnDevice_orientation error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnDevice_orientation = pData[offset];
+
+		pConfiguration->mnDevices = pData[offset + 1];
+		offset  += 2;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mProgram error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mProgram = pData[offset];
+		offset++;
+
+		if (offset + 4 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnSamplingRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnSamplingRate = SMS_HTONL(pData[offset],
+			pData[offset + 1], pData[offset + 2],
+			pData[offset + 3]);
+		offset  += 4;
+
+		if (offset + 1 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrc error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnPLLSrc = pData[offset];
+		offset++;
+
+		if (offset + 4 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrcRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnPLLSrcRate = SMS_HTONL(pData[offset],
+			pData[offset + 1], pData[offset + 2],
+			pData[offset + 3]);
+		offset  += 4;
+
+		if (offset + 2 > pFW->size) {
+			dev_err(tas_dev->dev, "%s: mnFsRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		pConfiguration->mnFsRate = SMS_HTONS(pData[offset],
+			pData[offset + 1]);
+		offset  += 2;
+
+		offset = fw_parse_data(pFirmware, &(pConfiguration->mData),
+			pFW, offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_header(struct tasdevice_priv *tas_dev,
+	struct TFirmware *pFirmware, const struct firmware *pFW, int offset)
+{
+	struct tasdevice_dspfw_hdr *pFw_hdr = &(pFirmware->fw_hdr);
+	struct tasdevice_fw_fixed_hdr *pFw_fixed_hdr = &(pFw_hdr->mnFixedHdr);
+	const unsigned char *buf = (unsigned char *)pFW->data;
+	int i = 0;
+	unsigned char pMagicNumber[] = { 0x35, 0x35, 0x35, 0x32 };
+
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	if (memcmp(&buf[offset], pMagicNumber, 4)) {
+		dev_err(tas_dev->dev, "%s: Magic number doesn't match",
+			__func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	pFw_fixed_hdr->mnMagicNumber = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnFWSize error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_fixed_hdr->mnFWSize = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	if (pFw_fixed_hdr->mnFWSize != pFW->size) {
+		dev_err(tas_dev->dev, "File size not match, %d %d", pFW->size,
+			pFw_fixed_hdr->mnFWSize);
+		offset = -1;
+		goto out;
+	}
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnChecksum error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_fixed_hdr->mnChecksum = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnPPCVersion error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_fixed_hdr->mnPPCVersion = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnFWVersion error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_fixed_hdr->mnFWVersion = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnDriverVersion error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	pFw_fixed_hdr->mnDriverVersion = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mnTimeStamp error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	for (i = 0; i < sizeof(BinFileformatVerInfo) /
+		sizeof(BinFileformatVerInfo[0]); i++) {
+		if (BinFileformatVerInfo[i][DRVFWVER] ==
+			pFw_fixed_hdr->mnDriverVersion) {
+			pFw_hdr->mnBinFileDocVer =
+				BinFileformatVerInfo[i][BINFILEDOCVER];
+			break;
+		}
+	}
+	pFw_fixed_hdr->mnTimeStamp = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 64 > pFW->size) {
+		dev_err(tas_dev->dev, "%s: mpDDCName error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	memcpy(pFw_fixed_hdr->mpDDCName, &buf[offset], 64);
+	offset  += 64;
+
+ out:
+	return offset;
+}
+
+static const unsigned char crc8_lookup_table[CRC8_TABLE_SIZE] = {
+	0x00, 0x4D, 0x9A, 0xD7, 0x79, 0x34, 0xE3, 0xAE,
+	0xF2, 0xBF, 0x68, 0x25, 0x8B, 0xC6, 0x11, 0x5C,
+	0xA9, 0xE4, 0x33, 0x7E, 0xD0, 0x9D, 0x4A, 0x07,
+	0x5B, 0x16, 0xC1, 0x8C, 0x22, 0x6F, 0xB8, 0xF5,
+	0x1F, 0x52, 0x85, 0xC8, 0x66, 0x2B, 0xFC, 0xB1,
+	0xED, 0xA0, 0x77, 0x3A, 0x94, 0xD9, 0x0E, 0x43,
+	0xB6, 0xFB, 0x2C, 0x61, 0xCF, 0x82, 0x55, 0x18,
+	0x44, 0x09, 0xDE, 0x93, 0x3D, 0x70, 0xA7, 0xEA,
+	0x3E, 0x73, 0xA4, 0xE9, 0x47, 0x0A, 0xDD, 0x90,
+	0xCC, 0x81, 0x56, 0x1B, 0xB5, 0xF8, 0x2F, 0x62,
+	0x97, 0xDA, 0x0D, 0x40, 0xEE, 0xA3, 0x74, 0x39,
+	0x65, 0x28, 0xFF, 0xB2, 0x1C, 0x51, 0x86, 0xCB,
+	0x21, 0x6C, 0xBB, 0xF6, 0x58, 0x15, 0xC2, 0x8F,
+	0xD3, 0x9E, 0x49, 0x04, 0xAA, 0xE7, 0x30, 0x7D,
+	0x88, 0xC5, 0x12, 0x5F, 0xF1, 0xBC, 0x6B, 0x26,
+	0x7A, 0x37, 0xE0, 0xAD, 0x03, 0x4E, 0x99, 0xD4,
+	0x7C, 0x31, 0xE6, 0xAB, 0x05, 0x48, 0x9F, 0xD2,
+	0x8E, 0xC3, 0x14, 0x59, 0xF7, 0xBA, 0x6D, 0x20,
+	0xD5, 0x98, 0x4F, 0x02, 0xAC, 0xE1, 0x36, 0x7B,
+	0x27, 0x6A, 0xBD, 0xF0, 0x5E, 0x13, 0xC4, 0x89,
+	0x63, 0x2E, 0xF9, 0xB4, 0x1A, 0x57, 0x80, 0xCD,
+	0x91, 0xDC, 0x0B, 0x46, 0xE8, 0xA5, 0x72, 0x3F,
+	0xCA, 0x87, 0x50, 0x1D, 0xB3, 0xFE, 0x29, 0x64,
+	0x38, 0x75, 0xA2, 0xEF, 0x41, 0x0C, 0xDB, 0x96,
+	0x42, 0x0F, 0xD8, 0x95, 0x3B, 0x76, 0xA1, 0xEC,
+	0xB0, 0xFD, 0x2A, 0x67, 0xC9, 0x84, 0x53, 0x1E,
+	0xEB, 0xA6, 0x71, 0x3C, 0x92, 0xDF, 0x08, 0x45,
+	0x19, 0x54, 0x83, 0xCE, 0x60, 0x2D, 0xFA, 0xB7,
+	0x5D, 0x10, 0xC7, 0x8A, 0x24, 0x69, 0xBE, 0xF3,
+	0xAF, 0xE2, 0x35, 0x78, 0xD6, 0x9B, 0x4C, 0x01,
+	0xF4, 0xB9, 0x6E, 0x23, 0x8D, 0xC0, 0x17, 0x5A,
+	0x06, 0x4B, 0x9C, 0xD1, 0x7F, 0x32, 0xE5, 0xA8
+};
+
+static int isInPageYRAM(struct tasdevice_priv *pTAS2781,
+	struct TYCRC *pCRCData,
+	unsigned char nBook, unsigned char nPage,
+	unsigned char nReg, unsigned char len)
+{
+	int nResult = 0;
+
+	if (nBook == TAS2781_YRAM_BOOK1) {
+		if (nPage == TAS2781_YRAM1_PAGE) {
+			if (nReg >= TAS2781_YRAM1_START_REG) {
+				pCRCData->mnOffset = nReg;
+				pCRCData->mnLen = len;
+				nResult = 1;
+			} else if ((nReg + len) > TAS2781_YRAM1_START_REG) {
+				pCRCData->mnOffset = TAS2781_YRAM1_START_REG;
+				pCRCData->mnLen =
+				len - (TAS2781_YRAM1_START_REG - nReg);
+				nResult = 1;
+			} else
+				nResult = 0;
+		} else if (nPage == TAS2781_YRAM3_PAGE) {
+			if (nReg > TAS2781_YRAM3_END_REG) {
+				nResult = 0;
+			} else if (nReg >= TAS2781_YRAM3_START_REG) {
+				if ((nReg + len) > TAS2781_YRAM3_END_REG) {
+					pCRCData->mnOffset = nReg;
+					pCRCData->mnLen =
+					TAS2781_YRAM3_END_REG - nReg + 1;
+					nResult = 1;
+				} else {
+					pCRCData->mnOffset = nReg;
+					pCRCData->mnLen = len;
+					nResult = 1;
+				}
+			} else {
+				if ((nReg + (len-1)) <
+					TAS2781_YRAM3_START_REG)
+					nResult = 0;
+				else {
+					pCRCData->mnOffset =
+					TAS2781_YRAM3_START_REG;
+					pCRCData->mnLen =
+					len - (TAS2781_YRAM3_START_REG - nReg);
+					nResult = 1;
+				}
+			}
+		}
+	} else if (nBook ==
+		TAS2781_YRAM_BOOK2) {
+		if (nPage == TAS2781_YRAM5_PAGE) {
+			if (nReg > TAS2781_YRAM5_END_REG) {
+				nResult = 0;
+			} else if (nReg >= TAS2781_YRAM5_START_REG) {
+				if ((nReg + len) > TAS2781_YRAM5_END_REG) {
+					pCRCData->mnOffset = nReg;
+					pCRCData->mnLen =
+					TAS2781_YRAM5_END_REG - nReg + 1;
+					nResult = 1;
+				} else {
+					pCRCData->mnOffset = nReg;
+					pCRCData->mnLen = len;
+					nResult = 1;
+				}
+			} else {
+				if ((nReg + (len-1)) <
+					TAS2781_YRAM5_START_REG)
+					nResult = 0;
+				else {
+					pCRCData->mnOffset =
+					TAS2781_YRAM5_START_REG;
+					pCRCData->mnLen =
+					len - (TAS2781_YRAM5_START_REG - nReg);
+					nResult = 1;
+				}
+			}
+		}
+	} else
+		nResult = 0;
+
+	return nResult;
+}
+
+static int isInBlockYRAM(struct tasdevice_priv *pTAS2781,
+	struct TYCRC *pCRCData,
+	unsigned char nBook, unsigned char nPage,
+	unsigned char nReg, unsigned char len)
+{
+	int nResult = 0;
+
+	if (nBook == TAS2781_YRAM_BOOK1) {
+		if (nPage < TAS2781_YRAM2_START_PAGE)
+			nResult = 0;
+		else if (nPage <= TAS2781_YRAM2_END_PAGE) {
+			if (nReg > TAS2781_YRAM2_END_REG)
+				nResult = 0;
+			else if (nReg >= TAS2781_YRAM2_START_REG) {
+				pCRCData->mnOffset = nReg;
+				pCRCData->mnLen = len;
+				nResult = 1;
+			} else {
+				if ((nReg + (len-1)) <
+					TAS2781_YRAM2_START_REG)
+					nResult = 0;
+				else {
+					pCRCData->mnOffset =
+					TAS2781_YRAM2_START_REG;
+					pCRCData->mnLen =
+					nReg + len - TAS2781_YRAM2_START_REG;
+					nResult = 1;
+				}
+			}
+		} else
+			nResult = 0;
+	} else if (nBook ==
+		TAS2781_YRAM_BOOK2) {
+		if (nPage < TAS2781_YRAM4_START_PAGE)
+			nResult = 0;
+		else if (nPage <= TAS2781_YRAM4_END_PAGE) {
+			if (nReg > TAS2781_YRAM2_END_REG)
+				nResult = 0;
+			else if (nReg >= TAS2781_YRAM2_START_REG) {
+				pCRCData->mnOffset = nReg;
+				pCRCData->mnLen = len;
+				nResult = 1;
+			} else {
+				if ((nReg + (len-1))
+					< TAS2781_YRAM2_START_REG)
+					nResult = 0;
+				else {
+					pCRCData->mnOffset =
+					TAS2781_YRAM2_START_REG;
+					pCRCData->mnLen =
+					nReg + len - TAS2781_YRAM2_START_REG;
+					nResult = 1;
+				}
+			}
+		} else
+			nResult = 0;
+	} else
+		nResult = 0;
+
+	return nResult;
+}
+
+static int isYRAM(struct tasdevice_priv *pTAS2781, struct TYCRC *pCRCData,
+	unsigned char nBook, unsigned char nPage,
+	unsigned char nReg, unsigned char len)
+{
+	int nResult = 0;
+
+	nResult = isInPageYRAM(pTAS2781, pCRCData, nBook, nPage, nReg, len);
+	if (nResult == 0)
+		nResult = isInBlockYRAM(pTAS2781, pCRCData, nBook,
+				nPage, nReg, len);
+
+	return nResult;
+}
+
+/*
+ * crc8-calculate a crc8 over the given input data.
+ *
+ * table: crc table used for calculation.
+ * pdata: pointer to data buffer.
+ * nbytes: number of bytes in data buffer.
+ * crc: previous returned crc8 value.
+ */
+static u8 ti_crc8(const u8 table[CRC8_TABLE_SIZE], u8 *pdata,
+			size_t nbytes, u8 crc)
+{
+	/*loop over the buffer data */
+	while (nbytes-- > 0)
+		crc = table[(crc ^ *(pdata  += 1)) & 0xff];
+
+	return crc;
+}
+
+static int doSingleRegCheckSum(struct tasdevice_priv *pTAS2781,
+	enum channel chl,
+		unsigned char nBook, unsigned char nPage,
+		unsigned char nReg, unsigned char nValue)
+{
+	int nResult = 0;
+	struct TYCRC sCRCData;
+	unsigned int nData1 = 0;
+
+	if ((nBook == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (nPage == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (nReg >= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
+		&& (nReg <= (TASDEVICE_PAGE_REG(
+		TAS2781_SA_COEFF_SWAP_REG) + 4))) {
+		/*DSP swap command, pass */
+		nResult = 0;
+		goto end;
+	}
+
+	nResult = isYRAM(pTAS2781, &sCRCData, nBook, nPage, nReg, 1);
+	if (nResult == 1) {
+		nResult = pTAS2781->read(pTAS2781, chl,
+				TASDEVICE_REG(nBook, nPage, nReg), &nData1);
+		if (nResult < 0)
+			goto end;
+
+		if (nData1 != nValue) {
+			dev_err(pTAS2781->dev,
+				"error2, B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
+				nBook, nPage, nReg,
+				nValue, nData1);
+			nResult = -EAGAIN;
+			pTAS2781->tasdevice[chl].mnErrCode |=
+				ERROR_YRAM_CRCCHK;
+			goto end;
+		}
+
+		if (nData1 != nValue) {
+			dev_err(pTAS2781->dev,
+				"error2, B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
+				nBook, nPage, nReg,
+				nValue, nData1);
+			nResult = -EAGAIN;
+			goto end;
+		}
+
+		nResult = ti_crc8(crc8_lookup_table, &nValue, 1, 0);
+	}
+
+end:
+	return nResult;
+}
+
+static int doMultiRegCheckSum(struct tasdevice_priv *pTAS2781,
+	enum channel chn, unsigned char nBook, unsigned char nPage,
+	unsigned char nReg, unsigned int len)
+{
+	int nResult = 0, i = 0;
+	unsigned char nCRCChkSum = 0;
+	unsigned char nBuf1[128] = {0};
+	struct TYCRC TCRCData;
+
+	if ((nReg + len-1) > 127) {
+		nResult = -EINVAL;
+		dev_err(pTAS2781->dev, "firmware error\n");
+		goto end;
+	}
+
+	if ((nBook == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (nPage == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (nReg == TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
+		&& (len == 4)) {
+		/*DSP swap command, pass */
+		nResult = 0;
+		goto end;
+	}
+
+	nResult = isYRAM(pTAS2781, &TCRCData, nBook, nPage, nReg, len);
+	dev_info(pTAS2781->dev,
+		"isYRAM: nBook 0x%x, nPage 0x%x, nReg 0x%x\n",
+		nBook, nPage, nReg);
+	dev_info(pTAS2781->dev,
+		"isYRAM: TCRCData.mnLen 0x%x, len 0x%x, nResult %d\n",
+		TCRCData.mnLen, len, nResult);
+	dev_info(pTAS2781->dev, "TCRCData.mnOffset %x\n", TCRCData.mnOffset);
+	if (nResult == 1) {
+		if (len == 1) {
+			dev_err(pTAS2781->dev, "firmware error\n");
+			nResult = -EINVAL;
+			goto end;
+		} else {
+			nResult = pTAS2781->bulk_read(pTAS2781, chn,
+				TASDEVICE_REG(nBook, nPage, TCRCData.mnOffset),
+				nBuf1, TCRCData.mnLen);
+			if (nResult < 0)
+				goto end;
+
+			for (i = 0; i < TCRCData.mnLen; i++) {
+				if ((nBook == TASDEVICE_BOOK_ID(
+					TAS2781_SA_COEFF_SWAP_REG))
+					&& (nPage == TASDEVICE_PAGE_ID(
+						TAS2781_SA_COEFF_SWAP_REG))
+					&& ((i + TCRCData.mnOffset)
+					>= TASDEVICE_PAGE_REG(
+						TAS2781_SA_COEFF_SWAP_REG))
+					&& ((i + TCRCData.mnOffset)
+					<= (TASDEVICE_PAGE_REG(
+						TAS2781_SA_COEFF_SWAP_REG)
+						+ 4))) {
+					/*DSP swap command, bypass */
+					continue;
+				} else
+					nCRCChkSum  +=
+					ti_crc8(crc8_lookup_table, &nBuf1[i],
+						1, 0);
+			}
+
+			nResult = nCRCChkSum;
+		}
+	}
+
+end:
+	return nResult;
+}
+
+static int tasdevice_load_block(struct tasdevice_priv *tas_dev,
+				struct TBlock *pBlock)
+{
+	int nResult = 0;
+	unsigned int nCommand = 0;
+	unsigned char nBook = 0;
+	unsigned char nPage = 0;
+	unsigned char nOffset = 0;
+	unsigned char nData = 0;
+	unsigned int nLength = 0;
+	unsigned int nSleep = 0;
+	unsigned char nCRCChkSum = 0;
+	unsigned int nValue = 0;
+	int nRetry = 6;
+	unsigned char *pData = pBlock->mpData;
+	int chn = 0, chnend = 0;
+
+	dev_info(tas_dev->dev,
+		"TAS2781 load block: Type = %d, commands = %d\n",
+		pBlock->mnType, pBlock->mnCommands);
+	switch (pBlock->mnType) {
+	case MAIN_ALL_DEVICES:
+		chn = 0;
+		chnend = tas_dev->ndev;
+		break;
+	case MAIN_DEVICE_A:
+	case COEFF_DEVICE_A:
+	case PRE_DEVICE_A:
+		chn = 0;
+		chnend = 1;
+		break;
+	case MAIN_DEVICE_B:
+	case COEFF_DEVICE_B:
+	case PRE_DEVICE_B:
+		chn = 1;
+		chnend = 2;
+		break;
+	case MAIN_DEVICE_C:
+	case COEFF_DEVICE_C:
+	case PRE_DEVICE_C:
+		chn = 2;
+		chnend = 3;
+		break;
+	case MAIN_DEVICE_D:
+	case COEFF_DEVICE_D:
+	case PRE_DEVICE_D:
+		chn = 3;
+		chnend = 4;
+		break;
+	default:
+		dev_info(tas_dev->dev,
+			"TAS2781 load block: Other Type = 0x%02x\n",
+			pBlock->mnType);
+		break;
+	}
+
+	for (; chn < chnend; chn++) {
+		if (tas_dev->tasdevice[chn].bLoading == false)
+			continue;
+start:
+		if (pBlock->mbPChkSumPresent) {
+			nResult = tas_dev->write(tas_dev, chn,
+				TASDEVICE_I2CChecksum, 0);
+			if (nResult < 0)
+				goto end;
+		}
+
+		if (pBlock->mbYChkSumPresent)
+			nCRCChkSum = 0;
+
+		nCommand = 0;
+
+		while (nCommand < pBlock->mnCommands) {
+			pData = pBlock->mpData + nCommand * 4;
+
+			nBook = pData[0];
+			nPage = pData[1];
+			nOffset = pData[2];
+			nData = pData[3];
+
+			nCommand++;
+
+			if (nOffset <= 0x7F) {
+				nResult = tas_dev->write(tas_dev, chn,
+					TASDEVICE_REG(nBook, nPage, nOffset),
+					nData);
+				if (nResult < 0)
+					goto end;
+				if (pBlock->mbYChkSumPresent) {
+					nResult = doSingleRegCheckSum(tas_dev,
+						chn, nBook, nPage, nOffset,
+						nData);
+					if (nResult < 0)
+						goto check;
+					nCRCChkSum  += (unsigned char)nResult;
+				}
+			} else if (nOffset == 0x81) {
+				nSleep = (nBook << 8) + nPage;
+				msleep(nSleep);
+			} else if (nOffset == 0x85) {
+				pData  += 4;
+				nLength = (nBook << 8) + nPage;
+				nBook = pData[0];
+				nPage = pData[1];
+				nOffset = pData[2];
+				if (nLength > 1) {
+					nResult = tas_dev->bulk_write(tas_dev,
+						chn, TASDEVICE_REG(nBook,
+						nPage, nOffset), pData + 3,
+						nLength);
+					if (nResult < 0)
+						goto end;
+					if (pBlock->mbYChkSumPresent) {
+						nResult = doMultiRegCheckSum(
+							tas_dev, chn, nBook,
+							nPage, nOffset,
+							nLength);
+					if (nResult < 0)
+						goto check;
+					nCRCChkSum  +=
+					(unsigned char)nResult;
+					}
+				} else {
+					nResult = tas_dev->write(tas_dev, chn,
+						TASDEVICE_REG(nBook, nPage,
+						nOffset),
+						pData[3]);
+					if (nResult < 0)
+						goto end;
+					if (pBlock->mbYChkSumPresent) {
+						nResult = doSingleRegCheckSum(
+							tas_dev, chn, nBook,
+							nPage, nOffset,
+							pData[3]);
+					if (nResult < 0)
+						goto check;
+					nCRCChkSum  +=
+					(unsigned char)nResult;
+					}
+				}
+
+				nCommand++;
+				if (nLength >= 2)
+					nCommand  += ((nLength - 2) / 4) + 1;
+			}
+		}
+		if (pBlock->mbPChkSumPresent) {
+			nResult = tas_dev->read(tas_dev, chn,
+				TASDEVICE_I2CChecksum, &nValue);
+			if (nResult < 0) {
+				dev_err(tas_dev->dev, "%s: Channel %d\n",
+					__func__, chn);
+				goto check;
+			}
+			if ((nValue&0xff) != pBlock->mnPChkSum) {
+				dev_err(tas_dev->dev,
+					"Block PChkSum Channel %d Error: FW = 0x%x, Reg = 0x%x\n",
+					chn, pBlock->mnPChkSum, (nValue&0xff));
+				nResult = -EAGAIN;
+				tas_dev->tasdevice[chn].mnErrCode |=
+					ERROR_PRAM_CRCCHK;
+				goto check;
+			}
+			nResult = 0;
+			tas_dev->tasdevice[chn].mnErrCode &=
+				~ERROR_PRAM_CRCCHK;
+			dev_info(tas_dev->dev, "Block[0x%02x] PChkSum match\n",
+				pBlock->mnType);
+		}
+
+		if (pBlock->mbYChkSumPresent) {
+			//TBD, open it when FW ready
+			dev_err(tas_dev->dev, "Block YChkSum: FW = 0x%x, YCRC = 0x%x\n",
+				pBlock->mnYChkSum,
+				nCRCChkSum);
+
+			tas_dev->tasdevice[chn].mnErrCode &=
+				~ERROR_YRAM_CRCCHK;
+			nResult = 0;
+			dev_info(tas_dev->dev,
+				"Block[0x%x] YChkSum match\n", pBlock->mnType);
+		}
+check:
+		if (nResult == -EAGAIN) {
+			nRetry--;
+			if (nRetry > 0)
+				goto start;
+			else {
+				if ((pBlock->mnType == MAIN_ALL_DEVICES)
+					|| (pBlock->mnType == MAIN_DEVICE_A)
+					|| (pBlock->mnType == MAIN_DEVICE_B)
+					|| (pBlock->mnType == MAIN_DEVICE_C)
+					|| (pBlock->mnType == MAIN_DEVICE_D)) {
+					tas_dev->tasdevice[chn].mnCurrentProgram
+					= -1;
+				} else {
+					tas_dev->tasdevice[chn].mnCurrentConfiguration
+					= -1;
+				}
+				nRetry = 6;
+			}
+		}
+	}
+end:
+	if (nResult < 0) {
+		dev_err(tas_dev->dev, "Block (%d) load error\n",
+				pBlock->mnType);
+	}
+	return nResult;
+}
+
+
+static int tasdevice_load_data(struct tasdevice_priv *tas_dev,
+	struct TData *pData)
+{
+	int nResult = 0;
+	unsigned int nBlock = 0;
+	struct TBlock *pBlock = NULL;
+
+	dev_info(tas_dev->dev, "%s: TAS2781 load data: %s, Blocks = %d\n",
+		__func__,
+		pData->mpName, pData->mnBlocks);
+
+	for (nBlock = 0; nBlock < pData->mnBlocks; nBlock++) {
+		pBlock = &(pData->mpBlocks[nBlock]);
+		nResult = tas_dev->tasdevice_load_block(tas_dev, pBlock);
+		if (nResult < 0)
+			break;
+	}
+
+	return nResult;
+}
+
+static int tasdevice_load_calibrated_data(
+	struct tasdevice_priv *tas_dev, struct TData *pData)
+{
+	int nResult = 0;
+	unsigned int nBlock = 0;
+	struct TBlock *pBlock = NULL;
+
+	dev_info(tas_dev->dev, "%s: TAS2781 load data: %s, Blocks = %d\n",
+		__func__,
+		pData->mpName, pData->mnBlocks);
+
+	for (nBlock = 0; nBlock < pData->mnBlocks; nBlock++) {
+		pBlock = &(pData->mpBlocks[nBlock]);
+		nResult = tasdevice_load_block(tas_dev, pBlock);
+		if (nResult < 0)
+			break;
+	}
+
+	return nResult;
+}
+
+int tas2781_load_calibration(void *pContext,
+			char *pFileName, enum channel i)
+{
+	int ret = 0, nSize = 0, offset = 0;
+	loff_t pos = 0;
+	struct file *filp = NULL;
+	struct firmware FW;
+	const struct firmware *fw_entry = NULL;
+	char *data = NULL;
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)pContext;
+	struct Ttasdevice *pTasdev = &(tas_dev->tasdevice[i]);
+	struct TFirmware *mpCalFirmware = NULL;
+	char pHint[256];
+
+	ret = request_firmware(&fw_entry, pFileName, tas_dev->dev);
+	if (!ret) {
+		if (!fw_entry->size) {
+			dev_err(tas_dev->dev,
+				"%s: file read error: size = %d\n",
+				__func__, fw_entry->size);
+			goto out;
+		}
+		FW.size = fw_entry->size;
+		FW.data = fw_entry->data;
+		dev_info(tas_dev->dev,
+			"%s: file = %s, file size %zd\n",
+			__func__, pFileName, fw_entry->size);
+	} else {
+		dev_info(tas_dev->dev,
+			"%s: Request firmware failed, try flip_open()\n",
+			__func__);
+
+		scnprintf(pHint, sizeof(pHint), "%s%s\n",
+			TAS2781_CAL_BIN_PATH, pFileName);
+		filp = filp_open(pHint, O_RDONLY, 664);
+		if (!IS_ERR_OR_NULL(filp)) {
+			FW.size = i_size_read(file_inode(filp));
+			dev_info(tas_dev->dev,
+				"%s: file = %s, file size %ld\n",
+				__func__, pHint, (long)FW.size);
+			data = kmalloc(FW.size, GFP_KERNEL);
+			if (data == NULL) {
+				dev_err(tas_dev->dev, "%s: malloc error\n",
+					__func__);
+				goto out;
+			}
+			nSize = (int)kernel_read(filp, data, FW.size, &pos);
+			if (!nSize) {
+				dev_err(tas_dev->dev,
+					"%s: file read error: size = %d\n",
+					__func__, nSize);
+				goto out;
+			}
+			dev_info(tas_dev->dev, "read filed nSize = %d\n",
+				nSize);
+			FW.data = data;
+		} else {
+			dev_err(tas_dev->dev,
+				"%s: cannot open calibration file: %s\n",
+				__func__, pHint);
+			goto out;
+		}
+	}
+
+	mpCalFirmware = pTasdev->mpCalFirmware = kcalloc(1,
+		sizeof(struct TFirmware), GFP_KERNEL);
+	if (pTasdev->mpCalFirmware == NULL) {
+		dev_err(tas_dev->dev, "%s: FW memory failed!\n", __func__);
+		ret = -1;
+		goto out;
+	}
+	mpCalFirmware->dev = tas_dev->dev;
+	offset = fw_parse_header(tas_dev, mpCalFirmware, &FW, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev, "%s: fw_parse_header EXIT!\n", __func__);
+		goto out;
+	}
+	offset = fw_parse_variable_header_cal(tas_dev, mpCalFirmware, &FW,
+		offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev,
+			"%s: fw_parse_variable_header_cal EXIT!\n", __func__);
+		goto out;
+	}
+	offset = fw_parse_program_data(tas_dev, mpCalFirmware, &FW, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev, "%s: fw_parse_program_data EXIT!\n",
+			__func__);
+		goto out;
+	}
+	offset = fw_parse_configuration_data(tas_dev, mpCalFirmware, &FW,
+		offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev,
+			"%s: fw_parse_configuration_data EXIT!\n", __func__);
+		goto out;
+	}
+	offset = fw_parse_calibration_data(tas_dev,
+		mpCalFirmware, &FW, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev, "%s: fw_parse_calibration_data EXIT!\n",
+			__func__);
+		goto out;
+	}
+	pTasdev->mbCalibrationLoaded = true;
+out:
+	if (!IS_ERR_OR_NULL(filp)) {
+		filp_close(filp, NULL);
+		kfree(data);
+	}
+	if (fw_entry) {
+		release_firmware(fw_entry);
+		fw_entry = NULL;
+	}
+	return ret;
+}
+
+int tasdevice_dspfw_ready(const void *pVoid, void *pContext)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+	const struct firmware *pFW = (const struct firmware *)pVoid;
+	struct TFirmware *pFirmware = NULL;
+	struct tasdevice_fw_fixed_hdr *pFw_fixed_hdr = NULL;
+	int offset = 0, ret = 0;
+
+	if (!pFW || !pFW->data) {
+		dev_err(tas_dev->dev, "%s: Failed to read firmware %s\n",
+			__func__, tas_dev->dsp_binaryname);
+		ret = -1;
+		goto out;
+	}
+
+	tas_dev->mpFirmware = kcalloc(1,
+		sizeof(struct TFirmware), GFP_KERNEL);
+	if (tas_dev->mpFirmware == NULL) {
+		ret = -1;
+		goto out;
+	}
+	pFirmware = tas_dev->mpFirmware;
+	pFirmware->dev = tas_dev->dev;
+	offset = fw_parse_header(tas_dev, pFirmware, pFW, offset);
+
+	if (offset == -1)
+		goto out;
+	pFw_fixed_hdr = &(pFirmware->fw_hdr.mnFixedHdr);
+	switch (pFw_fixed_hdr->mnDriverVersion) {
+	case 0x301:
+	case 0x302:
+	case 0x502:
+		tas_dev->fw_parse_variable_header =
+			fw_parse_variable_header_kernel;
+		tas_dev->fw_parse_program_data =
+			fw_parse_program_data_kernel;
+		tas_dev->fw_parse_configuration_data =
+			fw_parse_configuration_data_kernel;
+		tas_dev->tasdevice_load_block =
+			tasdevice_load_block_kernel;
+		pFirmware->bKernelFormat = true;
+		break;
+	case 0x202:
+	case 0x400:
+		tas_dev->fw_parse_variable_header =
+			fw_parse_variable_header_git;
+		tas_dev->fw_parse_program_data =
+			fw_parse_program_data;
+		tas_dev->fw_parse_configuration_data =
+			fw_parse_configuration_data;
+		tas_dev->tasdevice_load_block =
+			tasdevice_load_block;
+		pFirmware->bKernelFormat = false;
+		break;
+	default:
+	if (pFw_fixed_hdr->mnDriverVersion == 0x100) {
+		if (pFw_fixed_hdr->mnPPCVersion >= PPC3_VERSION) {
+			tas_dev->fw_parse_variable_header =
+				fw_parse_variable_header_kernel;
+			tas_dev->fw_parse_program_data =
+				fw_parse_program_data_kernel;
+			tas_dev->fw_parse_configuration_data =
+				fw_parse_configuration_data_kernel;
+			tas_dev->tasdevice_load_block =
+				tasdevice_load_block_kernel;
+			tas_dev->fw_parse_calibration_data = NULL;
+		} else {
+			switch (pFw_fixed_hdr->mnPPCVersion) {
+			case 0x00:
+				tas_dev->fw_parse_variable_header =
+					fw_parse_variable_header_git;
+				tas_dev->fw_parse_program_data =
+					fw_parse_program_data;
+				tas_dev->fw_parse_configuration_data =
+					fw_parse_configuration_data;
+				tas_dev->fw_parse_calibration_data =
+					fw_parse_calibration_data;
+				tas_dev->tasdevice_load_block =
+					tasdevice_load_block;
+				break;
+			default:
+				dev_err(tas_dev->dev,
+					"%s: PPCVersion must be 0x0 or 0x%02x Current:0x%02x\n",
+					__func__, PPC3_VERSION,
+					pFw_fixed_hdr->mnPPCVersion);
+				offset = -1;
+				break;
+			}
+		}
+	} else {
+		dev_err(tas_dev->dev,
+			"%s: DriverVersion must be 0x0, 0x230 or above 0x230:0x%02x\n",
+			__func__,
+			pFw_fixed_hdr->mnDriverVersion);
+		offset = -1;
+	}
+		break;
+	}
+
+	offset = tas_dev->fw_parse_variable_header(tas_dev, pFW, offset);
+	if (offset == -1)
+		goto out;
+
+	offset = tas_dev->fw_parse_program_data(tas_dev, pFirmware, pFW,
+		offset);
+	if (offset < 0) {
+		ret = -1;
+		goto out;
+	}
+	offset = tas_dev->fw_parse_configuration_data(tas_dev,
+		pFirmware, pFW, offset);
+	if (offset < 0)
+		ret = -1;
+
+out:
+	return ret;
+}
+
+void tasdevice_calbin_remove(void *pContext)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+	struct Ttasdevice *pTasdev = NULL;
+	int i = 0;
+
+	if (tas_dev) {
+		for (i = 0; i < tas_dev->ndev; i++) {
+			pTasdev = &(tas_dev->tasdevice[i]);
+			if (pTasdev->mpCalFirmware) {
+				tas2781_clear_Calfirmware(
+					pTasdev->mpCalFirmware);
+				pTasdev->mpCalFirmware = NULL;
+			}
+		}
+	}
+}
+
+void tasdevice_dsp_remove(void *pContext)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+	int i = 0;
+
+	if (tas_dev) {
+		if (tas_dev->mpFirmware) {
+			struct TFirmware *pFirmware = tas_dev->mpFirmware;
+
+			if (pFirmware->mpPrograms) {
+				struct TProgram *pProgram;
+
+				for (i = 0; i < pFirmware->mnPrograms; i++) {
+					pProgram = &(pFirmware->mpPrograms[i]);
+					if (pProgram) {
+						struct TData *pImageData =
+							&(pProgram->mData);
+
+					if (pImageData->mpBlocks) {
+						struct TBlock *pBlock;
+						unsigned int nBlock;
+
+					for (nBlock = 0;
+						nBlock <
+						pImageData->mnBlocks;
+						nBlock++) {
+						pBlock =
+							&(pImageData->mpBlocks[nBlock]);
+						kfree(pBlock->mpData);
+					}
+						kfree(pImageData->mpBlocks);
+						}
+						kfree(pProgram->mpDescription);
+					}
+				}
+				kfree(pFirmware->mpPrograms);
+			}
+
+			if (pFirmware->mpConfigurations) {
+				struct TConfiguration *pConfig;
+
+				for (i = 0; i < pFirmware->mnConfigurations;
+					i++) {
+					pConfig =
+					&(pFirmware->mpConfigurations[i]);
+					if (pConfig) {
+						struct TData *pImageData =
+							&(pConfig->mData);
+
+					if (pImageData->mpBlocks) {
+						struct TBlock *pBlock;
+						unsigned int nBlock;
+
+					for (nBlock = 0;
+						nBlock <
+							pImageData->mnBlocks;
+						nBlock++) {
+						pBlock =
+							&(pImageData->mpBlocks[nBlock]);
+						kfree(pBlock->mpData);
+					}
+						kfree(pImageData->mpBlocks);
+					}
+					kfree(pConfig->mpDescription);
+					}
+				}
+				kfree(pFirmware->mpConfigurations);
+			}
+			kfree(pFirmware->fw_hdr.mpDescription);
+			kfree(pFirmware);
+			tas_dev->mpFirmware = NULL;
+		}
+	}
+}
+
+void tasdevice_select_tuningprm_cfg(void *pContext, int prm_no,
+	int cfg_no, int regbin_conf_no)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+	struct tasdevice_regbin *regbin = &(tas_dev->mtRegbin);
+	struct tasdevice_config_info **cfg_info = regbin->cfg_info;
+	struct TFirmware *pFirmware = tas_dev->mpFirmware;
+	struct TConfiguration *pConfigurations = NULL;
+	struct TProgram *pProgram = NULL;
+	int i = 0;
+	int status = 0;
+
+	if (pFirmware == NULL) {
+		dev_err(tas_dev->dev, "%s: Firmware is NULL\n", __func__);
+		goto out;
+	}
+
+	if (cfg_no >= pFirmware->mnConfigurations) {
+		dev_err(tas_dev->dev,
+			"%s: cfg(%d) is not in range of conf %u\n",
+			__func__, cfg_no, pFirmware->mnConfigurations);
+		goto out;
+	}
+
+	if (prm_no >= pFirmware->mnPrograms || prm_no == 1) {
+		dev_err(tas_dev->dev,
+			"%s: prm(%d) is not in range of Programs %u\n",
+			__func__,  prm_no, pFirmware->mnPrograms);
+		goto out;
+	}
+
+	if (regbin_conf_no > regbin->ncfgs || regbin_conf_no < 0 ||
+		cfg_info == NULL) {
+		dev_err(tas_dev->dev,
+			"conf_no:%d should be in range from 0 to %u\n",
+			regbin_conf_no, regbin->ncfgs-1);
+		goto out;
+	} else {
+		dev_info(tas_dev->dev, "%s: regbin_profile_conf_id = %d\n",
+			__func__, regbin_conf_no);
+	}
+
+	tas_dev->mnCurrentConfiguration = cfg_no;
+	tas_dev->mnCurrentProgram = prm_no;
+
+	pConfigurations = &(pFirmware->mpConfigurations[cfg_no]);
+	for (i = 0; i < tas_dev->ndev; i++) {
+		if (cfg_info[regbin_conf_no]->active_dev & (1 << i)) {
+			if (tas_dev->tasdevice[i].mnCurrentProgram != prm_no) {
+				tas_dev->tasdevice[i].mnCurrentConfiguration
+					= -1;
+				tas_dev->tasdevice[i].bLoading = true;
+				status++;
+			}
+		} else
+			tas_dev->tasdevice[i].bLoading = false;
+		tas_dev->tasdevice[i].bLoaderr = false;
+	}
+
+	if (status) {
+		pProgram = &(pFirmware->mpPrograms[prm_no]);
+		tasdevice_load_data(tas_dev, &(pProgram->mData));
+		for (i = 0; i < tas_dev->ndev; i++) {
+			if (tas_dev->tasdevice[i].bLoaderr == true)
+				continue;
+			else if (tas_dev->tasdevice[i].bLoaderr == false
+				&& tas_dev->tasdevice[i].bLoading == true) {
+				struct TFirmware *pCalFirmware =
+					tas_dev->tasdevice[i].mpCalFirmware;
+
+				if (pCalFirmware) {
+					struct TCalibration *pCalibration =
+						pCalFirmware->mpCalibrations;
+
+					if (pCalibration)
+						tasdevice_load_calibrated_data(
+							tas_dev,
+							&(pCalibration->mData));
+				}
+				tas_dev->tasdevice[i].mnCurrentProgram
+					= prm_no;
+			}
+		}
+	}
+
+	if (tas_dev->mbCalibrationLoaded == false) {
+		for (i = 0; i < tas_dev->ndev; i++)
+			tas_dev->set_calibration(tas_dev, i, 0x100);
+		tas_dev->mbCalibrationLoaded = true;
+		/* No wise to reload calibrationdata everytime,
+		 * this code will work once even if calibrated
+		 * data still failed to be got
+		 */
+	}
+
+	status = 0;
+	for (i = 0; i < tas_dev->ndev; i++) {
+		dev_info(tas_dev->dev, "%s,fun %d,%d,%d\n", __func__,
+			tas_dev->tasdevice[i].mnCurrentConfiguration,
+			cfg_info[regbin_conf_no]->active_dev,
+			tas_dev->tasdevice[i].bLoaderr);
+		if (tas_dev->tasdevice[i].mnCurrentConfiguration != cfg_no
+			&& (cfg_info[regbin_conf_no]->active_dev & (1 << i))
+			&& (tas_dev->tasdevice[i].bLoaderr == false)) {
+			status++;
+			tas_dev->tasdevice[i].bLoading = true;
+		} else
+			tas_dev->tasdevice[i].bLoading = false;
+	}
+
+	if (status) {
+		status = 0;
+		tasdevice_load_data(tas_dev, &(pConfigurations->mData));
+		for (i = 0; i < tas_dev->ndev; i++) {
+			if (tas_dev->tasdevice[i].bLoaderr == true) {
+				status |= 1 << (i + 4);
+				continue;
+			} else if (tas_dev->tasdevice[i].bLoaderr == false
+				&& tas_dev->tasdevice[i].bLoading == true) {
+				tas_dev->tasdevice[i].mnCurrentConfiguration
+					= cfg_no;
+				tas_dev->tasdevice[i].bDSPBypass = false;
+			}
+		}
+	} else {
+		dev_err(tas_dev->dev,
+			"%s: No device is in active in conf %d\n",
+			__func__, regbin_conf_no);
+	}
+
+	status |= cfg_info[regbin_conf_no]->active_dev;
+	dev_info(tas_dev->dev, "%s: DSP mode: load status is %08x\n",
+		__func__, status);
+out:
+	return;
+}
+
+int tas2781_set_calibration(void *pContext, enum channel i,
+	int nCalibration)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+	int nResult = 0;
+	struct Ttasdevice *pTasdev = &(tas_dev->tasdevice[i]);
+	struct TFirmware *pCalFirmware = pTasdev->mpCalFirmware;
+
+	if ((!tas_dev->mpFirmware->mpPrograms)
+		|| (!tas_dev->mpFirmware->mpConfigurations)) {
+		dev_err(tas_dev->dev, "%s, Firmware not loaded\n\r", __func__);
+		nResult = 0;
+		goto out;
+	}
+
+	if (nCalibration == 0xFF || (nCalibration == 0x100
+		&& pTasdev->mbCalibrationLoaded == false)) {
+		if (pCalFirmware) {
+			pTasdev->mbCalibrationLoaded = false;
+			tas2781_clear_Calfirmware(pCalFirmware);
+			pCalFirmware = NULL;
+		}
+
+		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
+			tas_dev->dev_name, tas_dev->tasdevice[i].mnDevAddr);
+		nResult = tas2781_load_calibration(tas_dev,
+			tas_dev->cal_binaryname[i], i);
+		if (nResult != 0) {
+			dev_err(tas_dev->dev,
+				"%s: load %s error, no-side effect for playback\n",
+				__func__, tas_dev->cal_binaryname[i]);
+			nResult = 0;
+		}
+	}
+	pTasdev->bLoading = true;
+	pTasdev->bLoaderr = false;
+
+	if (pCalFirmware) {
+		struct TCalibration *pCalibration =
+			pCalFirmware->mpCalibrations;
+
+		if (pCalibration)
+			tasdevice_load_calibrated_data(tas_dev,
+				&(pCalibration->mData));
+	} else
+		dev_err(tas_dev->dev,
+			"%s: No calibrated data for device %d\n", __func__, i);
+
+out:
+	return nResult;
+}
diff --git a/sound/soc/codecs/tas2781-dsp.h b/sound/soc/codecs/tas2781-dsp.h
new file mode 100644
index 000000000..f7b689ad6
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.h
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable register setting
+ * for one, two, even multiple TAS2781 chips. All the register setting are in
+ * a bin file. Almost no specific register setting can be found in the code.
+ *
+ * Author: Shenghao Ding <shenghao-ding@ti.com>
+ *         Kevin Lu <kevin-lu@ti.com>
+ */
+
+#ifndef __TASDEVICE_DSP_H__
+#define __TASDEVICE_DSP_H__
+
+#define MAIN_ALL_DEVICES			(0x0d)
+#define MAIN_DEVICE_A				(0x01)
+#define MAIN_DEVICE_B				(0x08)
+#define MAIN_DEVICE_C				(0x10)
+#define MAIN_DEVICE_D				(0x14)
+#define COEFF_DEVICE_A				(0x03)
+#define COEFF_DEVICE_B				(0x0a)
+#define COEFF_DEVICE_C				(0x11)
+#define COEFF_DEVICE_D				(0x15)
+#define PRE_DEVICE_A				(0x04)
+#define PRE_DEVICE_B				(0x0b)
+#define PRE_DEVICE_C				(0x12)
+#define PRE_DEVICE_D				(0x16)
+
+#define PPC3_VERSION 0x4100
+#define REGBIN_CONFIGID_BYPASS_ALL	(0)
+#define TASDEVICE_DEVICE_SUM  (8)
+#define TASDEVICE_CONFIG_SUM  (64)
+
+enum channel {
+	TopLeftChn = 0x00,
+	TopRightChn = 0x01,
+	BottomLeftChn = 0x02,
+	BottomRightChn = 0x03,
+	MaxChn,
+};
+
+enum tasdevice_dsp_dev_idx {
+	TASDEVICE_DSP_TAS_2555 = 0,
+	TASDEVICE_DSP_TAS_2555_STEREO,
+	TASDEVICE_DSP_TAS_2557_MONO,
+	TASDEVICE_DSP_TAS_2557_DUAL_MONO,
+	TASDEVICE_DSP_TAS_2559,
+	TASDEVICE_DSP_TAS_2563,
+	TASDEVICE_DSP_TAS_2563_DUAL_MONO = 7,
+	TASDEVICE_DSP_TAS_2563_QUAD,
+	TASDEVICE_DSP_TAS_2563_21,
+	TASDEVICE_DSP_TAS_2781,
+	TASDEVICE_DSP_TAS_2781_DUAL_MONO,
+	TASDEVICE_DSP_TAS_2781_21,
+	TASDEVICE_DSP_TAS_2781_QUAD,
+	TASDEVICE_DSP_TAS_MAX_DEVICE
+};
+
+struct tasdevice_fw_fixed_hdr {
+	unsigned int mnMagicNumber;
+	unsigned int mnFWSize;
+	unsigned int mnChecksum;
+	unsigned int mnPPCVersion;
+	unsigned int mnFWVersion;
+	unsigned int mnDriverVersion;
+	unsigned int mnTimeStamp;
+	char mpDDCName[64];
+};
+
+struct tasdevice_dspfw_hdr {
+	struct tasdevice_fw_fixed_hdr mnFixedHdr;
+	unsigned int mnBinFileDocVer;
+	char *mpDescription;
+	unsigned short mnDeviceFamily;
+	unsigned short mnDevice;
+	unsigned char ndev;
+};
+
+struct TBlock {
+	unsigned int mnType;
+	unsigned char mbPChkSumPresent;
+	unsigned char mnPChkSum;
+	unsigned char mbYChkSumPresent;
+	unsigned char mnYChkSum;
+	unsigned int mnCommands;
+	unsigned int blk_size;
+	unsigned int nSublocks;
+	unsigned char *mpData;
+};
+
+struct TData {
+	char mpName[64];
+	char *mpDescription;
+	unsigned int mnBlocks;
+	struct TBlock *mpBlocks;
+};
+struct TProgram {
+	unsigned int prog_size;
+	char mpName[64];
+	char *mpDescription;
+	unsigned char mnAppMode;
+	unsigned char mnPDMI2SMode;
+	unsigned char mnISnsPD;
+	unsigned char mnVSnsPD;
+	unsigned char mnPowerLDG;
+	struct TData mData;
+};
+
+struct TConfiguration {
+	unsigned int cfg_size;
+	char mpName[64];
+	char *mpDescription;
+	unsigned char mnDevice_orientation;
+	unsigned char mnDevices;
+	unsigned int mProgram;
+	unsigned int mnSamplingRate;
+	unsigned short mnPLLSrc;
+	unsigned int mnPLLSrcRate;
+	unsigned int mnFsRate;
+	struct TData mData;
+};
+
+struct TCalibration {
+	char mpName[64];
+	char *mpDescription;
+	unsigned int mnProgram;
+	unsigned int mnConfiguration;
+	struct TData mData;
+};
+
+struct TFirmware {
+	struct tasdevice_dspfw_hdr fw_hdr;
+	unsigned int prog_start_offset;
+	unsigned short mnPrograms;
+	struct TProgram *mpPrograms;
+	unsigned int cfg_start_offset;
+	unsigned short mnConfigurations;
+	struct TConfiguration *mpConfigurations;
+	unsigned short mnCalibrations;
+	struct TCalibration *mpCalibrations;
+	bool bKernelFormat;
+	struct device *dev;
+};
+
+enum tasdevice_dsp_fw_state {
+	TASDEVICE_DSP_FW_NONE = 0,
+	TASDEVICE_DSP_FW_PENDING,
+	TASDEVICE_DSP_FW_FAIL,
+	TASDEVICE_DSP_FW_ALL_OK,
+};
+
+enum tasdevice_bin_blk_type {
+	TASDEVICE_BIN_BLK_COEFF = 1,
+	TASDEVICE_BIN_BLK_POST_POWER_UP,
+	TASDEVICE_BIN_BLK_PRE_SHUTDOWN,
+	TASDEVICE_BIN_BLK_PRE_POWER_UP,
+	TASDEVICE_BIN_BLK_POST_SHUTDOWN
+};
+
+struct tasdevice_regbin_hdr {
+	unsigned int img_sz;
+	unsigned int checksum;
+	unsigned int binary_version_num;
+	unsigned int drv_fw_version;
+	unsigned int timestamp;
+	unsigned char plat_type;
+	unsigned char dev_family;
+	unsigned char reserve;
+	unsigned char ndev;
+	unsigned char devs[TASDEVICE_DEVICE_SUM];
+	unsigned int nconfig;
+	unsigned int config_size[TASDEVICE_CONFIG_SUM];
+};
+
+struct tasdevice_block_data {
+	unsigned char dev_idx;
+	unsigned char block_type;
+	unsigned short yram_checksum;
+	unsigned int block_size;
+	unsigned int nSublocks;
+	unsigned char *regdata;
+};
+
+struct tasdevice_config_info {
+	char mpName[64];
+	unsigned int nblocks;
+	unsigned int real_nblocks;
+	unsigned char active_dev;
+	struct tasdevice_block_data **blk_data;
+};
+
+struct tasdevice_regbin {
+	struct tasdevice_regbin_hdr fw_hdr;
+	int ncfgs;
+	struct tasdevice_config_info **cfg_info;
+	int profile_cfg_id;
+};
+
+int tasdevice_dspfw_ready(const void *pVoid, void *pContext);
+void tasdevice_dsp_remove(void *pContext);
+void tasdevice_calbin_remove(void *pContext);
+int tas2781_load_calibration(void *tas_dev, char *pFileName,
+	enum channel i);
+int tas2781_set_calibration(void *pContext, enum channel i,
+	int nCalibration);
+void tasdevice_select_tuningprm_cfg(void *pContext, int prm,
+	int cfg_no, int regbin_conf_no);
+
+#endif
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
new file mode 100644
index 000000000..3ee254777
--- /dev/null
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -0,0 +1,2143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable register setting
+ * for one, two, even multiple TAS2781 chips. All the register setting are in
+ * a bin file. Almost no specific register setting can be found in the code.
+ *
+ * Author: Shenghao Ding <shenghao-ding@ti.com>
+ *         Kevin Lu <kevin-lu@ti.com>
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/firmware.h>
+#include <linux/of_gpio.h>
+#include <linux/interrupt.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+
+#include "tas2781.h"
+
+/* max. length of a alsa mixer control name */
+#define MAX_CONTROL_NAME		(48)
+#define TASDEVICE_CLK_DIR_IN		(0)
+#define TASDEVICE_CLK_DIR_OUT		(1)
+
+#define TASDEVICE_IRQ_DET_TIMEOUT		(30000)
+#define TASDEVICE_IRQ_DET_CNT_LIMIT		(500)
+#define TAS2781_REG_INT_LTCH0	TASDEVICE_REG(0X0, 0x0, 0x49)
+#define TAS2781_REG_INT_LTCH1	TASDEVICE_REG(0X0, 0x0, 0x4A)
+#define TAS2781_REG_INT_LTCH1_0	TASDEVICE_REG(0X0, 0x0, 0x4B)
+#define TAS2781_REG_INT_LTCH2	TASDEVICE_REG(0X0, 0x0, 0x4F)
+#define TAS2781_REG_INT_LTCH3	TASDEVICE_REG(0X0, 0x0, 0x50)
+#define TAS2781_REG_INT_LTCH4	TASDEVICE_REG(0X0, 0x0, 0x51)
+
+const char *blocktype[5] = {
+	"COEFF",
+	"POST_POWER_UP",
+	"PRE_SHUTDOWN",
+	"PRE_POWER_UP",
+	"POST_SHUTDOWN"
+};
+
+static const char * const dts_dev_addr_tag[] = {
+	"ti,topleft-channel",
+	"ti,topright-channel",
+	"ti,bottomleft-channel",
+	"ti,bottomright-channel"
+};
+
+static const char *dts_rst_tag = "ti,%s-gpio%d";
+
+static const char *dts_glb_addr_tag = "ti,global-address";
+
+static const struct i2c_device_id tasdevice_id[] = {
+	{ "audev", GENERAL_AUDEV },
+	{ "tas2781", TAS2781	 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tasdevice_id);
+
+static bool tasdevice_volatile(struct device *dev, unsigned int reg)
+{
+	return true;
+}
+
+static bool tasdevice_writeable(struct device *dev, unsigned int reg)
+{
+	return true;
+}
+
+static const struct regmap_config tasdevice_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = tasdevice_writeable,
+	.volatile_reg = tasdevice_volatile,
+	.cache_type = REGCACHE_FLAT,
+	.max_register = 1 * 128,
+};
+
+static const struct of_device_id tasdevice_of_match[] = {
+	{ .compatible = "ti,audev" },
+	{ .compatible = "ti,tas2781" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, tasdevice_of_match);
+
+int tasdevice_process_block(void *pContext,
+	unsigned char *data, unsigned char dev_idx, int sublocksize)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *)pContext;
+	unsigned char subblk_typ = data[1];
+	int subblk_offset = 2;
+	int chn = 0, chnend = 0;
+	int rc = 0;
+	int blktyp = dev_idx & 0xC0, idx = dev_idx & 0x3F;
+	bool bError = false;
+
+	if (idx) {
+		chn = idx-1;
+		chnend = idx;
+	} else {
+		if (tas_dev->glb_addr.mnDevAddr) {
+			chn = tas_dev->ndev;
+			chnend = tas_dev->ndev + 1;
+		} else {
+			chn = 0;
+			chnend = tas_dev->ndev;
+		}
+	}
+
+	for (; chn < chnend; chn++) {
+		if (tas_dev->glb_addr.mnDevAddr == 0 &&
+			tas_dev->tasdevice[chn].bLoading == false)
+			continue;
+
+		bError = false;
+		subblk_offset = 2;
+		switch (subblk_typ) {
+		case TASDEVICE_CMD_SING_W: {
+			int i = 0;
+			unsigned short len = SMS_HTONS(data[2], data[3]);
+
+			subblk_offset  += 2;
+			if (subblk_offset + 4 * len > sublocksize) {
+				dev_err(tas_dev->dev,
+					"process_block: Out of memory\n");
+				bError = true;
+				break;
+			}
+
+			for (i = 0; i < len; i++) {
+				rc = tasdevice_dev_write(tas_dev, chn,
+					TASDEVICE_REG(data[subblk_offset],
+						data[subblk_offset + 1],
+						data[subblk_offset + 2]),
+					data[subblk_offset + 3]);
+				if (rc < 0) {
+					bError = true;
+					dev_err(tas_dev->dev,
+						"process_block: single write error\n");
+				}
+				subblk_offset  += 4;
+			}
+		}
+			break;
+		case TASDEVICE_CMD_BURST: {
+			unsigned short len = SMS_HTONS(data[2], data[3]);
+
+			subblk_offset  += 2;
+			if (subblk_offset + 4 + len > sublocksize) {
+				dev_err(tas_dev->dev,
+					"process_block: BURST Out of memory\n");
+				bError = true;
+				break;
+			}
+			if (len % 4) {
+				dev_err(tas_dev->dev,
+				"process_block: Burst len(%u) can be divided by 4\n",
+				len);
+				break;
+			}
+
+			rc = tasdevice_dev_bulk_write(tas_dev, chn,
+				TASDEVICE_REG(data[subblk_offset],
+					data[subblk_offset + 1],
+					data[subblk_offset + 2]),
+					&(data[subblk_offset + 4]), len);
+			if (rc < 0) {
+				bError = true;
+				dev_err(tas_dev->dev,
+					"process_block: bulk_write error = %d\n",
+					rc);
+			}
+			subblk_offset  += (len + 4);
+		}
+			break;
+		case TASDEVICE_CMD_DELAY: {
+			unsigned short delay_time = 0;
+
+			if (subblk_offset + 2 > sublocksize) {
+				dev_err(tas_dev->dev,
+					"process_block: deley Out of memory\n");
+				bError = true;
+				break;
+			}
+			delay_time = SMS_HTONS(data[2], data[3]);
+			usleep_range(delay_time*1000, delay_time*1000);
+			subblk_offset  += 2;
+		}
+			break;
+		case TASDEVICE_CMD_FIELD_W:
+		if (subblk_offset + 6 > sublocksize) {
+			dev_err(tas_dev->dev,
+				"process_block: bit write Out of memory\n");
+			bError = true;
+			break;
+		}
+		rc = tasdevice_dev_update_bits(tas_dev, chn,
+			TASDEVICE_REG(data[subblk_offset + 2],
+				data[subblk_offset + 3],
+				data[subblk_offset + 4]),
+				data[subblk_offset + 1],
+				data[subblk_offset + 5]);
+		if (rc < 0) {
+			bError = true;
+			dev_err(tas_dev->dev,
+				"process_block: update_bits error = %d\n", rc);
+		}
+		subblk_offset  += 6;
+			break;
+		default:
+			break;
+		};
+		if (bError == true && blktyp != 0) {
+			if (blktyp == 0x80) {
+				tas_dev->tasdevice[chn].mnCurrentProgram = -1;
+				tas_dev->tasdevice[chn].mnCurrentConfiguration =
+				-1;
+			} else
+				tas_dev->tasdevice[chn].mnCurrentConfiguration =
+				-1;
+		}
+	}
+	return subblk_offset;
+}
+
+void tasdevice_select_cfg_blk(void *pContext, int conf_no,
+	unsigned char block_type)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) pContext;
+	struct tasdevice_regbin *regbin = &(tas_dev->mtRegbin);
+	struct tasdevice_config_info **cfg_info = regbin->cfg_info;
+	int j = 0, k = 0, chn = 0, chnend = 0;
+
+	if (conf_no >= regbin->ncfgs || conf_no < 0 || NULL == cfg_info) {
+		dev_err(tas_dev->dev,
+			"conf_no should be not more than %u\n",
+			regbin->ncfgs);
+		goto out;
+	} else
+		dev_info(tas_dev->dev,
+			"select_cfg_blk: profile_conf_id = %d\n",
+			conf_no);
+
+	for (j = 0; j < (int)cfg_info[conf_no]->real_nblocks; j++) {
+		unsigned int length = 0, rc = 0;
+
+		if (block_type > 5 || block_type < 2) {
+			dev_err(tas_dev->dev,
+			"ERROR!!!block_type should be in range from 2 to 5\n");
+			goto out;
+		}
+		if (block_type != cfg_info[conf_no]->blk_data[j]->block_type)
+			continue;
+		dev_info(tas_dev->dev,
+		"select_cfg_blk: conf %d, block type:%s\t device idx = 0x%02x\n",
+		conf_no, blocktype[cfg_info[conf_no]->blk_data[j]
+		->block_type-1], cfg_info[conf_no]->blk_data[j]
+		->dev_idx);
+
+		for (k = 0; k < (int)cfg_info[conf_no]->blk_data[j]
+			->nSublocks; k++) {
+			if (cfg_info[conf_no]->blk_data[j]->dev_idx) {
+				chn =
+				cfg_info[conf_no]->blk_data[j]->dev_idx
+				- 1;
+				chnend =
+				cfg_info[conf_no]->blk_data[j]->dev_idx;
+			} else {
+				chn = 0;
+				chnend = tas_dev->ndev;
+			}
+			for (; chn < chnend; chn++)
+				tas_dev->tasdevice[chn].bLoading = true;
+
+			rc = tasdevice_process_block(tas_dev,
+				cfg_info[conf_no]->blk_data[j]->regdata +
+					length,
+				cfg_info[conf_no]->blk_data[j]->dev_idx,
+				cfg_info[conf_no]->blk_data[j]->block_size -
+					length);
+			length  += rc;
+			if (cfg_info[conf_no]->blk_data[j]->block_size <
+				length) {
+				dev_err(tas_dev->dev,
+					"select_cfg_blk: ERROR:%u %u out of memory\n",
+					length,
+					cfg_info[conf_no]->blk_data[j]->block_size);
+				break;
+			}
+		}
+		if (length != cfg_info[conf_no]->blk_data[j]->block_size)
+			dev_err(tas_dev->dev,
+				"select_cfg_blk: ERROR: %u %u size is not same\n",
+				length,
+				cfg_info[conf_no]->blk_data[j]->block_size);
+
+	}
+
+out:
+	return;
+}
+
+static struct tasdevice_config_info *tasdevice_add_config(
+	void *pContext, unsigned char *config_data,
+	unsigned int config_size)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *)pContext;
+	struct tasdevice_config_info *cfg_info = NULL;
+	int config_offset = 0, i = 0;
+
+	cfg_info = kzalloc(
+			sizeof(struct tasdevice_config_info), GFP_KERNEL);
+	if (!cfg_info)
+		goto out;
+
+	if (tas_dev->mtRegbin.fw_hdr.binary_version_num >= 0x105) {
+		if (config_offset + 64 > (int)config_size) {
+			dev_err(tas_dev->dev,
+				"add config: Out of memory\n");
+			goto out;
+		}
+		memcpy(cfg_info->mpName, &config_data[config_offset], 64);
+		config_offset  += 64;
+	}
+
+	if (config_offset + 4 > (int)config_size) {
+		dev_err(tas_dev->dev,
+			"add config: Out of memory\n");
+		goto out;
+	}
+	cfg_info->nblocks =
+		SMS_HTONL(config_data[config_offset],
+		config_data[config_offset + 1],
+	config_data[config_offset + 2], config_data[config_offset + 3]);
+	config_offset  +=  4;
+
+	cfg_info->blk_data = kcalloc(
+		cfg_info->nblocks, sizeof(struct tasdevice_block_data *),
+		GFP_KERNEL);
+	if (!cfg_info->blk_data) {
+		dev_err(tas_dev->dev,
+			"add config: blk_data alloc failed!\n");
+		goto out;
+	}
+	cfg_info->real_nblocks = 0;
+	for (i = 0; i < (int)cfg_info->nblocks; i++) {
+		if (config_offset + 12 > config_size) {
+			dev_err(tas_dev->dev,
+			"add config: Out of memory: i = %d nblocks = %u!\n",
+			i, cfg_info->nblocks);
+			break;
+		}
+		cfg_info->blk_data[i] = kzalloc(
+			sizeof(struct tasdevice_block_data), GFP_KERNEL);
+		if (!cfg_info->blk_data[i])
+			break;
+
+		cfg_info->blk_data[i]->dev_idx = config_data[config_offset];
+		config_offset++;
+
+		cfg_info->blk_data[i]->block_type = config_data[config_offset];
+		config_offset++;
+
+		if (cfg_info->blk_data[i]->block_type  ==
+			TASDEVICE_BIN_BLK_PRE_POWER_UP) {
+			if (cfg_info->blk_data[i]->dev_idx == 0) {
+				cfg_info->active_dev = 1;
+			} else {
+				cfg_info->active_dev =
+					1 <<
+					(cfg_info->blk_data[i]->dev_idx - 1);
+			}
+		}
+		cfg_info->blk_data[i]->yram_checksum =
+			SMS_HTONS(config_data[config_offset],
+			config_data[config_offset + 1]);
+		config_offset  += 2;
+		cfg_info->blk_data[i]->block_size =
+			SMS_HTONL(config_data[config_offset],
+			config_data[config_offset + 1],
+			config_data[config_offset + 2],
+		config_data[config_offset + 3]);
+		config_offset  += 4;
+
+		cfg_info->blk_data[i]->nSublocks =
+			SMS_HTONL(config_data[config_offset],
+			config_data[config_offset + 1],
+			config_data[config_offset + 2],
+		config_data[config_offset + 3]);
+
+		config_offset  += 4;
+		cfg_info->blk_data[i]->regdata = kzalloc(
+			cfg_info->blk_data[i]->block_size, GFP_KERNEL);
+		if (cfg_info->blk_data[i]->regdata == 0) {
+			dev_err(tas_dev->dev,
+				"add config: regdata alloc failed!\n");
+			goto out;
+		}
+		if (config_offset + cfg_info->blk_data[i]->block_size
+			> config_size) {
+			dev_err(tas_dev->dev,
+			"add config: block_size Out of memory: i = %d nblocks = %u!\n",
+			i,
+			cfg_info->nblocks);
+			break;
+		}
+		memcpy(cfg_info->blk_data[i]->regdata,
+			&config_data[config_offset],
+		cfg_info->blk_data[i]->block_size);
+		config_offset  += cfg_info->blk_data[i]->block_size;
+		cfg_info->real_nblocks  += 1;
+	}
+out:
+	return cfg_info;
+}
+static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int val;
+	int ret = 0;
+
+	/* Read the primary device as the whole */
+	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_dev->dev,
+		"%s, get digital vol error\n",
+		__func__);
+		goto out;
+	}
+	val = (val > mc->max) ? mc->max : val;
+	val = mc->invert ? mc->max - val : val;
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+}
+
+static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int val;
+	int i, ret = 0;
+
+	val = ucontrol->value.integer.value[0];
+	val = (val > mc->max) ? mc->max : val;
+	val = mc->invert ? mc->max - val : val;
+	val = (val < 0) ? 0 : val;
+	if (tas_dev->tas2781_set_global != NULL) {
+		ret = tasdevice_dev_write(tas_dev, tas_dev->ndev,
+			mc->reg, val);
+		if (ret)
+			dev_err(tas_dev->dev,
+			"%s, set digital vol error in global mode\n",
+			__func__);
+	} else {
+		for (i = 0; i < tas_dev->ndev; i++) {
+			ret = tasdevice_dev_write(tas_dev, i,
+				mc->reg, val);
+			if (ret)
+				dev_err(tas_dev->dev,
+				"%s, set digital vol error in device %d\n",
+				__func__, i);
+		}
+	}
+
+	return ret;
+}
+
+static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int val;
+	unsigned char mask = 0;
+	int ret = 0;
+
+	/* Read the primary device */
+	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_dev->dev,
+		"%s, get AMP vol error\n",
+		__func__);
+		goto out;
+	}
+
+	mask = (1 << fls(mc->max)) - 1;
+	mask <<= mc->shift;
+	val = (val & mask) >> mc->shift;
+	val = (val > mc->max) ? mc->max : val;
+	val = mc->invert ? mc->max - val : val;
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+}
+
+static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int val;
+	int i, ret = 0;
+	unsigned char mask = 0;
+
+	mask = (1 << fls(mc->max)) - 1;
+	mask <<= mc->shift;
+	val = ucontrol->value.integer.value[0];
+	val = (val > mc->max) ? mc->max : val;
+	val = mc->invert ? mc->max - val : val;
+	val = (val < 0) ? 0 : val;
+	for (i = 0; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			mc->reg,
+			mask,
+			val << mc->shift);
+		if (ret)
+			dev_err(tas_dev->dev,
+			"%s, set AMP vol error in device %d\n",
+			__func__, i);
+	}
+
+	return ret;
+}
+
+static const DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
+
+static const struct snd_kcontrol_new tas2781_snd_controls[] = {
+	SOC_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2781_AMP_LEVEL,
+		1, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, amp_vol_tlv),
+	SOC_SINGLE_RANGE_EXT_TLV("Digital Volume Control", TAS2781_DVC_LVL,
+		0, 0, 200, 1, tas2781_digital_getvol,
+		tas2781_digital_putvol, dvc_tlv),
+};
+
+static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *p_tasdevice =
+		snd_soc_component_get_drvdata(codec);
+
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	p_tasdevice->mtRegbin.profile_cfg_id =
+		ucontrol->value.integer.value[0];
+	/* Codec Lock Release*/
+	mutex_unlock(&p_tasdevice->codec_lock);
+
+	return 0;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *p_tasdevice =
+		snd_soc_component_get_drvdata(codec);
+	struct TFirmware *Tfw = p_tasdevice->mpFirmware;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)Tfw->mnPrograms;
+	/* Codec Lock Release*/
+	mutex_unlock(&p_tasdevice->codec_lock);
+	return 0;
+}
+
+static int tasdevice_info_configurations(
+	struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *p_tasdevice =
+		snd_soc_component_get_drvdata(codec);
+	struct TFirmware *Tfw = p_tasdevice->mpFirmware;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)Tfw->mnConfigurations - 1;
+	/* Codec Lock Release*/
+	mutex_unlock(&p_tasdevice->codec_lock);
+
+	return 0;
+}
+
+static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *p_tasdevice =
+		snd_soc_component_get_drvdata(codec);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = max(0, p_tasdevice->mtRegbin.ncfgs);
+	/* Codec Lock Release*/
+	mutex_unlock(&p_tasdevice->codec_lock);
+	return 0;
+}
+
+static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *p_tasdevice
+		= snd_soc_component_get_drvdata(codec);
+
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	ucontrol->value.integer.value[0] =
+		p_tasdevice->mtRegbin.profile_cfg_id;
+	/* Codec Lock Release*/
+	mutex_unlock(&p_tasdevice->codec_lock);
+
+	return 0;
+}
+
+static int tasdevice_create_controls(struct tasdevice_priv *tas_dev)
+{
+	int  nr_controls = 1, ret = 0, mix_index = 0;
+	char *name = NULL;
+	struct snd_kcontrol_new *tasdevice_profile_controls = NULL;
+
+	tasdevice_profile_controls = devm_kzalloc(tas_dev->dev,
+			nr_controls * sizeof(tasdevice_profile_controls[0]),
+			GFP_KERNEL);
+	if (tasdevice_profile_controls == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Create a mixer item for selecting the active profile */
+	name = devm_kzalloc(tas_dev->dev,
+		MAX_CONTROL_NAME, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	scnprintf(name, MAX_CONTROL_NAME, "TASDEVICE Profile id");
+	tasdevice_profile_controls[mix_index].name = name;
+	tasdevice_profile_controls[mix_index].iface =
+		SNDRV_CTL_ELEM_IFACE_MIXER;
+	tasdevice_profile_controls[mix_index].info =
+		tasdevice_info_profile;
+	tasdevice_profile_controls[mix_index].get =
+		tasdevice_get_profile_id;
+	tasdevice_profile_controls[mix_index].put =
+		tasdevice_set_profile_id;
+	mix_index++;
+
+	ret = snd_soc_add_component_controls(tas_dev->codec,
+		tasdevice_profile_controls,
+		nr_controls < mix_index ? nr_controls : mix_index);
+
+	tas_dev->tas_ctrl.nr_controls =
+		nr_controls < mix_index ? nr_controls : mix_index;
+out:
+	return ret;
+}
+
+static int tasdevice_program_get(struct snd_kcontrol *pKcontrol,
+		struct snd_ctl_elem_value *pValue)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(pKcontrol);
+	struct tasdevice_priv *pTAS2781 = snd_soc_component_get_drvdata(codec);
+
+	mutex_lock(&pTAS2781->codec_lock);
+	pValue->value.integer.value[0] = pTAS2781->mnCurrentProgram;
+	mutex_unlock(&pTAS2781->codec_lock);
+	return 0;
+}
+
+static int tasdevice_program_put(struct snd_kcontrol *pKcontrol,
+		struct snd_ctl_elem_value *pValue)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(pKcontrol);
+	struct tasdevice_priv *pTAS2781 = snd_soc_component_get_drvdata(codec);
+	unsigned int nProgram = pValue->value.integer.value[0];
+
+	mutex_lock(&pTAS2781->codec_lock);
+	pTAS2781->mnCurrentProgram = nProgram;
+	mutex_unlock(&pTAS2781->codec_lock);
+	return 0;
+}
+
+static int tasdevice_configuration_get(
+	struct snd_kcontrol *pKcontrol,
+	struct snd_ctl_elem_value *pValue)
+{
+
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(pKcontrol);
+	struct tasdevice_priv *pTAS2781 = snd_soc_component_get_drvdata(codec);
+
+	mutex_lock(&pTAS2781->codec_lock);
+	pValue->value.integer.value[0] = pTAS2781->mnCurrentConfiguration;
+	mutex_unlock(&pTAS2781->codec_lock);
+	return 0;
+}
+
+static int tasdevice_configuration_put(
+	struct snd_kcontrol *pKcontrol,
+	struct snd_ctl_elem_value *pValue)
+{
+	struct snd_soc_component *codec
+					= snd_soc_kcontrol_component(pKcontrol);
+	struct tasdevice_priv *pTAS2781 = snd_soc_component_get_drvdata(codec);
+	unsigned int nConfiguration = pValue->value.integer.value[0];
+
+	mutex_lock(&pTAS2781->codec_lock);
+	pTAS2781->mnCurrentConfiguration = nConfiguration;
+	mutex_unlock(&pTAS2781->codec_lock);
+	return 0;
+}
+
+static int tasdevice_dsp_create_control(
+	struct tasdevice_priv *tas_dev)
+{
+	int  nr_controls = 2, ret = 0, mix_index = 0;
+	char *program_name = NULL;
+	char *configuration_name = NULL;
+	struct snd_kcontrol_new *tasdevice_dsp_controls = NULL;
+
+	tasdevice_dsp_controls = devm_kzalloc(tas_dev->dev,
+			nr_controls * sizeof(tasdevice_dsp_controls[0]),
+			GFP_KERNEL);
+	if (tasdevice_dsp_controls == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Create a mixer item for selecting the active profile */
+	program_name = devm_kzalloc(tas_dev->dev,
+		MAX_CONTROL_NAME, GFP_KERNEL);
+	configuration_name = devm_kzalloc(tas_dev->dev,
+		MAX_CONTROL_NAME, GFP_KERNEL);
+	if (!program_name || !configuration_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	scnprintf(program_name, MAX_CONTROL_NAME, "Program");
+	tasdevice_dsp_controls[mix_index].name = program_name;
+	tasdevice_dsp_controls[mix_index].iface =
+		SNDRV_CTL_ELEM_IFACE_MIXER;
+	tasdevice_dsp_controls[mix_index].info =
+		tasdevice_info_programs;
+	tasdevice_dsp_controls[mix_index].get =
+		tasdevice_program_get;
+	tasdevice_dsp_controls[mix_index].put =
+		tasdevice_program_put;
+	mix_index++;
+
+	scnprintf(configuration_name, MAX_CONTROL_NAME, "Configuration");
+	tasdevice_dsp_controls[mix_index].name = configuration_name;
+	tasdevice_dsp_controls[mix_index].iface =
+		SNDRV_CTL_ELEM_IFACE_MIXER;
+	tasdevice_dsp_controls[mix_index].info =
+		tasdevice_info_configurations;
+	tasdevice_dsp_controls[mix_index].get =
+		tasdevice_configuration_get;
+	tasdevice_dsp_controls[mix_index].put =
+		tasdevice_configuration_put;
+	mix_index++;
+
+	ret = snd_soc_add_component_controls(tas_dev->codec,
+		tasdevice_dsp_controls,
+		nr_controls < mix_index ? nr_controls : mix_index);
+
+	tas_dev->tas_ctrl.nr_controls += nr_controls;
+out:
+	return ret;
+}
+
+void tasdevice_regbin_ready(const struct firmware *pFW,
+	void *pContext)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) pContext;
+	struct tasdevice_regbin *regbin = NULL;
+	struct tasdevice_regbin_hdr *fw_hdr = NULL;
+	struct tasdevice_config_info **cfg_info = NULL;
+	const struct firmware *fw_entry = NULL;
+	unsigned char *buf = NULL;
+	int offset = 0, i = 0;
+	unsigned int total_config_sz = 0;
+	int ret = 0;
+
+	if (tas_dev == NULL) {
+		dev_err(tas_dev->dev,
+			"tasdev: regbin_ready: handle is NULL\n");
+		return;
+	}
+	mutex_lock(&tas_dev->codec_lock);
+	regbin = &(tas_dev->mtRegbin);
+	fw_hdr = &(regbin->fw_hdr);
+	if (unlikely(!pFW) || unlikely(!pFW->data)) {
+		dev_err(tas_dev->dev,
+		"Failed to read %s, no side - effect on driver running\n",
+		tas_dev->regbin_binaryname);
+		ret = -1;
+		goto out;
+	}
+	buf = (unsigned char *)pFW->data;
+
+	dev_info(tas_dev->dev, "tasdev: regbin_ready start\n");
+	fw_hdr->img_sz = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (fw_hdr->img_sz != pFW->size) {
+		dev_err(tas_dev->dev,
+			"File size not match, %d %u", (int)pFW->size,
+			fw_hdr->img_sz);
+		ret = -1;
+		goto out;
+	}
+
+	fw_hdr->checksum = SMS_HTONL(buf[offset], buf[offset + 1],
+					buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	fw_hdr->binary_version_num = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	if (fw_hdr->binary_version_num < 0x103) {
+		dev_err(tas_dev->dev,
+			"File version 0x%04x is too low",
+			fw_hdr->binary_version_num);
+		ret = -1;
+		goto out;
+	}
+	offset  += 4;
+	fw_hdr->drv_fw_version = SMS_HTONL(buf[offset], buf[offset + 1],
+					buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	fw_hdr->timestamp = SMS_HTONL(buf[offset], buf[offset + 1],
+					buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	fw_hdr->plat_type = buf[offset];
+	offset  += 1;
+	fw_hdr->dev_family = buf[offset];
+	offset  += 1;
+	fw_hdr->reserve = buf[offset];
+	offset  += 1;
+	fw_hdr->ndev = buf[offset];
+	offset  += 1;
+	if (fw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+		"ndev(%u) from Regbin and ndev(%u) from DTS does not match\n",
+		fw_hdr->ndev,
+		tas_dev->ndev);
+		ret = -1;
+		goto out;
+	}
+	if (offset + TASDEVICE_DEVICE_SUM > fw_hdr->img_sz) {
+		dev_err(tas_dev->dev,
+		"regbin_ready: Out of Memory!\n");
+		ret = -1;
+		goto out;
+	}
+
+	for (i = 0; i < TASDEVICE_DEVICE_SUM; i++, offset++)
+		fw_hdr->devs[i] = buf[offset];
+
+	fw_hdr->nconfig = SMS_HTONL(buf[offset], buf[offset + 1],
+				buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	dev_info(tas_dev->dev, "nconfig = %u\n", fw_hdr->nconfig);
+	for (i = 0; i < TASDEVICE_CONFIG_SUM; i++) {
+		fw_hdr->config_size[i] = SMS_HTONL(buf[offset],
+			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+		total_config_sz  += fw_hdr->config_size[i];
+	}
+	dev_info(tas_dev->dev,
+		"img_sz = %u total_config_sz = %u offset = %d\n",
+		fw_hdr->img_sz, total_config_sz, offset);
+	if (fw_hdr->img_sz - total_config_sz != (unsigned int)offset) {
+		dev_err(tas_dev->dev, "Bin file error!\n");
+		ret = -1;
+		goto out;
+	}
+	cfg_info = kcalloc(fw_hdr->nconfig,
+		sizeof(struct tasdevice_config_info *),
+		GFP_KERNEL);
+
+	if (!cfg_info) {
+		ret = -1;
+		dev_err(tas_dev->dev, "nconfig Memory alloc failed!\n");
+		goto out;
+	}
+	regbin->cfg_info = cfg_info;
+	regbin->ncfgs = 0;
+	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
+		cfg_info[i] = tasdevice_add_config(pContext, &buf[offset],
+				fw_hdr->config_size[i]);
+		if (!cfg_info[i]) {
+			ret = -1;
+			dev_err(tas_dev->dev,
+				"add_config Memory alloc failed!\n");
+			break;
+		}
+		offset  += (int)fw_hdr->config_size[i];
+		regbin->ncfgs  += 1;
+	}
+	tasdevice_create_controls(tas_dev);
+
+	tasdevice_dsp_remove(tas_dev);
+	tasdevice_calbin_remove(tas_dev);
+	tas_dev->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_dev->dsp_binaryname, 64, "%s_dsp.bin",
+		tas_dev->dev_name);
+	ret = request_firmware(&fw_entry, tas_dev->dsp_binaryname,
+		tas_dev->dev);
+	if (!ret) {
+		ret = tasdevice_dspfw_ready(fw_entry, tas_dev);
+		release_firmware(fw_entry);
+		fw_entry = NULL;
+	} else {
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		dev_err(tas_dev->dev, "%s: load %s error\n", __func__,
+			tas_dev->dsp_binaryname);
+		goto out;
+	}
+	tasdevice_dsp_create_control(tas_dev);
+
+	tas_dev->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	tas_dev->mbCalibrationLoaded = true;
+	for (i = 0; i < tas_dev->ndev; i++) {
+		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
+			tas_dev->dev_name, tas_dev->tasdevice[i].mnDevAddr);
+		ret = tas2781_load_calibration(tas_dev,
+			tas_dev->cal_binaryname[i], i);
+		if (ret != 0) {
+			dev_err(tas_dev->dev,
+				"%s: load %s error, no-side effect for playback\n",
+				__func__,
+				tas_dev->cal_binaryname[i]);
+			ret = 0;
+			tas_dev->mbCalibrationLoaded = false;
+		}
+	}
+
+out:
+	mutex_unlock(&tas_dev->codec_lock);
+	if (pFW)
+		release_firmware(pFW);
+	dev_info(tas_dev->dev, "Firmware init complete\n");
+}
+
+void tasdevice_config_info_remove(void *pContext)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) pContext;
+	struct tasdevice_regbin *regbin = &(tas_dev->mtRegbin);
+	struct tasdevice_config_info **cfg_info = regbin->cfg_info;
+	int i = 0, j = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (cfg_info) {
+		for (i = 0; i < regbin->ncfgs; i++) {
+			if (cfg_info[i]) {
+				for (j = 0; j < (int)cfg_info[i]->real_nblocks;
+					j++) {
+					kfree(
+					cfg_info[i]->blk_data[j]->regdata);
+					kfree(cfg_info[i]->blk_data[j]);
+				}
+				kfree(cfg_info[i]->blk_data);
+				kfree(cfg_info[i]);
+			}
+		}
+		kfree(cfg_info);
+	}
+	mutex_unlock(&tas_dev->dev_lock);
+}
+
+static int tasdevice_dac_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *codec = snd_soc_dapm_to_component(w->dapm);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		dev_info(tas_dev->dev, "SND_SOC_DAPM_POST_PMU\n");
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		dev_info(tas_dev->dev, "SND_SOC_DAPM_PRE_PMD\n");
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0,
+		tasdevice_dac_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("DMIC"),
+	SND_SOC_DAPM_SIGGEN("VMON"),
+	SND_SOC_DAPM_SIGGEN("IMON")
+};
+
+static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
+	{"DAC", NULL, "ASI"},
+	{"OUT", NULL, "DAC"},
+	{"ASI OUT", NULL, "DMIC"}
+};
+
+static int tasdevice_startup(struct snd_pcm_substream *substream,
+						struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	int ret = 0;
+
+	if (tas_dev->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
+		dev_err(tas_dev->dev, "DSP bin file not loaded\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int tasdevice_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct tasdevice_priv *tas_dev = snd_soc_dai_get_drvdata(dai);
+	unsigned int fsrate;
+	unsigned int slot_width;
+	int bclk_rate;
+	int rc = 0;
+
+	dev_info(tas_dev->dev, "%s: %s\n",
+		__func__, substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		"Playback":"Capture");
+
+	fsrate = params_rate(params);
+	switch (fsrate) {
+	case 48000:
+		break;
+	case 44100:
+		break;
+	default:
+		dev_err(tas_dev->dev,
+			"%s: incorrect sample rate = %u\n",
+			__func__, fsrate);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	slot_width = params_width(params);
+	switch (slot_width) {
+	case 16:
+		break;
+	case 20:
+		break;
+	case 24:
+		break;
+	case 32:
+		break;
+	default:
+		dev_err(tas_dev->dev,
+			"%s: incorrect slot width = %u\n",
+			__func__, slot_width);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	bclk_rate = snd_soc_params_to_bclk(params);
+	if (bclk_rate < 0) {
+		dev_err(tas_dev->dev,
+			"%s: incorrect bclk rate = %d\n",
+			__func__, bclk_rate);
+		rc = bclk_rate;
+		goto out;
+	}
+	dev_info(tas_dev->dev,
+	"%s: BCLK rate = %d Channel = %d Sample rate = %u slot width = %u\n",
+	__func__, bclk_rate, params_channels(params),
+	fsrate, slot_width);
+out:
+	return rc;
+}
+
+static void tasdevice_enable_irq(
+	struct tasdevice_priv *tas_dev, bool enable)
+{
+	struct irq_desc *desc = NULL;
+
+	if (enable) {
+		if (tas_dev->mIrqInfo.mb_irq_enable)
+			return;
+		if (gpio_is_valid(tas_dev->mIrqInfo.mn_irq_gpio)) {
+			desc = irq_to_desc(tas_dev->mIrqInfo.mn_irq);
+			if (desc && desc->depth > 0)
+				enable_irq(tas_dev->mIrqInfo.mn_irq);
+			else
+				dev_info(tas_dev->dev,
+					"### irq already enabled\n");
+		}
+		tas_dev->mIrqInfo.mb_irq_enable = true;
+	} else {
+		if (gpio_is_valid(tas_dev->mIrqInfo.mn_irq_gpio))
+			disable_irq_nosync(tas_dev->mIrqInfo.mn_irq);
+		tas_dev->mIrqInfo.mb_irq_enable = false;
+	}
+}
+
+static int tasdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	struct tasdevice_priv *tas_dev = snd_soc_dai_get_drvdata(codec_dai);
+
+	dev_info(tas_dev->dev,
+		"%s: clk_id = %d, freq = %u, CLK direction %s\n",
+		__func__, clk_id, freq,
+		dir == TASDEVICE_CLK_DIR_OUT ? "OUT":"IN");
+
+	return 0;
+}
+
+static void powercontrol_routine(struct work_struct *work)
+{
+	struct tasdevice_priv *tas_dev =
+		container_of(work, struct tasdevice_priv,
+		powercontrol_work.work);
+	struct TFirmware *pFw = NULL;
+	int profile_cfg_id = 0;
+
+	mutex_lock(&tas_dev->codec_lock);
+	/*mnCurrentProgram != 0 is dsp mode or tuning mode*/
+	if (tas_dev->mnCurrentProgram) {
+		/*bypass all in regbin is profile id 0*/
+		profile_cfg_id = REGBIN_CONFIGID_BYPASS_ALL;
+	} else {
+		profile_cfg_id = tas_dev->mtRegbin.profile_cfg_id;
+		pFw = tas_dev->mpFirmware;
+		dev_info(tas_dev->dev, "%s: %s\n", __func__,
+			pFw->mpConfigurations[tas_dev->mnCurrentConfiguration]
+			.mpName);
+		tasdevice_select_tuningprm_cfg(tas_dev,
+			tas_dev->mnCurrentProgram,
+			tas_dev->mnCurrentConfiguration,
+			profile_cfg_id);
+		if (tas_dev->tas2781_set_global != NULL)
+			tas_dev->tas2781_set_global(tas_dev);
+	}
+	tasdevice_select_cfg_blk(tas_dev, profile_cfg_id,
+		TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
+	if (tas_dev->chip_id != GENERAL_AUDEV)
+		tasdevice_enable_irq(tas_dev, true);
+	mutex_unlock(&tas_dev->codec_lock);
+}
+
+static void tasdevice_set_power_state(
+	struct tasdevice_priv *tas_dev, int state)
+{
+	switch (state) {
+	case 0:
+		schedule_delayed_work(&tas_dev->powercontrol_work,
+			msecs_to_jiffies(20));
+		break;
+	default:
+		if (!(tas_dev->pstream || tas_dev->cstream)) {
+			if (tas_dev->chip_id != GENERAL_AUDEV)
+				tasdevice_enable_irq(tas_dev, false);
+			tasdevice_select_cfg_blk(tas_dev,
+				tas_dev->mtRegbin.profile_cfg_id,
+				TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
+		}
+		break;
+	}
+}
+
+static int tasdevice_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+
+	if (mute) {
+		/* stop DSP only when both playback and capture streams
+		 * are deactivated
+		 */
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tas_dev->pstream = 0;
+		else
+			tas_dev->cstream = 0;
+		if (tas_dev->pstream != 0 || tas_dev->cstream != 0)
+			goto out;
+	} else {
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tas_dev->pstream = 1;
+		else
+			tas_dev->cstream = 1;
+
+	}
+	tasdevice_set_power_state(tas_dev, mute);
+out:
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tasdevice_dai_ops = {
+	.startup = tasdevice_startup,
+	.hw_params = tasdevice_hw_params,
+	.set_sysclk = tasdevice_set_dai_sysclk,
+	.mute_stream = tasdevice_mute,
+};
+
+static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
+	{
+		.name = "tas2781_codec",
+		.id = 0,
+		.playback = {
+			.stream_name	= "Playback",
+			.channels_min   = 1,
+			.channels_max   = 4,
+			.rates	 = TASDEVICE_RATES,
+			.formats	= TASDEVICE_FORMATS,
+		},
+		.capture = {
+			.stream_name	= "Capture",
+			.channels_min   = 1,
+			.channels_max   = 4,
+			.rates	 = TASDEVICE_RATES,
+			.formats	= TASDEVICE_FORMATS,
+		},
+		.ops = &tasdevice_dai_ops,
+		.symmetric_rate = 1,
+	},
+};
+
+static int tasdevice_codec_probe(
+	struct snd_soc_component *codec)
+{
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+
+	tas_dev->codec = codec;
+	scnprintf(tas_dev->regbin_binaryname, 64, "%s_regbin.bin",
+		tas_dev->dev_name);
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+		tas_dev->regbin_binaryname, tas_dev->dev, GFP_KERNEL, tas_dev,
+		tasdevice_regbin_ready);
+	if (ret)
+		dev_err(tas_dev->dev,
+			"%s: request_firmware_nowait error:0x%08x\n",
+			__func__, ret);
+
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	if (tas_dev->tas2781_reset != NULL)
+		tas_dev->tas2781_reset(tas_dev);
+	if (tas_dev->tas2781_set_global != NULL)
+		tas_dev->tas2781_set_global(tas_dev);
+
+	return ret;
+}
+
+static void tasdevice_deinit(void *pContext)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+
+	tasdevice_config_info_remove(tas_dev);
+	tasdevice_dsp_remove(tas_dev);
+	tasdevice_calbin_remove(tas_dev);
+	tas_dev->fw_state = TASDEVICE_DSP_FW_PENDING;
+}
+
+static void tasdevice_codec_remove(
+	struct snd_soc_component *codec)
+{
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+	tasdevice_deinit(tas_dev);
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	return;
+
+}
+
+static const struct snd_soc_component_driver
+	soc_codec_driver_tasdevice = {
+	.probe			= tasdevice_codec_probe,
+	.remove			= tasdevice_codec_remove,
+	.controls		= tas2781_snd_controls,
+	.num_controls		= ARRAY_SIZE(tas2781_snd_controls),
+	.dapm_widgets		= tasdevice_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tasdevice_dapm_widgets),
+	.dapm_routes		= tasdevice_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(tasdevice_audio_map),
+	.idle_bias_on		= 1,
+	.endianness		= 1,
+};
+
+static void irq_work_routine(struct work_struct *pWork)
+{
+	struct tasdevice_priv *tas_dev =
+		container_of(pWork, struct tasdevice_priv,
+		mIrqInfo.irq_work.work);
+
+	mutex_lock(&tas_dev->codec_lock);
+	if (tas_dev->mb_runtime_suspend) {
+		dev_info(tas_dev->dev, "%s, Runtime Suspended\n", __func__);
+		goto end;
+	}
+	/*Logical Layer IRQ function, return is ignored*/
+	if (tas_dev->irq_work_func)
+		tas_dev->irq_work_func(tas_dev);
+	else
+		dev_info(tas_dev->dev,
+			"%s, irq_work_func is NULL\n", __func__);
+end:
+	mutex_unlock(&tas_dev->codec_lock);
+}
+
+static void tas2781_irq_work_func(struct tasdevice_priv *tas_dev)
+{
+	int rc = 0;
+	unsigned int reg_val = 0, array_size = 0, i = 0, ndev = 0;
+	unsigned int int_reg_array[] = {
+		TAS2781_REG_INT_LTCH0,
+		TAS2781_REG_INT_LTCH1,
+		TAS2781_REG_INT_LTCH1_0,
+		TAS2781_REG_INT_LTCH2,
+		TAS2781_REG_INT_LTCH3,
+		TAS2781_REG_INT_LTCH4};
+
+	tasdevice_enable_irq(tas_dev, false);
+
+	array_size = ARRAY_SIZE(int_reg_array);
+
+	for (ndev = 0; ndev < tas_dev->ndev; ndev++) {
+		for (i = 0; i < array_size; i++) {
+			rc = tasdevice_dev_read(tas_dev,
+				ndev, int_reg_array[i], &reg_val);
+			if (!rc)
+				dev_info(tas_dev->dev,
+					"INT STATUS REG 0x%04x=0x%02x\n",
+					int_reg_array[i], reg_val);
+			else
+				dev_err(tas_dev->dev,
+					"Read Reg 0x%04x error(rc=%d)\n",
+					int_reg_array[i], rc);
+		}
+	}
+
+}
+
+static irqreturn_t tasdevice_irq_handler(int irq,
+	void *dev_id)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)dev_id;
+;
+	/* get IRQ status after 100 ms */
+	schedule_delayed_work(&tas_dev->mIrqInfo.irq_work,
+		msecs_to_jiffies(100));
+	return IRQ_HANDLED;
+}
+
+int tasdevice_parse_dt(struct tasdevice_priv *tas_dev)
+{
+	struct device_node *np = tas_dev->dev->of_node;
+	int rc = 0, i = 0, ndev = 0;
+	char buf[32];
+
+
+	for (i = 0, ndev = 0; i < MaxChn; i++) {
+		rc = of_property_read_u32(np, dts_dev_addr_tag[i],
+			&(tas_dev->tasdevice[ndev].mnDevAddr));
+		if (rc)
+			dev_err(tas_dev->dev,
+			"Looking up %s property in node %s failed  %d\n",
+			dts_dev_addr_tag[i],
+			np->full_name, rc);
+		else {
+			dev_dbg(tas_dev->dev, "%s=0x%02x", dts_dev_addr_tag[i],
+				tas_dev->tasdevice[ndev].mnDevAddr);
+			ndev++;
+		}
+	}
+
+	rc = of_property_read_u32(np, dts_glb_addr_tag,
+			&(tas_dev->glb_addr.mnDevAddr));
+	if (rc) {
+		dev_err(tas_dev->dev,
+		"Looking up %s property in node %s failed %d\n",
+		dts_glb_addr_tag, np->full_name, rc);
+		tas_dev->glb_addr.mnDevAddr = 0;
+	}
+	tas_dev->ndev = (ndev == 0) ? 1 : ndev;
+
+	for (i = 0, ndev = 0; i < tas_dev->ndev; i++) {
+		scnprintf(buf, sizeof(buf), dts_rst_tag, "reset", i);
+		tas_dev->tasdevice[ndev].mnResetGpio = of_get_named_gpio(np,
+			buf, 0);
+		if (gpio_is_valid(tas_dev->tasdevice[ndev].mnResetGpio)) {
+			rc = gpio_request(tas_dev->tasdevice[ndev].mnResetGpio,
+				buf);
+			if (!rc) {
+				gpio_direction_output(
+					tas_dev->tasdevice[ndev].mnResetGpio,
+					1);
+				dev_info(tas_dev->dev, "%s = %d", buf,
+					tas_dev->tasdevice[ndev].mnResetGpio);
+				ndev++;
+			} else
+				dev_err(tas_dev->dev,
+					"%s: Failed to request dev[%d] gpio %d\n",
+					__func__, ndev,
+					tas_dev->tasdevice[ndev].mnResetGpio);
+		} else
+			dev_err(tas_dev->dev,
+				"Looking up %s property in node %s failed %d\n",
+				buf, np->full_name,
+				tas_dev->tasdevice[ndev].mnResetGpio);
+	}
+	strcpy(tas_dev->dev_name, tasdevice_id[tas_dev->chip_id].name);
+	if (tas_dev->chip_id != GENERAL_AUDEV) {
+		tas_dev->mIrqInfo.mn_irq_gpio = of_get_named_gpio(np,
+			"ti,irq-gpio", 0);
+		if (gpio_is_valid(tas_dev->mIrqInfo.mn_irq_gpio)) {
+			dev_dbg(tas_dev->dev, "irq-gpio = %d",
+				tas_dev->mIrqInfo.mn_irq_gpio);
+			INIT_DELAYED_WORK(&tas_dev->mIrqInfo.irq_work,
+				irq_work_routine);
+
+			rc = gpio_request(tas_dev->mIrqInfo.mn_irq_gpio,
+						"AUDEV-IRQ");
+			if (!rc) {
+				gpio_direction_input(
+					tas_dev->mIrqInfo.mn_irq_gpio);
+
+				tas_dev->mIrqInfo.mn_irq =
+					gpio_to_irq(
+					tas_dev->mIrqInfo.mn_irq_gpio);
+				dev_info(tas_dev->dev,
+					"irq = %d\n",
+					tas_dev->mIrqInfo.mn_irq);
+
+				rc = request_threaded_irq(
+					tas_dev->mIrqInfo.mn_irq,
+					tasdevice_irq_handler,
+					NULL, IRQF_TRIGGER_FALLING|
+					IRQF_ONESHOT,
+					SMARTAMP_MODULE_NAME, tas_dev);
+				if (!rc)
+					disable_irq_nosync(
+						tas_dev->mIrqInfo.mn_irq);
+				else
+					dev_err(tas_dev->dev,
+						"request_irq failed, %d\n",
+						rc);
+			} else
+				dev_err(tas_dev->dev,
+					"%s: GPIO %d request error\n",
+					__func__,
+					tas_dev->mIrqInfo.mn_irq_gpio);
+		} else
+			dev_err(tas_dev->dev,
+				"Looking up irq-gpio property in node %s failed %d\n",
+				np->full_name,
+				tas_dev->mIrqInfo.mn_irq_gpio);
+	}
+
+	if (tas_dev->chip_id != GENERAL_AUDEV && rc == 0) {
+		if (tas_dev->chip_id == TAS2781)
+			tas_dev->irq_work_func = tas2781_irq_work_func;
+		else
+			dev_info(tas_dev->dev, "%s: No match irq_work_func\n",
+				__func__);
+	}
+
+	return 0;
+}
+
+static int tasdevice_regmap_write(
+	struct tasdevice_priv *tas_dev,
+	unsigned int reg, unsigned int value)
+{
+	int nResult = 0;
+	int retry_count = TASDEVICE_RETRY_COUNT;
+
+	while (retry_count--) {
+		nResult = regmap_write(tas_dev->regmap, reg,
+			value);
+		if (nResult >= 0)
+			break;
+		usleep_range(5000, 5050);
+	}
+	if (retry_count == -1)
+		return TASDEVICE_ERROR_FAILED;
+	else
+		return 0;
+}
+
+static int tasdevice_regmap_bulk_write(
+	struct tasdevice_priv *tas_dev, unsigned int reg,
+	unsigned char *pData, unsigned int nLength)
+{
+	int nResult = 0;
+	int retry_count = TASDEVICE_RETRY_COUNT;
+
+	while (retry_count--) {
+		nResult = regmap_bulk_write(tas_dev->regmap, reg,
+				pData, nLength);
+		if (nResult >= 0)
+			break;
+		usleep_range(5000, 5050);
+	}
+	if (retry_count == -1)
+		return TASDEVICE_ERROR_FAILED;
+	else
+		return 0;
+}
+
+static int tasdevice_regmap_read(
+	struct tasdevice_priv *tas_dev,
+	unsigned int reg, unsigned int *value)
+{
+	int nResult = 0;
+	int retry_count = TASDEVICE_RETRY_COUNT;
+
+	while (retry_count--) {
+		nResult = regmap_read(tas_dev->regmap, reg,
+			value);
+		if (nResult >= 0)
+			break;
+		usleep_range(5000, 5050);
+	}
+	if (retry_count == -1)
+		return TASDEVICE_ERROR_FAILED;
+	else
+		return 0;
+}
+
+static int tasdevice_regmap_bulk_read(
+	struct tasdevice_priv *tas_dev, unsigned int reg,
+	unsigned char *pData, unsigned int nLength)
+{
+	int nResult = 0;
+	int retry_count = TASDEVICE_RETRY_COUNT;
+
+	while (retry_count--) {
+		nResult = regmap_bulk_read(tas_dev->regmap, reg,
+			pData, nLength);
+		if (nResult >= 0)
+			break;
+		usleep_range(5000, 5050);
+	}
+	if (retry_count == -1)
+		return TASDEVICE_ERROR_FAILED;
+	else
+		return 0;
+}
+
+static int tasdevice_regmap_update_bits(
+	struct tasdevice_priv *tas_dev, unsigned int reg,
+	unsigned int mask, unsigned int value)
+{
+	int nResult = 0;
+	int retry_count = TASDEVICE_RETRY_COUNT;
+
+	while (retry_count--) {
+		nResult = regmap_update_bits(tas_dev->regmap, reg,
+			mask, value);
+		if (nResult >= 0)
+			break;
+		usleep_range(5000, 5050);
+	}
+	if (retry_count == -1)
+		return TASDEVICE_ERROR_FAILED;
+	else
+		return 0;
+}
+
+static int tasdevice_change_chn_book_page(
+	struct tasdevice_priv *tas_dev, enum channel chn,
+	int book, int page)
+{
+	int n_result = 0;
+	struct i2c_client *pClient =
+		(struct i2c_client *)tas_dev->client;
+
+	if (chn < tas_dev->ndev) {
+		if (tas_dev->glb_addr.ref_cnt != 0) {
+			tas_dev->glb_addr.ref_cnt = 0;
+			tas_dev->glb_addr.mnBkPg.mnBook = -1;
+			tas_dev->glb_addr.mnBkPg.mnPage = -1;
+		}
+		pClient->addr = tas_dev->tasdevice[chn].mnDevAddr;
+		if (tas_dev->tasdevice[chn].mnBkPg.mnBook != book) {
+			n_result = tasdevice_regmap_write(tas_dev,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, n_result);
+				goto out;
+			}
+			tas_dev->tasdevice[chn].mnBkPg.mnPage = 0;
+			n_result = tasdevice_regmap_write(tas_dev,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, n_result);
+				goto out;
+			}
+			tas_dev->tasdevice[chn].mnBkPg.mnBook = book;
+		}
+
+		if (tas_dev->tasdevice[chn].mnBkPg.mnPage != page) {
+			n_result = tasdevice_regmap_write(tas_dev,
+				TASDEVICE_BOOKCTL_PAGE, page);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, n_result);
+				goto out;
+			}
+			tas_dev->tasdevice[chn].mnBkPg.mnPage = page;
+		}
+	} else if (chn == tas_dev->ndev) {
+		int i = 0;
+
+		if (tas_dev->glb_addr.ref_cnt == 0)
+			for (i = 0; i < tas_dev->ndev; i++) {
+				tas_dev->tasdevice[i].mnBkPg.mnBook
+					= -1;
+				tas_dev->tasdevice[i].mnBkPg.mnPage
+					= -1;
+			}
+		pClient->addr = tas_dev->glb_addr.mnDevAddr;
+		if (tas_dev->glb_addr.mnBkPg.mnBook != book) {
+			n_result = tasdevice_regmap_write(tas_dev,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev,
+					"%s, 0ERROR, E=%d\n",
+					__func__, n_result);
+				goto out;
+			}
+			tas_dev->glb_addr.mnBkPg.mnPage = 0;
+			n_result = tasdevice_regmap_write(tas_dev,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev,
+					"%s, book%xERROR, E=%d\n",
+					__func__, book, n_result);
+				goto out;
+			}
+			tas_dev->glb_addr.mnBkPg.mnBook = book;
+		}
+
+		if (tas_dev->glb_addr.mnBkPg.mnPage != page) {
+			n_result = tasdevice_regmap_write(tas_dev,
+				TASDEVICE_BOOKCTL_PAGE, page);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev,
+					"%s, page%xERROR, E=%d\n",
+					__func__, page, n_result);
+				goto out;
+			}
+			tas_dev->glb_addr.mnBkPg.mnPage = page;
+		}
+		tas_dev->glb_addr.ref_cnt++;
+	} else
+		dev_err(tas_dev->dev,
+			"%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+
+out:
+	return n_result;
+}
+
+int tasdevice_dev_read(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned int *pValue)
+{
+	int n_result = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn < tas_dev->ndev) {
+		n_result = tasdevice_change_chn_book_page(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = tasdevice_regmap_read(tas_dev,
+			TASDEVICE_PAGE_REG(reg), pValue);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR,E=%d\n",
+				__func__, n_result);
+		else
+			dev_dbg(tas_dev->dev,
+			"%s: chn:0x%02x:BOOK:PAGE:REG 0x%02x:0x%02x:0x%02x, 0x%02x\n",
+			__func__,
+			tas_dev->tasdevice[chn].mnDevAddr,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg),
+			TASDEVICE_PAGE_REG(reg), *pValue);
+	} else {
+
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+	}
+
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return n_result;
+}
+
+int tasdevice_dev_write(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned int value)
+{
+	int n_result = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn <= tas_dev->ndev) {
+		n_result = tasdevice_change_chn_book_page(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = tasdevice_regmap_write(tas_dev,
+			TASDEVICE_PAGE_REG(reg), value);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
+		else {
+			dev_dbg(tas_dev->dev,
+			"%s: %s-0x%02x:BOOK:PAGE:REG 0x%02x:0x%02x:0x%02x, VAL: 0x%02x\n",
+			__func__, (chn == tas_dev->ndev)?"glb":"chn",
+			(chn == tas_dev->ndev) ?
+			tas_dev->glb_addr.mnDevAddr
+			: tas_dev->tasdevice[chn].mnDevAddr,
+			TASDEVICE_BOOK_ID(reg),
+			TASDEVICE_PAGE_ID(reg),
+			TASDEVICE_PAGE_REG(reg), value);
+		}
+	} else
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return n_result;
+}
+
+int tasdevice_dev_bulk_write(
+	struct tasdevice_priv *tas_dev, enum channel chn,
+	unsigned int reg, unsigned char *p_data,
+	unsigned int n_length)
+{
+	int n_result = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn <= tas_dev->ndev) {
+		n_result = tasdevice_change_chn_book_page(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = tasdevice_regmap_bulk_write(tas_dev,
+			TASDEVICE_PAGE_REG(reg), p_data, n_length);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
+		else {
+			dev_dbg(tas_dev->dev,
+			"%s: %s-0x%02x:BOOK:PAGE:REG 0x%02x:0x%02x: 0x%02x, len: 0x%02x\n",
+			__func__,
+			(chn == tas_dev->ndev)?"glb":"chn",
+			(chn == tas_dev->ndev) ?
+			tas_dev->glb_addr.mnDevAddr
+			: tas_dev->tasdevice[chn].mnDevAddr,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg),
+			TASDEVICE_PAGE_REG(reg), n_length);
+		}
+	} else
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return n_result;
+}
+
+int tasdevice_dev_bulk_read(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned char *p_data,
+	unsigned int n_length)
+{
+	int n_result = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn < tas_dev->ndev) {
+		n_result = tasdevice_change_chn_book_page(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = tasdevice_regmap_bulk_read(tas_dev,
+			TASDEVICE_PAGE_REG(reg), p_data, n_length);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
+		else
+			dev_dbg(tas_dev->dev,
+			"%s: chn0x%02x:BOOK:PAGE:REG 0x%02x:0x%02x: 0x%02x, len: 0x%02x\n",
+			__func__,
+			tas_dev->tasdevice[chn].mnDevAddr,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg),
+			TASDEVICE_PAGE_REG(reg), n_length);
+	} else
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return n_result;
+}
+
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *tas_dev, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	int n_result = 0;
+	struct i2c_client *pClient =
+		(struct i2c_client *)tas_dev->client;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn < tas_dev->ndev) {
+		n_result = tasdevice_change_chn_book_page(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg));
+		if (n_result < 0)
+			goto out;
+		pClient->addr = tas_dev->tasdevice[chn].mnDevAddr;
+		n_result = tasdevice_regmap_update_bits(tas_dev,
+			TASDEVICE_PAGE_REG(reg), mask, value);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
+		else
+			dev_dbg(tas_dev->dev,
+			"%s: chn0x%02x:BOOK:PAGE:REG 0x%02x:0x%02x:0x%02x, mask: 0x%02x, val: 0x%02x\n",
+			__func__, tas_dev->tasdevice[chn].mnDevAddr,
+			TASDEVICE_BOOK_ID(reg), TASDEVICE_PAGE_ID(reg),
+			TASDEVICE_PAGE_REG(reg), mask, value);
+	} else {
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+		n_result = -1;
+	}
+
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return n_result;
+}
+
+static void tas2781_reset(struct tasdevice_priv *tas_dev)
+{
+	int ret = 0;
+	int i = 0;
+
+	for (; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_write(tas_dev, i,
+			TAS2871_REG_SWRESET,
+			TAS2871_REG_SWRESET_RESET);
+		if (ret < 0) {
+			dev_err(tas_dev->dev, "%s: chn %d reset fail, %d\n",
+				__func__, i, ret);
+			continue;
+		}
+	}
+	usleep_range(1000, 1050);
+}
+
+static void tas2781_set_global(struct tasdevice_priv *tas_dev)
+{
+	int i = 0;
+	int ret = 0;
+
+	for (; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			TAS2871_MISC_CFG2,
+			TAS2871_GLOBAL_MASK, 0x02);
+		if (ret < 0) {
+			dev_err(tas_dev->dev, "%s: chn %d set global fail, %d\n",
+				__func__, i, ret);
+			continue;
+		}
+	}
+}
+
+static int tasdevice_init(struct tasdevice_priv *tas_dev)
+{
+	int nResult = 0, i = 0;
+
+	tas_dev->mnCurrentProgram = -1;
+	tas_dev->mnCurrentConfiguration = -1;
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		tas_dev->tasdevice[i].mnBkPg.mnBook = -1;
+		tas_dev->tasdevice[i].mnBkPg.mnPage = -1;
+		tas_dev->tasdevice[i].mnCurrentProgram = -1;
+		tas_dev->tasdevice[i].mnCurrentConfiguration = -1;
+	}
+	mutex_init(&tas_dev->dev_lock);
+	tas_dev->read = tasdevice_dev_read;
+	tas_dev->write = tasdevice_dev_write;
+	tas_dev->bulk_read = tasdevice_dev_bulk_read;
+	tas_dev->bulk_write = tasdevice_dev_bulk_write;
+	tas_dev->set_calibration = tas2781_set_calibration;
+	tas_dev->tas2781_reset = tas2781_reset;
+	if (tas_dev->glb_addr.mnDevAddr != 0
+		&& tas_dev->glb_addr.mnDevAddr < 0x7F)
+		tas_dev->tas2781_set_global = tas2781_set_global;
+	dev_set_drvdata(tas_dev->dev, tas_dev);
+
+	INIT_DELAYED_WORK(&tas_dev->powercontrol_work,
+		powercontrol_routine);
+
+	mutex_init(&tas_dev->codec_lock);
+	nResult = devm_snd_soc_register_component(tas_dev->dev,
+		&soc_codec_driver_tasdevice,
+		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
+	if (nResult)
+		dev_err(tas_dev->dev, "%s: codec register error:0x%08x\n",
+			__func__, nResult);
+
+	INIT_DELAYED_WORK(&tas_dev->mIrqInfo.irq_work, irq_work_routine);
+	tas_dev->mIrqInfo.mb_irq_enable = false;
+
+	dev_info(tas_dev->dev, "i2c register success\n");
+
+	return nResult;
+}
+
+void tasdevice_remove(struct tasdevice_priv *tas_dev)
+{
+	int i = 0;
+
+	for (i = 0; i < tas_dev->mtRstGPIOs.ndev; i++) {
+		if (gpio_is_valid(tas_dev->mtRstGPIOs.mnResetGpio[i]))
+			gpio_free(tas_dev->mtRstGPIOs.mnResetGpio[i]);
+	}
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		if (gpio_is_valid(tas_dev->tasdevice[i].mnIRQGPIO))
+			gpio_free(tas_dev->tasdevice[i].mnIRQGPIO);
+	}
+
+	if (delayed_work_pending(&tas_dev->mIrqInfo.irq_work)) {
+		dev_info(tas_dev->dev, "cancel IRQ work\n");
+		cancel_delayed_work(&tas_dev->mIrqInfo.irq_work);
+	}
+	cancel_delayed_work_sync(&tas_dev->mIrqInfo.irq_work);
+
+	mutex_destroy(&tas_dev->dev_lock);
+	mutex_destroy(&tas_dev->codec_lock);
+	snd_soc_unregister_component(tas_dev->dev);
+}
+
+static int tasdevice_pm_suspend(struct device *dev)
+{
+	struct tasdevice_priv *tas_dev = dev_get_drvdata(dev);
+
+	if (!tas_dev) {
+		dev_err(tas_dev->dev, "%s: drvdata is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&tas_dev->codec_lock);
+
+	tas_dev->mb_runtime_suspend = true;
+
+	if (tas_dev->chip_id != GENERAL_AUDEV) {
+		if (delayed_work_pending(&tas_dev->mIrqInfo.irq_work)) {
+			dev_dbg(tas_dev->dev, "cancel IRQ work\n");
+			cancel_delayed_work_sync(&tas_dev->mIrqInfo.irq_work);
+		}
+	}
+	mutex_unlock(&tas_dev->codec_lock);
+	return 0;
+}
+
+static int tasdevice_pm_resume(struct device *dev)
+{
+	struct tasdevice_priv *tas_dev = dev_get_drvdata(dev);
+
+	if (!tas_dev)
+		return -EINVAL;
+
+	mutex_lock(&tas_dev->codec_lock);
+	tas_dev->mb_runtime_suspend = false;
+	mutex_unlock(&tas_dev->codec_lock);
+	return 0;
+}
+
+const struct dev_pm_ops tasdevice_pm_ops = {
+	.suspend = tasdevice_pm_suspend,
+	.resume = tasdevice_pm_resume
+};
+
+static int tasdevice_i2c_probe(struct i2c_client *i2c,
+	const struct i2c_device_id *id)
+{
+	struct tasdevice_priv *tas_dev = NULL;
+	int ret = 0;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
+		dev_err(&i2c->dev,
+			"%s: I2C check failed\n", __func__);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	tas_dev = devm_kzalloc(&i2c->dev, sizeof(*tas_dev), GFP_KERNEL);
+	if (!tas_dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	tas_dev->dev = &i2c->dev;
+	tas_dev->client = (void *)i2c;
+	tas_dev->chip_id = id->driver_data;
+
+	if (i2c->dev.of_node)
+		ret = tasdevice_parse_dt(tas_dev);
+	else {
+		dev_err(tas_dev->dev, "No DTS info\n");
+		goto out;
+	}
+
+	tas_dev->regmap = devm_regmap_init_i2c(i2c,
+		&tasdevice_regmap);
+	if (IS_ERR(tas_dev->regmap)) {
+		ret = PTR_ERR(tas_dev->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+	ret = tasdevice_init(tas_dev);
+
+out:
+	if (ret < 0 && tas_dev != NULL)
+		tasdevice_remove(tas_dev);
+	return ret;
+
+}
+
+static void tasdevice_i2c_remove(struct i2c_client *pClient)
+{
+	struct tasdevice_priv *tas_dev = i2c_get_clientdata(pClient);
+
+	if (tas_dev)
+		tasdevice_remove(tas_dev);
+
+}
+
+static struct i2c_driver tasdevice_i2c_driver = {
+	.driver = {
+		.name = "tas2781-codec",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tasdevice_of_match),
+		.pm = &tasdevice_pm_ops,
+	},
+	.probe	= tasdevice_i2c_probe,
+	.remove = tasdevice_i2c_remove,
+	.id_table = tasdevice_id,
+};
+
+module_i2c_driver(tasdevice_i2c_driver);
+
+MODULE_AUTHOR("Shenghao Ding <shenghao-ding@ti.com>");
+MODULE_AUTHOR("Kevin Lu <kevin-lu@ti.com>");
+MODULE_DESCRIPTION("ASoC TAS2781 Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tas2781.h b/sound/soc/codecs/tas2781.h
new file mode 100644
index 000000000..db4ec752b
--- /dev/null
+++ b/sound/soc/codecs/tas2781.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable register setting
+ * for one, two, even multiple TAS2781 chips. All the register setting are in
+ * a bin file. Almost no specific register setting can be found in the code.
+ *
+ * Author: Shenghao Ding <shenghao-ding@ti.com>
+ *         Kevin Lu <kevin-lu@ti.com>
+ */
+
+#ifndef __TAS2781_H__
+#define __TAS2781_H__
+
+#include "tas2781-dsp.h"
+
+#define SMARTAMP_MODULE_NAME	("tas2781")
+#define MAX_LENGTH				(128)
+
+#define TASDEVICE_RETRY_COUNT	(3)
+#define TASDEVICE_ERROR_FAILED	(-2)
+
+#define TASDEVICE_RATES	(SNDRV_PCM_RATE_44100 |\
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |\
+	SNDRV_PCM_RATE_88200)
+#define TASDEVICE_MAX_CHANNELS (8)
+
+#define TASDEVICE_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+/*PAGE Control Register (available in page0 of each book) */
+#define TASDEVICE_PAGE_SELECT	(0x00)
+#define TASDEVICE_BOOKCTL_PAGE	(0x00)
+#define TASDEVICE_BOOKCTL_REG	(127)
+#define TASDEVICE_BOOK_ID(reg)		(reg / (256 * 128))
+#define TASDEVICE_PAGE_ID(reg)		((reg % (256 * 128)) / 128)
+#define TASDEVICE_PAGE_REG(reg)		((reg % (256 * 128)) % 128)
+#define TASDEVICE_REG(book, page, reg)	(((book * 256 * 128) + \
+					(page * 128)) + reg)
+
+	/*Software Reset */
+#define TAS2871_REG_SWRESET  TASDEVICE_REG(0x0, 0X0, 0x02)
+#define TAS2871_REG_SWRESET_RESET  (0x1 << 0)
+
+	/* Enable Global addresses */
+#define TAS2871_MISC_CFG2  TASDEVICE_REG(0x0, 0X0, 0x07)
+#define TAS2871_GLOBAL_MASK (0x1 << 1)
+
+#define SMS_HTONS(a, b)  ((((a)&0x00FF)<<8) | \
+				((b)&0x00FF))
+#define SMS_HTONL(a, b, c, d) ((((a)&0x000000FF)<<24) |\
+					(((b)&0x000000FF)<<16) | \
+					(((c)&0x000000FF)<<8) | \
+					((d)&0x000000FF))
+
+	/*I2C Checksum */
+#define TASDEVICE_I2CChecksum  TASDEVICE_REG(0x0, 0x0, 0x7E)
+
+	/* Volume control */
+#define TAS2781_DVC_LVL TASDEVICE_REG(0x0, 0x0, 0x1A)
+#define TAS2781_AMP_LEVEL TASDEVICE_REG(0x0, 0x0, 0x03)
+#define TAS2781_AMP_LEVEL_MASK GENMASK(5, 1)
+
+#define TASDEVICE_CMD_SING_W  (0x1)
+#define TASDEVICE_CMD_BURST  (0x2)
+#define TASDEVICE_CMD_DELAY  (0x3)
+#define TASDEVICE_CMD_FIELD_W  (0x4)
+
+enum audio_device {
+	GENERAL_AUDEV = 0,
+	TAS2781	  = 1,
+};
+
+struct smartpa_gpio_info {
+	unsigned char ndev;
+	int mnResetGpio[MaxChn];
+};
+
+#define SMS_HTONS(a, b)  ((((a)&0x00FF)<<8) | ((b)&0x00FF))
+#define SMS_HTONL(a, b, c, d) ((((a)&0x000000FF)<<24) | \
+	(((b)&0x000000FF)<<16) | (((c)&0x000000FF)<<8) | \
+	((d)&0x000000FF))
+
+struct Tbookpage {
+	unsigned char mnBook;
+	unsigned char mnPage;
+};
+
+struct Ttasdevice {
+	unsigned int mnDevAddr;
+	unsigned int mnErrCode;
+	short mnCurrentProgram;
+	short mnCurrentConfiguration;
+	short mnCurrentRegConf;
+	int mnIRQGPIO;
+	int mnResetGpio;
+	int mn_irq;
+	int PowerStatus;
+	bool bDSPBypass;
+	bool bIrq_enabled;
+	bool bLoading;
+	bool bLoaderr;
+	bool mbCalibrationLoaded;
+	struct Tbookpage mnBkPg;
+	struct TFirmware *mpCalFirmware;
+};
+
+struct global_addr {
+	struct Tbookpage mnBkPg;
+	unsigned int mnDevAddr;
+	int ref_cnt;
+};
+
+struct tas_control {
+	struct snd_kcontrol_new *tasdevice_profile_controls;
+	int nr_controls;
+};
+
+struct tasdevice_irqinfo {
+	int mn_irq_gpio;
+	int mn_irq;
+	struct delayed_work irq_work;
+	bool mb_irq_enable;
+};
+
+struct tasdevice_priv {
+	struct device *dev;
+	void *client;
+	struct regmap *regmap;
+	struct mutex codec_lock;
+	struct mutex dev_lock;
+	struct Ttasdevice tasdevice[MaxChn];
+	struct TFirmware *mpFirmware;
+	struct tasdevice_regbin mtRegbin;
+	struct smartpa_gpio_info mtRstGPIOs;
+	struct tasdevice_irqinfo mIrqInfo;
+	struct tas_control tas_ctrl;
+	struct global_addr glb_addr;
+	int mnCurrentProgram;
+	int mnCurrentConfiguration;
+	unsigned int chip_id;
+	int (*read)(struct tasdevice_priv *tas_dev, enum channel chn,
+		unsigned int reg, unsigned int *pValue);
+	int (*write)(struct tasdevice_priv *tas_dev, enum channel chn,
+		unsigned int reg, unsigned int Value);
+	int (*bulk_read)(struct tasdevice_priv *tas_dev, enum channel chn,
+		unsigned int reg, unsigned char *pData, unsigned int len);
+	int (*bulk_write)(struct tasdevice_priv *tas_dev, enum channel chn,
+		unsigned int reg, unsigned char *pData, unsigned int len);
+	int (*set_calibration)(void *tas_dev, enum channel chl,
+		int calibration);
+	void (*tas2781_reset)(struct tasdevice_priv *tas_dev);
+	void (*tas2781_set_global)(struct tasdevice_priv *tas_dev);
+	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_dev,
+		const struct firmware *pFW, int offset);
+	int (*fw_parse_program_data)(struct tasdevice_priv *tas_dev,
+		struct TFirmware *pFirmware,
+		const struct firmware *pFW, int offset);
+	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_dev,
+		struct TFirmware *pFirmware,
+		const struct firmware *pFW, int offset);
+	int (*tasdevice_load_block)(struct tasdevice_priv *tas_dev,
+		struct TBlock *pBlock);
+	int (*fw_parse_calibration_data)(struct tasdevice_priv *tas_dev,
+		struct TFirmware *pFirmware,
+		const struct firmware *pFW, int offset);
+	void (*irq_work_func)(struct tasdevice_priv *tas_dev);
+	int fw_state;
+	unsigned int magic_num;
+	unsigned char ndev;
+	unsigned char dev_name[32];
+	unsigned char regbin_binaryname[64];
+	unsigned char dsp_binaryname[64];
+	unsigned char cal_binaryname[MaxChn][64];
+	bool mb_runtime_suspend;
+	struct delayed_work powercontrol_work;
+	void *codec;
+	int sysclk;
+	int pstream;
+	int cstream;
+	bool mbCalibrationLoaded;
+};
+
+int tasdevice_dev_read(struct tasdevice_priv *pPcmdev,
+	enum channel chn, unsigned int reg, unsigned int *pValue);
+int tasdevice_process_block(void *pContext,
+	unsigned char *data, unsigned char dev_idx, int sublocksize);
+int tasdevice_dev_write(struct tasdevice_priv *pPcmdev,
+	enum channel chn, unsigned int reg, unsigned int value);
+
+int tasdevice_dev_bulk_write(
+	struct tasdevice_priv *pPcmdev, enum channel chn,
+	unsigned int reg, unsigned char *p_data, unsigned int n_length);
+
+int tasdevice_dev_bulk_read(struct tasdevice_priv *pPcmdev,
+	enum channel chn, unsigned int reg, unsigned char *p_data,
+	unsigned int n_length);
+
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *pPcmdev, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value);
+
+#endif /*__TAS2781_H__ */
-- 
2.17.1


