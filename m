Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D923970527C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjEPPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjEPPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:43:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1E1B1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684251831; x=1715787831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Vxi36mgu/Fu/p9QwYwFgNx6aP9zE7LW9i6i9LGYqO0=;
  b=gcTEDSBy7b3bmOopnCgEP5XWtRaGhUpNw/soDaHX5loQG0YSJu0rVo8/
   +4HcrpJwtwvFYJ+nNYYfGYN8xyPMF77XOmisUS5Z4LRGFQi7/6fYjrf4f
   avxGn5eMkO7LTt8uGf9bz5nmyh9OBQ8eW7/b8Jn4g22gkCDycsEoEyEfn
   u9WwuhImG6rtZ9IVdXRURwDpuYnrec/fTjArFBJMVO9UwcjGf+D5isnqC
   Ee+IDaMUHzay/HaLxWw6M5o0gkJ/YTbtBzf87Mg9iDyekNc86V/BoF0x8
   74cmpa8IPLbeVNyfmf8GNPX8Jo87Lmti+afZocFzhAnQrjmD6hnKuKeKy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379694284"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379694284"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="701391890"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="701391890"
Received: from aboonloe-mobl.amr.corp.intel.com (HELO [10.212.186.99]) ([10.212.186.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:43:38 -0700
Message-ID: <a94650e0-f7b4-b431-5a3c-042ce724cf50@linux.intel.com>
Date:   Tue, 16 May 2023 09:32:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/9] ASoC: amd: ps: create platform devices based on acp
 config
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
 <20230516103543.2515097-2-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230516103543.2515097-2-Vijendar.Mukunda@amd.com>
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
> Create platform devices for Soundwire Manager instances and
> PDM controller based on ACP pin config selection
> and ACPI fw handle for pink sardine platform.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h  |  43 ++++++-
>  sound/soc/amd/ps/pci-ps.c | 250 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 280 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 2f94448102d0..f27f71116598 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -10,7 +10,7 @@
>  #define ACP_DEVICE_ID 0x15E2
>  #define ACP63_REG_START		0x1240000
>  #define ACP63_REG_END		0x1250200
> -#define ACP63_DEVS		3
> +#define ACP63_DEVS		5
>  
>  #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
>  #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
> @@ -55,8 +55,14 @@
>  
>  #define ACP63_DMIC_ADDR		2
>  #define ACP63_PDM_MODE_DEVS		3
> -#define ACP63_PDM_DEV_MASK		1
>  #define ACP_DMIC_DEV	2
> +#define ACP63_SDW0_MODE_DEVS		2
> +#define ACP63_SDW0_SDW1_MODE_DEVS	3
> +#define ACP63_SDW0_PDM_MODE_DEVS	4
> +#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
> +#define ACP63_DMIC_ADDR			2
> +#define ACP63_SDW_ADDR			5
> +#define AMD_SDW_MAX_MANAGERS		2
>  
>  /* time in ms for acp timeout */
>  #define ACP_TIMEOUT		500
> @@ -80,6 +86,12 @@ enum acp_config {
>  	ACP_CONFIG_15,
>  };
>  
> +enum acp_pdev_mask {
> +	ACP63_PDM_DEV_MASK = 1,
> +	ACP63_SDW_DEV_MASK,
> +	ACP63_SDW_PDM_DEV_MASK,
> +};

a comment or kernel-doc wouldn't hurt to explain the difference between
ACP63_PDM_DEV_MASK and ACP63_SDW_PDM_DEV_MASK, the meaning of the 'SDW"
prefix is far from obvious.

> +
>  struct pdm_stream_instance {
>  	u16 num_pages;
>  	u16 channels;
> @@ -95,14 +107,41 @@ struct pdm_dev_data {
>  	struct snd_pcm_substream *capture_stream;
>  };
>  
> +/**
> + * struct acp63_dev_data - acp pci driver context
> + * @acp63_base: acp mmio base
> + * @res: resource
> + * @pdev: child platform device node structures

array of platform devices ?

> + * @acp_lock: used to protect acp common registers
> + * @sdw_fw_node: SoundWire controller fw node handle
> + * @pdev_mask: platform device mask
> + * @pdev_count: platform devices count
> + * @pdm_dev_index: pdm platform device index
> + * @sdw0_dev_index: Soundwire Manager-0 platform device index
> + * @sdw1_dev_index: Soundwire Manager-1 platform device index
> + * @sdw_dma_dev_index: Soundwire DMA controller platform device index
> + * @is_dmic_dev: flag set to true if DMIC device exists

it's not clear what 'DMIC device' refers to here and why it is exposed here.

> + * @is_sdw_dev: flag set to true if Soundwire manager devices exists

same, what does this track? What is the difference between 'dmic dev'
and 'sdw_dev', given that there are references above to SDW_PDM. It's
confusing.

> + * @acp_reset: flag set to true when bus reset is applied across all
> + * the active soundwire manager instances

SoundWire

> + */
> +
>  struct acp63_dev_data {
>  	void __iomem *acp63_base;
>  	struct resource *res;
>  	struct platform_device *pdev[ACP63_DEVS];
>  	struct mutex acp_lock; /* protect shared registers */
> +	struct fwnode_handle *sdw_fw_node;
>  	u16 pdev_mask;
>  	u16 pdev_count;
>  	u16 pdm_dev_index;
> +	u8 sdw_manager_count;
> +	u16 sdw0_dev_index;
> +	u16 sdw1_dev_index;
> +	u16 sdw_dma_dev_index;
> +	bool is_dmic_dev;
> +	bool is_sdw_dev;
> +	bool acp_reset;
>  };
>  
>  int snd_amd_acp_find_config(struct pci_dev *pci);
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index c957718abefc..f3aa08dc05b2 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> @@ -15,6 +16,7 @@
>  #include <sound/pcm_params.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/iopoll.h>
> +#include <linux/soundwire/sdw_amd.h>
>  
>  #include "acp63.h"
>  
> @@ -119,12 +121,70 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
> -				    struct acp63_dev_data *acp_data)
> +static int sdw_amd_scan_controller(struct device *dev)
> +{
> +	struct acp63_dev_data *acp_data;
> +	struct fwnode_handle *link;
> +	char name[32];
> +	u32 sdw_manager_bitmap;
> +	u8 count = 0;
> +	u32 acp_sdw_power_mode = 0;
> +	int index;
> +	int ret;
> +
> +	acp_data = dev_get_drvdata(dev);
> +	acp_data->acp_reset = true;
> +	/* Found controller, find links supported */
> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
> +					     &sdw_manager_bitmap, 1);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
> +		return -EINVAL;
> +	}
> +	count = hweight32(sdw_manager_bitmap);
> +	/* Check count is within bounds */
> +	if (count > AMD_SDW_MAX_MANAGERS) {
> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
> +		return -EINVAL;
> +	}
> +
> +	if (!count) {
> +		dev_dbg(dev, "No SoundWire Managers detected\n");
> +		return -EINVAL;
> +	}
> +	dev_dbg(dev, "ACPI reports %d Soundwire Manager devices\n", count);
> +	acp_data->sdw_manager_count = count;
> +	for (index = 0; index < count; index++) {
> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
> +		if (!link) {
> +			dev_err(dev, "Manager node %s not found\n", name);
> +			return -EIO;
> +		}
> +
> +		fwnode_property_read_u32(link, "amd-sdw-power-mode",
> +					 &acp_sdw_power_mode);
> +		/*
> +		 * when soundwire configuration is selected from acp pin config,
> +		 * based on manager instances count, acp init/de-init sequence should be
> +		 * executed as part of PM ops only when Bus reset is applied for the active
> +		 * soundwire manager instances.

try to be consistent and use the MIPI spelling in comments: "SoundWire".

> +		 */
> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
> +			acp_data->acp_reset = false;
> +	}
> +	return 0;
> +}
> +
> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>  {
>  	struct acpi_device *dmic_dev;
> +	struct acpi_device *sdw_dev;
>  	const union acpi_object *obj;
>  	bool is_dmic_dev = false;
> +	bool is_sdw_dev = false;
> +	int ret;
>  
>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>  	if (dmic_dev) {
> @@ -134,22 +194,83 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>  			is_dmic_dev = true;
>  	}
>  
> +	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
> +	if (sdw_dev) {
> +		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
> +		ret = sdw_amd_scan_controller(&pci->dev);
> +		if (!ret)
> +			is_sdw_dev = true;
> +	}
> +
> +	dev_dbg(&pci->dev, "Audio Mode %d\n", config);
>  	switch (config) {
> -	case ACP_CONFIG_0:
> -	case ACP_CONFIG_1:
> +	case ACP_CONFIG_4:
> +	case ACP_CONFIG_5:
> +	case ACP_CONFIG_10:
> +	case ACP_CONFIG_11:
> +		if (is_dmic_dev) {
> +			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
> +			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
> +		}
> +		break;
>  	case ACP_CONFIG_2:
>  	case ACP_CONFIG_3:
> -	case ACP_CONFIG_9:
> -	case ACP_CONFIG_15:
> -		dev_dbg(&pci->dev, "Audio Mode %d\n", config);
> +		if (is_sdw_dev) {
> +			switch (acp_data->sdw_manager_count) {
> +			case 1:
> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
> +				break;
> +			case 2:
> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
>  		break;
> -	default:
> -		if (is_dmic_dev) {
> +	case ACP_CONFIG_6:
> +	case ACP_CONFIG_7:
> +	case ACP_CONFIG_12:
> +	case ACP_CONFIG_8:
> +	case ACP_CONFIG_13:
> +	case ACP_CONFIG_14:
> +		if (is_dmic_dev && is_sdw_dev) {
> +			switch (acp_data->sdw_manager_count) {
> +			case 1:
> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
> +				break;
> +			case 2:
> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		} else if (is_dmic_dev) {
>  			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>  			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
> +		} else if (is_sdw_dev) {
> +			switch (acp_data->sdw_manager_count) {
> +			case 1:
> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
> +				break;
> +			case 2:
> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
>  		}
>  		break;
> +	default:
> +		break;

it really wouldn't hurt to have a high-level description of this series
of switch/ifs/else, it's very hard to review.

>  	}
> +	return 0;
>  }
>  
>  static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
> @@ -173,6 +294,7 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
>  
>  static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
>  {
> +	struct acp_sdw_pdata *sdw_pdata;
>  	struct platform_device_info pdevinfo[ACP63_DEVS];
>  	struct device *parent;
>  	int index;
> @@ -205,8 +327,110 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>  		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
>  					     0, NULL, 0, NULL, 0);
>  		break;
> +	case ACP63_SDW_DEV_MASK:
> +		if (adata->pdev_count == ACP63_SDW0_MODE_DEVS) {
> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
> +						 GFP_KERNEL);
> +			if (!sdw_pdata) {
> +				ret = -ENOMEM;
> +				goto de_init;
> +			}
> +
> +			sdw_pdata->instance = 0;
> +			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
> +			adata->sdw0_dev_index = 0;
> +			adata->sdw_dma_dev_index = 1;
> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
> +						     "amd_sdw_manager", 0, adata->res, 1,
> +						     sdw_pdata, sizeof(struct acp_sdw_pdata));
> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "amd_ps_sdw_dma",
> +						     0, adata->res, 1, &adata->acp_lock,
> +						     sizeof(adata->acp_lock));
> +		} else if (adata->pdev_count == ACP63_SDW0_SDW1_MODE_DEVS) {
> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
> +						 GFP_KERNEL);
> +			if (!sdw_pdata) {
> +				ret = -ENOMEM;
> +				goto de_init;
> +			}
> +
> +			sdw_pdata[0].instance = 0;
> +			sdw_pdata[1].instance = 1;
> +			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
> +			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
> +			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
> +			adata->sdw0_dev_index = 0;
> +			adata->sdw1_dev_index = 1;
> +			adata->sdw_dma_dev_index = 2;
> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
> +						     "amd_sdw_manager", 0, adata->res, 1,
> +						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
> +						     "amd_sdw_manager", 1, adata->res, 1,
> +						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
> +			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
> +						     0, adata->res, 1, &adata->acp_lock,
> +						     sizeof(adata->acp_lock));
> +		}
> +		break;
> +	case ACP63_SDW_PDM_DEV_MASK:
> +		if (adata->pdev_count == ACP63_SDW0_PDM_MODE_DEVS) {
> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
> +						 GFP_KERNEL);
> +			if (!sdw_pdata) {
> +				ret = -ENOMEM;
> +				goto de_init;
> +			}
> +
> +			sdw_pdata->instance = 0;
> +			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
> +			adata->pdm_dev_index = 0;
> +			adata->sdw0_dev_index = 1;
> +			adata->sdw_dma_dev_index = 2;
> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
> +						     0, adata->res, 1, &adata->acp_lock,
> +						     sizeof(adata->acp_lock));
> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
> +						     "amd_sdw_manager", 0, adata->res, 1,
> +						     sdw_pdata, sizeof(struct acp_sdw_pdata));
> +			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
> +						     0, adata->res, 1, &adata->acp_lock,
> +						     sizeof(adata->acp_lock));
> +			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "dmic-codec",
> +						     0, NULL, 0, NULL, 0);
> +		} else if (adata->pdev_count == ACP63_SDW0_SDW1_PDM_MODE_DEVS) {
> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
> +						 GFP_KERNEL);
> +			if (!sdw_pdata) {
> +				ret = -ENOMEM;
> +				goto de_init;
> +			}
> +			sdw_pdata[0].instance = 0;
> +			sdw_pdata[1].instance = 1;
> +			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
> +			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
> +			adata->pdm_dev_index = 0;
> +			adata->sdw0_dev_index = 1;
> +			adata->sdw1_dev_index = 2;
> +			adata->sdw_dma_dev_index = 3;
> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
> +						     0, adata->res, 1, &adata->acp_lock,
> +						     sizeof(adata->acp_lock));
> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
> +						     "amd_sdw_manager", 0, adata->res, 1,
> +						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
> +			acp63_fill_platform_dev_info(&pdevinfo[2], parent, adata->sdw_fw_node,
> +						     "amd_sdw_manager", 1, adata->res, 1,
> +						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
> +			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "amd_ps_sdw_dma",
> +						     0, adata->res, 1, &adata->acp_lock,
> +						     sizeof(adata->acp_lock));
> +			acp63_fill_platform_dev_info(&pdevinfo[4], parent, NULL, "dmic-codec",
> +						     0, NULL, 0, NULL, 0);
> +		}
> +		break;
>  	default:
> -		dev_dbg(&pci->dev, "No PDM devices found\n");
> +		dev_dbg(&pci->dev, "No PDM or Soundwire manager devices found\n");

what does this mean? I find this debug adds more confusion.

>  		return 0;
>  	}
>  
> @@ -290,7 +514,11 @@ static int snd_acp63_probe(struct pci_dev *pci,
>  		goto de_init;
>  	}
>  	val = readl(adata->acp63_base + ACP_PIN_CONFIG);
> -	get_acp63_device_config(val, pci, adata);
> +	ret = get_acp63_device_config(val, pci, adata);
> +	if (ret) {
> +		dev_err(&pci->dev, "get acp device config failed:%d\n", ret);
> +		goto de_init;
> +	}
>  	ret = create_acp63_platform_devs(pci, adata, addr);
>  	if (ret < 0) {
>  		dev_err(&pci->dev, "ACP platform devices creation failed\n");
