Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23CA6BACDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCOKAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjCOJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:59:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39C1C7FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51BDCB81DB8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5CC433D2;
        Wed, 15 Mar 2023 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874315;
        bh=1lIiPGGohCbNq0gwrO+vN4ph+ZOw89tmCaE7peGv7ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0ZQgNPelWFA1y6shE2m0WGd2PQSnL8z4e+B31Ezuy8sYjzHJHHiVN9JofYhRCxAD
         fToDrNiy5qx698mp2hsb6A+xueAQxvnSc+IDVSVSsx02XdWE+EvHkWjtoPSRgzWow2
         jl72bKMZi3gNeEMiUeRbjELf4oDbG8iS4vME7OMig6yDGiSSATNh4gx4m2TAjw+qnM
         xSxFQQtw5Apdk8K/hSeR1YHorsa4ziyI4ta4CBsLcwdgRH7RJe3Bo60qONUD5T3eky
         T1pW39vxyqLsgNxrgeTrWBjGsG6mNbArLcWv8qh/LUfNQbii1aFqi7GJBGmPiWpo+Y
         fsZjQojulHP4A==
Date:   Wed, 15 Mar 2023 15:28:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 3/8] soundwire: amd: register SoundWire manager dai ops
Message-ID: <ZBGWx4kR/eFLoz4q@matsya>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-4-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307133135.545952-4-Vijendar.Mukunda@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-23, 19:01, Vijendar Mukunda wrote:
> Register dai ops for SoundWire manager instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://lore.kernel.org/lkml/20230227154801.50319-4-Vijendar.Mukunda@amd.com
> ---
>  drivers/soundwire/amd_manager.c   | 182 ++++++++++++++++++++++++++++++
>  drivers/soundwire/amd_manager.h   |  18 +++
>  include/linux/soundwire/sdw_amd.h |  18 +++
>  3 files changed, 218 insertions(+)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index a5cf6acd936c..dd7fd4036d89 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -581,6 +581,182 @@ static const struct sdw_master_ops amd_sdw_ops = {
>  	.read_ping_status = amd_sdw_read_ping_status,
>  };
>  
> +static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +	struct sdw_stream_config sconfig;
> +	struct sdw_port_config *pconfig;
> +	int ch, dir;
> +	int ret;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (!dai_runtime)
> +		return -EIO;
> +
> +	ch = params_channels(params);
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		dir = SDW_DATA_DIR_RX;
> +	else
> +		dir = SDW_DATA_DIR_TX;
> +	dev_dbg(amd_manager->dev, "dir:%d dai->id:0x%x\n", dir, dai->id);
> +
> +	sconfig.direction = dir;
> +	sconfig.ch_count = ch;
> +	sconfig.frame_rate = params_rate(params);
> +	sconfig.type = dai_runtime->stream_type;
> +
> +	sconfig.bps = snd_pcm_format_width(params_format(params));
> +
> +	/* Port configuration */
> +	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
> +	if (!pconfig) {
> +		ret =  -ENOMEM;
> +		goto error;
> +	}
> +
> +	pconfig->num = dai->id;
> +	pconfig->ch_mask = (1 << ch) - 1;
> +	ret = sdw_stream_add_master(&amd_manager->bus, &sconfig,
> +				    pconfig, 1, dai_runtime->stream);
> +	if (ret)
> +		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
> +
> +	kfree(pconfig);
> +error:
> +	return ret;
> +}
> +
> +static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +	int ret;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (!dai_runtime)
> +		return -EIO;
> +
> +	ret = sdw_stream_remove_master(&amd_manager->bus, dai_runtime->stream);
> +	if (ret < 0)
> +		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
> +			dai_runtime->stream->name, ret);
> +	return ret;
> +}
> +
> +static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (stream) {
> +		/* first paranoia check */
> +		if (dai_runtime) {
> +			dev_err(dai->dev,
> +				"dai_runtime already allocated for dai %s\n",
> +				dai->name);

single line would look better

> +			return -EINVAL;
> +		}
> +
> +		/* allocate and set dai_runtime info */
> +		dai_runtime = kzalloc(sizeof(*dai_runtime), GFP_KERNEL);
> +		if (!dai_runtime)
> +			return -ENOMEM;
> +
> +		dai_runtime->stream_type = SDW_STREAM_PCM;
> +		dai_runtime->bus = &amd_manager->bus;
> +		dai_runtime->stream = stream;
> +		amd_manager->dai_runtime_array[dai->id] = dai_runtime;
> +	} else {
> +		/* second paranoia check */
> +		if (!dai_runtime) {
> +			dev_err(dai->dev,
> +				"dai_runtime not allocated for dai %s\n",
> +				dai->name);
> +			return -EINVAL;
> +		}
> +
> +		/* for NULL stream we release allocated dai_runtime */
> +		kfree(dai_runtime);
> +		amd_manager->dai_runtime_array[dai->id] = NULL;
> +	}
> +	return 0;
> +}
> +
> +static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
> +{
> +	return amd_set_sdw_stream(dai, stream, direction);
> +}
> +
> +static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
> +{
> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_amd_dai_runtime *dai_runtime;
> +
> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
> +	if (!dai_runtime)
> +		return ERR_PTR(-EINVAL);
> +
> +	return dai_runtime->stream;
> +}
> +
> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
> +	.hw_params = amd_sdw_hw_params,
> +	.hw_free = amd_sdw_hw_free,
> +	.set_stream = amd_pcm_set_sdw_stream,
> +	.get_stream = amd_get_sdw_stream,
> +};
> +
> +static const struct snd_soc_component_driver amd_sdw_dai_component = {
> +	.name = "soundwire",
> +};
> +
> +static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
> +{
> +	struct sdw_amd_dai_runtime **dai_runtime_array;
> +	struct snd_soc_dai_driver *dais;
> +	struct snd_soc_pcm_stream *stream;
> +	struct device *dev;
> +	int i, num_dais;
> +
> +	dev = amd_manager->dev;
> +	num_dais = amd_manager->num_dout_ports + amd_manager->num_din_ports;
> +	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
> +	if (!dais)
> +		return -ENOMEM;
> +
> +	dai_runtime_array = devm_kcalloc(dev, num_dais,
> +					 sizeof(struct sdw_amd_dai_runtime *),
> +					 GFP_KERNEL);
> +	if (!dai_runtime_array)
> +		return -ENOMEM;
> +	amd_manager->dai_runtime_array = dai_runtime_array;
> +	for (i = 0; i < num_dais; i++) {
> +		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", amd_manager->instance,
> +					      i);
> +		if (!dais[i].name)
> +			return -ENOMEM;
> +		if (i < amd_manager->num_dout_ports)
> +			stream = &dais[i].playback;
> +		else
> +			stream = &dais[i].capture;
> +
> +		stream->channels_min = 2;
> +		stream->channels_max = 2;
> +		stream->rates = SNDRV_PCM_RATE_48000;
> +		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
> +
> +		dais[i].ops = &amd_sdw_dai_ops;
> +		dais[i].id = i;
> +	}
> +
> +	return devm_snd_soc_register_component(dev, &amd_sdw_dai_component,
> +					       dais, num_dais);
> +}
> +
>  static void amd_sdw_probe_work(struct work_struct *work)
>  {
>  	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
> @@ -664,6 +840,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>  		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
>  		return ret;
>  	}
> +	ret = amd_sdw_register_dais(amd_manager);
> +	if (ret) {
> +		dev_err(dev, "CPU DAI registration failed\n");
> +		sdw_bus_master_delete(&amd_manager->bus);
> +		return ret;
> +	}
>  	dev_set_drvdata(dev, amd_manager);
>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>  	/*
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index 0d4b8653877e..cad26034087b 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -204,6 +204,24 @@ struct sdw_manager_dp_reg {
>  	u32 lane_ctrl_ch_en_reg;
>  };
>  
> +/*
> + * SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
> + * whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
> + * Below is the CPU DAI <->Manager port number mapping
> + * i.e SDW0 Pin0 -> port number 0 -> AUDIO0 TX
> + *     SDW0 Pin1 -> Port number 1 -> AUDIO1 TX
> + *     SDW0 Pin2 -> Port number 2 -> AUDIO2 TX
> + *     SDW0 Pin3 -> port number 3 -> AUDIO0 RX
> + *     SDW0 Pin4 -> Port number 4 -> AUDIO1 RX
> + *     SDW0 Pin5 -> Port number 5 -> AUDIO2 RX
> + *  Whereas for SDW1 instance
> + *  SDW1 Pin0 -> port number 0 -> AUDIO1 TX
> + *  SDW1 Pin1 -> Port number 1 -> AUDIO1 RX
> + *  Same mapping should be used for programming DMA controller registers in SoundWire DMA driver.
> + * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
> + * in SoundWire DMA driver.
> + */
> +
>  static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
>  	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
>  	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index c14a291a40e8..ac537419301d 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -23,6 +23,21 @@ struct sdw_manager_reg_mask {
>  	u32 acp_sdw_intr_mask;
>  };
>  
> +/**
> + * struct sdw_amd_dai_runtime: AMD sdw dai runtime  data
> + *
> + * @name: SoundWire stream name
> + * @stream: stream runtime
> + * @bus: Bus handle
> + * @stream_type: Stream type
> + */
> +struct sdw_amd_dai_runtime {
> +	char *name;
> +	struct sdw_stream_runtime *stream;
> +	struct sdw_bus *bus;
> +	enum sdw_stream_type stream_type;
> +};
> +
>  /**
>   * struct amd_sdw_manager - amd manager driver context
>   * @bus: bus handle
> @@ -40,6 +55,7 @@ struct sdw_manager_reg_mask {
>   * @quirks: SoundWire manager quirks
>   * @wake_en_mask: wake enable mask per SoundWire manager
>   * @power_mode_mask: flag interprets amd SoundWire manager power mode
> + * @dai_runtime_array: dai runtime array
>   */
>  struct amd_sdw_manager {
>  	struct sdw_bus bus;
> @@ -63,5 +79,7 @@ struct amd_sdw_manager {
>  	u32 quirks;
>  	u32 wake_en_mask;
>  	u32 power_mode_mask;
> +
> +	struct sdw_amd_dai_runtime **dai_runtime_array;
>  };
>  #endif
> -- 
> 2.34.1

-- 
~Vinod
