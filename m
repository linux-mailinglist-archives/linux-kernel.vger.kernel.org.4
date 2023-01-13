Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C550668C08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjAMF7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbjAMF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:57:50 -0500
Received: from out29-10.mail.aliyun.com (out29-10.mail.aliyun.com [115.124.29.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A376D53C;
        Thu, 12 Jan 2023 21:53:35 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712912|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00793197-0.000460394-0.991608;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.QrY0te9_1673589202;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QrY0te9_1673589202)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 13:53:24 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        wangweidong.a@awinic.com, flatmax@flatmax.com,
        jonathan.albrieux@gmail.com, povik+lin@cutebit.org,
        13691752556@139.com, shumingf@realtek.com,
        ryan.lee.analog@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, yijiangtao@awinic.com, zhaolei@awinic.com
Subject: [PATCH V10 4/5] ASoC: codecs: Aw88395 chip register file, data type file and Kconfig Makefile
Date:   Fri, 13 Jan 2023 13:53:00 +0800
Message-Id: <20230113055301.189541-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113055301.189541-1-wangweidong.a@awinic.com>
References: <20230113055301.189541-1-wangweidong.a@awinic.com>
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

The Awinic AW88395 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Signed-off-by: Nick Li <liweilei@awinic.com>
Signed-off-by: Bruce zhao <zhaolei@awinic.com>
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig                     |  17 +
 sound/soc/codecs/Makefile                    |   5 +
 sound/soc/codecs/aw88395/aw88395_data_type.h | 142 +++++++
 sound/soc/codecs/aw88395/aw88395_reg.h       | 383 +++++++++++++++++++
 4 files changed, 547 insertions(+)
 create mode 100644 sound/soc/codecs/aw88395/aw88395_data_type.h
 create mode 100644 sound/soc/codecs/aw88395/aw88395_reg.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f9d71490075..87e6300fa9a8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -54,6 +54,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ALC5623
 	imply SND_SOC_ALC5632
 	imply SND_SOC_AW8738
+	imply SND_SOC_AW88395
 	imply SND_SOC_BT_SCO
 	imply SND_SOC_BD28623
 	imply SND_SOC_CQ0093VC
@@ -599,6 +600,22 @@ config SND_SOC_AW8738
 	  SND_SOC_SIMPLE_AMPLIFIER, but additionally allows setting the
 	  operation mode using the Awinic-specific one-wire pulse control.
 
+config SND_SOC_AW88395_LIB
+	tristate
+
+config SND_SOC_AW88395
+	tristate "Soc Audio for awinic aw88395"
+	depends on I2C
+	select CRC8
+	select CRC32
+	select REGMAP_I2C
+	select SND_SOC_AW88395_LIB
+	help
+	  this option enables support for aw88395 Smart PA.
+	  The Awinic AW88395 is an I2S/TDM input, high efficiency
+	  digital Smart K audio amplifier with an integrated 10V
+	  smart boost convert.
+
 config SND_SOC_BD28623
 	tristate "ROHM BD28623 CODEC"
 	help
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 71d3ce5867e4..fa42adcc00ec 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -46,6 +46,9 @@ snd-soc-ak5386-objs := ak5386.o
 snd-soc-ak5558-objs := ak5558.o
 snd-soc-arizona-objs := arizona.o arizona-jack.o
 snd-soc-aw8738-objs := aw8738.o
+snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
+snd-soc-aw88395-objs := aw88395/aw88395.o \
+			aw88395/aw88395_device.o
 snd-soc-bd28623-objs := bd28623.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-cpcap-objs := cpcap.o
@@ -407,6 +410,8 @@ obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
+obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
+obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
 obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
diff --git a/sound/soc/codecs/aw88395/aw88395_data_type.h b/sound/soc/codecs/aw88395/aw88395_data_type.h
new file mode 100644
index 000000000000..c26ff63c7ac4
--- /dev/null
+++ b/sound/soc/codecs/aw88395/aw88395_data_type.h
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw883_data_type.h --  The data type of the AW88395 chip
+//
+// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
+//
+// Author: Bruce zhao <zhaolei@awinic.com>
+//
+
+#ifndef __AW88395_DATA_TYPE_H__
+#define __AW88395_DATA_TYPE_H__
+
+#define PROJECT_NAME_MAX		(24)
+#define CUSTOMER_NAME_MAX		(16)
+#define CFG_VERSION_MAX		(4)
+#define DEV_NAME_MAX			(16)
+#define PROFILE_STR_MAX		(32)
+
+#define ACF_FILE_ID			(0xa15f908)
+
+enum aw_cfg_hdr_version {
+	AW88395_CFG_HDR_VER	= 0x00000001,
+	AW88395_CFG_HDR_VER_V1	= 0x01000000,
+};
+
+enum aw_cfg_dde_type {
+	AW88395_DEV_NONE_TYPE_ID	= 0xFFFFFFFF,
+	AW88395_DEV_TYPE_ID		= 0x00000000,
+	AW88395_SKT_TYPE_ID		= 0x00000001,
+	AW88395_DEV_DEFAULT_TYPE_ID	= 0x00000002,
+};
+
+enum aw_sec_type {
+	ACF_SEC_TYPE_REG = 0,
+	ACF_SEC_TYPE_DSP,
+	ACF_SEC_TYPE_DSP_CFG,
+	ACF_SEC_TYPE_DSP_FW,
+	ACF_SEC_TYPE_HDR_REG,
+	ACF_SEC_TYPE_HDR_DSP_CFG,
+	ACF_SEC_TYPE_HDR_DSP_FW,
+	ACF_SEC_TYPE_MULTIPLE_BIN,
+	ACF_SEC_TYPE_SKT_PROJECT,
+	ACF_SEC_TYPE_DSP_PROJECT,
+	ACF_SEC_TYPE_MONITOR,
+	ACF_SEC_TYPE_MAX,
+};
+
+enum profile_data_type {
+	AW88395_DATA_TYPE_REG = 0,
+	AW88395_DATA_TYPE_DSP_CFG,
+	AW88395_DATA_TYPE_DSP_FW,
+	AW88395_DATA_TYPE_MAX,
+};
+
+enum aw_prof_type {
+	AW88395_PROFILE_MUSIC = 0,
+	AW88395_PROFILE_VOICE,
+	AW88395_PROFILE_VOIP,
+	AW88395_PROFILE_RINGTONE,
+	AW88395_PROFILE_RINGTONE_HS,
+	AW88395_PROFILE_LOWPOWER,
+	AW88395_PROFILE_BYPASS,
+	AW88395_PROFILE_MMI,
+	AW88395_PROFILE_FM,
+	AW88395_PROFILE_NOTIFICATION,
+	AW88395_PROFILE_RECEIVER,
+	AW88395_PROFILE_MAX,
+};
+
+enum aw_profile_status {
+	AW88395_PROFILE_WAIT = 0,
+	AW88395_PROFILE_OK,
+};
+
+struct aw_cfg_hdr {
+	u32 id;
+	char project[PROJECT_NAME_MAX];
+	char custom[CUSTOMER_NAME_MAX];
+	char version[CFG_VERSION_MAX];
+	u32 author_id;
+	u32 ddt_size;
+	u32 ddt_num;
+	u32 hdr_offset;
+	u32 hdr_version;
+	u32 reserved[3];
+};
+
+struct aw_cfg_dde {
+	u32 type;
+	char dev_name[DEV_NAME_MAX];
+	u16 dev_index;
+	u16 dev_bus;
+	u16 dev_addr;
+	u16 dev_profile;
+	u32 data_type;
+	u32 data_size;
+	u32 data_offset;
+	u32 data_crc;
+	u32 reserved[5];
+};
+
+struct aw_cfg_dde_v1 {
+	u32 type;
+	char dev_name[DEV_NAME_MAX];
+	u16 dev_index;
+	u16 dev_bus;
+	u16 dev_addr;
+	u16 dev_profile;
+	u32 data_type;
+	u32 data_size;
+	u32 data_offset;
+	u32 data_crc;
+	char dev_profile_str[PROFILE_STR_MAX];
+	u32 chip_id;
+	u32 reserved[4];
+};
+
+struct aw_sec_data_desc {
+	u32 len;
+	u8 *data;
+};
+
+struct aw_prof_desc {
+	u32 id;
+	u32 prof_st;
+	char *prf_str;
+	u32 fw_ver;
+	struct aw_sec_data_desc sec_desc[AW88395_DATA_TYPE_MAX];
+};
+
+struct aw_all_prof_info {
+	struct aw_prof_desc prof_desc[AW88395_PROFILE_MAX];
+};
+
+struct aw_prof_info {
+	int count;
+	int prof_type;
+	char **prof_name_list;
+	struct aw_prof_desc *prof_desc;
+};
+
+#endif
diff --git a/sound/soc/codecs/aw88395/aw88395_reg.h b/sound/soc/codecs/aw88395/aw88395_reg.h
new file mode 100644
index 000000000000..d54d86de52ed
--- /dev/null
+++ b/sound/soc/codecs/aw88395/aw88395_reg.h
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88395_reg.h --  AW88395 chip register file
+//
+// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
+//
+// Author: Bruce zhao <zhaolei@awinic.com>
+//
+
+#ifndef __AW88395_REG_H__
+#define __AW88395_REG_H__
+
+#define AW88395_ID_REG			(0x00)
+#define AW88395_SYSST_REG		(0x01)
+#define AW88395_SYSINT_REG		(0x02)
+#define AW88395_SYSINTM_REG		(0x03)
+#define AW88395_SYSCTRL_REG		(0x04)
+#define AW88395_SYSCTRL2_REG		(0x05)
+#define AW88395_I2SCTRL_REG		(0x06)
+#define AW88395_I2SCFG1_REG		(0x07)
+#define AW88395_I2SCFG2_REG		(0x08)
+#define AW88395_HAGCCFG1_REG		(0x09)
+#define AW88395_HAGCCFG2_REG		(0x0A)
+#define AW88395_HAGCCFG3_REG		(0x0B)
+#define AW88395_HAGCCFG4_REG		(0x0C)
+#define AW88395_HAGCCFG5_REG		(0x0D)
+#define AW88395_HAGCCFG6_REG		(0x0E)
+#define AW88395_HAGCCFG7_REG		(0x0F)
+#define AW88395_MPDCFG_REG		(0x10)
+#define AW88395_PWMCTRL_REG		(0x11)
+#define AW88395_I2SCFG3_REG		(0x12)
+#define AW88395_DBGCTRL_REG		(0x13)
+#define AW88395_HAGCST_REG		(0x20)
+#define AW88395_VBAT_REG		(0x21)
+#define AW88395_TEMP_REG		(0x22)
+#define AW88395_PVDD_REG		(0x23)
+#define AW88395_ISNDAT_REG		(0x24)
+#define AW88395_VSNDAT_REG		(0x25)
+#define AW88395_I2SINT_REG		(0x26)
+#define AW88395_I2SCAPCNT_REG		(0x27)
+#define AW88395_ANASTA1_REG		(0x28)
+#define AW88395_ANASTA2_REG		(0x29)
+#define AW88395_ANASTA3_REG		(0x2A)
+#define AW88395_ANASTA4_REG		(0x2B)
+#define AW88395_TESTDET_REG		(0x2C)
+#define AW88395_TESTIN_REG		(0x38)
+#define AW88395_TESTOUT_REG		(0x39)
+#define AW88395_DSPMADD_REG		(0x40)
+#define AW88395_DSPMDAT_REG		(0x41)
+#define AW88395_WDT_REG		(0x42)
+#define AW88395_ACR1_REG		(0x43)
+#define AW88395_ACR2_REG		(0x44)
+#define AW88395_ASR1_REG		(0x45)
+#define AW88395_ASR2_REG		(0x46)
+#define AW88395_DSPCFG_REG		(0x47)
+#define AW88395_ASR3_REG		(0x48)
+#define AW88395_ASR4_REG		(0x49)
+#define AW88395_VSNCTRL1_REG		(0x50)
+#define AW88395_ISNCTRL1_REG		(0x51)
+#define AW88395_PLLCTRL1_REG		(0x52)
+#define AW88395_PLLCTRL2_REG		(0x53)
+#define AW88395_PLLCTRL3_REG		(0x54)
+#define AW88395_CDACTRL1_REG		(0x55)
+#define AW88395_CDACTRL2_REG		(0x56)
+#define AW88395_SADCCTRL1_REG		(0x57)
+#define AW88395_SADCCTRL2_REG		(0x58)
+#define AW88395_CPCTRL1_REG		(0x59)
+#define AW88395_BSTCTRL1_REG		(0x60)
+#define AW88395_BSTCTRL2_REG		(0x61)
+#define AW88395_BSTCTRL3_REG		(0x62)
+#define AW88395_BSTCTRL4_REG		(0x63)
+#define AW88395_BSTCTRL5_REG		(0x64)
+#define AW88395_BSTCTRL6_REG		(0x65)
+#define AW88395_BSTCTRL7_REG		(0x66)
+#define AW88395_DSMCFG1_REG		(0x67)
+#define AW88395_DSMCFG2_REG		(0x68)
+#define AW88395_DSMCFG3_REG		(0x69)
+#define AW88395_DSMCFG4_REG		(0x6A)
+#define AW88395_DSMCFG5_REG		(0x6B)
+#define AW88395_DSMCFG6_REG		(0x6C)
+#define AW88395_DSMCFG7_REG		(0x6D)
+#define AW88395_DSMCFG8_REG		(0x6E)
+#define AW88395_TESTCTRL1_REG		(0x70)
+#define AW88395_TESTCTRL2_REG		(0x71)
+#define AW88395_EFCTRL1_REG		(0x72)
+#define AW88395_EFCTRL2_REG		(0x73)
+#define AW88395_EFWH_REG		(0x74)
+#define AW88395_EFWM2_REG		(0x75)
+#define AW88395_EFWM1_REG		(0x76)
+#define AW88395_EFWL_REG		(0x77)
+#define AW88395_EFRH_REG		(0x78)
+#define AW88395_EFRM2_REG		(0x79)
+#define AW88395_EFRM1_REG		(0x7A)
+#define AW88395_EFRL_REG		(0x7B)
+#define AW88395_TM_REG			(0x7C)
+
+enum aw88395_id {
+	AW88395_CHIP_ID = 0x2049,
+};
+
+#define AW88395_REG_MAX		(0x7D)
+
+#define AW88395_VOLUME_STEP_DB		(6 * 8)
+
+#define AW88395_UVLS_START_BIT		(14)
+#define AW88395_UVLS_NORMAL		(0)
+#define AW88395_UVLS_NORMAL_VALUE	\
+	(AW88395_UVLS_NORMAL << AW88395_UVLS_START_BIT)
+
+#define AW88395_DSPS_START_BIT		(12)
+#define AW88395_DSPS_BITS_LEN		(1)
+#define AW88395_DSPS_MASK		\
+	(~(((1<<AW88395_DSPS_BITS_LEN)-1) << AW88395_DSPS_START_BIT))
+
+#define AW88395_DSPS_NORMAL		(0)
+#define AW88395_DSPS_NORMAL_VALUE	\
+	(AW88395_DSPS_NORMAL << AW88395_DSPS_START_BIT)
+
+#define AW88395_BSTOCS_START_BIT	(11)
+#define AW88395_BSTOCS_OVER_CURRENT	(1)
+#define AW88395_BSTOCS_OVER_CURRENT_VALUE	\
+	(AW88395_BSTOCS_OVER_CURRENT << AW88395_BSTOCS_START_BIT)
+
+#define AW88395_BSTS_START_BIT		(9)
+#define AW88395_BSTS_FINISHED		(1)
+#define AW88395_BSTS_FINISHED_VALUE	\
+	(AW88395_BSTS_FINISHED << AW88395_BSTS_START_BIT)
+
+#define AW88395_SWS_START_BIT		(8)
+#define AW88395_SWS_SWITCHING		(1)
+#define AW88395_SWS_SWITCHING_VALUE	\
+	(AW88395_SWS_SWITCHING << AW88395_SWS_START_BIT)
+
+#define AW88395_NOCLKS_START_BIT	(5)
+#define AW88395_NOCLKS_NO_CLOCK	(1)
+#define AW88395_NOCLKS_NO_CLOCK_VALUE	\
+	(AW88395_NOCLKS_NO_CLOCK << AW88395_NOCLKS_START_BIT)
+
+#define AW88395_CLKS_START_BIT		(4)
+#define AW88395_CLKS_STABLE		(1)
+#define AW88395_CLKS_STABLE_VALUE	\
+	(AW88395_CLKS_STABLE << AW88395_CLKS_START_BIT)
+
+#define AW88395_OCDS_START_BIT		(3)
+#define AW88395_OCDS_OC		(1)
+#define AW88395_OCDS_OC_VALUE		\
+	(AW88395_OCDS_OC << AW88395_OCDS_START_BIT)
+
+#define AW88395_OTHS_START_BIT		(1)
+#define AW88395_OTHS_OT		(1)
+#define AW88395_OTHS_OT_VALUE		\
+	(AW88395_OTHS_OT << AW88395_OTHS_START_BIT)
+
+#define AW88395_PLLS_START_BIT		(0)
+#define AW88395_PLLS_LOCKED		(1)
+#define AW88395_PLLS_LOCKED_VALUE	\
+	(AW88395_PLLS_LOCKED << AW88395_PLLS_START_BIT)
+
+#define AW88395_BIT_PLL_CHECK \
+		(AW88395_CLKS_STABLE_VALUE | \
+		AW88395_PLLS_LOCKED_VALUE)
+
+#define AW88395_BIT_SYSST_CHECK_MASK \
+		(~(AW88395_UVLS_NORMAL_VALUE | \
+		AW88395_BSTOCS_OVER_CURRENT_VALUE | \
+		AW88395_BSTS_FINISHED_VALUE | \
+		AW88395_SWS_SWITCHING_VALUE | \
+		AW88395_NOCLKS_NO_CLOCK_VALUE | \
+		AW88395_CLKS_STABLE_VALUE | \
+		AW88395_OCDS_OC_VALUE | \
+		AW88395_OTHS_OT_VALUE | \
+		AW88395_PLLS_LOCKED_VALUE))
+
+#define AW88395_BIT_SYSST_CHECK \
+		(AW88395_BSTS_FINISHED_VALUE | \
+		AW88395_SWS_SWITCHING_VALUE | \
+		AW88395_CLKS_STABLE_VALUE | \
+		AW88395_PLLS_LOCKED_VALUE)
+
+#define AW88395_WDI_START_BIT		(6)
+#define AW88395_WDI_INT_VALUE		(1)
+#define AW88395_WDI_INTERRUPT		\
+	(AW88395_WDI_INT_VALUE << AW88395_WDI_START_BIT)
+
+#define AW88395_NOCLKI_START_BIT	(5)
+#define AW88395_NOCLKI_INT_VALUE	(1)
+#define AW88395_NOCLKI_INTERRUPT	\
+	(AW88395_NOCLKI_INT_VALUE << AW88395_NOCLKI_START_BIT)
+
+#define AW88395_CLKI_START_BIT		(4)
+#define AW88395_CLKI_INT_VALUE		(1)
+#define AW88395_CLKI_INTERRUPT		\
+	(AW88395_CLKI_INT_VALUE << AW88395_CLKI_START_BIT)
+
+#define AW88395_PLLI_START_BIT		(0)
+#define AW88395_PLLI_INT_VALUE		(1)
+#define AW88395_PLLI_INTERRUPT		\
+	(AW88395_PLLI_INT_VALUE << AW88395_PLLI_START_BIT)
+
+#define AW88395_BIT_SYSINT_CHECK \
+		(AW88395_WDI_INTERRUPT | \
+		AW88395_CLKI_INTERRUPT | \
+		AW88395_NOCLKI_INTERRUPT | \
+		AW88395_PLLI_INTERRUPT)
+
+#define AW88395_HMUTE_START_BIT	(8)
+#define AW88395_HMUTE_BITS_LEN		(1)
+#define AW88395_HMUTE_MASK		\
+	(~(((1<<AW88395_HMUTE_BITS_LEN)-1) << AW88395_HMUTE_START_BIT))
+
+#define AW88395_HMUTE_DISABLE		(0)
+#define AW88395_HMUTE_DISABLE_VALUE	\
+	(AW88395_HMUTE_DISABLE << AW88395_HMUTE_START_BIT)
+
+#define AW88395_HMUTE_ENABLE		(1)
+#define AW88395_HMUTE_ENABLE_VALUE	\
+	(AW88395_HMUTE_ENABLE << AW88395_HMUTE_START_BIT)
+
+#define AW88395_RCV_MODE_START_BIT	(7)
+#define AW88395_RCV_MODE_BITS_LEN	(1)
+#define AW88395_RCV_MODE_MASK		\
+	(~(((1<<AW88395_RCV_MODE_BITS_LEN)-1) << AW88395_RCV_MODE_START_BIT))
+
+#define AW88395_RCV_MODE_RECEIVER	(1)
+#define AW88395_RCV_MODE_RECEIVER_VALUE	\
+	(AW88395_RCV_MODE_RECEIVER << AW88395_RCV_MODE_START_BIT)
+
+#define AW88395_DSPBY_START_BIT	(2)
+#define AW88395_DSPBY_BITS_LEN		(1)
+#define AW88395_DSPBY_MASK		\
+	(~(((1<<AW88395_DSPBY_BITS_LEN)-1) << AW88395_DSPBY_START_BIT))
+
+#define AW88395_DSPBY_WORKING		(0)
+#define AW88395_DSPBY_WORKING_VALUE	\
+	(AW88395_DSPBY_WORKING << AW88395_DSPBY_START_BIT)
+
+#define AW88395_DSPBY_BYPASS		(1)
+#define AW88395_DSPBY_BYPASS_VALUE	\
+	(AW88395_DSPBY_BYPASS << AW88395_DSPBY_START_BIT)
+
+#define AW88395_AMPPD_START_BIT	(1)
+#define AW88395_AMPPD_BITS_LEN		(1)
+#define AW88395_AMPPD_MASK		\
+	(~(((1<<AW88395_AMPPD_BITS_LEN)-1) << AW88395_AMPPD_START_BIT))
+
+#define AW88395_AMPPD_WORKING		(0)
+#define AW88395_AMPPD_WORKING_VALUE	\
+	(AW88395_AMPPD_WORKING << AW88395_AMPPD_START_BIT)
+
+#define AW88395_AMPPD_POWER_DOWN	(1)
+#define AW88395_AMPPD_POWER_DOWN_VALUE	\
+	(AW88395_AMPPD_POWER_DOWN << AW88395_AMPPD_START_BIT)
+
+#define AW88395_PWDN_START_BIT		(0)
+#define AW88395_PWDN_BITS_LEN		(1)
+#define AW88395_PWDN_MASK		\
+	(~(((1<<AW88395_PWDN_BITS_LEN)-1) << AW88395_PWDN_START_BIT))
+
+#define AW88395_PWDN_WORKING		(0)
+#define AW88395_PWDN_WORKING_VALUE	\
+	(AW88395_PWDN_WORKING << AW88395_PWDN_START_BIT)
+
+#define AW88395_PWDN_POWER_DOWN	(1)
+#define AW88395_PWDN_POWER_DOWN_VALUE	\
+	(AW88395_PWDN_POWER_DOWN << AW88395_PWDN_START_BIT)
+
+#define AW88395_MUTE_VOL		(90 * 8)
+#define AW88395_VOLUME_STEP_DB		(6 * 8)
+
+#define AW88395_VOL_6DB_START		(6)
+#define AW88395_VOL_START_BIT		(6)
+#define AW88395_VOL_BITS_LEN		(10)
+#define AW88395_VOL_MASK		\
+	(~(((1<<AW88395_VOL_BITS_LEN)-1) << AW88395_VOL_START_BIT))
+
+#define AW88395_VOL_DEFAULT_VALUE	(0)
+
+#define AW88395_I2STXEN_START_BIT	(0)
+#define AW88395_I2STXEN_BITS_LEN	(1)
+#define AW88395_I2STXEN_MASK		\
+	(~(((1<<AW88395_I2STXEN_BITS_LEN)-1) << AW88395_I2STXEN_START_BIT))
+
+#define AW88395_I2STXEN_DISABLE	(0)
+#define AW88395_I2STXEN_DISABLE_VALUE	\
+	(AW88395_I2STXEN_DISABLE << AW88395_I2STXEN_START_BIT)
+
+#define AW88395_I2STXEN_ENABLE		(1)
+#define AW88395_I2STXEN_ENABLE_VALUE	\
+	(AW88395_I2STXEN_ENABLE << AW88395_I2STXEN_START_BIT)
+
+#define AW88395_AGC_DSP_CTL_START_BIT	(15)
+#define AW88395_AGC_DSP_CTL_BITS_LEN	(1)
+#define AW88395_AGC_DSP_CTL_MASK	\
+	(~(((1<<AW88395_AGC_DSP_CTL_BITS_LEN)-1) << AW88395_AGC_DSP_CTL_START_BIT))
+
+#define AW88395_AGC_DSP_CTL_DISABLE	(0)
+#define AW88395_AGC_DSP_CTL_DISABLE_VALUE	\
+	(AW88395_AGC_DSP_CTL_DISABLE << AW88395_AGC_DSP_CTL_START_BIT)
+
+#define AW88395_AGC_DSP_CTL_ENABLE	(1)
+#define AW88395_AGC_DSP_CTL_ENABLE_VALUE	\
+	(AW88395_AGC_DSP_CTL_ENABLE << AW88395_AGC_DSP_CTL_START_BIT)
+
+#define AW88395_VDSEL_START_BIT	(0)
+#define AW88395_VDSEL_BITS_LEN		(1)
+#define AW88395_VDSEL_MASK		\
+	(~(((1<<AW88395_VDSEL_BITS_LEN)-1) << AW88395_VDSEL_START_BIT))
+
+#define AW88395_MEM_CLKSEL_START_BIT	(3)
+#define AW88395_MEM_CLKSEL_BITS_LEN	(1)
+#define AW88395_MEM_CLKSEL_MASK		\
+	(~(((1<<AW88395_MEM_CLKSEL_BITS_LEN)-1) << AW88395_MEM_CLKSEL_START_BIT))
+
+#define AW88395_MEM_CLKSEL_OSC_CLK	(0)
+#define AW88395_MEM_CLKSEL_OSC_CLK_VALUE	\
+	(AW88395_MEM_CLKSEL_OSC_CLK << AW88395_MEM_CLKSEL_START_BIT)
+
+#define AW88395_MEM_CLKSEL_DAP_HCLK	(1)
+#define AW88395_MEM_CLKSEL_DAP_HCLK_VALUE	\
+	(AW88395_MEM_CLKSEL_DAP_HCLK << AW88395_MEM_CLKSEL_START_BIT)
+
+#define AW88395_CCO_MUX_START_BIT	(14)
+#define AW88395_CCO_MUX_BITS_LEN	(1)
+#define AW88395_CCO_MUX_MASK		\
+	(~(((1<<AW88395_CCO_MUX_BITS_LEN)-1) << AW88395_CCO_MUX_START_BIT))
+
+#define AW88395_CCO_MUX_DIVIDED	(0)
+#define AW88395_CCO_MUX_DIVIDED_VALUE	\
+	(AW88395_CCO_MUX_DIVIDED << AW88395_CCO_MUX_START_BIT)
+
+#define AW88395_CCO_MUX_BYPASS		(1)
+#define AW88395_CCO_MUX_BYPASS_VALUE	\
+	(AW88395_CCO_MUX_BYPASS << AW88395_CCO_MUX_START_BIT)
+
+#define AW88395_EF_VSN_GESLP_START_BIT	(0)
+#define AW88395_EF_VSN_GESLP_BITS_LEN	(10)
+#define AW88395_EF_VSN_GESLP_MASK	\
+	(~(((1<<AW88395_EF_VSN_GESLP_BITS_LEN)-1) << AW88395_EF_VSN_GESLP_START_BIT))
+
+#define AW88395_EF_VSN_GESLP_SIGN_MASK	(~(1 << 9))
+#define AW88395_EF_VSN_GESLP_SIGN_NEG	(0xfe00)
+
+#define AW88395_EF_ISN_GESLP_START_BIT	(0)
+#define AW88395_EF_ISN_GESLP_BITS_LEN	(10)
+#define AW88395_EF_ISN_GESLP_MASK	\
+	(~(((1<<AW88395_EF_ISN_GESLP_BITS_LEN)-1) << AW88395_EF_ISN_GESLP_START_BIT))
+
+#define AW88395_EF_ISN_GESLP_SIGN_MASK	(~(1 << 9))
+#define AW88395_EF_ISN_GESLP_SIGN_NEG	(0xfe00)
+
+#define AW88395_CABL_BASE_VALUE	(1000)
+#define AW88395_ICABLK_FACTOR		(1)
+#define AW88395_VCABLK_FACTOR		(1)
+#define AW88395_VCAL_FACTOR		(1 << 12)
+#define AW88395_VSCAL_FACTOR		(16500)
+#define AW88395_ISCAL_FACTOR		(3667)
+#define AW88395_EF_VSENSE_GAIN_SHIFT	(0)
+
+#define AW88395_VCABLK_FACTOR_DAC	(2)
+#define AW88395_VSCAL_FACTOR_DAC	(11790)
+#define AW88395_EF_DAC_GESLP_SHIFT	(10)
+#define AW88395_EF_DAC_GESLP_SIGN_MASK	(1 << 5)
+#define AW88395_EF_DAC_GESLP_SIGN_NEG	(0xffc0)
+
+#define AW88395_VCALB_ADJ_FACTOR	(12)
+
+#define AW88395_WDT_CNT_START_BIT	(0)
+#define AW88395_WDT_CNT_BITS_LEN	(8)
+#define AW88395_WDT_CNT_MASK		\
+	(~(((1<<AW88395_WDT_CNT_BITS_LEN)-1) << AW88395_WDT_CNT_START_BIT))
+
+#define AW88395_DSP_CFG_ADDR		(0x9C80)
+#define AW88395_DSP_FW_ADDR		(0x8C00)
+#define AW88395_DSP_REG_VMAX		(0x9C94)
+#define AW88395_DSP_REG_CFG_ADPZ_RE	(0x9D00)
+#define AW88395_DSP_REG_VCALB		(0x9CF7)
+#define AW88395_DSP_RE_SHIFT		(12)
+
+#define AW88395_DSP_REG_CFG_ADPZ_RA	(0x9D02)
+#define AW88395_DSP_REG_CRC_ADDR	(0x9F42)
+#define AW88395_DSP_CALI_F0_DELAY	(0x9CFD)
+
+#endif
-- 
2.39.0

