Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A51724806
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbjFFPky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbjFFPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3420810D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066027; x=1717602027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YetqiMtBgg9iuZtDtv2kPhnSL2iH8CyOWdyD+KWIne8=;
  b=SLhcDrZxSLrcN/sQzD7IRtEF706XK6oh3rFt5CuQuM91kUiBSkUxrYkY
   SoDmVknecaLK4JkmMDXBBEbDm/XSG421e0zw/DUyELttdPPStj51yX+ns
   gTaKzblt9KVd0rESU4YR082fsOLeS0EoedFZKXV46aHeAL/SNIkwOywbo
   mL5O1K6Lk1QnfuekcKOPAKTfmVs3qPiXEYrjIUjijWD/o3xYRmUlI7Z7c
   P8bsWuBvSgiHFGCI5M4M6FvI8RIaSvatEAKZoZa9DkE9ugU83TkVTNgam
   EkW6tMr2+9mLyE9wsNWzAsIfqWbP2vOt9bY40gZwex6+MRu41HYtTS0ro
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422550188"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422550188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955816519"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955816519"
Received: from pdonvalk-mobl2.amr.corp.intel.com (HELO [10.255.231.168]) ([10.255.231.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:11 -0700
Message-ID: <6c44969f-4d25-7b71-cd35-cd7087e083e4@linux.intel.com>
Date:   Tue, 6 Jun 2023 09:59:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 5/9] ASoC: amd: ps: add support for SoundWire DMA
 interrupts
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230606060724.2038680-6-Vijendar.Mukunda@amd.com>
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


> +enum amd_sdw0_channel {
> +	ACP_SDW0_AUDIO0_TX = 0,
> +	ACP_SDW0_AUDIO1_TX,
> +	ACP_SDW0_AUDIO2_TX,
> +	ACP_SDW0_AUDIO0_RX,
> +	ACP_SDW0_AUDIO1_RX,
> +	ACP_SDW0_AUDIO2_RX,
> +};
> +
> +enum amd_sdw1_channel {
> +	ACP_SDW1_AUDIO1_TX,
> +	ACP_SDW1_AUDIO1_RX,

any specify reason why SDW0 starts with AUDIO0 and SDW1 with AUDIO1?

> +};
> +
>  struct pdm_stream_instance {
>  	u16 num_pages;
>  	u16 channels;
> @@ -239,6 +253,8 @@ struct sdw_dma_ring_buf_reg {
>   * @sdw0_dev_index: SoundWire Manager-0 platform device index
>   * @sdw1_dev_index: SoundWire Manager-1 platform device index
>   * @sdw_dma_dev_index: SoundWire DMA controller platform device index
> + * @sdw0-dma_intr_stat: DMA interrupt status array for SoundWire manager-SW0 instance
> + * @sdw_dma_intr_stat: DMA interrupt status array for SoundWire manager-SW1 instance
>   * @acp_reset: flag set to true when bus reset is applied across all
>   * the active SoundWire manager instances
>   */
> @@ -256,6 +272,8 @@ struct acp63_dev_data {
>  	u16 sdw0_dev_index;
>  	u16 sdw1_dev_index;
>  	u16 sdw_dma_dev_index;
> +	u16 sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
> +	u16 sdw1_dma_intr_stat[ACP63_SDW1_DMA_MAX_STREAMS];
>  	bool acp_reset;
>  };
>  
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 17e29a3e1c21..daf54fe9cafd 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -99,14 +99,44 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
>  	return 0;
>  }
>  
> +static irqreturn_t acp63_irq_thread(int irq, void *context)
> +{
> +	struct sdw_dma_dev_data *sdw_dma_data;
> +	struct acp63_dev_data *adata = context;
> +	u32 stream_index;
> +	u16 pdev_index;
> +
> +	pdev_index = adata->sdw_dma_dev_index;
> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +
> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])

can this test be false?

> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
> +		}
> +	}
> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])

can this test be false?

> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
> +		}
> +	}
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>  {
>  	struct acp63_dev_data *adata;
>  	struct pdm_dev_data *ps_pdm_data;
>  	struct amd_sdw_manager *amd_manager;
>  	u32 ext_intr_stat, ext_intr_stat1;
> +	u32 stream_id = 0;
>  	u16 irq_flag = 0;
> +	u16 sdw_dma_irq_flag = 0;
>  	u16 pdev_index;
> +	u16 index;
>  
>  	adata = dev_id;
>  	if (!adata)
> @@ -153,6 +183,56 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
>  		irq_flag = 1;
>  	}
> +	if (ext_intr_stat & ACP_SDW_DMA_IRQ_MASK) {
> +		for (index = ACP_AUDIO2_RX_THRESHOLD; index <= ACP_AUDIO0_TX_THRESHOLD; index++) {
> +			if (ext_intr_stat & BIT(index)) {
> +				writel(BIT(index), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> +				switch (index) {
> +				case ACP_AUDIO0_TX_THRESHOLD:
> +					stream_id = ACP_SDW0_AUDIO0_TX;
> +					break;
> +				case ACP_AUDIO1_TX_THRESHOLD:
> +					stream_id = ACP_SDW0_AUDIO1_TX;
> +					break;
> +				case ACP_AUDIO2_TX_THRESHOLD:
> +					stream_id = ACP_SDW0_AUDIO2_TX;
> +					break;
> +				case ACP_AUDIO0_RX_THRESHOLD:
> +					stream_id = ACP_SDW0_AUDIO0_RX;
> +					break;
> +				case ACP_AUDIO1_RX_THRESHOLD:
> +					stream_id = ACP_SDW0_AUDIO1_RX;
> +					break;
> +				case ACP_AUDIO2_RX_THRESHOLD:
> +					stream_id = ACP_SDW0_AUDIO2_RX;
> +					break;
> +				}
> +
> +				adata->sdw0_dma_intr_stat[stream_id] = 1;
> +				sdw_dma_irq_flag = 1;
> +			}
> +		}
> +	}
> +
> +	/* SDW1 BT RX */
> +	if (ext_intr_stat1 & ACP_P1_AUDIO1_RX_THRESHOLD) {
> +		writel(ACP_P1_AUDIO1_RX_THRESHOLD,
> +		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_RX] = 1;
> +		sdw_dma_irq_flag = 1;
> +	}
> +
> +	/* SDW1 BT TX*/

keep spaces before */

> +	if (ext_intr_stat1 & ACP_P1_AUDIO1_TX_THRESHOLD) {
> +		writel(ACP_P1_AUDIO1_TX_THRESHOLD,
> +		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_TX] = 1;
> +		sdw_dma_irq_flag = 1;
> +	}
> +
> +	if (sdw_dma_irq_flag)
> +		return IRQ_WAKE_THREAD;
> +
>  	if (irq_flag)
>  		return IRQ_HANDLED;
>  	else
> @@ -544,8 +624,8 @@ static int snd_acp63_probe(struct pci_dev *pci,
>  	ret = acp63_init(adata->acp63_base, &pci->dev);
>  	if (ret)
>  		goto release_regions;
> -	ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
> -			       irqflags, "ACP_PCI_IRQ", adata);
> +	ret = devm_request_threaded_irq(&pci->dev, pci->irq, acp63_irq_handler,
> +					acp63_irq_thread, irqflags, "ACP_PCI_IRQ", adata);
>  	if (ret) {
>  		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
>  		goto de_init;
