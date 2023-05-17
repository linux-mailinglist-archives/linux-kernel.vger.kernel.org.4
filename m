Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155EE706AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEQOL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjEQOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:11:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81861BE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684332704; x=1715868704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8HgIw9VAVYTdiooZ92+QUJuNuT32dgIhD+Z/vDMl4s=;
  b=k0b0ekU5tmQmcDDOcR/KTFT3BQWDDOWQcaOTfjkG941UyicAovIVqu19
   l0el2KQ5yGBj37rME235qyNMPhLbFgcoaXdZF9R+ScAVmuelPDPFJ9kCV
   1bP3mbIcM17QepahVGRlJyhAxVWaHMz+xTtyOWTFasHs3g0g3STEqAhkJ
   i1CbOJi4nf7/YwRBmXaejktut326X8a/+blzvyr/dAt0M77vlceLWv/cu
   EC7SGEchNs2P3HbPbzyKauBGlhajMBg6DmsusTwUUbgRL9NXDmOu/Whf1
   APDH360C7jJ7gOc9h4vhcLeQC2FqrGRVvc6Sk6jWm9E8IEzCCCWlF7k9N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349273434"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="349273434"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734709685"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="734709685"
Received: from rdealba-mobl.amr.corp.intel.com (HELO [10.209.16.101]) ([10.209.16.101])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:43 -0700
Message-ID: <a36ec243-feaa-d886-0fe8-bfb07472a89f@linux.intel.com>
Date:   Wed, 17 May 2023 08:40:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/9] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-2-Vijendar.Mukunda@amd.com>
 <a94650e0-f7b4-b431-5a3c-042ce724cf50@linux.intel.com>
 <c9afc5b7-b07d-1ef5-7c76-f592577f833a@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c9afc5b7-b07d-1ef5-7c76-f592577f833a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 03:38, Mukunda,Vijendar wrote:
> On 16/05/23 20:02, Pierre-Louis Bossart wrote:
>>
>> On 5/16/23 05:35, Vijendar Mukunda wrote:
>>> Create platform devices for Soundwire Manager instances and
>>> PDM controller based on ACP pin config selection
>>> and ACPI fw handle for pink sardine platform.
>>>
>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>> ---
>>>  sound/soc/amd/ps/acp63.h  |  43 ++++++-
>>>  sound/soc/amd/ps/pci-ps.c | 250 ++++++++++++++++++++++++++++++++++++--
>>>  2 files changed, 280 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>>> index 2f94448102d0..f27f71116598 100644
>>> --- a/sound/soc/amd/ps/acp63.h
>>> +++ b/sound/soc/amd/ps/acp63.h
>>> @@ -10,7 +10,7 @@
>>>  #define ACP_DEVICE_ID 0x15E2
>>>  #define ACP63_REG_START		0x1240000
>>>  #define ACP63_REG_END		0x1250200
>>> -#define ACP63_DEVS		3
>>> +#define ACP63_DEVS		5
>>>  
>>>  #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
>>>  #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
>>> @@ -55,8 +55,14 @@
>>>  
>>>  #define ACP63_DMIC_ADDR		2
>>>  #define ACP63_PDM_MODE_DEVS		3
>>> -#define ACP63_PDM_DEV_MASK		1
>>>  #define ACP_DMIC_DEV	2
>>> +#define ACP63_SDW0_MODE_DEVS		2
>>> +#define ACP63_SDW0_SDW1_MODE_DEVS	3
>>> +#define ACP63_SDW0_PDM_MODE_DEVS	4
>>> +#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
>>> +#define ACP63_DMIC_ADDR			2
>>> +#define ACP63_SDW_ADDR			5
>>> +#define AMD_SDW_MAX_MANAGERS		2
>>>  
>>>  /* time in ms for acp timeout */
>>>  #define ACP_TIMEOUT		500
>>> @@ -80,6 +86,12 @@ enum acp_config {
>>>  	ACP_CONFIG_15,
>>>  };
>>>  
>>> +enum acp_pdev_mask {
>>> +	ACP63_PDM_DEV_MASK = 1,
>>> +	ACP63_SDW_DEV_MASK,
>>> +	ACP63_SDW_PDM_DEV_MASK,
>>> +};
>> a comment or kernel-doc wouldn't hurt to explain the difference between
>> ACP63_PDM_DEV_MASK and ACP63_SDW_PDM_DEV_MASK, the meaning of the 'SDW"
>> prefix is far from obvious.
> Above enum's are listed to know the platform device masks.
> For example - if ACP63_PDM_DEV_MASK is set, then ACP PCI driver
> will create platform device for PDM controller.
> 
> If ACP63_SDW_DEV_MASK is set, ACP PCI driver will create platform device
> nodes for soundwire manager instances based on instance count retrieved
> by scanning the SoundWire Controller.
> 
> If ACP63_SDW_PDM_DEV_MASK is set, ACP PCI driver will create platform device
> nodes for PDM controller and SoundWire manager instances.
> 
> We will add comment for the same.

Ah ok, I completely missed that you could have PDM, SoundWire or
PDM+SoundWire configurations. I was reading this with SoundWire blinders
and thought you wanted to have PDM over SoundWire or something.

>>> -		dev_dbg(&pci->dev, "No PDM devices found\n");
>>> +		dev_dbg(&pci->dev, "No PDM or Soundwire manager devices found\n");
>> what does this mean? I find this debug adds more confusion.
> Currently, we are trying to create platform devices for PDM controller and SoundWire
> Manager instances based on ACP pin config and ACPI _ADDR fields scan under ACP PCI device
> scope.
> Earlier We have added support for ACP PDM controller.
> ACP PIN config supports different audio configurations other than PDM and SoundWire
> based audio endpoints.
> 
> If there is no pdev_mask set, it refers to default switch case.
> This dev_dbg statement to notify that no PDM and Soundwire manager devices found
> from ACPI scan.
> 
> This patch adds support for platform device creation logic for Soundwire manager instances &
> PDM controller combinations based on ACP PIN Config and ACPI _ADDR field scan.
> 
> Possible combination of platform device nodes:
> 
> 1) ACP PDM Controller, dmic-codec, machine driver platform device node
> 2) ACP PDM Controller , dmic-codec, SW0 manager instance, platform device for SoundWire DMA driver
> 3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
> 3) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for SoundWire DMA driver

right, you really want this in the commit message so that reviewers
understand the various configurations upfront. Trying to
reverse-engineer the code induces migraines ;-)

