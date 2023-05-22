Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02870C536
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjEVScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjEVScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:32:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1478C2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684780325; x=1716316325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XMcOvcpn2XNfm3D+yAL/mRJvyTj4QDvdy7DS505FDp0=;
  b=g+U636I9b3cumVc7vv7FDCaJJRK9xg0Ud59WIOGxA31L+/0yt1gfgnyj
   HiWUa2N1MaLmVE44UuKFULG9GGlhP0zUmZip4CHTijSroZbVAmZn8ulN/
   GwlNbh14D7Y8Bb2wWWoYO05XtKJ9i2da/7W918Kgx2ZVvYqtMq32GTKTY
   CCdn9WlwJFhdKF+4WBpFSLN7fR3YTZu8KaMrqQWO8t5HsKLpY4UvmSRUW
   8Iw3LvBABTlAzUzPfjummiBGuyqRud74ynMWOtpJ3e7phdz9UOAUtNm22
   CTKR+Gez+xPf84EaxcIyHeRPvEVaP4GQdv0OgZYdJtrI8rlT1+3CBuDeJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356235087"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356235087"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697740832"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="697740832"
Received: from ljgreene-mobl.amr.corp.intel.com (HELO [10.209.124.121]) ([10.209.124.121])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:43 -0700
Message-ID: <1d73963a-de26-a147-6ccb-e5c8c65f579b@linux.intel.com>
Date:   Mon, 22 May 2023 11:16:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/9] ASoC: amd: ps: create platform devices based on
 acp config
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
 <20230522133122.166841-2-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230522133122.166841-2-Vijendar.Mukunda@amd.com>
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
> +		fwnode_property_read_u32(link, "amd-sdw-power-mode",
> +					 &acp_sdw_power_mode);

What happens if this property is not found or doesn't exist?

acp_sdw_power_mode is zero, so....


> +		/*
> +		 * when SoundWire configuration is selected from acp pin config,
> +		 * based on manager instances count, acp init/de-init sequence should be
> +		 * executed as part of PM ops only when Bus reset is applied for the active
> +		 * SoundWire manager instances.
> +		 */
> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
> +			acp_data->acp_reset = false;

... here this branch is taken.

Is this intentional?

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

useless init

> +	bool is_sdw_dev = false;

and useless init as well...

> +	int ret;
>  
>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>  	if (dmic_dev) {
> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>  		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>  					   ACPI_TYPE_INTEGER, &obj) &&
>  					   obj->integer.value == ACP_DMIC_DEV)
>  			is_dmic_dev = true;
>  	}
>  
> +	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
> +	if (sdw_dev) {
> +		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
> +		ret = sdw_amd_scan_controller(&pci->dev);
> +		/* is_sdw_dev flag will be set when SoundWire Manager device exists */
> +		if (!ret)
> +			is_sdw_dev = true;

sdw_amd_scan_controller() can return -EINVAL, how is this handled?
Shouldn't you stop execution and return here in the < 0 case?

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
>  	}
> +	return 0;
>  }

>  		dev_err(&pci->dev, "ACP platform devices creation failed\n");
