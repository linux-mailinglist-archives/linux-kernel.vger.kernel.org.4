Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8665724807
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbjFFPk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbjFFPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A9100
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066032; x=1717602032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1wl33YLKJtGYuzRigulhLv2j90MIPOzWoNLezUs3Qpk=;
  b=GOlpd7zmMAX+YdS6ZoYysbH3eO8xWC2b9YlFiuQjLpQm8P/MA/kiQJFG
   v5tNXf0l9YuYf65A6/sjOF0fELvuUsDnqxlaFx60iCuDz2RIT4PX83H2x
   eguIWT1q9OuKgyvA8Uta61pJ/WyddGCt4xTdpcqpioONmv2Jd8s2auG5q
   r6q5yAnyF0lPjLIufGt7bIcc/9oK3wbZEdRcudJSGzxG3HJ81EI+jxoIn
   kPF3h1a4us/HQ/NDoEjCqNXF1P8jXr/u/hEeOjXCQ/xXsDKuqi/ZY1mZu
   A/0a1x/cExlcPvM8LvwZ9reaWrAzvbhvM3LYXgCv6h5EMRlSSClXW9z/i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422550225"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422550225"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955816526"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955816526"
Received: from pdonvalk-mobl2.amr.corp.intel.com (HELO [10.255.231.168]) ([10.255.231.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:13 -0700
Message-ID: <892b8211-7384-f948-fe76-03c6c48f23c6@linux.intel.com>
Date:   Tue, 6 Jun 2023 10:02:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 6/9] ASoC: amd: ps: add pm ops support for SoundWire
 dma driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-7-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230606060724.2038680-7-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/23 01:07, Vijendar Mukunda wrote:
> Add support pm ops support for SoundWire dma driver.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/ps-sdw-dma.c | 98 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
> index 06d847c6a50e..118f4c3674ab 100644
> --- a/sound/soc/amd/ps/ps-sdw-dma.c
> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
> @@ -12,6 +12,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dai.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/soundwire/sdw_amd.h>
>  #include "acp63.h"
>  
> @@ -102,6 +103,29 @@ static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
>  	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
>  };
>  
> +static void acp63_enable_disable_sdw_dma_interrupts(void __iomem *acp_base, bool enable)
> +{
> +	u32 ext_intr_cntl, ext_intr_cntl1;
> +	u32 irq_mask = ACP_SDW_DMA_IRQ_MASK;
> +	u32 irq_mask1 = ACP_P1_SDW_DMA_IRQ_MASK;
> +
> +	if (enable) {
> +		ext_intr_cntl = readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
> +		ext_intr_cntl |= irq_mask;
> +		writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
> +		ext_intr_cntl1 = readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
> +		ext_intr_cntl1 |= irq_mask1;
> +		writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
> +	} else {
> +		ext_intr_cntl = readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
> +		ext_intr_cntl &= ~irq_mask;
> +		writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
> +		ext_intr_cntl1 = readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
> +		ext_intr_cntl1 &= ~irq_mask1;
> +		writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
> +	}
> +}
> +
>  static void acp63_config_dma(struct acp_sdw_dma_stream *stream, void __iomem *acp_base,
>  			     u32 stream_id)
>  {
> @@ -464,16 +488,86 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
>  	status = devm_snd_soc_register_component(&pdev->dev,
>  						 &acp63_sdw_component,
>  						 NULL, 0);
> -	if (status)
> +	if (status) {
>  		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
> +		return status;
> +	}
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	return 0;
> +}
>  
> -	return status;
> +static int acp63_sdw_platform_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
>  }
>  
> +static int acp_restore_sdw_dma_config(struct sdw_dma_dev_data *sdw_data)
> +{
> +	struct acp_sdw_dma_stream *stream;
> +	struct snd_pcm_substream *substream;
> +	struct snd_pcm_runtime *runtime;
> +	u32 period_bytes, buf_size, water_mark_size_reg;
> +	u32 stream_count;
> +	int index, instance, ret;
> +
> +	for (instance = 0; instance < AMD_SDW_MAX_MANAGERS; instance++) {
> +		if (instance == ACP_SDW0)
> +			stream_count = ACP63_SDW0_DMA_MAX_STREAMS;
> +		else
> +			stream_count = ACP63_SDW1_DMA_MAX_STREAMS;
> +
> +		for (index = 0; index < stream_count; index++) {
> +			if (instance == ACP_SDW0) {
> +				substream = sdw_data->sdw0_dma_stream[index];
> +				water_mark_size_reg =
> +						sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
> +			} else {
> +				substream = sdw_data->sdw1_dma_stream[index];
> +				water_mark_size_reg =
> +						sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
> +			}
> +
> +			if (substream && substream->runtime) {

can this be false?
> +				runtime = substream->runtime;
> +				stream = runtime->private_data;
> +				period_bytes = frames_to_bytes(runtime, runtime->period_size);
> +				buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> +				acp63_config_dma(stream, sdw_data->acp_base, index);
> +				ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
> +								     buf_size, instance);
> +				if (ret)
> +					return ret;
> +				writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
> +			}> +		}
> +	}
> +	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
> +	return 0;
> +}
> +
> +static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
> +{
> +	struct sdw_dma_dev_data *sdw_data;
> +
> +	sdw_data = dev_get_drvdata(dev);
> +	return acp_restore_sdw_dma_config(sdw_data);
> +}
> +
> +static const struct dev_pm_ops acp63_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp63_sdw_pcm_resume)
> +};
> +
>  static struct platform_driver acp63_sdw_dma_driver = {
>  	.probe = acp63_sdw_platform_probe,
> +	.remove = acp63_sdw_platform_remove,
>  	.driver = {
>  		.name = "amd_ps_sdw_dma",
> +		.pm = &acp63_pm_ops,
>  	},
>  };
>  
