Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE1654111
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiLVMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiLVMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:33:03 -0500
Received: from out29-174.mail.aliyun.com (out29-174.mail.aliyun.com [115.124.29.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893C21E2D;
        Thu, 22 Dec 2022 04:32:53 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0203299-0.00195916-0.977711;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.QbObWcu_1671712336;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QbObWcu_1671712336)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 20:32:18 +0800
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
Subject: [PATCH V7 1/5] ASoC: codecs: Add i2c and codec registration for aw883xx and their associated operation functions
Date:   Thu, 22 Dec 2022 20:32:02 +0800
Message-Id: <20221222123205.106353-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221222123205.106353-1-wangweidong.a@awinic.com>
References: <20221222123205.106353-1-wangweidong.a@awinic.com>
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
 sound/soc/codecs/aw883xx/aw883xx.c | 706 +++++++++++++++++++++++++++++
 sound/soc/codecs/aw883xx/aw883xx.h |  61 +++
 2 files changed, 767 insertions(+)
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
 create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h

diff --git a/sound/soc/codecs/aw883xx/aw883xx.c b/sound/soc/codecs/aw883xx/aw883xx.c
new file mode 100644
index 000000000000..0abf8d96d2fe
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx.c
@@ -0,0 +1,706 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * aw883xx.c --  ALSA SoC AW883XX codec support
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ * Author: Weidong Wang <wangweidong.a@awinic.com>
+ */
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include "aw883xx_pid_2049_reg.h"
+#include "aw883xx.h"
+#include "aw883xx_device.h"
+
+static const struct regmap_config aw883xx_remap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW_PID_2049_REG_MAX - 1,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static void aw883xx_start_pa(struct aw883xx *aw883xx)
+{
+	int ret, i;
+
+	if (!aw883xx->allow_pw) {
+		dev_info(aw883xx->aw_pa->dev, "%s:dev can not allow power", __func__);
+		return;
+	}
+
+	if (aw883xx->pstream == AW883XX_STREAM_CLOSE) {
+		dev_info(aw883xx->aw_pa->dev, "%s:pstream is close", __func__);
+		return;
+	}
+
+	for (i = 0; i < AW_START_RETRIES; i++) {
+		ret = aw883xx_dev_start(aw883xx->aw_pa);
+		if (ret) {
+			dev_err(aw883xx->aw_pa->dev, "aw883xx device start failed. retry = %d", i);
+			ret = aw883xx_dev_fw_update(aw883xx->aw_pa, AW_DSP_FW_UPDATE_ON, true);
+			if (ret < 0) {
+				dev_err(aw883xx->aw_pa->dev, "fw update failed");
+				continue;
+			}
+		} else {
+			dev_info(aw883xx->aw_pa->dev, "start success\n");
+			break;
+		}
+	}
+}
+
+static void aw883xx_startup_work(struct work_struct *work)
+{
+	struct aw883xx *aw883xx =
+		container_of(work, struct aw883xx, start_work.work);
+
+	mutex_lock(&aw883xx->lock);
+	aw883xx_start_pa(aw883xx);
+	mutex_unlock(&aw883xx->lock);
+}
+
+static void aw883xx_start(struct aw883xx *aw883xx, bool sync_start)
+{
+	int ret;
+	int i;
+
+	if (aw883xx->aw_pa->fw_status != AW_DEV_FW_OK)
+		return;
+
+	if (!aw883xx->allow_pw) {
+		dev_info(aw883xx->aw_pa->dev, "%s:dev can not allow power", __func__);
+		return;
+	}
+
+	if (aw883xx->aw_pa->status == AW_DEV_PW_ON)
+		return;
+
+	for (i = 0; i < AW_START_RETRIES; i++) {
+		ret = aw883xx_dev_fw_update(aw883xx->aw_pa, AW_DSP_FW_UPDATE_OFF, true);
+		if (ret < 0) {
+			dev_err(aw883xx->aw_pa->dev, "fw update failed. retry = %d", i);
+			continue;
+		} else {
+			/*firmware update success*/
+			if (sync_start == AW_SYNC_START)
+				aw883xx_start_pa(aw883xx);
+			else
+				queue_delayed_work(aw883xx->work_queue,
+					&aw883xx->start_work,
+					AW_START_WORK_DELAY_MS);
+			return;
+		}
+	}
+}
+
+/*
+ * Digital Audio Interface
+ */
+static int aw883xx_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+
+	aw883xx->pstream = AW883XX_STREAM_OPEN;
+
+	mutex_lock(&aw883xx->lock);
+	aw883xx_start(aw883xx, AW_ASYNC_START);
+	mutex_unlock(&aw883xx->lock);
+
+	return 0;
+}
+
+static void aw883xx_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+
+	aw883xx->pstream = AW883XX_STREAM_CLOSE;
+	cancel_delayed_work_sync(&aw883xx->start_work);
+	mutex_lock(&aw883xx->lock);
+	aw883xx_dev_stop(aw883xx->aw_pa);
+	mutex_unlock(&aw883xx->lock);
+
+}
+
+static const struct snd_soc_dai_ops aw883xx_dai_ops = {
+	.startup = aw883xx_startup,
+	.shutdown = aw883xx_shutdown,
+};
+
+static struct snd_soc_dai_driver aw883xx_dai[] = {
+	{
+		.name = "aw883xx-aif",
+		.id = 1,
+		.playback = {
+			.stream_name = "Speaker_Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW_RATES,
+			.formats = AW_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Speaker_Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW_RATES,
+			.formats = AW_FORMATS,
+		},
+		.ops = &aw883xx_dai_ops,
+	},
+};
+
+/*
+ * codec driver
+ */
+static int aw883xx_get_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw883xx->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
+
+	return 0;
+
+}
+
+static int aw883xx_set_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int time = 0;
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw883xx->aw_pa;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	time = ucontrol->value.integer.value[0];
+
+	if (time < mc->min || time > mc->max)
+		return 0;
+
+	if (time != aw_dev->fade_in_time) {
+		aw_dev->fade_in_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw883xx_get_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw883xx->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
+
+	return 0;
+}
+
+static int aw883xx_set_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw883xx->aw_pa;
+	unsigned int time = 0;
+
+	time = ucontrol->value.integer.value[0];
+	if (time < mc->min || time > mc->max)
+		return 0;
+
+	if (time != aw_dev->fade_out_time) {
+		aw_dev->fade_out_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw883xx_profile_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	int count;
+	char *name = NULL;
+	const char *prof_name = NULL;
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = aw883xx_dev_get_profile_count(aw883xx->aw_pa);
+	if (count <= 0) {
+		uinfo->value.enumerated.items = 0;
+		return 0;
+	}
+
+	uinfo->value.enumerated.items = count;
+
+	if (uinfo->value.enumerated.item >= count)
+		uinfo->value.enumerated.item = count - 1;
+
+	name = uinfo->value.enumerated.name;
+	count = uinfo->value.enumerated.item;
+
+	prof_name = aw883xx_dev_get_prof_name(aw883xx->aw_pa, count);
+	if (!prof_name) {
+		strscpy(uinfo->value.enumerated.name, "null",
+						strlen("null") + 1);
+		return 0;
+	}
+
+	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+
+	return 0;
+}
+
+static int aw883xx_profile_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw883xx_dev_get_profile_index(aw883xx->aw_pa);
+
+	return 0;
+}
+
+static int aw883xx_profile_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	/*pa stop or stopping just set profile*/
+	mutex_lock(&aw883xx->lock);
+	ret = aw883xx_dev_set_profile_index(aw883xx->aw_pa, ucontrol->value.integer.value[0]);
+	if (ret < 0) {
+		dev_dbg(codec->dev, "profile index does not change");
+		mutex_unlock(&aw883xx->lock);
+		return 0;
+	}
+
+	if (aw883xx->pstream) {
+		aw883xx_dev_stop(aw883xx->aw_pa);
+		aw883xx_start(aw883xx, AW_SYNC_START);
+	}
+
+	mutex_unlock(&aw883xx->lock);
+
+	return 1;
+}
+
+static int aw883xx_switch_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw883xx->allow_pw;
+
+	return 0;
+}
+
+static int aw883xx_switch_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int value = 0;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return 0;
+
+	if (value == aw883xx->allow_pw) {
+		dev_dbg(aw883xx->aw_pa->dev, "PA switch not change");
+		return 0;
+	}
+	aw883xx->allow_pw = value;
+
+	if (aw883xx->pstream) {
+		if (!aw883xx->allow_pw) {
+			cancel_delayed_work_sync(&aw883xx->start_work);
+			mutex_lock(&aw883xx->lock);
+			aw883xx_dev_stop(aw883xx->aw_pa);
+			mutex_unlock(&aw883xx->lock);
+		} else {
+			cancel_delayed_work_sync(&aw883xx->start_work);
+			mutex_lock(&aw883xx->lock);
+			aw883xx_start(aw883xx, AW_SYNC_START);
+			mutex_unlock(&aw883xx->lock);
+		}
+	}
+
+	return 1;
+}
+
+static int aw883xx_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw883xx->aw_pa->volume_desc;
+
+	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
+
+	return 0;
+}
+
+static int aw883xx_volume_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	int value = 0;
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw883xx->aw_pa->volume_desc;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return 0;
+
+	if (vol_desc->ctl_volume != value) {
+		vol_desc->ctl_volume = value;
+		aw883xx_dev_set_volume(aw883xx->aw_pa, vol_desc->ctl_volume);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw883xx_get_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw883xx->aw_pa->fade_step;
+
+	return 0;
+}
+
+static int aw883xx_set_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int value = 0;
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return 0;
+
+	if (aw883xx->aw_pa->fade_step != value) {
+		aw883xx->aw_pa->fade_step = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw883xx_re_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	struct aw_device *aw_dev = aw883xx->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->cali_desc.cali_re;
+
+	return 0;
+}
+
+static int aw883xx_re_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	int value = 0;
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
+	struct aw_device *aw_dev = aw883xx->aw_pa;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return 0;
+
+	if (aw_dev->cali_desc.cali_re != value) {
+		aw_dev->cali_desc.cali_re = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new aw883xx_controls[] = {
+	SOC_SINGLE_EXT("PCM Playback Switch", SND_SOC_NOPM, 0, 1, 0,
+				aw883xx_switch_get, aw883xx_switch_set),
+	SOC_SINGLE_EXT("PCM Playback Volume", AW_PID_2049_SYSCTRL2_REG,
+		6, AW_PID_2049_MUTE_VOL, 0, aw883xx_volume_get,
+		aw883xx_volume_set),
+	SOC_SINGLE_EXT("Fade Step", 0, 0, AW_PID_2049_MUTE_VOL, 0,
+		aw883xx_get_fade_step, aw883xx_set_fade_step),
+	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw883xx_get_fade_in_time, aw883xx_set_fade_in_time),
+	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw883xx_get_fade_out_time, aw883xx_set_fade_out_time),
+	SOC_SINGLE_EXT("Calib", 0, 0, 100, 0,
+		aw883xx_re_get, aw883xx_re_set),
+	AW_PROFILE_EXT("Profile Set", aw883xx_profile_info,
+		aw883xx_profile_get, aw883xx_profile_set),
+};
+
+static const struct snd_soc_dapm_widget aw883xx_dapm_widgets[] = {
+	 /* playback */
+	SND_SOC_DAPM_AIF_IN("AIF_RX", "Speaker_Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+	/* capture */
+	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("ADC Input"),
+};
+
+static const struct snd_soc_dapm_route aw883xx_audio_map[] = {
+	{"DAC Output", NULL, "AIF_RX"},
+	{"AIF_TX", NULL, "ADC Input"},
+};
+
+static int aw883xx_codec_probe(struct snd_soc_component *component)
+{
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	int ret = 0;
+
+	/*destroy_workqueue(struct workqueue_struct *wq)*/
+	aw883xx->work_queue = create_singlethread_workqueue("aw883xx");
+	if (!aw883xx->work_queue) {
+		dev_err(aw883xx->aw_pa->dev, "create workqueue failed !");
+		return -EINVAL;
+	}
+
+	INIT_DELAYED_WORK(&aw883xx->start_work, aw883xx_startup_work);
+
+	/*add widgets*/
+	ret = snd_soc_dapm_new_controls(dapm, aw883xx_dapm_widgets,
+							ARRAY_SIZE(aw883xx_dapm_widgets));
+	if (ret < 0)
+		return ret;
+
+	/*add route*/
+	ret = snd_soc_dapm_add_routes(dapm, aw883xx_audio_map,
+							ARRAY_SIZE(aw883xx_audio_map));
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_add_component_controls(component, aw883xx_controls,
+							ARRAY_SIZE(aw883xx_controls));
+
+	return ret;
+}
+
+static void aw883xx_codec_remove(struct snd_soc_component *aw_codec)
+{
+	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(aw_codec);
+
+	cancel_delayed_work_sync(&aw883xx->start_work);
+
+	if (aw883xx->work_queue)
+		destroy_workqueue(aw883xx->work_queue);
+
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_aw883xx = {
+	.probe = aw883xx_codec_probe,
+	.remove = aw883xx_codec_remove,
+};
+
+static struct aw883xx *aw883xx_malloc_init(struct i2c_client *i2c)
+{
+	struct aw883xx *aw883xx = devm_kzalloc(&i2c->dev,
+			sizeof(struct aw883xx), GFP_KERNEL);
+	if (!aw883xx)
+		return NULL;
+
+	aw883xx->aw_pa = NULL;
+	aw883xx->allow_pw = true;
+	aw883xx->work_queue = NULL;
+	mutex_init(&aw883xx->lock);
+
+	return aw883xx;
+}
+
+static void aw883xx_hw_reset(struct aw883xx *aw883xx)
+{
+	if (aw883xx->reset_gpio) {
+		gpiod_set_value_cansleep(aw883xx->reset_gpio, 0);
+		usleep_range(AW_1000_US, AW_1000_US + 10);
+		gpiod_set_value_cansleep(aw883xx->reset_gpio, 1);
+		usleep_range(AW_1000_US, AW_1000_US + 10);
+	} else {
+		dev_err(aw883xx->aw_pa->dev, "%s failed", __func__);
+	}
+}
+
+static int aw883xx_request_firmware_file(struct aw883xx *aw883xx)
+{
+	const struct firmware *cont = NULL;
+	int ret = 0;
+
+	aw883xx->aw_pa->fw_status = AW_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, AW_ACF_FILE, aw883xx->aw_pa->dev);
+	if ((ret < 0) || (!cont)) {
+		dev_err(aw883xx->aw_pa->dev, "load [%s] failed!", AW_ACF_FILE);
+		return ret;
+	}
+
+	dev_info(aw883xx->aw_pa->dev, "loaded %s - size: %zu\n",
+			AW_ACF_FILE, cont ? cont->size : 0);
+
+	aw883xx->aw_cfg = kzalloc(cont->size + sizeof(int), GFP_KERNEL);
+	if (!aw883xx->aw_cfg) {
+		release_firmware(cont);
+		return -ENOMEM;
+	}
+	aw883xx->aw_cfg->len = (int)cont->size;
+	memcpy(aw883xx->aw_cfg->data, cont->data, cont->size);
+	release_firmware(cont);
+
+	ret = aw883xx_dev_load_acf_check(aw883xx->aw_cfg);
+	if (ret < 0) {
+		dev_err(aw883xx->aw_pa->dev, "Load [%s] failed ....!", AW_ACF_FILE);
+		kfree(aw883xx->aw_cfg);
+		aw883xx->aw_cfg = NULL;
+		return ret;
+	}
+
+	dev_info(aw883xx->aw_pa->dev, "%s : bin load success\n", __func__);
+
+	mutex_lock(&aw883xx->lock);
+	/*aw device init*/
+	ret = aw883xx_dev_init(aw883xx->aw_pa, aw883xx->aw_cfg);
+	if (ret < 0) {
+		dev_err(aw883xx->aw_pa->dev, "dev init failed");
+		kfree(aw883xx->aw_cfg);
+	}
+
+	mutex_unlock(&aw883xx->lock);
+
+	return ret;
+}
+
+/*
+ * i2c driver
+ */
+static int aw883xx_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw883xx *aw883xx = NULL;
+	int ret = 0;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
+		dev_err(&i2c->dev, "check_functionality failed");
+		return -EIO;
+	}
+
+	aw883xx = aw883xx_malloc_init(i2c);
+	if (!aw883xx) {
+		dev_err(&i2c->dev, "malloc aw883xx failed");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(i2c, aw883xx);
+
+	aw883xx->reset_gpio = devm_gpiod_get_optional(&i2c->dev,
+								"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw883xx->reset_gpio))
+		dev_info(&i2c->dev, "reset gpio not defined\n");
+
+	/* hardware reset */
+	aw883xx_hw_reset(aw883xx);
+
+	aw883xx->regmap = devm_regmap_init_i2c(i2c, &aw883xx_remap_config);
+	if (IS_ERR(aw883xx->regmap)) {
+		ret = PTR_ERR(aw883xx->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	/*aw pa init*/
+	ret = aw883xx_init(&aw883xx->aw_pa, i2c, aw883xx->regmap);
+	if (ret < 0)
+		return ret;
+
+	ret = aw883xx_request_firmware_file(aw883xx);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "%s failed\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_register_component(&i2c->dev,
+			&soc_codec_dev_aw883xx,
+			aw883xx_dai, ARRAY_SIZE(aw883xx_dai));
+	if (ret < 0) {
+		dev_err(&i2c->dev, "failed to register aw883xx: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void aw883xx_i2c_remove(struct i2c_client *i2c)
+{
+	struct aw883xx *aw883xx = i2c_get_clientdata(i2c);
+
+	aw883xx_deinit(aw883xx->aw_pa);
+	snd_soc_unregister_component(&i2c->dev);
+
+	if (aw883xx->aw_cfg) {
+		kfree(aw883xx->aw_cfg);
+		aw883xx->aw_cfg = NULL;
+	}
+
+}
+
+static const struct i2c_device_id aw883xx_i2c_id[] = {
+	{ AW_I2C_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw883xx_i2c_id);
+
+static struct i2c_driver aw883xx_i2c_driver = {
+	.driver = {
+		.name = AW_I2C_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe_new = aw883xx_i2c_probe,
+	.remove = aw883xx_i2c_remove,
+	.id_table = aw883xx_i2c_id,
+};
+module_i2c_driver(aw883xx_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW883XX Smart PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw883xx/aw883xx.h b/sound/soc/codecs/aw883xx/aw883xx.h
new file mode 100644
index 000000000000..fd19e1cab1f3
--- /dev/null
+++ b/sound/soc/codecs/aw883xx/aw883xx.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * aw883xx.c --  ALSA SoC AW883XX codec support
+ *
+ * Copyright (c) 2022 AWINIC Technology CO., LTD
+ *
+ * Author: Bruce zhao <zhaolei@awinic.com>
+ */
+
+#ifndef __AW883XX_H__
+#define __AW883XX_H__
+
+#define AW_CHIP_ID_REG			(0x00)
+#define AW_START_RETRIES		(5)
+#define AW_START_WORK_DELAY_MS	(0)
+
+#define AW_DSP_16_DATA_MASK		(0x0000ffff)
+
+#define AW_I2C_NAME				"aw883xx_smartpa"
+
+#define AW_RATES (SNDRV_PCM_RATE_8000_48000 | \
+			SNDRV_PCM_RATE_96000)
+#define AW_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+#define FADE_TIME_MAX			100000
+#define FADE_TIME_MIN			0
+
+#define AW_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = profile_info, \
+	.get = profile_get, \
+	.put = profile_set, \
+}
+
+enum {
+	AW_SYNC_START = 0,
+	AW_ASYNC_START,
+};
+
+enum {
+	AW883XX_STREAM_CLOSE = 0,
+	AW883XX_STREAM_OPEN,
+};
+
+struct aw883xx {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct gpio_desc *reset_gpio;
+	bool allow_pw;
+	u8 pstream;
+	struct workqueue_struct *work_queue;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+	struct aw_container *aw_cfg;
+};
+
+#endif
-- 
2.38.1

