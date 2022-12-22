Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BA654104
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiLVMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiLVMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:32:33 -0500
Received: from out29-128.mail.aliyun.com (out29-128.mail.aliyun.com [115.124.29.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5D1A816;
        Thu, 22 Dec 2022 04:32:28 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00334286-0.00077978-0.995877;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.QbObWjX_1671712341;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QbObWjX_1671712341)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 20:32:23 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, ryan.lee.analog@gmail.com,
        jonathan.albrieux@gmail.com, tanureal@opensource.cirrus.com,
        povik+lin@cutebit.org, 13691752556@139.com,
        cezary.rojewski@intel.com, stephan@gerhold.net,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com, duanyibo@awinic.com,
        Weidong Wang <wangweidong.a@awinic.com>
Subject: [PATCH V7 3/5] ASoC: codecs: Aw883xx common function for ALSA Audio Driver
Date:   Thu, 22 Dec 2022 20:32:04 +0800
Message-Id: <20221222123205.106353-4-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221222123205.106353-1-wangweidong.a@awinic.com>
References: <20221222123205.106353-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The Awinic AW883XX is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Signed-off-by: Nick Li <liweilei@awinic.com>
Signed-off-by: Bruce zhao <zhaolei@awinic.com>
Signed-off-by: Ben Yi <yijiangtao@awinic.com>
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw883xx/aw883xx_device.c | 1840 +++++++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_device.h |  201 +++
 2 files changed, 2041 insertions(+)
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_device.h

diff --git a/sound/soc/codecs/aw883xx/aw883xx_device.c b/sound/soc/codecs/aw883xx/aw883xx_device.c
new file mode 100644
index 000000000000..c207a3ac1301
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx_device.c
@@ -0,0 +1,1840 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * aw883xx_device.c --  AW883XX common function for ALSA Audio Driver
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ * Author: Ben Yi <yijiangtao@awinic.com>
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include "aw883xx_pid_2049_reg.h"
+#include "aw883xx_data_type.h"
+#include "aw883xx_device.h"
+#include "aw883xx_bin_parse.h"
+
+/*
+ * aw883xx device dsp write/read
+ */
+static int aw_dev_dsp_write_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data)
+{
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, (u16)dsp_data);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write data error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int aw_dev_dsp_write_32bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data)
+{
+	int ret;
+	u16 temp_data = 0;
+
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	temp_data = dsp_data & AW_DSP_16_DATA_MASK;
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, (u16)temp_data);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write datal error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	temp_data = dsp_data >> 16;
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, (u16)temp_data);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write datah error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int aw_dev_dsp_write(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data, unsigned char data_type)
+{
+	int ret = 0;
+	u32 reg_value;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	switch (data_type) {
+	case AW_DSP_16_DATA:
+		ret = aw_dev_dsp_write_16bit(aw_dev, dsp_addr, dsp_data);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
+					(u32)dsp_addr, dsp_data);
+		break;
+	case AW_DSP_32_DATA:
+		ret = aw_dev_dsp_write_32bit(aw_dev, dsp_addr, dsp_data);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 32-bit dsp_data[0x%x] failed",
+					(u32)dsp_addr, dsp_data);
+		break;
+	default:
+		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	/* clear dsp chip select state*/
+	regmap_read(aw_dev->regmap, AW_PID_2049_ID_REG, &reg_value);
+	mutex_unlock(&aw_dev->dsp_lock);
+	return ret;
+}
+
+static int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data)
+{
+	int ret;
+	unsigned int temp_data = 0;
+
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &temp_data);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	*dsp_data = temp_data;
+
+	return 0;
+}
+
+static int aw_dev_dsp_read_32bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data)
+{
+	int ret;
+	unsigned int temp_data = 0;
+
+	ret = regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, dsp_addr);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &temp_data);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	*dsp_data = temp_data;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &temp_data);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	*dsp_data |= (temp_data << 16);
+
+	return 0;
+}
+
+static int aw_dev_dsp_read(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type)
+{
+	int ret = 0;
+	u32 reg_value;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	switch (data_type) {
+	case AW_DSP_16_DATA:
+		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
+					(u32)dsp_addr, *dsp_data);
+		break;
+	case AW_DSP_32_DATA:
+		ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32r-bit dsp_data[0x%x] failed",
+					(u32)dsp_addr, *dsp_data);
+		break;
+	default:
+		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	/* clear dsp chip select state*/
+	regmap_read(aw_dev->regmap, AW_PID_2049_ID_REG, &reg_value);
+	mutex_unlock(&aw_dev->dsp_lock);
+	return ret;
+}
+
+
+static int aw_dev_read_chipid(struct aw_device *aw_dev, u16 *chip_id)
+{
+	int ret = 0;
+	int reg_val = 0;
+
+	ret = regmap_read(aw_dev->regmap, AW_CHIP_ID_REG, &reg_val);
+	if (ret < 0)
+		return -EIO;
+
+	dev_info(aw_dev->dev, "chip id = %x\n", reg_val);
+	*chip_id = reg_val;
+
+	return 0;
+}
+
+static void aw_dev_set_cfg_f0_fs(struct aw_device *aw_dev, unsigned int *f0_fs)
+{
+	unsigned int rate_data = 0;
+	u32 fs = 0;
+
+	regmap_read(aw_dev->regmap, AW_PID_2049_I2SCTRL_REG, &rate_data);
+
+	switch (rate_data & (~AW_PID_2049_I2SSR_MASK)) {
+	case AW_PID_2049_I2SSR_8_KHZ_VALUE:
+		fs = 8000;
+		break;
+	case AW_PID_2049_I2SSR_16_KHZ_VALUE:
+		fs = 16000;
+		break;
+	case AW_PID_2049_I2SSR_32_KHZ_VALUE:
+		fs = 32000;
+		break;
+	case AW_PID_2049_I2SSR_44_KHZ_VALUE:
+		fs = 44000;
+		break;
+	case AW_PID_2049_I2SSR_48_KHZ_VALUE:
+		fs = 48000;
+		break;
+	case AW_PID_2049_I2SSR_96_KHZ_VALUE:
+		fs = 96000;
+		break;
+	case AW_PID_2049_I2SSR_192KHZ_VALUE:
+		fs = 192000;
+		break;
+	default:
+		fs = 48000;
+		dev_err(aw_dev->dev,
+			"rate can not support, use default 48kHz");
+		break;
+	}
+
+	dev_dbg(aw_dev->dev, "i2s fs:%d Hz", fs);
+	*f0_fs = fs / 8;
+
+	aw_dev_dsp_write(aw_dev, AW_PID_2049_DSP_REG_CFGF0_FS, *f0_fs, AW_DSP_32_DATA);
+}
+
+/*[9 : 6]: -6DB ; [5 : 0]: -0.125DB  real_value = value * 8 : 0.125db --> 1*/
+static unsigned int reg_val_to_db(unsigned int value)
+{
+	return (((value >> AW_PID_2049_VOL_6DB_START) * AW_PID_2049_VOLUME_STEP_DB) +
+			((value & 0x3f) % AW_PID_2049_VOLUME_STEP_DB));
+}
+
+/*[9 : 6]: -6DB ; [5 : 0]: -0.125DB reg_value = value / step << 6 + value % step ; step = 6 * 8*/
+static unsigned short db_to_reg_val(unsigned short value)
+{
+	return (((value / AW_PID_2049_VOLUME_STEP_DB) << AW_PID_2049_VOL_6DB_START) +
+			(value % AW_PID_2049_VOLUME_STEP_DB));
+}
+
+static int aw_dev_dsp_fw_check(struct aw_device *aw_dev)
+{
+	struct aw_prof_desc *set_prof_desc = NULL;
+	struct aw_sec_data_desc *dsp_fw_desc = NULL;
+	u16 base_addr = AW_PID_2049_DSP_FW_ADDR;
+	u16 addr = base_addr;
+	int ret, i;
+	u32 dsp_val;
+	u16 bin_val;
+
+	ret = aw883xx_dev_get_prof_data(aw_dev, aw_dev->prof_cur, &set_prof_desc);
+	if (ret < 0)
+		return ret;
+
+	/*update reg*/
+	dsp_fw_desc = &set_prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW];
+
+	for (i = 0; i < AW_FW_CHECK_PART; i++) {
+		ret = aw_dev_dsp_read(aw_dev, addr, &dsp_val, AW_DSP_16_DATA);
+		if (ret  < 0) {
+			dev_err(aw_dev->dev, "dsp read failed");
+			return ret;
+		}
+
+		bin_val = be16_to_cpup((void *)&dsp_fw_desc->data[2 * (addr - base_addr)]);
+
+		if (dsp_val != bin_val) {
+			dev_err(aw_dev->dev, "fw check failed, addr[0x%x], read[0x%x] != bindata[0x%x]",
+					addr, dsp_val, bin_val);
+			return -EINVAL;
+		}
+
+		addr += (dsp_fw_desc->len / 2) / AW_FW_CHECK_PART;
+		if ((addr - base_addr) > dsp_fw_desc->len) {
+			dev_err(aw_dev->dev, "fw check failed, addr[0x%x] too large", addr);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int aw_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int reg_value = 0;
+	u16 real_value = 0;
+	u16 volume = 0;
+
+	volume = min((value + vol_desc->init_volume), (unsigned int)AW_PID_2049_MUTE_VOL);
+	real_value = db_to_reg_val(volume);
+
+	/* cal real value */
+	regmap_read(aw_dev->regmap, AW_PID_2049_SYSCTRL2_REG, &reg_value);
+
+	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
+
+	/*[15 : 6] volume*/
+	real_value = (real_value << AW_PID_2049_VOL_START_BIT) | (reg_value & AW_PID_2049_VOL_MASK);
+
+	/* write value */
+	regmap_write(aw_dev->regmap, AW_PID_2049_SYSCTRL2_REG, real_value);
+
+	return 0;
+}
+
+void aw883xx_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol)
+{
+	int ret = 0;
+
+	ret = aw_dev_set_volume(aw_dev, set_vol);
+	if (ret < 0)
+		dev_dbg(aw_dev->dev, "set volume failed");
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_set_volume);
+
+static void aw_dev_fade_in(struct aw_device *aw_dev)
+{
+	int i = 0;
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_step = aw_dev->fade_step;
+	u16 fade_in_vol = desc->ctl_volume;
+
+	if (!aw_dev->fade_en)
+		return;
+
+	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
+		aw_dev_set_volume(aw_dev, fade_in_vol);
+		return;
+	}
+	/*volume up*/
+	for (i = AW_PID_2049_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
+		aw_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
+	}
+	if (i != fade_in_vol)
+		aw_dev_set_volume(aw_dev, fade_in_vol);
+}
+
+static void aw_dev_fade_out(struct aw_device *aw_dev)
+{
+	int i = 0;
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_step = aw_dev->fade_step;
+
+	if (!aw_dev->fade_en)
+		return;
+
+	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
+		aw_dev_set_volume(aw_dev, AW_PID_2049_MUTE_VOL);
+		return;
+	}
+
+	for (i = desc->ctl_volume; i <= AW_PID_2049_MUTE_VOL; i += fade_step) {
+		aw_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+	if (i != AW_PID_2049_MUTE_VOL) {
+		aw_dev_set_volume(aw_dev, AW_PID_2049_MUTE_VOL);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+}
+
+static int aw_dev_modify_dsp_cfg(struct aw_device *aw_dev,
+			unsigned int addr, unsigned int dsp_data, unsigned char data_type)
+{
+	u32 addr_offset = 0;
+	u16 data1 = 0;
+	u32 data2 = 0;
+	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
+
+	dev_dbg(aw_dev->dev, "addr:0x%x, dsp_data:0x%x", addr, dsp_data);
+
+	addr_offset = (addr - AW_PID_2049_DSP_CFG_ADDR) * 2;
+	if (addr_offset > crc_dsp_cfg->len) {
+		dev_err(aw_dev->dev, "addr_offset[%d] > crc_dsp_cfg->len[%d]",
+				addr_offset, crc_dsp_cfg->len);
+		return -EINVAL;
+	}
+	switch (data_type) {
+	case AW_DSP_16_DATA:
+		data1 = cpu_to_le16((u16)dsp_data);
+		memcpy(crc_dsp_cfg->data + addr_offset, (u8 *)&data1, 2);
+		break;
+	case AW_DSP_32_DATA:
+		data2 = cpu_to_le32(dsp_data);
+		memcpy(crc_dsp_cfg->data + addr_offset, (u8 *)&data2, 4);
+		break;
+	default:
+		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_dsp_set_cali_re(struct aw_device *aw_dev)
+{
+	u32 cali_re = 0;
+	int ret = 0;
+
+	cali_re = AW_SHOW_RE_TO_DSP_RE((aw_dev->cali_desc.cali_re +
+		aw_dev->cali_desc.ra), AW_PID_2049_DSP_RE_SHIFT);
+
+	/* set cali re to device */
+	ret = aw_dev_dsp_write(aw_dev,
+			AW_PID_2049_DSP_REG_CFG_ADPZ_RE, cali_re, AW_DSP_32_DATA);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "set cali re error");
+		return ret;
+	}
+
+	ret = aw_dev_modify_dsp_cfg(aw_dev, AW_PID_2049_DSP_REG_CFG_ADPZ_RE,
+				cali_re, AW_DSP_32_DATA);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "modify dsp cfg failed");
+
+	return ret;
+
+}
+
+static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
+{
+	if (flag) {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_I2SCFG1_REG,
+				~AW_PID_2049_I2STXEN_MASK,
+				AW_PID_2049_I2STXEN_ENABLE_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_I2SCFG1_REG,
+				~AW_PID_2049_I2STXEN_MASK,
+				AW_PID_2049_I2STXEN_DISABLE_VALUE);
+	}
+}
+
+static int aw_dev_dsp_set_crc32(struct aw_device *aw_dev)
+{
+	u32 crc_value = 0;
+	u32 crc_data_len = 0;
+	int ret = 0;
+	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
+
+	/*get crc data len*/
+	crc_data_len = (AW_PID_2049_DSP_REG_CRC_ADDR - AW_PID_2049_DSP_CFG_ADDR) * 2;
+	if (crc_data_len > crc_dsp_cfg->len) {
+		dev_err(aw_dev->dev, "crc data len :%d > cfg_data len:%d",
+			crc_data_len, crc_dsp_cfg->len);
+		return -EINVAL;
+	}
+
+	if (crc_data_len % 4 != 0) {
+		dev_err(aw_dev->dev, "The crc data len :%d unsupport", crc_data_len);
+		return -EINVAL;
+	}
+
+	crc_value = __crc32c_le(0xFFFFFFFF, crc_dsp_cfg->data, crc_data_len) ^ 0xFFFFFFFF;
+
+	dev_dbg(aw_dev->dev, "crc_value:0x%x", crc_value);
+	ret = aw_dev_dsp_write(aw_dev, AW_PID_2049_DSP_REG_CRC_ADDR, crc_value,
+						AW_DSP_32_DATA);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "set dsp crc value failed");
+
+	return ret;
+}
+
+static void aw_dev_dsp_check_crc_enable(struct aw_device *aw_dev, bool flag)
+{
+	if (flag)
+		regmap_update_bits(aw_dev->regmap,
+				AW_PID_2049_HAGCCFG7_REG,
+				~AW_PID_2049_AGC_DSP_CTL_MASK,
+				AW_PID_2049_AGC_DSP_CTL_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap,
+				AW_PID_2049_HAGCCFG7_REG,
+				~AW_PID_2049_AGC_DSP_CTL_MASK,
+				AW_PID_2049_AGC_DSP_CTL_DISABLE_VALUE);
+}
+
+static int aw_dev_dsp_check_st(struct aw_device *aw_dev)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+	int i;
+
+	for (i = 0; i < AW_DSP_ST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->regmap, AW_PID_2049_SYSST_REG, &reg_val);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "read reg0x%x failed", AW_PID_2049_SYSST_REG);
+			continue;
+		}
+
+		if ((reg_val & (~AW_PID_2049_DSPS_MASK)) != AW_PID_2049_DSPS_NORMAL_VALUE) {
+			dev_err(aw_dev->dev, "check dsp st fail,reg_val:0x%04x", reg_val);
+			ret = -EPERM;
+			continue;
+		} else {
+			dev_dbg(aw_dev->dev, "dsp st check ok, reg_val:0x%04x", reg_val);
+			return 0;
+		}
+	}
+
+	return ret;
+}
+
+static void aw_dev_dsp_enable(struct aw_device *aw_dev, bool is_enable)
+{
+	int ret = 0;
+
+	if (is_enable) {
+		ret = regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+					~AW_PID_2049_DSPBY_MASK, AW_PID_2049_DSPBY_WORKING_VALUE);
+		if (ret < 0)
+			dev_dbg(aw_dev->dev, "enable dsp failed");
+	} else {
+		ret = regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+					~AW_PID_2049_DSPBY_MASK, AW_PID_2049_DSPBY_BYPASS_VALUE);
+		if (ret < 0)
+			dev_dbg(aw_dev->dev, "disable dsp failed");
+	}
+}
+
+static int aw_dev_dsp_check_crc32(struct aw_device *aw_dev)
+{
+	int ret;
+
+	if (aw_dev->dsp_cfg == AW_DEV_DSP_BYPASS) {
+		dev_info(aw_dev->dev, "dsp bypass");
+		return 0;
+	}
+
+	ret = aw_dev_dsp_set_crc32(aw_dev);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "set dsp crc32 failed");
+		return ret;
+	}
+
+	aw_dev_dsp_check_crc_enable(aw_dev, true);
+
+	/*dsp enable*/
+	aw_dev_dsp_enable(aw_dev, true);
+	usleep_range(AW_5000_US, AW_5000_US + 100);
+
+	ret = aw_dev_dsp_check_st(aw_dev);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "check crc32 fail");
+	} else {
+		aw_dev_dsp_check_crc_enable(aw_dev, false);
+		aw_dev->dsp_crc_st = AW_DSP_CRC_OK;
+	}
+	return ret;
+}
+
+static void aw_dev_pwd(struct aw_device *aw_dev, bool pwd)
+{
+	if (pwd) {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+				~AW_PID_2049_PWDN_MASK,
+				AW_PID_2049_PWDN_POWER_DOWN_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+				~AW_PID_2049_PWDN_MASK,
+				AW_PID_2049_PWDN_WORKING_VALUE);
+	}
+}
+
+static void aw_dev_amppd(struct aw_device *aw_dev, bool amppd)
+{
+	if (amppd) {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+				~AW_PID_2049_AMPPD_MASK,
+				AW_PID_2049_AMPPD_POWER_DOWN_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+				~AW_PID_2049_AMPPD_MASK,
+				AW_PID_2049_AMPPD_WORKING_VALUE);
+	}
+}
+
+void aw883xx_dev_mute(struct aw_device *aw_dev, bool is_mute)
+{
+	if (is_mute) {
+		aw_dev_fade_out(aw_dev);
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+				~AW_PID_2049_HMUTE_MASK, AW_PID_2049_HMUTE_ENABLE_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG,
+				~AW_PID_2049_HMUTE_MASK, AW_PID_2049_HMUTE_DISABLE_VALUE);
+		aw_dev_fade_in(aw_dev);
+	}
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_mute);
+
+static int aw_dev_get_icalk(struct aw_device *aw_dev, int16_t *icalk)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+	u16 reg_icalk = 0;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_EFRM2_REG, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	reg_icalk = reg_val & (~AW_PID_2049_EF_ISN_GESLP_MASK);
+
+	if (reg_icalk & (~AW_PID_2049_EF_ISN_GESLP_SIGN_MASK))
+		reg_icalk = reg_icalk | AW_PID_2049_EF_ISN_GESLP_SIGN_NEG;
+
+	*icalk = (int16_t)reg_icalk;
+
+	return ret;
+}
+
+static int aw_dev_get_vcalk(struct aw_device *aw_dev, int16_t *vcalk)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+	u16 reg_vcalk = 0;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_EFRH_REG, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	reg_val = reg_val >> AW_PID_2049_EF_VSENSE_GAIN_SHIFT;
+
+	reg_vcalk = (u16)reg_val & (~AW_PID_2049_EF_VSN_GESLP_MASK);
+
+	if (reg_vcalk & (~AW_PID_2049_EF_VSN_GESLP_SIGN_MASK))
+		reg_vcalk = reg_vcalk | AW_PID_2049_EF_VSN_GESLP_SIGN_NEG;
+
+	*vcalk = (int16_t)reg_vcalk;
+
+	return ret;
+}
+
+static int aw_dev_get_vcalk_dac(struct aw_device *aw_dev, int16_t *vcalk)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+	u16 reg_vcalk = 0;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_EFRM2_REG, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	reg_vcalk = reg_val >> AW_PID_2049_EF_DAC_GESLP_SHIFT;
+
+	if (reg_vcalk & AW_PID_2049_EF_DAC_GESLP_SIGN_MASK)
+		reg_vcalk = reg_vcalk | AW_PID_2049_EF_DAC_GESLP_SIGN_NEG;
+
+	*vcalk = (int16_t)reg_vcalk;
+
+	return ret;
+}
+
+static int aw_dev_vsense_select(struct aw_device *aw_dev, int *vsense_select)
+{
+	int ret = 0;
+	unsigned int vsense_reg_val;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_I2SCFG3_REG, &vsense_reg_val);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "read vsense_reg_val failed");
+		return ret;
+	}
+	dev_dbg(aw_dev->dev, "vsense_reg = 0x%x", vsense_reg_val);
+
+	if (vsense_reg_val & (~AW_PID_2049_VDSEL_MASK)) {
+		*vsense_select = AW_DEV_VDSEL_VSENSE;
+		dev_dbg(aw_dev->dev, "vsense outside");
+	} else {
+		*vsense_select = AW_DEV_VDSEL_DAC;
+		dev_dbg(aw_dev->dev, "vsense inside");
+	}
+	return 0;
+}
+
+static int aw_dev_set_vcalb(struct aw_device *aw_dev)
+{
+	int ret = 0;
+	u32 reg_val = 0;
+	int vcalb;
+	int icalk;
+	int vcalk;
+	int16_t icalk_val = 0;
+	int16_t vcalk_val = 0;
+	u32 vcalb_adj;
+	int vsense_select = -1;
+
+	ret = aw_dev_dsp_read(aw_dev, AW_PID_2049_DSP_REG_VCALB, &vcalb_adj, AW_DSP_16_DATA);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "read vcalb_adj failed");
+		return ret;
+	}
+
+	ret = aw_dev_vsense_select(aw_dev, &vsense_select);
+	if (ret < 0)
+		return ret;
+	dev_dbg(aw_dev->dev, "vsense_select = %d", vsense_select);
+
+	ret = aw_dev_get_icalk(aw_dev, &icalk_val);
+	if (ret < 0)
+		return ret;
+	icalk = AW_PID_2049_CABL_BASE_VALUE + AW_PID_2049_ICABLK_FACTOR * icalk_val;
+
+	switch (vsense_select) {
+	case AW_DEV_VDSEL_VSENSE:
+		ret = aw_dev_get_vcalk(aw_dev, &vcalk_val);
+		if (ret < 0)
+			return ret;
+		vcalk = AW_PID_2049_CABL_BASE_VALUE + AW_PID_2049_VCABLK_FACTOR * vcalk_val;
+		vcalb = AW_PID_2049_VCAL_FACTOR * AW_PID_2049_VSCAL_FACTOR /
+			AW_PID_2049_ISCAL_FACTOR * icalk / vcalk * vcalb_adj;
+
+		dev_dbg(aw_dev->dev, "vcalk_factor=%d, vscal_factor=%d, icalk=%d, vcalk=%d",
+				AW_PID_2049_VCABLK_FACTOR, AW_PID_2049_VSCAL_FACTOR, icalk, vcalk);
+		break;
+	case AW_DEV_VDSEL_DAC:
+		ret = aw_dev_get_vcalk_dac(aw_dev, &vcalk_val);
+		if (ret < 0)
+			return ret;
+		vcalk = AW_PID_2049_CABL_BASE_VALUE + AW_PID_2049_VCABLK_FACTOR_DAC * vcalk_val;
+		vcalb = AW_PID_2049_VCAL_FACTOR * AW_PID_2049_VSCAL_FACTOR_DAC /
+			AW_PID_2049_ISCAL_FACTOR * icalk / vcalk * vcalb_adj;
+
+		dev_dbg(aw_dev->dev, "vcalk_dac_factor=%d, vscal_dac_factor=%d, icalk=%d, vcalk=%d",
+				AW_PID_2049_VCABLK_FACTOR_DAC,
+				AW_PID_2049_VSCAL_FACTOR_DAC, icalk, vcalk);
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupport vsense status");
+		return -EINVAL;
+	}
+
+	if ((vcalk == 0) || (AW_PID_2049_ISCAL_FACTOR == 0)) {
+		dev_err(aw_dev->dev, "vcalk:%d or desc->iscal_factor:%d unsupported",
+			vcalk, AW_PID_2049_ISCAL_FACTOR);
+		return -EINVAL;
+	}
+
+	vcalb = vcalb >> AW_PID_2049_VCALB_ADJ_FACTOR;
+	reg_val = (u32)vcalb;
+
+	dev_dbg(aw_dev->dev, "vcalb=%d, reg_val=0x%x, vcalb_adj =0x%x",
+				vcalb, reg_val, vcalb_adj);
+
+	ret = aw_dev_dsp_write(aw_dev, AW_PID_2049_DSP_REG_VCALB, reg_val, AW_DSP_16_DATA);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "write vcalb failed");
+		return ret;
+	}
+
+	ret = aw_dev_modify_dsp_cfg(aw_dev, AW_PID_2049_DSP_REG_VCALB,
+					(u32)reg_val, AW_DSP_16_DATA);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "modify dsp cfg failed");
+
+	return ret;
+}
+
+static int aw_dev_get_cali_f0_delay(struct aw_device *aw_dev)
+{
+	struct aw_cali_delay_desc *desc = &aw_dev->cali_delay_desc;
+	u32 cali_delay = 0;
+	int ret = 0;
+
+	ret = aw_dev_dsp_read(aw_dev,
+			AW_PID_2049_DSP_CALI_F0_DELAY, &cali_delay, AW_DSP_16_DATA);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "read cali delay failed, ret=%d", ret);
+	else
+		desc->delay = AW_CALI_DELAY_CACL(cali_delay);
+
+	dev_dbg(aw_dev->dev, "read cali delay: %d ms", desc->delay);
+
+	return ret;
+}
+
+static void aw_dev_get_int_status(struct aw_device *aw_dev, unsigned short *int_status)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_SYSINT_REG, &reg_val);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "read interrupt reg fail, ret=%d", ret);
+	else
+		*int_status = reg_val;
+
+	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", *int_status);
+}
+
+static void aw_dev_clear_int_status(struct aw_device *aw_dev)
+{
+	u16 int_status = 0;
+
+	/*read int status and clear*/
+	aw_dev_get_int_status(aw_dev, &int_status);
+	/*make sure int status is clear*/
+	aw_dev_get_int_status(aw_dev, &int_status);
+	if (int_status)
+		dev_info(aw_dev->dev, "int status(%d) is not cleaned.\n", int_status);
+}
+
+static int aw_dev_get_iis_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val = 0;
+
+	regmap_read(aw_dev->regmap, AW_PID_2049_SYSST_REG, &reg_val);
+	if ((reg_val & AW_PID_2049_BIT_PLL_CHECK) != AW_PID_2049_BIT_PLL_CHECK) {
+		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_check_mode1_pll(struct aw_device *aw_dev)
+{
+	u16 i = 0;
+	int ret;
+
+	for (i = 0; i < AW_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw_dev_get_iis_status(aw_dev);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
+{
+	int ret = 0;
+	u16 i = 0;
+	unsigned int reg_val = 0;
+
+	regmap_read(aw_dev->regmap, AW_PID_2049_PLLCTRL1_REG, &reg_val);
+	reg_val &= (~AW_PID_2049_CCO_MUX_MASK);
+	if (reg_val == AW_PID_2049_CCO_MUX_DIVIDED_VALUE) {
+		dev_dbg(aw_dev->dev, "CCO_MUX is already divider");
+		return -EPERM;
+	}
+
+	/* change mode2 */
+	regmap_update_bits(aw_dev->regmap, AW_PID_2049_PLLCTRL1_REG,
+		~AW_PID_2049_CCO_MUX_MASK, AW_PID_2049_CCO_MUX_DIVIDED_VALUE);
+
+	for (i = 0; i < AW_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw_dev_get_iis_status(aw_dev);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "mode2 iis signal check error");
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	/* change mode1*/
+	regmap_update_bits(aw_dev->regmap, AW_PID_2049_PLLCTRL1_REG,
+		~AW_PID_2049_CCO_MUX_MASK, AW_PID_2049_CCO_MUX_BYPASS_VALUE);
+
+	if (ret == 0) {
+		usleep_range(AW_2000_US, AW_2000_US + 10);
+		for (i = 0; i < AW_DEV_SYSST_CHECK_MAX; i++) {
+			ret = aw_dev_check_mode1_pll(aw_dev);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
+				usleep_range(AW_2000_US, AW_2000_US + 10);
+			} else {
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int aw_dev_check_syspll(struct aw_device *aw_dev)
+{
+	int ret = 0;
+
+	ret = aw_dev_check_mode1_pll(aw_dev);
+	if (ret < 0) {
+		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
+		ret = aw_dev_check_mode2_pll(aw_dev);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "mode2 check iis failed");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int aw_dev_check_sysst(struct aw_device *aw_dev)
+{
+	unsigned char i;
+	unsigned int reg_val = 0;
+	unsigned int check_val = 0;
+
+
+	for (i = 0; i < AW_DEV_SYSST_CHECK_MAX; i++) {
+		regmap_read(aw_dev->regmap, AW_PID_2049_SYSST_REG, &reg_val);
+		check_val = reg_val & (~AW_PID_2049_BIT_SYSST_CHECK_MASK)
+							& AW_PID_2049_BIT_SYSST_CHECK;
+		if (((reg_val & (~AW_PID_2049_BIT_SYSST_CHECK_MASK))
+					& AW_PID_2049_BIT_SYSST_CHECK)
+					!= AW_PID_2049_BIT_SYSST_CHECK) {
+			dev_dbg(aw_dev->dev, "check sysst fail, cnt=%d, reg_val=0x%04x, check:0x%x",
+				i, reg_val, check_val);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	dev_err(aw_dev->dev, "check sysst fail");
+
+	return -EPERM;
+}
+
+static int aw_dev_check_sysint(struct aw_device *aw_dev)
+{
+	u16 reg_val = 0;
+
+	aw_dev_get_int_status(aw_dev, &reg_val);
+
+	if (reg_val & AW_PID_2049_BIT_SYSINT_CHECK) {
+		dev_err(aw_dev->dev, "pa stop check fail:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void aw_dev_get_cur_mode_st(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	struct aw_profctrl_desc *profctrl_desc = &aw_dev->profctrl_desc;
+
+	regmap_read(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG, &reg_val);
+	if ((reg_val & (~AW_PID_2049_RCV_MODE_MASK)) == AW_PID_2049_RCV_MODE_RECEIVER_VALUE)
+		profctrl_desc->cur_mode = AW_RCV_MODE;
+	else
+		profctrl_desc->cur_mode = AW_NOT_RCV_MODE;
+}
+
+static void aw_dev_get_dsp_config(struct aw_device *aw_dev, unsigned char *dsp_cfg)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+
+	ret = regmap_read(aw_dev->regmap, AW_PID_2049_SYSCTRL_REG, &reg_val);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "reg read failed");
+		return;
+	}
+
+	if (reg_val & (~AW_PID_2049_DSPBY_MASK))
+		*dsp_cfg = AW_DEV_DSP_BYPASS;
+	else
+		*dsp_cfg = AW_DEV_DSP_WORK;
+}
+
+static void aw_dev_select_memclk(struct aw_device *aw_dev, unsigned char flag)
+{
+	int ret = 0;
+
+	switch (flag) {
+	case AW_DEV_MEMCLK_PLL:
+		ret = regmap_update_bits(aw_dev->regmap, AW_PID_2049_DBGCTRL_REG,
+					~AW_PID_2049_MEM_CLKSEL_MASK,
+					AW_PID_2049_MEM_CLKSEL_DAP_HCLK_VALUE);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "memclk select pll failed");
+		break;
+	case AW_DEV_MEMCLK_OSC:
+		ret = regmap_update_bits(aw_dev->regmap, AW_PID_2049_DBGCTRL_REG,
+					~AW_PID_2049_MEM_CLKSEL_MASK,
+					AW_PID_2049_MEM_CLKSEL_OSC_CLK_VALUE);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "memclk select OSC failed");
+		break;
+	default:
+		dev_err(aw_dev->dev, "unknown memclk config, flag=0x%x", flag);
+		break;
+	}
+}
+
+static int aw_dev_get_dsp_status(struct aw_device *aw_dev)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+
+	regmap_read(aw_dev->regmap, AW_PID_2049_WDT_REG, &reg_val);
+	if (reg_val & (~AW_PID_2049_WDT_CNT_MASK))
+		ret = 0;
+
+	return ret;
+}
+
+static int aw_dev_get_vmax(struct aw_device *aw_dev, unsigned int *vmax)
+{
+	int ret = 0;
+
+	ret = aw_dev_dsp_read(aw_dev, AW_PID_2049_DSP_REG_VMAX, vmax, AW_DSP_16_DATA);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "get vmax failed");
+
+	return ret;
+}
+
+static int aw_dev_update_reg_container(struct aw_device *aw_dev,
+				unsigned char *data, unsigned int len)
+{
+	int i, ret;
+	u8 reg_addr = 0;
+	u16 reg_val = 0;
+	unsigned int read_val = 0;
+	u16 read_vol = 0;
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	int16_t *reg_data = NULL;
+	int data_len;
+
+	reg_data = (int16_t *)data;
+	data_len = len >> 1;
+
+	if (data_len & 0x1) {
+		dev_err(aw_dev->dev, "data len:%d unsupported",	data_len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data_len; i += 2) {
+		reg_addr = reg_data[i];
+		reg_val = reg_data[i + 1];
+
+		if (reg_addr == AW_PID_2049_SYSCTRL_REG) {
+			regmap_read(aw_dev->regmap, reg_addr, &read_val);
+			read_val &= (~AW_PID_2049_HMUTE_MASK);
+			reg_val &= AW_PID_2049_HMUTE_MASK;
+			reg_val |= read_val;
+		}
+		if (reg_addr == AW_PID_2049_HAGCCFG7_REG)
+			reg_val &= AW_PID_2049_AGC_DSP_CTL_MASK;
+
+		if (reg_addr == AW_PID_2049_I2SCFG1_REG) {
+			/*close tx*/
+			reg_val &= AW_PID_2049_I2STXEN_MASK;
+			reg_val |= AW_PID_2049_I2STXEN_DISABLE_VALUE;
+		}
+
+		if (reg_addr == AW_PID_2049_SYSCTRL2_REG) {
+			read_vol = (reg_val & (~AW_PID_2049_VOL_MASK)) >>
+				AW_PID_2049_VOL_START_BIT;
+			aw_dev->volume_desc.init_volume =
+				reg_val_to_db(read_vol);
+		}
+		ret = regmap_write(aw_dev->regmap, reg_addr, reg_val);
+		if (ret < 0)
+			break;
+
+	}
+
+	aw_dev_get_cur_mode_st(aw_dev);
+
+	if (aw_dev->prof_cur != aw_dev->prof_index) {
+		/*clear control volume when PA change profile*/
+		vol_desc->ctl_volume = 0;
+	} else {
+		/*keep control volume when PA start with sync mode*/
+		aw_dev_set_volume(aw_dev, vol_desc->ctl_volume);
+	}
+
+	/*keep min volume*/
+	if (aw_dev->fade_en)
+		aw_dev_set_volume(aw_dev, AW_PID_2049_MUTE_VOL);
+
+	aw_dev_get_dsp_config(aw_dev, &aw_dev->dsp_cfg);
+
+	return ret;
+}
+
+static int aw_dev_reg_update(struct aw_device *aw_dev,
+					unsigned char *data, unsigned int len)
+{
+	int ret = 0;
+
+	if (len && (data != NULL)) {
+		ret = aw_dev_update_reg_container(aw_dev, data, len);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "reg update failed");
+			return ret;
+		}
+	} else {
+		dev_err(aw_dev->dev, "reg data is null or len is 0");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
+{
+	int ret;
+	u32 dsp_ra;
+	struct aw_device *aw_dev =
+		container_of(cali_desc, struct aw_device, cali_desc);
+
+	ret = aw_dev_dsp_read(aw_dev, AW_PID_2049_DSP_REG_CFG_ADPZ_RA,
+				&dsp_ra, AW_DSP_32_DATA);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "read ra error");
+		return ret;
+	}
+
+	cali_desc->ra = AW_DSP_RE_TO_SHOW_RE(dsp_ra,
+					AW_PID_2049_DSP_RE_SHIFT);
+	dev_dbg(aw_dev->dev, "get ra:%d", cali_desc->ra);
+	return 0;
+}
+
+static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len, unsigned short base)
+{
+	int i;
+#ifdef AW_DSP_I2C_WRITES
+	u32 tmp_len = 0;
+#else
+	u16 reg_val = 0;
+#endif
+
+	mutex_lock(&aw_dev->dsp_lock);
+#ifdef AW_DSP_I2C_WRITES
+	/* i2c writes */
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, base);
+
+	for (i = 0; i < len; i += AW_MAX_RAM_WRITE_BYTE_SIZE) {
+		if ((len - i) < AW_MAX_RAM_WRITE_BYTE_SIZE)
+			tmp_len = len - i;
+		else
+			tmp_len = AW_MAX_RAM_WRITE_BYTE_SIZE;
+		regmap_raw_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG,
+					&data[i], tmp_len);
+	}
+
+#else
+	/* i2c write */
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, base);
+	for (i = 0; i < len; i += 2) {
+		reg_val = (data[i] << 8) + data[i + 1];
+		regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG,
+					reg_val);
+	}
+#endif
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return 0;
+}
+
+static int aw_dev_dsp_update_fw(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len)
+{
+
+	dev_dbg(aw_dev->dev, "dsp firmware len:%d", len);
+
+	if (len && (data != NULL)) {
+		aw_dev_dsp_update_container(aw_dev,
+			data, len, AW_PID_2049_DSP_FW_ADDR);
+		aw_dev->dsp_fw_len = len;
+	} else {
+		dev_err(aw_dev->dev, "dsp firmware data is null or len is 0");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_copy_to_crc_dsp_cfg(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int size)
+{
+	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
+
+	if (!crc_dsp_cfg->data) {
+		crc_dsp_cfg->data = devm_kzalloc(aw_dev->dev, size, GFP_KERNEL);
+		if (!crc_dsp_cfg->data)
+			return -ENOMEM;
+		crc_dsp_cfg->len = size;
+	} else if (crc_dsp_cfg->len < size) {
+		devm_kfree(aw_dev->dev, crc_dsp_cfg->data);
+		crc_dsp_cfg->data = devm_kzalloc(aw_dev->dev, size, GFP_KERNEL);
+		if (!crc_dsp_cfg->data) {
+			dev_err(aw_dev->dev, "error allocating memory");
+			return -ENOMEM;
+		}
+		crc_dsp_cfg->len = size;
+	}
+	memcpy(crc_dsp_cfg->data, data, size);
+	swab16_array((u16 *)crc_dsp_cfg->data, size >> 1);
+
+	return 0;
+}
+
+static int aw_dev_dsp_update_cfg(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len)
+{
+	int ret;
+
+	dev_dbg(aw_dev->dev, "dsp config len:%d", len);
+
+	if (len && (data != NULL)) {
+		aw_dev_dsp_update_container(aw_dev,
+			data, len, AW_PID_2049_DSP_CFG_ADDR);
+		aw_dev->dsp_cfg_len = len;
+
+		ret = aw_dev_copy_to_crc_dsp_cfg(aw_dev, data, len);
+		if (ret < 0)
+			return ret;
+
+		ret = aw_dev_set_vcalb(aw_dev);
+		if (ret < 0)
+			return ret;
+		ret = aw_dev_get_ra(&aw_dev->cali_desc);
+		if (ret < 0)
+			return ret;
+		ret = aw_dev_get_cali_f0_delay(aw_dev);
+		if (ret < 0)
+			return ret;
+
+		ret = aw_dev_get_vmax(aw_dev, &aw_dev->vmax_desc.init_vmax);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "get vmax failed");
+			return ret;
+		}
+		dev_dbg(aw_dev->dev, "get init vmax:0x%x",
+						aw_dev->vmax_desc.init_vmax);
+		aw_dev->dsp_crc_st = AW_DSP_CRC_NA;
+	} else {
+		dev_err(aw_dev->dev, "dsp config data is null or len is 0");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_check_sram(struct aw_device *aw_dev)
+{
+	unsigned int reg_val = 0;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	/*check the odd bits of reg 0x40*/
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG,
+					AW_DSP_ODD_NUM_BIT_TEST);
+	regmap_read(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, &reg_val);
+	if (reg_val != AW_DSP_ODD_NUM_BIT_TEST) {
+		dev_err(aw_dev->dev, "check reg 0x40 odd bit failed, read[0x%x] != write[0x%x]",
+				reg_val, AW_DSP_ODD_NUM_BIT_TEST);
+		goto error;
+	}
+
+	/*check the even bits of reg 0x40*/
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG,
+					AW_DSP_EVEN_NUM_BIT_TEST);
+	regmap_read(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, &reg_val);
+	if (reg_val != AW_DSP_EVEN_NUM_BIT_TEST) {
+		dev_err(aw_dev->dev, "check reg 0x40 even bit failed, read[0x%x] != write[0x%x]",
+				reg_val, AW_DSP_EVEN_NUM_BIT_TEST);
+		goto error;
+	}
+
+	/*check dsp_fw_base_addr*/
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG,
+					AW_PID_2049_DSP_FW_ADDR);
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG,
+					AW_DSP_EVEN_NUM_BIT_TEST);
+
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG,
+					AW_PID_2049_DSP_FW_ADDR);
+	regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &reg_val);
+	if (reg_val != AW_DSP_EVEN_NUM_BIT_TEST) {
+		dev_err(aw_dev->dev, "check dsp fw addr failed, read[0x%x] != write[0x%x]",
+						reg_val, AW_DSP_EVEN_NUM_BIT_TEST);
+		goto error;
+	}
+
+	/*check dsp_cfg_base_addr*/
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, AW_PID_2049_DSP_CFG_ADDR);
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, AW_DSP_ODD_NUM_BIT_TEST);
+
+	regmap_write(aw_dev->regmap, AW_PID_2049_DSPMADD_REG, AW_PID_2049_DSP_CFG_ADDR);
+	regmap_read(aw_dev->regmap, AW_PID_2049_DSPMDAT_REG, &reg_val);
+	if (reg_val != AW_DSP_ODD_NUM_BIT_TEST) {
+		dev_err(aw_dev->dev, "check dsp cfg failed, read[0x%x] != write[0x%x]",
+						reg_val, AW_DSP_ODD_NUM_BIT_TEST);
+		goto error;
+	}
+
+	mutex_unlock(&aw_dev->dsp_lock);
+	return 0;
+
+error:
+	mutex_unlock(&aw_dev->dsp_lock);
+	return -EPERM;
+}
+
+int aw883xx_dev_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool force_up_en)
+{
+	int ret = 0;
+	struct aw_prof_desc *prof_index_desc = NULL;
+	struct aw_sec_data_desc *sec_desc = NULL;
+	char *prof_name = NULL;
+
+	if ((aw_dev->prof_cur == aw_dev->prof_index) &&
+			(force_up_en == AW_FORCE_UPDATE_OFF)) {
+		dev_dbg(aw_dev->dev, "scene no change, not update");
+		return 0;
+	}
+
+	if (aw_dev->fw_status == AW_DEV_FW_FAILED) {
+		dev_err(aw_dev->dev, "fw status[%d] error", aw_dev->fw_status);
+		return -EPERM;
+	}
+
+	prof_name = aw883xx_dev_get_prof_name(aw_dev, aw_dev->prof_index);
+	if (!prof_name)
+		return -ENOMEM;
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw883xx_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	if (ret < 0)
+		return ret;
+
+	/*update reg*/
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw_dev_reg_update(aw_dev, sec_desc[AW_DATA_TYPE_REG].data,
+					sec_desc[AW_DATA_TYPE_REG].len);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "update reg failed");
+		return ret;
+	}
+
+	aw883xx_dev_mute(aw_dev, true);
+
+	if (aw_dev->dsp_cfg == AW_DEV_DSP_WORK)
+		aw_dev_dsp_enable(aw_dev, false);
+
+	aw_dev_select_memclk(aw_dev, AW_DEV_MEMCLK_OSC);
+
+	if (up_dsp_fw_en) {
+		ret = aw_dev_check_sram(aw_dev);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "check sram failed");
+			goto error;
+		}
+
+		/*update dsp firmware*/
+		dev_dbg(aw_dev->dev, "fw_ver: [%x]", prof_index_desc->fw_ver);
+		ret = aw_dev_dsp_update_fw(aw_dev, sec_desc[AW_DATA_TYPE_DSP_FW].data,
+					sec_desc[AW_DATA_TYPE_DSP_FW].len);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "update dsp fw failed");
+			goto error;
+		}
+	}
+
+	/*update dsp config*/
+	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW_DATA_TYPE_DSP_CFG].data,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].len);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "update dsp cfg failed");
+		goto error;
+	}
+
+	aw_dev_select_memclk(aw_dev, AW_DEV_MEMCLK_PLL);
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return 0;
+
+error:
+	aw_dev_select_memclk(aw_dev, AW_DEV_MEMCLK_PLL);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_fw_update);
+
+static int aw_dev_dsp_check(struct aw_device *aw_dev)
+{
+	int ret = 0;
+	u16 i = 0;
+
+	switch (aw_dev->dsp_cfg) {
+	case AW_DEV_DSP_BYPASS:
+		dev_dbg(aw_dev->dev, "dsp bypass");
+		ret = 0;
+		break;
+	case AW_DEV_DSP_WORK:
+		aw_dev_dsp_enable(aw_dev, false);
+		aw_dev_dsp_enable(aw_dev, true);
+		usleep_range(AW_1000_US, AW_1000_US + 10);
+		for (i = 0; i < AW_DEV_DSP_CHECK_MAX; i++) {
+			ret = aw_dev_get_dsp_status(aw_dev);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
+				usleep_range(AW_2000_US, AW_2000_US + 10);
+			}
+		}
+		break;
+	default:
+		dev_err(aw_dev->dev, "unknown dsp cfg=%d", aw_dev->dsp_cfg);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void aw_dev_dsp_set_cfg_f0_fs(struct aw_device *aw_dev)
+{
+	u32 f0_fs = 0;
+	int ret;
+
+	aw_dev_set_cfg_f0_fs(aw_dev, &f0_fs);
+	ret = aw_dev_modify_dsp_cfg(aw_dev, AW_PID_2049_DSP_REG_CFGF0_FS,
+				f0_fs, AW_DSP_32_DATA);
+	if (ret < 0)
+		dev_err(aw_dev->dev, "modify dsp cfg failed");
+}
+
+static void aw_dev_update_cali_re(struct aw_cali_desc *cali_desc)
+{
+	int ret = 0;
+	struct aw_device *aw_dev =
+		container_of(cali_desc, struct aw_device, cali_desc);
+
+	if ((aw_dev->cali_desc.cali_re < AW_CALI_RE_MAX) &&
+		(aw_dev->cali_desc.cali_re > AW_CALI_RE_MIN)) {
+
+		ret = aw_dev_dsp_set_cali_re(aw_dev);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "set cali re failed");
+	}
+}
+
+int aw883xx_dev_start(struct aw_device *aw_dev)
+{
+	int ret = 0;
+
+	if (aw_dev->status == AW_DEV_PW_ON) {
+		dev_info(aw_dev->dev, "already power on");
+		return 0;
+	}
+
+	/*power on*/
+	aw_dev_pwd(aw_dev, false);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
+
+	ret = aw_dev_check_syspll(aw_dev);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "pll check failed cannot start");
+		goto pll_check_fail;
+	}
+
+	/*amppd on*/
+	aw_dev_amppd(aw_dev, false);
+	usleep_range(AW_1000_US, AW_1000_US + 50);
+
+	/*check i2s status*/
+	ret = aw_dev_check_sysst(aw_dev);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "sysst check failed");
+		goto sysst_check_fail;
+	}
+
+	if (aw_dev->dsp_cfg == AW_DEV_DSP_WORK) {
+		/*dsp bypass*/
+		aw_dev_dsp_enable(aw_dev, false);
+		ret = aw_dev_dsp_fw_check(aw_dev);
+		if (ret < 0)
+			goto dev_dsp_fw_check_fail;
+
+		aw_dev_dsp_set_cfg_f0_fs(aw_dev);
+
+		aw_dev_update_cali_re(&aw_dev->cali_desc);
+
+		if (aw_dev->dsp_crc_st != AW_DSP_CRC_OK) {
+			ret = aw_dev_dsp_check_crc32(aw_dev);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "dsp crc check failed");
+				goto crc_check_fail;
+			}
+		}
+
+		ret = aw_dev_dsp_check(aw_dev);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "dsp status check failed");
+			goto dsp_check_fail;
+		}
+	} else {
+		dev_dbg(aw_dev->dev, "start pa with dsp bypass");
+	}
+
+	/*enable tx feedback*/
+	aw_dev_i2s_tx_enable(aw_dev, true);
+
+	/*close mute*/
+	aw883xx_dev_mute(aw_dev, false);
+	/*clear inturrupt*/
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW_DEV_PW_ON;
+
+	return 0;
+
+dsp_check_fail:
+crc_check_fail:
+	aw_dev_dsp_enable(aw_dev, false);
+dev_dsp_fw_check_fail:
+sysst_check_fail:
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev_amppd(aw_dev, true);
+pll_check_fail:
+	aw_dev_pwd(aw_dev, true);
+	aw_dev->status = AW_DEV_PW_OFF;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_start);
+
+int aw883xx_dev_stop(struct aw_device *aw_dev)
+{
+	struct aw_sec_data_desc *dsp_cfg =
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_CFG];
+	struct aw_sec_data_desc *dsp_fw =
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_FW];
+	int int_st = 0;
+	int ret = 0;
+
+	if (aw_dev->status == AW_DEV_PW_OFF) {
+		dev_info(aw_dev->dev, "already power off");
+		return 0;
+	}
+
+	aw_dev->status = AW_DEV_PW_OFF;
+
+	/*set mute*/
+	aw883xx_dev_mute(aw_dev, true);
+	usleep_range(AW_4000_US, AW_4000_US + 100);
+
+	/*close tx feedback*/
+	aw_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
+
+	/*check sysint state*/
+	int_st = aw_dev_check_sysint(aw_dev);
+
+	/*close dsp*/
+	aw_dev_dsp_enable(aw_dev, false);
+
+	/*enable amppd*/
+	aw_dev_amppd(aw_dev, true);
+
+	if (int_st < 0) {
+		/*system status anomaly*/
+		aw_dev_select_memclk(aw_dev, AW_DEV_MEMCLK_OSC);
+		ret = aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "update dsp fw failed");
+		ret = aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len);
+		if (ret < 0)
+			dev_err(aw_dev->dev, "update dsp cfg failed");
+		aw_dev_select_memclk(aw_dev, AW_DEV_MEMCLK_PLL);
+	}
+
+	/*set power down*/
+	aw_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_stop);
+
+/*deinit aw_device*/
+static void aw883xx_dev_deinit(struct aw_device *aw_dev)
+{
+	if (!aw_dev)
+		return;
+
+	if (aw_dev->prof_info.prof_desc) {
+		devm_kfree(aw_dev->dev, aw_dev->prof_info.prof_desc);
+		aw_dev->prof_info.prof_desc = NULL;
+	}
+	aw_dev->prof_info.count = 0;
+
+	if (aw_dev->crc_dsp_cfg.data) {
+		aw_dev->crc_dsp_cfg.len = 0;
+		devm_kfree(aw_dev->dev, aw_dev->crc_dsp_cfg.data);
+		aw_dev->crc_dsp_cfg.data = NULL;
+	}
+
+}
+
+/*init aw_device*/
+int aw883xx_dev_init(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+{
+	int ret;
+
+	if ((!aw_dev) || (!aw_cfg)) {
+		pr_err("aw_dev is NULL or aw_cfg is NULL");
+		return -ENOMEM;
+	}
+	ret = aw883xx_dev_cfg_load(aw_dev, aw_cfg);
+	if (ret < 0) {
+		aw883xx_dev_deinit(aw_dev);
+		dev_err(aw_dev->dev, "aw_dev acf parse failed");
+		return -EINVAL;
+	}
+	aw_dev->fade_in_time = AW_1000_US / 10;
+	aw_dev->fade_out_time = AW_1000_US >> 1;
+	aw_dev->prof_cur = aw_dev->prof_info.prof_desc[0].id;
+	aw_dev->prof_index = aw_dev->prof_info.prof_desc[0].id;
+
+	ret = aw883xx_dev_fw_update(aw_dev, AW_FORCE_UPDATE_ON,	AW_DSP_FW_UPDATE_ON);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "fw update failed");
+		return ret;
+	}
+
+	/*set mute*/
+	aw883xx_dev_mute(aw_dev, true);
+	usleep_range(AW_4000_US, AW_4000_US + 100);
+
+	/*close tx feedback*/
+	aw_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
+
+	/*close dsp*/
+	aw_dev_dsp_enable(aw_dev, false);
+	/*enable amppd*/
+	aw_dev_amppd(aw_dev, true);
+	/*set power down*/
+	aw_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_init);
+
+static void aw883xx_parse_channel_dt(struct aw_device *aw_dev)
+{
+	int ret;
+	u32 channel_value;
+	struct device_node *np = aw_dev->dev->of_node;
+
+	ret = of_property_read_u32(np, "sound-channel", &channel_value);
+	if (ret < 0) {
+		dev_dbg(aw_dev->dev,
+			"read sound-channel failed,use default 0");
+		aw_dev->channel = AW_DEV_DEFAULT_CH;
+		return;
+	}
+
+	dev_dbg(aw_dev->dev, "read sound-channel value is: %d",
+			channel_value);
+	aw_dev->channel = channel_value;
+}
+
+static void aw883xx_parse_fade_enable_dt(struct aw_device *aw_dev)
+{
+	int ret = 0;
+	struct device_node *np = aw_dev->dev->of_node;
+	u32 fade_en;
+
+	ret = of_property_read_u32(np, "fade-enable", &fade_en);
+	if (ret < 0) {
+		dev_dbg(aw_dev->dev,
+			"read fade-enable failed, close fade_in_out");
+		fade_en = AW_FADE_IN_OUT_DEFAULT;
+	}
+
+	dev_dbg(aw_dev->dev, "read fade-enable value is: %d", fade_en);
+
+	aw_dev->fade_en = fade_en;
+}
+
+static int aw883xx_pid_2049_dev_init(struct aw_device *aw_dev)
+{
+	aw_dev->chip_id = AW883XX_PID_2049;
+	/*call aw device init func*/
+	aw_dev->acf = NULL;
+	aw_dev->prof_info.prof_desc = NULL;
+	aw_dev->prof_info.count = 0;
+	aw_dev->prof_info.prof_type = AW_DEV_NONE_TYPE_ID;
+	aw_dev->channel = 0;
+	aw_dev->fw_status = AW_DEV_FW_FAILED;
+
+	aw_dev->fade_step = AW_PID_2049_VOLUME_STEP_DB;
+	aw_dev->volume_desc.ctl_volume = AW_PID_2049_VOL_DEFAULT_VALUE;
+	aw883xx_parse_channel_dt(aw_dev);
+	aw883xx_parse_fade_enable_dt(aw_dev);
+
+	return 0;
+}
+
+int aw883xx_dev_get_profile_count(struct aw_device *aw_dev)
+{
+	return aw_dev->prof_info.count;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_get_profile_count);
+
+int aw883xx_dev_get_profile_index(struct aw_device *aw_dev)
+{
+	return aw_dev->prof_index;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_get_profile_index);
+
+int aw883xx_dev_set_profile_index(struct aw_device *aw_dev, int index)
+{
+	struct aw_prof_desc *prof_desc = NULL;
+
+	/* check the index whether is valid. */
+	if ((index >= aw_dev->prof_info.count) || (index < 0))
+		return -EINVAL;
+	/* check the index whether change. */
+	if (aw_dev->prof_index == index)
+		return -EINVAL;
+
+	aw_dev->prof_index = index;
+	prof_desc = &aw_dev->prof_info.prof_desc[index];
+	dev_dbg(aw_dev->dev, "set prof[%s]", aw_dev->prof_info.prof_name_list[prof_desc->id]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_set_profile_index);
+
+char *aw883xx_dev_get_prof_name(struct aw_device *aw_dev, int index)
+{
+	struct aw_prof_desc *prof_desc = NULL;
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
+			index, aw_dev->prof_info.count);
+		return NULL;
+	}
+
+	prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	return prof_info->prof_name_list[prof_desc->id];
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_get_prof_name);
+
+int aw883xx_dev_get_prof_data(struct aw_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc)
+{
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
+				__func__, index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_get_prof_data);
+
+int aw883xx_init(struct aw_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap)
+{
+	int ret = 0;
+	u16 chip_id = 0;
+
+	if (*aw_dev) {
+		dev_info(&i2c->dev, "it should be initialized here.\n");
+	} else {
+		*aw_dev = kzalloc(sizeof(struct aw_device), GFP_KERNEL);
+		if (!(*aw_dev))
+			return -ENOMEM;
+	}
+
+	(*aw_dev)->i2c = i2c;
+	(*aw_dev)->dev = &i2c->dev;
+	(*aw_dev)->regmap = regmap;
+	mutex_init(&(*aw_dev)->dsp_lock);
+
+	/* read chip id */
+	ret = aw_dev_read_chipid((*aw_dev), &chip_id);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "dev_read_chipid failed ret=%d", ret);
+		return ret;
+	}
+
+	switch (chip_id) {
+	case AW883XX_PID_2049:
+		ret = aw883xx_pid_2049_dev_init((*aw_dev));
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err((*aw_dev)->dev, "unsupported device");
+		break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw883xx_init);
+
+void aw883xx_deinit(struct aw_device *aw_dev)
+{
+	if (aw_dev) {
+		aw883xx_dev_deinit(aw_dev);
+		kfree(aw_dev);
+	}
+}
+EXPORT_SYMBOL_GPL(aw883xx_deinit);
+
+MODULE_DESCRIPTION("AW883XX device lib");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw883xx/aw883xx_device.h b/sound/soc/codecs/aw883xx/aw883xx_device.h
new file mode 100644
index 000000000000..d3a654e15815
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx_device.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * aw883xx.c --  ALSA SoC AW883XX codec support
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ */
+
+#ifndef __AW883XX_DEVICE_FILE_H__
+#define __AW883XX_DEVICE_FILE_H__
+
+#include "aw883xx_data_type.h"
+#include "aw883xx_bin_parse.h"
+#include "aw883xx.h"
+
+#define AW_DEV_DEFAULT_CH				(0)
+#define AW_DEV_DSP_CHECK_MAX			(5)
+
+/*
+ * DSP I2C WRITES
+ */
+#define AW_DSP_I2C_WRITES
+#define AW_MAX_RAM_WRITE_BYTE_SIZE		(128)
+#define AW_DSP_ODD_NUM_BIT_TEST			(0x5555)
+#define AW_DSP_EVEN_NUM_BIT_TEST		(0xAAAA)
+#define AW_DSP_ST_CHECK_MAX				(2)
+#define AW_FADE_IN_OUT_DEFAULT			(0)
+#define AW_CALI_RE_MAX					(15000)
+#define AW_CALI_RE_MIN					(4000)
+#define AW_CALI_DELAY_CACL(value)		((value * 32) / 48)
+
+#define AW_DSP_RE_TO_SHOW_RE(re, shift) (((re) * (1000)) >> (shift))
+#define AW_SHOW_RE_TO_DSP_RE(re, shift) (((re) << shift) / (1000))
+
+#define AW_ACF_FILE						"aw883xx_acf.bin"
+#define AW_DEV_SYSST_CHECK_MAX			(10)
+
+enum {
+	AW_DEV_VDSEL_DAC = 0,
+	AW_DEV_VDSEL_VSENSE = 1,
+};
+
+enum {
+	AW_DSP_CRC_NA = 0,
+	AW_DSP_CRC_OK = 1,
+};
+
+enum {
+	AW_DSP_FW_UPDATE_OFF = 0,
+	AW_DSP_FW_UPDATE_ON = 1,
+};
+
+enum {
+	AW_FORCE_UPDATE_OFF = 0,
+	AW_FORCE_UPDATE_ON = 1,
+};
+
+enum {
+	AW_1000_US = 1000,
+	AW_2000_US = 2000,
+	AW_3000_US = 3000,
+	AW_4000_US = 4000,
+	AW_5000_US = 5000,
+	AW_10000_US = 10000,
+	AW_100000_US = 100000,
+};
+
+enum {
+	AW_DEV_TYPE_OK = 0,
+	AW_DEV_TYPE_NONE = 1,
+};
+
+
+enum AW_DEV_STATUS {
+	AW_DEV_PW_OFF = 0,
+	AW_DEV_PW_ON,
+};
+
+enum AW_DEV_FW_STATUS {
+	AW_DEV_FW_FAILED = 0,
+	AW_DEV_FW_OK,
+};
+
+enum AW_DEV_MEMCLK {
+	AW_DEV_MEMCLK_OSC = 0,
+	AW_DEV_MEMCLK_PLL = 1,
+};
+
+enum AW_DEV_DSP_CFG {
+	AW_DEV_DSP_WORK = 0,
+	AW_DEV_DSP_BYPASS = 1,
+};
+
+enum {
+	AW_DSP_16_DATA = 0,
+	AW_DSP_32_DATA = 1,
+};
+
+enum {
+	AW_NOT_RCV_MODE = 0,
+	AW_RCV_MODE = 1,
+};
+
+struct aw_profctrl_desc {
+	unsigned int cur_mode;
+};
+
+struct aw_volume_desc {
+	unsigned int init_volume;
+	unsigned int mute_volume;
+	unsigned int ctl_volume;
+	unsigned int max_volume;
+};
+
+struct aw_dsp_mem_desc {
+	unsigned int dsp_madd_reg;
+	unsigned int dsp_mdat_reg;
+	unsigned int dsp_fw_base_addr;
+	unsigned int dsp_cfg_base_addr;
+};
+
+struct aw_vmax_desc {
+	unsigned int init_vmax;
+};
+
+struct aw_cali_delay_desc {
+	unsigned int delay;
+};
+
+struct aw_cali_desc {
+	u32 cali_re;	/*cali value*/
+	u32 ra;
+};
+
+struct aw_container {
+	int len;
+	u8 data[];
+};
+
+struct aw_device {
+	int status;
+	struct mutex dsp_lock;
+
+	unsigned char prof_cur;		/*current profile index*/
+	unsigned char prof_index;	/*set profile index*/
+	unsigned char dsp_crc_st;
+	u16 chip_id;
+
+	unsigned int channel;		/*pa channel select*/
+	unsigned int fade_step;
+
+	struct i2c_client *i2c;
+	struct device *dev;
+	struct regmap *regmap;
+	char *acf;
+
+	u32 fade_en;
+	unsigned char dsp_cfg;
+
+	u32 dsp_fw_len;
+	u32 dsp_cfg_len;
+	u8 platform;
+	u8 fw_status;	/*load cfg status*/
+
+	unsigned int fade_in_time;
+	unsigned int fade_out_time;
+
+	struct aw_prof_info prof_info;
+	struct aw_sec_data_desc crc_dsp_cfg;
+	struct aw_profctrl_desc profctrl_desc;
+	struct aw_volume_desc volume_desc;
+	struct aw_dsp_mem_desc dsp_mem_desc;
+	struct aw_vmax_desc vmax_desc;
+
+	struct aw_cali_delay_desc cali_delay_desc;
+	struct aw_cali_desc cali_desc;
+
+};
+
+int aw883xx_init(struct aw_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap);
+void aw883xx_deinit(struct aw_device *aw_dev);
+int aw883xx_dev_init(struct aw_device *aw_dev, struct aw_container *aw_cfg);
+int aw883xx_dev_start(struct aw_device *aw_dev);
+int aw883xx_dev_stop(struct aw_device *aw_dev);
+int aw883xx_dev_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool force_up_en);
+
+void aw883xx_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol);
+int aw883xx_dev_get_prof_data(struct aw_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc);
+char *aw883xx_dev_get_prof_name(struct aw_device *aw_dev, int index);
+int aw883xx_dev_set_profile_index(struct aw_device *aw_dev, int index);
+int aw883xx_dev_get_profile_index(struct aw_device *aw_dev);
+int aw883xx_dev_get_profile_count(struct aw_device *aw_dev);
+
+int aw883xx_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg);
+int aw883xx_dev_load_acf_check(struct aw_container *aw_cfg);
+void aw883xx_dev_mute(struct aw_device *aw_dev, bool is_mute);
+
+#endif
+
-- 
2.38.1

