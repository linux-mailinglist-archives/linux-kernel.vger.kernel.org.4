Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80215731DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjFOQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjFOQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:30:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E230273E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686846632; x=1718382632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wxqMg8pf+Z+Iffs07wBWUeS7VLTVDNo0vpmK0c0PBOE=;
  b=hLFw/TInoQeZ0gHgjYvavivsruUBNWjPwxGdd4/2V/DV5N/tsa9CeN1I
   lXyEJw+euE1Q+OMVzJpWp8l/3YinVHRpOojvb0KMRkfPw371yHxfQZwC/
   lxnrYkjh37V4jj8H/cbepnjiPRdrRm0r0rrlTQuXMNVtguHDm4XgW6cF1
   lsMGSkf6XUVNgQmrtQZOOFFueY0HK6mOdhSNzqhW/rvQVexmFRsXB1FyI
   SIcZ68o0+6luPPVm6FULEXSprrzmGGxC15MLQxE1FwH8e6exZAeJkD19A
   uN39EFGA37/TaGdA2NhL0IgUKtVm8xNKTgOLRjcfFJAfU4yV8Ea+a4pw6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="422603166"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="422603166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:24:27 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745640902"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745640902"
Received: from mrejmak-mobl.ger.corp.intel.com (HELO [10.252.36.104]) ([10.252.36.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:24:22 -0700
Message-ID: <59da8a18-752a-bc8c-c8c5-19d75d8c87fb@linux.intel.com>
Date:   Thu, 15 Jun 2023 18:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V4 1/9] ASoC: amd: ps: create platform devices based on
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
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-2-Vijendar.Mukunda@amd.com>
 <5899c2b8-e984-fda9-5e12-190b0c9fd3b2@linux.intel.com>
 <cd465394-5a19-239e-7aad-caa6f19b0918@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <cd465394-5a19-239e-7aad-caa6f19b0918@amd.com>
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



On 6/13/23 07:42, Mukunda,Vijendar wrote:
> On 12/06/23 23:39, Pierre-Louis Bossart wrote:
>> =
>>> +static int sdw_amd_scan_controller(struct device *dev)
>>> +{
>>> +	struct acp63_dev_data *acp_data;
>>> +	struct fwnode_handle *link;
>>> +	char name[32];
>>> +	u32 sdw_manager_bitmap;
>>> +	u8 count = 0;
>>> +	u32 acp_sdw_power_mode = 0;
>>> +	int index;
>>> +	int ret;
>>> +
>>> +	acp_data = dev_get_drvdata(dev);
>>> +	/*
>>> +	 * Current implementation is based on MIPI DisCo 2.0 spec.
>>> +	 * Found controller, find links supported.
>>> +	 */
>>> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
>>> +					     &sdw_manager_bitmap, 1);
>>> +
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
>>> +		return -EINVAL;
>>> +	}
>>> +	count = hweight32(sdw_manager_bitmap);
>>> +	/* Check count is within bounds */
>>> +	if (count > AMD_SDW_MAX_MANAGERS) {
>>> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
>>> +		return -EINVAL;
>>> +	}
>> nit-pick: the count is not enough, you should also check that only bits
>> 0 and 1 are set in mipi-sdw-manager-list...
> As per our design for PS platform,
> we will go with two bit map values as 0x03 and 0x01.
> 1. As per ACP PIN CONFIG, we support Single SDW Manager instance
> which refers to SW0 manager instance. For this, we need to use bitmap
> value as 0x01.
> 2. Other bit map value - 0x03 will be used to populate two SoundWire
> manager instances.
> We have extra sub property "amd-sdw-enable" to invoke the init sequence
> for SoundWire manager.
> 
> As we are supporting two bit map value combinations here, it's not required
> to check bit set value. count value is enough to know manager instance count.
> It doesn't break anything.

Not a blocker but you underestimate the creativity of UEFI BIOS writers...

