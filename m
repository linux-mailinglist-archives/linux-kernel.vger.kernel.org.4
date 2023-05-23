Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92970E492
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjEWSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbjEWSYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:24:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420E8F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684866278; x=1716402278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ix13VAl7dfaEjHEjOpNS6mBHoH/Qpd2+FxMGVb01JO4=;
  b=TlW/z0cqjcuK9sz+czdVgkv4yy60pzeZabmHToMse19MLPQxwiGKDogp
   qBVTjg7kFxWSSK9ZRSY40Are7OzOVdvwY0F4FKv8PXTeD36TDoZb0OFz/
   FjcPgV4Ry9O+OOBEhvsz8X3r/GzZaryIO7S6veQZmh0zEDQ5PQq4wFhK9
   W/fGzmbkE66uSGa+KSYb9KOC2kV0voKQtjGo0/4DlhcT31DsDRUeboCQZ
   mykyDJmNW/WgV6jKHsJ5O/4HkQ5+eFQ9+yJDcHh4gLbQnFbLpdWxYHYxT
   Xs1k0iLmr4NZUl0H4aes8XtUUYCiW55iV1xjehb7sy3NtOaMJOffIz5Js
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342786239"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="342786239"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="736974294"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="736974294"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:36 -0700
Message-ID: <904f47b6-46f4-039c-2019-4ee60ac6d9da@linux.intel.com>
Date:   Tue, 23 May 2023 09:48:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/9] ASoC: amd: ps: add SoundWire dma driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-4-Vijendar.Mukunda@amd.com>
 <0bf45d6e-72bc-d31a-fec5-b52859b8dcae@linux.intel.com>
 <129df804-a05e-47a6-cfa3-cc36282955d1@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <129df804-a05e-47a6-cfa3-cc36282955d1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>> +struct sdw_dma_dev_data {
>>> +	void __iomem *acp_base;
>>> +	struct mutex *acp_lock; /* used to protect acp common register access */
>>> +};
>>> +
>>>  /**
>>>   * struct acp63_dev_data - acp pci driver context
>>>   * @acp63_base: acp mmio base
>>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>>> new file mode 100644
>>> index 000000000000..f41849fd035c
>>> --- /dev/null
>>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>>> @@ -0,0 +1,70 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * AMD ALSA SoC Pink Sardine SoundWire DMA Driver
>>> + *
>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <sound/pcm_params.h>
>>> +#include <sound/soc.h>
>>> +#include <sound/soc-dai.h>
>>> +#include "acp63.h"
>>> +
>>> +#define DRV_NAME "amd_ps_sdw_dma"
>>> +
>>> +static const struct snd_soc_component_driver acp63_sdw_component = {
>>> +	.name		= DRV_NAME,
>>> +};
>>> +
>>> +static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>> +{
>>> +	struct resource *res;
>>> +	struct sdw_dma_dev_data *sdw_data;
>>> +	int status;
>>> +
>>> +	if (!pdev->dev.platform_data) {
>>> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
>>> +		return -ENODEV;
>>> +	}
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!res) {
>>> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
>>> +	if (!sdw_data)
>>> +		return -ENOMEM;
>>> +
>>> +	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>> +	if (!sdw_data->acp_base)
>>> +		return -ENOMEM;
>>> +
>>> +	sdw_data->acp_lock = pdev->dev.platform_data;
>> so you are sharing the same lock between parent and child platform device?
> Initially, we thought of sharing the same lock between parent and child
> platform devices. Later we have observed, mutex hang issues observed.

If the goal is a global lock, then the platform data should contain a
pointer to the lock. We used this for Intel, see .e.g. the shim_mask in
drivers/soundwire/intel_init.c, where the same pointer is used by all
children.

> 
> We have avoided critical section code and removed acp_lock from
> ACP SoundWire DMA driver while accessing ACP common registers.
> We will remove mutex lock from ACP SoundWire DMA driver code.
>> Does this work? IIRC the platform_data is copied, you do not point
>> directly to the initial data provided by the parent. We had issues with
>> SoundWire when we used platform devices, with the 'wrong' pointer used.
> Till now, we haven't observed mutex hang issues due to
> ACP PDM driver mutex lock changes.
> Agreed. We will remove the mutex code from ACP PDM driver as
> well and we will refactor code.
> In SoundWire manager driver, we are sharing the same copy for two
> manager instances. We haven't observed any issue.

What's the benefit of passing this lock as platform_data, if the goal is
to perform mutual exclusion between the two manager instances? Why not
just create the lock as part of the SoundWire probe?

If there was no need for a lock, then please remove it :-)

If it's needed, please describe what it protects, which agents rely on
it and how the lock is shared.

>>
>> The documentation does make mention of a copy....
>>
>> /**
>>  * platform_device_add_data - add platform-specific data to a platform
>> device
>>  * @pdev: platform device allocated by platform_device_alloc to add
>> resources to
>>  * @data: platform specific data for this platform device
>>  * @size: size of platform specific data
>>  *
>>  * Add a copy of platform specific data to the platform device's
>>  * platform_data pointer.  The memory associated with the platform data
>>  * will be freed when the platform device is released.
>>  */
>>> +	dev_set_drvdata(&pdev->dev, sdw_data);
>>> +	status = devm_snd_soc_register_component(&pdev->dev,
>>> +						 &acp63_sdw_component,
>>> +						 NULL, 0);
>>> +	if (status)
>>> +		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>>> +
>>> +	return status;
>>> +}

