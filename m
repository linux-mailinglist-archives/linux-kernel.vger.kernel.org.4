Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBE67D18D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjAZQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjAZQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:26:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC86721CB;
        Thu, 26 Jan 2023 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674750353; x=1706286353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tkQrGs3FSg5dTmlRU0hcgvbam/IWtDu8mWuckiRq01s=;
  b=GPk182CpQsM/0tECI8Y1sf1yn/QuX6El8GxErrRSHumLZMHvqyGR4N0v
   0lfems8LGQ9aZg7NjX9BWg7q/uIaobCIt38JWDzlTy4bKgXyYfW305m7Q
   gr+0k8goffv0V3EY2UpM1QGUUXk+MOdijBU+2ahxgjiYJY/IciM6tMYkK
   3kfP3R7mY2d9LzZF4He+VHbm85i1GZVh67fa4KsZRBEI6TKBacpoRRRpC
   Wxh9oYadsj0LvgY1TZDvPT+bl2Q0blsk/wCf6+fYU0raPtuuuvZgA0e6T
   WwTXb6lNtXn3+inAIhgpoeT6mz77dflG/PF/iprMcJ8ejaf8rrshnWVTE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354154717"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354154717"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612855093"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612855093"
Received: from nmani1-mobl2.amr.corp.intel.com (HELO [10.209.167.178]) ([10.209.167.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:41 -0800
Message-ID: <557f8f76-38f5-5e07-905e-774e03120bd2@linux.intel.com>
Date:   Thu, 26 Jan 2023 10:12:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 20/22] sound: usb: Prevent starting of audio stream
 if in use
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
 <20230126031424.14582-21-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230126031424.14582-21-quic_wcheng@quicinc.com>
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
> With USB audio offloading, an audio session is started from the ASoC
> platform sound card and PCM devices.  Likewise, the USB SND path is still
> readily available for use, in case the non-offload path is desired.  In
> order to prevent the two entities from attempting to use the USB bus,
> introduce a flag that determines when either paths are in use.
> 
> If a PCM device is already in use, the check will return an error to
> userspace notifying that the stream is currently busy.  This ensures that
> only one path is using the USB substream.

It's good to maintain mutual exclusion, but it's still very hard for an
application to figure out which card can be used when.

Returning -EBUSY is not super helpful. There should be something like a
notification or connection status so that routing decisions can be made
without trial-and-error.

> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.h                  |  1 +
>  sound/usb/pcm.c                   | 19 +++++++++++++++++--
>  sound/usb/qcom/qc_audio_offload.c | 15 ++++++++++++++-
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 410a4ffad98e..ff6d4695e727 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -163,6 +163,7 @@ struct snd_usb_substream {
>  	unsigned int pkt_offset_adj;	/* Bytes to drop from beginning of packets (for non-compliant devices) */
>  	unsigned int stream_offset_adj;	/* Bytes to drop from beginning of stream (for non-compliant devices) */
>  
> +	unsigned int opened:1;		/* pcm device opened */
>  	unsigned int running: 1;	/* running status */
>  	unsigned int period_elapsed_pending;	/* delay period handling */
>  
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 0b01a5dfcb73..8946f8ddb892 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -1114,8 +1114,15 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>  	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct snd_usb_substream *subs = &as->substream[direction];
> +	struct snd_usb_audio *chip = subs->stream->chip;
>  	int ret;
>  
> +	mutex_lock(&chip->mutex);
> +	if (subs->opened) {
> +		mutex_unlock(&chip->mutex);
> +		return -EBUSY;
> +	}
> +
>  	runtime->hw = snd_usb_hardware;
>  	/* need an explicit sync to catch applptr update in low-latency mode */
>  	if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
> @@ -1132,13 +1139,17 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>  
>  	ret = setup_hw_info(runtime, subs);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  	ret = snd_usb_autoresume(subs->stream->chip);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  	ret = snd_media_stream_init(subs, as->pcm, direction);
>  	if (ret < 0)
>  		snd_usb_autosuspend(subs->stream->chip);
> +	subs->opened = 1;
> +out:
> +	mutex_unlock(&chip->mutex);
> +
>  	return ret;
>  }
>  
> @@ -1147,6 +1158,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
>  	int direction = substream->stream;
>  	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
>  	struct snd_usb_substream *subs = &as->substream[direction];
> +	struct snd_usb_audio *chip = subs->stream->chip;
>  	int ret;
>  
>  	snd_media_stop_pipeline(subs);
> @@ -1160,6 +1172,9 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
>  
>  	subs->pcm_substream = NULL;
>  	snd_usb_autosuspend(subs->stream->chip);
> +	mutex_lock(&chip->mutex);
> +	subs->opened = 0;
> +	mutex_unlock(&chip->mutex);
>  
>  	return 0;
>  }
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index c1254d5f680d..9bd09282e70d 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -1365,12 +1365,17 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		goto response;
>  	}
>  
> +	mutex_lock(&chip->mutex);
>  	if (req_msg->enable) {
> -		if (info_idx < 0 || chip->system_suspend) {
> +		if (info_idx < 0 || chip->system_suspend || subs->opened) {
>  			ret = -EBUSY;
> +			mutex_unlock(&chip->mutex);
> +
>  			goto response;
>  		}
> +		subs->opened = 1;
>  	}
> +	mutex_unlock(&chip->mutex);
>  
>  	if (req_msg->service_interval_valid) {
>  		ret = get_data_interval_from_si(subs,
> @@ -1392,6 +1397,11 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		if (!ret)
>  			ret = prepare_qmi_response(subs, req_msg, &resp,
>  					info_idx);
> +		if (ret < 0) {
> +			mutex_lock(&chip->mutex);
> +			subs->opened = 0;
> +			mutex_unlock(&chip->mutex);
> +		}
>  	} else {
>  		info = &uadev[pcm_card_num].info[info_idx];
>  		if (info->data_ep_pipe) {
> @@ -1413,6 +1423,9 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		}
>  
>  		disable_audio_stream(subs);
> +		mutex_lock(&chip->mutex);
> +		subs->opened = 0;
> +		mutex_unlock(&chip->mutex);
>  	}
>  
>  response:
