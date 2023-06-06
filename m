Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0669F724805
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjFFPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbjFFPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4A10EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066021; x=1717602021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GelMQS7A/Lfhb0VxgBucg1eyg9fuPuwktHizh8Kwk48=;
  b=n4tyh8QLn5xm8va3nmQuO7cVozfPLxMfCtfJaeMf0HWgdrFQqcq6eOyL
   37qML6idr4Q3MlpeSL2LNUdx7V75UIjQEn0sBQFismCHEXiEp2gwvt/WQ
   myXkJNHI8Ik0hMeEgLrDFWMv9sCxlkZG2bnMz3o+ESUjlH+rn9oJNCY5k
   WT7Bi/a97HAQaZH2SUB4D8Tr5f27h9c5FMGDxb58dQIk+eVS97xqyyDmZ
   kAbA8ll37pOfqlTaA6BhFXhCiZci9blLsiESWgB0NWIzgmC9F5yv+DTQQ
   0twdSMymfqfopdA6yQV2j4V5mJWa+9yN+VTsA+HwsWA8nvojInadUHO5R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422550150"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422550150"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955816518"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955816518"
Received: from pdonvalk-mobl2.amr.corp.intel.com (HELO [10.255.231.168]) ([10.255.231.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:09 -0700
Message-ID: <652a07e4-49be-7715-cc77-b05f1727a496@linux.intel.com>
Date:   Tue, 6 Jun 2023 09:49:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp
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
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-3-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230606060724.2038680-3-Vijendar.Mukunda@amd.com>
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


>  static void acp63_disable_interrupts(void __iomem *acp_base)
> @@ -102,23 +103,60 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
> +	/* ACP interrupts will be cleared by reading particular bit and writing
> +	 * same value to the status register. writing zero's doesn't have any
> +	 * effect.
> +	 * Bit by bit checking of IRQ field is implemented.
> +	 */
> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> +	if (ext_intr_stat & ACP_SDW0_STAT) {
> +		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> +		pdev_index = adata->sdw0_dev_index;
> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +		if (amd_manager)

can this test be false?

> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
> +		irq_flag = 1;
> +	}
>  
> -	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> -	if (val & BIT(PDM_DMA_STAT)) {
> +	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +	if (ext_intr_stat1 & ACP_SDW1_STAT) {
> +		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> +		pdev_index = adata->sdw1_dev_index;
> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
> +		if (amd_manager)

can this be false?

> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
> +		irq_flag = 1;
> +	}
> +
> +	if (ext_intr_stat & ACP_ERROR_IRQ) {
> +		writel(ACP_ERROR_IRQ, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
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
