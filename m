Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA129671C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjARMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjARMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:38:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812995150
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:03:27 -0800 (PST)
Received: from [192.168.1.103] (unknown [103.86.18.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C1041643;
        Wed, 18 Jan 2023 13:03:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674043405;
        bh=xqoJmXp5A5UYs1VELsFCrw1lWZU25O95+ePMttd4PgE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PFu4ZXH4gPCDe/Sv+3RSItX65lYMxGDtBablkp23ea7UehaPwm/5ctdxaeK+vGFhF
         gcioVolgttKuKxk0Rt5nRHcDW/Wl3g9OhO0f7p+hOfXXl1PzHufsC4o+cou+VUXU1R
         w099fwomZcrel2aYlVhPf+Bwx604rJMermkshLNk=
Message-ID: <d4e9fd51-6d22-d304-3eb0-e76c15dcb1da@ideasonboard.com>
Date:   Wed, 18 Jan 2023 17:33:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] staging: vchiq_arm: fix enum vchiq_status return types
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Adrien Thierry <athierry@redhat.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230117163957.1109872-1-arnd@kernel.org>
 <3a69e1fc-c266-d75c-32e3-9b5f655a8258@i2se.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <3a69e1fc-c266-d75c-32e3-9b5f655a8258@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/23 5:08 PM, Stefan Wahren wrote:
> Hi Arnd,
>
> Am 17.01.23 um 17:39 schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> gcc-13 notices a type mismatch between function declaration
>> and definition for a few functions that have been converted
>> from returning vchiq specific status values to regular error
>> codes:
>>
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:662:5: 
>> error: conflicting types for 'vchiq_initialise' due to enum/integer 
>> mismatch; have 'int(struct vchiq_instance **)' 
>> [-Werror=enum-int-mismatch]
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1411:1: 
>> error: conflicting types for 'vchiq_use_internal' due to enum/integer 
>> mismatch; have 'int(struct vchiq_state *, struct vchiq_service *, 
>> enum USE_TYPE_E)' [-Werror=enum-int-mismatch]
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1468:1: 
>> error: conflicting types for 'vchiq_release_internal' due to 
>> enum/integer mismatch; have 'int(struct vchiq_state *, struct 
>> vchiq_service *)' [-Werror=enum-int-mismatch]
>>
>> Change the declarations to match the actual function definition.
>>
>> Fixes: a9fbd828be7f ("staging: vchiq_arm: drop enum vchiq_status from 
>> vchiq_*_internal")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> thanks for fixing this.
>
> Greg applied a series [1] from Umang which completely removes this 
> enum completely. This series has been applied to today and will likely 
> cause a conflict tomorrow in linux-next.

Yes, the series was applied today.

Has this patch (By Arnd) already applied to linux-next? I am not sure if 
I understand where the conflict will get originated ..

>
> [1] - 
> https://lore.kernel.org/linux-arm-kernel/ba52e6b4-33ec-622e-00b6-1b098f529a90@ideasonboard.com/T/
>
>> ---
>>   .../staging/vc04_services/include/linux/raspberrypi/vchiq.h | 2 +-
>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git 
>> a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h 
>> b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
>> index db1441c0cc66..690ab7165b2c 100644
>> --- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
>> +++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
>> @@ -86,7 +86,7 @@ struct vchiq_service_params_kernel {
>>     struct vchiq_instance;
>>   -extern enum vchiq_status vchiq_initialise(struct vchiq_instance 
>> **pinstance);
>> +extern int vchiq_initialise(struct vchiq_instance **pinstance);
>>   extern enum vchiq_status vchiq_shutdown(struct vchiq_instance 
>> *instance);
>>   extern enum vchiq_status vchiq_connect(struct vchiq_instance 
>> *instance);
>>   extern enum vchiq_status vchiq_open_service(struct vchiq_instance 
>> *instance,
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
>> index 2851ef6b9cd0..cd20eb18f275 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
>> @@ -100,10 +100,10 @@ vchiq_dump_platform_use_state(struct 
>> vchiq_state *state);
>>   extern void
>>   vchiq_dump_service_use_state(struct vchiq_state *state);
>>   -extern enum vchiq_status
>> +extern int
>>   vchiq_use_internal(struct vchiq_state *state, struct vchiq_service 
>> *service,
>>              enum USE_TYPE_E use_type);
>> -extern enum vchiq_status
>> +extern int
>>   vchiq_release_internal(struct vchiq_state *state,
>>                  struct vchiq_service *service);

