Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2970912E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjESICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjESICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:02:02 -0400
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA147E60;
        Fri, 19 May 2023 01:01:53 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[39.144.39.119])
        by rmsmtp-lg-appmail-03-12081 (RichMail) with SMTP id 2f3164672ce4423-404a4;
        Fri, 19 May 2023 16:01:44 +0800 (CST)
X-RM-TRANSID: 2f3164672ce4423-404a4
From:   Shenghao Ding <13916275206@139.com>
To:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com, Shenghao Ding <13916275206@139.com>
Subject: [PATCH v3 1/5] ASoC: tas2781: Add Header file for tas2781 driver
Date:   Fri, 19 May 2023 16:01:35 +0800
Message-Id: <20230519080135.20167-1-13916275206@139.com>
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

Create Header file for  tas2781 driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v3:
 - correct some enums have capitalized Chn, chn to all
 Changes to be committed:
	new file:   include/sound/tas2781-dsp.h
	new file:   include/sound/tas2781-tlv.h
	new file:   include/sound/tas2781.h
---
 include/sound/tas2781-dsp.h | 190 ++++++++++++++++++++++++++++++++++++
 include/sound/tas2781-tlv.h |  22 +++++
 include/sound/tas2781.h     | 176 +++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 include/sound/tas2781-dsp.h
 create mode 100644 include/sound/tas2781-tlv.h
 create mode 100644 include/sound/tas2781.h

diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
new file mode 100644
index 000000000000..b05f20bc4a1f
--- /dev/null
+++ b/include/sound/tas2781-dsp.h
@@ -0,0 +1,190 @@
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
+#define PPC3_VERSION_TAS2781			0x14c00
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
+int tas2781_load_calibration(void *context, char *file_name,
+	enum channel i);
+
+#endif
diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
new file mode 100644
index 000000000000..f4310dce655a
--- /dev/null
+++ b/include/sound/tas2781-tlv.h
@@ -0,0 +1,22 @@
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
+#ifndef __TAS2781_TLV_H__
+#define __TAS2781_TLV_H__
+
+static const DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
+
+#endif /* __TAS2781_LIB_H__ */
diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
new file mode 100644
index 000000000000..c98955bda07e
--- /dev/null
+++ b/include/sound/tas2781.h
@@ -0,0 +1,176 @@
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
+	bool playback_started;
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
+void tas2781_reset(struct tasdevice_priv *tas_dev);
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
+int tasdevice_amp_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+int tasdevice_amp_getvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+int tasdevice_digital_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+int tasdevice_digital_getvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+
+#endif /* __TAS2781_H__ */
-- 
2.34.1


