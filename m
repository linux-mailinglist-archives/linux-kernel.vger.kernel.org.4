Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389606E5B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDRH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjDRH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:56:16 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B8448C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:56:09 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 33I7cx4T087017;
        Tue, 18 Apr 2023 15:38:59 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 Apr
 2023 15:55:15 +0800
Message-ID: <cb81a63f-72b5-def7-e2de-f74087b87bfb@aspeedtech.com>
Date:   Tue, 18 Apr 2023 15:55:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/ast: Fix ARM compatibility
To:     Thomas Zimmermann <tzimmermann@suse.de>, <airlied@redhat.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <giantl@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20230302021905.2777-1-jammy_huang@aspeedtech.com>
 <d72b0fd9-844e-a422-45b6-261d73dbad18@aspeedtech.com>
 <24987cff-02e4-aa4a-449f-fd48accf7365@suse.de>
 <c5fb047b-ed55-be1f-56ae-3b21b1d1dd29@aspeedtech.com>
 <45255d15-6149-adbc-6b26-22e9d03634f3@suse.de>
Content-Language: en-US
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <45255d15-6149-adbc-6b26-22e9d03634f3@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 33I7cx4T087017
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for you reminder. The comment you mentioned is added in 2014 for 
AST2400 rev 0x20, which means MMIO is not enable by default before that 
revision. I will send another patch to handle it.


On 2023/4/18 下午 03:24, Thomas Zimmermann wrote:
> Hi
>
> Am 18.04.23 um 03:23 schrieb Jammy Huang:
>> Hi Thomas,
>>
>> The Intel(x86) CPUs have a separate address space for "IO", but the 
>> ARM architecture only has "memory", so all IO devices are accessed as 
>> if they were memory. Which means ARM does not support isolated IO. 
>> Here is a related discussion on ARM's forum.
>>
>> https://community.arm.com/support-forums/f/architectures-and-processors-forum/52046/how-to-read-write-an-i-o-port-in-aarch64 
>>
>>
>> Thus, we want to adapt MMIO only after this patch.
>
> What I mean is that there's a comment that says "assume the chip has 
> MMIO enabled by default (rev 0x20 and higher)". We also support revs 
> before 0x20. What happens to them?
>
> Best regards
> Thomas
>
>>
>> On 2023/4/17 下午 07:51, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 07.04.23 um 04:09 schrieb Jammy Huang:
>>>> Hi Thomas,
>>>>
>>>> Could you help review this patch??
>>>>
>>>> We met some problem on nvidia's ARM platfrom and need this patch to 
>>>> fix it.
>>>>
>>>> On 2023/3/2 上午 10:19, Jammy Huang wrote:
>>>>> ARM architecture only has 'memory', so all devices are accessed by 
>>>>> MMIO.
>>>>>
>>>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>>>> ---
>>>>>   drivers/gpu/drm/ast/ast_main.c | 17 +----------------
>>>>>   1 file changed, 1 insertion(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ast/ast_main.c 
>>>>> b/drivers/gpu/drm/ast/ast_main.c
>>>>> index 794ffd4a29c5..f86d01e9f024 100644
>>>>> --- a/drivers/gpu/drm/ast/ast_main.c
>>>>> +++ b/drivers/gpu/drm/ast/ast_main.c
>>>>> @@ -424,22 +424,7 @@ struct ast_device *ast_device_create(const 
>>>>> struct drm_driver *drv,
>>>>>       if (!ast->regs)
>>>>>           return ERR_PTR(-EIO);
>>>>> -    /*
>>>>> -     * If we don't have IO space at all, use MMIO now and
>>>>> -     * assume the chip has MMIO enabled by default (rev 0x20
>>>>> -     * and higher).
>>>>> -     */
>>>>> -    if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
>>>>> -        drm_info(dev, "platform has no IO space, trying MMIO\n");
>>>>> -        ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
>>>>> -    }
>>>>> -
>>>>> -    /* "map" IO regs if the above hasn't done so already */
>>>>> -    if (!ast->ioregs) {
>>>>> -        ast->ioregs = pcim_iomap(pdev, 2, 0);
>>>
>>> What happens on systems that use this branch?
>>>
>>> Best regards
>>> Thomas
>>>
>>>>> -        if (!ast->ioregs)
>>>>> -            return ERR_PTR(-EIO);
>>>>> -    }
>>>>> +    ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
>>>>>       ast_detect_chip(dev, &need_post);
>>>>>
>>>>> base-commit: 254986e324add8a30d0019c6da59f81adc8b565f
>>>>
>>>
>> -- 
>> Best Regards
>> Jammy
>>
>
-- 
Best Regards
Jammy

