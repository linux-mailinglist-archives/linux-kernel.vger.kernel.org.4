Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34CF6660AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjAKQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjAKQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3059FE1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454964; x=1704990964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G0tJKzV5lHHaXRt1euD8K1hOmKAS82nXgpcI5KscenM=;
  b=SJ8wTXuCsgeb/UzvRDY8cbp0Ae9y+61IaRq1E2v0UX+gcN1Khn7pDNII
   qeAfZaxlSlmAtlyPk9Eqsgwl7qO7VlmeD9CKdRumuLa+CW7+VEW42I+kW
   fmAHPNd7UVYHl7ZW1jMwlYCgU/6go8EmY6TybkkTGBdI6AyW4Eb8WtEDo
   WVZLn2YfhsnkfNENouSmlgM2TbpeYNyObs6LPbWawVTeUEBsxaQkupY8x
   z+wb64EQVdkRAXK0GJpGxnMQAD8DpbW4SBSCok0OWQPZtNhwG2NZ+o+sn
   hiPSJ6/WsQWECbjrmk0NYjjMRRbOZZr66vI45hgFQuuAMeeDiDhGPJiqO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704104"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704104"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408509"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408509"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:24 -0800
Message-ID: <77e35f54-323e-42d0-9e74-be984eebc0fe@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:34:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 08/19] ASoC: amd: ps: add soundwire dma driver dma ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 03:02, Vijendar Mukunda wrote:
> Add Soundwire DMA driver dma ops for Pink Sardine platform.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h      |  61 ++++
>  sound/soc/amd/ps/ps-sdw-dma.c | 531 ++++++++++++++++++++++++++++++++++
>  2 files changed, 592 insertions(+)
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index b462320fdf2a..8963cfb6120d 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -67,6 +67,38 @@
>  #define ACP_SDW0_IRQ_MASK	21
>  #define ACP_SDW1_IRQ_MASK	2
>  #define ACP_ERROR_IRQ_MASK      29
> +#define ACP_AUDIO_TX_THRESHOLD	28
> +#define ACP_BT_TX_THRESHOLD	26
> +#define ACP_HS_TX_THRESHOLD	24
> +#define ACP_AUDIO_RX_THRESHOLD	27
> +#define ACP_BT_RX_THRESHOLD	25
> +#define ACP_HS_RX_THRESHOLD	23
> +#define ACP_P1_BT_TX_THRESHOLD	6
> +#define ACP_P1_BT_RX_THRESHOLD	5
> +#define ACP_SDW_DMA_IRQ_MASK	0x1F800000
> +#define ACP_P1_SDW_DMA_IRQ_MASK	0x60
> +#define ACP63_SDW_MAX_STREAMS		8
> +
> +#define ACP_DELAY_US		5
> +#define SDW_MEM_WINDOW_START	0x4800000
> +#define ACP_SDW_SRAM_PTE_OFFSET	0x03800400
> +#define SDW_PTE_OFFSET		0x400
> +#define SDW_FIFO_SIZE		0x100
> +#define SDW_DMA_SIZE		0x40
> +#define ACP_SDW_FIFO_OFFSET	0x100
> +#define ACP_SDW_RING_BUFF_ADDR_OFFSET (128 * 1024)
> +
> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
> +#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
> +#define SDW_PLAYBACK_MIN_PERIOD_SIZE    1024
> +#define SDW_CAPTURE_MIN_NUM_PERIODS     2
> +#define SDW_CAPTURE_MAX_NUM_PERIODS     8
> +#define SDW_CAPTURE_MAX_PERIOD_SIZE     8192
> +#define SDW_CAPTURE_MIN_PERIOD_SIZE     1024
> +
> +#define SDW_MAX_BUFFER (SDW_PLAYBACK_MAX_PERIOD_SIZE * SDW_PLAYBACK_MAX_NUM_PERIODS)
> +#define SDW_MIN_BUFFER SDW_MAX_BUFFER
>  
>  enum acp_config {
>  	ACP_CONFIG_0 = 0,
> @@ -93,6 +125,17 @@ enum acp_pdev_mask {
>  	ACP63_SDW_PDM_DEV_MASK,
>  };
>  
> +enum channel_type {
> +	ACP_SDW_AUDIO_TX = 0,
> +	ACP_SDW_BT_TX,
> +	ACP_SDW_HS_TX,
> +	ACP_SDW_AUDIO_RX,
> +	ACP_SDW_BT_RX,
> +	ACP_SDW_HS_RX,
> +	ACP_SDW1_BT_TX,
> +	ACP_SDW1_BT_RX,
> +};

this was defined in another patch already?

> +
>  struct pdm_stream_instance {
>  	u16 num_pages;
>  	u16 channels;
> @@ -139,4 +182,22 @@ struct acp63_dev_data {
>  struct sdw_dma_dev_data {
>  	void __iomem *acp_base;
>  	struct mutex *acp_lock;
> +	struct snd_pcm_substream *sdw_stream[ACP63_SDW_MAX_STREAMS];
> +};
> +
> +struct sdw_stream_instance {

sdw_stream is already a well-defined concept. Please use sdw_dma_stream
or something less confusing naming-wise.

> +	u16 num_pages;
> +	u16 channels;
> +	u32 stream_id;
> +	dma_addr_t dma_addr;
> +	u64 bytescount;
> +	void __iomem *acp_base;
> +};
> +
> +union acp_sdw_dma_count {
> +	struct {
> +	u32 low;
> +	u32 high;
> +	} bcount;
> +	u64 bytescount;
>  };
> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
> index 388a4b7df715..e94f76053c66 100644
> --- a/sound/soc/amd/ps/ps-sdw-dma.c
> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
> @@ -12,12 +12,543 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dai.h>
> +#include <linux/soundwire/sdw_amd.h>
>  #include "acp63.h"
>  
>  #define DRV_NAME "amd_ps_sdw_dma"
>  
> +static const struct snd_pcm_hardware acp63_sdw_hardware_playback = {
> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
> +	.channels_min = 2,
> +	.channels_max = 2,
> +	.rates = SNDRV_PCM_RATE_48000,
> +	.rate_min = 48000,
> +	.rate_max = 48000,

is this really limited to 2ch 48kHz? This doesn't align with the
references to Bluetooth above?

> +	.buffer_bytes_max = SDW_PLAYBACK_MAX_NUM_PERIODS * SDW_PLAYBACK_MAX_PERIOD_SIZE,
> +	.period_bytes_min = SDW_PLAYBACK_MIN_PERIOD_SIZE,
> +	.period_bytes_max = SDW_PLAYBACK_MAX_PERIOD_SIZE,
> +	.periods_min = SDW_PLAYBACK_MIN_NUM_PERIODS,
> +	.periods_max = SDW_PLAYBACK_MAX_NUM_PERIODS,
> +};
> +
> +static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_MMAP |
> +		SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
> +	.channels_min = 2,
> +	.channels_max = 2,
> +	.rates = SNDRV_PCM_RATE_48000,
> +	.rate_min = 48000,
> +	.rate_max = 48000,

same here?

> +	.buffer_bytes_max = SDW_CAPTURE_MAX_NUM_PERIODS * SDW_CAPTURE_MAX_PERIOD_SIZE,
> +	.period_bytes_min = SDW_CAPTURE_MIN_PERIOD_SIZE,
> +	.period_bytes_max = SDW_CAPTURE_MAX_PERIOD_SIZE,
> +	.periods_min = SDW_CAPTURE_MIN_NUM_PERIODS,
> +	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
> +};
> +
> +static void acp63_config_dma(struct sdw_stream_instance *sdw_ins, u32 stream_id)
> +{
> +	u16 page_idx;
> +	u32 low, high, val;
> +	dma_addr_t addr;
> +
> +	addr = sdw_ins->dma_addr;
> +	val = SDW_PTE_OFFSET + (stream_id * 256);
> +
> +	/* Group Enable */
> +	acp63_writel(ACP_SDW_SRAM_PTE_OFFSET | BIT(31), sdw_ins->acp_base +
> +		     ACPAXI2AXI_ATU_BASE_ADDR_GRP_2);
> +	acp63_writel(PAGE_SIZE_4K_ENABLE, sdw_ins->acp_base +
> +		     ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2);
> +	for (page_idx = 0; page_idx < sdw_ins->num_pages; page_idx++) {
> +		/* Load the low address of page int ACP SRAM through SRBM */
> +		low = lower_32_bits(addr);
> +		high = upper_32_bits(addr);
> +
> +		acp63_writel(low, sdw_ins->acp_base + ACP_SCRATCH_REG_0 + val);
> +		high |= BIT(31);
> +		acp63_writel(high, sdw_ins->acp_base + ACP_SCRATCH_REG_0 + val + 4);
> +		val += 8;
> +		addr += PAGE_SIZE;
> +	}
> +
> +	/*cache Invalidation added for Testing */

/* cache

> +	acp63_writel(0x1, sdw_ins->acp_base + ACPAXI2AXI_ATU_CTRL);
> +}

> +static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
> +				   struct snd_pcm_substream *substream,
> +				   struct snd_pcm_hw_params *params)
> +{
> +	struct sdw_stream_instance *sdw_stream_data;
> +	struct sdw_dma_dev_data *sdw_data;
> +	u32 period_bytes;
> +	u32 water_mark_size_reg;
> +	u32 irq_mask, ext_intr_ctrl;
> +	u64 size;
> +	u32 stream_id;
> +	u32 acp_ext_intr_cntl_reg;
> +	int ret;
> +
> +	stream_id = 0;

useless initialization...

> +	sdw_data = dev_get_drvdata(component->dev);
> +	sdw_stream_data = substream->runtime->private_data;
> +	if (!sdw_stream_data)
> +		return -EINVAL;
> +	stream_id = sdw_stream_data->stream_id;

... overriden here

> +	sdw_data->sdw_stream[stream_id] = substream;
> +	size = params_buffer_bytes(params);
> +	period_bytes = params_period_bytes(params);
> +	sdw_stream_data->dma_addr = substream->runtime->dma_addr;
> +	sdw_stream_data->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	acp63_config_dma(sdw_stream_data, stream_id);
> +	ret = acp63_configure_sdw_ringbuffer(sdw_stream_data->acp_base, stream_id, size);
> +	if (ret) {
> +		dev_err(component->dev, "Invalid channel type\n");
> +		return -EINVAL;
> +	}
> +	switch (stream_id) {
> +	case ACP_SDW_AUDIO_TX:
> +		water_mark_size_reg = ACP_AUDIO_TX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_AUDIO_TX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
> +		break;

so there's ONE resource to deal with external codecs? How does this work
if you have a headset codec and an amplifier?

> +	case ACP_SDW_BT_TX:
> +		water_mark_size_reg = ACP_BT_TX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_BT_TX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
> +		break;
> +	case ACP_SDW_HS_TX:
> +		water_mark_size_reg = ACP_HS_TX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_HS_TX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
> +		break;
> +	case ACP_SDW1_BT_TX:
> +		water_mark_size_reg = ACP_P1_BT_TX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_P1_BT_TX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
> +		break;
> +	case ACP_SDW_AUDIO_RX:
> +		water_mark_size_reg = ACP_AUDIO_RX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_AUDIO_RX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
> +		break;
> +	case ACP_SDW_BT_RX:
> +		water_mark_size_reg = ACP_BT_RX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_BT_RX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
> +		break;
> +	case ACP_SDW_HS_RX:
> +		water_mark_size_reg = ACP_HS_RX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_HS_RX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
> +		break;
> +	case ACP_SDW1_BT_RX:
> +		water_mark_size_reg = ACP_P1_BT_RX_INTR_WATERMARK_SIZE;
> +		irq_mask = BIT(ACP_P1_BT_RX_THRESHOLD);
> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
> +		break;
> +	default:
> +		dev_err(component->dev, "%s: Invalid channel type\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ext_intr_ctrl = acp63_readl(sdw_stream_data->acp_base + acp_ext_intr_cntl_reg);
> +	ext_intr_ctrl |= irq_mask;
> +	acp63_writel(ext_intr_ctrl, sdw_stream_data->acp_base + acp_ext_intr_cntl_reg);
> +	acp63_writel(period_bytes, sdw_stream_data->acp_base + water_mark_size_reg);
> +	return 0;
> +}
