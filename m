Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88170C53C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjEVScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjEVScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:32:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E4B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684780329; x=1716316329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XAXCCp+4iACwZFaEUSigJa9p6OzPE1evsHYjiRa7ZYc=;
  b=bsUY7PJWWGzNwEDW9vBgAjT60rO8x8092zMF9mKyQ81sv7e0PC78rxwl
   ktOOUrxh8QGwL3yVsj/6FXWpec+BJoUaN+GW6PcTuVjx01b5jjwO2BM3+
   vvGCciv3UyRE8MUKFoe6/ewZhgSpBdO97tERKoJZTOSCersVo5B0GutVc
   tzXGrz0any5e4qJmR7XylVy0y9CgZEf4zBhczkYs4MZDMGXf6Rrr64jpF
   BxSuV8HMa1bXbTVT9kgCLleQM2NhSZ6bDwE7etzYEDafMnNJcbna+gUPH
   CPKTH6pZ5/cdtmbjA7l/tZc8W24l27NBmr3RGjNCmDjvUxkTwB52ECg2K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356235160"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356235160"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697740842"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="697740842"
Received: from ljgreene-mobl.amr.corp.intel.com (HELO [10.209.124.121]) ([10.209.124.121])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:50 -0700
Message-ID: <fea3c862-1470-7911-ff77-5d945b1d77cf@linux.intel.com>
Date:   Mon, 22 May 2023 13:12:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 5/9] ASoC: amd: ps: add support for SoundWire DMA
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
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230522133122.166841-6-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 08:31, Vijendar Mukunda wrote:
> Initialize workqueue for SoundWire DMA interrupts handling.
> Whenever audio data equal to the SoundWire FIFO watermark level
> are produced/consumed, interrupt is generated.
> Acknowledge the interrupt and schedule the workqueue.

It would help to explain why a work queue is needed is the first place,
as opposed to handling periods in the interrupt thread.

> +static void acp63_sdw_dma_workthread(struct work_struct *work)
> +{
> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
> +						    acp_sdw_dma_work);
> +	struct sdw_dma_dev_data *sdw_dma_data;
> +	u32 stream_index;
> +	u16 pdev_index;
> +
> +	pdev_index = adata->sdw_dma_dev_index;
> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +
> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
> +		}
> +	}
> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
> +		}
> +	}

I am not clear on the benefits of the workqueue which only tests a flag
that's set ...

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
> @@ -148,7 +178,57 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
>  		irq_flag = 1;
>  	}
> -	if (irq_flag)
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

.. here ...
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

... and here ...

> +		sdw_dma_irq_flag = 1;
> +	}
> +
> +	/* SDW1 BT TX*/
> +	if (ext_intr_stat1 & ACP_P1_AUDIO1_TX_THRESHOLD) {
> +		writel(ACP_P1_AUDIO1_TX_THRESHOLD,
> +		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_TX] = 1;

... or here ...

> +		sdw_dma_irq_flag = 1;
> +	}
> +
> +	if (sdw_dma_irq_flag)
> +		schedule_work(&adata->acp_sdw_dma_work);
> +
> +	if (irq_flag || sdw_dma_irq_flag)
>  		return IRQ_HANDLED;
>  	else
>  		return IRQ_NONE;

