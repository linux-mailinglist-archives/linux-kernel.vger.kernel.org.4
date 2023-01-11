Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256AA6660A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjAKQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjAKQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:35:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC91207
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454952; x=1704990952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JO/X1hLLWdoPZeV4e0U1XRXlWg6KprX6CGLGaYJyPyU=;
  b=b4bNyQpRH+mwsx4/HwoqCRBHybOH4PHvLSrSJME6IuHLgnHNw4pR9OQ5
   c0FOib74t5qgXGNFKASRa99kuaLOmL0UYT0B/Y3PIhOzQ/LSaacZ/R9aL
   yyBZyp09HYue0COiysm2Jt9GFhA+2AC45YoYsVFGJ8KGmvMX/k7EKPCb9
   sjBxMRx2LA3oAVFjqNYtjlA+Gks600NW6ciwpmAOAxAd/nQFvSJ36VGfp
   i+NvxZ+S/iohLj5+8wI5sFjzWYTYTGlVzLi8nfwTI/ZKrBPlJG0zpFtew
   e0TAw8b7ijSu3zi/ySeoDqkOXos/c/vhEHmZFJV6AaUcX69wpDPdkzJKo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324703960"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324703960"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408108"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408108"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:01 -0800
Message-ID: <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
Date:   Wed, 11 Jan 2023 07:32:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
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




> +#define AMD_SDW_CLK_STOP_MODE		1

there are multiple modes for clock stop in SoundWire, and multiple ways
for the link manager to deal with clock stop, you want a comment to
describe what this define refers to.

> +#define AMD_SDW_POWER_OFF_MODE		2
> +
> +struct acp_sdw_pdata {
> +	u16 instance;
> +	struct mutex *sdw_lock;

need a comment on what this lock protects.

> +};
> +#endif
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index b7535c7d093f..ed979e6d0c1d 100644
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
> +#define AMD_SDW_MAX_CONTROLLERS		2
>  
>  enum acp_config {
>  	ACP_CONFIG_0 = 0,
> @@ -77,6 +83,12 @@ enum acp_config {
>  	ACP_CONFIG_15,
>  };
>  
> +enum acp_pdev_mask {
> +	ACP63_PDM_DEV_MASK = 1,
> +	ACP63_SDW_DEV_MASK,
> +	ACP63_SDW_PDM_DEV_MASK,
> +};
> +
>  struct pdm_stream_instance {
>  	u16 num_pages;
>  	u16 channels;
> @@ -107,7 +119,15 @@ struct acp63_dev_data {
>  	struct resource *res;
>  	struct platform_device *pdev[ACP63_DEVS];
>  	struct mutex acp_lock; /* protect shared registers */
> +	struct fwnode_handle *sdw_fw_node;
>  	u16 pdev_mask;
>  	u16 pdev_count;
>  	u16 pdm_dev_index;
> +	u8 sdw_master_count;

for new contributions, it's recommended to use manager and peripheral.

> +	u16 sdw0_dev_index;
> +	u16 sdw1_dev_index;

probably need a comment on what the 0 and 1 refer to, it's not clear if
there's any sort of dependency/link with the 'sdw_master_count' above.

If this is related to the two controllers mentioned in the cover letter,
then an explanation of the sdw_master_count would be needed as well
(single variable for two controllers?)

> +	u16 sdw_dma_dev_index;
> +	bool is_dmic_dev;
> +	bool is_sdw_dev;
> +	bool acp_sdw_power_off;
>  };
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index e86f23d97584..85154cf0b2a2 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <sound/pcm_params.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/soundwire/sdw_amd.h>
>  
>  #include "acp63.h"
>  
> @@ -134,12 +135,68 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
> +	u8 count = 0;
> +	u32 acp_sdw_power_mode = 0;
> +	int index;
> +	int ret;
> +
> +	acp_data = dev_get_drvdata(dev);
> +	acp_data->acp_sdw_power_off = true;
> +	/* Found controller, find links supported */
> +	ret = fwnode_property_read_u8_array((acp_data->sdw_fw_node),
> +					    "mipi-sdw-master-count", &count, 1);
> +
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to read mipi-sdw-master-count: %d\n", ret);

one line?

> +		return -EINVAL;
> +	}
> +
> +	/* Check count is within bounds */
> +	if (count > AMD_SDW_MAX_CONTROLLERS) {
> +		dev_err(dev, "Controller count %d exceeds max %d\n",
> +			count, AMD_SDW_MAX_CONTROLLERS);

No. controllers and masters are different concepts, see the DisCo
specification for SoundWire. A Controller can have multiple Masters.

> +		return -EINVAL;
> +	}
> +
> +	if (!count) {
> +		dev_warn(dev, "No SoundWire controllers detected\n");
> +		return -EINVAL;
> +	}

is this really a warning, looks like a dev_dbg or info to me.

> +	dev_dbg(dev, "ACPI reports %d Soundwire Controller devices\n", count);

the term device is incorrect here, the DisCo spec does not expose ACPI
devices for each master.

"ACPI reports %d Managers"

> +	acp_data->sdw_master_count  = count;
> +	for (index = 0; index < count; index++) {
> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
> +		if (!link) {
> +			dev_err(dev, "Master node %s not found\n", name);
> +			return -EIO;
> +		}
> +
> +		fwnode_property_read_u32(link, "amd-sdw-power-mode",
> +					 &acp_sdw_power_mode);
> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
> +			acp_data->acp_sdw_power_off = false;

does power-off mean 'clock-stop'?

> +	}
> +	return 0;
> +}
> +

> +		if (is_dmic_dev && is_sdw_dev) {
> +			switch (acp_data->sdw_master_count) {
> +			case 1:
> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
> +				break;
> +			case 2:
> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
> +				break;

so the cover letter is indeed wrong and confuses two controllers for two
managers.

> +			default:
> +				return -EINVAL;
> +			}
> +		} else if (is_dmic_dev) {
>  			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>  			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
> +		} else if (is_sdw_dev) {
> +			switch (acp_data->sdw_master_count) {
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
>  	}
> +	return 0;
>  }

