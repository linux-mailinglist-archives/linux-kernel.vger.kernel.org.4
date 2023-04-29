Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE006F22AD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 05:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbjD2DYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 23:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjD2DYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:24:32 -0400
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FACE42
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 20:23:49 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.194.159.16])
        by rmsmtp-lg-appmail-25-12028 (RichMail) with SMTP id 2efc644c8db18fe-b9b98;
        Sat, 29 Apr 2023 11:23:32 +0800 (CST)
X-RM-TRANSID: 2efc644c8db18fe-b9b98
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v1] ASoC: tas2781: Add tas2781 driver lib to support common operation for both ASoC codec driver and HDA codec driver
Date:   Sat, 29 Apr 2023 11:23:02 +0800
Message-Id: <20230429032302.5257-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create tas2781 driver lib.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v1:
 - create driver lib
 Changes to be committed:
	new file:   include/sound/tas2781-dsp.h
	new file:   include/sound/tas2781.h
	modified:   sound/soc/codecs/Kconfig
	modified:   sound/soc/codecs/Makefile
	new file:   sound/soc/codecs/tas2781-lib.c
---
 include/sound/tas2781-dsp.h    | 187 ++++++++++++++
 include/sound/tas2781.h        | 168 ++++++++++++
 sound/soc/codecs/Kconfig       |   6 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/tas2781-lib.c | 455 +++++++++++++++++++++++++++++++++
 5 files changed, 818 insertions(+)
 create mode 100644 include/sound/tas2781-dsp.h
 create mode 100644 include/sound/tas2781.h
 create mode 100644 sound/soc/codecs/tas2781-lib.c

diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
new file mode 100644
index 000000000000..125cbba9298d
--- /dev/null
+++ b/include/sound/tas2781-dsp.h
@@ -0,0 +1,187 @@
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
+void tasdevice_select_cfg_blk(void *context, int conf_no,
+	unsigned char block_type);
+void tasdevice_config_info_remove(void *context);
+void tasdevice_dsp_remove(void *context);
+int tasdevice_dsp_parser(void *context);
+int tasdevice_rca_parser(void *context, const struct firmware *fmw);
+void tasdevice_dsp_remove(void *context);
+void tasdevice_calbin_remove(void *context);
+int tasdevice_select_tuningprm_cfg(void *context, int prm,
+	int cfg_no, int rca_conf_no);
+int tasdevice_prmg_load(void *context, int prm_no);
+int tasdevice_prmg_calibdata_load(void *context, int prm_no);
+void tasdevice_tuning_switch(void *context, int state);
+
+#endif
diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
new file mode 100644
index 000000000000..ee3dd56f2084
--- /dev/null
+++ b/include/sound/tas2781.h
@@ -0,0 +1,168 @@
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
+#define TAS2781_GLOBAL_ADDR	0x40
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
+#define TASDEVICE_PGRG(reg)		(reg % (256 * 128))
+#define TASDEVICE_REG(book, page, reg)	(((book * 256 * 128) + \
+					(page * 128)) + reg)
+
+/*Software Reset */
+#define TAS2781_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x02)
+#define TAS2781_REG_SWRESET_RESET	BIT(0)
+
+/* Enable Global addresses */
+#define TAS2781_MISC_CFG2		TASDEVICE_REG(0x0, 0X0, 0x07)
+#define TAS2781_GLOBAL_ADDR_MASK	BIT(1)
+#define TAS2781_GLOBAL_ADDR_ENABLE	BIT(1)
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
+	int ref_cnt;
+	unsigned int dev_addr;
+	unsigned char cur_book;
+};
+
+struct tasdevice_irqinfo {
+	int irq_gpio;
+	int irq;
+};
+
+struct calidata {
+	unsigned char *data;
+	unsigned long total_sz;
+};
+
+struct tasdevice_priv {
+	struct tasdevice tasdevice[max_chn];
+	struct tasdevice_irqinfo irq_info;
+	struct global_addr glb_addr;
+	struct tasdevice_rca rcabin;
+	struct tasdevice_fw *fmw;
+	struct regmap *regmap;
+	struct mutex codec_lock;
+	struct calidata cali_data;
+	struct gpio_desc *reset;
+	struct device *dev;
+	struct tm tm;
+
+	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
+	unsigned char cal_binaryname[max_chn][64];
+	unsigned char coef_binaryname[64];
+	unsigned char rca_binaryname[64];
+	unsigned char dev_name[32];
+	unsigned char ndev;
+	unsigned int magic_num;
+	unsigned int chip_id;
+	unsigned int sysclk;
+	const char *acpi_subsystem_id;
+	int index;
+	int cur_prog;
+	int cur_conf;
+	int fw_state;
+	void *client;
+	void *codec;
+	bool isacpi;
+	void (*set_global_mode)(struct tasdevice_priv *tas_priv);
+	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_priv,
+		const struct firmware *fmw, int offset);
+	int (*fw_parse_program_data)(struct tasdevice_priv *tas_priv,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_priv,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
+		struct tasdev_blk *block);
+};
+
+int tas2781_load_calibration(void *context, char *file_name, enum channel i);
+int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
+	void (*cont)(const struct firmware *fw, void *context));
+struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c);
+int tasdevice_init(struct tasdevice_priv *tas_priv);
+void tasdevice_remove(struct tasdevice_priv *tas_priv);
+int tasdevice_dev_read(struct tasdevice_priv *tas_priv,
+	enum channel chn, unsigned int reg, unsigned int *value);
+int tasdevice_dev_write(struct tasdevice_priv *tas_priv,
+	enum channel chn, unsigned int reg, unsigned int value);
+int tasdevice_dev_bulk_write(
+	struct tasdevice_priv *tas_priv, enum channel chn,
+	unsigned int reg, unsigned char *p_data, unsigned int n_length);
+int tasdevice_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	enum channel chn, unsigned int reg, unsigned char *p_data,
+	unsigned int n_length);
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *tasdevice, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value);
+
+#endif /* __TAS2781_H__ */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 79d2362ad055..c899b18e423a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -234,6 +234,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2764
 	imply SND_SOC_TAS2770
 	imply SND_SOC_TAS2780
+	imply SND_SOC_TAS2781_LIB
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1699,6 +1700,11 @@ config SND_SOC_TAS2780
 	  Enable support for Texas Instruments TAS2780 high-efficiency
 	  digital input mono Class-D audio power amplifiers.
 
+config SND_SOC_TAS2781_LIB
+	select CRC8
+	select REGMAP_I2C
+	tristate
+
 config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5cdbae88e6e3..3f58a5df8120 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -269,6 +269,7 @@ snd-soc-tas5805m-objs := tas5805m.o
 snd-soc-tas6424-objs := tas6424.o
 snd-soc-tda7419-objs := tda7419.o
 snd-soc-tas2770-objs := tas2770.o
+snd-soc-tas2781-lib-objs := tas2781-lib.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tfa989x-objs := tfa989x.o
 snd-soc-tlv320adc3xxx-objs := tlv320adc3xxx.o
@@ -633,6 +634,7 @@ obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS2562)	+= snd-soc-tas2562.o
 obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
+obj-$(CONFIG_SND_SOC_TAS2781_LIB)	+= snd-soc-tas2781-lib.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2781-lib.c b/sound/soc/codecs/tas2781-lib.c
new file mode 100644
index 000000000000..1d843bc6c42e
--- /dev/null
+++ b/sound/soc/codecs/tas2781-lib.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// tas2781-lib.c -- TAS2781 Common functions for HDA and ASoC Audio drivers
+//
+// Copyright 2023 Texas Instruments, Inc.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
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
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tas2781.h>
+#include <sound/tlv.h>
+
+#define TASDEVICE_CRC8_POLYNOMIAL	0x4d
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
+static int tasdevice_change_chn_book(struct tasdevice_priv *tas_priv,
+	enum channel chn, int book)
+{
+	struct i2c_client *client = (struct i2c_client *)tas_priv->client;
+	int ret = 0;
+	int i;
+
+	if (chn < tas_priv->ndev) {
+		struct tasdevice *tasdev = &tas_priv->tasdevice[chn];
+
+		if (tas_priv->glb_addr.ref_cnt != 0) {
+			tas_priv->glb_addr.ref_cnt = 0;
+			tas_priv->glb_addr.cur_book = -1;
+		}
+		client->addr = tasdev->dev_addr;
+		if (tasdev->cur_book != book) {
+			ret = regmap_write(tas_priv->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_priv->dev, "%s, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			tasdev->cur_book = book;
+		}
+	} else if (chn == tas_priv->ndev) {
+		struct global_addr *glb_addr = &tas_priv->glb_addr;
+
+		/* Chn == device number will enable global broadcast mode*/
+		if (tas_priv->glb_addr.ref_cnt == 0)
+			for (i = 0; i < tas_priv->ndev; i++)
+				tas_priv->tasdevice[i].cur_book = -1;
+		client->addr = glb_addr->dev_addr;
+		if (glb_addr->cur_book != book) {
+			ret = regmap_write(tas_priv->regmap,
+				TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_priv->dev, "%s, book%x, E=%d\n",
+					__func__, book, ret);
+				goto out;
+			}
+			glb_addr->cur_book = book;
+		}
+
+		glb_addr->ref_cnt++;
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_priv->dev, "%s, no such channel(%d)\n", __func__,
+			chn);
+	}
+
+out:
+	return ret;
+}
+
+int tasdevice_dev_read(struct tasdevice_priv *tas_priv,
+	enum channel chn, unsigned int reg, unsigned int *val)
+{
+	int ret = 0;
+
+	if (chn < tas_priv->ndev) {
+		ret = tasdevice_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_read(tas_priv->regmap, TASDEVICE_PGRG(reg), val);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_priv->dev, "%s, no such channel(%d)\n", __func__,
+			chn);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_dev_read);
+
+int tasdevice_dev_write(struct tasdevice_priv *tas_priv,
+	enum channel chn, unsigned int reg, unsigned int value)
+{
+	int ret = 0;
+
+	/* chn <= tas_dev->ndev will support global broadcast mode*/
+	if (chn <= tas_priv->ndev) {
+		ret = tasdevice_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_write(tas_priv->regmap, TASDEVICE_PGRG(reg),
+			value);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_priv->dev, "%s, no such channel(%d)\n", __func__,
+			chn);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_dev_write);
+
+int tasdevice_dev_bulk_write(
+	struct tasdevice_priv *tas_priv, enum channel chn,
+	unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = 0;
+
+	/* chn <= tas_dev->ndev will support global broadcast mode*/
+	if (chn <= tas_priv->ndev) {
+		ret = tasdevice_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_write(tas_priv->regmap, TASDEVICE_PGRG(reg),
+			data, len);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		ret = -EINVAL;
+		dev_err(tas_priv->dev, "%s, no such channel(%d)\n", __func__,
+			chn);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_dev_bulk_write);
+
+int tasdevice_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	enum channel chn, unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = 0;
+
+	if (chn < tas_priv->ndev) {
+		ret = tasdevice_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_read(tas_priv->regmap, TASDEVICE_PGRG(reg),
+			data, len);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	} else
+		dev_err(tas_priv->dev, "%s, no such channel(%d)\n", __func__,
+			chn);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_dev_bulk_read);
+
+int tasdevice_dev_update_bits(
+	struct tasdevice_priv *tasdev, enum channel chn,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	int ret = 0;
+
+	/* update-bits can't support global broadcast mode,
+	 * because this operation contains a reading operation
+	 * for register value. In global mode, reading register
+	 * from all of the tas2781 will cause confusion.
+	 */
+	if (chn < tasdev->ndev) {
+		ret = tasdevice_change_chn_book(tasdev, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_update_bits(tasdev->regmap,
+			TASDEVICE_PGRG(reg), mask, value);
+		if (ret < 0)
+			dev_err(tasdev->dev, "%s, E=%d\n", __func__, ret);
+	} else {
+		dev_err(tasdev->dev, "%s, no such channel(%d)\n", __func__,
+			chn);
+		ret = -EINVAL;
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_dev_update_bits);
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
+			TAS2781_MISC_CFG2, TAS2781_GLOBAL_ADDR_MASK,
+			TAS2781_GLOBAL_ADDR_ENABLE);
+		if (ret < 0) {
+			dev_err(tas_dev->dev, "%s: chn %d set glb fail, %d\n",
+				__func__, i, ret);
+			continue;
+		}
+	}
+}
+
+struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c)
+{
+	struct tasdevice_priv *tas_priv;
+
+	tas_priv = devm_kzalloc(&i2c->dev, sizeof(*tas_priv), GFP_KERNEL);
+	if (!tas_priv)
+		return NULL;
+	tas_priv->dev = &i2c->dev;
+	tas_priv->client = (void *)i2c;
+
+	return tas_priv;
+}
+EXPORT_SYMBOL_GPL(tasdevice_kzalloc);
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
+				TAS2781_REG_SWRESET,
+				TAS2781_REG_SWRESET_RESET);
+			if (ret < 0)
+				dev_err(tas_dev->dev,
+					"dev %d swreset fail, %d\n",
+					i, ret);
+		}
+	}
+	usleep_range(1000, 1050);
+}
+
+int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	int ret = 0;
+
+	/* Codec Lock Hold to ensure that codec_probe and firmware parsing and
+	 * loading do not simultaneously execute.
+	 */
+	mutex_lock(&tas_priv->codec_lock);
+
+	scnprintf(tas_priv->rca_binaryname, 64, "%s_rca.bin",
+		tas_priv->dev_name);
+	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
+	tas_priv->codec = codec;
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+		tas_priv->rca_binaryname, tas_priv->dev, GFP_KERNEL, tas_priv,
+		cont);
+	if (ret)
+		dev_err(tas_priv->dev, "request_firmware_nowait err:0x%08x\n",
+			ret);
+
+	tas2781_reset(tas_priv);
+	if (tas_priv->set_global_mode)
+		tas_priv->set_global_mode(tas_priv);
+
+	/* Codec Lock Release*/
+	mutex_unlock(&tas_priv->codec_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tascodec_init);
+
+int tasdevice_init(struct tasdevice_priv *tas_priv)
+{
+	int ret = 0;
+	int i;
+
+	tas_priv->regmap = devm_regmap_init_i2c(tas_priv->client,
+		&tasdevice_regmap);
+	if (IS_ERR(tas_priv->regmap)) {
+		ret = PTR_ERR(tas_priv->regmap);
+		dev_err(tas_priv->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto out;
+	}
+
+	tas_priv->cur_prog = -1;
+	tas_priv->cur_conf = -1;
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		tas_priv->tasdevice[i].cur_book = -1;
+		tas_priv->tasdevice[i].cur_prog = -1;
+		tas_priv->tasdevice[i].cur_conf = -1;
+	}
+
+	if (tas_priv->glb_addr.dev_addr != 0
+		&& tas_priv->glb_addr.dev_addr < 0x7F)
+		tas_priv->set_global_mode = tas2781_set_global_mode;
+	dev_set_drvdata(tas_priv->dev, tas_priv);
+
+	mutex_init(&tas_priv->codec_lock);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_init);
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
+EXPORT_SYMBOL_GPL(tasdevice_dsp_remove);
+
+void tasdevice_remove(struct tasdevice_priv *tas_priv)
+{
+	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
+		gpio_free(tas_priv->irq_info.irq_gpio);
+	kfree(tas_priv->acpi_subsystem_id);
+	mutex_destroy(&tas_priv->codec_lock);
+}
+EXPORT_SYMBOL_GPL(tasdevice_remove);
+
+MODULE_DESCRIPTION("TAS2781 library");
+MODULE_AUTHOR("Shenghao Ding, TI, <shenghao-ding@ti.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


