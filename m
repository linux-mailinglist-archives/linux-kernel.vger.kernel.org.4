Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508370C537
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjEVScL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjEVScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:32:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441711F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684780326; x=1716316326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YbFK8GUrMIrpRbbx+GNGUXtzCx238UspxqLc+WIumjQ=;
  b=XXn9C5oyeocycMRc9NFfjzHLUUSjGz7UZFbMYkcayJ68F2FiJ4V7VTyg
   6SJurXhuScGnB+CrZfbz/G/NWWnri1ZvZlnnNdVZJT5y/Faxx6hpie+/V
   epysYPV2cQOkT3fTJBRzI30uXkuZmlZfCEYnc63C6NTwIRlvbFN4oGEkj
   3sNe0JE5QdBaxvRveeARsxddYr5vY8QNEhv+W6DOFMToEehVotZ0oQb+V
   6ZyQL2ZKvEn16rPHgiavf/Gc0JYo/IyQihcFHtrOpNLkueoQZzfSlVlp0
   2svo3A/abE2vjE6oEpVsVSGlQh7ByORzadB8tKyJpwjB1ybf9ZUcz/4sI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356235106"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356235106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697740834"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="697740834"
Received: from ljgreene-mobl.amr.corp.intel.com (HELO [10.209.124.121]) ([10.209.124.121])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:45 -0700
Message-ID: <134a2efd-648a-fb4b-4b61-154173b97f04@linux.intel.com>
Date:   Mon, 22 May 2023 11:26:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp
 pci driver
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
 <20230522133122.166841-3-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230522133122.166841-3-Vijendar.Mukunda@amd.com>
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
> Handle SoundWire manager related interrupts in ACP PCI driver
> interrupt handler and schedule SoundWire manager work queue for
> further processing.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h  |  4 ++++
>  sound/soc/amd/ps/pci-ps.c | 43 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 95bb1cef900a..d296059be4f0 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -88,6 +88,10 @@
>  /* time in ms for acp timeout */
>  #define ACP_TIMEOUT		500
>  
> +#define ACP_SDW0_STAT		BIT(21)
> +#define ACP_SDW1_STAT		BIT(2)
> +#define ACP_ERROR_IRQ		BIT(29)
> +
>  enum acp_config {
>  	ACP_CONFIG_0 = 0,
>  	ACP_CONFIG_1,
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 02caae6968ad..26514e340a33 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
>  static void acp63_enable_interrupts(void __iomem *acp_base)
>  {
>  	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
> +	writel(ACP_ERROR_IRQ, acp_base + ACP_EXTERNAL_INTR_CNTL);

you may want to comment on why you don't have a read-modify-write
approach for something that looks generic and not limited to a single
error bit?

>  }
>  
>  static void acp63_disable_interrupts(void __iomem *acp_base)
> @@ -102,23 +103,55 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>  {
>  	struct acp63_dev_data *adata;
>  	struct pdm_dev_data *ps_pdm_data;
> -	u32 val;
> +	struct amd_sdw_manager *amd_manager;
> +	u32 ext_intr_stat, ext_intr_stat1;
> +	u16 irq_flag = 0;
>  	u16 pdev_index;
>  
>  	adata = dev_id;
>  	if (!adata)
>  		return IRQ_NONE;
> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> +	if (ext_intr_stat & ACP_SDW0_STAT) {
> +		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);

[1]

this is confusing, if this is w1c, should this be:

writel(ext_intr_stat, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);

Otherwise you may be clearing fields that have not been set?

> +		pdev_index = adata->sdw0_dev_index;
> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +		if (amd_manager)
> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
> +		irq_flag = 1;
> +	}
>  
> -	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> -	if (val & BIT(PDM_DMA_STAT)) {
> +	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +	if (ext_intr_stat1 & ACP_SDW1_STAT) {
> +		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);

same comment here.

> +		pdev_index = adata->sdw1_dev_index;
> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +		if (amd_manager)
> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
> +		irq_flag = 1;
> +	}
> +
> +	if (ext_intr_stat & ACP_ERROR_IRQ) {
> +		writel(ACP_ERROR_IRQ, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);

[2]

and this is even move confusing because you may end-up writing twice to
the same adata->acp63_base + ACP_EXTERNAL_INTR_STAT with [1] and [2], so
the previous write

writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);

may have cleared the register already.

Something looks wrong here?

> +		/* TODO: Report SoundWire Manager instance errors */
> +		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
> +		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
> +		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
> +		irq_flag = 1;
> +	}
> +
> +	if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
>  		pdev_index = adata->pdm_dev_index;
>  		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>  		writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>  		if (ps_pdm_data->capture_stream)
>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
> -		return IRQ_HANDLED;
> +		irq_flag = 1;
>  	}
> -	return IRQ_NONE;
> +	if (irq_flag)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
>  }
>  
>  static int sdw_amd_scan_controller(struct device *dev)
