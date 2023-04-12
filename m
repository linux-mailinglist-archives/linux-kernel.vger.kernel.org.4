Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14CA6DF59E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDLMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjDLMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:40:04 -0400
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED88A4A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:39:35 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 12 Apr
 2023 15:39:08 +0300
Received: from [192.168.211.128] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 12 Apr
 2023 15:39:08 +0300
Message-ID: <5d5b0b94-4dd4-2a95-a777-521b65f6f053@fintech.ru>
Date:   Wed, 12 Apr 2023 05:39:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] radeon: avoid double free in ci_dpm_init()
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230403182808.8699-1-n.zhandarovich@fintech.ru>
 <BL1PR12MB51446866BAE5945297315399F79A9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <BL1PR12MB51446866BAE5945297315399F79A9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 14:11, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> Sent: Monday, April 3, 2023 2:28 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
>> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; amd-
>> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
>> kernel@vger.kernel.org; lvc-project@linuxtesting.org
>> Subject: [PATCH] radeon: avoid double free in ci_dpm_init()
>>
>> There are several calls to ci_dpm_fini() in ci_dpm_init() when there occur
>> errors in functions like r600_parse_extended_power_table().
>> This is harmful as it can lead to double free situations: for instance,
>> r600_parse_extended_power_table() will call for
>> r600_free_extended_power_table() as will ci_dpm_fini(), both of which will
>> try to free resources.
>> Other drivers do not call *_dpm_fini functions from their respective
>> *_dpm_init calls - neither should cpm_dpm_init().
>>
>> Fix this by removing extra calls to ci_dpm_fini().
> 
> You can't just drop the calls to fini().  You'll need to properly unwind to avoid leaking memory.
> 
> Alex
>>>
>> Found by Linux Verification Center (linuxtesting.org) with static analysis tool
>> SVACE.
>>
>> Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Natalia Petrova <n.petrova@fintech.ru>
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>>
>> ---
>>  drivers/gpu/drm/radeon/ci_dpm.c | 20 +++++---------------
>>  1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c
>> b/drivers/gpu/drm/radeon/ci_dpm.c index 8ef25ab305ae..7b77d4c93f1d
>> 100644
>> --- a/drivers/gpu/drm/radeon/ci_dpm.c
>> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
>> @@ -5677,28 +5677,20 @@ int ci_dpm_init(struct radeon_device *rdev)
>>  	pi->pcie_lane_powersaving.min = 16;
>>
>>  	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
>> -	if (ret) {
>> -		ci_dpm_fini(rdev);
>> +	if (ret)
>>  		return ret;
>> -	}
>>
>>  	ret = r600_get_platform_caps(rdev);
>> -	if (ret) {
>> -		ci_dpm_fini(rdev);
>> +	if (ret)
>>  		return ret;
>> -	}
>>
>>  	ret = r600_parse_extended_power_table(rdev);
>> -	if (ret) {
>> -		ci_dpm_fini(rdev);
>> +	if (ret)
>>  		return ret;
>> -	}
>>
>>  	ret = ci_parse_power_table(rdev);
>> -	if (ret) {
>> -		ci_dpm_fini(rdev);
>> +	if (ret)
>>  		return ret;
>> -	}
>>
>>  	pi->dll_default_on = false;
>>  	pi->sram_end = SMC_RAM_END;
>> @@ -5749,10 +5741,8 @@ int ci_dpm_init(struct radeon_device *rdev)
>>  		kcalloc(4,
>>  			sizeof(struct
>> radeon_clock_voltage_dependency_entry),
>>  			GFP_KERNEL);
>> -	if (!rdev-
>>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
>> -		ci_dpm_fini(rdev);
>> +	if (!rdev-
>>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
>>  		return -ENOMEM;
>> -	}
>>  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
>>  	rdev-
>>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
>>  	rdev-
>>> pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;


I think you are correct when it comes to ensuring we deal with memory
issues in ci_dpm_init().

However, I could use some direction on how to deal with the problem of
freeing only previously allocated resources. For instance, once
ci_parse_power_table() fails, it is not clear what we should and should
not free.

I wanna point out that in this case I would like to fix both double and
uninitialized free issues as it can also lead to undefined behavior.

Thanks for your patience,
Nikita
