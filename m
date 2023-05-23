Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99570E490
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbjEWSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjEWSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:24:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE948F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684866275; x=1716402275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tuFnnzUtO+j+G9zdngej++eyid3nUrqyPHqy1/mTfTQ=;
  b=WdhUW8h4i+WYX3aVQxUwQGq+wO1hmidmyefcmmjyr7o6JPHWHQp7oEQ+
   OAnN44fA7fEpY61Bj7yyJVZQHmg0kwl5LpKWPL2p1oLEcy3S0smwC8OOo
   pNzHGWPuUuxzDa+y0PEiFfWH97FUTwWKwli3NX7eAII1pLEKrj6IL1Rla
   maUrUZw8Rdvc9QiDtYeg7RkdM4e0Ms1itNPfZ5PdSy8PbPDTkGkUOeQNO
   1H47YvDEkWya5ZvMUER8OtDbFp68jpg0r9gQHfNGl6BDMKh5chU09ZhXc
   XXNpuhoDXOAXPANBHIXtXF1g60NJFILdkpBknZ9lmelUlPZ0vwuIOHbF8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342786210"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="342786210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="736974290"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="736974290"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:33 -0700
Message-ID: <dd93f315-79ef-5108-0cae-fbfafafb9a12@linux.intel.com>
Date:   Tue, 23 May 2023 09:29:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/9] ASoC: amd: ps: create platform devices based on
 acp config
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
 <20230522133122.166841-2-Vijendar.Mukunda@amd.com>
 <1d73963a-de26-a147-6ccb-e5c8c65f579b@linux.intel.com>
 <a9723614-2ee8-279c-8a95-28535ca47709@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <a9723614-2ee8-279c-8a95-28535ca47709@amd.com>
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


>>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>>  {
>>>  	struct acpi_device *dmic_dev;
>>> +	struct acpi_device *sdw_dev;
>>>  	const union acpi_object *obj;
>>>  	bool is_dmic_dev = false;
>> useless init
> We are checking is_dmic_dev & is_sdw_dev flags in same code.
> Either we need to explicitly update value as false when no ACP PDM
> /SoundWire manager instances not found.

please discard my comment, I read this sideways

>>
>>> +	bool is_sdw_dev = false;
>> and useless init as well...

same here.
>>
>>> +	int ret;
>>>  
>>>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>>  	if (dmic_dev) {
>>> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>>>  		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>>>  					   ACPI_TYPE_INTEGER, &obj) &&
>>>  					   obj->integer.value == ACP_DMIC_DEV)
>>>  			is_dmic_dev = true;
>>>  	}
>>>  
>>> +	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
>>> +	if (sdw_dev) {
>>> +		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
>>> +		ret = sdw_amd_scan_controller(&pci->dev);
>>> +		/* is_sdw_dev flag will be set when SoundWire Manager device exists */
>>> +		if (!ret)
>>> +			is_sdw_dev = true;
>> sdw_amd_scan_controller() can return -EINVAL, how is this handled?
>> Shouldn't you stop execution and return here in the < 0 case?
> As per our design, ACP PCI driver probe should be successful, even
> there are no ACP PDM or Soundwire Manager instance configuration
> related platform devices.
> 
> The ACP PCI driver is multi-use and that even if SoundWire manager
> instances or PDM controller is not found, it will still be used to set the
> hardware to proper low power states. i.e ACP should enter D3 state
> after successful execution of probe sequence.

Ah ok, maybe a reworded comment would make sense then, e.g.

"continue probe and discard errors if SoundWire Manager is not described
in ACPI tables"

Same for DMIC above
