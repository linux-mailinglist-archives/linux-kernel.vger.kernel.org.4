Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8E696DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjBNTW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjBNTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:22:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED4BB92
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676402572; x=1707938572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9DZVAA+wlCy183muiHl56v2KwqeBMqprVZFGarThNBo=;
  b=eG7Wq9zBj0rFGgKR35ATNo6j9bLB++/hLgE0IhADddPcp5BB8S+ROU8k
   rCBYc0V1aiVTHjE5Xi5T91+x1R3Nz77QWT6Kbxfq0i53RPzqrP/wy9R7K
   08WzgLI76hNaCIQX/ejKwfucOfQyn6E4zll/w9bXlomnAg41/aBUW47cN
   fv3QPfkZf+uSZX6e0RL23K9O+K1EquYilT2p+YcVetgpEntXiWwNcpvJT
   25Fr8iH1LuSydfId+tmrxNqLI7T0aDpHxIFB8NzJpinQMnAuiHpyhQ4r0
   CMnvcd4oWt+Of/eZCQyQJC3sKjg5Lo7kPW7Ni9vZs0GkUuYH/QVs2kbdN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314893708"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="314893708"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778485237"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778485237"
Received: from parthgup-mobl2.amr.corp.intel.com (HELO [10.209.175.23]) ([10.209.175.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:51 -0800
Message-ID: <b632ba86-767f-2813-ad2d-4a3424e6b02e@linux.intel.com>
Date:   Tue, 14 Feb 2023 07:28:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 5/8] soundwire: amd: add soundwire manager interrupt
 handling
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-6-Vijendar.Mukunda@amd.com>
 <9505941e-73a1-249b-08c2-83b86e7ef5c6@linux.intel.com>
 <2fc1191d-e57d-4b76-1c9c-088e33f2ad45@amd.com>
 <f739053c-d19b-f773-cead-77abad53feec@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <f739053c-d19b-f773-cead-77abad53feec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +update_status:
>>>> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>>>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>>>> +		if (retry_count++ < SDW_MAX_DEVICES) {
>>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>>>> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>>>> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>>>> +			amd_sdw_read_and_process_ping_status(amd_manager);
>>>> +			goto update_status;
>>>> +		} else {
>>>> +			dev_err_ratelimited(amd_manager->dev,
>>>> +					    "Device0 detected after %d iterations\n",
>>>> +					    retry_count);
>>>> +		}
>>>> +	}
>>> this seems rather inspired by the Cadence code, but is there really a
>>> case where you need to re-check for devices? In the Cadence case, this
>>> was added because we have a logical OR and new devices would not be handled.
>> As mentioned in V1 set, we have corner cases during enumeration sequence.
>> We observed device alerts are missing during peripheral enumeration sequence
>> when multiple peripheral devices are connected over the same link.
>> This is not inspired by Intel code.
>>
>> As per V1 version review comment, we have included retry_count logic to address
>> faulty case.
>>
>> We forgot to include comment. we will fix it.
> Slight correction in the explanation.
> 
> During the peripheral enumeration sequence, the soundwire peripheral interrupts
> are masked.
> If soundwire interrupts are not masked, it will cause side effects when multiple
> peripheral devices connected over the same link.
> As interrupts are masked, during device slot programming for each peripheral,
> soundwire manager driver won't receive any interrupts.
> 
> Once the device number programming is done for all peripherals, the soundwire
> interrupts will be unmasked. Read the peripheral device status from ping command
> and process the response, which will invoke the peripheral device initialization sequence.
> This sequence will ensure all peripheral devices enumerated and initialized
> properly.

Humm, the explanation is difficult to follow, it's not clear on which
side the interrupts are masked. Are you talking about the peripheral
being prevented from generating interrupts, or about the manager not
detecting peripheral state changes with an interrupt-based mechanism?

I am not sure what 'side effects' can happen, during enumeration all
devices show up as device0 and the SoundWire bus provides a mechanism to
enumerate without conflicts.
