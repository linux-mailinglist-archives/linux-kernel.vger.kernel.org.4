Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE216596DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiL3JgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiL3Jf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:35:26 -0500
Received: from out29-223.mail.aliyun.com (out29-223.mail.aliyun.com [115.124.29.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03C1A807;
        Fri, 30 Dec 2022 01:35:24 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712914|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00658004-0.0028205-0.990599;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Qh0Qg5D_1672392916;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Qh0Qg5D_1672392916)
          by smtp.aliyun-inc.com;
          Fri, 30 Dec 2022 17:35:19 +0800
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
Subject: [PATCH V8 4/5] ASoC: codecs: Aw883xx chip register file, data type file and Kconfig Makefile
Date:   Fri, 30 Dec 2022 17:34:53 +0800
Message-Id: <20221230093454.190579-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230093454.190579-1-wangweidong.a@awinic.com>
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
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
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   6 +
 sound/soc/codecs/aw883xx/aw883xx_data_type.h  | 143 +++++++
 .../soc/codecs/aw883xx/aw883xx_pid_2049_reg.h | 384 ++++++++++++++++++
 4 files changed, 543 insertions(+)
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_data_type.h
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f9d71490075..ea1dd48c642b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -54,6 +54,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ALC5623
 	imply SND_SOC_ALC5632
 	imply SND_SOC_AW8738
+	imply SND_SOC_AW883XX
 	imply SND_SOC_BT_SCO
 	imply SND_SOC_BD28623
 	imply SND_SOC_CQ0093VC
@@ -2167,4 +2168,13 @@ config SND_SOC_LPASS_TX_MACRO
 	select SND_SOC_LPASS_MACRO_COMMON
 	tristate "Qualcomm TX Macro in LPASS(Low Power Audio SubSystem)"
 
+config SND_SOC_AW883XX
+	tristate "Soc Audio for awinic aw883xx series"
+	depends on I2C
+	help
+	  this option enables support for aw883xx series Smart PA.
+	  The Awinic AW883XX is an I2S/TDM input, high efficiency
+	  digital Smart K audio amplifier with an integrated 10V
+	  smart boost convert.
+
 endmenu
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 71d3ce5867e4..afcac34e4d78 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -358,6 +358,10 @@ snd-soc-tas2780-objs := tas2780.o
 # Mux
 snd-soc-simple-mux-objs := simple-mux.o
 
+snd_soc_aw883xx-objs := aw883xx/aw883xx.o \
+						aw883xx/aw883xx_device.o \
+						aw883xx/aw883xx_bin_parse.o \
+
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
 obj-$(CONFIG_SND_SOC_AB8500_CODEC)	+= snd-soc-ab8500-codec.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
@@ -721,3 +725,5 @@ obj-$(CONFIG_SND_SOC_LPASS_TX_MACRO)	+= snd-soc-lpass-tx-macro.o
 
 # Mux
 obj-$(CONFIG_SND_SOC_SIMPLE_MUX)	+= snd-soc-simple-mux.o
+
+obj-$(CONFIG_SND_SOC_AW883XX) +=snd_soc_aw883xx.o
diff --git a/sound/soc/codecs/aw883xx/aw883xx_data_type.h b/sound/soc/codecs/aw883xx/aw883xx_data_type.h
new file mode 100644
index 000000000000..cf60953792f2
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx_data_type.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * aw883xx.c --  ALSA SoC AW883XX codec support
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ */
+
+#ifndef __AW883XX_DATA_TYPE_H__
+#define __AW883XX_DATA_TYPE_H__
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
+	AW_CFG_HDR_VER		= 0x00000001,
+	AW_CFG_HDR_VER_V1	= 0x01000000,
+};
+
+enum aw_cfg_dde_type {
+	AW_DEV_NONE_TYPE_ID	= 0xFFFFFFFF,
+	AW_DEV_TYPE_ID		= 0x00000000,
+	AW_SKT_TYPE_ID		= 0x00000001,
+	AW_DEV_DEFAULT_TYPE_ID	= 0x00000002,
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
+	AW_DATA_TYPE_REG = 0,
+	AW_DATA_TYPE_DSP_CFG,
+	AW_DATA_TYPE_DSP_FW,
+	AW_DATA_TYPE_MAX,
+};
+
+enum aw_prof_type {
+	AW_PROFILE_MUSIC = 0,
+	AW_PROFILE_VOICE,
+	AW_PROFILE_VOIP,
+	AW_PROFILE_RINGTONE,
+	AW_PROFILE_RINGTONE_HS,
+	AW_PROFILE_LOWPOWER,
+	AW_PROFILE_BYPASS,
+	AW_PROFILE_MMI,
+	AW_PROFILE_FM,
+	AW_PROFILE_NOTIFICATION,
+	AW_PROFILE_RECEIVER,
+	AW_PROFILE_MAX,
+};
+
+enum aw_profile_status {
+	AW_PROFILE_WAIT = 0,
+	AW_PROFILE_OK,
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
+	struct aw_sec_data_desc sec_desc[AW_DATA_TYPE_MAX];
+};
+
+struct aw_all_prof_info {
+	struct aw_prof_desc prof_desc[AW_PROFILE_MAX];
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
+
diff --git a/sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h b/sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h
new file mode 100644
index 000000000000..7305a21bf05a
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h
@@ -0,0 +1,384 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * aw883xx.c --  ALSA SoC AW883XX codec support
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ */
+
+#ifndef __AW883XX_PID_2049_REG_H__
+#define __AW883XX_PID_2049_REG_H__
+
+#define AW_PID_2049_ID_REG			(0x00)
+#define AW_PID_2049_SYSST_REG			(0x01)
+#define AW_PID_2049_SYSINT_REG			(0x02)
+#define AW_PID_2049_SYSINTM_REG		(0x03)
+#define AW_PID_2049_SYSCTRL_REG		(0x04)
+#define AW_PID_2049_SYSCTRL2_REG		(0x05)
+#define AW_PID_2049_I2SCTRL_REG		(0x06)
+#define AW_PID_2049_I2SCFG1_REG		(0x07)
+#define AW_PID_2049_I2SCFG2_REG		(0x08)
+#define AW_PID_2049_HAGCCFG1_REG		(0x09)
+#define AW_PID_2049_HAGCCFG2_REG		(0x0A)
+#define AW_PID_2049_HAGCCFG3_REG		(0x0B)
+#define AW_PID_2049_HAGCCFG4_REG		(0x0C)
+#define AW_PID_2049_HAGCCFG5_REG		(0x0D)
+#define AW_PID_2049_HAGCCFG6_REG		(0x0E)
+#define AW_PID_2049_HAGCCFG7_REG		(0x0F)
+#define AW_PID_2049_MPDCFG_REG			(0x10)
+#define AW_PID_2049_PWMCTRL_REG		(0x11)
+#define AW_PID_2049_I2SCFG3_REG		(0x12)
+#define AW_PID_2049_DBGCTRL_REG		(0x13)
+#define AW_PID_2049_HAGCST_REG			(0x20)
+#define AW_PID_2049_VBAT_REG			(0x21)
+#define AW_PID_2049_TEMP_REG			(0x22)
+#define AW_PID_2049_PVDD_REG			(0x23)
+#define AW_PID_2049_ISNDAT_REG			(0x24)
+#define AW_PID_2049_VSNDAT_REG			(0x25)
+#define AW_PID_2049_I2SINT_REG			(0x26)
+#define AW_PID_2049_I2SCAPCNT_REG		(0x27)
+#define AW_PID_2049_ANASTA1_REG		(0x28)
+#define AW_PID_2049_ANASTA2_REG		(0x29)
+#define AW_PID_2049_ANASTA3_REG		(0x2A)
+#define AW_PID_2049_ANASTA4_REG		(0x2B)
+#define AW_PID_2049_TESTDET_REG		(0x2C)
+#define AW_PID_2049_TESTIN_REG			(0x38)
+#define AW_PID_2049_TESTOUT_REG		(0x39)
+#define AW_PID_2049_DSPMADD_REG		(0x40)
+#define AW_PID_2049_DSPMDAT_REG		(0x41)
+#define AW_PID_2049_WDT_REG			(0x42)
+#define AW_PID_2049_ACR1_REG			(0x43)
+#define AW_PID_2049_ACR2_REG			(0x44)
+#define AW_PID_2049_ASR1_REG			(0x45)
+#define AW_PID_2049_ASR2_REG			(0x46)
+#define AW_PID_2049_DSPCFG_REG			(0x47)
+#define AW_PID_2049_ASR3_REG			(0x48)
+#define AW_PID_2049_ASR4_REG			(0x49)
+#define AW_PID_2049_VSNCTRL1_REG		(0x50)
+#define AW_PID_2049_ISNCTRL1_REG		(0x51)
+#define AW_PID_2049_PLLCTRL1_REG		(0x52)
+#define AW_PID_2049_PLLCTRL2_REG		(0x53)
+#define AW_PID_2049_PLLCTRL3_REG		(0x54)
+#define AW_PID_2049_CDACTRL1_REG		(0x55)
+#define AW_PID_2049_CDACTRL2_REG		(0x56)
+#define AW_PID_2049_SADCCTRL1_REG		(0x57)
+#define AW_PID_2049_SADCCTRL2_REG		(0x58)
+#define AW_PID_2049_CPCTRL1_REG		(0x59)
+#define AW_PID_2049_BSTCTRL1_REG		(0x60)
+#define AW_PID_2049_BSTCTRL2_REG		(0x61)
+#define AW_PID_2049_BSTCTRL3_REG		(0x62)
+#define AW_PID_2049_BSTCTRL4_REG		(0x63)
+#define AW_PID_2049_BSTCTRL5_REG		(0x64)
+#define AW_PID_2049_BSTCTRL6_REG		(0x65)
+#define AW_PID_2049_BSTCTRL7_REG		(0x66)
+#define AW_PID_2049_DSMCFG1_REG		(0x67)
+#define AW_PID_2049_DSMCFG2_REG		(0x68)
+#define AW_PID_2049_DSMCFG3_REG		(0x69)
+#define AW_PID_2049_DSMCFG4_REG		(0x6A)
+#define AW_PID_2049_DSMCFG5_REG		(0x6B)
+#define AW_PID_2049_DSMCFG6_REG		(0x6C)
+#define AW_PID_2049_DSMCFG7_REG		(0x6D)
+#define AW_PID_2049_DSMCFG8_REG		(0x6E)
+#define AW_PID_2049_TESTCTRL1_REG		(0x70)
+#define AW_PID_2049_TESTCTRL2_REG		(0x71)
+#define AW_PID_2049_EFCTRL1_REG		(0x72)
+#define AW_PID_2049_EFCTRL2_REG		(0x73)
+#define AW_PID_2049_EFWH_REG			(0x74)
+#define AW_PID_2049_EFWM2_REG			(0x75)
+#define AW_PID_2049_EFWM1_REG			(0x76)
+#define AW_PID_2049_EFWL_REG			(0x77)
+#define AW_PID_2049_EFRH_REG			(0x78)
+#define AW_PID_2049_EFRM2_REG			(0x79)
+#define AW_PID_2049_EFRM1_REG			(0x7A)
+#define AW_PID_2049_EFRL_REG			(0x7B)
+#define AW_PID_2049_TM_REG			(0x7C)
+
+enum aw883xx_id {
+	AW883XX_PID_2049 = 0x2049,
+};
+
+#define AW_PID_2049_REG_MAX			(0x7D)
+
+#define AW_PID_2049_VOLUME_STEP_DB		(6 * 8)
+
+#define AW_PID_2049_UVLS_START_BIT		(14)
+#define AW_PID_2049_UVLS_NORMAL		(0)
+#define AW_PID_2049_UVLS_NORMAL_VALUE		\
+	(AW_PID_2049_UVLS_NORMAL << AW_PID_2049_UVLS_START_BIT)
+
+#define AW_PID_2049_DSPS_START_BIT		(12)
+#define AW_PID_2049_DSPS_BITS_LEN		(1)
+#define AW_PID_2049_DSPS_MASK			\
+	(~(((1<<AW_PID_2049_DSPS_BITS_LEN)-1) << AW_PID_2049_DSPS_START_BIT))
+
+#define AW_PID_2049_DSPS_NORMAL		(0)
+#define AW_PID_2049_DSPS_NORMAL_VALUE		\
+	(AW_PID_2049_DSPS_NORMAL << AW_PID_2049_DSPS_START_BIT)
+
+#define AW_PID_2049_BSTOCS_START_BIT		(11)
+#define AW_PID_2049_BSTOCS_OVER_CURRENT	(1)
+#define AW_PID_2049_BSTOCS_OVER_CURRENT_VALUE	\
+	(AW_PID_2049_BSTOCS_OVER_CURRENT << AW_PID_2049_BSTOCS_START_BIT)
+
+#define AW_PID_2049_BSTS_START_BIT		(9)
+#define AW_PID_2049_BSTS_FINISHED		(1)
+#define AW_PID_2049_BSTS_FINISHED_VALUE	\
+	(AW_PID_2049_BSTS_FINISHED << AW_PID_2049_BSTS_START_BIT)
+
+#define AW_PID_2049_SWS_START_BIT		(8)
+#define AW_PID_2049_SWS_SWITCHING		(1)
+#define AW_PID_2049_SWS_SWITCHING_VALUE	\
+	(AW_PID_2049_SWS_SWITCHING << AW_PID_2049_SWS_START_BIT)
+
+#define AW_PID_2049_NOCLKS_START_BIT		(5)
+#define AW_PID_2049_NOCLKS_NO_CLOCK		(1)
+#define AW_PID_2049_NOCLKS_NO_CLOCK_VALUE	\
+	(AW_PID_2049_NOCLKS_NO_CLOCK << AW_PID_2049_NOCLKS_START_BIT)
+
+#define AW_PID_2049_CLKS_START_BIT		(4)
+#define AW_PID_2049_CLKS_STABLE		(1)
+#define AW_PID_2049_CLKS_STABLE_VALUE		\
+	(AW_PID_2049_CLKS_STABLE << AW_PID_2049_CLKS_START_BIT)
+
+#define AW_PID_2049_OCDS_START_BIT		(3)
+#define AW_PID_2049_OCDS_OC			(1)
+#define AW_PID_2049_OCDS_OC_VALUE		\
+	(AW_PID_2049_OCDS_OC << AW_PID_2049_OCDS_START_BIT)
+
+#define AW_PID_2049_OTHS_START_BIT		(1)
+#define AW_PID_2049_OTHS_OT			(1)
+#define AW_PID_2049_OTHS_OT_VALUE		\
+	(AW_PID_2049_OTHS_OT << AW_PID_2049_OTHS_START_BIT)
+
+#define AW_PID_2049_PLLS_START_BIT		(0)
+#define AW_PID_2049_PLLS_LOCKED		(1)
+#define AW_PID_2049_PLLS_LOCKED_VALUE	\
+	(AW_PID_2049_PLLS_LOCKED << AW_PID_2049_PLLS_START_BIT)
+
+#define AW_PID_2049_BIT_PLL_CHECK \
+		(AW_PID_2049_CLKS_STABLE_VALUE | \
+		AW_PID_2049_PLLS_LOCKED_VALUE)
+
+#define AW_PID_2049_BIT_SYSST_CHECK_MASK \
+		(~(AW_PID_2049_UVLS_NORMAL_VALUE | \
+		AW_PID_2049_BSTOCS_OVER_CURRENT_VALUE | \
+		AW_PID_2049_BSTS_FINISHED_VALUE | \
+		AW_PID_2049_SWS_SWITCHING_VALUE | \
+		AW_PID_2049_NOCLKS_NO_CLOCK_VALUE | \
+		AW_PID_2049_CLKS_STABLE_VALUE | \
+		AW_PID_2049_OCDS_OC_VALUE | \
+		AW_PID_2049_OTHS_OT_VALUE | \
+		AW_PID_2049_PLLS_LOCKED_VALUE))
+
+#define AW_PID_2049_BIT_SYSST_CHECK \
+		(AW_PID_2049_BSTS_FINISHED_VALUE | \
+		AW_PID_2049_SWS_SWITCHING_VALUE | \
+		AW_PID_2049_CLKS_STABLE_VALUE | \
+		AW_PID_2049_PLLS_LOCKED_VALUE)
+
+#define AW_PID_2049_WDI_START_BIT		(6)
+#define AW_PID_2049_WDI_INT_VALUE		(1)
+#define AW_PID_2049_WDI_INTERRUPT		\
+	(AW_PID_2049_WDI_INT_VALUE << AW_PID_2049_WDI_START_BIT)
+
+#define AW_PID_2049_NOCLKI_START_BIT		(5)
+#define AW_PID_2049_NOCLKI_INT_VALUE		(1)
+#define AW_PID_2049_NOCLKI_INTERRUPT		\
+	(AW_PID_2049_NOCLKI_INT_VALUE << AW_PID_2049_NOCLKI_START_BIT)
+
+#define AW_PID_2049_CLKI_START_BIT		(4)
+#define AW_PID_2049_CLKI_INT_VALUE		(1)
+#define AW_PID_2049_CLKI_INTERRUPT		\
+	(AW_PID_2049_CLKI_INT_VALUE << AW_PID_2049_CLKI_START_BIT)
+
+#define AW_PID_2049_PLLI_START_BIT		(0)
+#define AW_PID_2049_PLLI_INT_VALUE		(1)
+#define AW_PID_2049_PLLI_INTERRUPT		\
+	(AW_PID_2049_PLLI_INT_VALUE << AW_PID_2049_PLLI_START_BIT)
+
+#define AW_PID_2049_BIT_SYSINT_CHECK \
+		(AW_PID_2049_WDI_INTERRUPT | \
+		AW_PID_2049_CLKI_INTERRUPT | \
+		AW_PID_2049_NOCLKI_INTERRUPT | \
+		AW_PID_2049_PLLI_INTERRUPT)
+
+#define AW_PID_2049_HMUTE_START_BIT		(8)
+#define AW_PID_2049_HMUTE_BITS_LEN		(1)
+#define AW_PID_2049_HMUTE_MASK			\
+	(~(((1<<AW_PID_2049_HMUTE_BITS_LEN)-1) << AW_PID_2049_HMUTE_START_BIT))
+
+#define AW_PID_2049_HMUTE_DISABLE		(0)
+#define AW_PID_2049_HMUTE_DISABLE_VALUE	\
+	(AW_PID_2049_HMUTE_DISABLE << AW_PID_2049_HMUTE_START_BIT)
+
+#define AW_PID_2049_HMUTE_ENABLE		(1)
+#define AW_PID_2049_HMUTE_ENABLE_VALUE		\
+	(AW_PID_2049_HMUTE_ENABLE << AW_PID_2049_HMUTE_START_BIT)
+
+#define AW_PID_2049_RCV_MODE_START_BIT		(7)
+#define AW_PID_2049_RCV_MODE_BITS_LEN		(1)
+#define AW_PID_2049_RCV_MODE_MASK		\
+	(~(((1<<AW_PID_2049_RCV_MODE_BITS_LEN)-1) << AW_PID_2049_RCV_MODE_START_BIT))
+
+#define AW_PID_2049_RCV_MODE_RECEIVER		(1)
+#define AW_PID_2049_RCV_MODE_RECEIVER_VALUE	\
+	(AW_PID_2049_RCV_MODE_RECEIVER << AW_PID_2049_RCV_MODE_START_BIT)
+
+#define AW_PID_2049_DSPBY_START_BIT		(2)
+#define AW_PID_2049_DSPBY_BITS_LEN		(1)
+#define AW_PID_2049_DSPBY_MASK			\
+	(~(((1<<AW_PID_2049_DSPBY_BITS_LEN)-1) << AW_PID_2049_DSPBY_START_BIT))
+
+#define AW_PID_2049_DSPBY_WORKING		(0)
+#define AW_PID_2049_DSPBY_WORKING_VALUE	\
+	(AW_PID_2049_DSPBY_WORKING << AW_PID_2049_DSPBY_START_BIT)
+
+#define AW_PID_2049_DSPBY_BYPASS		(1)
+#define AW_PID_2049_DSPBY_BYPASS_VALUE		\
+	(AW_PID_2049_DSPBY_BYPASS << AW_PID_2049_DSPBY_START_BIT)
+
+#define AW_PID_2049_AMPPD_START_BIT		(1)
+#define AW_PID_2049_AMPPD_BITS_LEN		(1)
+#define AW_PID_2049_AMPPD_MASK			\
+	(~(((1<<AW_PID_2049_AMPPD_BITS_LEN)-1) << AW_PID_2049_AMPPD_START_BIT))
+
+#define AW_PID_2049_AMPPD_WORKING		(0)
+#define AW_PID_2049_AMPPD_WORKING_VALUE	\
+	(AW_PID_2049_AMPPD_WORKING << AW_PID_2049_AMPPD_START_BIT)
+
+#define AW_PID_2049_AMPPD_POWER_DOWN		(1)
+#define AW_PID_2049_AMPPD_POWER_DOWN_VALUE	\
+	(AW_PID_2049_AMPPD_POWER_DOWN << AW_PID_2049_AMPPD_START_BIT)
+
+#define AW_PID_2049_PWDN_START_BIT		(0)
+#define AW_PID_2049_PWDN_BITS_LEN		(1)
+#define AW_PID_2049_PWDN_MASK			\
+	(~(((1<<AW_PID_2049_PWDN_BITS_LEN)-1) << AW_PID_2049_PWDN_START_BIT))
+
+#define AW_PID_2049_PWDN_WORKING		(0)
+#define AW_PID_2049_PWDN_WORKING_VALUE		\
+	(AW_PID_2049_PWDN_WORKING << AW_PID_2049_PWDN_START_BIT)
+
+#define AW_PID_2049_PWDN_POWER_DOWN		(1)
+#define AW_PID_2049_PWDN_POWER_DOWN_VALUE	\
+	(AW_PID_2049_PWDN_POWER_DOWN << AW_PID_2049_PWDN_START_BIT)
+
+#define AW_PID_2049_MUTE_VOL			(90 * 8)
+#define AW_PID_2049_VOLUME_STEP_DB		(6 * 8)
+
+#define AW_PID_2049_VOL_6DB_START		(6)
+#define AW_PID_2049_VOL_START_BIT		(6)
+#define AW_PID_2049_VOL_BITS_LEN		(10)
+#define AW_PID_2049_VOL_MASK			\
+	(~(((1<<AW_PID_2049_VOL_BITS_LEN)-1) << AW_PID_2049_VOL_START_BIT))
+
+#define AW_PID_2049_VOL_DEFAULT_VALUE		(0)
+
+#define AW_PID_2049_I2STXEN_START_BIT		(0)
+#define AW_PID_2049_I2STXEN_BITS_LEN		(1)
+#define AW_PID_2049_I2STXEN_MASK		\
+	(~(((1<<AW_PID_2049_I2STXEN_BITS_LEN)-1) << AW_PID_2049_I2STXEN_START_BIT))
+
+#define AW_PID_2049_I2STXEN_DISABLE		(0)
+#define AW_PID_2049_I2STXEN_DISABLE_VALUE	\
+	(AW_PID_2049_I2STXEN_DISABLE << AW_PID_2049_I2STXEN_START_BIT)
+
+#define AW_PID_2049_I2STXEN_ENABLE		(1)
+#define AW_PID_2049_I2STXEN_ENABLE_VALUE	\
+	(AW_PID_2049_I2STXEN_ENABLE << AW_PID_2049_I2STXEN_START_BIT)
+
+#define AW_PID_2049_AGC_DSP_CTL_START_BIT	(15)
+#define AW_PID_2049_AGC_DSP_CTL_BITS_LEN	(1)
+#define AW_PID_2049_AGC_DSP_CTL_MASK	\
+	(~(((1<<AW_PID_2049_AGC_DSP_CTL_BITS_LEN)-1) << AW_PID_2049_AGC_DSP_CTL_START_BIT))
+
+#define AW_PID_2049_AGC_DSP_CTL_DISABLE	(0)
+#define AW_PID_2049_AGC_DSP_CTL_DISABLE_VALUE	\
+	(AW_PID_2049_AGC_DSP_CTL_DISABLE << AW_PID_2049_AGC_DSP_CTL_START_BIT)
+
+#define AW_PID_2049_AGC_DSP_CTL_ENABLE		(1)
+#define AW_PID_2049_AGC_DSP_CTL_ENABLE_VALUE	\
+	(AW_PID_2049_AGC_DSP_CTL_ENABLE << AW_PID_2049_AGC_DSP_CTL_START_BIT)
+
+#define AW_PID_2049_VDSEL_START_BIT		(0)
+#define AW_PID_2049_VDSEL_BITS_LEN		(1)
+#define AW_PID_2049_VDSEL_MASK			\
+	(~(((1<<AW_PID_2049_VDSEL_BITS_LEN)-1) << AW_PID_2049_VDSEL_START_BIT))
+
+#define AW_PID_2049_MEM_CLKSEL_START_BIT	(3)
+#define AW_PID_2049_MEM_CLKSEL_BITS_LEN	(1)
+#define AW_PID_2049_MEM_CLKSEL_MASK		\
+	(~(((1<<AW_PID_2049_MEM_CLKSEL_BITS_LEN)-1) << AW_PID_2049_MEM_CLKSEL_START_BIT))
+
+#define AW_PID_2049_MEM_CLKSEL_OSC_CLK		(0)
+#define AW_PID_2049_MEM_CLKSEL_OSC_CLK_VALUE	\
+	(AW_PID_2049_MEM_CLKSEL_OSC_CLK << AW_PID_2049_MEM_CLKSEL_START_BIT)
+
+#define AW_PID_2049_MEM_CLKSEL_DAP_HCLK	(1)
+#define AW_PID_2049_MEM_CLKSEL_DAP_HCLK_VALUE	\
+	(AW_PID_2049_MEM_CLKSEL_DAP_HCLK << AW_PID_2049_MEM_CLKSEL_START_BIT)
+
+#define AW_PID_2049_CCO_MUX_START_BIT		(14)
+#define AW_PID_2049_CCO_MUX_BITS_LEN		(1)
+#define AW_PID_2049_CCO_MUX_MASK		\
+	(~(((1<<AW_PID_2049_CCO_MUX_BITS_LEN)-1) << AW_PID_2049_CCO_MUX_START_BIT))
+
+#define AW_PID_2049_CCO_MUX_DIVIDED		(0)
+#define AW_PID_2049_CCO_MUX_DIVIDED_VALUE	\
+	(AW_PID_2049_CCO_MUX_DIVIDED << AW_PID_2049_CCO_MUX_START_BIT)
+
+#define AW_PID_2049_CCO_MUX_BYPASS		(1)
+#define AW_PID_2049_CCO_MUX_BYPASS_VALUE	\
+	(AW_PID_2049_CCO_MUX_BYPASS << AW_PID_2049_CCO_MUX_START_BIT)
+
+#define AW_PID_2049_EF_VSN_GESLP_START_BIT	(0)
+#define AW_PID_2049_EF_VSN_GESLP_BITS_LEN	(10)
+#define AW_PID_2049_EF_VSN_GESLP_MASK		\
+	(~(((1<<AW_PID_2049_EF_VSN_GESLP_BITS_LEN)-1) << AW_PID_2049_EF_VSN_GESLP_START_BIT))
+
+#define AW_PID_2049_EF_VSN_GESLP_SIGN_MASK	(~(1 << 9))
+#define AW_PID_2049_EF_VSN_GESLP_SIGN_NEG	(0xfe00)
+
+#define AW_PID_2049_EF_ISN_GESLP_START_BIT	(0)
+#define AW_PID_2049_EF_ISN_GESLP_BITS_LEN	(10)
+#define AW_PID_2049_EF_ISN_GESLP_MASK	\
+	(~(((1<<AW_PID_2049_EF_ISN_GESLP_BITS_LEN)-1) << AW_PID_2049_EF_ISN_GESLP_START_BIT))
+
+#define AW_PID_2049_EF_ISN_GESLP_SIGN_MASK	(~(1 << 9))
+#define AW_PID_2049_EF_ISN_GESLP_SIGN_NEG	(0xfe00)
+
+#define AW_PID_2049_CABL_BASE_VALUE		(1000)
+#define AW_PID_2049_ICABLK_FACTOR		(1)
+#define AW_PID_2049_VCABLK_FACTOR		(1)
+#define AW_PID_2049_VCAL_FACTOR		(1 << 12)
+#define AW_PID_2049_VSCAL_FACTOR		(16500)
+#define AW_PID_2049_ISCAL_FACTOR		(3667)
+#define AW_PID_2049_EF_VSENSE_GAIN_SHIFT	(0)
+
+#define AW_PID_2049_VCABLK_FACTOR_DAC		(2)
+#define AW_PID_2049_VSCAL_FACTOR_DAC		(11790)
+#define AW_PID_2049_EF_DAC_GESLP_SHIFT		(10)
+#define AW_PID_2049_EF_DAC_GESLP_SIGN_MASK	(1 << 5)
+#define AW_PID_2049_EF_DAC_GESLP_SIGN_NEG	(0xffc0)
+
+#define AW_PID_2049_VCALB_ADJ_FACTOR		(12)
+
+#define AW_PID_2049_WDT_CNT_START_BIT		(0)
+#define AW_PID_2049_WDT_CNT_BITS_LEN		(8)
+#define AW_PID_2049_WDT_CNT_MASK		\
+	(~(((1<<AW_PID_2049_WDT_CNT_BITS_LEN)-1) << AW_PID_2049_WDT_CNT_START_BIT))
+
+#define AW_PID_2049_DSP_CFG_ADDR		(0x9C80)
+#define AW_PID_2049_DSP_FW_ADDR		(0x8C00)
+#define AW_PID_2049_DSP_REG_VMAX		(0x9C94)
+#define AW_PID_2049_DSP_REG_CFG_ADPZ_RE	(0x9D00)
+#define AW_PID_2049_DSP_REG_VCALB		(0x9CF7)
+#define AW_PID_2049_DSP_RE_SHIFT		(12)
+
+#define AW_PID_2049_DSP_REG_CFG_ADPZ_RA	(0x9D02)
+#define AW_PID_2049_DSP_REG_CRC_ADDR		(0x9F42)
+#define AW_PID_2049_DSP_REG_CFGF0_FS		(0x9F44)
+#define AW_PID_2049_DSP_CALI_F0_DELAY		(0x9CFD)
+
+#endif
-- 
2.38.1

