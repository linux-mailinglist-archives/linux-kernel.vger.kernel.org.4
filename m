Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C106B0A41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjCHOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjCHOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:00:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545891B48
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678283926; x=1709819926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fDkj2qqI5Hd3gyncELfzGm9AhlqswmOIQl8Kz6+UxNw=;
  b=JdRHEvlw+oZNBtK8LlCw4ZAuyLF6AX/LO1fuL/1Pp8Y+SjYxBB8DTPUm
   H5s1+kxDUw3ZpgaU0PB7gnBfmhjA0YsdZiwk6tyx+0jfageSRP6rCT5ai
   AXobrhwHFMkUHW1siJCZWsTjXWJJygMhImEJp/uosbmDns3+NJyRXDm+R
   TfGxeOz5BCUbQdRXIfbBH0qMMIcUHWTz34JOZdrP4wuGnTMKaPUKfWplY
   zhUTqDJOwhWqeRNJwkvJWD5zqKlAQLAI15YvN81ALDNpv7i1B/p/GZFcn
   6wKM6i3sYNkC5CcuVXpGuT5LrW+CsSlTSujArva/tNVm4xQI5PRwDQx8S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="336170527"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="336170527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="709429695"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="709429695"
Received: from vkhatavx-mobl.amr.corp.intel.com (HELO [10.255.34.124]) ([10.255.34.124])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:58:44 -0800
Message-ID: <85aba51e-1feb-5eb0-2e21-b714e217f9e4@linux.intel.com>
Date:   Wed, 8 Mar 2023 07:58:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
 <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
 <d5a75826-d762-27fc-5820-6826debdecd9@amd.com>
 <9399110b-bbba-f96e-85ef-a317e8f4d518@linux.intel.com>
 <4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 22:32, Mukunda,Vijendar wrote:
> On 08/03/23 02:38, Pierre-Louis Bossart wrote:
>>
>> On 3/7/23 14:25, Mukunda,Vijendar wrote:
>>> On 07/03/23 20:58, Pierre-Louis Bossart wrote:
>>>>> +static int amd_resume_child_device(struct device *dev, void *data)
>>>>> +{
>>>>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>>>>> +	int ret;
>>>>> +
>>>>> +	if (!slave->probed) {
>>>>> +		dev_dbg(dev, "skipping device, no probed driver\n");
>>>>> +		return 0;
>>>>> +	}
>>>>> +	if (!slave->dev_num_sticky) {
>>>>> +		dev_dbg(dev, "skipping device, never detected on bus\n");
>>>>> +		return 0;
>>>>> +	}
>>>>> +	if (!pm_runtime_suspended(dev))
>>>>> +		return 0;
>>>>> +	ret = pm_request_resume(dev);
>>>> I still don't get why the test above was needed. It's racy and brings
>>>> limited benefits.
>>> As explained below thread,
>>>
>>> https://lore.kernel.org/lkml/acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com
>>>
>>> Our scenario is multiple peripheral devices are connected
>>> over the same link.
>>>
>>> In our implementation, device_for_each_child() function invokes
>>> amd_resume_child_device callback for each child.
>>> When any one of the child device is active, It will break the
>>> iteration, which results in failure resuming all child devices.
>> Can you clarify the 'it will break the iteration' statement?
>>
>> Are you saying pm_request_resume() will return a negative error code if
>> the device is already active?
>>
>> We've used an unconditional pm_request_resume() in the Intel code for
>> quite some time, including with multiple amplifiers per link, and have
>> never observed the issue you report, so I'd like to get to the root
>> cause pretty please. You took the Intel code and added a test for AMD
>> platforms, and I'd really like to understand if the Intel code was wrong
>> in the first place, or if the test is not needed. Something does not add
>> up here.
> AMP Codec (In aggregate mode) + Jack Codec connected over the same
> link on our platform.
> Consider below, scenario.
> Active stream is running on AMP codec and Jack codec is already in runtime
> suspend state.
> If system level suspend is invoked, in prepare callback, we need to resume
> both the codec devices.
> 
> device_for_each_child() will invoke amd_resume_child_device() function callback
> for each device which will try to resume the child device in this case.
> By definition, device_for_each_child() Iterate over @parent's child devices,
> and invokes the callback for each. We check the return of amd_resume_child_device()
> each time.
> If it returns anything other than 0, we break out and return that value.
> 
> In current scenario, As AMP codec is not in runtime suspend state,
> pm_request_resume() will return a value as 1. This will break the
> sequence for resuming rest of the child devices(JACK codec in our case).

Well, yes, now that makes sense, thanks for the details.

I think the reason why we didn't see the problem with the Intel code is
that both amplifiers are on the same dailink, so they are by
construction either both suspended or both active. We never had
different types of devices on the same link.

I would however suggest this simpler alternative, where only negative
return values are returned:

ret = pm_request_resume(dev);
if (ret < 0) {
	dev_err(dev, "pm_request_resume failed: %d\n", ret);
        return ret;
}
return 0;

this would work just fine, no?


> 
> As mentioned in an earlier thread, there are two possible solutions.
> 1. check pm runtime suspend state and return 0 if it is not suspended
> 2. simply always return 0 for amd_resume_child_device() function callback.
> 
> We opted first one as solution.

My suggestion looks like your option 2. It's cleaner IMHO.
