Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2B654573
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiLVRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:05:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06E1E3F4;
        Thu, 22 Dec 2022 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671728738; x=1703264738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4XE5PPSOHqIzjPC8evx+SqZsIyJTW+wfEzMNdCa3iyk=;
  b=J9eLmj3syKR2ewKCLUlnCmQuEI/YbmLhHuz0rdYPeQnbiuwWpPqGgt2a
   AyUb5w1FcymvitwWvDODxT1Za2Ux23RvO+GSZEw1V7RaNFF/uQc8QpOGU
   0A2fZJ58fY146biWA7e0On7bymBfPKITVKSeWJmDzdHtb8XhV6npCyq0V
   oNqXYxevi43ZHh2pjE7DN0Brr7BW72M4c9fOBlR3u/b+fzv9Oj3tS18CZ
   5J8okUpFpm/whBTszjH53IuD6/umCFnXF7LI2uVYdansVZGp45tJfwJRJ
   CV/G1Be34LKZtjcoolaXWjoZnerNtER11GzdvSzjT9GVEoWVKeQQrqRZb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406410611"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="406410611"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:03:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="794175658"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="794175658"
Received: from rpurdy-mobl.amr.corp.intel.com (HELO [10.212.42.91]) ([10.212.42.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:03:56 -0800
Message-ID: <29825fd6-ee41-226e-9030-2034e7e80591@linux.intel.com>
Date:   Thu, 22 Dec 2022 09:09:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V7 1/5] ASoC: codecs: Add i2c and codec registration for
 aw883xx and their associated operation functions
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.cirrus.com, peter.ujfalusi@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        ryan.lee.analog@gmail.com, jonathan.albrieux@gmail.com,
        tanureal@opensource.cirrus.com, povik+lin@cutebit.org,
        13691752556@139.com, cezary.rojewski@intel.com,
        stephan@gerhold.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com, duanyibo@awinic.com
References: <20221222123205.106353-1-wangweidong.a@awinic.com>
 <20221222123205.106353-2-wangweidong.a@awinic.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221222123205.106353-2-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/22 06:32, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> The Awinic AW883XX is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert
> 
> Signed-off-by: Nick Li <liweilei@awinic.com>
> Signed-off-by: Bruce zhao <zhaolei@awinic.com>
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  sound/soc/codecs/aw883xx/aw883xx.c | 706 +++++++++++++++++++++++++++++
>  sound/soc/codecs/aw883xx/aw883xx.h |  61 +++
>  2 files changed, 767 insertions(+)
>  create mode 100644 sound/soc/codecs/aw883xx/aw883xx.c
>  create mode 100644 sound/soc/codecs/aw883xx/aw883xx.h
> 
> diff --git a/sound/soc/codecs/aw883xx/aw883xx.c b/sound/soc/codecs/aw883xx/aw883xx.c
> new file mode 100644
> index 000000000000..0abf8d96d2fe
> --- /dev/null
> +++ b/sound/soc/codecs/aw883xx/aw883xx.c
> @@ -0,0 +1,706 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * aw883xx.c --  ALSA SoC AW883XX codec support
> + *
> + * Copyright (c) 2022 AWINIC Technology CO., LTD
> + *
> + * Author: Bruce zhao <zhaolei@awinic.com>
> + * Author: Weidong Wang <wangweidong.a@awinic.com>
> + */
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
> +	if (!aw883xx->allow_pw) {
> +		dev_info(aw883xx->aw_pa->dev, "%s:dev can not allow power", __func__);
> +		return;
> +	}
> +
> +	if (aw883xx->pstream == AW883XX_STREAM_CLOSE) {
> +		dev_info(aw883xx->aw_pa->dev, "%s:pstream is close", __func__);
> +		return;
> +	}
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
> +	int i;
> +
> +	if (aw883xx->aw_pa->fw_status != AW_DEV_FW_OK)
> +		return;
> +
> +	if (!aw883xx->allow_pw) {
> +		dev_info(aw883xx->aw_pa->dev, "%s:dev can not allow power", __func__);
> +		return;
> +	}
> +
> +	if (aw883xx->aw_pa->status == AW_DEV_PW_ON)
> +		return;
> +
> +	for (i = 0; i < AW_START_RETRIES; i++) {
> +		ret = aw883xx_dev_fw_update(aw883xx->aw_pa, AW_DSP_FW_UPDATE_OFF, true);
> +		if (ret < 0) {
> +			dev_err(aw883xx->aw_pa->dev, "fw update failed. retry = %d", i);
> +			continue;
> +		} else {
> +			/*firmware update success*/
> +			if (sync_start == AW_SYNC_START)
> +				aw883xx_start_pa(aw883xx);

If I scroll two functions above, I see this:

static void aw883xx_start_pa(struct aw883xx *aw883xx)
{
	int ret, i;

[...0]

        for (i = 0; i < AW_START_RETRIES; i++) {
		ret = aw883xx_dev_start(aw883xx->aw_pa);
		if (ret) {
			dev_err(aw883xx->aw_pa->dev, "aw883xx device start failed. retry =
%d", i);
			ret = aw883xx_dev_fw_update(aw883xx->aw_pa, AW_DSP_FW_UPDATE_ON, true);

so your handling of retries is rather convoluted, with two nested retry
loops.

> +			else
> +				queue_delayed_work(aw883xx->work_queue,
> +					&aw883xx->start_work,
> +					AW_START_WORK_DELAY_MS);
> +			return;
> +		}
> +	}
> +}
> +
> +/*
> + * Digital Audio Interface
> + */
> +static int aw883xx_startup(struct snd_pcm_substream *substream,
> +			struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +
> +	aw883xx->pstream = AW883XX_STREAM_OPEN;
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
> +	aw883xx->pstream = AW883XX_STREAM_CLOSE;

it's a bit odd that you are setting the state before the transitions happen.

> +	cancel_delayed_work_sync(&aw883xx->start_work);
> +	mutex_lock(&aw883xx->lock);
> +	aw883xx_dev_stop(aw883xx->aw_pa);
> +	mutex_unlock(&aw883xx->lock);
> +
> +}

> +static int aw883xx_set_fade_in_time(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	unsigned int time = 0;

useless initialization, and move this declaration lower (reverse x-mas
tree style).

> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	struct aw_device *aw_dev = aw883xx->aw_pa;
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
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
> +	unsigned int time = 0;

useless init, you override the value on the next line.

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
> +	int count;
> +	char *name = NULL;

useless init, and reverse the declaration order.

> +	const char *prof_name = NULL;

useless init

> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
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
> +	/*pa stop or stopping just set profile*/

use spaces after and before /* and */

> +	mutex_lock(&aw883xx->lock);
> +	ret = aw883xx_dev_set_profile_index(aw883xx->aw_pa, ucontrol->value.integer.value[0]);
> +	if (ret < 0) {
> +		dev_dbg(codec->dev, "profile index does not change");
> +		mutex_unlock(&aw883xx->lock);
> +		return 0;
> +	}
> +
> +	if (aw883xx->pstream) {
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
> +	ucontrol->value.integer.value[0] = aw883xx->allow_pw;
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
> +	unsigned int value = 0;

useless init

> +
> +	value = ucontrol->value.integer.value[0];
> +	if (value < mc->min || value > mc->max)
> +		return 0;
> +
> +	if (value == aw883xx->allow_pw) {
> +		dev_dbg(aw883xx->aw_pa->dev, "PA switch not change");
> +		return 0;
> +	}
> +	aw883xx->allow_pw = value;
> +
> +	if (aw883xx->pstream) {
> +		if (!aw883xx->allow_pw) {
> +			cancel_delayed_work_sync(&aw883xx->start_work);
> +			mutex_lock(&aw883xx->lock);
> +			aw883xx_dev_stop(aw883xx->aw_pa);
> +			mutex_unlock(&aw883xx->lock);
> +		} else {
> +			cancel_delayed_work_sync(&aw883xx->start_work);

the cancel_delayed_work_sync can be moved outside of the test, and so
can the mutex_lock and mutex_unlock. What's in the test should be
aw883xx_dev_stop() and aw883xx_start()

> +			mutex_lock(&aw883xx->lock);
> +			aw883xx_start(aw883xx, AW_SYNC_START);
> +			mutex_unlock(&aw883xx->lock);
> +		}
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
> +	int value = 0;

useless init and reverse order. same for the rest of the code.

> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(codec);
> +	struct aw_volume_desc *vol_desc = &aw883xx->aw_pa->volume_desc;
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
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

> +static int aw883xx_codec_probe(struct snd_soc_component *component)
> +{
> +	struct aw883xx *aw883xx = snd_soc_component_get_drvdata(component);
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +	int ret = 0;
> +
> +	/*destroy_workqueue(struct workqueue_struct *wq)*/
> +	aw883xx->work_queue = create_singlethread_workqueue("aw883xx");

why do you need your own workqueue? It's common for codec/amplifiers to
use a default one.

> +	if (!aw883xx->work_queue) {
> +		dev_err(aw883xx->aw_pa->dev, "create workqueue failed !");
> +		return -EINVAL;
> +	}
> +
> +	INIT_DELAYED_WORK(&aw883xx->start_work, aw883xx_startup_work);
> +
> +	/*add widgets*/
> +	ret = snd_soc_dapm_new_controls(dapm, aw883xx_dapm_widgets,
> +							ARRAY_SIZE(aw883xx_dapm_widgets));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*add route*/
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
> +	if (aw883xx->work_queue)

do you need to test this? The probe will not succeed without a workqueue
created.

> +		destroy_workqueue(aw883xx->work_queue);
> +
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
> +	aw883xx->allow_pw = true;

what does 'pw' stand for?

> +	aw883xx->work_queue = NULL;
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
> +	int ret = 0;
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
> +	if (!aw883xx->aw_cfg) {
> +		release_firmware(cont);
> +		return -ENOMEM;
> +	}
> +	aw883xx->aw_cfg->len = (int)cont->size;
> +	memcpy(aw883xx->aw_cfg->data, cont->data, cont->size);
> +	release_firmware(cont);
> +
> +	ret = aw883xx_dev_load_acf_check(aw883xx->aw_cfg);
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
> +	/*aw device init*/
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
> +/*
> + * i2c driver
> + */
> +static int aw883xx_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct aw883xx *aw883xx = NULL;
> +	int ret = 0;
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
> +	/*aw pa init*/
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
> +		kfree(aw883xx->aw_cfg);
> +		aw883xx->aw_cfg = NULL;
> +	}
> +
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

"GPL"

