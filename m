Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170B56D1F76
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjCaLvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:51:18 -0400
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDDC610C1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:51:08 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[39.144.43.181])
        by rmsmtp-lg-appmail-20-12023 (RichMail) with SMTP id 2ef76426c69eb86-13b99;
        Fri, 31 Mar 2023 19:40:21 +0800 (CST)
X-RM-TRANSID: 2ef76426c69eb86-13b99
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v11] ASoC: tas2781: Add tas2781 driver
Date:   Fri, 31 Mar 2023 19:40:08 +0800
Message-Id: <20230331114008.12522-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2781 driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v11:
 - Add comment on why use be32_to_cpup instead of be32_to_cpu
 - Simplify the code in tasdevice_add_config
 - Correct the wrong spelling comments in tasdevice_add_config
 Changes to be committed:
	modified:   sound/soc/codecs/Kconfig
	modified:   sound/soc/codecs/Makefile
	new file:   sound/soc/codecs/tas2781-dsp.c
	new file:   sound/soc/codecs/tas2781-dsp.h
	new file:   sound/soc/codecs/tas2781-i2c.c
	new file:   sound/soc/codecs/tas2781.h
---
 sound/soc/codecs/Kconfig       |   13 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tas2781-dsp.c | 1830 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2781-dsp.h |  181 ++++
 sound/soc/codecs/tas2781-i2c.c | 1614 ++++++++++++++++++++++++++++
 sound/soc/codecs/tas2781.h     |  156 +++
 6 files changed, 3796 insertions(+)
 create mode 100644 sound/soc/codecs/tas2781-dsp.c
 create mode 100644 sound/soc/codecs/tas2781-dsp.h
 create mode 100644 sound/soc/codecs/tas2781-i2c.c
 create mode 100644 sound/soc/codecs/tas2781.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 07747565c3b5..c4e3eb748f09 100644
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
@@ -1637,6 +1638,18 @@ config SND_SOC_TAS2780
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
+	  algo coefficient setting, for one, two or even multiple TAS2781
+	  chips.
+
 config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f1ca18f7946c..2c41f162584c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -262,6 +262,7 @@ snd-soc-tas5805m-objs := tas5805m.o
 snd-soc-tas6424-objs := tas6424.o
 snd-soc-tda7419-objs := tda7419.o
 snd-soc-tas2770-objs := tas2770.o
+snd-soc-tas2781-objs := tas2781-i2c.o tas2781-dsp.o
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
index 000000000000..4974aeaf5a19
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.c
@@ -0,0 +1,1830 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
+
+#include <linux/crc8.h>
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "tas2781.h"
+
+#define ERROR_PRAM_CRCCHK			0x0000000
+#define ERROR_YRAM_CRCCHK			0x0000001
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
+#define TAS2781_YRAM5_START_REG			TAS2781_YRAM3_START_REG
+#define TAS2781_YRAM5_END_REG			TAS2781_YRAM3_END_REG
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
+	if (offset + 16 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+
+	/* convert data[offset], data[offset + 1], data[offset + 2] and
+	 * data[offset + 3] into host
+	 */
+	block->type = be32_to_cpup((__be32 *)&data[offset]);
+	offset += 4;
+
+	block->is_pchksum_present = data[offset];
+	offset++;
+
+	block->pchksum = data[offset];
+	offset++;
+
+	block->is_ychksum_present = data[offset];
+	offset++;
+
+	block->ychksum = data[offset];
+	offset++;
+
+	block->blk_size = be32_to_cpup((__be32 *)&data[offset]);
+	offset += 4;
+
+	block->nr_subblocks = be32_to_cpup((__be32 *)&data[offset]);
+	offset += 4;
+
+	if (offset + block->blk_size > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: nSublocks error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	/* instead of kzalloc+memcpy */
+	block->data = kmemdup(&data[offset], block->blk_size, GFP_KERNEL);
+	if (!block->data) {
+		offset = -ENOMEM;
+		goto out;
+	}
+	offset += block->blk_size;
+
+out:
+	return offset;
+}
+
+static int fw_parse_data_kernel(struct tasdevice_fw *tas_fmw,
+	struct tasdevice_data *img_data, const struct firmware *fmw,
+	int offset)
+{
+	const unsigned char *data = fmw->data;
+	struct tasdev_blk *blk;
+	unsigned int i;
+
+	if (offset + 4 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	img_data->nr_blk = be32_to_cpup((__be32 *)&data[offset]);
+	offset += 4;
+
+	img_data->dev_blks = kcalloc(img_data->nr_blk,
+		sizeof(struct tasdev_blk), GFP_KERNEL);
+	if (!img_data->dev_blks) {
+		offset = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < img_data->nr_blk; i++) {
+		blk = &(img_data->dev_blks[i]);
+		offset = fw_parse_block_data_kernel(tas_fmw, blk, fmw, offset);
+		if (offset < 0) {
+			offset = -EINVAL;
+			break;
+		}
+	}
+
+out:
+	return offset;
+}
+
+static int fw_parse_program_data_kernel(
+	struct tasdevice_priv *tas_dev, struct tasdevice_fw *tas_fmw,
+	const struct firmware *fmw, int offset)
+{
+	struct tasdevice_prog *program;
+	unsigned int i;
+
+	for (i = 0; i < tas_fmw->nr_programs; i++) {
+		program = &(tas_fmw->programs[i]);
+		if (offset + 72 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
+			offset = -EINVAL;
+			goto out;
+		}
+		/*skip 72 unused byts*/
+		offset += 72;
+
+		offset = fw_parse_data_kernel(tas_fmw, &(program->dev_data),
+			fmw, offset);
+		if (offset < 0)
+			goto out;
+	}
+
+out:
+	return offset;
+}
+
+static int fw_parse_configuration_data_kernel(
+	struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	const unsigned char *data = fmw->data;
+	struct tasdevice_config *config;
+	unsigned int i;
+
+	for (i = 0; i < tas_fmw->nr_configurations; i++) {
+		config = &(tas_fmw->configs[i]);
+		if (offset + 80 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
+			offset = -EINVAL;
+			goto out;
+		}
+		memcpy(config->name, &data[offset], 64);
+		/*skip extra 16 bytes*/
+		offset += 80;
+
+		offset = fw_parse_data_kernel(tas_fmw, &(config->dev_data),
+			fmw, offset);
+		if (offset < 0)
+			goto out;
+	}
+
+out:
+	return offset;
+}
+
+static int fw_parse_variable_header_kernel(
+	struct tasdevice_priv *tas_dev, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+	struct tasdevice_prog *program;
+	struct tasdevice_config *config;
+	const unsigned char *buf = fmw->data;
+	unsigned short max_confs;
+	unsigned int i;
+
+	if (offset + 12 + 4 * TASDEVICE_MAXPROGRAM_NUM_KERNEL > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	fw_hdr->device_family = be16_to_cpup((__be16 *)&buf[offset]);
+	if (fw_hdr->device_family != 0) {
+		dev_err(tas_dev->dev, "%s:not TAS device\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += 2;
+	fw_hdr->device = be16_to_cpup((__be16 *)&buf[offset]);
+	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		fw_hdr->device == 6) {
+		dev_err(tas_dev->dev, "Unsupported dev %d\n", fw_hdr->device);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += 2;
+	fw_hdr->ndev = deviceNumber[fw_hdr->device];
+
+	if (fw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"%s: ndev(%u) in dspbin mismatch ndev(%u) in DTS\n",
+			__func__, fw_hdr->ndev, tas_dev->ndev);
+		offset = -EINVAL;
+		goto out;
+	}
+
+	tas_fmw->nr_programs = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+
+	if (tas_fmw->nr_programs == 0 || tas_fmw->nr_programs >
+		TASDEVICE_MAXPROGRAM_NUM_KERNEL) {
+		dev_err(tas_dev->dev, "%s: mnPrograms is invalid\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+
+	tas_fmw->programs = kcalloc(tas_fmw->nr_programs,
+		sizeof(struct tasdevice_prog), GFP_KERNEL);
+	if (!tas_fmw->programs) {
+		offset = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < tas_fmw->nr_programs; i++) {
+		program = &(tas_fmw->programs[i]);
+		program->prog_size = be32_to_cpup((__be32 *)&buf[offset]);
+		offset += 4;
+	}
+
+	/* Skip the unused prog_size */
+	offset += 4 * (TASDEVICE_MAXPROGRAM_NUM_KERNEL - tas_fmw->nr_programs);
+
+	tas_fmw->nr_configurations = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+
+	/* The max number of config in firmware greater than 4 pieces of
+	 * tas2781s is different from the one lower than 4 pieces of
+	 * tas2781s.
+	 */
+	max_confs = (fw_hdr->ndev >= 4) ?
+		TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS :
+		TASDEVICE_MAXCONFIG_NUM_KERNEL;
+	if (tas_fmw->nr_configurations == 0 ||
+		tas_fmw->nr_configurations > max_confs) {
+		dev_err(tas_dev->dev, "%s: Conf is invalid\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+
+	if (offset + 4 * max_confs > fmw->size) {
+		dev_err(tas_dev->dev, "%s: mpConfigurations err\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+
+	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
+		sizeof(struct tasdevice_config), GFP_KERNEL);
+	if (!tas_fmw->configs) {
+		offset = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < tas_fmw->nr_programs; i++) {
+		config = &(tas_fmw->configs[i]);
+		config->cfg_size = be32_to_cpup((__be32 *)&buf[offset]);
+		offset += 4;
+	}
+
+	/* Skip the unused configs */
+	offset += 4 * (max_confs - tas_fmw->nr_programs);
+
+out:
+	return offset;
+}
+
+static int tasdevice_load_block_kernel(
+	struct tasdevice_priv *tasdevice, struct tasdev_blk *block)
+{
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tasdevice->fmw->fw_hdr);
+	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
+	const unsigned int blk_size = block->blk_size;
+	unsigned int i, length;
+	unsigned char *data = block->data;
+	unsigned char dev_idx = 0;
+
+	if (fw_fixed_hdr->ppcver >= PPC3_VERSION) {
+		switch (block->type) {
+		case MAIN_ALL_DEVICES_1X:
+			dev_idx = 0x80;
+			break;
+		case MAIN_DEVICE_A_1X:
+			dev_idx = 0x81;
+			break;
+		case COEFF_DEVICE_A_1X:
+		case PRE_DEVICE_A_1X:
+			dev_idx = 0xC1;
+			break;
+		case MAIN_DEVICE_B_1X:
+			dev_idx = 0x82;
+			break;
+		case COEFF_DEVICE_B_1X:
+		case PRE_DEVICE_B_1X:
+			dev_idx = 0xC2;
+			break;
+		case MAIN_DEVICE_C_1X:
+			dev_idx = 0x83;
+			break;
+		case COEFF_DEVICE_C_1X:
+		case PRE_DEVICE_C_1X:
+			dev_idx = 0xC3;
+			break;
+		case MAIN_DEVICE_D_1X:
+			dev_idx = 0x84;
+			break;
+		case COEFF_DEVICE_D_1X:
+		case PRE_DEVICE_D_1X:
+			dev_idx = 0xC4;
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
+			dev_idx = 0x81;
+			break;
+		case COEFF_DEVICE_A:
+		case PRE_DEVICE_A:
+			dev_idx = 0xC1;
+			break;
+		case MAIN_DEVICE_B:
+			dev_idx = 0x82;
+			break;
+		case COEFF_DEVICE_B:
+		case PRE_DEVICE_B:
+			dev_idx = 0xC2;
+			break;
+		case MAIN_DEVICE_C:
+			dev_idx = 0x83;
+			break;
+		case COEFF_DEVICE_C:
+		case PRE_DEVICE_C:
+			dev_idx = 0xC3;
+			break;
+		case MAIN_DEVICE_D:
+			dev_idx = 0x84;
+			break;
+		case COEFF_DEVICE_D:
+		case PRE_DEVICE_D:
+			dev_idx = 0xC4;
+			break;
+		default:
+			dev_info(tasdevice->dev,
+				"%s: load block: Other Type = 0x%02x\n",
+				__func__, block->type);
+			break;
+		}
+	}
+
+	for (i = 0, length = 0; i < block->nr_subblocks; i++) {
+		int rc = tasdevice_process_block(tasdevice, data + length,
+			dev_idx, blk_size - length);
+		if (rc < 0) {
+			dev_err(tasdevice->dev,
+				"%s: %u %u sublock write error\n",
+				__func__, length, blk_size);
+			break;
+		}
+		length += (unsigned int)rc;
+		if (blk_size < length) {
+			dev_err(tasdevice->dev, "%s: %u %u out of boundary\n",
+				__func__, length, blk_size);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int fw_parse_variable_hdr(struct tasdevice_priv
+	*tas_dev, struct tasdevice_dspfw_hdr *fw_hdr,
+	const struct firmware *fmw, int offset)
+{
+	const unsigned char *buf = fmw->data;
+	int len = strlen((char *)&buf[offset]);
+
+	len++;
+
+	if (offset + len + 8 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+
+	offset += len;
+
+	fw_hdr->device_family = be32_to_cpup((__be32 *)&buf[offset]);
+	if (fw_hdr->device_family != 0) {
+		dev_err(tas_dev->dev, "%s: not TAS device\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += 4;
+
+	fw_hdr->device = be32_to_cpup((__be32 *)&buf[offset]);
+	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
+		fw_hdr->device == 6) {
+		dev_err(tas_dev->dev, "Unsupported dev %d\n", fw_hdr->device);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += 4;
+	fw_hdr->ndev = deviceNumber[fw_hdr->device];
+
+out:
+	return offset;
+}
+
+static int fw_parse_variable_header_git(struct tasdevice_priv
+	*tas_dev, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+
+	offset = fw_parse_variable_hdr(tas_dev, fw_hdr, fmw, offset);
+	if (offset < 0)
+		goto out;
+	if (fw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"%s: ndev(%u) in dspbin mismatch ndev(%u) in DTS\n",
+			__func__, fw_hdr->ndev, tas_dev->ndev);
+		offset = -EINVAL;
+	}
+
+out:
+	return offset;
+}
+
+static int fw_parse_variable_hdr_cal(struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+
+	offset = fw_parse_variable_hdr(tas_dev, fw_hdr, fmw, offset);
+	if (offset < 0)
+		goto out;
+	if (fw_hdr->ndev != 1) {
+		dev_err(tas_dev->dev,
+			"%s: calbin must be 1, but currently ndev(%u)\n",
+			__func__, fw_hdr->ndev);
+		offset = -EINVAL;
+	}
+
+out:
+	return offset;
+}
+
+static inline void tas2781_clear_calfirmware(struct tasdevice_fw
+	*tas_fmw)
+{
+	struct tasdevice_calibration *calibration;
+	struct tasdev_blk *block;
+	struct tasdevice_data *im;
+	unsigned int blks;
+	int i;
+
+	if (!tas_fmw->calibrations)
+		goto out;
+
+	for (i = 0; i < tas_fmw->nr_calibrations; i++) {
+		calibration = &(tas_fmw->calibrations[i]);
+		if (!calibration)
+			continue;
+
+		im = &(calibration->dev_data);
+
+		if (!im->dev_blks)
+			continue;
+
+		for (blks = 0; blks < im->nr_blk; blks++) {
+			block = &(im->dev_blks[blks]);
+			if (!block)
+				continue;
+			kfree(block->data);
+		}
+		kfree(im->dev_blks);
+	}
+	kfree(tas_fmw->calibrations);
+out:
+	kfree(tas_fmw);
+}
+
+static int fw_parse_block_data(struct tasdevice_fw *tas_fmw,
+	struct tasdev_blk *block, const struct firmware *fmw, int offset)
+{
+	unsigned char *data = (unsigned char *)fmw->data;
+	int n;
+
+	if (offset + 8 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: Type error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	block->type = be32_to_cpup((__be32 *)&data[offset]);
+	offset += 4;
+
+	if (tas_fmw->fw_hdr.fixed_hdr.drv_ver >= PPC_DRIVER_CRCCHK) {
+		if (offset + 4 > fmw->size) {
+			dev_err(tas_fmw->dev, "PChkSumPresent error\n");
+			offset = -EINVAL;
+			goto out;
+		}
+		block->is_pchksum_present = data[offset];
+		offset++;
+
+		block->pchksum = data[offset];
+		offset++;
+
+		block->is_ychksum_present = data[offset];
+		offset++;
+
+		block->ychksum = data[offset];
+		offset++;
+	} else {
+		block->is_pchksum_present = 0;
+		block->is_ychksum_present = 0;
+	}
+
+	block->nr_cmds = be32_to_cpup((__be32 *)&data[offset]);
+	offset += 4;
+
+	n = block->nr_cmds * 4;
+	if (offset + n > fmw->size) {
+		dev_err(tas_fmw->dev,
+			"%s: File Size(%lu) error offset = %d n = %d\n",
+			__func__, (unsigned long)fmw->size, offset, n);
+		offset = -EINVAL;
+		goto out;
+	}
+	/* instead of kzalloc+memcpy */
+	block->data = kmemdup(&data[offset], n, GFP_KERNEL);
+	if (!block->data) {
+		offset = -ENOMEM;
+		goto out;
+	}
+	offset += n;
+
+out:
+	return offset;
+}
+
+/* When parsing error occurs, all the memory resource will be released
+ * in the end of tasdevice_rca_ready.
+ */
+static int fw_parse_data(struct tasdevice_fw *tas_fmw,
+	struct tasdevice_data *img_data, const struct firmware *fmw,
+	int offset)
+{
+	const unsigned char *data = (unsigned char *)fmw->data;
+	struct tasdev_blk *blk;
+	unsigned int i;
+	int n;
+
+	if (offset + 64 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: Name error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	memcpy(img_data->name, &data[offset], 64);
+	offset += 64;
+
+	n = strlen((char *)&data[offset]);
+	n++;
+	if (offset + n + 2 > fmw->size) {
+		dev_err(tas_fmw->dev, "%s: Description error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += n;
+	img_data->nr_blk = be16_to_cpup((__be16 *)&data[offset]);
+	offset += 2;
+
+	img_data->dev_blks = kcalloc(img_data->nr_blk,
+		sizeof(struct tasdev_blk), GFP_KERNEL);
+	if (!img_data->dev_blks) {
+		offset = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < img_data->nr_blk; i++) {
+		blk = &(img_data->dev_blks[i]);
+		offset = fw_parse_block_data(tas_fmw, blk, fmw, offset);
+		if (offset < 0) {
+			offset = -EINVAL;
+			goto out;
+		}
+	}
+
+out:
+	return offset;
+}
+
+/* When calibrated data parsing error occurs, DSP can still work with default
+ * calibrated data, memory resource related to calibrated data will be
+ * released in the tasdevice_codec_remove.
+ */
+static int fw_parse_calibration_data(struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_calibration *calibration;
+	unsigned char *data = (unsigned char *)fmw->data;
+	unsigned int i, n;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: Calibrations error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	tas_fmw->nr_calibrations = be16_to_cpup((__be16 *)&data[offset]);
+	offset += 2;
+
+	if (tas_fmw->nr_calibrations != 1) {
+		dev_err(tas_dev->dev,
+			"%s: only support one calibraiton(%d)!\n",
+			__func__, tas_fmw->nr_calibrations);
+		goto out;
+	}
+
+	tas_fmw->calibrations = kcalloc(tas_fmw->nr_calibrations,
+		sizeof(struct tasdevice_calibration), GFP_KERNEL);
+	if (!tas_fmw->calibrations) {
+		offset = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < tas_fmw->nr_calibrations; i++) {
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "Calibrations error\n");
+			offset = -EINVAL;
+			goto out;
+		}
+		calibration = &(tas_fmw->calibrations[i]);
+		offset += 64;
+
+		n = strlen((char *)&data[offset]);
+		/* skip '\0' and 2 unused bytes */
+		n += 3;
+		if (offset + n > fmw->size) {
+			dev_err(tas_dev->dev, "Description err\n");
+			offset = -EINVAL;
+			goto out;
+		}
+		offset += n;
+
+		offset = fw_parse_data(tas_fmw, &(calibration->dev_data), fmw,
+			offset);
+		if (offset < 0)
+			goto out;
+	}
+
+out:
+	return offset;
+}
+
+/* When parsing error occurs, all the memory resource will be released
+ * in the end of tasdevice_rca_ready.
+ */
+static int fw_parse_program_data(struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	unsigned char *buf = (unsigned char *)fmw->data;
+	struct tasdevice_prog *program;
+	int i;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	tas_fmw->nr_programs = be16_to_cpup((__be16 *)&buf[offset]);
+	offset += 2;
+
+	if (tas_fmw->nr_programs == 0) {
+		/*Not error in calibration Data file, return directly*/
+		dev_info(tas_dev->dev, "%s: No Programs data, maybe calbin\n",
+			__func__);
+		goto out;
+	}
+
+	tas_fmw->programs =
+		kcalloc(tas_fmw->nr_programs, sizeof(struct tasdevice_prog),
+			GFP_KERNEL);
+	if (!tas_fmw->programs) {
+		offset = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < tas_fmw->nr_programs; i++) {
+		int n = 0;
+
+		program = &(tas_fmw->programs[i]);
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: mpName error\n", __func__);
+			offset = -EINVAL;
+			goto out;
+		}
+		offset += 64;
+
+		n = strlen((char *)&buf[offset]);
+		/* skip '\0' and 5 unused bytes */
+		n += 6;
+		if (offset + n > fmw->size) {
+			dev_err(tas_dev->dev, "Description err\n");
+			offset = -EINVAL;
+			goto out;
+		}
+
+		offset += n;
+
+		offset = fw_parse_data(tas_fmw, &(program->dev_data), fmw,
+			offset);
+		if (offset < 0)
+			goto out;
+	}
+
+out:
+	return offset;
+}
+
+/* When parsing error occurs, all the memory resource will be released
+ * in the end of tasdevice_rca_ready.
+ */
+static int fw_parse_configuration_data(
+	struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw,
+	const struct firmware *fmw, int offset)
+{
+	unsigned char *data = (unsigned char *)fmw->data;
+	struct tasdevice_config *config;
+	unsigned int i;
+	int n;
+
+	if (offset + 2 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	tas_fmw->nr_configurations = be16_to_cpup((__be16 *)&data[offset]);
+	offset += 2;
+
+	if (tas_fmw->nr_configurations == 0) {
+		dev_err(tas_dev->dev, "%s: Conf is zero\n", __func__);
+		/*Not error for calibration Data file, return directly*/
+		goto out;
+	}
+	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
+			sizeof(struct tasdevice_config), GFP_KERNEL);
+	if (!tas_fmw->configs) {
+		offset = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < tas_fmw->nr_configurations; i++) {
+		config = &(tas_fmw->configs[i]);
+		if (offset + 64 > fmw->size) {
+			dev_err(tas_dev->dev, "%s: File Size err\n", __func__);
+			offset = -EINVAL;
+			goto out;
+		}
+		memcpy(config->name, &data[offset], 64);
+		offset += 64;
+
+		n = strlen((char *)&data[offset]);
+		n += 15;
+		if (offset + n > fmw->size) {
+			dev_err(tas_dev->dev, "Description err\n");
+			offset = -EINVAL;
+			goto out;
+		}
+
+		offset += n;
+
+		offset = fw_parse_data(tas_fmw, &(config->dev_data),
+			fmw, offset);
+		if (offset < 0)
+			goto out;
+	}
+
+out:
+	return offset;
+}
+
+static int fw_parse_header(struct tasdevice_priv *tas_dev,
+	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
+{
+	struct tasdevice_dspfw_hdr *fw_hdr = &(tas_fmw->fw_hdr);
+	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &(fw_hdr->fixed_hdr);
+	const unsigned char magic_number[] = { 0x35, 0x35, 0x35, 0x32 };
+	const unsigned char *buf = (unsigned char *)fmw->data;
+
+	if (offset + 92 > fmw->size) {
+		dev_err(tas_dev->dev, "%s: File Size error\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	if (memcmp(&buf[offset], magic_number, 4)) {
+		dev_err(tas_dev->dev, "%s: Magic num NOT match\n", __func__);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += 4;
+
+	/* Convert data[offset], data[offset + 1], data[offset + 2] and
+	 * data[offset + 3] into host
+	 */
+	fw_fixed_hdr->fwsize = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+	if (fw_fixed_hdr->fwsize != fmw->size) {
+		dev_err(tas_dev->dev, "File size not match, %lu %u",
+			(unsigned long)fmw->size, fw_fixed_hdr->fwsize);
+		offset = -EINVAL;
+		goto out;
+	}
+	offset += 4;
+	fw_fixed_hdr->ppcver = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 8;
+	fw_fixed_hdr->drv_ver = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 72;
+
+ out:
+	return offset;
+}
+
+static bool check_inpage_yram_rg(struct tas_crc *cd,
+	unsigned char reg, unsigned char len)
+{
+	bool in = false;
+
+
+	if (reg <= TAS2781_YRAM5_END_REG &&
+		reg >= TAS2781_YRAM5_START_REG) {
+		if (reg + len > TAS2781_YRAM5_END_REG)
+			cd->len = TAS2781_YRAM5_END_REG - reg + 1;
+		else
+			cd->len = len;
+		cd->offset = reg;
+		in = true;
+	} else if (reg < TAS2781_YRAM5_START_REG) {
+		if (reg + len > TAS2781_YRAM5_START_REG) {
+			cd->offset = TAS2781_YRAM5_START_REG;
+			cd->len = len - TAS2781_YRAM5_START_REG + reg;
+			in = true;
+		}
+	}
+
+	return in;
+}
+
+static bool check_inpage_yram_bk1(struct tas_crc *cd,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	bool in = false;
+
+	if (page == TAS2781_YRAM1_PAGE) {
+		if (reg >= TAS2781_YRAM1_START_REG) {
+			cd->offset = reg;
+			cd->len = len;
+			in = true;
+		} else if (reg + len > TAS2781_YRAM1_START_REG) {
+			cd->offset = TAS2781_YRAM1_START_REG;
+			cd->len = len - TAS2781_YRAM1_START_REG + reg;
+			in = true;
+		}
+	} else if (page == TAS2781_YRAM3_PAGE)
+		in = check_inpage_yram_rg(cd, reg, len);
+
+	return in;
+}
+
+/* Return Code:
+ * true -- the registers are in the inpage yram
+ * false -- the registers are NOT in the inpage yram
+ */
+static bool check_inpage_yram(struct tas_crc *cd, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	bool in = false;
+
+	if (book == TAS2781_YRAM_BOOK1) {
+		in = check_inpage_yram_bk1(cd, page, reg, len);
+		goto end;
+	}
+	if (book == TAS2781_YRAM_BOOK2 && page == TAS2781_YRAM5_PAGE)
+		in = check_inpage_yram_rg(cd, reg, len);
+
+end:
+	return in;
+}
+
+static bool check_inblock_yram_bk(struct tas_crc *cd,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	bool in = false;
+
+	if ((page >= TAS2781_YRAM4_START_PAGE &&
+		page <= TAS2781_YRAM4_END_PAGE) ||
+		(page >= TAS2781_YRAM2_START_PAGE &&
+		page <= TAS2781_YRAM2_END_PAGE)) {
+		if (reg <= TAS2781_YRAM2_END_REG &&
+			reg >= TAS2781_YRAM2_START_REG) {
+			cd->offset = reg;
+			cd->len = len;
+			in = true;
+		} else if (reg < TAS2781_YRAM2_START_REG) {
+			if (reg + len - 1 >= TAS2781_YRAM2_START_REG) {
+				cd->offset = TAS2781_YRAM2_START_REG;
+				cd->len = reg + len - TAS2781_YRAM2_START_REG;
+				in = true;
+			}
+		}
+	}
+
+	return in;
+}
+
+/* Return Code:
+ * true -- the registers are in the inblock yram
+ * false -- the registers are NOT in the inblock yram
+ */
+static bool check_inblock_yram(struct tas_crc *cd, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	bool in = false;
+
+	if (book == TAS2781_YRAM_BOOK1 || book == TAS2781_YRAM_BOOK2)
+		in = check_inblock_yram_bk(cd, page, reg, len);
+
+	return in;
+}
+
+static bool check_yram(struct tas_crc *cd, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char len)
+{
+	bool in;
+
+	in = check_inpage_yram(cd, book, page, reg, len);
+	if (in)
+		goto end;
+	in = check_inblock_yram(cd, book, page, reg, len);
+
+end:
+	return in;
+}
+
+static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
+	enum channel chl, unsigned char book, unsigned char page,
+	unsigned char reg, unsigned char val)
+{
+	struct tas_crc crc_data;
+	unsigned int nData1;
+	int ret = 0;
+	bool in;
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
+	in = check_yram(&crc_data, book, page, reg, 1);
+	if (!in)
+		goto end;
+	ret = tasdevice_dev_read(tasdevice, chl,
+		TASDEVICE_REG(book, page, reg), &nData1);
+	if (ret < 0)
+		goto end;
+
+	if (nData1 != val) {
+		dev_err(tasdevice->dev,
+			"B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
+			book, page, reg, val, nData1);
+		tasdevice->tasdevice[chl].err_code |= ERROR_YRAM_CRCCHK;
+		ret = -EAGAIN;
+		goto end;
+	}
+
+	ret = crc8(tasdevice->crc8_lkp_tbl, &val, 1, 0);
+
+end:
+	return ret;
+}
+
+static int tasdev_multibytes_chksum(struct tasdevice_priv *tasdevice,
+	enum channel chn, unsigned char book, unsigned char page,
+	unsigned char reg, unsigned int len)
+{
+	struct tas_crc crc_data;
+	unsigned char crc_chksum = 0;
+	unsigned char nBuf1[128];
+	int ret = 0;
+	int i;
+	bool in;
+
+	if ((reg + len - 1) > 127) {
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
+	in = check_yram(&crc_data, book, page, reg, len);
+	if (!in)
+		goto end;
+
+	if (len == 1) {
+		dev_err(tasdevice->dev, "firmware error\n");
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = tasdevice_dev_bulk_read(tasdevice, chn,
+		TASDEVICE_REG(book, page, crc_data.offset),
+		nBuf1, crc_data.len);
+	if (ret < 0)
+		goto end;
+
+	for (i = 0; i < crc_data.len; i++) {
+		if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG))
+			&& (page == TASDEVICE_PAGE_ID(
+			TAS2781_SA_COEFF_SWAP_REG))
+			&& ((i + crc_data.offset)
+			>= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG))
+			&& ((i + crc_data.offset)
+			<= (TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)
+			+ 4)))
+			/*DSP swap command, bypass */
+			continue;
+		else
+			crc_chksum += crc8(tasdevice->crc8_lkp_tbl, &nBuf1[i],
+				1, 0);
+	}
+
+	ret = crc_chksum;
+
+end:
+	return ret;
+}
+
+static void set_err_prg_cfg(unsigned int type, struct tasdevice *dev)
+{
+	if ((type == MAIN_ALL_DEVICES) || (type == MAIN_DEVICE_A)
+		|| (type == MAIN_DEVICE_B) || (type == MAIN_DEVICE_C)
+		|| (type == MAIN_DEVICE_D))
+		dev->cur_prog = -1;
+	else
+		dev->cur_conf = -1;
+}
+
+static int tasdev_bytes_chksum(struct tasdevice_priv *tas_dev,
+	struct tasdev_blk *block, int chn, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned int len,
+	unsigned char val, unsigned char *crc_chksum)
+{
+	int ret;
+
+	if (len > 1)
+		ret = tasdev_multibytes_chksum(tas_dev, chn, book, page, reg,
+			len);
+	else
+		ret = do_singlereg_checksum(tas_dev, chn, book, page, reg,
+			val);
+
+	if (ret > 0) {
+		*crc_chksum += (unsigned char)ret;
+		goto end;
+	}
+
+	if (ret != -EAGAIN)
+		goto end;
+
+	block->nr_retry--;
+	if (block->nr_retry > 0)
+		goto end;
+
+	set_err_prg_cfg(block->type, &tas_dev->tasdevice[chn]);
+
+end:
+	return ret;
+}
+
+static int tasdev_multibytes_wr(struct tasdevice_priv *tas_dev,
+	struct tasdev_blk *block, int chn, unsigned char book,
+	unsigned char page, unsigned char reg, unsigned char *data,
+	unsigned int len, unsigned int *nr_cmds,
+	unsigned char *crc_chksum)
+{
+	int ret;
+
+	if (len > 1) {
+		ret = tasdevice_dev_bulk_write(tas_dev, chn,
+			TASDEVICE_REG(book, page, reg), data + 3, len);
+		if (ret < 0)
+			goto end;
+		if (block->is_ychksum_present)
+			ret = tasdev_bytes_chksum(tas_dev, block, chn,
+				book, page, reg, len, 0, crc_chksum);
+	} else {
+		ret = tasdevice_dev_write(tas_dev, chn,
+			TASDEVICE_REG(book, page, reg), data[3]);
+		if (ret < 0)
+			goto end;
+		if (block->is_ychksum_present)
+			ret = tasdev_bytes_chksum(tas_dev, block, chn, book,
+				page, reg, 1, data[3], crc_chksum);
+	}
+
+	if (!block->is_ychksum_present || ret >= 0) {
+		*nr_cmds += 1;
+		if (len >= 2)
+			*nr_cmds += ((len - 2) / 4) + 1;
+	}
+
+end:
+	return ret;
+}
+
+static int tasdev_block_chksum(struct tasdevice_priv *tas_dev,
+	struct tasdev_blk *block, int chn)
+{
+	unsigned int nr_value;
+	int ret;
+
+	ret = tasdevice_dev_read(tas_dev, chn, TASDEVICE_I2CChecksum,
+		&nr_value);
+	if (ret < 0) {
+		dev_err(tas_dev->dev, "%s: Chn %d\n", __func__, chn);
+		set_err_prg_cfg(block->type, &tas_dev->tasdevice[chn]);
+		goto end;
+	}
+
+	if ((nr_value & 0xff) != block->pchksum) {
+		dev_err(tas_dev->dev, "%s: Blk PChkSum Chn %d ", __func__,
+			chn);
+		dev_err(tas_dev->dev, "PChkSum = 0x%x, Reg = 0x%x\n",
+			block->pchksum, (nr_value & 0xff));
+		tas_dev->tasdevice[chn].err_code |= ERROR_PRAM_CRCCHK;
+		ret = -EAGAIN;
+		block->nr_retry--;
+
+		if (block->nr_retry <= 0)
+			set_err_prg_cfg(block->type, &tas_dev->tasdevice[chn]);
+	} else
+		tas_dev->tasdevice[chn].err_code &= ~ERROR_PRAM_CRCCHK;
+
+end:
+	return ret;
+}
+
+static int tasdev_load_blk(struct tasdevice_priv *tas_dev,
+	struct tasdev_blk *block, int chn)
+{
+	unsigned int sleep_time;
+	unsigned int len;
+	unsigned int nr_cmds;
+	unsigned char *data = block->data;
+	unsigned char crc_chksum = 0;
+	unsigned char offset;
+	unsigned char book;
+	unsigned char page;
+	unsigned char val;
+	int ret = 0;
+
+	while (block->nr_retry > 0) {
+		if (block->is_pchksum_present) {
+			ret = tasdevice_dev_write(tas_dev, chn,
+				TASDEVICE_I2CChecksum, 0);
+			if (ret < 0)
+				break;
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
+			/*Single byte write*/
+			if (offset <= 0x7F) {
+				ret = tasdevice_dev_write(tas_dev, chn,
+					TASDEVICE_REG(book, page, offset),
+					val);
+				if (ret < 0)
+					goto end;
+				if (block->is_ychksum_present) {
+					ret = tasdev_bytes_chksum(tas_dev,
+						block, chn, book, page, offset,
+						1, val, &crc_chksum);
+					if (ret < 0)
+						break;
+				}
+				continue;
+			}
+			/*sleep command*/
+			if (offset == 0x81) {
+				/*book -- data[0] page -- data[1]*/
+				sleep_time = ((book << 8) + page)*1000;
+				usleep_range(sleep_time, sleep_time + 50);
+				continue;
+			}
+			/*Multiple bytes write*/
+			if (offset == 0x85) {
+				data += 4;
+				len = (book << 8) + page;
+				book = data[0];
+				page = data[1];
+				offset = data[2];
+				ret = tasdev_multibytes_wr(tas_dev, block, chn,
+					book, page, offset, data, len,
+					&nr_cmds, &crc_chksum);
+				if (ret < 0)
+					break;
+			}
+		}
+		if (ret == -EAGAIN) {
+			if (block->nr_retry > 0)
+				continue;
+		} else if (ret < 0) /*err in current device, skip it*/
+			break;
+
+		if (block->is_pchksum_present) {
+			ret = tasdev_block_chksum(tas_dev, block, chn);
+			if (ret == -EAGAIN) {
+				if (block->nr_retry > 0)
+					continue;
+			} else if (ret < 0) /*err in current device, skip it*/
+				break;
+		}
+
+		if (block->is_ychksum_present) {
+			/* TBD, open it when FW ready */
+			dev_err(tas_dev->dev,
+				"Blk YChkSum: FW = 0x%x, YCRC = 0x%x\n",
+				block->ychksum, crc_chksum);
+
+			tas_dev->tasdevice[chn].err_code &=
+				~ERROR_YRAM_CRCCHK;
+			ret = 0;
+		}
+		/*skip current blk*/
+		break;
+	}
+
+end:
+	return ret;
+}
+
+static int tasdevice_load_block(struct tasdevice_priv *tas_dev,
+	struct tasdev_blk *block)
+{
+	int chnend = 0;
+	int ret = 0;
+	int chn = 0;
+	int rc = 0;
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
+		dev_dbg(tas_dev->dev, "load blk: Other Type = 0x%02x\n",
+			block->type);
+		break;
+	}
+
+	for (; chn < chnend; chn++) {
+		block->nr_retry = 6;
+		if (tas_dev->tasdevice[chn].is_loading == false)
+			continue;
+		ret = tasdev_load_blk(tas_dev, block, chn);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "dev %d, Blk (%d) load error\n",
+				chn, block->type);
+		rc |= ret;
+	}
+
+	return rc;
+}
+
+static int tasdevice_load_data(struct tasdevice_priv *tas_dev,
+	struct tasdevice_data *dev_data)
+{
+	struct tasdev_blk *block;
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < dev_data->nr_blk; i++) {
+		block = &(dev_data->dev_blks[i]);
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
+	struct tasdev_blk *block;
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < dev_data->nr_blk; i++) {
+		block = &(dev_data->dev_blks[i]);
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
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
+	struct tasdevice *tasdev = &(tas_dev->tasdevice[i]);
+	const struct firmware *fw_entry;
+	struct tasdevice_fw *tas_fmw;
+	struct firmware fmw;
+	int offset = 0;
+	int ret;
+
+	ret = request_firmware(&fw_entry, file_name, tas_dev->dev);
+	if (ret) {
+		dev_info(tas_dev->dev, "%s: Request firmware %s failed\n",
+			__func__, file_name);
+		goto out;
+	}
+
+	if (!fw_entry->size) {
+		dev_err(tas_dev->dev, "%s: file read error: size = %lu\n",
+			__func__, (unsigned long)fw_entry->size);
+		goto out;
+	}
+	fmw.size = fw_entry->size;
+	fmw.data = fw_entry->data;
+
+	tas_fmw = tasdev->cali_data_fmw = kzalloc(sizeof(struct tasdevice_fw),
+		GFP_KERNEL);
+	if (!tasdev->cali_data_fmw) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	tas_fmw->dev = tas_dev->dev;
+	offset = fw_parse_header(tas_dev, tas_fmw, &fmw, offset);
+	if (offset == -EINVAL) {
+		dev_err(tas_dev->dev, "%s: fw_parse_header EXIT!\n", __func__);
+		ret = offset;
+		goto out;
+	}
+	offset = fw_parse_variable_hdr_cal(tas_dev, tas_fmw, &fmw, offset);
+	if (offset == -EINVAL) {
+		dev_err(tas_dev->dev,
+			"%s: fw_parse_variable_header_cal EXIT!\n", __func__);
+		ret = offset;
+		goto out;
+	}
+	offset = fw_parse_program_data(tas_dev, tas_fmw, &fmw, offset);
+	if (offset < 0) {
+		dev_err(tas_dev->dev, "fw_parse_program_data EXIT!\n");
+		ret = offset;
+		goto out;
+	}
+	offset = fw_parse_configuration_data(tas_dev, tas_fmw, &fmw, offset);
+	if (offset < 0) {
+		dev_err(tas_dev->dev, "fw_parse_configuration_data EXIT!\n");
+		ret = offset;
+		goto out;
+	}
+	offset = fw_parse_calibration_data(tas_dev, tas_fmw, &fmw, offset);
+	if (offset < 0) {
+		dev_err(tas_dev->dev, "fw_parse_calibration_data EXIT!\n");
+		ret = offset;
+		goto out;
+	}
+	tasdev->is_calibrated_data_loaded = true;
+
+out:
+	if (fw_entry) {
+		release_firmware(fw_entry);
+		fw_entry = NULL;
+	}
+	return ret;
+}
+
+static int dspfw_default_callback(struct tasdevice_priv *tas_dev,
+	unsigned int drv_ver, unsigned int ppcver)
+{
+	int offset = 0;
+
+	if (drv_ver == 0x100) {
+		if (ppcver >= PPC3_VERSION) {
+			tas_dev->fw_parse_variable_header =
+				fw_parse_variable_header_kernel;
+			tas_dev->fw_parse_program_data =
+				fw_parse_program_data_kernel;
+			tas_dev->fw_parse_configuration_data =
+				fw_parse_configuration_data_kernel;
+			tas_dev->tasdevice_load_block =
+				tasdevice_load_block_kernel;
+		} else {
+			switch (ppcver) {
+			case 0x00:
+				tas_dev->fw_parse_variable_header =
+					fw_parse_variable_header_git;
+				tas_dev->fw_parse_program_data =
+					fw_parse_program_data;
+				tas_dev->fw_parse_configuration_data =
+					fw_parse_configuration_data;
+				tas_dev->tasdevice_load_block =
+					tasdevice_load_block;
+				break;
+			default:
+				dev_err(tas_dev->dev,
+					"%s: PPCVer must be 0x0 or 0x%02x",
+					__func__, PPC3_VERSION);
+				dev_err(tas_dev->dev, " Current:0x%02x\n",
+					ppcver);
+				offset = -EINVAL;
+				break;
+			}
+		}
+	} else {
+		dev_err(tas_dev->dev,
+			"DrvVer must be 0x0, 0x230 or above 0x230 ");
+		dev_err(tas_dev->dev, "current is 0x%02x\n", drv_ver);
+		offset = -EINVAL;
+	}
+
+	return offset;
+}
+
+int tasdevice_dspfw_ready(const struct firmware *fmw, void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr;
+	struct tasdevice_fw *tas_fmw;
+	int offset = 0;
+	int ret = 0;
+
+	if (!fmw || !fmw->data) {
+		dev_err(tas_dev->dev, "%s: Failed to read firmware %s\n",
+			__func__, tas_dev->coef_binaryname);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tas_dev->fmw = kzalloc(sizeof(struct tasdevice_fw), GFP_KERNEL);
+	if (!tas_dev->fmw) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	tas_fmw = tas_dev->fmw;
+	tas_fmw->dev = tas_dev->dev;
+	offset = fw_parse_header(tas_dev, tas_fmw, fmw, offset);
+
+	if (offset == -EINVAL)
+		goto out;
+	fw_fixed_hdr = &(tas_fmw->fw_hdr.fixed_hdr);
+	/* Support different versions of firmware */
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
+		offset = dspfw_default_callback(tas_dev, fw_fixed_hdr->drv_ver,
+			fw_fixed_hdr->ppcver);
+		break;
+	}
+
+	offset = tas_dev->fw_parse_variable_header(tas_dev, fmw, offset);
+	if (offset < 0) {
+		ret = offset;
+		goto out;
+	}
+	offset = tas_dev->fw_parse_program_data(tas_dev, tas_fmw, fmw,
+		offset);
+	if (offset < 0) {
+		ret = offset;
+		goto out;
+	}
+	offset = tas_dev->fw_parse_configuration_data(tas_dev,
+		tas_fmw, fmw, offset);
+	if (offset < 0)
+		ret = offset;
+
+out:
+	return ret;
+}
+
+void tasdevice_calbin_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice *tasdev;
+	int i;
+
+	if (!tas_dev)
+		return;
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		tasdev = &(tas_dev->tasdevice[i]);
+		if (!tasdev->cali_data_fmw)
+			continue;
+		tas2781_clear_calfirmware(tasdev->cali_data_fmw);
+		tasdev->cali_data_fmw = NULL;
+	}
+}
+
+static void tasdev_dsp_prog_blk_remove(struct tasdevice_prog *prog)
+{
+	struct tasdevice_data *im;
+	struct tasdev_blk *blk;
+	unsigned int nr_blk;
+
+	if (!prog)
+		return;
+
+	im = &(prog->dev_data);
+
+	if (!im->dev_blks)
+		return;
+
+	for (nr_blk = 0; nr_blk < im->nr_blk; nr_blk++) {
+		blk = &(im->dev_blks[nr_blk]);
+		kfree(blk->data);
+	}
+	kfree(im->dev_blks);
+}
+
+static void tasdev_dsp_prog_remove(struct tasdevice_prog *prog,
+	unsigned short nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		tasdev_dsp_prog_blk_remove(&prog[i]);
+	kfree(prog);
+}
+
+static void tasdev_dsp_cfg_blk_remove(struct tasdevice_config *cfg)
+{
+	struct tasdevice_data *im;
+	struct tasdev_blk *blk;
+	unsigned int nr_blk;
+
+	if (cfg) {
+		im = &(cfg->dev_data);
+
+		if (!im->dev_blks)
+			return;
+
+		for (nr_blk = 0; nr_blk < im->nr_blk; nr_blk++) {
+			blk = &(im->dev_blks[nr_blk]);
+			kfree(blk->data);
+		}
+		kfree(im->dev_blks);
+	}
+}
+
+static void tasdev_dsp_cfg_remove(struct tasdevice_config *config,
+	unsigned short nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		tasdev_dsp_cfg_blk_remove(&config[i]);
+	kfree(config);
+}
+
+void tasdevice_dsp_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+
+	if (!tas_dev->fmw)
+		return;
+
+	if (tas_fmw->programs)
+		tasdev_dsp_prog_remove(tas_fmw->programs,
+			tas_fmw->nr_programs);
+	if (tas_fmw->configs)
+		tasdev_dsp_cfg_remove(tas_fmw->configs,
+			tas_fmw->nr_configurations);
+	kfree(tas_fmw);
+	tas_dev->fmw = NULL;
+}
+
+int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
+	int cfg_no, int rca_conf_no)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice_rca *rca = &(tas_dev->rcabin);
+	struct tasdevice_config_info **cfg_info = rca->cfg_info;
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	struct tasdevice_prog *program;
+	struct tasdevice_config *conf;
+	int prog_status = 0;
+	int status, i;
+
+	if (!tas_fmw) {
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
+			__func__, prm_no, tas_fmw->nr_programs);
+		goto out;
+	}
+
+	if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
+		!cfg_info) {
+		dev_err(tas_dev->dev,
+			"conf_no:%d should be in range from 0 to %u\n",
+			rca_conf_no, rca->ncfgs-1);
+		goto out;
+	}
+
+	conf = &(tas_fmw->configs[cfg_no]);
+	for (i = 0, prog_status = 0; i < tas_dev->ndev; i++) {
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
+						*cal = cal_fmw->calibrations;
+
+					if (cal)
+						tasdevice_load_calibrated_data(
+							tas_dev,
+							&(cal->dev_data));
+				}
+				tas_dev->tasdevice[i].cur_prog = prm_no;
+			}
+		}
+	}
+
+	for (i = 0, status = 0; i < tas_dev->ndev; i++) {
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
+
+out:
+	return prog_status;
+}
diff --git a/sound/soc/codecs/tas2781-dsp.h b/sound/soc/codecs/tas2781-dsp.h
new file mode 100644
index 000000000000..82603742a1b0
--- /dev/null
+++ b/sound/soc/codecs/tas2781-dsp.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// TAS2781 chips.
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
+	int nr_retry;
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
+
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
index 000000000000..3ee23fd0f1fb
--- /dev/null
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -0,0 +1,1614 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
+
+#include <linux/crc8.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
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
+static const struct i2c_device_id tasdevice_id[] = {
+	{ "tas2781", TAS2781 },
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
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
+	unsigned char subblk_typ = data[1];
+	bool is_err = false;
+	int blktyp = dev_idx & 0xC0;
+	int idx = dev_idx & 0x3F;
+	int subblk_offset;
+	int chn, chnend;
+	int rc;
+
+	if (idx) {
+		chn = idx - 1;
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
+		if (!tas_dev->set_global_mode &&
+			tas_dev->tasdevice[chn].is_loading == false)
+			continue;
+
+		is_err = false;
+		subblk_offset = 2;
+		switch (subblk_typ) {
+		case TASDEVICE_CMD_SING_W: {
+			int i;
+			unsigned short len = be16_to_cpup((__be16 *)&data[2]);
+
+			subblk_offset += 2;
+			if (subblk_offset + 4 * len > sublocksize) {
+				dev_err(tas_dev->dev,
+					"process_block: Out of boundary\n");
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
+				subblk_offset += 4;
+			}
+		}
+			break;
+		case TASDEVICE_CMD_BURST: {
+			unsigned short len = be16_to_cpup((__be16 *)&data[2]);
+
+			subblk_offset += 2;
+			if (subblk_offset + 4 + len > sublocksize) {
+				dev_err(tas_dev->dev,
+					"%s: BST Out of boundary\n",
+					__func__);
+				is_err = true;
+				break;
+			}
+			if (len % 4) {
+				dev_err(tas_dev->dev,
+					"%s:Bst-len(%u)not div by 4\n",
+					__func__, len);
+				break;
+			}
+
+			rc = tasdevice_dev_bulk_write(tas_dev, chn,
+				TASDEVICE_REG(data[subblk_offset],
+				data[subblk_offset + 1],
+				data[subblk_offset + 2]),
+				&(data[subblk_offset + 4]), len);
+			if (rc < 0) {
+				is_err = true;
+				dev_err(tas_dev->dev,
+					"%s: bulk_write error = %d\n",
+					__func__, rc);
+			}
+			subblk_offset += (len + 4);
+		}
+			break;
+		case TASDEVICE_CMD_DELAY: {
+			unsigned int sleep_time = 0;
+
+			if (subblk_offset + 2 > sublocksize) {
+				dev_err(tas_dev->dev,
+					"%s: delay Out of boundary\n",
+					__func__);
+				is_err = true;
+				break;
+			}
+			sleep_time = be16_to_cpup((__be16 *)&data[2]) * 1000;
+			usleep_range(sleep_time, sleep_time + 50);
+			subblk_offset += 2;
+		}
+			break;
+		case TASDEVICE_CMD_FIELD_W:
+			if (subblk_offset + 6 > sublocksize) {
+				dev_err(tas_dev->dev,
+					"%s: bit write Out of boundary\n",
+					__func__);
+				is_err = true;
+				break;
+			}
+			rc = tasdevice_dev_update_bits(tas_dev, chn,
+				TASDEVICE_REG(data[subblk_offset + 2],
+				data[subblk_offset + 3],
+				data[subblk_offset + 4]),
+				data[subblk_offset + 1],
+				data[subblk_offset + 5]);
+			if (rc < 0) {
+				is_err = true;
+				dev_err(tas_dev->dev,
+					"%s: update_bits error = %d\n",
+					__func__, rc);
+			}
+			subblk_offset += 6;
+			break;
+		default:
+			break;
+		}
+		if (is_err == true && blktyp != 0) {
+			if (blktyp == 0x80) {
+				tas_dev->tasdevice[chn].cur_prog = -1;
+				tas_dev->tasdevice[chn].cur_conf = -1;
+			} else
+				tas_dev->tasdevice[chn].cur_conf = -1;
+		}
+	}
+
+	return subblk_offset;
+}
+
+static void tasdevice_select_cfg_blk(void *pContext, int conf_no,
+	unsigned char block_type)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) pContext;
+	struct tasdevice_rca *rca = &(tas_dev->rcabin);
+	struct tasdevice_config_info **cfg_info = rca->cfg_info;
+	struct tasdev_blk_data **blk_data;
+	int j, k, chn, chnend;
+
+	if (conf_no >= rca->ncfgs || conf_no < 0 || !cfg_info) {
+		dev_err(tas_dev->dev, "conf_no should be not more than %u\n",
+			rca->ncfgs);
+		return;
+	}
+	blk_data =  cfg_info[conf_no]->blk_data;
+
+	for (j = 0; j < (int)cfg_info[conf_no]->real_nblocks; j++) {
+		unsigned int length = 0, rc = 0;
+
+		if (block_type > 5 || block_type < 2) {
+			dev_err(tas_dev->dev,
+				"block_type should be in range from 2 to 5\n");
+			break;
+		}
+		if (block_type != blk_data[j]->block_type)
+			continue;
+
+		for (k = 0; k < (int)blk_data[j]->n_subblks; k++) {
+			if (blk_data[j]->dev_idx) {
+				chn = blk_data[j]->dev_idx - 1;
+				chnend = blk_data[j]->dev_idx;
+			} else {
+				chn = 0;
+				chnend = tas_dev->ndev;
+			}
+			for (; chn < chnend; chn++)
+				tas_dev->tasdevice[chn].is_loading = true;
+
+			rc = tasdevice_process_block(tas_dev,
+				blk_data[j]->regdata + length,
+				blk_data[j]->dev_idx,
+				blk_data[j]->block_size - length);
+			length += rc;
+			if (blk_data[j]->block_size < length) {
+				dev_err(tas_dev->dev,
+					"%s: %u %u out of boundary\n",
+					__func__, length,
+					blk_data[j]->block_size);
+				break;
+			}
+		}
+		if (length != blk_data[j]->block_size)
+			dev_err(tas_dev->dev, "%s: %u %u size is not same\n",
+				__func__, length, blk_data[j]->block_size);
+	}
+}
+
+static struct tasdevice_config_info *tasdevice_add_config(
+	void *context, unsigned char *config_data,
+	unsigned int config_size, int *status)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
+	struct tasdevice_config_info *cfg_info;
+	struct tasdev_blk_data **bk_da;
+	unsigned int config_offset = 0;
+	unsigned int i;
+
+	/* In most projects are many audio cases, such as music, handfree,
+	 * receiver, games, audio-to-haptics, PMIC record, bypass mode,
+	 * portrait, landscape, etc. Even in multiple audios, one or
+	 * two of the chips will work for the special case, such as
+	 * ultrasonic application. In order to support these variable-numbers
+	 * of audio cases, flexible configs have been introduced in the
+	 * dsp firmware.
+	 */
+	cfg_info = kzalloc(sizeof(struct tasdevice_config_info), GFP_KERNEL);
+	if (!cfg_info) {
+		*status = -ENOMEM;
+		goto out;
+	}
+
+	if (tas_dev->rcabin.fw_hdr.binary_version_num >= 0x105) {
+		if (config_offset + 64 > (int)config_size) {
+			*status = -EINVAL;
+			dev_err(tas_dev->dev, "add config: Out of boundary\n");
+			goto out;
+		}
+		config_offset += 64;
+	}
+
+	if (config_offset + 4 > (int)config_size) {
+		*status = -EINVAL;
+		dev_err(tas_dev->dev, "add config: Out of boundary\n");
+		goto out;
+	}
+
+	/* convert data[offset], data[offset + 1], data[offset + 2] and
+	 * data[offset + 3] into host
+	 */
+	cfg_info->nblocks =
+		be32_to_cpup((__be32 *)&config_data[config_offset]);
+	config_offset += 4;
+
+	/* Several kinds of dsp/algorithm firmwares can run on tas2781,
+	 * the number and size of blk are not fixed and different among
+	 * these firmwares.
+	 */
+	bk_da = cfg_info->blk_data = kcalloc(cfg_info->nblocks,
+		sizeof(struct tasdev_blk_data *), GFP_KERNEL);
+	if (!bk_da) {
+		*status = -ENOMEM;
+		goto out;
+	}
+	cfg_info->real_nblocks = 0;
+	for (i = 0; i < cfg_info->nblocks; i++) {
+		if (config_offset + 12 > config_size) {
+			*status = -EINVAL;
+			dev_err(tas_dev->dev,
+				"%s: Out of boundary: i = %d nblocks = %u!\n",
+				__func__, i, cfg_info->nblocks);
+			break;
+		}
+		bk_da[i] = kzalloc(sizeof(struct tasdev_blk_data), GFP_KERNEL);
+		if (!bk_da[i]) {
+			*status = -ENOMEM;
+			break;
+		}
+
+		bk_da[i]->dev_idx = config_data[config_offset];
+		config_offset++;
+
+		bk_da[i]->block_type = config_data[config_offset];
+		config_offset++;
+
+		if (bk_da[i]->block_type == TASDEVICE_BIN_BLK_PRE_POWER_UP) {
+			if (bk_da[i]->dev_idx == 0)
+				cfg_info->active_dev = 1;
+			else
+				cfg_info->active_dev = 1 <<
+					(bk_da[i]->dev_idx - 1);
+
+		}
+		bk_da[i]->yram_checksum =
+			be16_to_cpup((__be16 *)&config_data[config_offset]);
+		config_offset += 2;
+		bk_da[i]->block_size =
+			be32_to_cpup((__be32 *)&config_data[config_offset]);
+		config_offset += 4;
+
+		bk_da[i]->n_subblks =
+			be32_to_cpup((__be32 *)&config_data[config_offset]);
+
+		config_offset += 4;
+
+		if (config_offset + bk_da[i]->block_size
+			> config_size) {
+			*status = -EINVAL;
+			dev_err(tas_dev->dev,
+				"%s: Out of boundary: i = %d blks = %u!\n",
+				__func__, i, cfg_info->nblocks);
+			break;
+		}
+		/* instead of kzalloc+memcpy */
+		bk_da[i]->regdata = kmemdup(&config_data[config_offset],
+			bk_da[i]->block_size, GFP_KERNEL);
+		if (!bk_da[i]->regdata) {
+			*status = -ENOMEM;
+			goto out;
+		}
+
+		config_offset += bk_da[i]->block_size;
+		cfg_info->real_nblocks += 1;
+	}
+
+out:
+	return cfg_info;
+}
+
+static int tas2781_clamp(int val, int max, unsigned int invert)
+{
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+	return val;
+}
+
+/**
+ * tas2781_digital_getvol - get the volum control
+ * @kcontrol: control pointer
+ * @ucontrol: User data
+ * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
+ * depends on internal regmap mechanism.
+ * tas2781 contains book and page two-level register map, especially
+ * book switching will set the register BXXP00R7F, after switching to the
+ * correct book, then leverage the mechanism for paging to access the
+ * register.
+ */
+static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int ret, val;
+
+	/* Read the primary device as the whole */
+	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_dev->dev, "%s, get digital vol error\n", __func__);
+		goto out;
+	}
+
+	val = tas2781_clamp(val, max, invert);
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+}
+
+static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int err_cnt = 0;
+	int ret = 1;
+	int val, i;
+
+	val = tas2781_clamp(ucontrol->value.integer.value[0], max, invert);
+
+	if (!tas_dev->set_global_mode) {
+		ret = tasdevice_dev_write(tas_dev, tas_dev->ndev,
+			mc->reg, (unsigned int)val);
+		if (ret)
+			dev_err(tas_dev->dev, "%s, error in global mode\n",
+				__func__);
+	}
+
+	if (!tas_dev->set_global_mode || ret == 1) {
+		for (i = 0; i < tas_dev->ndev; i++) {
+			ret = tasdevice_dev_write(tas_dev, i, mc->reg,
+				(unsigned int)val);
+			if (!ret)
+				continue;
+			err_cnt++;
+			dev_err(tas_dev->dev,
+				"set digital vol err in dev %d\n", i);
+		}
+	}
+
+	/* All the devices set error, return 0 */
+	return (err_cnt == tas_dev->ndev) ? 0 : 1;
+}
+
+static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int invert = mc->invert;
+	unsigned char mask = 0;
+	int max = mc->max;
+	int ret = 0;
+	int val;
+
+	/* Read the primary device */
+	ret = tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_dev->dev, "%s, get AMP vol error\n", __func__);
+		goto out;
+	}
+
+	mask = (1 << fls(max)) - 1;
+	mask <<= mc->shift;
+	val = (val & mask) >> mc->shift;
+	val = tas2781_clamp(val, max, invert);
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+}
+
+static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int invert = mc->invert;
+	unsigned char mask;
+	int max = mc->max;
+	int err_cnt = 0;
+	int val, i, ret;
+
+	mask = (1 << fls(max)) - 1;
+	mask <<= mc->shift;
+	val = tas2781_clamp(ucontrol->value.integer.value[0], max, invert);
+	for (i = 0; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			mc->reg, mask, (unsigned int)(val << mc->shift));
+		if (!ret)
+			continue;
+		err_cnt++;
+		dev_err(tas_dev->dev, "set AMP vol error in dev %d\n", i);
+	}
+
+	/* All the devices set error, return 0 */
+	return (err_cnt == tas_dev->ndev) ? 0 : 1;
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
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+
+	tas_dev->rcabin.profile_cfg_id = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	struct tasdevice_fw *tas_fw = tas_dev->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
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
+	struct snd_soc_component *codec =
+		snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	struct tasdevice_fw *tas_fw = tas_dev->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (int)tas_fw->nr_configurations - 1;
+
+	return 0;
+}
+
+static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 1;
+	uinfo->value.integer.max = max(0, tas_dev->rcabin.ncfgs);
+
+	return 0;
+}
+
+static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = tas_dev->rcabin.profile_cfg_id;
+
+	return 0;
+}
+
+static int tasdevice_create_controls(struct tasdevice_priv *tas_dev)
+{
+	struct snd_kcontrol_new *prof_ctrls;
+	int nr_controls = 1;
+	int mix_index = 0;
+	int ret;
+	char *name;
+
+	prof_ctrls = devm_kcalloc(tas_dev->dev, nr_controls,
+		sizeof(prof_ctrls[0]), GFP_KERNEL);
+	if (!prof_ctrls) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Create a mixer item for selecting the active profile */
+	name = devm_kzalloc(tas_dev->dev, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+		GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "TASDEVICE Profile id");
+	prof_ctrls[mix_index].name = name;
+	prof_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	prof_ctrls[mix_index].info = tasdevice_info_profile;
+	prof_ctrls[mix_index].get = tasdevice_get_profile_id;
+	prof_ctrls[mix_index].put = tasdevice_set_profile_id;
+	mix_index++;
+
+	ret = snd_soc_add_component_controls(tas_dev->codec,
+		prof_ctrls, nr_controls < mix_index ? nr_controls : mix_index);
+
+out:
+	return ret;
+}
+
+static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tasdev = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = tasdev->cur_prog;
+
+	return 0;
+}
+
+static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tasdev = snd_soc_component_get_drvdata(codec);
+	unsigned int nr_program = ucontrol->value.integer.value[0];
+
+	tasdev->cur_prog = nr_program;
+
+	return 1;
+}
+
+static int tasdevice_configuration_get(
+	struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tasdev = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = tasdev->cur_conf;
+
+	return 0;
+}
+
+static int tasdevice_configuration_put(
+	struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	unsigned int nr_configuration = ucontrol->value.integer.value[0];
+
+	tas_dev->cur_conf = nr_configuration;
+
+	return 1;
+}
+
+static int tasdevice_dsp_create_control(
+	struct tasdevice_priv *tas_dev)
+{
+	struct snd_kcontrol_new *dsp_ctrls;
+	char *prog_name, *conf_name;
+	int nr_controls = 2;
+	int mix_index = 0;
+	int ret;
+
+	/* Alloc kcontrol via devm_lzalloc, which don't manually
+	 * free the kcontrol
+	 */
+	dsp_ctrls = devm_kcalloc(tas_dev->dev, nr_controls,
+		sizeof(dsp_ctrls[0]), GFP_KERNEL);
+	if (!dsp_ctrls) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Create a mixer item for selecting the active profile */
+	prog_name = devm_kzalloc(tas_dev->dev,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+	conf_name = devm_kzalloc(tas_dev->dev, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+		GFP_KERNEL);
+	if (!prog_name || !conf_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	scnprintf(prog_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Program");
+	dsp_ctrls[mix_index].name = prog_name;
+	dsp_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	dsp_ctrls[mix_index].info = tasdevice_info_programs;
+	dsp_ctrls[mix_index].get = tasdevice_program_get;
+	dsp_ctrls[mix_index].put = tasdevice_program_put;
+	mix_index++;
+
+	scnprintf(conf_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Configuration");
+	dsp_ctrls[mix_index].name = conf_name;
+	dsp_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	dsp_ctrls[mix_index].info = tasdevice_info_configurations;
+	dsp_ctrls[mix_index].get = tasdevice_configuration_get;
+	dsp_ctrls[mix_index].put = tasdevice_configuration_put;
+	mix_index++;
+
+	ret = snd_soc_add_component_controls(tas_dev->codec, dsp_ctrls,
+		nr_controls < mix_index ? nr_controls : mix_index);
+
+out:
+	return ret;
+}
+
+static void tasdevice_config_info_remove(void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct tasdevice_rca *rca = &(tas_dev->rcabin);
+	struct tasdevice_config_info **ci = rca->cfg_info;
+	int i, j;
+
+	if (!ci)
+		return;
+	for (i = 0; i < rca->ncfgs; i++) {
+		if (!ci[i])
+			continue;
+		if (ci[i]->blk_data) {
+			for (j = 0; j < (int)ci[i]->real_nblocks; j++) {
+				if (!ci[i]->blk_data[j])
+					continue;
+				kfree(ci[i]->blk_data[j]->regdata);
+				kfree(ci[i]->blk_data[j]);
+			}
+			kfree(ci[i]->blk_data);
+		}
+		kfree(ci[i]);
+	}
+	kfree(ci);
+}
+
+static void tasdevice_rca_ready(const struct firmware *fmw,
+	void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *)context;
+	struct tasdevice_config_info **cfg_info = NULL;
+	struct tasdevice_rca_hdr *fw_hdr;
+	struct tasdevice_rca *rca;
+	const struct firmware *fw_entry;
+	unsigned int total_config_sz = 0;
+	unsigned char *buf;
+	int offset = 0;
+	int ret = 0;
+	int i;
+
+	mutex_lock(&tas_dev->codec_lock);
+	rca = &(tas_dev->rcabin);
+	fw_hdr = &(rca->fw_hdr);
+	if (!fmw || !fmw->data) {
+		dev_err(tas_dev->dev, "Failed to read %s\n",
+			tas_dev->rca_binaryname);
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		ret = -EINVAL;
+		goto out;
+	}
+	buf = (unsigned char *)fmw->data;
+
+	fw_hdr->img_sz = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+	if (fw_hdr->img_sz != fmw->size) {
+		dev_err(tas_dev->dev,
+			"File size not match, %d %u", (int)fmw->size,
+			fw_hdr->img_sz);
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fw_hdr->checksum = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+	fw_hdr->binary_version_num = be32_to_cpup((__be32 *)&buf[offset]);
+	if (fw_hdr->binary_version_num < 0x103) {
+		dev_err(tas_dev->dev, "File version 0x%04x is too low",
+			fw_hdr->binary_version_num);
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		ret = -EINVAL;
+		goto out;
+	}
+	offset += 4;
+	fw_hdr->drv_fw_version = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 8;
+	fw_hdr->plat_type = buf[offset];
+	offset += 1;
+	fw_hdr->dev_family = buf[offset];
+	offset += 1;
+	fw_hdr->reserve = buf[offset];
+	offset += 1;
+	fw_hdr->ndev = buf[offset];
+	offset += 1;
+	if (fw_hdr->ndev != tas_dev->ndev) {
+		dev_err(tas_dev->dev,
+			"ndev(%u) in rcabin mismatch ndev(%u) in DTS\n",
+			fw_hdr->ndev, tas_dev->ndev);
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		ret = -EINVAL;
+		goto out;
+	}
+	if (offset + TASDEVICE_DEVICE_SUM > fw_hdr->img_sz) {
+		dev_err(tas_dev->dev, "rca_ready: Out of boundary!\n");
+		ret = -EINVAL;
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+
+	for (i = 0; i < TASDEVICE_DEVICE_SUM; i++, offset++)
+		fw_hdr->devs[i] = buf[offset];
+
+	fw_hdr->nconfig = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+
+	for (i = 0; i < TASDEVICE_CONFIG_SUM; i++) {
+		fw_hdr->config_size[i] = be32_to_cpup((__be32 *)&buf[offset]);
+		offset += 4;
+		total_config_sz += fw_hdr->config_size[i];
+	}
+
+	if (fw_hdr->img_sz - total_config_sz != (unsigned int)offset) {
+		dev_err(tas_dev->dev, "Bin file error!\n");
+		ret = -EINVAL;
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+
+	cfg_info = kcalloc(fw_hdr->nconfig, sizeof(*cfg_info), GFP_KERNEL);
+	if (!cfg_info) {
+		ret = -ENOMEM;
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+	rca->cfg_info = cfg_info;
+	rca->ncfgs = 0;
+	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
+		rca->ncfgs += 1;
+		cfg_info[i] = tasdevice_add_config(context, &buf[offset],
+			fw_hdr->config_size[i], &ret);
+		if (ret) {
+			tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+			goto out;
+		}
+		offset += (int)fw_hdr->config_size[i];
+	}
+
+	tasdevice_create_controls(tas_dev);
+
+	tasdevice_dsp_remove(tas_dev);
+	tasdevice_calbin_remove(tas_dev);
+	tas_dev->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_dev->coef_binaryname, 64, "%s_coef.bin",
+		tas_dev->dev_name);
+	ret = request_firmware(&fw_entry, tas_dev->coef_binaryname,
+		tas_dev->dev);
+	if (ret) {
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		dev_err(tas_dev->dev, "%s: load %s error\n", __func__,
+			tas_dev->coef_binaryname);
+		goto out;
+	}
+
+	ret = tasdevice_dspfw_ready(fw_entry, tas_dev);
+	release_firmware(fw_entry);
+	fw_entry = NULL;
+	if (ret) {
+		dev_err(tas_dev->dev, "dspfw load %s error\n",
+			tas_dev->coef_binaryname);
+		tas_dev->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+	tasdevice_dsp_create_control(tas_dev);
+
+	tas_dev->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	for (i = 0; i < tas_dev->ndev; i++) {
+		scnprintf(tas_dev->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
+			tas_dev->dev_name, tas_dev->tasdevice[i].dev_addr);
+		ret = tas2781_load_calibration(tas_dev,
+			tas_dev->cal_binaryname[i], i);
+		if (ret != 0)
+			dev_err(tas_dev->dev,
+				"%s: load %s error, default will effect\n",
+				__func__, tas_dev->cal_binaryname[i]);
+	}
+
+out:
+	if (tas_dev->fw_state == TASDEVICE_DSP_FW_FAIL) {
+		/*If DSP FW fail, kcontrol won't be created */
+		tasdevice_config_info_remove(tas_dev);
+		tasdevice_dsp_remove(tas_dev);
+	}
+	mutex_unlock(&tas_dev->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+}
+
+static void tasdevice_tuning_switch(
+	struct tasdevice_priv *tas_dev, int state)
+{
+	struct tasdevice_fw *tas_fmw = tas_dev->fmw;
+	int profile_cfg_id = 0;
+
+	if (tas_dev->fw_state == TASDEVICE_DSP_FW_FAIL) {
+		dev_err(tas_dev->dev, "DSP bin file not loaded\n");
+		return;
+	}
+
+	if (state == 0) {
+		if (tas_dev->cur_prog >= tas_fmw->nr_programs)
+			/*bypass all in rca is profile id 0*/
+			profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
+		else {
+			/*dsp mode or tuning mode*/
+			profile_cfg_id = tas_dev->rcabin.profile_cfg_id;
+			tasdevice_select_tuningprm_cfg(tas_dev,
+				tas_dev->cur_prog, tas_dev->cur_conf,
+				profile_cfg_id);
+			if (tas_dev->set_global_mode)
+				tas_dev->set_global_mode(tas_dev);
+		}
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
+
+	return ret;
+}
+
+static int tasdevice_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct tasdevice_priv *tas_dev = snd_soc_dai_get_drvdata(dai);
+	unsigned int slot_width;
+	unsigned int fsrate;
+	int bclk_rate;
+	int rc = 0;
+
+	fsrate = params_rate(params);
+	switch (fsrate) {
+	case 48000:
+	case 44100:
+		break;
+	default:
+		dev_err(tas_dev->dev, "%s: incorrect sample rate = %u\n",
+			__func__, fsrate);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	slot_width = params_width(params);
+	switch (slot_width) {
+	case 16:
+	case 20:
+	case 24:
+	case 32:
+		break;
+	default:
+		dev_err(tas_dev->dev, "%s: incorrect slot width = %u\n",
+			__func__, slot_width);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	bclk_rate = snd_soc_params_to_bclk(params);
+	if (bclk_rate < 0) {
+		dev_err(tas_dev->dev, "%s: incorrect bclk rate = %d\n",
+			__func__, bclk_rate);
+		rc = bclk_rate;
+		goto out;
+	}
+
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
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates	 = TASDEVICE_RATES,
+			.formats	= TASDEVICE_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 4,
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
+	int ret, i;
+
+	if (tas_dev->reset) {
+		gpiod_set_value_cansleep(tas_dev->reset, 0);
+		usleep_range(500, 1000);
+		gpiod_set_value_cansleep(tas_dev->reset, 1);
+	} else {
+		for (i = 0; i < tas_dev->ndev; i++) {
+			ret = tasdevice_dev_write(tas_dev, i,
+				TAS2871_REG_SWRESET,
+				TAS2871_REG_SWRESET_RESET);
+			if (ret < 0)
+				dev_err(tas_dev->dev,
+					"dev %d swreset fail, %d\n",
+					i, ret);
+		}
+	}
+	usleep_range(1000, 1050);
+}
+
+static int tasdevice_codec_probe(
+	struct snd_soc_component *codec)
+{
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	/* Codec Lock Hold to ensure that codec_probe and firmware parsing and
+	 * loading do not simultaneously execute.
+	 */
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
+		dev_err(tas_dev->dev, "request_firmware_nowait err:0x%08x\n",
+			ret);
+
+	tas2781_reset(tas_dev);
+	if (tas_dev->set_global_mode)
+		tas_dev->set_global_mode(tas_dev);
+
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_dev->codec_lock);
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
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(codec);
+
+	tasdevice_deinit(tas_dev);
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
+static void tasdevice_parse_dt(struct tasdevice_priv *tas_dev)
+{
+	struct i2c_client *client = (struct i2c_client *)tas_dev->client;
+	unsigned int dev_addrs[max_chn];
+	int rc, i, ndev;
+
+	if (tas_dev->isacpi) {
+		ndev = device_property_read_u32_array(&client->dev,
+			"ti,audio-slots", NULL, 0);
+		if (ndev <= 0) {
+			ndev = 1;
+			dev_addrs[0] = client->addr;
+		} else {
+			ndev = (ndev < ARRAY_SIZE(dev_addrs))
+				? ndev : ARRAY_SIZE(dev_addrs);
+			ndev = device_property_read_u32_array(&client->dev,
+				"ti,audio-slots", dev_addrs, ndev);
+		}
+
+		tas_dev->irq_info.irq_gpio =
+			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
+	} else {
+		struct device_node *np = tas_dev->dev->of_node;
+
+		ndev = of_property_read_variable_u32_array(np,
+			"ti,audio-slots", dev_addrs, 0, ARRAY_SIZE(dev_addrs));
+		if (ndev <= 0) {
+			ndev = 1;
+			dev_addrs[0] = client->addr;
+		}
+		tas_dev->irq_info.irq_gpio = of_irq_get(np, 0);
+	}
+	tas_dev->ndev = ndev;
+	for (i = 0; i < ndev; i++)
+		tas_dev->tasdevice[i].dev_addr = dev_addrs[i];
+
+	if (ndev > 1) {
+		rc = device_property_read_u32(&client->dev,
+			"ti,broadcast-addr",
+			&(tas_dev->glb_addr.dev_addr));
+		if (rc) {
+			dev_err(tas_dev->dev,
+				"Looking up broadcast-addr failed %d\n", rc);
+			tas_dev->glb_addr.dev_addr = 0;
+		}
+	}
+
+	tas_dev->reset = devm_gpiod_get_optional(&client->dev,
+			"reset-gpios", GPIOD_OUT_HIGH);
+	if (IS_ERR(tas_dev->reset))
+		dev_err(tas_dev->dev, "%s Can't get reset GPIO\n",
+			__func__);
+
+	strcpy(tas_dev->dev_name, tasdevice_id[tas_dev->chip_id].name);
+
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
+			dev_err(tas_dev->dev, "%s: GPIO %d request error\n",
+				__func__, tas_dev->irq_info.irq_gpio);
+	} else
+		dev_err(tas_dev->dev,
+			"Looking up irq-gpio property failed %d\n",
+			tas_dev->irq_info.irq_gpio);
+}
+
+static int tasdevice_change_chn_book(struct tasdevice_priv *tas_dev,
+	enum channel chn, int book)
+{
+	struct i2c_client *client = (struct i2c_client *)tas_dev->client;
+	int ret = 0;
+	int i;
+
+	if (chn < tas_dev->ndev) {
+		if (tas_dev->glb_addr.ref_cnt != 0) {
+			tas_dev->glb_addr.ref_cnt = 0;
+			tas_dev->glb_addr.cur_book = -1;
+		}
+		client->addr = tas_dev->tasdevice[chn].dev_addr;
+		if (tas_dev->tasdevice[chn].cur_book != book) {
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			tas_dev->tasdevice[chn].cur_book = book;
+		}
+	} else if (chn == tas_dev->ndev) {
+		/* Chn == device number will enable global broadcast mode*/
+		if (tas_dev->glb_addr.ref_cnt == 0)
+			for (i = 0; i < tas_dev->ndev; i++)
+				tas_dev->tasdevice[i].cur_book = -1;
+		client->addr = tas_dev->glb_addr.dev_addr;
+		if (tas_dev->glb_addr.cur_book != book) {
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_PAGE, 0);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			ret = regmap_write(tas_dev->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_dev->dev, "%s, book%x, E=%d\n",
+					__func__, book, ret);
+				goto out;
+			}
+			tas_dev->glb_addr.cur_book = book;
+		}
+
+		tas_dev->glb_addr.ref_cnt++;
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
+			__func__, chn);
+	}
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
+	if (chn < tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_read(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), val);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
+			__func__, chn);
+	}
+
+out:
+	return ret;
+}
+
+int tasdevice_dev_write(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned int value)
+{
+	int ret = 0;
+
+	/* chn <= tas_dev->ndev will support global broadcast mode*/
+	if (chn <= tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_write(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), value);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
+			__func__, chn);
+	}
+
+out:
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
+	/* chn <= tas_dev->ndev will support global broadcast mode*/
+	if (chn <= tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_write(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), data, len);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
+			__func__, chn);
+	}
+
+out:
+	return ret;
+}
+
+int tasdevice_dev_bulk_read(struct tasdevice_priv *tas_dev,
+	enum channel chn, unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = 0;
+
+	if (chn < tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_read(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), data, len);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else
+		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
+			__func__, chn);
+
+out:
+	return ret;
+}
+
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *tas_dev, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	int ret = 0;
+
+	/* update-bits can't support global broadcast mode,
+	 * because this operation contains a reading operation
+	 * for register value. In global mode, reading register
+	 * from all of the tas2781 will cause confusion.
+	 */
+	if (chn < tas_dev->ndev) {
+		ret = tasdevice_change_chn_book(tas_dev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_update_bits(tas_dev->regmap,
+			TASDEVICE_PGRG(reg), mask, value);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		dev_err(tas_dev->dev, "%s, no such channel(%d)\n",
+			__func__, chn);
+		ret = -EINVAL;
+	}
+
+out:
+	return ret;
+}
+
+/* Only register write and bulk write support global mode
+ * Other cases, such as bits update, register read and bulk
+ * only support device-by-device operation
+ */
+static void tas2781_set_global_mode(struct tasdevice_priv *tas_dev)
+{
+	int i, ret;
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		ret = tasdevice_dev_update_bits(tas_dev, i,
+			TAS2871_MISC_CFG2, TAS2871_GLOBAL_ADDR_MASK,
+			TAS2871_GLOBAL_ADDR_ENABLE);
+		if (ret < 0) {
+			dev_err(tas_dev->dev, "%s: chn %d set glb fail, %d\n",
+				__func__, i, ret);
+			continue;
+		}
+	}
+}
+
+static int tasdevice_init(struct tasdevice_priv *tas_dev)
+{
+	int ret, i;
+
+	tas_dev->cur_prog = -1;
+	tas_dev->cur_conf = -1;
+
+	for (i = 0; i < tas_dev->ndev; i++) {
+		tas_dev->tasdevice[i].cur_book = -1;
+		tas_dev->tasdevice[i].cur_prog = -1;
+		tas_dev->tasdevice[i].cur_conf = -1;
+	}
+
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
+	if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
+		gpio_free(tas_dev->irq_info.irq_gpio);
+
+	mutex_destroy(&tas_dev->codec_lock);
+}
+
+static int tasdevice_i2c_probe(struct i2c_client *i2c)
+{
+	const struct i2c_device_id *id = i2c_match_id(tasdevice_id, i2c);
+	const struct acpi_device_id *acpi_id;
+	struct tasdevice_priv *tas_dev;
+	int ret;
+
+	tas_dev = devm_kzalloc(&i2c->dev, sizeof(*tas_dev), GFP_KERNEL);
+	if (!tas_dev)
+		return -ENOMEM;
+
+	if (ACPI_HANDLE(&i2c->dev)) {
+		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
+				&i2c->dev);
+		if (!acpi_id) {
+			dev_err(&i2c->dev, "No driver data\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		tas_dev->chip_id = acpi_id->driver_data;
+		tas_dev->isacpi = true;
+	} else {
+		tas_dev->chip_id = id ? id->driver_data : 0;
+		tas_dev->isacpi = false;
+	}
+
+	tas_dev->dev = &i2c->dev;
+	tas_dev->client = (void *)i2c;
+
+	tasdevice_parse_dt(tas_dev);
+
+	tas_dev->regmap = devm_regmap_init_i2c(i2c, &tasdevice_regmap);
+	if (IS_ERR(tas_dev->regmap)) {
+		ret = PTR_ERR(tas_dev->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto out;
+	}
+	ret = tasdevice_init(tas_dev);
+
+out:
+	if (ret < 0)
+		tasdevice_remove(tas_dev);
+	return ret;
+}
+
+static void tasdevice_i2c_remove(struct i2c_client *client)
+{
+	struct tasdevice_priv *tas_dev = i2c_get_clientdata(client);
+
+	tasdevice_remove(tas_dev);
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tasdevice_acpi_match[] = {
+	{ "TAS2781", TAS2781 },
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, tasdevice_acpi_match);
+#endif
+
+static struct i2c_driver tasdevice_i2c_driver = {
+	.driver = {
+		.name = "tas2781-codec",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tasdevice_of_match),
+		.acpi_match_table = ACPI_PTR(tasdevice_acpi_match),
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
index 000000000000..c0c52236f1da
--- /dev/null
+++ b/sound/soc/codecs/tas2781.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// TAS2781 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+// Author: Kevin Lu <kevin-lu@ti.com>
+//
+
+#ifndef __TAS2781_H__
+#define __TAS2781_H__
+
+#include <linux/kernel.h>
+#include "tas2781-dsp.h"
+
+/* version number */
+#define TAS2781_DRV_VER			1
+#define SMARTAMP_MODULE_NAME		"tas2781"
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
+/*Software Reset */
+#define TAS2871_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x02)
+#define TAS2871_REG_SWRESET_RESET	BIT(0)
+
+/* Enable Global addresses */
+#define TAS2871_MISC_CFG2		TASDEVICE_REG(0x0, 0X0, 0x07)
+#define TAS2871_GLOBAL_ADDR_MASK	BIT(1)
+#define TAS2871_GLOBAL_ADDR_ENABLE	BIT(1)
+
+/*I2C Checksum */
+#define TASDEVICE_I2CChecksum		TASDEVICE_REG(0x0, 0x0, 0x7E)
+
+/* Volume control */
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
+struct tasdevice {
+	struct tasdevice_fw *cali_data_fmw;
+	unsigned int dev_addr;
+	unsigned int err_code;
+	unsigned char cur_book;
+	short cur_prog;
+	short cur_conf;
+	bool is_loading;
+	bool is_loaderr;
+	bool is_calibrated_data_loaded;
+};
+
+/*
+ * This item is used to store the generic i2c address of
+ * all the tas2781 devices for I2C broadcast during the multi-device
+ * writes, useless in mono case.
+ */
+struct global_addr {
+	unsigned int dev_addr;
+	unsigned char cur_book;
+	int ref_cnt;
+};
+
+struct tasdevice_irqinfo {
+	int irq_gpio;
+	int irq;
+};
+
+struct tasdevice_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex codec_lock;
+	struct gpio_desc *reset;
+	struct tasdevice tasdevice[max_chn];
+	struct tasdevice_fw *fmw;
+	struct tasdevice_rca rcabin;
+	struct tasdevice_irqinfo irq_info;
+	struct global_addr glb_addr;
+	unsigned int chip_id;
+	unsigned int magic_num;
+	unsigned int sysclk;
+	unsigned char ndev;
+	unsigned char dev_name[32];
+	unsigned char rca_binaryname[64];
+	unsigned char coef_binaryname[64];
+	unsigned char cal_binaryname[max_chn][64];
+	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
+	void *client;
+	void *codec;
+	bool isacpi;
+	int cur_prog;
+	int cur_conf;
+	int fw_state;
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
+#endif /* __TAS2781_H__ */
-- 
2.34.1


