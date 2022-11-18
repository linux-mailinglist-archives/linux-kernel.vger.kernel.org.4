Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378D762F119
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiKRJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKRJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:24:57 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4113D28
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:24:55 -0800 (PST)
X-UUID: 65a0b4b390194fa38cb937c4cbeeb3a9-20221118
X-CPASD-INFO: a30bbf889eb14895b776f333e9c9069e@qoNqgo-YZmhlhaR9g3uEb4JoZ2aWX1O
        Cp3ODaV5mZYWVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3sHVqgpKUaA==
X-CLOUD-ID: a30bbf889eb14895b776f333e9c9069e
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:181.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:192.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:7,DUF:8753,ACD:145,DCD:145,SL:0,EISP:0,AG:0,CFC:0.75,CFSR:0.034,UAT:0,R
        AF:2,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,
        EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 65a0b4b390194fa38cb937c4cbeeb3a9-20221118
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 65a0b4b390194fa38cb937c4cbeeb3a9-20221118
X-User: lizhenneng@kylinos.cn
Received: from [172.20.124.41] [(116.128.244.169)] by mailgw
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1399027987; Fri, 18 Nov 2022 17:25:13 +0800
Message-ID: <4adc40d1-e775-c480-bb35-23fe9c63e05e@kylinos.cn>
Date:   Fri, 18 Nov 2022 17:24:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add mb for si
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20221118074810.380368-1-lizhenneng@kylinos.cn>
 <ecd9d251-8941-b2db-71b2-e4ac06f860a3@amd.com>
 <800a1207-8ff6-4cfa-60f3-6ff456874890@mailbox.org>
From:   =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
In-Reply-To: <800a1207-8ff6-4cfa-60f3-6ff456874890@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/18 17:18, Michel Dänzer 写道:
> On 11/18/22 09:01, Christian König wrote:
>> Am 18.11.22 um 08:48 schrieb Zhenneng Li:
>>> During reboot test on arm64 platform, it may failure on boot,
>>> so add this mb in smc.
>>>
>>> The error message are as follows:
>>> [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR*
>>>                  late_init of IP block <si_dpm> failed -22
>>> [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_init failed
>>> [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU init
>> Memory barries are not supposed to be sprinkled around like this, you need to give a detailed explanation why this is necessary.
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
>>> ---
>>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
>>> index 8f994ffa9cd1..c7656f22278d 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
>>> @@ -155,6 +155,8 @@ bool amdgpu_si_is_smc_running(struct amdgpu_device *adev)
>>>        u32 rst = RREG32_SMC(SMC_SYSCON_RESET_CNTL);
>>>        u32 clk = RREG32_SMC(SMC_SYSCON_CLOCK_CNTL_0);
>>>    +    mb();
>>> +
>>>        if (!(rst & RST_REG) && !(clk & CK_DISABLE))
>>>            return true;
> In particular, it makes no sense in this specific place, since it cannot directly affect the values of rst & clk.

I thinks so too.

But when I do reboot test using nine desktop machines,  there maybe 
report this error on one or two machines after Hundreds of times or 
Thousands of times reboot test, at the beginning, I use msleep() instead 
of mb(), these two methods are all works, but I don't know what is the 
root case.

I use this method on other verdor's oland card, this error message are 
reported again.

What could be the root reason?

test environmen:

graphics card: OLAND 0x1002:0x6611 0x1642:0x1869 0x87

driver: amdgpu

os: ubuntu 2004

platform: arm64

kernel: 5.4.18

>

