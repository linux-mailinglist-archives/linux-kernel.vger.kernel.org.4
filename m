Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64955724804
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjFFPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbjFFPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1AC139
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066019; x=1717602019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Yd7V++zdvA2vEUkR1sYRPT7hNptU858SN5zGbFEXrY=;
  b=apAOSI+2yF4UhOOnMyLxUYPWwUyDVl3V927vBXZfsGNZGE6RB7JMsLna
   IZDM6BfMNxMORXYIiVR0ZpHGYzuh4bWJXSo3ZuX5zWcYFHIqVNA89v5l5
   ZXcwh8I8tIF2xb7As8h9pQBFnfFnxnDQwK7sPr9nM9TSUoe2XPgMg8gro
   4ZnaCWsGH429wVWamfwMng2hZ9thLXxw25H4mj6WxveGfbyFGA3A8GeGb
   ztVk99BB88UXsRwWdvUNfQfl0ZLHws/tl68pjaZOjM3Xsg0yGSyJgFMal
   ZIslqMwL3xj2/1tOQ0kSsncBRBRqJdrkMK7SUYAA6FfvQv395JbsyhhLg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422550127"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422550127"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955816512"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955816512"
Received: from pdonvalk-mobl2.amr.corp.intel.com (HELO [10.255.231.168]) ([10.255.231.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:06 -0700
Message-ID: <00aeb130-b3d0-ebab-51da-4e590eef8c7b@linux.intel.com>
Date:   Tue, 6 Jun 2023 09:00:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 1/9] ASoC: amd: ps: create platform devices based on
 acp config
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
 <20230606060724.2038680-2-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230606060724.2038680-2-Vijendar.Mukunda@amd.com>
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




> +/**
> + * acp_pdev_mask corresponds to platform device mask based on audio endpoint combinations.
> + * acp_pdev_mask will be calculated based on ACPI Scan under ACP PCI device and
> + * ACP PIN Configuration.
> + * Based acp_pdev_mask, platform devices will be created.
> + * Below are possible platform device combinations.
> + * 1) ACP PDM Controller, dmic-codec, machine driver platform device node
> + * 2) ACP PDM Controller , dmic-codec, SW0 SoundWire manager instance, platform device for
> + *    SoundWire DMA driver
> + * 3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
> + * 4) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for
> + *    SoundWire DMA driver
> + * ACP63_PDM_DEV_MASK corresponds to platform device mask for ACP PDM controller.
> + * ACP63_SDW_DEV_MASK corresponds to platform device mask for SDW manager instances.
> + * ACP63_SDW_PDM_DEV_MASK corresponds to platform device mask for ACP PDM + SDW manager combination
> + */
> +enum acp_pdev_mask {
> +	ACP63_PDM_DEV_MASK = 1,
> +	ACP63_SDW_DEV_MASK,
> +	ACP63_SDW_PDM_DEV_MASK,
> +};

This does not look like a mask, the definitions prevent bit-wise
operations from happening.

Either use BIT(0), BIT(1), BIT(2) or GENMASK(1, 0), or demote this to a
regular enum (e.g. pdev_config or something)

> +
>  struct pdm_stream_instance {
>  	u16 num_pages;
>  	u16 channels;
> @@ -95,14 +144,38 @@ struct pdm_dev_data {
>  	struct snd_pcm_substream *capture_stream;
>  };
>  
> +/**
> + * struct acp63_dev_data - acp pci driver context
> + * @acp63_base: acp mmio base
> + * @res: resource
> + * @pdev: array of child platform device node structures
> + * @acp_lock: used to protect acp common registers
> + * @sdw_fw_node: SoundWire controller fw node handle
> + * @pdev_mask: platform device mask
> + * @pdev_count: platform devices count
> + * @pdm_dev_index: pdm platform device index
> + * @sdw_manager_count: SoundWire manager instance count
> + * @sdw0_dev_index: SoundWire Manager-0 platform device index
> + * @sdw1_dev_index: SoundWire Manager-1 platform device index
> + * @sdw_dma_dev_index: SoundWire DMA controller platform device index
> + * @acp_reset: flag set to true when bus reset is applied across all
> + * the active SoundWire manager instances
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
> +	bool acp_reset;
>  };
>  
>  int snd_amd_acp_find_config(struct pci_dev *pci);
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 54752d6040d6..816c22e7f1ab 100644
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
> @@ -119,37 +121,162 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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

IIRC this is only defined in the DisCo 2.0 spec, previous editions had a
'mipi-master-count'. A comment would not hurt to point to the minimal
DisCo spec version.

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
> +	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
> +	acp_data->sdw_manager_count = count;
> +	for (index = 0; index < count; index++) {
> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
> +		if (!link) {
> +			dev_err(dev, "Manager node %s not found\n", name);
> +			return -EIO;
> +		}
> +
> +		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * when SoundWire configuration is selected from acp pin config,
> +		 * based on manager instances count, acp init/de-init sequence should be
> +		 * executed as part of PM ops only when Bus reset is applied for the active
> +		 * SoundWire manager instances.
> +		 */
> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
> +			acp_data->acp_reset = false;
> +			return 0;
> +		}
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
> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>  		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",

usually properties start with the 'mipi-' or 'vendor-' prefix. Is there
a missing 'amd-' here or is 'acp-' unique enough?
