Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4911D64E1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLOTtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLOTtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:49:10 -0500
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE55537F8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:49:08 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 5uE3pbl9p4s3d5uE4pTEzM; Thu, 15 Dec 2022 20:49:07 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 Dec 2022 20:49:07 +0100
X-ME-IP: 86.243.100.34
Message-ID: <24af516c-53db-c4f5-6745-7e3a4a2fdf26@wanadoo.fr>
Date:   Thu, 15 Dec 2022 20:49:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amd/pm: avoid large variable on kernel stack
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@kernel.org
Cc:     Hawking.Zhang@amd.com, Jack.Gui@amd.com, KevinYang.Wang@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, arnd@arndb.de,
        christian.koenig@amd.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, evan.quan@amd.com,
        kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com
References: <20221215163649.386750-1-arnd@kernel.org>
 <bca79bc1-9e7c-b145-0b0b-0ce725d58821@wanadoo.fr>
In-Reply-To: <bca79bc1-9e7c-b145-0b0b-0ce725d58821@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/12/2022 à 20:46, Christophe JAILLET a écrit :
> Le 15/12/2022 à 17:36, Arnd Bergmann a écrit :
>> From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>
>> The activity_monitor_external[] array is too big to fit on the
>> kernel stack, resulting in this warning with clang:
>>
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1438:12: error: stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_power_profile_mode' [-Werror,-Wframe-larger-than]
>>
>> Use dynamic allocation instead. It should also be possible to
>> have single element here instead of the array, but this seems
>> easier.
>>
>> Fixes: 334682ae8151 ("drm/amd/pm: enable workload type change on 
>> smu_v13_0_7")
>> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> ---
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 21 ++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> index c270f94a1b86..7eba854e09ec 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> @@ -1439,7 +1439,7 @@ static int smu_v13_0_7_get_power_limit(struct 
>> smu_context *smu,
>>   static int smu_v13_0_7_get_power_profile_mode(struct smu_context 
>> *smu, char *buf)
>>   {
>> -    DpmActivityMonitorCoeffIntExternal_t 
>> activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
>> +    DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
>>       uint32_t i, j, size = 0;
>>       int16_t workload_type = 0;
>>       int result = 0;
>> @@ -1447,6 +1447,12 @@ static int 
>> smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>>       if (!buf)
>>           return -EINVAL;
>> +    activity_monitor_external = 
>> kcalloc(sizeof(activity_monitor_external),
> 
> Hi,
> 
> Before, 'activity_monitor_external' was not initialized.
> Maybe kcalloc() is enough?

Read kmalloc_array()

> 
> sizeof(*activity_monitor_external)?
>       ~~~~
> 
>> +                        PP_SMC_POWER_PROFILE_COUNT,
>> +                        GFP_KERNEL);
>> +    if (!activity_monitor_external)
>> +        return -ENOMEM;
>> +
>>       size += sysfs_emit_at(buf, size, "                              ");
>>       for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
> 
> Unrelated, but wouldn't it be more straightforward with "< 
> PP_SMC_POWER_PROFILE_COUNT"?
> 
>>           size += sysfs_emit_at(buf, size, "%-14s%s", 
>> amdgpu_pp_profile_name[i],
>> @@ -1459,15 +1465,17 @@ static int 
>> smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>>           workload_type = smu_cmn_to_asic_specific_index(smu,
>>                                      CMN2ASIC_MAPPING_WORKLOAD,
>>                                      i);
>> -        if (workload_type < 0)
>> -            return -EINVAL;
>> +        if (workload_type < 0) {
>> +            result = -EINVAL;
>> +            goto out;
>> +        }
>>           result = smu_cmn_update_table(smu,
>>                         SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
>>                         (void *)(&activity_monitor_external[i]), false);
>>           if (result) {
>>               dev_err(smu->adev->dev, "[%s] Failed to get activity 
>> monitor!", __func__);
>> -            return result;
>> +            goto out;
>>           }
>>       }
>> @@ -1495,7 +1503,10 @@ do 
>> {                                                    \
>>       PRINT_DPM_MONITOR(Fclk_BoosterFreq);
>>   #undef PRINT_DPM_MONITOR
>> -    return size;
>> +    result = size;
>> +out:
>> +    kfree(activity_monitor_external);
>> +    return result;
>>   }
>>   static int smu_v13_0_7_set_power_profile_mode(struct smu_context 
>> *smu, long *input, uint32_t size)
> 
> 
