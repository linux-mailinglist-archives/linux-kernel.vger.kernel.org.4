Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A692465598E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLXJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 04:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 04:03:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E2D133;
        Sat, 24 Dec 2022 01:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1C9EB82199;
        Sat, 24 Dec 2022 09:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5A6C433D2;
        Sat, 24 Dec 2022 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671872582;
        bh=+kG15PvK63UV0ICAXIsmStskkU/j6a9J1EXGsvuOza4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGJmykkrLFYlsH/py47R/SND2LMXrYtPE9ZqWCRNfucJiV6qdU/M+gzibeW4TNq3u
         RyWzDhCqwA122l25yT5yUrVSWE7KvIBxg/UjdVkgcsbPPPiGidDl480iU0F6X3z+Vd
         zSTxMnRCC85P/FlXxbHTvtw6S8RiSkytNif/aaU4=
Date:   Sat, 24 Dec 2022 10:02:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Message-ID: <Y6bAQ8hDLkvrvjQQ@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-4-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:49PM -0800, Wesley Cheng wrote:
> Create a USB BE component that will register a new USB port to the ASoC USB
> framework.  This will handle determination on if the requested audio
> profile is supported by the USB device currently selected.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  include/sound/q6usboffload.h  |  20 +++
>  sound/soc/qcom/Kconfig        |   4 +
>  sound/soc/qcom/qdsp6/Makefile |   1 +
>  sound/soc/qcom/qdsp6/q6usb.c  | 232 ++++++++++++++++++++++++++++++++++
>  4 files changed, 257 insertions(+)
>  create mode 100644 include/sound/q6usboffload.h
>  create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
> 
> diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
> new file mode 100644
> index 000000000000..e576808901d9
> --- /dev/null
> +++ b/include/sound/q6usboffload.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * linux/sound/q6usboffload.h -- QDSP6 USB offload
> + *
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/**
> + * struct q6usb_offload
> + * @dev - dev handle to usb be

"be"?  What is that?

> + * @sid - streamID for iommu
> + * @intr_num - usb interrupter number
> + * @domain - allocated iommu domain
> + **/
> +struct q6usb_offload {
> +	struct device *dev;

Do you properly reference count this?

> +	u32 sid;
> +	u32 intr_num;
> +	struct iommu_domain *domain;
> +};

What is the lifetime of this structure?  Who owns it?  Where is the lock
for accessing it?

> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 8c7398bc1ca8..d65c365116e5 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -111,6 +111,9 @@ config SND_SOC_QDSP6_APM
>  config SND_SOC_QDSP6_PRM_LPASS_CLOCKS
>  	tristate
>  
> +config SND_SOC_QDSP6_USB
> +	tristate
> +
>  config SND_SOC_QDSP6_PRM
>  	tristate
>  	select SND_SOC_QDSP6_PRM_LPASS_CLOCKS
> @@ -131,6 +134,7 @@ config SND_SOC_QDSP6
>  	select SND_SOC_TOPOLOGY
>  	select SND_SOC_QDSP6_APM
>  	select SND_SOC_QDSP6_PRM
> +	select SND_SOC_QDSP6_USB
>  	help
>  	 To add support for MSM QDSP6 Soc Audio.
>  	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index 3963bf234664..c9457ee898d0 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_APM_DAI) += q6apm-dai.o
>  obj-$(CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI) += q6apm-lpass-dais.o
>  obj-$(CONFIG_SND_SOC_QDSP6_PRM) += q6prm.o
>  obj-$(CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS) += q6prm-clocks.o
> +obj-$(CONFIG_SND_SOC_QDSP6_USB) += q6usb.o
> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
> new file mode 100644
> index 000000000000..a9da6dec6c6f
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6usb.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.

All of the code in this patch series is older than 2022 as I know it has
been in shipping devices for many years.  Please use the proper
copyright year to make your lawyers happy...

> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
> +
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-usb.h>
> +#include <sound/pcm_params.h>
> +#include <sound/asound.h>
> +#include <sound/q6usboffload.h>
> +
> +#include "q6dsp-lpass-ports.h"
> +#include "q6afe.h"
> +
> +struct q6usb_port_data {
> +	struct q6afe_usb_cfg usb_cfg;
> +	struct snd_soc_usb *usb;
> +	struct q6usb_offload priv;
> +	int active_idx;
> +};
> +
> +static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
> +	SND_SOC_DAPM_HP("USB_RX_BE", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
> +	{"USB Playback", NULL, "USB_RX_BE"},
> +};

No terminating entry?  How does this not break?  Why do you need to
specify the size of the array, that feels like a design bug somewhere.


> +
> +static int q6usb_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params,
> +			   struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +static const struct snd_soc_dai_ops q6usb_ops = {
> +	.hw_params	= q6usb_hw_params,
> +};
> +
> +static struct snd_soc_dai_driver q6usb_be_dais[] = {
> +	{
> +		.playback = {
> +			.stream_name = "USB BE RX",
> +			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
> +					SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
> +					SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> +					SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
> +					SNDRV_PCM_RATE_192000,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +					SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
> +					SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
> +					SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rate_max =     192000,
> +			.rate_min =	8000,
> +		},
> +		.id = USB_RX,
> +		.name = "USB_RX_BE",
> +		.ops = &q6usb_ops,
> +	},
> +};
> +
> +int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
> +					const struct of_phandle_args *args,
> +					const char **dai_name)
> +{
> +	int id = args->args[0];
> +	int ret = -EINVAL;
> +	int i;
> +
> +	for (i = 0; i  < ARRAY_SIZE(q6usb_be_dais); i++) {
> +		if (q6usb_be_dais[i].id == id) {
> +			*dai_name = q6usb_be_dais[i].name;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int q6usb_component_probe(struct snd_soc_component *component)
> +{
> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +
> +	data->usb->component = component;
> +
> +	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> +	snd_soc_dapm_sync(dapm);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_component_driver q6usb_dai_component = {
> +	.probe		= q6usb_component_probe,
> +	.name		= "q6usb-dai-component",
> +	.dapm_widgets = q6usb_dai_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(q6usb_dai_widgets),
> +	.dapm_routes = q6usb_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(q6usb_dapm_routes),
> +	.of_xlate_dai_name = q6usb_audio_ports_of_xlate_dai_name,
> +};
> +
> +int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
> +			int connected)
> +{
> +	struct snd_soc_dapm_context *dapm;
> +	struct q6usb_port_data *data;
> +
> +	if (!usb->component)
> +		return 0;

How can this happen?

Why is this not an error?

> +
> +	dapm = snd_soc_component_get_dapm(usb->component);
> +	data = dev_get_drvdata(usb->component->dev);
> +
> +	if (connected) {
> +		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
> +		/* We only track the latest USB headset plugged in */
> +		data->active_idx = card_idx;
> +	} else {
> +		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> +	}
> +	snd_soc_dapm_sync(dapm);
> +
> +	return 0;
> +}
> +
> +static int q6usb_dai_dev_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct q6usb_port_data *data;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(node, "qcom,usb-audio-stream-id",
> +				&data->priv.sid);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read sid.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(node, "qcom,usb-audio-intr-num",
> +				&data->priv.intr_num);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to read intr num.\n");
> +		return -ENODEV;
> +	}
> +
> +	data->priv.domain = iommu_domain_alloc(pdev->dev.bus);
> +	if (!data->priv.domain) {
> +		dev_err(&pdev->dev, "failed to allocate iommu domain\n");
> +		return -ENODEV;
> +	}
> +
> +	/* attach to external processor iommu */
> +	ret = iommu_attach_device(data->priv.domain, &pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to attach device ret = %d\n", ret);
> +		goto free_domain;
> +	}
> +
> +	data->usb = snd_soc_usb_add_port(dev, q6usb_alsa_connection_cb);
> +	if (IS_ERR(data->usb)) {
> +		dev_err(&pdev->dev, "failed to add usb port\n");
> +		goto detach_device;
> +	}
> +
> +	data->priv.dev = dev;
> +	dev_set_drvdata(dev, data);
> +	devm_snd_soc_register_component(dev, &q6usb_dai_component,
> +							q6usb_be_dais, ARRAY_SIZE(q6usb_be_dais));

Very odd indentation.  Please do this properly everywhere.


> +	snd_soc_usb_set_priv_data(&data->priv);
> +
> +	return 0;
> +
> +detach_device:
> +	iommu_detach_device(data->priv.domain, &pdev->dev);
> +free_domain:
> +	iommu_domain_free(data->priv.domain);
> +
> +	return ret;
> +}
> +
> +static int q6usb_dai_dev_remove(struct platform_device *pdev)
> +{
> +	struct q6usb_port_data *data = platform_get_drvdata(pdev);
> +
> +	iommu_detach_device(data->priv.domain, &pdev->dev);
> +	iommu_domain_free(data->priv.domain);
> +
> +	snd_soc_usb_remove_port();
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF

Is this really needed still?

thanks,

greg k-h
