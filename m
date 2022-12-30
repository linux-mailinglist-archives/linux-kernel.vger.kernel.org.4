Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F376596D5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiL3Jf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiL3JfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:35:19 -0500
Received: from out29-103.mail.aliyun.com (out29-103.mail.aliyun.com [115.124.29.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E11A82C;
        Fri, 30 Dec 2022 01:35:16 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712911|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00738935-0.000479261-0.992131;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Qh0QfyA_1672392908;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Qh0QfyA_1672392908)
          by smtp.aliyun-inc.com;
          Fri, 30 Dec 2022 17:35:11 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        povik+lin@cutebit.org, pierre-louis.bossart@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        tanureal@opensource.cirrus.com, steve@sk2.org, stephan@gerhold.net,
        zhuning0077@gmail.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc:     zhaolei@awinic.com, liweilei@awinic.com, yijiangtao@awinic.com,
        duanyibo@awinic.com
Subject: [PATCH V8 2/5] ASoC: codecs: Aw883xx function for ACF file parse and check
Date:   Fri, 30 Dec 2022 17:34:51 +0800
Message-Id: <20221230093454.190579-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230093454.190579-1-wangweidong.a@awinic.com>
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c | 1067 ++++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h |   92 ++
 2 files changed, 1159 insertions(+)
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_bin_parse.h

diff --git a/sound/soc/codecs/aw883xx/aw883xx_bin_parse.c b/sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
new file mode 100644
index 000000000000..771bd87d0eca
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx_bin_parse.c
@@ -0,0 +1,1067 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * aw_bin_parse.c  -- AW883XX function for ACF file parse and check
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ */
+
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/swab.h>
+#include "aw883xx_bin_parse.h"
+#include "aw883xx_device.h"
+
+#define AW_CRC8_POLYNOMIAL 0x8C
+DECLARE_CRC8_TABLE(aw_crc8_table);
+
+static char *profile_name[AW_PROFILE_MAX] = {
+	"Music", "Voice", "Voip", "Ringtone",
+	"Ringtone_hs", "Lowpower", "Bypass",
+	"Mmi", "Fm", "Notification", "Receiver"
+};
+
+static int aw_parse_bin_header(struct aw_device *aw_dev, struct aw_bin *bin);
+
+static int aw_check_sum(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
+{
+	unsigned char *p_check_sum;
+	unsigned int sum_data = 0;
+	unsigned int check_sum;
+	unsigned int i, len;
+
+	p_check_sum = &(bin->info.data[(bin->header_info[bin_num].valid_data_addr -
+						bin->header_info[bin_num].header_len)]);
+	len = bin->header_info[bin_num].bin_data_len + bin->header_info[bin_num].header_len;
+	check_sum = le32_to_cpup((void *)p_check_sum);
+
+	for (i = 4; i < len; i++)
+		sum_data += *(p_check_sum + i);
+
+	dev_dbg(aw_dev->dev, "%s -- check_sum = %p, check_sum = 0x%x, sum_data = 0x%x",
+					__func__, p_check_sum, check_sum, sum_data);
+	if (sum_data != check_sum) {
+		dev_err(aw_dev->dev, "%s. CheckSum Fail.bin_num=%d, CheckSum:0x%x, SumData:0x%x",
+				__func__, bin_num, check_sum, sum_data);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_check_data_version(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
+{
+	if (bin->header_info[bin_num].bin_data_ver < DATA_VERSION_V1 ||
+		bin->header_info[bin_num].bin_data_ver > DATA_VERSION_MAX) {
+		dev_err(aw_dev->dev, "aw_bin_parse Unrecognized this bin data version\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_check_register_num(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
+{
+	struct bin_header_info temp_info = bin->header_info[bin_num];
+	unsigned int check_register_num, parse_register_num;
+	unsigned char *p_check_sum;
+
+	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
+
+	parse_register_num = le32_to_cpup((void *)p_check_sum);
+	check_register_num = (bin->header_info[bin_num].bin_data_len - CHECK_REGISTER_NUM_OFFSET) /
+				(bin->header_info[bin_num].reg_byte_len +
+				bin->header_info[bin_num].data_byte_len);
+	dev_dbg(aw_dev->dev, "%s,parse_register_num = 0x%x,check_register_num = 0x%x\n",
+				__func__, parse_register_num, check_register_num);
+	if (parse_register_num != check_register_num) {
+		dev_err(aw_dev->dev, "%s parse_register_num = 0x%x,check_register_num = 0x%x\n",
+				__func__, parse_register_num, check_register_num);
+
+		return -EINVAL;
+	}
+
+	bin->header_info[bin_num].reg_num = parse_register_num;
+	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - VALID_DATA_LEN;
+	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr + VALID_DATA_ADDR;
+
+	return 0;
+}
+
+static int aw_check_dsp_reg_num(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
+{
+	struct bin_header_info temp_info = bin->header_info[bin_num];
+	unsigned int check_dsp_reg_num, parse_dsp_reg_num;
+	unsigned char *p_check_sum;
+
+	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
+
+	parse_dsp_reg_num = le32_to_cpup((void *)(p_check_sum + PARSE_DSP_REG_NUM));
+	bin->header_info[bin_num].reg_data_byte_len =
+			le32_to_cpup((void *)(p_check_sum + REG_DATA_BYTP_LEN));
+	check_dsp_reg_num = (bin->header_info[bin_num].bin_data_len - CHECK_DSP_REG_NUM) /
+				bin->header_info[bin_num].reg_data_byte_len;
+	dev_dbg(aw_dev->dev, "%s bin_num = %d, parse_dsp_reg_num = 0x%x, check_dsp_reg_num = 0x%x",
+					__func__, bin_num, check_dsp_reg_num, check_dsp_reg_num);
+	if (parse_dsp_reg_num != check_dsp_reg_num) {
+		dev_err(aw_dev->dev, "aw_bin_parse check dsp reg num error\n");
+		dev_err(aw_dev->dev, "%s parse_dsp_reg_num = 0x%x, check_dsp_reg_num = 0x%x",
+					__func__, check_dsp_reg_num, check_dsp_reg_num);
+		return -EINVAL;
+	}
+
+	bin->header_info[bin_num].download_addr = le32_to_cpup((void *)p_check_sum);
+	bin->header_info[bin_num].reg_num = parse_dsp_reg_num;
+	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - DSP_VALID_DATA_LEN;
+	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr +
+								DSP_VALID_DATA_ADDR;
+
+	return 0;
+}
+
+static int aw_check_soc_app_num(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
+{
+	struct bin_header_info temp_info = bin->header_info[bin_num];
+	unsigned int check_soc_app_num, parse_soc_app_num;
+	unsigned char *p_check_sum;
+
+	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
+
+	bin->header_info[bin_num].app_version = le32_to_cpup((void *)p_check_sum);
+	parse_soc_app_num = le32_to_cpup((void *)(p_check_sum + PARSE_SOC_APP_NUM));
+	check_soc_app_num = bin->header_info[bin_num].bin_data_len - CHECK_SOC_APP_NUM;
+	dev_dbg(aw_dev->dev, "%s bin_num = %d, parse_soc_app_num=0x%x, check_soc_app_num = 0x%x\n",
+					__func__, bin_num, parse_soc_app_num, check_soc_app_num);
+	if (parse_soc_app_num != check_soc_app_num) {
+		dev_err(aw_dev->dev, "%s parse_soc_app_num=0x%x, check_soc_app_num = 0x%x\n",
+					__func__, parse_soc_app_num, check_soc_app_num);
+
+		return -EINVAL;
+	}
+
+	bin->header_info[bin_num].reg_num = parse_soc_app_num;
+	bin->header_info[bin_num].download_addr = le32_to_cpup((void *)(p_check_sum +
+								APP_DOWNLOAD_ADDR));
+	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - APP_VALID_DATA_LEN;
+	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr +
+								APP_VALID_DATA_ADDR;
+
+	return 0;
+}
+
+static void aw_get_single_bin_header(struct aw_bin *bin)
+{
+	memcpy((void *)&bin->header_info[bin->all_bin_parse_num], bin->p_addr, DATA_LEN);
+
+	bin->header_info[bin->all_bin_parse_num].header_len = HEADER_LEN;
+	bin->all_bin_parse_num += 1;
+}
+
+static int aw_parse_one_of_multi_bins(struct aw_device *aw_dev, unsigned int bin_num,
+					int bin_serial_num, struct aw_bin *bin)
+{
+	struct bin_header_info aw_bin_header_info;
+	unsigned int bin_start_addr;
+	unsigned int valid_data_len;
+
+	if (bin->info.len < sizeof(struct bin_header_info)) {
+		dev_err(aw_dev->dev, "bin_header_info size[%d] overflow file size[%d]\n",
+				(int)sizeof(struct bin_header_info), bin->info.len);
+		return -EINVAL;
+	}
+
+	aw_bin_header_info = bin->header_info[bin->all_bin_parse_num - 1];
+	if (!bin_serial_num) {
+		bin_start_addr = le32_to_cpup((void *)(bin->p_addr + START_ADDR_OFFSET));
+		bin->p_addr += (HEADER_LEN + bin_start_addr);
+		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
+			aw_bin_header_info.valid_data_addr + VALID_DATA_ADDR + 8 * bin_num +
+			VALID_DATA_ADDR_OFFSET;
+	} else {
+		valid_data_len = aw_bin_header_info.bin_data_len;
+		bin->p_addr += (HDADER_LEN + valid_data_len);
+		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
+		    aw_bin_header_info.valid_data_addr + aw_bin_header_info.bin_data_len +
+		    VALID_DATA_ADDR_OFFSET;
+	}
+
+	return aw_parse_bin_header(aw_dev, bin);
+}
+
+static int aw_get_multi_bin_header(struct aw_device *aw_dev, struct aw_bin *bin)
+{
+	unsigned int bin_num, i;
+	int ret;
+
+	bin_num = le32_to_cpup((void *)(bin->p_addr + VALID_DATA_ADDR_OFFSET));
+	if (bin->multi_bin_parse_num == 1)
+		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
+							VALID_DATA_ADDR_OFFSET;
+
+	aw_get_single_bin_header(bin);
+
+	for (i = 0; i < bin_num; i++) {
+		dev_dbg(aw_dev->dev, "aw_bin_parse enter multi bin for is %d\n", i);
+		ret = aw_parse_one_of_multi_bins(aw_dev, bin_num, i, bin);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int aw_parse_bin_header(struct aw_device *aw_dev, struct aw_bin *bin)
+{
+	unsigned int bin_data_type;
+
+	if (bin->info.len < sizeof(struct bin_header_info)) {
+		dev_err(aw_dev->dev, "bin_header_info size[%d] overflow file size[%d]\n",
+				(int)sizeof(struct bin_header_info), bin->info.len);
+		return -EINVAL;
+	}
+
+	bin_data_type = le32_to_cpup((void *)(bin->p_addr + BIN_DATA_TYPE_OFFSET));
+	dev_dbg(aw_dev->dev, "aw_bin_parse bin_data_type 0x%x\n", bin_data_type);
+	switch (bin_data_type) {
+	case DATA_TYPE_REGISTER:
+	case DATA_TYPE_DSP_REG:
+	case DATA_TYPE_SOC_APP:
+		bin->single_bin_parse_num += 1;
+		dev_dbg(aw_dev->dev, "%s bin->single_bin_parse_num is %d\n", __func__,
+						bin->single_bin_parse_num);
+		if (!bin->multi_bin_parse_num)
+			bin->header_info[bin->all_bin_parse_num].valid_data_addr =
+								VALID_DATA_ADDR_OFFSET;
+		aw_get_single_bin_header(bin);
+		return 0;
+	case DATA_TYPE_MULTI_BINS:
+		bin->multi_bin_parse_num += 1;
+		dev_dbg(aw_dev->dev, "%s bin->multi_bin_parse_num is %d\n", __func__,
+						bin->multi_bin_parse_num);
+		return aw_get_multi_bin_header(aw_dev, bin);
+	default:
+		dev_dbg(aw_dev->dev, "%s There is no corresponding type\n", __func__);
+		return 0;
+	}
+}
+
+static int aw_check_bin_header_version(struct aw_device *aw_dev, struct aw_bin *bin)
+{
+	unsigned int header_version;
+
+	header_version = le32_to_cpup((void *)(bin->p_addr + HEADER_VERSION_OFFSET));
+	dev_dbg(aw_dev->dev, "aw_bin_parse header_version 0x%x\n", header_version);
+
+	switch (header_version) {
+	case HEADER_VERSION_V1:
+		return aw_parse_bin_header(aw_dev, bin);
+	default:
+		dev_err(aw_dev->dev, "aw_bin_parse Unrecognized this bin header version\n");
+		return -EINVAL;
+	}
+}
+
+static int aw_parsing_bin_file(struct aw_device *aw_dev, struct aw_bin *bin)
+{
+	int ret = -EINVAL;
+	int i;
+
+	if (!bin) {
+		dev_err(aw_dev->dev, "aw_bin_parse bin is NULL\n");
+		return ret;
+	}
+	bin->p_addr = bin->info.data;
+	bin->all_bin_parse_num = 0;
+	bin->multi_bin_parse_num = 0;
+	bin->single_bin_parse_num = 0;
+
+	ret = aw_check_bin_header_version(aw_dev, bin);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "aw_bin_parse check bin header version error\n");
+		return ret;
+	}
+
+	for (i = 0; i < bin->all_bin_parse_num; i++) {
+		ret = aw_check_sum(aw_dev, bin, i);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "aw_bin_parse check sum data error\n");
+			return ret;
+		}
+		ret = aw_check_data_version(aw_dev, bin, i);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "aw_bin_parse check data version error\n");
+			return ret;
+		}
+		if (bin->header_info[i].bin_data_ver == DATA_VERSION_V1) {
+			switch (bin->header_info[i].bin_data_type) {
+			case DATA_TYPE_REGISTER:
+				ret = aw_check_register_num(aw_dev, bin, i);
+				break;
+			case DATA_TYPE_DSP_REG:
+				ret = aw_check_dsp_reg_num(aw_dev, bin, i);
+				break;
+			case DATA_TYPE_SOC_APP:
+				ret = aw_check_soc_app_num(aw_dev, bin, i);
+				break;
+			default:
+				bin->header_info[i].valid_data_len =
+						bin->header_info[i].bin_data_len;
+				ret = 0;
+				break;
+			}
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aw_dev_parse_raw_reg(unsigned char *data, unsigned int data_len,
+		struct aw_prof_desc *prof_desc)
+{
+	prof_desc->sec_desc[AW_DATA_TYPE_REG].data = data;
+	prof_desc->sec_desc[AW_DATA_TYPE_REG].len = data_len;
+
+	prof_desc->prof_st = AW_PROFILE_OK;
+
+	return 0;
+}
+
+static int aw_dev_parse_raw_dsp_cfg(unsigned char *data, unsigned int data_len,
+		struct aw_prof_desc *prof_desc)
+{
+	if (data_len & 0x01)
+		return -EINVAL;
+
+	swab16_array((u16 *)data, data_len >> 1);
+
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].data = data;
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].len = data_len;
+
+	prof_desc->prof_st = AW_PROFILE_OK;
+
+	return 0;
+}
+
+static int aw_dev_parse_raw_dsp_fw(unsigned char *data,	unsigned int data_len,
+		struct aw_prof_desc *prof_desc)
+{
+	if (data_len & 0x01)
+		return -EINVAL;
+
+	swab16_array((u16 *)data, data_len >> 1);
+
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].data = data;
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].len = data_len;
+
+	prof_desc->prof_st = AW_PROFILE_OK;
+
+	return 0;
+}
+
+static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *data,
+				unsigned int data_len, struct aw_prof_desc *prof_desc)
+{
+	struct aw_bin *aw_bin;
+	int ret;
+	int i;
+
+	aw_bin = kzalloc(data_len + sizeof(struct aw_bin), GFP_KERNEL);
+	if (!aw_bin)
+		return -ENOMEM;
+
+	aw_bin->info.len = data_len;
+	memcpy(aw_bin->info.data, data, data_len);
+
+	ret = aw_parsing_bin_file(aw_dev, aw_bin);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "parse bin failed");
+		goto parse_bin_failed;
+	}
+
+	for (i = 0; i < aw_bin->all_bin_parse_num; i++) {
+		switch (aw_bin->header_info[i].bin_data_type) {
+		case DATA_TYPE_REGISTER:
+			prof_desc->sec_desc[AW_DATA_TYPE_REG].len =
+					aw_bin->header_info[i].valid_data_len;
+			prof_desc->sec_desc[AW_DATA_TYPE_REG].data =
+					data + aw_bin->header_info[i].valid_data_addr;
+			break;
+		case DATA_TYPE_DSP_REG:
+			if (aw_bin->header_info[i].valid_data_len & 0x01) {
+				ret = -EINVAL;
+				goto parse_bin_failed;
+			}
+
+			swab16_array((u16 *)(data + aw_bin->header_info[i].valid_data_addr),
+					aw_bin->header_info[i].valid_data_len >> 1);
+
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].len =
+					aw_bin->header_info[i].valid_data_len;
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].data =
+					data + aw_bin->header_info[i].valid_data_addr;
+			break;
+		case DATA_TYPE_DSP_FW:
+		case DATA_TYPE_SOC_APP:
+			if (aw_bin->header_info[i].valid_data_len & 0x01) {
+				ret = -EINVAL;
+				goto parse_bin_failed;
+			}
+
+			swab16_array((u16 *)(data + aw_bin->header_info[i].valid_data_addr),
+					aw_bin->header_info[i].valid_data_len >> 1);
+
+			prof_desc->fw_ver = aw_bin->header_info[i].app_version;
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].len =
+					aw_bin->header_info[i].valid_data_len;
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].data =
+					data + aw_bin->header_info[i].valid_data_addr;
+			break;
+		default:
+			dev_dbg(aw_dev->dev, "bin_data_type not found");
+			break;
+		}
+	}
+	prof_desc->prof_st = AW_PROFILE_OK;
+	ret =  0;
+
+parse_bin_failed:
+	kfree(aw_bin);
+	return ret;
+}
+
+static int aw_dev_parse_data_by_sec_type(struct aw_device *aw_dev, struct aw_cfg_hdr *cfg_hdr,
+			struct aw_cfg_dde *cfg_dde, struct aw_prof_desc *scene_prof_desc)
+{
+	switch (cfg_dde->data_type) {
+	case ACF_SEC_TYPE_REG:
+		return aw_dev_parse_raw_reg((u8 *)cfg_hdr + cfg_dde->data_offset,
+				cfg_dde->data_size, scene_prof_desc);
+	case ACF_SEC_TYPE_DSP_CFG:
+		return aw_dev_parse_raw_dsp_cfg((u8 *)cfg_hdr + cfg_dde->data_offset,
+				cfg_dde->data_size, scene_prof_desc);
+	case ACF_SEC_TYPE_DSP_FW:
+		return aw_dev_parse_raw_dsp_fw(
+				(u8 *)cfg_hdr + cfg_dde->data_offset,
+				cfg_dde->data_size, scene_prof_desc);
+	case ACF_SEC_TYPE_MULTIPLE_BIN:
+		return aw_dev_prof_parse_multi_bin(
+				aw_dev, (u8 *)cfg_hdr + cfg_dde->data_offset,
+				cfg_dde->data_size, scene_prof_desc);
+	default:
+		dev_err(aw_dev->dev, "%s cfg_dde->data_type = %d\n", __func__, cfg_dde->data_type);
+		break;
+	}
+	return 0;
+}
+
+static int aw_dev_parse_dev_type(struct aw_device *aw_dev,
+		struct aw_cfg_hdr *prof_hdr, struct aw_all_prof_info *all_prof_info)
+{
+	struct aw_cfg_dde *cfg_dde =
+		(struct aw_cfg_dde *)((char *)prof_hdr + prof_hdr->hdr_offset);
+	int sec_num = 0;
+	int ret, i;
+
+	for (i = 0; i < prof_hdr->ddt_num; i++) {
+		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
+		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
+		    (cfg_dde[i].type == AW_DEV_TYPE_ID) &&
+		    (cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
+			if (cfg_dde[i].dev_profile >= AW_PROFILE_MAX) {
+				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
+							cfg_dde[i].dev_profile);
+				return -EINVAL;
+			}
+
+			ret = aw_dev_parse_data_by_sec_type(aw_dev, prof_hdr, &cfg_dde[i],
+					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "parse failed");
+				return ret;
+			}
+			sec_num++;
+		}
+	}
+
+	if (sec_num == 0) {
+		dev_dbg(aw_dev->dev, "get dev type num is %d, please use default", sec_num);
+		return AW_DEV_TYPE_NONE;
+	}
+
+	return AW_DEV_TYPE_OK;
+}
+
+static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
+		struct aw_cfg_hdr *prof_hdr, struct aw_all_prof_info *all_prof_info)
+{
+	struct aw_cfg_dde *cfg_dde =
+		(struct aw_cfg_dde *)((char *)prof_hdr + prof_hdr->hdr_offset);
+	int sec_num = 0;
+	int ret, i;
+
+	for (i = 0; i < prof_hdr->ddt_num; i++) {
+		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
+			(cfg_dde[i].type == AW_DEV_DEFAULT_TYPE_ID) &&
+			(cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
+			if (cfg_dde[i].dev_profile >= AW_PROFILE_MAX) {
+				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
+					cfg_dde[i].dev_profile);
+				return -EINVAL;
+			}
+			ret = aw_dev_parse_data_by_sec_type(aw_dev, prof_hdr, &cfg_dde[i],
+					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "parse failed");
+				return ret;
+			}
+			sec_num++;
+		}
+	}
+
+	if (sec_num == 0) {
+		dev_err(aw_dev->dev, "get dev default type failed, get num[%d]", sec_num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
+				struct aw_all_prof_info all_prof_info)
+{
+	struct aw_prof_desc *prof_desc = all_prof_info.prof_desc;
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_sec_data_desc *sec_desc;
+	int num = 0;
+	int i;
+
+	for (i = 0; i < AW_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
+			sec_desc = prof_desc[i].sec_desc;
+			if ((sec_desc[AW_DATA_TYPE_REG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_REG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].len != 0)) {
+				prof_info->count++;
+			}
+		}
+	}
+
+	dev_dbg(aw_dev->dev, "get valid profile:%d", aw_dev->prof_info.count);
+
+	if (!prof_info->count) {
+		dev_err(aw_dev->dev, "no profile data");
+		return -EPERM;
+	}
+
+	prof_info->prof_desc = devm_kcalloc(aw_dev->dev,
+					prof_info->count, sizeof(struct aw_prof_desc),
+					GFP_KERNEL);
+	if (!prof_info->prof_desc)
+		return -ENOMEM;
+
+	for (i = 0; i < AW_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
+			sec_desc = prof_desc[i].sec_desc;
+			if ((sec_desc[AW_DATA_TYPE_REG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_REG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].len != 0)) {
+				if (num >= prof_info->count) {
+					dev_err(aw_dev->dev, "overflow count[%d]",
+							prof_info->count);
+					return -EINVAL;
+				}
+				prof_info->prof_desc[num] = prof_desc[i];
+				prof_info->prof_desc[num].id = i;
+				num++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
+		struct aw_cfg_hdr *prof_hdr)
+{
+	struct aw_all_prof_info *all_prof_info;
+	int ret;
+
+	all_prof_info = devm_kzalloc(aw_dev->dev, sizeof(struct aw_all_prof_info), GFP_KERNEL);
+	if (!all_prof_info)
+		return -ENOMEM;
+
+	ret = aw_dev_parse_dev_type(aw_dev, prof_hdr, all_prof_info);
+	if (ret < 0) {
+		goto exit;
+	} else if (ret == AW_DEV_TYPE_NONE) {
+		dev_dbg(aw_dev->dev, "get dev type num is 0, parse default dev");
+		ret = aw_dev_parse_dev_default_type(aw_dev, prof_hdr, all_prof_info);
+		if (ret < 0)
+			goto exit;
+	}
+
+	ret = aw_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
+	if (ret < 0)
+		goto exit;
+
+	aw_dev->prof_info.prof_name_list = profile_name;
+exit:
+	devm_kfree(aw_dev->dev, all_prof_info);
+	return ret;
+}
+
+static int aw_dev_create_prof_name_list_v1(struct aw_device *aw_dev)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_prof_desc *prof_desc = prof_info->prof_desc;
+	int i;
+
+	if (!prof_desc) {
+		dev_err(aw_dev->dev, "prof_desc is NULL");
+		return -EINVAL;
+	}
+
+	prof_info->prof_name_list = devm_kzalloc(aw_dev->dev,
+					prof_info->count * PROFILE_STR_MAX,
+					GFP_KERNEL);
+	if (!prof_info->prof_name_list)
+		return -ENOMEM;
+
+	for (i = 0; i < prof_info->count; i++) {
+		prof_desc[i].id = i;
+		prof_info->prof_name_list[i] = prof_desc[i].prf_str;
+		dev_info(aw_dev->dev, "prof name is %s", prof_info->prof_name_list[i]);
+	}
+
+	return 0;
+}
+
+static int aw_get_dde_type_info(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+{
+	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+	struct aw_cfg_dde_v1 *cfg_dde =
+		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
+	int default_num = 0;
+	int dev_num = 0;
+	unsigned int i;
+
+	for (i = 0; i < cfg_hdr->ddt_num; i++) {
+		if (cfg_dde[i].type == AW_DEV_TYPE_ID)
+			dev_num++;
+
+		if (cfg_dde[i].type == AW_DEV_DEFAULT_TYPE_ID)
+			default_num++;
+	}
+
+	if (dev_num != 0) {
+		aw_dev->prof_info.prof_type = AW_DEV_TYPE_ID;
+	} else if (default_num != 0) {
+		aw_dev->prof_info.prof_type = AW_DEV_DEFAULT_TYPE_ID;
+	} else {
+		dev_err(aw_dev->dev, "can't find scene");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_container *aw_cfg,
+						unsigned int *scene_num)
+{
+	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+	struct aw_cfg_dde_v1 *cfg_dde =
+		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
+	unsigned int i;
+
+	for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+		if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
+		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+		    ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
+		     (aw_dev->i2c->addr == cfg_dde[i].dev_addr)))
+			(*scene_num)++;
+	}
+
+	return 0;
+}
+
+static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
+						struct aw_container *aw_cfg,
+						unsigned int *scene_num)
+{
+	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+	struct aw_cfg_dde_v1 *cfg_dde =
+		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
+	unsigned int i;
+
+	for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+		if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
+		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+		    (aw_dev->channel == cfg_dde[i].dev_index))
+			(*scene_num)++;
+	}
+
+	return 0;
+}
+
+static int aw_dev_parse_scene_count_v1(struct aw_device *aw_dev,
+							struct aw_container *aw_cfg,
+							unsigned int *count)
+{
+	int ret;
+
+	ret = aw_get_dde_type_info(aw_dev, aw_cfg);
+	if (ret < 0)
+		return ret;
+
+	switch (aw_dev->prof_info.prof_type) {
+	case AW_DEV_TYPE_ID:
+		ret = aw_get_dev_scene_count_v1(aw_dev, aw_cfg, count);
+		break;
+	case AW_DEV_DEFAULT_TYPE_ID:
+		ret = aw_get_default_scene_count_v1(aw_dev, aw_cfg, count);
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupported prof_type[%x]", aw_dev->prof_info.prof_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	dev_dbg(aw_dev->dev, "scene count is %d", (*count));
+	return ret;
+}
+
+static int aw_dev_parse_data_by_sec_type_v1(struct aw_device *aw_dev,
+							struct aw_cfg_hdr *prof_hdr,
+							struct aw_cfg_dde_v1 *cfg_dde,
+							int *cur_scene_id)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	int ret;
+
+	switch (cfg_dde->data_type) {
+	case ACF_SEC_TYPE_MULTIPLE_BIN:
+		ret = aw_dev_prof_parse_multi_bin(aw_dev, (u8 *)prof_hdr + cfg_dde->data_offset,
+					cfg_dde->data_size, &prof_info->prof_desc[*cur_scene_id]);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "parse multi bin failed");
+			return ret;
+		}
+		prof_info->prof_desc[*cur_scene_id].prf_str = cfg_dde->dev_profile_str;
+		prof_info->prof_desc[*cur_scene_id].id = cfg_dde->dev_profile;
+		(*cur_scene_id)++;
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupported SEC_TYPE [%d]", cfg_dde->data_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_parse_dev_type_v1(struct aw_device *aw_dev,
+		struct aw_cfg_hdr *prof_hdr)
+{
+	struct aw_cfg_dde_v1 *cfg_dde =
+		(struct aw_cfg_dde_v1 *)((char *)prof_hdr + prof_hdr->hdr_offset);
+	int cur_scene_id;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < prof_hdr->ddt_num; i++) {
+		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
+		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
+		    (aw_dev->chip_id == cfg_dde[i].chip_id)) {
+			ret = aw_dev_parse_data_by_sec_type_v1(aw_dev, prof_hdr,
+							&cfg_dde[i], &cur_scene_id);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "parse failed");
+				return ret;
+			}
+		}
+	}
+
+	if (cur_scene_id == 0) {
+		dev_err(aw_dev->dev, "get dev type failed, get num [%d]", cur_scene_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_parse_default_type_v1(struct aw_device *aw_dev,
+		struct aw_cfg_hdr *prof_hdr)
+{
+	struct aw_cfg_dde_v1 *cfg_dde =
+		(struct aw_cfg_dde_v1 *)((char *)prof_hdr + prof_hdr->hdr_offset);
+	int cur_scene_id = 0;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < prof_hdr->ddt_num; i++) {
+		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
+			(aw_dev->chip_id == cfg_dde[i].chip_id)) {
+			ret = aw_dev_parse_data_by_sec_type_v1(aw_dev, prof_hdr,
+							&cfg_dde[i], &cur_scene_id);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "parse failed");
+				return ret;
+			}
+		}
+	}
+
+	if (cur_scene_id == 0) {
+		dev_err(aw_dev->dev, "get dev default type failed, get num[%d]", cur_scene_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_parse_by_hdr_v1(struct aw_device *aw_dev,
+		struct aw_cfg_hdr *cfg_hdr)
+{
+	int ret;
+
+	switch (aw_dev->prof_info.prof_type) {
+	case AW_DEV_TYPE_ID:
+		ret = aw_dev_parse_dev_type_v1(aw_dev, cfg_hdr);
+		break;
+	case AW_DEV_DEFAULT_TYPE_ID:
+		ret = aw_dev_parse_default_type_v1(aw_dev, cfg_hdr);
+		break;
+	default:
+		dev_err(aw_dev->dev, "prof type matched failed, get num[%d]",
+			aw_dev->prof_info.prof_type);
+		ret =  -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int aw_dev_load_cfg_by_hdr_v1(struct aw_device *aw_dev,
+						struct aw_container *aw_cfg)
+{
+	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	int ret;
+
+	ret = aw_dev_parse_scene_count_v1(aw_dev, aw_cfg, &prof_info->count);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "get scene count failed");
+		return ret;
+	}
+
+	prof_info->prof_desc = devm_kcalloc(aw_dev->dev,
+					prof_info->count, sizeof(struct aw_prof_desc),
+					GFP_KERNEL);
+	if (!prof_info->prof_desc)
+		return -ENOMEM;
+
+	ret = aw_dev_parse_by_hdr_v1(aw_dev, cfg_hdr);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "parse hdr failed");
+		return ret;
+	}
+
+	ret = aw_dev_create_prof_name_list_v1(aw_dev);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "create prof name list failed");
+		return ret;
+	}
+
+	return 0;
+}
+
+int aw883xx_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+{
+	struct aw_cfg_hdr *cfg_hdr;
+	int ret;
+
+	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+
+	switch (cfg_hdr->hdr_version) {
+	case AW_CFG_HDR_VER:
+		ret = aw_dev_load_cfg_by_hdr(aw_dev, cfg_hdr);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "hdr_cersion[0x%x] parse failed",
+						cfg_hdr->hdr_version);
+			return ret;
+		}
+		break;
+	case AW_CFG_HDR_VER_V1:
+		ret = aw_dev_load_cfg_by_hdr_v1(aw_dev, aw_cfg);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "hdr_cersion[0x%x] parse failed",
+						cfg_hdr->hdr_version);
+			return ret;
+		}
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupported hdr_version [0x%x]", cfg_hdr->hdr_version);
+		return -EINVAL;
+	}
+	aw_dev->fw_status = AW_DEV_FW_OK;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_cfg_load);
+
+static int aw_dev_check_cfg_by_hdr(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+{
+	unsigned int end_data_offset;
+	struct aw_cfg_hdr *cfg_hdr;
+	struct aw_cfg_dde *cfg_dde;
+	unsigned int hdr_ddt_len;
+	unsigned int act_data = 0;
+	unsigned int i;
+	u8 act_crc8;
+
+	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+	/* check file type id is awinic acf file */
+	if (cfg_hdr->id != ACF_FILE_ID) {
+		dev_err(aw_dev->dev, "not acf type file");
+		return -EINVAL;
+	}
+
+	hdr_ddt_len = cfg_hdr->hdr_offset + cfg_hdr->ddt_size;
+	if (hdr_ddt_len > aw_cfg->len) {
+		dev_err(aw_dev->dev, "hdrlen with ddt_len [%d] overflow file size[%d]",
+		cfg_hdr->hdr_offset, aw_cfg->len);
+		return -EINVAL;
+	}
+
+	/* check data size */
+	cfg_dde = (struct aw_cfg_dde *)((char *)aw_cfg->data + cfg_hdr->hdr_offset);
+	act_data += hdr_ddt_len;
+	for (i = 0; i < cfg_hdr->ddt_num; i++)
+		act_data += cfg_dde[i].data_size;
+
+	if (act_data != aw_cfg->len) {
+		dev_err(aw_dev->dev, "act_data[%d] not equal to file size[%d]!",
+			act_data, aw_cfg->len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cfg_hdr->ddt_num; i++) {
+		/* data check */
+		end_data_offset = cfg_dde[i].data_offset + cfg_dde[i].data_size;
+		if (end_data_offset > aw_cfg->len) {
+			dev_err(aw_dev->dev, "ddt_num[%d] end_data_offset[%d] overflow size[%d]",
+				i, end_data_offset, aw_cfg->len);
+			return -EINVAL;
+		}
+
+		/* crc check */
+		act_crc8 = crc8(aw_crc8_table, aw_cfg->data + cfg_dde[i].data_offset,
+							cfg_dde[i].data_size, 0);
+		if (act_crc8 != cfg_dde[i].data_crc) {
+			dev_err(aw_dev->dev, "ddt_num[%d] act_crc8:0x%x != data_crc:0x%x",
+				i, (u32)act_crc8, cfg_dde[i].data_crc);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int aw_dev_check_acf_by_hdr_v1(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+{
+	struct aw_cfg_dde_v1 *cfg_dde;
+	unsigned int end_data_offset;
+	struct aw_cfg_hdr *cfg_hdr;
+	unsigned int act_data = 0;
+	unsigned int hdr_ddt_len;
+	u8 act_crc8;
+	int i;
+
+	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+
+	/* check file type id is awinic acf file */
+	if (cfg_hdr->id != ACF_FILE_ID) {
+		dev_err(aw_dev->dev, "not acf type file");
+		return -EINVAL;
+	}
+
+	hdr_ddt_len = cfg_hdr->hdr_offset + cfg_hdr->ddt_size;
+	if (hdr_ddt_len > aw_cfg->len) {
+		dev_err(aw_dev->dev, "hdrlen with ddt_len [%d] overflow file size[%d]",
+		cfg_hdr->hdr_offset, aw_cfg->len);
+		return -EINVAL;
+	}
+
+	/* check data size */
+	cfg_dde = (struct aw_cfg_dde_v1 *)((char *)aw_cfg->data + cfg_hdr->hdr_offset);
+	act_data += hdr_ddt_len;
+	for (i = 0; i < cfg_hdr->ddt_num; i++)
+		act_data += cfg_dde[i].data_size;
+
+	if (act_data != aw_cfg->len) {
+		dev_err(aw_dev->dev, "act_data[%d] not equal to file size[%d]!",
+			act_data, aw_cfg->len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cfg_hdr->ddt_num; i++) {
+		/* data check */
+		end_data_offset = cfg_dde[i].data_offset + cfg_dde[i].data_size;
+		if (end_data_offset > aw_cfg->len) {
+			dev_err(aw_dev->dev, "ddt_num[%d] end_data_offset[%d] overflow size[%d]",
+				i, end_data_offset, aw_cfg->len);
+			return -EINVAL;
+		}
+
+		/* crc check */
+		act_crc8 = crc8(aw_crc8_table, aw_cfg->data + cfg_dde[i].data_offset,
+									cfg_dde[i].data_size, 0);
+		if (act_crc8 != cfg_dde[i].data_crc) {
+			dev_err(aw_dev->dev, "ddt_num[%d] act_crc8:0x%x != data_crc 0x%x",
+				i, (u32)act_crc8, cfg_dde[i].data_crc);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+
+}
+
+int aw883xx_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+{
+	struct aw_cfg_hdr *cfg_hdr;
+
+	if (!aw_cfg) {
+		dev_err(aw_dev->dev, "aw_prof is NULL");
+		return -EINVAL;
+	}
+
+	if (aw_cfg->len < sizeof(struct aw_cfg_hdr)) {
+		dev_err(aw_dev->dev, "cfg hdr size[%d] overflow file size[%d]",
+			aw_cfg->len, (int)sizeof(struct aw_cfg_hdr));
+		return -EINVAL;
+	}
+
+	crc8_populate_lsb(aw_crc8_table, AW_CRC8_POLYNOMIAL);
+
+	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
+	switch (cfg_hdr->hdr_version) {
+	case AW_CFG_HDR_VER:
+		return aw_dev_check_cfg_by_hdr(aw_dev, aw_cfg);
+	case AW_CFG_HDR_VER_V1:
+		return aw_dev_check_acf_by_hdr_v1(aw_dev, aw_cfg);
+	default:
+		dev_err(aw_dev->dev, "unsupported hdr_version [0x%x]", cfg_hdr->hdr_version);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw883xx_dev_load_acf_check);
+
+MODULE_DESCRIPTION("AW883XX ACF File Parsing Lib");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw883xx/aw883xx_bin_parse.h b/sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
new file mode 100644
index 000000000000..be23282a73d3
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx_bin_parse.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * aw883xx.c --  ALSA SoC AW883XX codec support
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ */
+
+#ifndef __AW883XX_BIN_PARSE_H__
+#define __AW883XX_BIN_PARSE_H__
+
+#define CHECK_REGISTER_NUM_OFFSET	(4)
+#define VALID_DATA_LEN			(4)
+#define VALID_DATA_ADDR		(4)
+#define PARSE_DSP_REG_NUM		(4)
+#define REG_DATA_BYTP_LEN		(8)
+#define CHECK_DSP_REG_NUM		(12)
+#define DSP_VALID_DATA_LEN		(12)
+#define DSP_VALID_DATA_ADDR		(12)
+#define PARSE_SOC_APP_NUM		(8)
+#define CHECK_SOC_APP_NUM		(12)
+#define APP_DOWNLOAD_ADDR		(4)
+#define APP_VALID_DATA_LEN		(12)
+#define APP_VALID_DATA_ADDR		(12)
+#define BIN_NUM_MAX			(100)
+#define HEADER_LEN			(60)
+#define BIN_DATA_TYPE_OFFSET		(8)
+#define DATA_LEN			(44)
+#define VALID_DATA_ADDR_OFFSET		(60)
+#define START_ADDR_OFFSET		(64)
+
+#define AW_FW_CHECK_PART		(10)
+#define HDADER_LEN			(60)
+
+#define HEADER_VERSION_OFFSET		(4)
+
+enum bin_header_version_enum {
+	HEADER_VERSION_V1 = 0x01000000,
+};
+
+enum data_type_enum {
+	DATA_TYPE_REGISTER   = 0x00000000,
+	DATA_TYPE_DSP_REG    = 0x00000010,
+	DATA_TYPE_DSP_CFG    = 0x00000011,
+	DATA_TYPE_SOC_REG    = 0x00000020,
+	DATA_TYPE_SOC_APP    = 0x00000021,
+	DATA_TYPE_DSP_FW     = 0x00000022,
+	DATA_TYPE_MULTI_BINS = 0x00002000,
+};
+
+enum data_version_enum {
+	DATA_VERSION_V1 = 0x00000001,
+	DATA_VERSION_MAX,
+};
+
+struct bin_header_info {
+	unsigned int check_sum;
+	unsigned int header_ver;
+	unsigned int bin_data_type;
+	unsigned int bin_data_ver;
+	unsigned int bin_data_len;
+	unsigned int ui_ver;
+	unsigned char chip_type[8];
+	unsigned int reg_byte_len;
+	unsigned int data_byte_len;
+	unsigned int device_addr;
+	unsigned int valid_data_len;
+	unsigned int valid_data_addr;
+
+	unsigned int reg_num;
+	unsigned int reg_data_byte_len;
+	unsigned int download_addr;
+	unsigned int app_version;
+	unsigned int header_len;
+};
+
+struct bin_container {
+	unsigned int len;
+	unsigned char data[];
+};
+
+struct aw_bin {
+	unsigned char *p_addr;
+	unsigned int all_bin_parse_num;
+	unsigned int multi_bin_parse_num;
+	unsigned int single_bin_parse_num;
+	struct bin_header_info header_info[BIN_NUM_MAX];
+	struct bin_container info;
+};
+
+#endif
-- 
2.38.1

