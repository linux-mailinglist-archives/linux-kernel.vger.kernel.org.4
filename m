Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1063A6660A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjAKQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjAKQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A363CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454962; x=1704990962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XHUr/CORx1SuyvuYcSDmm9Qfy38H53He+lyFrfgcJxM=;
  b=RWJMg7EQgDJ2tFUlemsGpOV5OJJETxttE5+lcsbsP/r3QxxbP8zxAuna
   ++eGVNA+sNwFVbz60r/Zq0ycOCBY69MZjlUT0FmwqXRcJoUCIhQd86x44
   m1Da2GK8Qm7n5514vKHXoctYpXtJkKmRYUGeV0zztuumefE/W4rQ0ap6e
   PM/0/qcormSfsQGML2RbZ15ncHBOYkXE7XfS8WY+UawiW9ZSmM9rS4IpX
   vXrJYYHrCffxmcnFKntqZL2LKrXE+eZh+iu08cz9/mV+Q4GPWNwThCiqg
   nOQiJCh3/bvo49hiBEbvrLNVSKC7Akbi5ARPlfE6nAiIRLBytwcmA0IRO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704075"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704075"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408443"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408443"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:20 -0800
Message-ID: <6a0fa6bd-efb0-9363-4c8d-0e919992557f@linux.intel.com>
Date:   Wed, 11 Jan 2023 09:22:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 07/19] ASoC: amd: ps: add soundwire dma driver for pink
 sardine platform
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
 <20230111090222.2016499-8-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-8-Vijendar.Mukunda@amd.com>
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
> Soundwire DMA platform driver binds to the platform device created by
> ACP PCI device. Soundwire DMA driver registers ALSA DMA component
> with ASoC framework.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h      |  5 +++
>  sound/soc/amd/ps/ps-sdw-dma.c | 72 +++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 0bd9dc363461..b462320fdf2a 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -135,3 +135,8 @@ struct acp63_dev_data {
>  	bool is_sdw_dev;
>  	bool acp_sdw_power_off;
>  };
> +
> +struct sdw_dma_dev_data {
> +	void __iomem *acp_base;
> +	struct mutex *acp_lock;
> +};
> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
> new file mode 100644
> index 000000000000..388a4b7df715
> --- /dev/null
> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AMD ALSA SoC Pink Sardine Soundwire DMA Driver
> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#include "acp63.h"
> +
> +#define DRV_NAME "amd_ps_sdw_dma"
> +
> +static const struct snd_soc_component_driver acp63_sdw_component = {
> +	.name		= DRV_NAME,
> +};
> +
> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct sdw_dma_dev_data *sdw_data;
> +	int status;
> +
> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
> +		return -ENODEV;
> +	}
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		return -ENODEV;
> +	}
> +
> +	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
> +	if (!sdw_data)
> +		return -ENOMEM;
> +
> +	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!sdw_data->acp_base)
> +		return -ENOMEM;
> +
> +	sdw_data->acp_lock = pdev->dev.platform_data;
> +	dev_set_drvdata(&pdev->dev, sdw_data);
> +	status = devm_snd_soc_register_component(&pdev->dev,
> +						 &acp63_sdw_component,
> +						 NULL, 0);
> +	if (status) {
> +		dev_err(&pdev->dev, "Fail to register acp pdm dai\n");

not sure what this means? Are you registering a PDM component or a DMA one?

> +
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +static struct platform_driver acp63_sdw_dma_driver = {
> +	.probe = acp63_sdw_platform_probe,
> +	.driver = {
> +		.name = "amd_ps_sdw_dma",
> +	},
> +};
> +
> +module_platform_driver(acp63_sdw_dma_driver);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_DESCRIPTION("AMD ACP6.3 PS SDW DMA Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);
