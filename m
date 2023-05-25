Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3F710262
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjEYBaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEYBaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:30:21 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A210F5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:30:19 -0700 (PDT)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 May
 2023 09:30:16 +0800
Message-ID: <fb6844e9-d045-5ea1-b24c-3509892d248b@aspeedtech.com>
Date:   Thu, 25 May 2023 09:30:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/ast: Fix modeset failed on DisplayPort
To:     Thomas Zimmermann <tzimmermann@suse.de>, <airlied@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20230425070330.8520-1-jammy_huang@aspeedtech.com>
 <d43c0c09-ff6b-e2d1-01ae-68fe93188896@suse.de>
 <d285566b-ed7c-8e2a-a078-7bdd5bac13e3@aspeedtech.com>
 <1e4ca9bc-0e39-2708-8da8-b402139fe7ff@aspeedtech.com>
 <2f516118-2183-400f-7efd-04c2766fa9d6@suse.de>
Content-Language: en-US
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <2f516118-2183-400f-7efd-04c2766fa9d6@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks, I will modify the patch accordingly.

On 2023/5/24 下午 06:47, Thomas Zimmermann wrote:
> Hi,
>
> this patch also fell through the cracks. Apologies.
>
> Am 24.05.23 um 04:29 schrieb Jammy Huang:
>> Hi Thomas,
>>
>> Do you have other suggestion for this patch??
>
> The main issue was that struct ast_private is now called struct 
> ast_device.  So the current patch cannot be applied.
>
>>
>> Please kindly advise.
>>
>> On 2023/4/25 下午 03:39, Jammy Huang wrote:
>>> Hi Thomas,
>>>
>>> I think DP501 is OK. It doesn't use ioregs in ast_dp501_read_edid().
>>>
>>> On 2023/4/25 下午 03:27, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 25.04.23 um 09:03 schrieb Jammy Huang:
>>>>> If we switch display and update cursor together, it could lead to
>>>>> modeset failed because of concurrent access to IO registers.
>>>>>
>>>>> Add lock protection in DP's edid access to avoid this problem.
>>>>
>>>> Thanks for the patch. I thought I fixed this issue already, but 
>>>> that apparently only happened for SIL164 and VGA.
>>>>
>>>> What about ast_dp501_connector_helper_get_modes()? Does it require 
>>>> the locking as well?
>>>>
>>>>>
>>>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>>>> ---
>>>>>   drivers/gpu/drm/ast/ast_mode.c | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ast/ast_mode.c 
>>>>> b/drivers/gpu/drm/ast/ast_mode.c
>>>>> index 984ec590a7e7..fe5f1fd61361 100644
>>>>> --- a/drivers/gpu/drm/ast/ast_mode.c
>>>>> +++ b/drivers/gpu/drm/ast/ast_mode.c
>>>>> @@ -1635,6 +1635,8 @@ static int ast_dp501_output_init(struct 
>>>>> ast_private *ast)
>>>>>   static int ast_astdp_connector_helper_get_modes(struct 
>>>>> drm_connector *connector)
>>>>>   {
>>>>>       void *edid;
>>>>> +    struct drm_device *dev = connector->dev;
>>>>> +    struct ast_private *ast = to_ast_private(dev);
>>>>
>>>> We've meanwhile renamed ast_private to ast_device. Could you please 
>>>> provide an updated patch for the drm-misc-next tree?
>>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>>>         int succ;
>>>>>       int count;
>>>>> @@ -1643,10 +1645,18 @@ static int 
>>>>> ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
>>>>>       if (!edid)
>>>>>           goto err_drm_connector_update_edid_property;
>>>>>   +    /*
>>>>> +     * Protect access to I/O registers from concurrent modesetting
>>>>> +     * by acquiring the I/O-register lock.
>>>>> +     */
>>>>> +    mutex_lock(&ast->ioregs_lock);
>>>>> +
>>>>>       succ = ast_astdp_read_edid(connector->dev, edid);
>>>>>       if (succ < 0)
>>>>>           goto err_kfree;
>>>>>   +    mutex_unlock(&ast->ioregs_lock);
>>>>> +
>>>>>       drm_connector_update_edid_property(connector, edid);
>>>>>       count = drm_add_edid_modes(connector, edid);
>>>>>       kfree(edid);
>>>>> @@ -1654,6 +1664,7 @@ static int 
>>>>> ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
>>>>>       return count;
>>>>>     err_kfree:
>
> Here's a minor issue that the goto label should now be called 
> err_mutex_unlock.
>
> Best regards
> Thomas
>
>>>>> + mutex_unlock(&ast->ioregs_lock);
>>>>>       kfree(edid);
>>>>>   err_drm_connector_update_edid_property:
>>>>>       drm_connector_update_edid_property(connector, NULL);
>>>>>
>>>>> base-commit: 61d325dcbc05d8fef88110d35ef7776f3ac3f68b
>>>>
>
-- 
Best Regards
Jammy

