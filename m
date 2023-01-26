Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23267D172
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjAZQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjAZQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:26:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DD6F209;
        Thu, 26 Jan 2023 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674750327; x=1706286327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSOhY7Uv65igMIrvhXXRk2vWZmq7sA/l6fN6PS7evBs=;
  b=OXPJqqTXh3bAnsj5iRnNQ+jMCKO7Kj/pmyWxvvo0ZCFTPyCTAdOFA/Z2
   9kk+Tntsxrw2XDtNsZwEIFhAh5XsSVqB9pqsfFpzF5tDnpJaYxVoc3jSH
   PGif52343fz2b0uYAsfCiKJ1vGV1dgTGMbe6t6abD6njwsjsakGjED21U
   viEL5GkzxlgEyJN02mccB0o7I9+rGUzjNajoqGyzpZ8jLubBKSQ/TxDGW
   B/wYxZbCXxVxryRDmo4OZLrTj7A3FZV7B0pMB1JLeTteC7sPud4S61aUu
   UqqoUyUQvrwcVyTdm8TLoLGVqO0o3eFPNrszrUmujnlkx2CaZdNPPFJ++
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354154693"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354154693"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612855083"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612855083"
Received: from nmani1-mobl2.amr.corp.intel.com (HELO [10.209.167.178]) ([10.209.167.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:39 -0800
Message-ID: <940fdc34-3d45-05be-7087-31f576114418@linux.intel.com>
Date:   Thu, 26 Jan 2023 10:07:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 16/22] sound: usb: Introduce QC USB SND offloading
 support
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-17-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230126031424.14582-17-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/23 21:14, Wesley Cheng wrote:
> Several Qualcomm SoCs have a dedicated audio DSP, which has the ability to
> support USB sound devices.  This vendor driver will implement the required
> handshaking with the DSP, in order to pass along required resources that
> will be utilized by the DSP's USB SW.  The communication channel used for
> this handshaking will be using the QMI protocol.  Required resources
> include:
> - Allocated secondary event ring address
> - EP transfer ring address
> - Interrupter number
> 
> The above information will allow for the audio DSP to execute USB transfers
> over the USB bus.  It will also be able to support devices that have an
> implicit feedback and sync endpoint as well.  Offloading these data
> transfers will allow the main/applications processor to enter lower CPU
> power modes, and sustain a longer duration in those modes.
> 
> Audio offloading is initiated with the following sequence:
> 1. Userspace configures to route audio playback to USB backend and starts
> playback on the platform soundcard.

what happens if the DSP driver is probed after the USB one?
Or vice-versa?

Userspace needs to be notified of what is detected at the kernel level,
I don't see how we can assume a specific route is always present.


> +config QC_USB_AUDIO_OFFLOAD
> +	tristate "Qualcomm Audio Offload driver"

USB Audio Offload


> +struct uaudio_dev {
> +	struct usb_device *udev;
> +	/* audio control interface */
> +	struct usb_host_interface *ctrl_intf;
> +	unsigned int card_num;
> +	unsigned int usb_core_id;
> +	atomic_t in_use;
> +	struct kref kref;
> +	wait_queue_head_t disconnect_wq;
> +
> +	/* interface specific */
> +	int num_intf;
> +	struct intf_info *info;
> +	struct snd_usb_audio *chip;
> +};
> +
> +static struct uaudio_dev uadev[SNDRV_CARDS];

I don't follow what this array is? Does this shadow all possible cards,
even non-USB ones?

> +static struct uaudio_qmi_dev *uaudio_qdev;
> +static struct uaudio_qmi_svc *uaudio_svc;
> +static DEFINE_MUTEX(qdev_mutex);

> +/**
> + * disable_audio_stream() - disable usb snd endpoints
> + * @subs: usb substream
> + *
> + * Closes the USB SND endpoints associated with the current audio stream
> + * used.  This will decrement the USB SND endpoint opened reference count.
> + *
> + */
> +static void disable_audio_stream(struct snd_usb_substream *subs)
> +{
> +	struct snd_usb_audio *chip = subs->stream->chip;
> +
> +	if (subs->data_endpoint || subs->sync_endpoint) {
> +		close_endpoints(chip, subs);
> +
> +		mutex_lock(&chip->mutex);
> +		subs->cur_audiofmt = NULL;
> +		mutex_unlock(&chip->mutex);

can you explain why the format selection is protected by a mutex? I
don't quite get what level of concurrency might happen here?

> +	}
> +
> +	snd_usb_autosuspend(chip);
> +}
> +
> +/**
> + * enable_audio_stream() - enable usb snd endpoints
> + * @subs: usb substream
> + * @pcm_format: pcm format requested
> + * @channels: number of channels
> + * @cur_rate: sample rate
> + * @datainterval: interval
> + *
> + * Opens all USB SND endpoints used for the data interface.  This will increment
> + * the USB SND endpoint's opened count.  Requests to keep the interface resumed
> + * until the audio stream is stopped.  Will issue the USB set interface control
> + * message to enable the data interface.
> + *
> + */
> +static int enable_audio_stream(struct snd_usb_substream *subs,
> +				snd_pcm_format_t pcm_format,
> +				unsigned int channels, unsigned int cur_rate,
> +				int datainterval)
> +{
> +	struct snd_usb_audio *chip = subs->stream->chip;
> +	struct snd_pcm_hw_params params;
> +	const struct audioformat *fmt;
> +	int ret;
> +
> +	_snd_pcm_hw_params_any(&params);
> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_FORMAT,
> +			(__force int) pcm_format, 0);
> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_CHANNELS,
> +			channels, 0);
> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_RATE,
> +			cur_rate, 0);
> +
> +	pm_runtime_barrier(&chip->intf[0]->dev);
> +	snd_usb_autoresume(chip);
> +
> +	fmt = find_format(&subs->fmt_list, pcm_format, cur_rate,
> +			channels, datainterval, subs);
> +	if (!fmt) {
> +		dev_err(uaudio_qdev->dev,
> +			"cannot find format: format = %#x, rate = %d, ch = %d\n",
> +			pcm_format, cur_rate, channels);
> +		return -EINVAL;
> +	}
> +
> +	if (atomic_read(&chip->shutdown)) {
> +		dev_err(uaudio_qdev->dev, "chip already shutdown\n");
> +		ret = -ENODEV;
> +	} else {
> +		if (subs->data_endpoint)
> +			close_endpoints(chip, subs);
> +
> +		subs->data_endpoint = snd_usb_endpoint_open(chip, fmt,
> +				&params, false);
> +		if (!subs->data_endpoint) {
> +			dev_err(uaudio_qdev->dev, "failed to open data endpoint\n");
> +			return -EINVAL;
> +		}
> +
> +		if (fmt->sync_ep) {
> +			subs->sync_endpoint = snd_usb_endpoint_open(chip,
> +					fmt, &params, true);
> +			if (!subs->sync_endpoint) {
> +				dev_err(uaudio_qdev->dev,
> +					"failed to open sync endpoint\n");
> +				return -EINVAL;
> +			}
> +
> +			subs->data_endpoint->sync_source = subs->sync_endpoint;
> +		}
> +
> +		mutex_lock(&chip->mutex);
> +		subs->cur_audiofmt = fmt;
> +		mutex_unlock(&chip->mutex);
> +
> +		if (subs->sync_endpoint) {
> +			ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		ret = snd_usb_endpoint_prepare(chip, subs->data_endpoint);
> +		if (ret < 0)
> +			return ret;

what happens in those two error cases? Should the format selected above
remain set even though the prepare failed?

> +
> +		dev_dbg(uaudio_qdev->dev,
> +			"selected %s iface:%d altsetting:%d datainterval:%dus\n",
> +			subs->direction ? "capture" : "playback",
> +			fmt->iface, fmt->altsetting,
> +			(1 << fmt->datainterval) *
> +			(subs->dev->speed >= USB_SPEED_HIGH ?
> +			BUS_INTERVAL_HIGHSPEED_AND_ABOVE :
> +			BUS_INTERVAL_FULL_SPEED));
> +	}
> +
> +	return 0;
> +}

<snip>

> diff --git a/sound/usb/qcom/usb_audio_qmi_v01.c b/sound/usb/qcom/usb_audio_qmi_v01.c
> new file mode 100644
> index 000000000000..95ae434f0a41
> --- /dev/null
> +++ b/sound/usb/qcom/usb_audio_qmi_v01.c
> @@ -0,0 +1,892 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/soc/qcom/qmi.h>
> +
> +#include "usb_audio_qmi_v01.h"
> +
> +static struct qmi_elem_info mem_info_v01_ei[] = {
> +	{
> +		.data_type	= QMI_UNSIGNED_8_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u64),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0,
> +		.offset		= offsetof(struct mem_info_v01, va),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_8_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u64),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0,
> +		.offset		= offsetof(struct mem_info_v01, pa),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_4_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u32),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0,
> +		.offset		= offsetof(struct mem_info_v01, size),
> +	},
> +	{
> +		.data_type	= QMI_EOTI,
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= QMI_COMMON_TLV_TYPE,
> +	},

<snip>

> +	{
> +		.data_type	= QMI_EOTI,
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= QMI_COMMON_TLV_TYPE,
> +	},
> +};

Are those dozens of descriptors needed? They look mostly the same, not
sure how anyone could review this.
