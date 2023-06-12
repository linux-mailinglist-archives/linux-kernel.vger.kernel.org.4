Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAD72C8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbjFLOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbjFLOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:48:49 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9868EBD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:48:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxGupHMIdkL94DAA--.8422S3;
        Mon, 12 Jun 2023 22:48:39 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC8pGMIdkC3IWAA--.55549S3;
        Mon, 12 Jun 2023 22:48:38 +0800 (CST)
Message-ID: <3ca51fbe-391c-7428-4cf0-20a20ab294d9@loongson.cn>
Date:   Mon, 12 Jun 2023 22:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Add error reporting code for the display
 core
Content-Language: en-US
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>,
        "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>,
        "Tam, Samson" <Samson.Tam@amd.com>,
        "Varone, Dillon" <Dillon.Varone@amd.com>,
        "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230611152351.24569-1-suijingfeng@loongson.cn>
 <BL1PR12MB5144EE0E3EB0D30F27D5F824F754A@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <BL1PR12MB5144EE0E3EB0D30F27D5F824F754A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxC8pGMIdkC3IWAA--.55549S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF1kAr13Ww15Cw48JF48Xwc_yoW7JFyUpr
        4fGF4Y9rWUZw1aqry3JFyjvF4ay3WfKF4FyrWUGw1Sv3sFyr1fJF48Kr43u3y3uFsrWw1I
        qFWjgF4xuF12krXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EPfPUUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/12 22:41, Deucher, Alexander wrote:
> [Public]
>
>> -----Original Message-----
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>> Sent: Sunday, June 11, 2023 11:24 AM
>> To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
>> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
>> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lee, Alvin
>> <Alvin.Lee2@amd.com>; Lei, Jun <Jun.Lei@amd.com>; Zhuo, Qingqing (Lillian)
>> <Qingqing.Zhuo@amd.com>; Liu, Wenjing <Wenjing.Liu@amd.com>; Tam,
>> Samson <Samson.Tam@amd.com>; Varone, Dillon
>> <Dillon.Varone@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v2] drm/amdgpu: Add error reporting code for the display
>> core
>>
>> [why]
>>
>> Because the drm/amdgpu drivers do not work with Navi 10 [RX 5700] series
>> GPUs on non-x86 platforms, this patch helps find out where the drivers fail.
>> After applying his patch, the following error message can be found:
>>
>> [drm:dc_create [amdgpu]] *ERROR* dc_construct: failed to create resource
>> pool [drm:dc_create [amdgpu]] *ERROR* dc_create: dc construct failed [drm]
>> Display Core failed to initialize with v3.2.230!
> Curious what the failure was on your platform.  Resource create is mostly just allocating structures.
This is because the DRM_AMD_DC_FP configuration does not get selected on 
my hardware platform.
>
> Alex
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 29 ++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 52564b93f7eb..d33b78aa3e58 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -951,7 +951,7 @@ static bool dc_construct(struct dc *dc,
>>                goto fail;
>>        }
>>
>> -        dc_ctx = dc->ctx;
>> +     dc_ctx = dc->ctx;
>>
>>        /* Resource should construct all asic specific resources.
>>         * This should be the only place where we need to parse the asic id
>> @@ -990,16 +990,21 @@ static bool dc_construct(struct dc *dc,
>>        }
>>
>>        dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx-
>>> dce_version);
>> -     if (!dc->res_pool)
>> +     if (!dc->res_pool) {
>> +             dm_error("%s: failed to create resource pool\n", __func__);
>>                goto fail;
>> +     }
>>
>>        /* set i2c speed if not done by the respective dcnxxx__resource.c */
>>        if (dc->caps.i2c_speed_in_khz_hdcp == 0)
>>                dc->caps.i2c_speed_in_khz_hdcp = dc-
>>> caps.i2c_speed_in_khz;
>>        dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc-
>>> res_pool->dccg);
>> -     if (!dc->clk_mgr)
>> +     if (!dc->clk_mgr) {
>> +             dm_error("%s: failed to create clk manager\n", __func__);
>>                goto fail;
>> +     }
>> +
>>   #ifdef CONFIG_DRM_AMD_DC_FP
>>        dc->clk_mgr->force_smu_not_present = init_params-
>>> force_smu_not_present;
>> @@ -1022,14 +1027,18 @@ static bool dc_construct(struct dc *dc,
>>                goto fail;
>>        }
>>
>> -     if (!create_links(dc, init_params->num_virtual_links))
>> +     if (!create_links(dc, init_params->num_virtual_links)) {
>> +             dm_error("%s: failed to create links\n", __func__);
>>                goto fail;
>> +     }
>>
>>        /* Create additional DIG link encoder objects if fewer than the
>> platform
>>         * supports were created during link construction.
>>         */
>> -     if (!create_link_encoders(dc))
>> +     if (!create_link_encoders(dc)) {
>> +             dm_error("%s: failed to create link encoders\n", __func__);
>>                goto fail;
>> +     }
>>
>>        dc_resource_state_construct(dc, dc->current_state);
>>
>> @@ -1314,11 +1323,15 @@ struct dc *dc_create(const struct dc_init_data
>> *init_params)
>>                return NULL;
>>
>>        if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
>> -             if (!dc_construct_ctx(dc, init_params))
>> +             if (!dc_construct_ctx(dc, init_params)) {
>> +                     DC_LOG_ERROR("%s: dc construct failed\n",
>> __func__);
>>                        goto destruct_dc;
>> +             }
>>        } else {
>> -             if (!dc_construct(dc, init_params))
>> +             if (!dc_construct(dc, init_params)) {
>> +                     DC_LOG_ERROR("%s: dc construct failed\n",
>> __func__);
>>                        goto destruct_dc;
>> +             }
>>
>>                full_pipe_count = dc->res_pool->pipe_count;
>>                if (dc->res_pool->underlay_pipe_index !=
>> NO_UNDERLAY_PIPE) @@ -1349,8 +1362,6 @@ struct dc *dc_create(const
>> struct dc_init_data *init_params)
>>
>>        DC_LOG_DC("Display Core initialized\n");
>>
>> -
>> -
>>        return dc;
>>
>>   destruct_dc:
>> --
>> 2.25.1

-- 
Jingfeng

