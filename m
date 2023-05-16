Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A970527D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjEPPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjEPPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:43:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFDF2108
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684251835; x=1715787835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rh59zO8e75nVjvFgnk6rq5RQQysJdEwRP0tmCbgxNhY=;
  b=IWLW30SGuWdHN8OJOvrVAxLYyde4rezasN5IBbL7a1dJlmWuyd7U3i1T
   uA2rMJRKqeATzSC7+uQdwYYQCXcrY7ULQvgzdMTHcVk7K8DrDz0yoA3Rt
   MtGQjhIjkLgJQU+bsyopNNK4/Tes0LVZuBVcvGlS3YxWKl+vCef8kMdya
   WtM5ZRZvGw7P8kHe+Kf1KR1dKHIX3sunm7+hzgrzi1sDKwMECXzprWrn7
   ylAtMU6F0lPJ4WkFif+BIUT+JH0o/gV6oFLdZPc+BHVpysgJyYPV2K2QK
   1yNTdo4RxkR/0OeWfeH3GleVqFNag0U3PPaz/6lYaVGtT1VylIk/TJ8fW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379694314"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379694314"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="701391896"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="701391896"
Received: from aboonloe-mobl.amr.corp.intel.com (HELO [10.212.186.99]) ([10.212.186.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:43:40 -0700
Message-ID: <bc58e1b1-8bce-3894-f840-57dd2d802932@linux.intel.com>
Date:   Tue, 16 May 2023 09:39:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/9] ASoC: amd: ps: handle soundwire interrupts in acp pci
 driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        --to=broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-3-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230516103543.2515097-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/23 05:35, Vijendar Mukunda wrote:
> Handle soundwire manager related interrupts in ACP PCI driver
> interrupt handler and schedule soundwire manager work queue for
> further processing.

"SoundWire" please

> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h  |  4 ++++
>  sound/soc/amd/ps/pci-ps.c | 42 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index f27f71116598..faf7be4d77c2 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -67,6 +67,10 @@
>  /* time in ms for acp timeout */
>  #define ACP_TIMEOUT		500
>  
> +#define ACP_SDW0_IRQ_MASK		21
> +#define ACP_SDW1_IRQ_MASK		2
> +#define ACP_ERROR_IRQ_MASK		29

Shouldn't this be in 0x representation or BIT/GENMASK?

> +
>  enum acp_config {
>  	ACP_CONFIG_0 = 0,
>  	ACP_CONFIG_1,
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index f3aa08dc05b2..6566ee14d300 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
>  static void acp63_enable_interrupts(void __iomem *acp_base)
>  {
>  	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
> +	writel(BIT(ACP_ERROR_IRQ_MASK), acp_base + ACP_EXTERNAL_INTR_CNTL);

BIT(FOO_MASK) is very odd.

BIT(ACP_ERROR_IRQ) or ACP_ERROR_IRQ_MASK?

>  }
>  
>  static void acp63_disable_interrupts(void __iomem *acp_base)
> @@ -102,23 +103,54 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
> +	if (ext_intr_stat & BIT(ACP_SDW0_IRQ_MASK)) {
> +		writel(BIT(ACP_SDW0_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
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
> +	if (ext_intr_stat1 & BIT(ACP_SDW1_IRQ_MASK)) {
> +		writel(BIT(ACP_SDW1_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +		pdev_index = adata->sdw1_dev_index;
> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +		if (amd_manager)
> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
> +		irq_flag = 1;
> +	}
> +
> +	if (ext_intr_stat & BIT(ACP_ERROR_IRQ_MASK)) {
> +		writel(BIT(ACP_ERROR_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> +		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
> +		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
> +		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
> +		irq_flag = 1;

it's not clear what this does? Looks like just filtering out interrupts
without doing anything about the interrupt source?

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
