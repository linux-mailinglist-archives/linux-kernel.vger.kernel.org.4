Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9B6B6513
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCLKte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCLKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:49:31 -0400
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A046091
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:49:21 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.194.157.166])
        by rmsmtp-lg-appmail-31-12045 (RichMail) with SMTP id 2f0d640dae2a239-3d992;
        Sun, 12 Mar 2023 18:49:18 +0800 (CST)
X-RM-TRANSID: 2f0d640dae2a239-3d992
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v4] ASoC: tas2781: Add tas2781 driver
Date:   Sun, 12 Mar 2023 18:48:48 +0800
Message-Id: <20230312104848.16575-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2781 driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v4:
 - make the entire comment block a C++ one
 - remove uncessary dbg log in the firmware downlaoding
 - remove simliar macro already defined in ALSA header
 - use crc8_populate_msb() to generate the crc lookup table
 - remove all the hungarian notation in the code
 - remove log failures to allocate
 - add comment for tas2781_digital_getvol on the reason to custom
   control, tas2781 contain book and page two-level regmap,
   especially book switching will set two registers, one is
   BXXPXXR00, the other is B0P0R7F, after switching to the
   correct book, then the code can leverage the mechanism for
   paging, and access the register.
 - return 1 in all of the put control callback
 - fix "Control names for volumes should end with Volume"
 - remove the Lock in the control callback functions
 - remove likely() or unlikely().
 - remove uncessary GPIO check for irq
 - remove unused functions
 - remove i2c check in the i2c probe
 Changes to be committed:
	modified:   sound/soc/codecs/Kconfig
	modified:   sound/soc/codecs/Makefile
	new file:   sound/soc/codecs/tas2781-dsp.c
	new file:   sound/soc/codecs/tas2781-dsp.h
	new file:   sound/soc/codecs/tas2781-i2c.c
	new file:   sound/soc/codecs/tas2781.h
---
 sound/soc/codecs/Kconfig       |   12 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tas2781-dsp.c | 2192 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2781-dsp.h |  178 +++
 sound/soc/codecs/tas2781-i2c.c | 1660 ++++++++++++++++++++++++
 sound/soc/codecs/tas2781.h     |  170 +++
 6 files changed, 4214 insertions(+)
 create mode 100644 sound/soc/codecs/tas2781-dsp.c
 create mode 100644 sound/soc/codecs/tas2781-dsp.h
 create mode 100644 sound/soc/codecs/tas2781-i2c.c
 create mode 100644 sound/soc/codecs/tas2781.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 07747565c3b5..e1afe1ced5d7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -229,6 +229,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2764
 	imply SND_SOC_TAS2770
 	imply SND_SOC_TAS2780
+	imply SND_SOC_TAS2781
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1637,6 +1638,17 @@ config SND_SOC_TAS2780
 	  Enable support for Texas Instruments TAS2780 high-efficiency
 	  digital input mono Class-D audio power amplifiers.
 
+config SND_SOC_TAS2781
+	tristate "Texas Instruments TAS2781 speaker amplifier"
+	depends on I2C
+	select REGMAP_I2C
+	select CRC8
+	help
+	  Enable support for Texas Instruments TAS2781 Smart Amplifier
+	  Digital input mono Class-D and DSP-inside audio power amplifiers.
+	  Note the TAS2781 driver implements a flexible and configurable
+	  algo coff setting, for one, two, even multiple TAS2781 chips.
+
 config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f1ca18f7946c..5559b9e9cc17 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -262,6 +262,7 @@ snd-soc-tas5805m-objs := tas5805m.o
 snd-soc-tas6424-objs := tas6424.o
 snd-soc-tda7419-objs := tda7419.o
 snd-soc-tas2770-objs := tas2770.o
+snd-soc-tas2781-objs :=	tas2781-i2c.o tas2781-dsp.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tfa989x-objs := tfa989x.o
 snd-soc-tlv320adc3xxx-objs := tlv320adc3xxx.o
@@ -619,6 +620,7 @@ obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS2562)	+= snd-soc-tas2562.o
 obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
+obj-$(CONFIG_SND_SOC_TAS2781)	+= snd-soc-tas2781.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2781-dsp.c b/sound/soc/codecs/tas2781-dsp.c
new file mode 100644
index 000000000000..2a1f0bbb95a5
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.c
@@ -0,0 +1,2192 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable algo coff setting
+// for one, two, even multiple TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
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
+#define ERROR_PRAM_CRCCHK			0x0000000
+#define ERROR_YRAM_CRCCHK			0x0000001
+#define BINFILE_VER				0
+#define DRV_VER				1
+#define	PPC_DRIVER_CRCCHK			0x00000200
+
+#define TAS2781_SA_COEFF_SWAP_REG		TASDEVICE_REG(0, 0x35, 0x2c)
+#define TAS2781_YRAM_BOOK1			140
+#define TAS2781_YRAM1_PAGE			42
+#define TAS2781_YRAM1_START_REG			88
+
+#define TAS2781_YRAM2_START_PAGE		43
+#define TAS2781_YRAM2_END_PAGE			49
+#define TAS2781_YRAM2_START_REG			8
+#define TAS2781_YRAM2_END_REG			127
+
+#define TAS2781_YRAM3_PAGE			50
+#define TAS2781_YRAM3_START_REG			8
+#define TAS2781_YRAM3_END_REG			27
+
+/*should not include B0_P53_R44-R47 */
+#define TAS2781_YRAM_BOOK2			0
+#define TAS2781_YRAM4_START_PAGE		50
+#define TAS2781_YRAM4_END_PAGE			60
+
+#define TAS2781_YRAM5_PAGE			61
+#define TAS2781_YRAM5_START_REG			8
+#define TAS2781_YRAM5_END_REG			27
+
+#define TASDEVICE_MAXPROGRAM_NUM_KERNEL			5
+#define TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS	64
+#define TASDEVICE_MAXCONFIG_NUM_KERNEL			10
+#define MAIN_ALL_DEVICES_1X				0x01
+#define MAIN_DEVICE_A_1X				0x02
+#define MAIN_DEVICE_B_1X				0x03
+#define MAIN_DEVICE_C_1X				0x04
+#define MAIN_DEVICE_D_1X				0x05
+#define COEFF_DEVICE_A_1X				0x12
+#define COEFF_DEVICE_B_1X				0x13
+#define COEFF_DEVICE_C_1X				0x14
+#define COEFF_DEVICE_D_1X				0x15
+#define PRE_DEVICE_A_1X					0x22
+#define PRE_DEVICE_B_1X					0x23
+#define PRE_DEVICE_C_1X					0x24
+#define PRE_DEVICE_D_1X					0x25
+
+struct tas_crc {
+	unsigned char offset;
+	unsigned char len;
+};
+
+const char deviceNumber[TASDEVICE_DSP_TAS_MAX_DEVICE] = {
+	1, 2, 1, 2, 1, 1, 0, 2, 4, 3, 1, 2, 3, 4
+};
+
+static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
+	struct tasdev_blk *block, const struct firmware *fmw, int offset)
+{
+	const unsigned char *data = fmw->data;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->type = SMS_HTONL(data[offset],
+			data[offset + 1], data[offset + 2],
+			data[offset + 3]);
+	offset  += 4;
+
+	if (offset + 1 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mbPChkSumPresent error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	block->is_pchksum_present = data[offset];
+	offset++;
+
+	if (offset + 1 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mnPChkSum error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->pchksum = data[offset];
+	offset++;
+
+	if (offset + 1 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mbYChkSumPresent error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	block->is_ychksum_present = data[offset];
+	offset++;
+
+	if (offset + 1 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mnYChkSum error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->ychksum = data[offset];
+	offset++;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: blk_size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->blk_size = SMS_HTONL(data[offset], data[offset + 1],
+		data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: nSublocks error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->nr_subblocks = SMS_HTONL(data[offset], data[offset + 1],
+		data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	block->data = kzalloc(block->blk_size, GFP_KERNEL);
+	if (block->data == NULL) {
+		offset = -1;
+		goto out;
+	}
+	memcpy(block->data, &data[offset], block->blk_size);
+	offset  += block->blk_size;
+out:
+	return offset;
+}
+
+static int fw_parse_data_kernel(struct tasdevice_fw *tas_fmw,
+	struct tasdevice_data *img_data, const struct firmware *fmw,
+	int offset)
+{
+	const unsigned char *data = fmw->data;
+	unsigned int nr_block;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	img_data->nr_blk = SMS_HTONL(data[offset],
+		data[offset + 1], data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	img_data->dev_blks =
+		kcalloc(img_data->nr_blk, sizeof(struct tasdev_blk),
+			GFP_KERNEL);
+	if (img_data->dev_blks == NULL) {
+		dev_err(tas_fmw->dev, "%s: FW memory failed!\n", __func__);
+		goto out;
+	}
+
+	for (nr_block = 0; nr_block < img_data->nr_blk; nr_block++) {
+		offset = fw_parse_block_data_kernel(tas_fmw,
+			&(img_data->dev_blks[nr_block]), fmw, offset);
+		if (offset < 0) {
+			offset = -1;
+			goto out;
+		}
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_program_data_kernel(
+	struct tasdevice_priv *tas_dev, struct tasdevice_fw *tas_fmw,
+	const struct firmware *fmw, int offset)
+{
+	struct tasdevice_prog *program;
+	unsigned int  nr_program = 0;
+
+	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
+		program = &(tas_fmw->programs[nr_program]);
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 64;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnAppMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPDMI2SMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnISnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnVSnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		//skip 3-byte reserved
+		offset  += 3;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPowerLDG error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		offset = fw_parse_data_kernel(tas_fmw, &(program->dev_data),
+			fmw, offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_configuration_data_kernel(
+	struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	const unsigned char *data = fmw->data;
+	unsigned int nr_configs;
+	struct tasdevice_config *config;
+
+	for (nr_configs = 0; nr_configs < tas_fmw->nr_configurations;
+		nr_configs++) {
+		config =
+			&(tas_fmw->configs[nr_configs]);
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		memcpy(config->name, &data[offset], 64);
+		offset  += 64;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: orientation error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnDevices error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 1;
+
+		if (offset + 2 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mProgram error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 2;
+
+		if (offset + 4 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnSamplingRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 4;
+
+		if (offset + 2 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrc error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 2;
+
+		if (offset + 2 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnFsRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 2;
+
+		if (offset + 4 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrcRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 4;
+		offset = fw_parse_data_kernel(tas_fmw,
+			&(config->dev_data), fmw, offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_variable_header_kernel(
+	struct tasdevice_priv *tas_dev, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+	const unsigned char *buf = fmw->data;
+	struct tasdevice_prog *program;
+	struct tasdevice_config *config;
+	unsigned int  nr_program = 0, nr_configs = 0;
+	unsigned short max_confs = TASDEVICE_MAXCONFIG_NUM_KERNEL;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_hdr->device_family = SMS_HTONS(buf[offset], buf[offset + 1]);
+	if (fw_hdr->device_family != 0) {
+		dev_err(tas_dev->dev, "ERROR:%s:not TAS device\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 2;
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnDevice error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_hdr->device = SMS_HTONS(buf[offset], buf[offset + 1]);
+	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		fw_hdr->device == 6) {
+		dev_err(tas_dev->dev, "ERROR:%s: not support device %d\n",
+			__func__, fw_hdr->device);
+		offset = -1;
+		goto out;
+	}
+	offset  += 2;
+	fw_hdr->ndev = deviceNumber[fw_hdr->device];
+
+	if (fw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"%s: ndev(%u) in dspbin dismatch ndev(%u) in DTS\n",
+			__func__, fw_hdr->ndev, tas_dev->ndev);
+		offset = -1;
+		goto out;
+	}
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnPrograms error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->nr_programs = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+
+	if (tas_fmw->nr_programs == 0 || tas_fmw->nr_programs >
+		TASDEVICE_MAXPROGRAM_NUM_KERNEL) {
+		dev_err(tas_dev->dev, "%s: mnPrograms is invalid\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	if (offset + 4 * TASDEVICE_MAXPROGRAM_NUM_KERNEL > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mpPrograms error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	tas_fmw->programs =
+		kcalloc(tas_fmw->nr_programs,
+		sizeof(struct tasdevice_prog), GFP_KERNEL);
+	if (tas_fmw->programs == NULL) {
+		dev_err(tas_dev->dev, "%s: mpPrograms memory failed!\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
+		program = &(tas_fmw->programs[nr_program]);
+		program->prog_size = SMS_HTONL(buf[offset], buf[offset + 1],
+			buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+	}
+	offset  += (4 * (5 - nr_program));
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->nr_configurations = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	max_confs = (fw_hdr->ndev >= 4) ?
+		TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS :
+		TASDEVICE_MAXCONFIG_NUM_KERNEL;
+	if (tas_fmw->nr_configurations == 0 ||
+		tas_fmw->nr_configurations > max_confs) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations is invalid\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	if (offset + 4 * max_confs > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mpConfigurations error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
+		sizeof(struct tasdevice_config), GFP_KERNEL);
+	if (tas_fmw->configs == NULL) {
+		offset = -1;
+		goto out;
+	}
+
+	for (nr_configs = 0; nr_configs < tas_fmw->nr_programs;
+		nr_configs++) {
+		config =
+			&(tas_fmw->configs[nr_configs]);
+		config->cfg_size = SMS_HTONL(buf[offset],
+			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+	}
+
+	offset  += (4 * (max_confs - nr_configs));
+out:
+	return offset;
+}
+
+static int tasdevice_load_block_kernel(
+	struct tasdevice_priv *tasdevice, struct tasdev_blk *block)
+{
+	int ret = 0;
+
+	unsigned char *data = block->data;
+	unsigned int i = 0, length = 0;
+	const unsigned int blk_size = block->blk_size;
+	unsigned char dev_idx = 0;
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tasdevice->fmw->fw_hdr);
+	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
+
+	if (fw_fixed_hdr->ppcver >= PPC3_VERSION) {
+		switch (block->type) {
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
+			dev_info(tasdevice->dev,
+				"%s: load block: Other Type = 0x%02x\n",
+				__func__, block->type);
+			break;
+		}
+	} else {
+		switch (block->type) {
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
+			dev_info(tasdevice->dev,
+				"%s: load block: Other Type = 0x%02x\n",
+				__func__, block->type);
+			break;
+		}
+	}
+
+	for (i = 0; i < block->nr_subblocks; i++) {
+		int rc = tasdevice_process_block(tasdevice, data + length,
+			dev_idx, blk_size - length);
+		if (rc < 0) {
+			dev_err(tasdevice->dev,
+				"%s: ERROR:%u %u sublock write error\n",
+				__func__, length, blk_size);
+			break;
+		}
+		length  += (unsigned int)rc;
+		if (blk_size < length) {
+			dev_err(tasdevice->dev,
+				"%s: ERROR:%u %u out of bounary\n",
+				__func__, length, blk_size);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int fw_parse_variable_header_git(struct tasdevice_priv
+	*tas_dev, const struct firmware *fmw, int offset)
+{
+	const unsigned char *buf = fmw->data;
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+	int i = strlen((char *)&buf[offset]);
+
+	i++;
+
+	if (offset + i > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	offset  += i;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_hdr->device_family = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (fw_hdr->device_family != 0) {
+		dev_err(tas_dev->dev, "ERROR:%s: not TAS device\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_hdr->device = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		fw_hdr->device == 6) {
+		dev_err(tas_dev->dev, "ERROR:%s: not support device %d\n",
+			__func__, fw_hdr->device);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	fw_hdr->ndev = deviceNumber[fw_hdr->device];
+	if (fw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"%s: ndev(%u) in dspbin dismatch ndev(%u) in DTS\n",
+			__func__, fw_hdr->ndev,
+			tas_dev->ndev);
+		offset = -1;
+	}
+
+out:
+	return offset;
+}
+
+static int fw_parse_variable_hdr_cal(struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	const unsigned char *buf = fmw->data;
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+	int i = strlen((char *)&buf[offset]);
+
+	i++;
+
+	if (offset + i > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+
+	offset  += i;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnDeviceFamily error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_hdr->device_family = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (fw_hdr->device_family != 0) {
+		dev_err(tas_dev->dev, "ERROR:%s: not TAS device\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnDevice error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_hdr->device = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		fw_hdr->device == 6) {
+		dev_err(tas_dev->dev, "ERROR:%s: not support device %d\n",
+			__func__, fw_hdr->device);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	fw_hdr->ndev = deviceNumber[fw_hdr->device];
+	if (fw_hdr->ndev != 1) {
+		dev_err(tas_dev->dev,
+			"%s: calbin must be 1, but currently ndev(%u)\n",
+			__func__, fw_hdr->ndev);
+		offset = -1;
+	}
+
+out:
+	return offset;
+}
+
+static inline void tas2781_clear_calfirmware(struct tasdevice_fw
+	*tas_fmw)
+{
+	int i = 0;
+	unsigned int blks = 0;
+
+	if (tas_fmw->calibrations) {
+		struct tasdevice_calibration *calibration;
+
+		for (i = 0; i < tas_fmw->nr_calibrations; i++) {
+			calibration = &(tas_fmw->calibrations[i]);
+			if (calibration) {
+				struct tasdevice_data *im =
+					&(calibration->dev_data);
+
+				if (im->dev_blks) {
+					struct tasdev_blk *block;
+
+					for (blks = 0; blks < im->nr_blk;
+						blks++) {
+						block = &(im->dev_blks[blks]);
+						kfree(block->data);
+					}
+					kfree(im->dev_blks);
+				}
+			}
+		}
+		kfree(tas_fmw->calibrations);
+	}
+	kfree(tas_fmw);
+}
+
+static int fw_parse_block_data(struct tasdevice_fw *tas_fmw,
+	struct tasdev_blk *block, const struct firmware *fmw, int offset)
+{
+	unsigned char *data = (unsigned char *)fmw->data;
+	int n;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mnType error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->type = SMS_HTONL(data[offset], data[offset + 1],
+		data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	if (tas_fmw->fw_hdr.fixed_hdr.drv_ver >=
+		PPC_DRIVER_CRCCHK) {
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_fmw->dev, "%s: mbPChkSumPresent error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		block->is_pchksum_present = data[offset];
+		offset++;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_fmw->dev, "%s: mnPChkSum error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		block->pchksum = data[offset];
+		offset++;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_fmw->dev, "%s: mbYChkSumPresent error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		block->is_ychksum_present = data[offset];
+		offset++;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_fmw->dev, "%s: mnYChkSum error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		block->ychksum = data[offset];
+		offset++;
+	} else {
+		block->is_pchksum_present = 0;
+		block->is_ychksum_present = 0;
+	}
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mnCommands error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	block->nr_cmds = SMS_HTONL(data[offset], data[offset + 1],
+		data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	n = block->nr_cmds * 4;
+	if (offset + n > fmw->size) {
+		dev_err(tas_fmw->dev,
+			"%s: File Size(%lu) error offset = %d n = %d\n",
+			__func__, (unsigned long)fmw->size, offset, n);
+		offset = -1;
+		goto out;
+	}
+	block->data = kmemdup(&data[offset], n, GFP_KERNEL);
+	if (block->data == NULL) {
+		offset = -1;
+		goto out;
+	}
+	offset  += n;
+out:
+	return offset;
+}
+
+static int fw_parse_data(struct tasdevice_fw *tas_fmw,
+	struct tasdevice_data *img_data, const struct firmware *fmw,
+	int offset)
+{
+	const unsigned char *data = (unsigned char *)fmw->data;
+	int n = 0;
+	unsigned int nr_block;
+
+	if (offset + 64 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mpName error\n", __func__);
+		n = -1;
+		goto out;
+	}
+	memcpy(img_data->name, &data[offset], 64);
+	offset  += 64;
+
+	n = strlen((char *)&data[offset]);
+	n++;
+	if (offset + n > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mpDescription error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += n;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: mnBlocks error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	img_data->nr_blk = SMS_HTONS(data[offset], data[offset + 1]);
+	offset  += 2;
+
+	img_data->dev_blks =
+		kcalloc(img_data->nr_blk, sizeof(struct tasdev_blk),
+			GFP_KERNEL);
+	if (img_data->dev_blks == NULL) {
+		dev_err(tas_fmw->dev, "%s: FW memory failed!\n", __func__);
+		goto out;
+	}
+	for (nr_block = 0; nr_block < img_data->nr_blk; nr_block++) {
+		offset = fw_parse_block_data(tas_fmw,
+			&(img_data->dev_blks[nr_block]), fmw, offset);
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
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	unsigned char *data = (unsigned char *)fmw->data;
+	unsigned int n = 0;
+	unsigned int nr_calibration = 0;
+	struct tasdevice_calibration *calibration = NULL;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnCalibrations error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->nr_calibrations = SMS_HTONS(data[offset], data[offset + 1]);
+	offset  += 2;
+
+	if (tas_fmw->nr_calibrations != 1) {
+		dev_err(tas_dev->dev,
+			"%s: only support one calibraiton(%d)!\n",
+			__func__, tas_fmw->nr_calibrations);
+		goto out;
+	}
+
+	tas_fmw->calibrations =
+		kcalloc(tas_fmw->nr_calibrations,
+			sizeof(struct tasdevice_calibration), GFP_KERNEL);
+	if (tas_fmw->calibrations == NULL) {
+		dev_err(tas_dev->dev, "%s: mpCalibrations memory failed!\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	for (nr_calibration = 0; nr_calibration < tas_fmw->nr_calibrations;
+		nr_calibration++) {
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpCalibrations error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		calibration = &(tas_fmw->calibrations[nr_calibration]);
+		offset  += 64;
+
+		n = strlen((char *)&data[offset]);
+		n++;
+		if (offset + n > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpDescription error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += n;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnProgram error, offset = %d\n", __func__,
+				offset);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnConfiguration error, offset = %d\n",
+				__func__,
+				offset);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		offset = fw_parse_data(tas_fmw, &(calibration->dev_data), fmw,
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
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_prog *program;
+	unsigned char *buf = (unsigned char *)fmw->data;
+	int nr_program = 0;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->nr_programs = SMS_HTONS(buf[offset], buf[offset + 1]);
+	offset  += 2;
+
+	if (tas_fmw->nr_programs == 0) {
+		dev_err(tas_dev->dev, "%s: mnPrograms is null, maybe calbin\n",
+			__func__);
+		//Do not "offset = -1;", because of calbin
+		goto out;
+	}
+
+	tas_fmw->programs =
+		kcalloc(tas_fmw->nr_programs, sizeof(struct tasdevice_prog),
+			GFP_KERNEL);
+	if (tas_fmw->programs == NULL) {
+		offset = -1;
+		goto out;
+	}
+	for (nr_program = 0; nr_program < tas_fmw->nr_programs; nr_program++) {
+		int n = 0;
+
+		program = &(tas_fmw->programs[nr_program]);
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 64;
+
+		n = strlen((char *)&buf[offset]);
+		n++;
+		if (offset + n > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpDescription error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+
+		offset  += n;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnAppMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPDMI2SMode error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnISnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnVSnsPD error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPowerLDG error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		offset = fw_parse_data(tas_fmw, &(program->dev_data), fmw,
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
+	struct tasdevice_fw *tas_fmw,
+	const struct firmware *fmw, int offset)
+{
+	unsigned char *data = (unsigned char *)fmw->data;
+	int n;
+	unsigned int n_configs;
+	struct tasdevice_config *config;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->nr_configurations = SMS_HTONS(data[offset], data[offset + 1]);
+	offset  += 2;
+
+	if (tas_fmw->nr_configurations == 0) {
+		dev_err(tas_dev->dev, "%s: Configurations is zero\n",
+			__func__);
+		//Do not "offset = -1;", because of calbin
+		goto out;
+	}
+	tas_fmw->configs =
+		kcalloc(tas_fmw->nr_configurations,
+				sizeof(struct tasdevice_config), GFP_KERNEL);
+
+	for (n_configs = 0; n_configs < tas_fmw->nr_configurations;
+		n_configs++) {
+		config =
+			&(tas_fmw->configs[n_configs]);
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: File Size error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		memcpy(config->name, &data[offset], 64);
+		offset  += 64;
+
+		n = strlen((char *)&data[offset]);
+		n++;
+		if (offset + n > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpDescription error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+
+		offset  += n;
+		if (offset + 2 > fmw->size) {
+			dev_err(tas_dev->dev,
+				"%s: mnDevice_orientation error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 2;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mProgram error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		if (offset + 4 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnSamplingRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 4;
+
+		if (offset + 1 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrc error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset++;
+
+		if (offset + 4 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnPLLSrcRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 4;
+
+		if (offset + 2 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mnFsRate error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		offset  += 2;
+
+		offset = fw_parse_data(tas_fmw, &(config->dev_data),
+			fmw, offset);
+		if (offset < 0)
+			goto out;
+	}
+out:
+	return offset;
+}
+
+static int fw_parse_header(struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
+	const unsigned char *buf = (unsigned char *)fmw->data;
+	const unsigned char magic_number[] = { 0x35, 0x35, 0x35, 0x32 };
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	if (memcmp(&buf[offset], magic_number, 4)) {
+		dev_err(tas_dev->dev, "%s: Magic number doesn't match",
+			__func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnFWSize error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_fixed_hdr->fwsize = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	if (fw_fixed_hdr->fwsize != fmw->size) {
+		dev_err(tas_dev->dev, "File size not match, %lu %u",
+			(unsigned long)fmw->size, fw_fixed_hdr->fwsize);
+		offset = -1;
+		goto out;
+	}
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnChecksum error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnPPCVersion error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_fixed_hdr->ppcver = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnFWVersion error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnDriverVersion error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	fw_fixed_hdr->drv_ver = SMS_HTONL(buf[offset],
+		buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnTimeStamp error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 4;
+	if (offset + 64 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mpDDCName error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	offset  += 64;
+
+ out:
+	return offset;
+}
+
+static int check_inpage_yram(struct tas_crc *cd, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	int ret = 0;
+
+	if (book == TAS2781_YRAM_BOOK1) {
+		if (page == TAS2781_YRAM1_PAGE) {
+			if (reg >= TAS2781_YRAM1_START_REG) {
+				cd->offset = reg;
+				cd->len = len;
+				ret = 1;
+			} else if ((reg + len) > TAS2781_YRAM1_START_REG) {
+				cd->offset = TAS2781_YRAM1_START_REG;
+				cd->len =
+				len - (TAS2781_YRAM1_START_REG - reg);
+				ret = 1;
+			} else
+				ret = 0;
+		} else if (page == TAS2781_YRAM3_PAGE) {
+			if (reg > TAS2781_YRAM3_END_REG) {
+				ret = 0;
+			} else if (reg >= TAS2781_YRAM3_START_REG) {
+				if ((reg + len) > TAS2781_YRAM3_END_REG) {
+					cd->offset = reg;
+					cd->len =
+					TAS2781_YRAM3_END_REG - reg + 1;
+					ret = 1;
+				} else {
+					cd->offset = reg;
+					cd->len = len;
+					ret = 1;
+				}
+			} else {
+				if ((reg + (len-1)) <
+					TAS2781_YRAM3_START_REG)
+					ret = 0;
+				else {
+					cd->offset =
+					TAS2781_YRAM3_START_REG;
+					cd->len =
+					len - (TAS2781_YRAM3_START_REG - reg);
+					ret = 1;
+				}
+			}
+		}
+	} else if (book ==
+		TAS2781_YRAM_BOOK2) {
+		if (page == TAS2781_YRAM5_PAGE) {
+			if (reg > TAS2781_YRAM5_END_REG) {
+				ret = 0;
+			} else if (reg >= TAS2781_YRAM5_START_REG) {
+				if ((reg + len) > TAS2781_YRAM5_END_REG) {
+					cd->offset = reg;
+					cd->len =
+					TAS2781_YRAM5_END_REG - reg + 1;
+					ret = 1;
+				} else {
+					cd->offset = reg;
+					cd->len = len;
+					ret = 1;
+				}
+			} else {
+				if ((reg + (len-1)) <
+					TAS2781_YRAM5_START_REG)
+					ret = 0;
+				else {
+					cd->offset =
+					TAS2781_YRAM5_START_REG;
+					cd->len =
+					len - (TAS2781_YRAM5_START_REG - reg);
+					ret = 1;
+				}
+			}
+		}
+	} else
+		ret = 0;
+
+	return ret;
+}
+
+static int check_inblock_yram(struct tas_crc *cd, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	int ret = 0;
+
+	if (book == TAS2781_YRAM_BOOK1) {
+		if (page < TAS2781_YRAM2_START_PAGE)
+			ret = 0;
+		else if (page <= TAS2781_YRAM2_END_PAGE) {
+			if (reg > TAS2781_YRAM2_END_REG)
+				ret = 0;
+			else if (reg >= TAS2781_YRAM2_START_REG) {
+				cd->offset = reg;
+				cd->len = len;
+				ret = 1;
+			} else {
+				if ((reg + (len-1)) <
+					TAS2781_YRAM2_START_REG)
+					ret = 0;
+				else {
+					cd->offset =
+					TAS2781_YRAM2_START_REG;
+					cd->len =
+					reg + len - TAS2781_YRAM2_START_REG;
+					ret = 1;
+				}
+			}
+		} else
+			ret = 0;
+	} else if (book ==
+		TAS2781_YRAM_BOOK2) {
+		if (page < TAS2781_YRAM4_START_PAGE)
+			ret = 0;
+		else if (page <= TAS2781_YRAM4_END_PAGE) {
+			if (reg > TAS2781_YRAM2_END_REG)
+				ret = 0;
+			else if (reg >= TAS2781_YRAM2_START_REG) {
+				cd->offset = reg;
+				cd->len = len;
+				ret = 1;
+			} else {
+				if ((reg + (len-1))
+					< TAS2781_YRAM2_START_REG)
+					ret = 0;
+				else {
+					cd->offset =
+					TAS2781_YRAM2_START_REG;
+					cd->len =
+					reg + len - TAS2781_YRAM2_START_REG;
+					ret = 1;
+				}
+			}
+		} else
+			ret = 0;
+	} else
+		ret = 0;
+
+	return ret;
+}
+
+static int check_yram(struct tas_crc *cd, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	int ret = 0;
+
+	ret = check_inpage_yram(cd, book, page, reg, len);
+	if (ret == 0)
+		ret = check_inblock_yram(cd, book,
+				page, reg, len);
+
+	return ret;
+}
+
+static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
+	enum channel chl, unsigned char book, unsigned char page,
+	unsigned char reg, unsigned char val)
+{
+	int ret = 0;
+	struct tas_crc crc_data;
+	unsigned int nData1 = 0;
+
+	if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (reg >= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
+		&& (reg <= (TASDEVICE_PAGE_REG(
+		TAS2781_SA_COEFF_SWAP_REG) + 4))) {
+		/*DSP swap command, pass */
+		ret = 0;
+		goto end;
+	}
+
+	ret = check_yram(&crc_data, book, page, reg, 1);
+	if (ret == 1) {
+		ret = tasdevice_dev_read(tasdevice, chl,
+			TASDEVICE_REG(book, page, reg), &nData1);
+		if (ret < 0)
+			goto end;
+
+		if (nData1 != val) {
+			dev_err(tasdevice->dev,
+				"B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
+				book, page, reg,
+				val, nData1);
+			ret = -EAGAIN;
+			tasdevice->tasdevice[chl].err_code |=
+				ERROR_YRAM_CRCCHK;
+			ret = -EAGAIN;
+			goto end;
+		}
+
+		ret = crc8(tasdevice->crc8_lkp_tbl, &val, 1, 0);
+	}
+
+end:
+	return ret;
+}
+
+static int do_multireg_checksum(struct tasdevice_priv *tasdevice,
+	enum channel chn, unsigned char book, unsigned char page,
+	unsigned char reg, unsigned int len)
+{
+	int ret = 0, i = 0;
+	unsigned char crc_chksum = 0;
+	unsigned char nBuf1[128] = {0};
+	struct tas_crc crc_data;
+
+	if ((reg + len-1) > 127) {
+		ret = -EINVAL;
+		dev_err(tasdevice->dev, "firmware error\n");
+		goto end;
+	}
+
+	if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG))
+		&& (reg == TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
+		&& (len == 4)) {
+		/*DSP swap command, pass */
+		ret = 0;
+		goto end;
+	}
+
+	ret = check_yram(&crc_data, book, page, reg, len);
+	if (ret == 1) {
+		if (len == 1) {
+			dev_err(tasdevice->dev, "firmware error\n");
+			ret = -EINVAL;
+			goto end;
+		} else {
+			ret = tasdevice_dev_bulk_read(tasdevice, chn,
+				TASDEVICE_REG(book, page, crc_data.offset),
+				nBuf1, crc_data.len);
+			if (ret < 0)
+				goto end;
+
+			for (i = 0; i < crc_data.len; i++) {
+				if ((book == TASDEVICE_BOOK_ID(
+					TAS2781_SA_COEFF_SWAP_REG))
+					&& (page == TASDEVICE_PAGE_ID(
+						TAS2781_SA_COEFF_SWAP_REG))
+					&& ((i + crc_data.offset)
+					>= TASDEVICE_PAGE_REG(
+						TAS2781_SA_COEFF_SWAP_REG))
+					&& ((i + crc_data.offset)
+					<= (TASDEVICE_PAGE_REG(
+						TAS2781_SA_COEFF_SWAP_REG)
+						+ 4))) {
+					/*DSP swap command, bypass */
+					continue;
+				} else
+					crc_chksum  +=
+						crc8(tasdevice->crc8_lkp_tbl,
+							&nBuf1[i], 1, 0);
+			}
+
+			ret = crc_chksum;
+		}
+	}
+
+end:
+	return ret;
+}
+
+static int tasdevice_load_block(struct tasdevice_priv *tas_dev,
+	struct tasdev_blk *block)
+{
+	int ret = 0;
+	unsigned int nr_cmds = 0;
+	unsigned char book = 0;
+	unsigned char page = 0;
+	unsigned char offset = 0;
+	unsigned char val = 0;
+	unsigned int len = 0;
+	unsigned int sleep_dur = 0;
+	unsigned char crc_chksum = 0;
+	unsigned int nr_value = 0;
+	int nr_retry = 6;
+	unsigned char *data = block->data;
+	int chn = 0, chnend = 0;
+
+	switch (block->type) {
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
+		dev_dbg(tas_dev->dev, "load block: Other Type = 0x%02x\n",
+			block->type);
+		break;
+	}
+
+	for (; chn < chnend; chn++) {
+		if (tas_dev->tasdevice[chn].is_loading == false)
+			continue;
+start:
+		if (block->is_pchksum_present) {
+			ret = tasdevice_dev_write(tas_dev, chn,
+				TASDEVICE_I2CChecksum, 0);
+			if (ret < 0)
+				goto end;
+		}
+
+		if (block->is_ychksum_present)
+			crc_chksum = 0;
+
+		nr_cmds = 0;
+
+		while (nr_cmds < block->nr_cmds) {
+			data = block->data + nr_cmds * 4;
+
+			book = data[0];
+			page = data[1];
+			offset = data[2];
+			val = data[3];
+
+			nr_cmds++;
+
+			if (offset <= 0x7F) {
+				ret = tasdevice_dev_write(tas_dev, chn,
+					TASDEVICE_REG(book, page, offset),
+					val);
+				if (ret < 0)
+					goto end;
+				if (block->is_ychksum_present) {
+					ret = do_singlereg_checksum(tas_dev,
+						chn, book, page, offset,
+						val);
+					if (ret < 0)
+						goto check;
+					crc_chksum  += (unsigned char)ret;
+				}
+				continue;
+			}
+			if (offset == 0x81) {
+				sleep_dur = (book << 8) + page;
+				msleep(sleep_dur);
+				continue;
+			}
+			if (offset == 0x85) {
+				data  += 4;
+				len = (book << 8) + page;
+				book = data[0];
+				page = data[1];
+				offset = data[2];
+				if (len > 1) {
+					ret = tasdevice_dev_bulk_write(
+						tas_dev, chn,
+						TASDEVICE_REG(book, page,
+						offset), data + 3, len);
+					if (ret < 0)
+						goto end;
+					if (!block->is_ychksum_present)
+						goto next;
+					ret = do_multireg_checksum(
+						tas_dev, chn, book,
+						page, offset,
+						len);
+					if (ret < 0)
+						goto check;
+					crc_chksum +=
+						(unsigned char)ret;
+				} else {
+					ret = tasdevice_dev_write(tas_dev,
+						chn,
+						TASDEVICE_REG(book, page,
+						offset),
+						data[3]);
+					if (ret < 0)
+						goto end;
+					if (!block->is_ychksum_present)
+						goto next;
+					ret = do_singlereg_checksum(
+						tas_dev, chn, book,
+						page, offset,
+						data[3]);
+					if (ret < 0)
+						goto check;
+					crc_chksum +=
+						(unsigned char)ret;
+				}
+next:
+				nr_cmds++;
+				if (len >= 2)
+					nr_cmds += ((len - 2) / 4) + 1;
+			}
+		}
+		if (block->is_pchksum_present) {
+			ret = tasdevice_dev_read(tas_dev, chn,
+				TASDEVICE_I2CChecksum, &nr_value);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s: Channel %d\n",
+					__func__, chn);
+				goto check;
+			}
+			if ((nr_value & 0xff) != block->pchksum) {
+				dev_err(tas_dev->dev,
+					"Block PChkSum Channel %d ", chn);
+				dev_err(tas_dev->dev,
+					"FW = 0x%x, Reg = 0x%x\n",
+					block->pchksum,
+					(nr_value & 0xff));
+				ret = -EAGAIN;
+				tas_dev->tasdevice[chn].err_code |=
+					ERROR_PRAM_CRCCHK;
+				goto check;
+			}
+			ret = 0;
+			tas_dev->tasdevice[chn].err_code &=
+				~ERROR_PRAM_CRCCHK;
+		}
+
+		if (block->is_ychksum_present) {
+			//TBD, open it when FW ready
+			dev_err(tas_dev->dev,
+				"Block YChkSum: FW = 0x%x, YCRC = 0x%x\n",
+				block->ychksum, crc_chksum);
+
+			tas_dev->tasdevice[chn].err_code &=
+				~ERROR_YRAM_CRCCHK;
+			ret = 0;
+		}
+check:
+		if (ret == -EAGAIN) {
+			nr_retry--;
+			if (nr_retry > 0)
+				goto start;
+			else {
+				if ((block->type == MAIN_ALL_DEVICES)
+					|| (block->type == MAIN_DEVICE_A)
+					|| (block->type == MAIN_DEVICE_B)
+					|| (block->type == MAIN_DEVICE_C)
+					|| (block->type == MAIN_DEVICE_D))
+					tas_dev->tasdevice[chn].cur_prog = -1;
+				else
+					tas_dev->tasdevice[chn].cur_conf = -1;
+				nr_retry = 6;
+			}
+		}
+	}
+end:
+	if (ret < 0)
+		dev_err(tas_dev->dev, "Block (%d) load error\n", block->type);
+
+	return ret;
+}
+
+
+static int tasdevice_load_data(struct tasdevice_priv *tas_dev,
+	struct tasdevice_data *dev_data)
+{
+	int ret = 0;
+	unsigned int nr_block = 0;
+	struct tasdev_blk *block = NULL;
+
+	for (nr_block = 0; nr_block < dev_data->nr_blk; nr_block++) {
+		block = &(dev_data->dev_blks[nr_block]);
+		ret = tas_dev->tasdevice_load_block(tas_dev, block);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+static int tasdevice_load_calibrated_data(
+	struct tasdevice_priv *tas_dev, struct tasdevice_data *dev_data)
+{
+	int ret = 0;
+	unsigned int nr_block = 0;
+	struct tasdev_blk *block = NULL;
+
+	for (nr_block = 0; nr_block < dev_data->nr_blk; nr_block++) {
+		block = &(dev_data->dev_blks[nr_block]);
+		ret = tasdevice_load_block(tas_dev, block);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+int tas2781_load_calibration(void *context,
+			char *file_name, enum channel i)
+{
+	int ret = 0, offset = 0;
+	struct firmware fmw;
+	const struct firmware *fw_entry = NULL;
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
+	struct tasdevice *tasdev = &(tas_dev->tasdevice[i]);
+	struct tasdevice_fw *tas_fmw = NULL;
+
+	ret = request_firmware(&fw_entry, file_name, tas_dev->dev);
+	if (!ret) {
+		if (!fw_entry->size) {
+			dev_err(tas_dev->dev,
+				"%s: file read error: size = %lu\n",
+				__func__, (unsigned long)fw_entry->size);
+			goto out;
+		}
+		fmw.size = fw_entry->size;
+		fmw.data = fw_entry->data;
+	} else {
+		dev_info(tas_dev->dev,
+			"%s: Request firmware %s failed\n",
+			__func__, file_name);
+		goto out;
+	}
+
+	tas_fmw = tasdev->cali_data_fmw = kcalloc(1,
+		sizeof(struct tasdevice_fw), GFP_KERNEL);
+	if (tasdev->cali_data_fmw == NULL) {
+		dev_err(tas_dev->dev, "%s: FW memory failed!\n", __func__);
+		ret = -1;
+		goto out;
+	}
+	tas_fmw->dev = tas_dev->dev;
+	offset = fw_parse_header(tas_dev, tas_fmw, &fmw, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev, "%s: fw_parse_header EXIT!\n", __func__);
+		goto out;
+	}
+	offset = fw_parse_variable_hdr_cal(tas_dev, tas_fmw, &fmw, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev,
+			"%s: fw_parse_variable_header_cal EXIT!\n", __func__);
+		goto out;
+	}
+	offset = fw_parse_program_data(tas_dev, tas_fmw, &fmw, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev, "%s: fw_parse_program_data EXIT!\n",
+			__func__);
+		goto out;
+	}
+	offset = fw_parse_configuration_data(tas_dev, tas_fmw, &fmw,
+		offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev,
+			"%s: fw_parse_configuration_data EXIT!\n", __func__);
+		goto out;
+	}
+	offset = fw_parse_calibration_data(tas_dev,
+		tas_fmw, &fmw, offset);
+	if (offset == -1) {
+		dev_err(tas_dev->dev, "%s: fw_parse_calibration_data EXIT!\n",
+			__func__);
+		goto out;
+	}
+	tasdev->is_calibrated_data_loaded = true;
+out:
+	if (fw_entry) {
+		release_firmware(fw_entry);
+		fw_entry = NULL;
+	}
+	return ret;
+}
+
+int tasdevice_dspfw_ready(const struct firmware *fmw, void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice_fw *tas_fmw = NULL;
+	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = NULL;
+	int offset = 0, ret = 0;
+
+	if (!fmw || !fmw->data) {
+		dev_err(tas_dev->dev, "%s: Failed to read firmware %s\n",
+			__func__, tas_dev->coef_binaryname);
+		ret = -1;
+		goto out;
+	}
+
+	tas_dev->fmw = kcalloc(1,
+		sizeof(struct tasdevice_fw), GFP_KERNEL);
+	if (tas_dev->fmw == NULL) {
+		ret = -1;
+		goto out;
+	}
+	tas_fmw = tas_dev->fmw;
+	tas_fmw->dev = tas_dev->dev;
+	offset = fw_parse_header(tas_dev, tas_fmw, fmw, offset);
+
+	if (offset == -1)
+		goto out;
+	fw_fixed_hdr = &(tas_fmw->fw_hdr.fixed_hdr);
+	switch (fw_fixed_hdr->drv_ver) {
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
+		break;
+	default:
+	if (fw_fixed_hdr->drv_ver == 0x100) {
+		if (fw_fixed_hdr->ppcver >= PPC3_VERSION) {
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
+			switch (fw_fixed_hdr->ppcver) {
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
+					"%s: PPCVersion must be 0x0 or 0x%02x",
+					__func__, PPC3_VERSION);
+				dev_err(tas_dev->dev, " Current:0x%02x\n",
+					fw_fixed_hdr->ppcver);
+				offset = -1;
+				break;
+			}
+		}
+	} else {
+		dev_err(tas_dev->dev,
+			"%s: DriverVersion must be 0x0, 0x230 or above 0x230 ",
+			__func__);
+		dev_err(tas_dev->dev, "current is 0x%02x\n",
+			fw_fixed_hdr->drv_ver);
+		offset = -1;
+	}
+		break;
+	}
+
+	offset = tas_dev->fw_parse_variable_header(tas_dev, fmw, offset);
+	if (offset == -1)
+		goto out;
+
+	offset = tas_dev->fw_parse_program_data(tas_dev, tas_fmw, fmw,
+		offset);
+	if (offset < 0) {
+		ret = -1;
+		goto out;
+	}
+	offset = tas_dev->fw_parse_configuration_data(tas_dev,
+		tas_fmw, fmw, offset);
+	if (offset < 0)
+		ret = -1;
+
+out:
+	return ret;
+}
+
+void tasdevice_calbin_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice *tasdev = NULL;
+	int i = 0;
+
+	if (tas_dev) {
+		for (i = 0; i < tas_dev->ndev; i++) {
+			tasdev = &(tas_dev->tasdevice[i]);
+			if (tasdev->cali_data_fmw) {
+				tas2781_clear_calfirmware(
+					tasdev->cali_data_fmw);
+				tasdev->cali_data_fmw = NULL;
+			}
+		}
+	}
+}
+
+void tasdevice_dsp_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	int i;
+	struct tasdev_blk *blk;
+	unsigned int nr_blk;
+
+	if (tas_dev->fmw) {
+		struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+
+		if (tas_fmw->programs) {
+			struct tasdevice_prog *program;
+
+			for (i = 0; i < tas_fmw->nr_programs; i++) {
+				program = &(tas_fmw->programs[i]);
+				if (program) {
+					struct tasdevice_data
+						*im = &(program->dev_data);
+
+					if (!im->dev_blks)
+						continue;
+
+					for (nr_blk = 0; nr_blk < im->nr_blk;
+						nr_blk++) {
+						blk =
+						&(im->dev_blks[nr_blk]);
+						kfree(blk->data);
+					}
+					kfree(im->dev_blks);
+				}
+			}
+			kfree(tas_fmw->programs);
+		}
+
+		if (tas_fmw->configs) {
+			struct tasdevice_config *config;
+
+			for (i = 0; i < tas_fmw->nr_configurations; i++) {
+				config = &(tas_fmw->configs[i]);
+				if (config) {
+					struct tasdevice_data
+						*im = &(config->dev_data);
+
+					if (!im->dev_blks)
+						continue;
+					for (nr_blk = 0; nr_blk < im->nr_blk;
+						nr_blk++) {
+						blk =
+						&(im->dev_blks[nr_blk]);
+						kfree(blk->data);
+					}
+					kfree(im->dev_blks);
+				}
+			}
+			kfree(tas_fmw->configs);
+		}
+		kfree(tas_fmw);
+		tas_dev->fmw = NULL;
+	}
+}
+
+static int tas2781_set_calibration(void *context, enum channel i,
+	int n_calibration)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	int ret = 0;
+	struct tasdevice *tasdevice = &(tas_dev->tasdevice[i]);
+	struct tasdevice_fw *cal_fmw = tasdevice->cali_data_fmw;
+
+	if ((!tas_dev->fmw->programs)
+		|| (!tas_dev->fmw->configs)) {
+		dev_err(tas_dev->dev, "%s, Firmware not loaded\n\r", __func__);
+		ret = 0;
+		goto out;
+	}
+
+	if (n_calibration == 0xFF || (n_calibration == 0x100
+		&& tasdevice->is_calibrated_data_loaded == false)) {
+		if (cal_fmw) {
+			tasdevice->is_calibrated_data_loaded = false;
+			tas2781_clear_calfirmware(cal_fmw);
+			cal_fmw = NULL;
+		}
+
+		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
+			tas_dev->dev_name, tas_dev->tasdevice[i].dev_addr);
+		ret = tas2781_load_calibration(tas_dev,
+			tas_dev->cal_binaryname[i], i);
+		if (ret != 0) {
+			dev_err(tas_dev->dev,
+				"%s: load %s error, no-side effect\n",
+				__func__, tas_dev->cal_binaryname[i]);
+			ret = 0;
+		}
+	}
+	tasdevice->is_loading = true;
+	tasdevice->is_loaderr = false;
+
+	if (cal_fmw) {
+		struct tasdevice_calibration *calibration =
+			cal_fmw->calibrations;
+
+		if (calibration)
+			tasdevice_load_calibrated_data(tas_dev,
+				&(calibration->dev_data));
+	} else
+		dev_err(tas_dev->dev,
+			"%s: No calibrated data for device %d\n", __func__, i);
+
+out:
+	return ret;
+}
+
+int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
+	int cfg_no, int rca_conf_no)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice_rca *rca = &(tas_dev->rcabin);
+	struct tasdevice_config_info **cfg_info = rca->cfg_info;
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	struct tasdevice_config *conf = NULL;
+	struct tasdevice_prog *program = NULL;
+	int i = 0;
+	int status = 0;
+	int prog_status = 0;
+
+	if (tas_fmw == NULL) {
+		dev_err(tas_dev->dev, "%s: Firmware is NULL\n", __func__);
+		goto out;
+	}
+
+	if (cfg_no >= tas_fmw->nr_configurations) {
+		dev_err(tas_dev->dev,
+			"%s: cfg(%d) is not in range of conf %u\n",
+			__func__, cfg_no, tas_fmw->nr_configurations);
+		goto out;
+	}
+
+	if (prm_no >= tas_fmw->nr_programs) {
+		dev_err(tas_dev->dev,
+			"%s: prm(%d) is not in range of Programs %u\n",
+			__func__,  prm_no, tas_fmw->nr_programs);
+		goto out;
+	}
+
+	if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
+		cfg_info == NULL) {
+		dev_err(tas_dev->dev,
+			"conf_no:%d should be in range from 0 to %u\n",
+			rca_conf_no, rca->ncfgs-1);
+		goto out;
+	}
+
+	conf = &(tas_fmw->configs[cfg_no]);
+	for (i = 0; i < tas_dev->ndev; i++) {
+		if (cfg_info[rca_conf_no]->active_dev & (1 << i)) {
+			if (tas_dev->tasdevice[i].cur_prog != prm_no) {
+				tas_dev->tasdevice[i].cur_conf = -1;
+				tas_dev->tasdevice[i].is_loading = true;
+				prog_status++;
+			}
+		} else
+			tas_dev->tasdevice[i].is_loading = false;
+		tas_dev->tasdevice[i].is_loaderr = false;
+	}
+
+	if (prog_status) {
+		program = &(tas_fmw->programs[prm_no]);
+		tasdevice_load_data(tas_dev, &(program->dev_data));
+		for (i = 0; i < tas_dev->ndev; i++) {
+			if (tas_dev->tasdevice[i].is_loaderr == true)
+				continue;
+			else if (tas_dev->tasdevice[i].is_loaderr == false
+				&& tas_dev->tasdevice[i].is_loading == true) {
+				struct tasdevice_fw *cal_fmw =
+					tas_dev->tasdevice[i].cali_data_fmw;
+
+				if (cal_fmw) {
+					struct tasdevice_calibration
+						*calibration =
+							cal_fmw->calibrations;
+
+					if (calibration)
+						tasdevice_load_calibrated_data(
+						tas_dev,
+						&(calibration->dev_data));
+				}
+				tas_dev->tasdevice[i].cur_prog = prm_no;
+			}
+		}
+	}
+
+	if (tas_dev->is_glb_calibrated_data_loaded == false) {
+		for (i = 0; i < tas_dev->ndev; i++)
+			tas2781_set_calibration(tas_dev, i, 0x100);
+		tas_dev->is_glb_calibrated_data_loaded = true;
+		/* No wise to reload calibrationdata everytime,
+		 * this code will work once even if calibrated
+		 * data still failed to be got
+		 */
+	}
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		if (tas_dev->tasdevice[i].cur_conf != cfg_no
+			&& (cfg_info[rca_conf_no]->active_dev & (1 << i))
+			&& (tas_dev->tasdevice[i].is_loaderr == false)) {
+			status++;
+			tas_dev->tasdevice[i].is_loading = true;
+		} else
+			tas_dev->tasdevice[i].is_loading = false;
+	}
+
+	if (status) {
+		status = 0;
+		tasdevice_load_data(tas_dev, &(conf->dev_data));
+		for (i = 0; i < tas_dev->ndev; i++) {
+			if (tas_dev->tasdevice[i].is_loaderr == true) {
+				status |= 1 << (i + 4);
+				continue;
+			} else if (tas_dev->tasdevice[i].is_loaderr == false
+				&& tas_dev->tasdevice[i].is_loading == true)
+				tas_dev->tasdevice[i].cur_conf = cfg_no;
+		}
+	} else
+		dev_err(tas_dev->dev,
+			"%s: No device is in active in conf %d\n",
+			__func__, rca_conf_no);
+
+	status |= cfg_info[rca_conf_no]->active_dev;
+out:
+	return prog_status;
+}
diff --git a/sound/soc/codecs/tas2781-dsp.h b/sound/soc/codecs/tas2781-dsp.h
new file mode 100644
index 000000000000..26a6f5796349
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable algo coff setting
+// for one, two, even multiple TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
+
+#ifndef __TASDEVICE_DSP_H__
+#define __TASDEVICE_DSP_H__
+
+#define MAIN_ALL_DEVICES			0x0d
+#define MAIN_DEVICE_A				0x01
+#define MAIN_DEVICE_B				0x08
+#define MAIN_DEVICE_C				0x10
+#define MAIN_DEVICE_D				0x14
+#define COEFF_DEVICE_A				0x03
+#define COEFF_DEVICE_B				0x0a
+#define COEFF_DEVICE_C				0x11
+#define COEFF_DEVICE_D				0x15
+#define PRE_DEVICE_A				0x04
+#define PRE_DEVICE_B				0x0b
+#define PRE_DEVICE_C				0x12
+#define PRE_DEVICE_D				0x16
+
+#define PPC3_VERSION				0x4100
+#define RCA_CONFIGID_BYPASS_ALL			0
+#define TASDEVICE_DEVICE_SUM			8
+#define TASDEVICE_CONFIG_SUM			64
+
+enum channel {
+	top_left_Chn,
+	top_right_chn,
+	bottom_left_Chn,
+	bottom_right_chn,
+	max_chn,
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
+	unsigned int fwsize;
+	unsigned int ppcver;
+	unsigned int drv_ver;
+};
+
+struct tasdevice_dspfw_hdr {
+	struct tasdevice_fw_fixed_hdr fixed_hdr;
+	unsigned short device_family;
+	unsigned short device;
+	unsigned char ndev;
+};
+
+struct tasdev_blk {
+	unsigned int type;
+	unsigned char is_pchksum_present;
+	unsigned char pchksum;
+	unsigned char is_ychksum_present;
+	unsigned char ychksum;
+	unsigned int nr_cmds;
+	unsigned int blk_size;
+	unsigned int nr_subblocks;
+	unsigned char *data;
+};
+
+struct tasdevice_data {
+	char name[64];
+	unsigned int nr_blk;
+	struct tasdev_blk *dev_blks;
+};
+struct tasdevice_prog {
+	unsigned int prog_size;
+	struct tasdevice_data dev_data;
+};
+
+struct tasdevice_config {
+	unsigned int cfg_size;
+	char name[64];
+	struct tasdevice_data dev_data;
+};
+
+struct tasdevice_calibration {
+	struct tasdevice_data dev_data;
+};
+
+struct tasdevice_fw {
+	struct tasdevice_dspfw_hdr fw_hdr;
+	unsigned short nr_programs;
+	struct tasdevice_prog *programs;
+	unsigned short nr_configurations;
+	struct tasdevice_config *configs;
+	unsigned short nr_calibrations;
+	struct tasdevice_calibration *calibrations;
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
+struct tasdevice_rca_hdr {
+	unsigned int img_sz;
+	unsigned int checksum;
+	unsigned int binary_version_num;
+	unsigned int drv_fw_version;
+	unsigned char plat_type;
+	unsigned char dev_family;
+	unsigned char reserve;
+	unsigned char ndev;
+	unsigned char devs[TASDEVICE_DEVICE_SUM];
+	unsigned int nconfig;
+	unsigned int config_size[TASDEVICE_CONFIG_SUM];
+};
+
+struct tasdev_blk_data {
+	unsigned char dev_idx;
+	unsigned char block_type;
+	unsigned short yram_checksum;
+	unsigned int block_size;
+	unsigned int n_subblks;
+	unsigned char *regdata;
+};
+
+struct tasdevice_config_info {
+	unsigned int nblocks;
+	unsigned int real_nblocks;
+	unsigned char active_dev;
+	struct tasdev_blk_data **blk_data;
+};
+
+struct tasdevice_rca {
+	struct tasdevice_rca_hdr fw_hdr;
+	int ncfgs;
+	struct tasdevice_config_info **cfg_info;
+	int profile_cfg_id;
+};
+
+int tasdevice_dspfw_ready(const struct firmware *fmw, void *context);
+void tasdevice_dsp_remove(void *context);
+void tasdevice_calbin_remove(void *context);
+int tas2781_load_calibration(void *tas_dev, char *filename,
+	enum channel i);
+int tasdevice_select_tuningprm_cfg(void *context, int prm,
+	int cfg_no, int rca_conf_no);
+
+#endif
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
new file mode 100644
index 000000000000..f097b3d52ec4
--- /dev/null
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -0,0 +1,1660 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable algo coff setting
+// for one, two, even multiple TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
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
+#include <linux/crc8.h>
+
+#include "tas2781.h"
+
+#define TASDEVICE_CRC8_POLYNOMIAL	0x4d
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
+	"topleft-channel",
+	"topright-channel",
+	"bottomleft-channel",
+	"bottomright-channel"
+};
+
+static const struct i2c_device_id tasdevice_id[] = {
+	{ "tas2781", TAS2781	 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tasdevice_id);
+
+static const struct regmap_range_cfg tasdevice_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = 256 * 128,
+		.selector_reg = TASDEVICE_PAGE_SELECT,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 128,
+	},
+};
+
+static const struct regmap_config tasdevice_regmap = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.ranges = tasdevice_ranges,
+	.num_ranges = ARRAY_SIZE(tasdevice_ranges),
+	.max_register = 256 * 128,
+};
+
+static const struct of_device_id tasdevice_of_match[] = {
+	{ .compatible = "ti,tas2781" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, tasdevice_of_match);
+
+int tasdevice_process_block(void *context,
+	unsigned char *data, unsigned char dev_idx, int sublocksize)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *)context;
+	unsigned char subblk_typ = data[1];
+	int subblk_offset = 2;
+	int chn = 0, chnend = 0;
+	int rc = 0;
+	int blktyp = dev_idx & 0xC0, idx = dev_idx & 0x3F;
+	bool is_err = false;
+
+	if (idx) {
+		chn = idx-1;
+		chnend = idx;
+	} else {
+		if (tas_dev->set_global_mode) {
+			chn = tas_dev->ndev;
+			chnend = tas_dev->ndev + 1;
+		} else {
+			chn = 0;
+			chnend = tas_dev->ndev;
+		}
+	}
+
+	for (; chn < chnend; chn++) {
+		if (tas_dev->set_global_mode == NULL &&
+			tas_dev->tasdevice[chn].is_loading == false)
+			continue;
+
+		is_err = false;
+		subblk_offset = 2;
+		switch (subblk_typ) {
+		case TASDEVICE_CMD_SING_W: {
+			int i = 0;
+			unsigned short len = SMS_HTONS(data[2], data[3]);
+
+			subblk_offset  += 2;
+			if (subblk_offset + 4 * len > sublocksize) {
+				dev_err(tas_dev->dev,
+					"process_block: Out of bounary\n");
+				is_err = true;
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
+					is_err = true;
+					dev_err(tas_dev->dev,
+					"process_block: single write error\n");
+				}
+				subblk_offset  += 4;
+			}
+		}
+			break;
+		case TASDEVICE_CMD_BURST: {
+				unsigned short len =
+					SMS_HTONS(data[2], data[3]);
+
+				subblk_offset  += 2;
+				if (subblk_offset + 4 + len > sublocksize) {
+					dev_err(tas_dev->dev,
+					"%s: BST Out of bounary\n", __func__);
+					is_err = true;
+					break;
+				}
+				if (len % 4) {
+					dev_err(tas_dev->dev,
+						"%s:Bst-len(%u)not div by 4\n",
+						__func__, len);
+					break;
+				}
+
+				rc = tasdevice_dev_bulk_write(tas_dev, chn,
+					TASDEVICE_REG(data[subblk_offset],
+						data[subblk_offset + 1],
+						data[subblk_offset + 2]),
+						&(data[subblk_offset + 4]),
+						len);
+				if (rc < 0) {
+					is_err = true;
+					dev_err(tas_dev->dev,
+						"%s: bulk_write error = %d\n",
+						__func__, rc);
+				}
+				subblk_offset  += (len + 4);
+			}
+			break;
+		case TASDEVICE_CMD_DELAY: {
+				unsigned short delay_time = 0;
+
+				if (subblk_offset + 2 > sublocksize) {
+					dev_err(tas_dev->dev,
+						"%s: deley Out of bounary\n",
+						__func__);
+					is_err = true;
+					break;
+				}
+				delay_time = SMS_HTONS(data[2], data[3]);
+				usleep_range(delay_time*1000, delay_time*1000);
+				subblk_offset  += 2;
+			}
+			break;
+		case TASDEVICE_CMD_FIELD_W:
+			if (subblk_offset + 6 > sublocksize) {
+				dev_err(tas_dev->dev,
+					"%s: bit write Out of bounary\n",
+					__func__);
+				is_err = true;
+				break;
+			}
+			rc = tasdevice_dev_update_bits(tas_dev, chn,
+				TASDEVICE_REG(data[subblk_offset + 2],
+					data[subblk_offset + 3],
+					data[subblk_offset + 4]),
+					data[subblk_offset + 1],
+					data[subblk_offset + 5]);
+			if (rc < 0) {
+				is_err = true;
+				dev_err(tas_dev->dev,
+					"%s: update_bits error = %d\n",
+					__func__, rc);
+			}
+			subblk_offset  += 6;
+			break;
+		default:
+			break;
+		};
+		if (is_err == true && blktyp != 0) {
+			if (blktyp == 0x80) {
+				tas_dev->tasdevice[chn].cur_prog = -1;
+				tas_dev->tasdevice[chn].cur_conf = -1;
+			} else
+				tas_dev->tasdevice[chn].cur_conf = -1;
+		}
+	}
+	return subblk_offset;
+}
+
+static void tasdevice_select_cfg_blk(void *pContext, int conf_no,
+	unsigned char block_type)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) pContext;
+	struct tasdevice_rca *rca = &(tas_dev->rcabin);
+	struct tasdevice_config_info **cfg_info = rca->cfg_info;
+	int j = 0, k = 0, chn = 0, chnend = 0;
+
+	if (conf_no >= rca->ncfgs || conf_no < 0 || NULL == cfg_info) {
+		dev_err(tas_dev->dev,
+			"conf_no should be not more than %u\n",
+			rca->ncfgs);
+		goto out;
+	}
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
+
+		for (k = 0; k < (int)cfg_info[conf_no]->blk_data[j]
+			->n_subblks; k++) {
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
+				tas_dev->tasdevice[chn].is_loading = true;
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
+					"%s: ERROR:%u %u out of bounary\n",
+					__func__, length,
+					cfg_info[conf_no]->blk_data[j]
+					->block_size);
+				break;
+			}
+		}
+		if (length != cfg_info[conf_no]->blk_data[j]->block_size)
+			dev_err(tas_dev->dev,
+				"%s: %u %u size is not same\n",
+				__func__, length,
+				cfg_info[conf_no]->blk_data[j]->block_size);
+
+	}
+
+out:
+	return;
+}
+
+static struct tasdevice_config_info *tasdevice_add_config(
+	void *context, unsigned char *config_data,
+	unsigned int config_size)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *)context;
+	struct tasdevice_config_info *cfg_info = NULL;
+	int config_offset = 0, i = 0;
+
+	cfg_info = kzalloc(
+			sizeof(struct tasdevice_config_info), GFP_KERNEL);
+	if (!cfg_info)
+		goto out;
+
+	if (tas_dev->rcabin.fw_hdr.binary_version_num >= 0x105) {
+		if (config_offset + 64 > (int)config_size) {
+			dev_err(tas_dev->dev,
+				"add config: Out of bounary\n");
+			goto out;
+		}
+		config_offset  += 64;
+	}
+
+	if (config_offset + 4 > (int)config_size) {
+		dev_err(tas_dev->dev,
+			"add config: Out of bounary\n");
+		goto out;
+	}
+	cfg_info->nblocks =
+		SMS_HTONL(config_data[config_offset],
+		config_data[config_offset + 1],
+	config_data[config_offset + 2], config_data[config_offset + 3]);
+	config_offset  +=  4;
+
+	cfg_info->blk_data = kcalloc(
+		cfg_info->nblocks, sizeof(struct tasdev_blk_data *),
+		GFP_KERNEL);
+	if (!cfg_info->blk_data)
+		goto out;
+
+	cfg_info->real_nblocks = 0;
+	for (i = 0; i < (int)cfg_info->nblocks; i++) {
+		if (config_offset + 12 > config_size) {
+			dev_err(tas_dev->dev,
+			"add config: Out of bounary: i = %d nblocks = %u!\n",
+			i, cfg_info->nblocks);
+			break;
+		}
+		cfg_info->blk_data[i] = kzalloc(
+			sizeof(struct tasdev_blk_data), GFP_KERNEL);
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
+		cfg_info->blk_data[i]->n_subblks =
+			SMS_HTONL(config_data[config_offset],
+			config_data[config_offset + 1],
+			config_data[config_offset + 2],
+		config_data[config_offset + 3]);
+
+		config_offset  += 4;
+		cfg_info->blk_data[i]->regdata = kzalloc(
+			cfg_info->blk_data[i]->block_size, GFP_KERNEL);
+		if (cfg_info->blk_data[i]->regdata == 0)
+			goto out;
+
+		if (config_offset + cfg_info->blk_data[i]->block_size
+			> config_size) {
+			dev_err(tas_dev->dev,
+			"%s: block_size Out of bounary: i = %d blks = %u!\n",
+			__func__, i, cfg_info->nblocks);
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
+
+// tas2781 contain book and page two-level regmap, especially book switching
+// will set two registers, one is BXXPXXR00, the other is B0P0R7F, after
+// switching to the correct book, then leverage the mechanism for paging to
+// access the register. Custom control is primarily for regmap booking,
+// paging depends on internal regmap mechanism
+static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int val;
+	unsigned int invert = mc->invert;
+	int max = mc->max;
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
+
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
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
+	int val;
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int i, ret = 0;
+
+	val = ucontrol->value.integer.value[0];
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+
+	if (tas_dev->set_global_mode != NULL) {
+		ret = tasdevice_dev_write(tas_dev, tas_dev->ndev,
+			mc->reg, (unsigned int)val);
+		if (ret)
+			dev_err(tas_dev->dev,
+			"%s, set digital vol error in global mode\n",
+			__func__);
+	} else {
+		for (i = 0; i < tas_dev->ndev; i++) {
+			ret = tasdevice_dev_write(tas_dev, i,
+				mc->reg, (unsigned int)val);
+			if (ret)
+				dev_err(tas_dev->dev,
+				"%s, set digital vol error in device %d\n",
+				__func__, i);
+		}
+	}
+
+	return 1;
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
+	int val;
+	unsigned char mask = 0;
+	int max = mc->max;
+	int ret = 0;
+	unsigned int invert = mc->invert;
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
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
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
+	int val;
+	int i, ret = 0;
+	unsigned char mask = 0;
+	int max = mc->max;
+	unsigned int invert = mc->invert;
+
+	mask = (1 << fls(mc->max)) - 1;
+	mask <<= mc->shift;
+	val = ucontrol->value.integer.value[0];
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+	for (i = 0; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			mc->reg, mask, (unsigned int)(val << mc->shift));
+		if (ret)
+			dev_err(tas_dev->dev,
+			"%s, set AMP vol error in device %d\n",
+			__func__, i);
+	}
+
+	return 1;
+}
+
+static const DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
+
+static const struct snd_kcontrol_new tas2781_snd_controls[] = {
+	SOC_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2781_AMP_LEVEL,
+		1, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, amp_vol_tlv),
+	SOC_SINGLE_RANGE_EXT_TLV("Digital Volume", TAS2781_DVC_LVL,
+		0, 0, 200, 1, tas2781_digital_getvol,
+		tas2781_digital_putvol, dvc_tlv),
+};
+
+static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+
+	tas_dev->rcabin.profile_cfg_id =
+		ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct tasdevice_fw *tas_fw = tas_dev->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->nr_programs;
+
+	return 0;
+}
+
+static int tasdevice_info_configurations(
+	struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct tasdevice_fw *tas_fw = tas_dev->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->nr_configurations - 1;
+
+
+	return 0;
+}
+
+static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 1;
+	uinfo->value.integer.max = max(0, tas_dev->rcabin.ncfgs);
+
+	return 0;
+}
+
+static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev
+		= snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] =
+		tas_dev->rcabin.profile_cfg_id;
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
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "TASDEVICE Profile id");
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
+	pValue->value.integer.value[0] = pTAS2781->cur_prog;
+
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
+	pTAS2781->cur_prog = nProgram;
+
+	return 1;
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
+	pValue->value.integer.value[0] = pTAS2781->cur_conf;
+
+	return 0;
+}
+
+static int tasdevice_configuration_put(
+	struct snd_kcontrol *pKcontrol,
+	struct snd_ctl_elem_value *pValue)
+{
+	struct snd_soc_component *codec
+			= snd_soc_kcontrol_component(pKcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	unsigned int n_configuration = pValue->value.integer.value[0];
+
+	tas_dev->cur_conf = n_configuration;
+
+	return 1;
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
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+	configuration_name = devm_kzalloc(tas_dev->dev,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+	if (!program_name || !configuration_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	scnprintf(program_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Program");
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
+	scnprintf(configuration_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+		"Configuration");
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
+static void tasdevice_rca_ready(const struct firmware *fmw,
+	void *context)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) context;
+	struct tasdevice_rca *rca = NULL;
+	struct tasdevice_rca_hdr *fw_hdr = NULL;
+	struct tasdevice_config_info **cfg_info = NULL;
+	const struct firmware *fw_entry = NULL;
+	unsigned char *buf = NULL;
+	int offset = 0, i = 0;
+	unsigned int total_config_sz = 0;
+	int ret = 0;
+
+	mutex_lock(&tas_dev->codec_lock);
+	rca = &(tas_dev->rcabin);
+	fw_hdr = &(rca->fw_hdr);
+	if (!fmw || !fmw->data) {
+		dev_err(tas_dev->dev,
+		"Failed to read %s, no side - effect on driver running\n",
+		tas_dev->rca_binaryname);
+		ret = -1;
+		goto out;
+	}
+	buf = (unsigned char *)fmw->data;
+
+	fw_hdr->img_sz = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	if (fw_hdr->img_sz != fmw->size) {
+		dev_err(tas_dev->dev,
+			"File size not match, %d %u", (int)fmw->size,
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
+	offset  += 8;
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
+		"ndev(%u) from rcabin and ndev(%u) from DTS does not match\n",
+		fw_hdr->ndev,
+		tas_dev->ndev);
+		ret = -1;
+		goto out;
+	}
+	if (offset + TASDEVICE_DEVICE_SUM > fw_hdr->img_sz) {
+		dev_err(tas_dev->dev,
+		"rca_ready: Out of bounary!\n");
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
+
+	for (i = 0; i < TASDEVICE_CONFIG_SUM; i++) {
+		fw_hdr->config_size[i] = SMS_HTONL(buf[offset],
+			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+		total_config_sz  += fw_hdr->config_size[i];
+	}
+
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
+		goto out;
+	}
+	rca->cfg_info = cfg_info;
+	rca->ncfgs = 0;
+	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
+		cfg_info[i] = tasdevice_add_config(context, &buf[offset],
+				fw_hdr->config_size[i]);
+		if (!cfg_info[i]) {
+			ret = -1;
+			break;
+		}
+		offset  += (int)fw_hdr->config_size[i];
+		rca->ncfgs  += 1;
+	}
+	tasdevice_create_controls(tas_dev);
+
+	tasdevice_dsp_remove(tas_dev);
+	tasdevice_calbin_remove(tas_dev);
+	tas_dev->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_dev->coef_binaryname, 64, "%s_coef.bin",
+		tas_dev->dev_name);
+	ret = request_firmware(&fw_entry, tas_dev->coef_binaryname,
+		tas_dev->dev);
+	if (!ret) {
+		ret = tasdevice_dspfw_ready(fw_entry, tas_dev);
+		release_firmware(fw_entry);
+		fw_entry = NULL;
+	} else {
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		dev_err(tas_dev->dev, "%s: load %s error\n", __func__,
+			tas_dev->coef_binaryname);
+		goto out;
+	}
+	tasdevice_dsp_create_control(tas_dev);
+
+	tas_dev->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	tas_dev->is_glb_calibrated_data_loaded = true;
+	for (i = 0; i < tas_dev->ndev; i++) {
+		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
+			tas_dev->dev_name, tas_dev->tasdevice[i].dev_addr);
+		ret = tas2781_load_calibration(tas_dev,
+			tas_dev->cal_binaryname[i], i);
+		if (ret != 0) {
+			dev_err(tas_dev->dev,
+				"%s: load %s error, no-side effect\n",
+				__func__,
+				tas_dev->cal_binaryname[i]);
+			ret = 0;
+			tas_dev->is_glb_calibrated_data_loaded = false;
+		}
+	}
+
+out:
+	mutex_unlock(&tas_dev->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+}
+
+static void tasdevice_config_info_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) context;
+	struct tasdevice_rca *rca = &(tas_dev->rcabin);
+	struct tasdevice_config_info **cfg_info = rca->cfg_info;
+	int i = 0, j = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (cfg_info) {
+		for (i = 0; i < rca->ncfgs; i++) {
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
+static void tasdevice_tuning_switch(
+	struct tasdevice_priv *tas_dev, int state)
+{
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	int profile_cfg_id = 0;
+	int is_set_glb_mode = 0;
+
+	if (state == 0) {
+		if (tas_fmw) {
+			if (tas_dev->cur_prog >= tas_fmw->nr_programs)
+				/*bypass all in rca is profile id 0*/
+				profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
+			else {
+				/*dsp mode or tuning mode*/
+				profile_cfg_id =
+					tas_dev->rcabin.profile_cfg_id;
+
+				is_set_glb_mode =
+					tasdevice_select_tuningprm_cfg(tas_dev,
+						tas_dev->cur_prog,
+						tas_dev->cur_conf,
+						profile_cfg_id);
+				if (tas_dev->set_global_mode != NULL)
+					tas_dev->set_global_mode(tas_dev);
+			}
+		}  else
+			profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
+
+		tasdevice_select_cfg_blk(tas_dev, profile_cfg_id,
+			TASDEVICE_BIN_BLK_PRE_POWER_UP);
+	} else
+		tasdevice_select_cfg_blk(tas_dev,
+			tas_dev->rcabin.profile_cfg_id,
+			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
+}
+
+static int tasdevice_dapm_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *codec = snd_soc_dapm_to_component(w->dapm);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	int state = 1;
+
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+	if (event == SND_SOC_DAPM_PRE_PMD)
+		state = 0;
+	tasdevice_tuning_switch(tas_dev, state);
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT_E("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
+		0, 0, tasdevice_dapm_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SPK("SPK", tasdevice_dapm_event),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("DMIC")
+};
+
+static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
+	{"SPK", NULL, "ASI"},
+	{"OUT", NULL, "SPK"},
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
+out:
+	return rc;
+}
+
+static int tasdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	struct tasdevice_priv *tas_dev = snd_soc_dai_get_drvdata(codec_dai);
+
+	tas_dev->sysclk = freq;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tasdevice_dai_ops = {
+	.startup = tasdevice_startup,
+	.hw_params = tasdevice_hw_params,
+	.set_sysclk = tasdevice_set_dai_sysclk,
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
+	crc8_populate_msb(tas_dev->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
+	tas_dev->codec = codec;
+	scnprintf(tas_dev->rca_binaryname, 64, "%s_rca.bin",
+		tas_dev->dev_name);
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL, tas_dev,
+		tasdevice_rca_ready);
+	if (ret)
+		dev_err(tas_dev->dev,
+			"%s: request_firmware_nowait error:0x%08x\n",
+			__func__, ret);
+
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+
+	tas2781_reset(tas_dev);
+	if (tas_dev->set_global_mode != NULL)
+		tas_dev->set_global_mode(tas_dev);
+
+	return ret;
+}
+
+static void tasdevice_deinit(void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
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
+static int tasdevice_parse_dt(struct tasdevice_priv *tas_dev)
+{
+	struct device_node *np = tas_dev->dev->of_node;
+	int rc = 0, i = 0, ndev = 0;
+	unsigned int dev_addrs[max_chn];
+	struct i2c_client *client = (struct i2c_client *)tas_dev->client;
+
+	ndev = of_property_read_variable_u32_array(np, "ti,audio-slots",
+		dev_addrs, 0, ARRAY_SIZE(dev_addrs));
+	if (ndev <= 0) {
+		ndev = 1;
+		dev_addrs[0] = client->addr;
+	}
+
+	for (i = 0; i < ndev; i++)
+		tas_dev->tasdevice[i].dev_addr = dev_addrs[i];
+
+	if (ndev > 1) {
+		rc = of_property_read_u32(np, "ti,broadcast-addr",
+				&(tas_dev->glb_addr.dev_addr));
+		if (rc) {
+			dev_err(tas_dev->dev,
+			"Looking up node %s failed %d\n",
+			np->full_name, rc);
+			tas_dev->glb_addr.dev_addr = 0;
+		}
+	}
+
+	tas_dev->ndev = ndev;
+
+	tas_dev->rst_gpio = of_get_named_gpio(np, "reset-gpios", i);
+	if (gpio_is_valid(tas_dev->rst_gpio)) {
+		rc = gpio_request(tas_dev->rst_gpio, "reset");
+		if (!rc)
+			gpio_direction_output(tas_dev->rst_gpio, 1);
+	}
+
+	strcpy(tas_dev->dev_name, tasdevice_id[tas_dev->chip_id].name);
+
+	tas_dev->irq_info.irq_gpio = of_get_named_gpio(np,
+		"interrupts", 0);
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio)) {
+		rc = gpio_request(tas_dev->irq_info.irq_gpio,
+				"AUDEV-IRQ");
+		if (!rc) {
+			gpio_direction_input(
+				tas_dev->irq_info.irq_gpio);
+
+			tas_dev->irq_info.irq =
+				gpio_to_irq(tas_dev->irq_info.irq_gpio);
+		} else
+			dev_err(tas_dev->dev,
+				"%s: GPIO %d request error\n",
+				__func__,
+				tas_dev->irq_info.irq_gpio);
+	} else
+		dev_err(tas_dev->dev,
+			"Looking up irq-gpio property in node %s failed %d\n",
+			np->full_name,
+			tas_dev->irq_info.irq_gpio);
+
+	return 0;
+}
+
+static int tasdevice_change_chn_book(struct tasdevice_priv *tas_dev,
+	enum channel chn, int book)
+{
+	int ret = 0;
+	struct i2c_client *client =
+		(struct i2c_client *)tas_dev->client;
+
+	if (chn < tas_dev->ndev) {
+		if (tas_dev->glb_addr.ref_cnt != 0) {
+			tas_dev->glb_addr.ref_cnt = 0;
+			tas_dev->glb_addr.cur_book = -1;
+		}
+		client->addr = tas_dev->tasdevice[chn].dev_addr;
+		if (tas_dev->tasdevice[chn].cur_book != book) {
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			tas_dev->tasdevice[chn].cur_book = book;
+		}
+	} else if (chn == tas_dev->ndev) {
+		int i = 0;
+
+		if (tas_dev->glb_addr.ref_cnt == 0)
+			for (i = 0; i < tas_dev->ndev; i++)
+				tas_dev->tasdevice[i].cur_book = -1;
+		client->addr = tas_dev->glb_addr.dev_addr;
+		if (tas_dev->glb_addr.cur_book != book) {
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (ret < 0) {
+				dev_err(tas_dev->dev,
+					"%s, 0ERROR, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_dev->dev,
+					"%s, book%xERROR, E=%d\n",
+					__func__, book, ret);
+				goto out;
+			}
+			tas_dev->glb_addr.cur_book = book;
+		}
+
+		tas_dev->glb_addr.ref_cnt++;
+	} else
+		dev_err(tas_dev->dev,
+			"%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+
+out:
+	return ret;
+}
+
+int tasdevice_dev_read(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned int *val)
+{
+	int ret = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn < tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_read(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), val);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, ERROR,E=%d\n",
+				__func__, ret);
+	} else {
+
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+	}
+
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return ret;
+}
+
+int tasdevice_dev_write(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned int value)
+{
+	int ret = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn <= tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_write(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), value);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, ret);
+	} else
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return ret;
+}
+
+int tasdevice_dev_bulk_write(
+	struct tasdevice_priv *tas_dev, enum channel chn,
+	unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn <= tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_write(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), data, len);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, ret);
+	} else
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return ret;
+}
+
+int tasdevice_dev_bulk_read(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = 0;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn < tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_read(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), data, len);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, ret);
+	} else
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return ret;
+}
+
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *tas_dev, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	int ret = 0;
+	struct i2c_client *client =
+		(struct i2c_client *)tas_dev->client;
+
+	mutex_lock(&tas_dev->dev_lock);
+	if (chn < tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+		client->addr = tas_dev->tasdevice[chn].dev_addr;
+		ret = regmap_update_bits(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), mask, value);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, ret);
+	} else {
+		dev_err(tas_dev->dev, "%s, ERROR, no such channel(%d)\n",
+			__func__, chn);
+		ret = -1;
+	}
+
+out:
+	mutex_unlock(&tas_dev->dev_lock);
+	return ret;
+}
+
+static void tas2781_set_global_mode(struct tasdevice_priv *tas_dev)
+{
+	int i = 0;
+	int ret = 0;
+
+	for (; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			TAS2871_MISC_CFG2, TAS2871_GLOBAL_ADDR_MASK,
+			TAS2871_GLOBAL_ADDR_ENABLE);
+		if (ret < 0) {
+			dev_err(tas_dev->dev,
+				"%s: chn %d set global fail, %d\n",
+				__func__, i, ret);
+			continue;
+		}
+	}
+}
+
+static int tasdevice_init(struct tasdevice_priv *tas_dev)
+{
+	int ret = 0, i = 0;
+
+	tas_dev->cur_prog = -1;
+	tas_dev->cur_conf = -1;
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		tas_dev->tasdevice[i].cur_book = -1;
+		tas_dev->tasdevice[i].cur_prog = -1;
+		tas_dev->tasdevice[i].cur_conf = -1;
+	}
+	mutex_init(&tas_dev->dev_lock);
+	if (tas_dev->glb_addr.dev_addr != 0
+		&& tas_dev->glb_addr.dev_addr < 0x7F)
+		tas_dev->set_global_mode = tas2781_set_global_mode;
+	dev_set_drvdata(tas_dev->dev, tas_dev);
+
+	mutex_init(&tas_dev->codec_lock);
+	ret = devm_snd_soc_register_component(tas_dev->dev,
+		&soc_codec_driver_tasdevice,
+		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
+	if (ret) {
+		dev_err(tas_dev->dev, "%s: codec register error:0x%08x\n",
+			__func__, ret);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static void tasdevice_remove(struct tasdevice_priv *tas_dev)
+{
+	snd_soc_unregister_component(tas_dev->dev);
+	if (gpio_is_valid(tas_dev->rst_gpio))
+		gpio_free(tas_dev->rst_gpio);
+
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
+		gpio_free(tas_dev->irq_info.irq_gpio);
+
+	mutex_destroy(&tas_dev->dev_lock);
+	mutex_destroy(&tas_dev->codec_lock);
+}
+
+static int tasdevice_i2c_probe(struct i2c_client *i2c)
+{
+	struct tasdevice_priv *tas_dev = NULL;
+	int ret = 0;
+	const struct i2c_device_id *id = i2c_match_id(tasdevice_id, i2c);
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
+		goto out;
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
+static void tasdevice_i2c_remove(struct i2c_client *client)
+{
+	struct tasdevice_priv *tas_dev = i2c_get_clientdata(client);
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
index 000000000000..5056290fe963
--- /dev/null
+++ b/sound/soc/codecs/tas2781.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable algo coff setting
+// for one, two, even multiple TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
+
+#ifndef __TAS2781_H__
+#define __TAS2781_H__
+
+#include "tas2781-dsp.h"
+
+#define SMARTAMP_MODULE_NAME		"tas2781"
+#define TASDEVICE_RETRY_COUNT		3
+#define TASDEVICE_ERROR_FAILED		-2
+
+#define TASDEVICE_RATES			(SNDRV_PCM_RATE_44100 |\
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |\
+	SNDRV_PCM_RATE_88200)
+#define TASDEVICE_MAX_CHANNELS		8
+
+#define TASDEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+/*PAGE Control Register (available in page0 of each book) */
+#define TASDEVICE_PAGE_SELECT		0x00
+#define TASDEVICE_BOOKCTL_PAGE		0x00
+#define TASDEVICE_BOOKCTL_REG		127
+#define TASDEVICE_BOOK_ID(reg)		(reg / (256 * 128))
+#define TASDEVICE_PAGE_ID(reg)		((reg % (256 * 128)) / 128)
+#define TASDEVICE_PAGE_REG(reg)		((reg % (256 * 128)) % 128)
+#define TASDEVICE_PGRG(reg)		((reg % (256 * 128)))
+#define TASDEVICE_REG(book, page, reg)	(((book * 256 * 128) + \
+					(page * 128)) + reg)
+
+	/*Software Reset */
+#define TAS2871_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x02)
+#define TAS2871_REG_SWRESET_RESET	BIT(0)
+
+	/* Enable Global addresses */
+#define TAS2871_MISC_CFG2		TASDEVICE_REG(0x0, 0X0, 0x07)
+#define TAS2871_GLOBAL_ADDR_MASK	BIT(1)
+#define TAS2871_GLOBAL_ADDR_ENABLE	BIT(1)
+
+	/*I2C Checksum */
+#define TASDEVICE_I2CChecksum		TASDEVICE_REG(0x0, 0x0, 0x7E)
+
+	/* Volume control */
+#define TAS2781_DVC_LVL			TASDEVICE_REG(0x0, 0x0, 0x1A)
+#define TAS2781_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
+#define TAS2781_AMP_LEVEL_MASK		GENMASK(5, 1)
+
+#define TASDEVICE_CMD_SING_W		0x1
+#define TASDEVICE_CMD_BURST		0x2
+#define TASDEVICE_CMD_DELAY		0x3
+#define TASDEVICE_CMD_FIELD_W		0x4
+
+enum audio_device {
+	TAS2781	= 0,
+};
+
+#define SMS_HTONS(a, b)			((((a)&0x00FF)<<8) | ((b)&0x00FF))
+#define SMS_HTONL(a, b, c, d)		((((a)&0x000000FF)<<24) | \
+	(((b)&0x000000FF)<<16) | (((c)&0x000000FF)<<8) | \
+	((d)&0x000000FF))
+
+struct tasdevice {
+	unsigned int dev_addr;
+	unsigned int err_code;
+	short cur_prog;
+	short cur_conf;
+	bool is_loading;
+	bool is_loaderr;
+	bool is_calibrated_data_loaded;
+	unsigned char cur_book;
+	struct tasdevice_fw *cali_data_fmw;
+};
+
+/*
+ * This item is used to store the generic i2c address of
+ * all the tas2781 devices for I2C broadcast during the multi-device
+ *  writes, useless in mono case.
+ */
+struct global_addr {
+	unsigned char cur_book;
+	unsigned int dev_addr;
+	int ref_cnt;
+};
+
+struct tas_control {
+	struct snd_kcontrol_new *tasdevice_profile_controls;
+	int nr_controls;
+};
+
+struct tasdevice_irqinfo {
+	int irq_gpio;
+	int irq;
+};
+
+struct tasdevice_priv {
+	struct device *dev;
+	void *client;
+	struct regmap *regmap;
+	struct mutex codec_lock;
+	struct mutex dev_lock;
+	int rst_gpio;
+	struct tasdevice tasdevice[max_chn];
+	struct tasdevice_fw *fmw;
+	struct tasdevice_rca rcabin;
+	struct tasdevice_irqinfo irq_info;
+	struct tas_control tas_ctrl;
+	struct global_addr glb_addr;
+	int cur_prog;
+	int cur_conf;
+	unsigned int chip_id;
+	void (*set_global_mode)(struct tasdevice_priv *tas_dev);
+	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_dev,
+		const struct firmware *fmw, int offset);
+	int (*fw_parse_program_data)(struct tasdevice_priv *tas_dev,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_dev,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int (*tasdevice_load_block)(struct tasdevice_priv *tas_dev,
+		struct tasdev_blk *pBlock);
+	int (*fw_parse_calibration_data)(struct tasdevice_priv *tas_dev,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int fw_state;
+	unsigned int magic_num;
+	unsigned char ndev;
+	unsigned char dev_name[32];
+	unsigned char rca_binaryname[64];
+	unsigned char coef_binaryname[64];
+	unsigned char cal_binaryname[max_chn][64];
+	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
+	void *codec;
+	unsigned int sysclk;
+	bool is_glb_calibrated_data_loaded;
+};
+
+int tasdevice_dev_read(struct tasdevice_priv *tasdevice,
+	enum channel chn, unsigned int reg, unsigned int *value);
+int tasdevice_process_block(void *context,
+	unsigned char *data, unsigned char dev_idx, int sublocksize);
+int tasdevice_dev_write(struct tasdevice_priv *tasdevice,
+	enum channel chn, unsigned int reg, unsigned int value);
+
+int tasdevice_dev_bulk_write(
+	struct tasdevice_priv *tasdevice, enum channel chn,
+	unsigned int reg, unsigned char *p_data, unsigned int n_length);
+
+int tasdevice_dev_bulk_read(struct tasdevice_priv *tasdevice,
+	enum channel chn, unsigned int reg, unsigned char *p_data,
+	unsigned int n_length);
+
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *tasdevice, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value);
+
+#endif /*__TAS2781_H__ */
-- 
2.34.1


