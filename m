Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DB6E8E59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjDTJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjDTJjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:39:06 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9780EC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:37:41 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 33K9Kcq1063608;
        Thu, 20 Apr 2023 17:20:38 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 20 Apr
 2023 17:37:00 +0800
Message-ID: <325512ba-b468-bca0-d3ef-a1c9cf464d62@aspeedtech.com>
Date:   Thu, 20 Apr 2023 17:37:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/ast: Fix ARM compatibility
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, <airlied@redhat.com>
CC:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230420080947.27226-1-jammy_huang@aspeedtech.com>
 <61edb9d3-11f5-42de-633d-6e6253ce021f@suse.de>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <61edb9d3-11f5-42de-633d-6e6253ce021f@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 33K9Kcq1063608
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for help. I will update a new patch per your comments

On 2023/4/20 下午 04:57, Thomas Zimmermann wrote:
> Hi
>
> Am 20.04.23 um 10:09 schrieb Jammy Huang:
>> ARM architecture only has 'memory', so all devices are accessed by
>> MMIO if possible.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   v2 changes:
>>    - Use MMIO after AST2500 which enable MMIO by default.
>> ---
>>   drivers/gpu/drm/ast/ast_main.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_main.c 
>> b/drivers/gpu/drm/ast/ast_main.c
>> index f83ce77127cb..d384e810fa4d 100644
>> --- a/drivers/gpu/drm/ast/ast_main.c
>> +++ b/drivers/gpu/drm/ast/ast_main.c
>> @@ -425,11 +425,12 @@ struct ast_private *ast_device_create(const 
>> struct drm_driver *drv,
>>           return ERR_PTR(-EIO);
>>         /*
>> -     * If we don't have IO space at all, use MMIO now and
>> -     * assume the chip has MMIO enabled by default (rev 0x20
>> -     * and higher).
>> +     * After AST2500, MMIO is enabled by default, and it should be 
>> adapted
>
> By 'adapted', you mean 'adopted'?
>
> Apart from that:
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> I also ran this patch on an AST2100, which still works as before.
>
> Best regards
> Thomas
>
>> +     * to be compatible with Arm.
>>        */
>> -    if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
>> +    if (pdev->revision >= 0x40) {
>> +        ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
>> +    } else if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
>>           drm_info(dev, "platform has no IO space, trying MMIO\n");
>>           ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
>>       }
>>
>> base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
>
-- 
Best Regards
Jammy

