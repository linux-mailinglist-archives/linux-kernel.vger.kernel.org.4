Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3996660A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAKQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbjAKQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CE64DF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454966; x=1704990966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Tf4fOTtVxxPUIU5o6FffNBYvv8T1/1+ZdmCbPKp6+w=;
  b=lJh7vuURu7RFAZ96n10tZkKbISHDnyYoBdD+HpIpnlq/lT/wpAAcPYq8
   9q/NIimpUR0c5+hU5CbILXglU6RmU9DjQuvftU3kRyhv8i+vozRePZtqa
   FJOyK39J0MRWmWZundby5Z88e7bxrScIpZMhpbmxq6pC/GWhfbzOcR38r
   VyrDa4wd9pL4WVH0NvADnCvamgIoqbhW2h1vG+4hqdlj0WfTwUTptSfG8
   DMttZX+wieoC3VdYh4JojRBt2AzzIvARyR9YnJTh/V1u3oVNgFA3mq54v
   eesCQDRHY3TfMjtaFspR1f9Pc02mGFBkIzD8PWw9Kkwy/3wFpHLhL1am/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704143"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704143"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408589"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408589"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:29 -0800
Message-ID: <0d2ccd69-63e3-b8c5-396b-b698110cad14@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:38:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 09/19] ASoC: amd: ps: add support for Soundwire DMA
 interrupts
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-10-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-10-Vijendar.Mukunda@amd.com>
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




> @@ -167,9 +167,11 @@ struct acp63_dev_data {
>  	struct platform_device *pdev[ACP63_DEVS];
>  	struct mutex acp_lock; /* protect shared registers */
>  	struct fwnode_handle *sdw_fw_node;
> +	struct work_struct acp_sdw_dma_work;
>  	u16 pdev_mask;
>  	u16 pdev_count;
>  	u16 pdm_dev_index;
> +	u16 dma_intr_stat[ACP63_SDW_MAX_STREAMS];

streams and DMAs are different things in SoundWire. You can have a 1:N
mapping.

>  	u8 sdw_master_count;
>  	u16 sdw0_dev_index;
>  	u16 sdw1_dev_index;
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 0fbe5e27f3fb..5b82ee8e3ad8 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -113,14 +113,37 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
>  	return 0;
>  }
>  
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
> +	for (stream_index = 0; stream_index < ACP63_SDW_MAX_STREAMS; stream_index++) {
> +		if (adata->dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw_stream[stream_index])
> +				snd_pcm_period_elapsed(sdw_dma_data->sdw_stream[stream_index]);

is there a reason why you do this in a work thread?

IIRC we did this in SOF because of an issue where during an xrun a stop
IPC would be sent while we were dealing with an IPC.

I don't quite see why it's needed for a DMA?

What am I missing?

> +			adata->dma_intr_stat[stream_index] = 0;
> +		}
> +	}
> +}

