Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1903659844
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiL3MdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3MdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:33:03 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCC3885
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:33:01 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BEZApfyOlIwEfBEZApwsi7; Fri, 30 Dec 2022 13:32:58 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Dec 2022 13:32:58 +0100
X-ME-IP: 86.243.100.34
Message-ID: <d7c58f99-6c37-3e0a-b8c7-0026b5d523a4@wanadoo.fr>
Date:   Fri, 30 Dec 2022 13:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V8 1/5] ASoC: codecs: Add i2c and codec registration for
 aw883xx and their associated operation functions
To:     wangweidong.a@awinic.com
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
 <20221230093454.190579-2-wangweidong.a@awinic.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cezary.rojewski@intel.com, ckeepax@opensource.cirrus.com,
        devicetree@vger.kernel.org, duanyibo@awinic.com,
        flatmax@flatmax.com, james.schulman@cirrus.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, stephan@gerhold.net, steve@sk2.org,
        tanureal@opensource.cirrus.com, tiwai@suse.com,
        yijiangtao@awinic.com, zhaolei@awinic.com, zhuning0077@gmail.com
In-Reply-To: <20221230093454.190579-2-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/12/2022 à 10:34, 
wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org a écrit :
> From: Weidong Wang <wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> 
> The Awinic AW883XX is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert
> 

Hi,
a few nits below related to un needed extra new lines and some error 
handling in the probe.

> Signed-off-by: Nick Li <liweilei-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bruce zhao <zhaolei-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Weidong Wang <wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> ---
>   sound/soc/codecs/aw883xx/aw883xx.c | 667 +++++++++++++++++++++++++++++
>   sound/soc/codecs/aw883xx/aw883xx.h |  59 +++
>   2 files changed, 726 insertions(+)
>   create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
>   create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
> 
> diff --git a/sound/soc/codecs/aw883xx/aw883xx.c b/sound/soc/codecs/aw883xx/aw883xx.c
> new file mode 100644
> index 000000000000..3ab50377cb1f
> --- /dev/null
> +++ b/sound/soc/codecs/aw883xx/aw883xx.c
> @@ -0,0 +1,667 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * aw883xx.c --  ALSA SoC AW883XX codec support
> + *
> + * Copyright (c) 2022 AWINIC Technology CO., LTD
> + *
> + * Author: Bruce zhao <zhaolei-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> + * Author: Weidong Wang <wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/firmware.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +#include "aw883xx_pid_2049_reg.h"
> +#include "aw883xx.h"
> +#include "aw883xx_device.h"
> +
> +static const struct regmap_config aw883xx_remap_config = {
> +	.val_bits = 16,
> +	.reg_bits = 8,
> +	.max_register = AW_PID_2049_REG_MAX - 1,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +};
> +
> +static void aw883xx_start_pa(struct aw883xx *aw883xx)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < AW_START_RETRIES; i++) {
> +		ret = aw883xx_dev_start(aw883xx->aw_pa);
> +		if (ret) {
> +			dev_err(aw883xx->aw_pa->dev, "aw883xx device start failed. retry = %d", i);
> +			ret = aw883xx_dev_fw_update(aw883xx->aw_pa, AW_DSP_FW_UPDATE_ON, true);
> +			if (ret < 0) {
> +				dev_err(aw883xx->aw_pa->dev, "fw update failed");
> +				continue;
> +			}
> +		} else {
> +			dev_info(aw883xx->aw_pa->dev, "start success\n");
> +			break;
> +		}
> +	}
> +}
> +
> +static void aw883xx_startup_work(struct work_struct *work)
> +{
> +	struct aw883xx *aw883xx =
> +		container_of(work, struct aw883xx, start_work.work);
> +
> +	mutex_lock(&aw883xx->lock);
> +	aw883xx_start_pa(aw883xx);
> +	mutex_unlock(&aw883xx->lock);
> +}
> +
> +static void aw883xx_start(struct aw883xx *aw883xx, bool sync_start)
> +{
> +	int ret;
> +
> +	if (aw883xx->aw_pa->fw_status != AW_DEV_FW_OK)
> +		return;
> +
> +	if (!aw883xx->allow_power) {
> +		dev_info(aw883xx->aw_pa->dev, "%s:dev can not allow power", __func__);
> +		return;
> +	}
> +
> +	if (aw883xx->aw_pa->status == AW_DEV_PW_ON)
> +		return;
> +
> +	ret = aw883xx_dev_fw_update(aw883xx->aw_pa, AW_DSP_FW_UPDATE_OFF, true);
> +	if (ret < 0) {
> +		dev_err(aw883xx->aw_pa->dev, "fw update failed.");
> +		return;
> +	}
> +
> +	if (sync_start == AW_SYNC_START)
> +		aw883xx_start_pa(aw883xx);
> +	else
> +		queue_delayed_work(system_wq,
> +			&aw883xx->start_work,
> +			AW_START_WORK_DELAY_MS);
> +}
> +
> +static int aw883xx_startup(struct snd_pcm_substream *substream,
> +			struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	mutex_lock(&aw883xx->lock);
> +	aw883xx_start(aw883xx, AW_ASYNC_START);
> +	mutex_unlock(&aw883xx->lock);
> +
> +	return 0;
> +}
> +
> +static void aw883xx_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	cancel_delayed_work_sync(&aw883xx->start_work);
> +	mutex_lock(&aw883xx->lock);
> +	aw883xx_dev_stop(aw883xx->aw_pa);
> +	mutex_unlock(&aw883xx->lock);
> +

Un-needed new line.

> +}
> +
> +static const struct snd_soc_dai_ops aw883xx_dai_ops = {
> +	.startup = aw883xx_startup,
> +	.shutdown = aw883xx_shutdown,
> +};
> +
> +static struct snd_soc_dai_driver aw883xx_dai[] = {
> +	{
> +		.name = "aw883xx-aif",
> +		.id = 1,
> +		.playback = {
> +			.stream_name = "Speaker_Playback",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = AW_RATES,
> +			.formats = AW_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "Speaker_Capture",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = AW_RATES,
> +			.formats = AW_FORMATS,
> +		},
> +		.ops = &aw883xx_dai_ops,
> +	},
> +};
> +
> +static int aw883xx_get_fade_in_time(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +
> +	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
> +
> +	return 0;
> +

Un-needed new line.

> +}
> +
> +static int aw883xx_set_fade_in_time(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +	int time;
> +
> +	time = ucontrol->value.integer.value[0];
> +
> +	if (time < mc->min || time > mc->max)
> +		return 0;
> +
> +	if (time != aw_dev->fade_in_time) {
> +		aw_dev->fade_in_time = time;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw883xx_get_fade_out_time(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +
> +	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
> +
> +	return 0;
> +}
> +
> +static int aw883xx_set_fade_out_time(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +	int time;
> +
> +	time = ucontrol->value.integer.value[0];
> +	if (time < mc->min || time > mc->max)
> +		return 0;
> +
> +	if (time != aw_dev->fade_out_time) {
> +		aw_dev->fade_out_time = time;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw883xx_profile_info(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	const char *prof_name;
> +	char *name;
> +	int count;
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
> +	uinfo->count = 1;
> +
> +	count = aw883xx_dev_get_profile_count(aw883xx->aw_pa);
> +	if (count <= 0) {
> +		uinfo->value.enumerated.items = 0;
> +		return 0;
> +	}
> +
> +	uinfo->value.enumerated.items = count;
> +
> +	if (uinfo->value.enumerated.item >= count)
> +		uinfo->value.enumerated.item = count - 1;
> +
> +	name = uinfo->value.enumerated.name;
> +	count = uinfo->value.enumerated.item;
> +
> +	prof_name = aw883xx_dev_get_prof_name(aw883xx->aw_pa, count);
> +	if (!prof_name) {
> +		strscpy(uinfo->value.enumerated.name, "null",
> +						strlen("null") + 1);
> +		return 0;
> +	}
> +
> +	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
> +
> +	return 0;
> +}
> +
> +static int aw883xx_profile_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] = aw883xx_dev_get_profile_index(aw883xx->aw_pa);
> +
> +	return 0;
> +}
> +
> +static int aw883xx_profile_set(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	int ret;
> +
> +	/* pa stop or stopping just set profile */
> +	mutex_lock(&aw883xx->lock);
> +	ret = aw883xx_dev_set_profile_index(aw883xx->aw_pa, ucontrol->value.integer.value[0]);
> +	if (ret < 0) {
> +		dev_dbg(codec->dev, "profile index does not change");
> +		mutex_unlock(&aw883xx->lock);
> +		return 0;
> +	}
> +
> +	if (aw883xx->aw_pa->status) {
> +		aw883xx_dev_stop(aw883xx->aw_pa);
> +		aw883xx_start(aw883xx, AW_SYNC_START);
> +	}
> +
> +	mutex_unlock(&aw883xx->lock);
> +
> +	return 1;
> +}
> +
> +static int aw883xx_switch_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] = aw883xx->allow_power;
> +
> +	return 0;
> +}
> +
> +static int aw883xx_switch_set(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int value;
> +
> +	value = ucontrol->value.integer.value[0];
> +	if (value < mc->min || value > mc->max)
> +		return 0;
> +
> +	if (value == aw883xx->allow_power) {
> +		dev_dbg(aw883xx->aw_pa->dev, "PA switch not change");
> +		return 0;
> +	}
> +	aw883xx->allow_power = value;
> +
> +	if (aw883xx->aw_pa->status) {
> +		cancel_delayed_work_sync(&aw883xx->start_work);
> +		mutex_lock(&aw883xx->lock);
> +
> +		if (!aw883xx->allow_power)
> +			aw883xx_dev_stop(aw883xx->aw_pa);
> +		else
> +			aw883xx_start(aw883xx, AW_SYNC_START);
> +
> +		mutex_unlock(&aw883xx->lock);
> +	}
> +
> +	return 1;
> +}
> +
> +static int aw883xx_volume_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct aw_volume_desc *vol_desc = &aw883xx->aw_pa->volume_desc;
> +
> +	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
> +
> +	return 0;
> +}
> +
> +static int aw883xx_volume_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct aw_volume_desc *vol_desc = &aw883xx->aw_pa->volume_desc;
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int value;
> +
> +	value = ucontrol->value.integer.value[0];
> +	if (value < mc->min || value > mc->max)
> +		return 0;
> +
> +	if (vol_desc->ctl_volume != value) {
> +		vol_desc->ctl_volume = value;
> +		aw883xx_dev_set_volume(aw883xx->aw_pa, vol_desc->ctl_volume);
> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw883xx_get_fade_step(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] = aw883xx->aw_pa->fade_step;
> +
> +	return 0;
> +}
> +
> +static int aw883xx_set_fade_step(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int value;
> +
> +	value = ucontrol->value.integer.value[0];
> +	if (value < mc->min || value > mc->max)
> +		return 0;
> +
> +	if (aw883xx->aw_pa->fade_step != value) {
> +		aw883xx->aw_pa->fade_step = value;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw883xx_re_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +
> +	ucontrol->value.integer.value[0] = aw_dev->cali_desc.cali_re;
> +
> +	return 0;
> +}
> +
> +static int aw883xx_re_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +	int value;
> +
> +	value = ucontrol->value.integer.value[0];
> +	if (value < mc->min || value > mc->max)
> +		return 0;
> +
> +	if (aw_dev->cali_desc.cali_re != value) {
> +		aw_dev->cali_desc.cali_re = value;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new aw883xx_controls[] = {
> +	SOC_SINGLE_EXT("PCM Playback Switch", SND_SOC_NOPM, 0, 1, 0,
> +				aw883xx_switch_get, aw883xx_switch_set),
> +	SOC_SINGLE_EXT("PCM Playback Volume", AW_PID_2049_SYSCTRL2_REG,
> +		6, AW_PID_2049_MUTE_VOL, 0, aw883xx_volume_get,
> +		aw883xx_volume_set),
> +	SOC_SINGLE_EXT("Fade Step", 0, 0, AW_PID_2049_MUTE_VOL, 0,
> +		aw883xx_get_fade_step, aw883xx_set_fade_step),
> +	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
> +		aw883xx_get_fade_in_time, aw883xx_set_fade_in_time),
> +	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
> +		aw883xx_get_fade_out_time, aw883xx_set_fade_out_time),
> +	SOC_SINGLE_EXT("Calib", 0, 0, 100, 0,
> +		aw883xx_re_get, aw883xx_re_set),
> +	AW_PROFILE_EXT("Profile Set", aw883xx_profile_info,
> +		aw883xx_profile_get, aw883xx_profile_set),
> +};
> +
> +static const struct snd_soc_dapm_widget aw883xx_dapm_widgets[] = {
> +	 /* playback */
> +	SND_SOC_DAPM_AIF_IN("AIF_RX", "Speaker_Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_OUTPUT("DAC Output"),
> +	/* capture */
> +	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_INPUT("ADC Input"),
> +};
> +
> +static const struct snd_soc_dapm_route aw883xx_audio_map[] = {
> +	{"DAC Output", NULL, "AIF_RX"},
> +	{"AIF_TX", NULL, "ADC Input"},
> +};
> +
> +static int aw883xx_codec_probe(struct snd_soc_component *component)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	INIT_DELAYED_WORK(&aw883xx->start_work, aw883xx_startup_work);
> +
> +	/* add widgets */
> +	ret = snd_soc_dapm_new_controls(dapm, aw883xx_dapm_widgets,
> +							ARRAY_SIZE(aw883xx_dapm_widgets));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* add route */
> +	ret = snd_soc_dapm_add_routes(dapm, aw883xx_audio_map,
> +							ARRAY_SIZE(aw883xx_audio_map));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_add_component_controls(component, aw883xx_controls,
> +							ARRAY_SIZE(aw883xx_controls));
> +
> +	return ret;
> +}
> +
> +static void aw883xx_codec_remove(struct snd_soc_component *aw_codec)
> +{
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(aw_codec);
> +
> +	cancel_delayed_work_sync(&aw883xx->start_work);
> +

un-needed new line.

> +}
> +
> +static const struct snd_soc_component_driver soc_codec_dev_aw883xx = {
> +	.probe = aw883xx_codec_probe,
> +	.remove = aw883xx_codec_remove,
> +};
> +
> +static struct aw883xx *aw883xx_malloc_init(struct i2c_client *i2c)
> +{
> +	struct aw883xx *aw883xx = devm_kzalloc(&i2c->dev,
> +			sizeof(struct aw883xx), GFP_KERNEL);
> +	if (!aw883xx)
> +		return NULL;
> +
> +	aw883xx->aw_pa = NULL;

Un-needed. The structure is kzalloc()'ed, and other pointers are not set 
to NULL anyway.

> +	aw883xx->allow_power = true;
> +	mutex_init(&aw883xx->lock);
> +
> +	return aw883xx;
> +}
> +
> +static void aw883xx_hw_reset(struct aw883xx *aw883xx)
> +{
> +	if (aw883xx->reset_gpio) {
> +		gpiod_set_value_cansleep(aw883xx->reset_gpio, 0);
> +		usleep_range(AW_1000_US, AW_1000_US + 10);
> +		gpiod_set_value_cansleep(aw883xx->reset_gpio, 1);
> +		usleep_range(AW_1000_US, AW_1000_US + 10);
> +	} else {
> +		dev_err(aw883xx->aw_pa->dev, "%s failed", __func__);
> +	}
> +}
> +
> +static int aw883xx_request_firmware_file(struct aw883xx *aw883xx)
> +{
> +	const struct firmware *cont = NULL;
> +	int ret;
> +
> +	aw883xx->aw_pa->fw_status = AW_DEV_FW_FAILED;
> +
> +	ret = request_firmware(&cont, AW_ACF_FILE, aw883xx->aw_pa->dev);
> +	if ((ret < 0) || (!cont)) {
> +		dev_err(aw883xx->aw_pa->dev, "load [%s] failed!", AW_ACF_FILE);
> +		return ret;
> +	}
> +
> +	dev_info(aw883xx->aw_pa->dev, "loaded %s - size: %zu\n",
> +			AW_ACF_FILE, cont ? cont->size : 0);
> +
> +	aw883xx->aw_cfg = kzalloc(cont->size + sizeof(int), GFP_KERNEL);

devm_kzalloc() to simplify error handling and the remove function?
This would also avoid a memory leak if snd_soc_register_component() 
fails in the probe. (or it should be handled in the error handling path)

> +	if (!aw883xx->aw_cfg) {
> +		release_firmware(cont);
> +		return -ENOMEM;
> +	}
> +	aw883xx->aw_cfg->len = (int)cont->size;
> +	memcpy(aw883xx->aw_cfg->data, cont->data, cont->size);
> +	release_firmware(cont);
> +
> +	ret = aw883xx_dev_load_acf_check(aw883xx->aw_pa, aw883xx->aw_cfg);
> +	if (ret < 0) {
> +		dev_err(aw883xx->aw_pa->dev, "Load [%s] failed ....!", AW_ACF_FILE);
> +		kfree(aw883xx->aw_cfg);
> +		aw883xx->aw_cfg = NULL;
> +		return ret;
> +	}
> +
> +	dev_info(aw883xx->aw_pa->dev, "%s : bin load success\n", __func__);
> +
> +	mutex_lock(&aw883xx->lock);
> +	/* aw device init */
> +	ret = aw883xx_dev_init(aw883xx->aw_pa, aw883xx->aw_cfg);
> +	if (ret < 0) {
> +		dev_err(aw883xx->aw_pa->dev, "dev init failed");
> +		kfree(aw883xx->aw_cfg);
> +	}
> +
> +	mutex_unlock(&aw883xx->lock);
> +
> +	return ret;
> +}
> +
> +static int aw883xx_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct aw883xx *aw883xx;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&i2c->dev, "check_functionality failed");
> +		return -EIO;
> +	}
> +
> +	aw883xx = aw883xx_malloc_init(i2c);
> +	if (!aw883xx) {
> +		dev_err(&i2c->dev, "malloc aw883xx failed");
> +		return -ENOMEM;
> +	}
> +	i2c_set_clientdata(i2c, aw883xx);
> +
> +	aw883xx->reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> +								"reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(aw883xx->reset_gpio))
> +		dev_info(&i2c->dev, "reset gpio not defined\n");
> +
> +	/* hardware reset */
> +	aw883xx_hw_reset(aw883xx);
> +
> +	aw883xx->regmap = devm_regmap_init_i2c(i2c, &aw883xx_remap_config);
> +	if (IS_ERR(aw883xx->regmap)) {
> +		ret = PTR_ERR(aw883xx->regmap);
> +		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* aw pa init */
> +	ret = aw883xx_init(&aw883xx->aw_pa, i2c, aw883xx->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = aw883xx_request_firmware_file(aw883xx);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "%s failed\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_register_component(&i2c->dev,
> +			&soc_codec_dev_aw883xx,
> +			aw883xx_dai, ARRAY_SIZE(aw883xx_dai));
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "failed to register aw883xx: %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;

aw883xx_deinit() is called in the remove function. It is likely that an 
error handling path is also needed in the probe.

> +}
> +
> +static void aw883xx_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct aw883xx *aw883xx = i2c_get_clientdata(i2c);
> +
> +	aw883xx_deinit(aw883xx->aw_pa);
> +	snd_soc_unregister_component(&i2c->dev);
> +
> +	if (aw883xx->aw_cfg) {

I think that 'aw883xx->aw_cfg' can't be NULL at this point.
More-over, should it be NULL, kfree can handle it.

> +		kfree(aw883xx->aw_cfg);
> +		aw883xx->aw_cfg = NULL;
> +	}
> +

Un-needed new line.

> +}
> +
> +static const struct i2c_device_id aw883xx_i2c_id[] = {
> +	{ AW_I2C_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, aw883xx_i2c_id);
> +
> +static struct i2c_driver aw883xx_i2c_driver = {
> +	.driver = {
> +		.name = AW_I2C_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe_new = aw883xx_i2c_probe,
> +	.remove = aw883xx_i2c_remove,
> +	.id_table = aw883xx_i2c_id,
> +};
> +module_i2c_driver(aw883xx_i2c_driver);
> +
> +MODULE_DESCRIPTION("ASoC AW883XX Smart PA Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/codecs/aw883xx/aw883xx.h b/sound/soc/codecs/aw883xx/aw883xx.h
> new file mode 100644
> index 000000000000..e72d8938a4c7
> --- /dev/null
> +++ b/sound/soc/codecs/aw883xx/aw883xx.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * aw883xx.c --  ALSA SoC AW883XX codec support
> + *
> + * Copyright (c) 2022 AWINIC Technology CO., LTD
> + *
> + * Author: Bruce zhao <zhaolei-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> + */
> +
> +#ifndef __AW883XX_H__
> +#define __AW883XX_H__
> +
> +#define AW_CHIP_ID_REG			(0x00)
> +#define AW_START_RETRIES		(5)
> +#define AW_START_WORK_DELAY_MS		(0)
> +
> +#define AW_DSP_16_DATA_MASK		(0x0000ffff)
> +
> +#define AW_I2C_NAME			"aw883xx_smartpa"
> +
> +#define AW_RATES (SNDRV_PCM_RATE_8000_48000 | \
> +			SNDRV_PCM_RATE_96000)
> +#define AW_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
> +			SNDRV_PCM_FMTBIT_S24_LE | \
> +			SNDRV_PCM_FMTBIT_S32_LE)
> +
> +#define FADE_TIME_MAX			100000
> +#define FADE_TIME_MIN			0
> +
> +#define AW_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
> +{ \
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +	.name = xname, \
> +	.info = profile_info, \
> +	.get = profile_get, \
> +	.put = profile_set, \
> +}
> +
> +enum {
> +	AW_SYNC_START = 0,
> +	AW_ASYNC_START,
> +};
> +
> +enum {
> +	AW883XX_STREAM_CLOSE = 0,
> +	AW883XX_STREAM_OPEN,
> +};
> +
> +struct aw883xx {
> +	struct aw_device *aw_pa;
> +	struct mutex lock;
> +	struct gpio_desc *reset_gpio;
> +	bool allow_power;
> +	struct delayed_work start_work;
> +	struct regmap *regmap;
> +	struct aw_container *aw_cfg;
> +};
> +
> +#endif

