Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AC69B17E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBQQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBQQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:58:51 -0500
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC436243E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:58:42 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.194.158.46])
        by rmsmtp-lg-appmail-26-12031 (RichMail) with SMTP id 2eff63efb239e35-1e350;
        Sat, 18 Feb 2023 00:58:37 +0800 (CST)
X-RM-TRANSID: 2eff63efb239e35-1e350
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v3] ASoC: tas2781: Add tas2781 driver
Date:   Sat, 18 Feb 2023 00:58:20 +0800
Message-Id: <20230217165820.27707-1-13916275206@139.com>
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
Changes in v3:
 - fixed issues reported-by: kernel test robot <lkp@intel.com>
 - correct all the inconsistent indenting warnings.
 - correct uninitialized symbol 'pwr_state'
 - correct unsigned 'val' is never less than zero
 - correct 'tas_dev' could be null
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
 sound/soc/codecs/tas2781-dsp.c | 2253 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2781-dsp.h |  178 +++
 sound/soc/codecs/tas2781-i2c.c | 1913 +++++++++++++++++++++++++++
 sound/soc/codecs/tas2781.h     |  176 +++
 6 files changed, 4534 insertions(+)
 create mode 100644 sound/soc/codecs/tas2781-dsp.c
 create mode 100644 sound/soc/codecs/tas2781-dsp.h
 create mode 100644 sound/soc/codecs/tas2781-i2c.c
 create mode 100644 sound/soc/codecs/tas2781.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f9d71490075..9016c4846d95 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -223,6 +223,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2764
 	imply SND_SOC_TAS2770
 	imply SND_SOC_TAS2780
+	imply SND_SOC_TAS2781
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1579,6 +1580,17 @@ config SND_SOC_TAS2780
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
index 71d3ce5867e4..49f912aea19d 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -355,6 +355,7 @@ snd-soc-tas2552-objs := tas2552.o
 snd-soc-tas2562-objs := tas2562.o
 snd-soc-tas2764-objs := tas2764.o
 snd-soc-tas2780-objs := tas2780.o
+snd-soc-tas2781-objs :=	tas2781-i2c.o tas2781-dsp.o
 # Mux
 snd-soc-simple-mux-objs := simple-mux.o
 
@@ -606,6 +607,7 @@ obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS2562)	+= snd-soc-tas2562.o
 obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
+obj-$(CONFIG_SND_SOC_TAS2781)	+= snd-soc-tas2781.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2781-dsp.c b/sound/soc/codecs/tas2781-dsp.c
new file mode 100644
index 000000000000..08c554481ff0
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.c
@@ -0,0 +1,2253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable algo coff setting
+ * for one, two, even multiple TAS2781 chips.
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
+	block->n_subblocks = SMS_HTONL(data[offset], data[offset + 1],
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
+	unsigned int n_block;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	img_data->n_blk = SMS_HTONL(data[offset],
+		data[offset + 1], data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	img_data->dev_blks =
+		kcalloc(img_data->n_blk, sizeof(struct tasdev_blk),
+			GFP_KERNEL);
+	if (img_data->dev_blks == NULL) {
+		dev_err(tas_fmw->dev, "%s: FW memory failed!\n", __func__);
+		goto out;
+	}
+
+	for (n_block = 0; n_block < img_data->n_blk; n_block++) {
+		offset = fw_parse_block_data_kernel(tas_fmw,
+			&(img_data->dev_blks[n_block]), fmw, offset);
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
+	unsigned int  n_program = 0;
+
+	for (n_program = 0; n_program < tas_fmw->n_programs; n_program++) {
+		program = &(tas_fmw->programs[n_program]);
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
+	unsigned int n_configs;
+	struct tasdevice_config *config;
+
+	for (n_configs = 0; n_configs < tas_fmw->n_configurations;
+		n_configs++) {
+		config =
+			&(tas_fmw->configs[n_configs]);
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
+	unsigned int  n_program = 0, n_configs = 0;
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
+	tas_fmw->n_programs = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+
+	if (tas_fmw->n_programs == 0 || tas_fmw->n_programs >
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
+		kcalloc(tas_fmw->n_programs,
+		sizeof(struct tasdevice_prog), GFP_KERNEL);
+	if (tas_fmw->programs == NULL) {
+		dev_err(tas_dev->dev, "%s: mpPrograms memory failed!\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+
+	for (n_program = 0; n_program < tas_fmw->n_programs; n_program++) {
+		program = &(tas_fmw->programs[n_program]);
+		program->prog_size = SMS_HTONL(buf[offset], buf[offset + 1],
+			buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+	}
+	offset  += (4 * (5 - n_program));
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations error\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->n_configurations = SMS_HTONL(buf[offset], buf[offset + 1],
+		buf[offset + 2], buf[offset + 3]);
+	offset  += 4;
+	max_confs = (fw_hdr->ndev >= 4) ?
+		TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS :
+		TASDEVICE_MAXCONFIG_NUM_KERNEL;
+	if (tas_fmw->n_configurations == 0 ||
+		tas_fmw->n_configurations > max_confs) {
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
+	tas_fmw->configs = kcalloc(tas_fmw->n_configurations,
+		sizeof(struct tasdevice_config), GFP_KERNEL);
+	if (tas_fmw->configs == NULL) {
+		offset = -1;
+		goto out;
+	}
+
+	for (n_configs = 0; n_configs < tas_fmw->n_programs;
+		n_configs++) {
+		config =
+			&(tas_fmw->configs[n_configs]);
+		config->cfg_size = SMS_HTONL(buf[offset],
+			buf[offset + 1], buf[offset + 2], buf[offset + 3]);
+		offset  += 4;
+	}
+
+	offset  += (4 * (max_confs - n_configs));
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
+	for (i = 0; i < block->n_subblocks; i++) {
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
+				"%s: ERROR:%u %u out of memory\n",
+				__func__, length, blk_size);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int fw_parse_variable_header_git(struct tasdevice_priv *tas_dev,
+	const struct firmware *fmw, int offset)
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
+	unsigned int n_blk = 0;
+
+	if (tas_fmw->calibrations) {
+		struct tasdevice_calibration *calibration;
+
+		for (i = 0; i < tas_fmw->n_calibrations; i++) {
+			calibration = &(tas_fmw->calibrations[i]);
+			if (calibration) {
+				struct tasdevice_data *im =
+					&(calibration->dev_data);
+
+				if (im->dev_blks) {
+					struct tasdev_blk *block;
+
+					for (n_blk = 0; n_blk < im->n_blk;
+						n_blk++) {
+						block = &(im->dev_blks[n_blk]);
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
+	block->n_cmds = SMS_HTONL(data[offset], data[offset + 1],
+		data[offset + 2], data[offset + 3]);
+	offset  += 4;
+
+	n = block->n_cmds * 4;
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
+	unsigned int n_block;
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
+	img_data->n_blk = SMS_HTONS(data[offset], data[offset + 1]);
+	offset  += 2;
+
+	img_data->dev_blks =
+		kcalloc(img_data->n_blk, sizeof(struct tasdev_blk),
+			GFP_KERNEL);
+	if (img_data->dev_blks == NULL) {
+		dev_err(tas_fmw->dev, "%s: FW memory failed!\n", __func__);
+		goto out;
+	}
+	for (n_block = 0; n_block < img_data->n_blk; n_block++) {
+		offset = fw_parse_block_data(tas_fmw,
+			&(img_data->dev_blks[n_block]), fmw, offset);
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
+	unsigned int n_calibration = 0;
+	struct tasdevice_calibration *calibration = NULL;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mnCalibrations error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->n_calibrations = SMS_HTONS(data[offset], data[offset + 1]);
+	offset  += 2;
+
+	if (tas_fmw->n_calibrations != 1) {
+		dev_err(tas_dev->dev,
+			"%s: only support one calibraiton(%d)!\n",
+			__func__, tas_fmw->n_calibrations);
+		goto out;
+	}
+
+	tas_fmw->calibrations =
+		kcalloc(tas_fmw->n_calibrations,
+			sizeof(struct tasdevice_calibration), GFP_KERNEL);
+	if (tas_fmw->calibrations == NULL) {
+		dev_err(tas_dev->dev, "%s: mpCalibrations memory failed!\n",
+			__func__);
+		offset = -1;
+		goto out;
+	}
+	for (n_calibration = 0; n_calibration < tas_fmw->n_calibrations;
+		n_calibration++) {
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpCalibrations error\n",
+				__func__);
+			offset = -1;
+			goto out;
+		}
+		calibration = &(tas_fmw->calibrations[n_calibration]);
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
+	int n_program = 0;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -1;
+		goto out;
+	}
+	tas_fmw->n_programs = SMS_HTONS(buf[offset], buf[offset + 1]);
+	offset  += 2;
+
+	if (tas_fmw->n_programs == 0) {
+		dev_err(tas_dev->dev, "%s: mnPrograms is null, maybe calbin\n",
+			__func__);
+		//Do not "offset = -1;", because of calbin
+		goto out;
+	}
+
+	tas_fmw->programs =
+		kcalloc(tas_fmw->n_programs, sizeof(struct tasdevice_prog),
+			GFP_KERNEL);
+	if (tas_fmw->programs == NULL) {
+		offset = -1;
+		goto out;
+	}
+	for (n_program = 0; n_program < tas_fmw->n_programs; n_program++) {
+		int n = 0;
+
+		program = &(tas_fmw->programs[n_program]);
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
+	tas_fmw->n_configurations = SMS_HTONS(data[offset], data[offset + 1]);
+	offset  += 2;
+
+	if (tas_fmw->n_configurations == 0) {
+		dev_err(tas_dev->dev, "%s: mnConfigurations is zero\n",
+			__func__);
+		//Do not "offset = -1;", because of calbin
+		goto out;
+	}
+	tas_fmw->configs =
+		kcalloc(tas_fmw->n_configurations,
+				sizeof(struct tasdevice_config), GFP_KERNEL);
+
+	for (n_configs = 0; n_configs < tas_fmw->n_configurations;
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
+		ret = crc8(crc8_lookup_table, &val, 1, 0);
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
+	dev_info(tasdevice->dev,
+		"isYRAM: Bk 0x%02x, Pg 0x%02x, Rg 0x%02x\n",
+		book, page, reg);
+	dev_info(tasdevice->dev,
+		"isYRAM: crc_data.mnLen 0x%x, len 0x%x, nResult %d\n",
+		crc_data.len, len, ret);
+	dev_info(tasdevice->dev, "crc_data.mnOffset %x\n", crc_data.offset);
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
+						crc8(crc8_lookup_table,
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
+	unsigned int n_cmds = 0;
+	unsigned char book = 0;
+	unsigned char page = 0;
+	unsigned char offset = 0;
+	unsigned char val = 0;
+	unsigned int len = 0;
+	unsigned int sleep_dur = 0;
+	unsigned char crc_chksum = 0;
+	unsigned int n_value = 0;
+	int n_retry = 6;
+	unsigned char *data = block->data;
+	int chn = 0, chnend = 0;
+
+	dev_info(tas_dev->dev,
+		"load block: Type = %d, commands = %d\n",
+		block->type, block->n_cmds);
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
+		dev_info(tas_dev->dev,
+			"load block: Other Type = 0x%02x\n",
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
+		n_cmds = 0;
+
+		while (n_cmds < block->n_cmds) {
+			data = block->data + n_cmds * 4;
+
+			book = data[0];
+			page = data[1];
+			offset = data[2];
+			val = data[3];
+
+			n_cmds++;
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
+			} else if (offset == 0x81) {
+				sleep_dur = (book << 8) + page;
+				msleep(sleep_dur);
+			} else if (offset == 0x85) {
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
+					if (block->is_ychksum_present)
+						ret = do_multireg_checksum(
+							tas_dev, chn, book,
+							page, offset,
+							len);
+				} else {
+					ret = tasdevice_dev_write(tas_dev,
+						chn,
+						TASDEVICE_REG(book, page,
+						offset),
+						data[3]);
+					if (ret < 0)
+						goto end;
+					if (block->is_ychksum_present)
+						ret = do_singlereg_checksum(
+							tas_dev, chn, book,
+							page, offset,
+							data[3]);
+				}
+				if (block->is_ychksum_present) {
+					if (ret < 0)
+						goto check;
+					crc_chksum += (unsigned char)ret;
+				}
+
+				n_cmds++;
+				if (len >= 2)
+					n_cmds += ((len - 2) / 4) + 1;
+			}
+		}
+		if (block->is_pchksum_present) {
+			ret = tasdevice_dev_read(tas_dev, chn,
+				TASDEVICE_I2CChecksum, &n_value);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s: Channel %d\n",
+					__func__, chn);
+				goto check;
+			}
+			if ((n_value & 0xff) != block->pchksum) {
+				dev_err(tas_dev->dev,
+					"Block PChkSum Channel %d ", chn);
+				dev_err(tas_dev->dev,
+					"FW = 0x%x, Reg = 0x%x\n",
+					block->pchksum,
+					(n_value & 0xff));
+				ret = -EAGAIN;
+				tas_dev->tasdevice[chn].err_code |=
+					ERROR_PRAM_CRCCHK;
+				goto check;
+			}
+			ret = 0;
+			tas_dev->tasdevice[chn].err_code &=
+				~ERROR_PRAM_CRCCHK;
+			dev_info(tas_dev->dev, "Block[0x%02x] PChkSum match\n",
+				block->type);
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
+			dev_info(tas_dev->dev,
+				"Block[0x%x] YChkSum match\n", block->type);
+		}
+check:
+		if (ret == -EAGAIN) {
+			n_retry--;
+			if (n_retry > 0)
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
+				n_retry = 6;
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
+	unsigned int n_block = 0;
+	struct tasdev_blk *block = NULL;
+
+	dev_info(tas_dev->dev, "%s: TAS2781 load data: %s, Blocks = %d\n",
+		__func__, dev_data->name, dev_data->n_blk);
+
+	for (n_block = 0; n_block < dev_data->n_blk; n_block++) {
+		block = &(dev_data->dev_blks[n_block]);
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
+	unsigned int n_block = 0;
+	struct tasdev_blk *block = NULL;
+
+	dev_info(tas_dev->dev, "%s: TAS2781 load data: %s, Blocks = %d\n",
+		__func__, dev_data->name, dev_data->n_blk);
+
+	for (n_block = 0; n_block < dev_data->n_blk; n_block++) {
+		block = &(dev_data->dev_blks[n_block]);
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
+		dev_info(tas_dev->dev,
+			"%s: file = %s, file size %zd\n",
+			__func__, file_name, fw_entry->size);
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
+	int i = 0;
+
+	if (tas_dev->fmw) {
+		struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+
+		if (tas_fmw->programs) {
+			struct tasdevice_prog *program;
+
+			for (i = 0; i < tas_fmw->n_programs; i++) {
+				program = &(tas_fmw->programs[i]);
+				if (program) {
+					struct tasdevice_data
+						*im = &(program->dev_data);
+					struct tasdev_blk *blk;
+					unsigned int n_blk;
+
+					if (!im->dev_blks)
+						continue;
+
+					for (n_blk = 0; n_blk < im->n_blk;
+						n_blk++) {
+						blk = &(im->dev_blks[n_blk]);
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
+			for (i = 0; i < tas_fmw->n_configurations; i++) {
+				config = &(tas_fmw->configs[i]);
+				if (config) {
+					struct tasdevice_data
+						*im = &(config->dev_data);
+					struct tasdev_blk *block;
+					unsigned int n_blk;
+
+					if (!im->dev_blks)
+						continue;
+
+					for (n_blk = 0; n_blk < im->n_blk;
+						n_blk++) {
+						block = &(im->dev_blks[n_blk]);
+						kfree(block->data);
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
+	if (cfg_no >= tas_fmw->n_configurations) {
+		dev_err(tas_dev->dev,
+			"%s: cfg(%d) is not in range of conf %u\n",
+			__func__, cfg_no, tas_fmw->n_configurations);
+		goto out;
+	}
+
+	if (prm_no >= tas_fmw->n_programs) {
+		dev_err(tas_dev->dev,
+			"%s: prm(%d) is not in range of Programs %u\n",
+			__func__,  prm_no, tas_fmw->n_programs);
+		goto out;
+	}
+
+	if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
+		cfg_info == NULL) {
+		dev_err(tas_dev->dev,
+			"conf_no:%d should be in range from 0 to %u\n",
+			rca_conf_no, rca->ncfgs-1);
+		goto out;
+	} else {
+		dev_info(tas_dev->dev, "%s: rca_profile_conf_id = %d\n",
+			__func__, rca_conf_no);
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
+		dev_info(tas_dev->dev, "%s,fun %d,%d,%d\n", __func__,
+			tas_dev->tasdevice[i].cur_conf,
+			cfg_info[rca_conf_no]->active_dev,
+			tas_dev->tasdevice[i].is_loaderr);
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
+	} else {
+		dev_err(tas_dev->dev,
+			"%s: No device is in active in conf %d\n",
+			__func__, rca_conf_no);
+	}
+
+	status |= cfg_info[rca_conf_no]->active_dev;
+	dev_info(tas_dev->dev, "%s: DSP mode: load status is %08x\n",
+		__func__, status);
+out:
+	return prog_status;
+}
diff --git a/sound/soc/codecs/tas2781-dsp.h b/sound/soc/codecs/tas2781-dsp.h
new file mode 100644
index 000000000000..639e84e0b5b4
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable algo coff setting
+ * for one, two, even multiple TAS2781 chips.
+ *
+ * Author: Shenghao Ding <shenghao-ding@ti.com>
+ *         Kevin Lu <kevin-lu@ti.com>
+ */
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
+	unsigned int n_cmds;
+	unsigned int blk_size;
+	unsigned int n_subblocks;
+	unsigned char *data;
+};
+
+struct tasdevice_data {
+	char name[64];
+	unsigned int n_blk;
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
+	unsigned short n_programs;
+	struct tasdevice_prog *programs;
+	unsigned short n_configurations;
+	struct tasdevice_config *configs;
+	unsigned short n_calibrations;
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
index 000000000000..2b2b8367044f
--- /dev/null
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -0,0 +1,1913 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable algo coff setting
+ * for one, two, even multiple TAS2781 chips.
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
+/* max. length of the alsa mixer control name */
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
+	.reg_bits = 8,
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
+					"process_block: Out of memory\n");
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
+					"%s: BURST Out of memory\n", __func__);
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
+						"%s: deley Out of memory\n",
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
+					"%s: bit write Out of memory\n",
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
+			"%s: conf %d, block type:%s\t device idx = 0x%02x\n",
+			__func__, conf_no,
+			blocktype[cfg_info[conf_no]->blk_data[j]
+			->block_type-1], cfg_info[conf_no]->blk_data[j]
+		->dev_idx);
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
+					"%s: ERROR:%u %u out of memory\n",
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
+	if (tas_dev->rcabin.fw_hdr.binary_version_num >= 0x105) {
+		if (config_offset + 64 > (int)config_size) {
+			dev_err(tas_dev->dev,
+				"add config: Out of memory\n");
+			goto out;
+		}
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
+		cfg_info->nblocks, sizeof(struct tasdev_blk_data *),
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
+		if (cfg_info->blk_data[i]->regdata == 0) {
+			dev_err(tas_dev->dev,
+				"add config: regdata alloc failed!\n");
+			goto out;
+		}
+		if (config_offset + cfg_info->blk_data[i]->block_size
+			> config_size) {
+			dev_err(tas_dev->dev,
+			"%s: block_size Out of memory: i = %d nblocks = %u!\n",
+			__func__, i,
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
+	int val;
+	int i, ret = 0;
+
+	val = ucontrol->value.integer.value[0];
+	val = (val > mc->max) ? mc->max : val;
+	val = mc->invert ? mc->max - val : val;
+	val = (val < 0) ? 0 : val;
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
+	ucontrol->value.integer.value[0] = (int)val;
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
+
+	mask = (1 << fls(mc->max)) - 1;
+	mask <<= mc->shift;
+	val = ucontrol->value.integer.value[0];
+	val = (val > mc->max) ? mc->max : val;
+	val = mc->invert ? mc->max - val : val;
+	val = (val < 0) ? 0 : val;
+	for (i = 0; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			mc->reg, mask, (unsigned int)(val << mc->shift));
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
+	p_tasdevice->rcabin.profile_cfg_id =
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
+	struct tasdevice_fw *tas_fw = p_tasdevice->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->n_programs;
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
+	struct tasdevice_fw *tas_fw = p_tasdevice->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	/* Codec Lock Hold*/
+	mutex_lock(&p_tasdevice->codec_lock);
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->n_configurations - 1;
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
+	uinfo->value.integer.min = 1;
+	uinfo->value.integer.max = max(0, p_tasdevice->rcabin.ncfgs);
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
+		p_tasdevice->rcabin.profile_cfg_id;
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
+	pValue->value.integer.value[0] = pTAS2781->cur_prog;
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
+	pTAS2781->cur_prog = nProgram;
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
+	pValue->value.integer.value[0] = pTAS2781->cur_conf;
+	mutex_unlock(&pTAS2781->codec_lock);
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
+	mutex_lock(&tas_dev->codec_lock);
+	tas_dev->cur_conf = n_configuration;
+	mutex_unlock(&tas_dev->codec_lock);
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
+	if (unlikely(!fmw) || unlikely(!fmw->data)) {
+		dev_err(tas_dev->dev,
+		"Failed to read %s, no side - effect on driver running\n",
+		tas_dev->rca_binaryname);
+		ret = -1;
+		goto out;
+	}
+	buf = (unsigned char *)fmw->data;
+
+	dev_info(tas_dev->dev, "tasdev: rca_ready start\n");
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
+		"rca_ready: Out of Memory!\n");
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
+	rca->cfg_info = cfg_info;
+	rca->ncfgs = 0;
+	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
+		cfg_info[i] = tasdevice_add_config(context, &buf[offset],
+				fw_hdr->config_size[i]);
+		if (!cfg_info[i]) {
+			ret = -1;
+			dev_err(tas_dev->dev,
+				"add_config Memory alloc failed!\n");
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
+	dev_info(tas_dev->dev, "Firmware init complete\n");
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
+static void tasdevice_enable_irq(
+	struct tasdevice_priv *tas_dev, bool enable)
+{
+	if (enable) {
+		if (tas_dev->irq_info.is_irq_enable)
+			return;
+		if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
+			enable_irq(tas_dev->irq_info.irq);
+		tas_dev->irq_info.is_irq_enable = true;
+	} else {
+		if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
+			disable_irq_nosync(tas_dev->irq_info.irq);
+		tas_dev->irq_info.is_irq_enable = false;
+	}
+}
+
+static void tasdevice_set_power_state(
+	struct tasdevice_priv *tas_dev, int state)
+{
+	switch (state) {
+	case 0:
+		schedule_delayed_work(&tas_dev->tuning_switch_wrk,
+			msecs_to_jiffies(20));
+		break;
+	default:
+		if (!(tas_dev->pstream || tas_dev->cstream)) {
+			if (tas_dev->irq_work_func)
+				tasdevice_enable_irq(tas_dev, false);
+			tasdevice_select_cfg_blk(tas_dev,
+				tas_dev->rcabin.profile_cfg_id,
+				TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
+		}
+		break;
+	}
+}
+
+static int tasdevice_dapm_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *codec = snd_soc_dapm_to_component(w->dapm);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	int stream;
+
+	/* Codec Lock Hold */
+	mutex_lock(&tas_dev->codec_lock);
+	stream = strcmp(w->name, "SPK") ? SNDRV_PCM_STREAM_PLAYBACK :
+		SNDRV_PCM_STREAM_CAPTURE;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		dev_info(tas_dev->dev, "SND_SOC_DAPM_POST_PMU\n");
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tas_dev->pstream = 1;
+		else
+			tas_dev->cstream = 1;
+		tasdevice_set_power_state(tas_dev, 0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		dev_info(tas_dev->dev, "SND_SOC_DAPM_PRE_PMD\n");
+		/* stop DSP only when both playback and capture streams
+		 * are deactivated
+		 */
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tas_dev->pstream = 0;
+		else
+			tas_dev->cstream = 0;
+		if (tas_dev->pstream != 0 || tas_dev->cstream != 0)
+			goto out;
+		tasdevice_set_power_state(tas_dev, 1);
+		break;
+	}
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
+out:
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
+static void tuning_switch_routine(struct work_struct *work)
+{
+	struct tasdevice_priv *tas_dev =
+		container_of(work, struct tasdevice_priv,
+		tuning_switch_wrk.work);
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	int profile_cfg_id = 0;
+	int is_set_glb_mode = 0;
+
+	mutex_lock(&tas_dev->codec_lock);
+
+	if (tas_fmw) {
+		if (tas_dev->cur_prog >= tas_fmw->n_programs)
+			/*bypass all in rca is profile id 0*/
+			profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
+		else {
+			/*dsp mode or tuning mode*/
+			profile_cfg_id = tas_dev->rcabin.profile_cfg_id;
+			tas_fmw = tas_dev->fmw;
+			dev_info(tas_dev->dev, "%s: %s\n", __func__,
+				tas_fmw->configs[tas_dev->cur_conf].name);
+			is_set_glb_mode =
+				tasdevice_select_tuningprm_cfg(tas_dev,
+					tas_dev->cur_prog,
+					tas_dev->cur_conf,
+					profile_cfg_id);
+			if (tas_dev->set_global_mode != NULL)
+				tas_dev->set_global_mode(tas_dev);
+		}
+	}  else
+		profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
+
+	tasdevice_select_cfg_blk(tas_dev, profile_cfg_id,
+		TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
+	if (is_set_glb_mode && tas_dev->set_global_mode)
+		tas_dev->set_global_mode(tas_dev);
+	if (tas_dev->irq_work_func)
+		tasdevice_enable_irq(tas_dev, true);
+	mutex_unlock(&tas_dev->codec_lock);
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
+static void irq_work_routine(struct work_struct *pWork)
+{
+	struct tasdevice_priv *tas_dev =
+		container_of(pWork, struct tasdevice_priv,
+		irq_info.irq_work.work);
+
+	mutex_lock(&tas_dev->codec_lock);
+	if (tas_dev->runtime_suspend) {
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
+
+	/* get IRQ status after 100 ms */
+	schedule_delayed_work(&tas_dev->irq_info.irq_work,
+		msecs_to_jiffies(100));
+	return IRQ_HANDLED;
+}
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
+	for (i = 0; i < ndev; i++) {
+		tas_dev->tasdevice[i].dev_addr = dev_addrs[i];
+		dev_info(tas_dev->dev, "%s=0x%02x",
+			dts_dev_addr_tag[i],
+			tas_dev->tasdevice[i].dev_addr);
+	}
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
+		if (!rc) {
+			gpio_direction_output(tas_dev->rst_gpio, 1);
+			dev_info(tas_dev->dev, "reset-gpio = %d",
+				tas_dev->rst_gpio);
+			ndev++;
+		} else
+			dev_err(tas_dev->dev,
+				"%s: Failed to request gpio %d\n",
+				__func__, tas_dev->rst_gpio);
+	} else
+		dev_err(tas_dev->dev,
+			"Looking up node %s failed %d\n",
+			np->full_name,
+			tas_dev->rst_gpio);
+
+	strcpy(tas_dev->dev_name, tasdevice_id[tas_dev->chip_id].name);
+
+	tas_dev->irq_info.irq_gpio = of_get_named_gpio(np,
+		"interrupts", 0);
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio)) {
+		dev_dbg(tas_dev->dev, "interrupts gpio = %d",
+			tas_dev->irq_info.irq_gpio);
+		INIT_DELAYED_WORK(&tas_dev->irq_info.irq_work,
+			irq_work_routine);
+
+		rc = gpio_request(tas_dev->irq_info.irq_gpio,
+				"AUDEV-IRQ");
+		if (!rc) {
+			gpio_direction_input(
+				tas_dev->irq_info.irq_gpio);
+
+			tas_dev->irq_info.irq =
+				gpio_to_irq(
+				tas_dev->irq_info.irq_gpio);
+			dev_info(tas_dev->dev,
+				"irq = %d\n",
+				tas_dev->irq_info.irq);
+
+			rc = request_threaded_irq(
+				tas_dev->irq_info.irq,
+				tasdevice_irq_handler,
+				NULL, IRQF_TRIGGER_FALLING|
+				IRQF_ONESHOT,
+				SMARTAMP_MODULE_NAME, tas_dev);
+			if (!rc)
+				disable_irq_nosync(
+					tas_dev->irq_info.irq);
+			else
+				dev_err(tas_dev->dev,
+					"request_irq failed, %d\n",
+					rc);
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
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio) && rc == 0) {
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
+static int tasdevice_change_chn_book(struct tasdevice_priv *tas_dev,
+	enum channel chn, int book)
+{
+	int n_result = 0;
+	struct i2c_client *pClient =
+		(struct i2c_client *)tas_dev->client;
+
+	if (chn < tas_dev->ndev) {
+		if (tas_dev->glb_addr.ref_cnt != 0) {
+			tas_dev->glb_addr.ref_cnt = 0;
+			tas_dev->glb_addr.cur_book = -1;
+		}
+		pClient->addr = tas_dev->tasdevice[chn].dev_addr;
+		if (tas_dev->tasdevice[chn].cur_book != book) {
+			n_result = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, n_result);
+				goto out;
+			}
+			n_result = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+					__func__, n_result);
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
+		pClient->addr = tas_dev->glb_addr.dev_addr;
+		if (tas_dev->glb_addr.cur_book != book) {
+			n_result = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev,
+					"%s, 0ERROR, E=%d\n",
+					__func__, n_result);
+				goto out;
+			}
+			n_result = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (n_result < 0) {
+				dev_err(tas_dev->dev,
+					"%s, book%xERROR, E=%d\n",
+					__func__, book, n_result);
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
+		n_result = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = regmap_read(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), pValue);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR,E=%d\n",
+				__func__, n_result);
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
+		n_result = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = regmap_write(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), value);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
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
+		n_result = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = regmap_bulk_write(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), p_data, n_length);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
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
+		n_result = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (n_result < 0)
+			goto out;
+
+		n_result = regmap_bulk_read(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), p_data, n_length);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
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
+		n_result = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (n_result < 0)
+			goto out;
+		pClient->addr = tas_dev->tasdevice[chn].dev_addr;
+		n_result = regmap_update_bits(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), mask, value);
+		if (n_result < 0)
+			dev_err(tas_dev->dev, "%s, ERROR, E=%d\n",
+				__func__, n_result);
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
+	INIT_DELAYED_WORK(&tas_dev->tuning_switch_wrk,
+		tuning_switch_routine);
+
+	mutex_init(&tas_dev->codec_lock);
+	ret = devm_snd_soc_register_component(tas_dev->dev,
+		&soc_codec_driver_tasdevice,
+		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
+	if (ret)
+		dev_err(tas_dev->dev, "%s: codec register error:0x%08x\n",
+			__func__, ret);
+
+	INIT_DELAYED_WORK(&tas_dev->irq_info.irq_work, irq_work_routine);
+	tas_dev->irq_info.is_irq_enable = false;
+
+	dev_info(tas_dev->dev, "i2c register success\n");
+
+	return ret;
+}
+
+static void tasdevice_remove(struct tasdevice_priv *tas_dev)
+{
+	if (gpio_is_valid(tas_dev->rst_gpio))
+		gpio_free(tas_dev->rst_gpio);
+
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio)) {
+		if (delayed_work_pending(&tas_dev->irq_info.irq_work)) {
+			dev_info(tas_dev->dev, "cancel IRQ work\n");
+			cancel_delayed_work(&tas_dev->irq_info.irq_work);
+		}
+		cancel_delayed_work_sync(&tas_dev->irq_info.irq_work);
+	}
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
+	mutex_lock(&tas_dev->codec_lock);
+	tas_dev->runtime_suspend = true;
+
+	if (tas_dev->irq_work_func) {
+		if (delayed_work_pending(&tas_dev->irq_info.irq_work)) {
+			dev_dbg(tas_dev->dev, "cancel IRQ work\n");
+			cancel_delayed_work_sync(&tas_dev->irq_info.irq_work);
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
+	mutex_lock(&tas_dev->codec_lock);
+	tas_dev->runtime_suspend = false;
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
index 000000000000..ce9d3d162aa0
--- /dev/null
+++ b/sound/soc/codecs/tas2781.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+ *
+ * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * The TAS2781 driver implements a flexible and configurable algo coff setting
+ * for one, two, even multiple TAS2781 chips.
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
+	struct delayed_work irq_work;
+	bool is_irq_enable;
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
+	void (*irq_work_func)(struct tasdevice_priv *tas_dev);
+	int fw_state;
+	unsigned int magic_num;
+	unsigned char ndev;
+	unsigned char dev_name[32];
+	unsigned char rca_binaryname[64];
+	unsigned char coef_binaryname[64];
+	unsigned char cal_binaryname[max_chn][64];
+	bool runtime_suspend;
+	struct delayed_work tuning_switch_wrk;
+	void *codec;
+	int sysclk;
+	int pstream;
+	int cstream;
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


