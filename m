Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826FC64982D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 04:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiLLDR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 22:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLLDRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 22:17:24 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B9F6336
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 19:17:20 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2BC386UZ086585;
        Mon, 12 Dec 2022 11:08:06 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Dec
 2022 11:16:46 +0800
Message-ID: <e769bddc-5e62-4325-9f56-b9850eb393ad@aspeedtech.com>
Date:   Mon, 12 Dec 2022 11:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/ast: Fix no display at WayLand after power-off
To:     Thomas Zimmermann <tzimmermann@suse.de>, <airlied@redhat.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221209091143.6290-1-jammy_huang@aspeedtech.com>
 <180babce-37e3-01b4-8f1a-03a82771bc8c@suse.de>
Content-Language: en-US
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <180babce-37e3-01b4-8f1a-03a82771bc8c@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2BC386UZ086585
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


OK. Thanks for the reminder.


On 2022/12/9 下午 05:45, Thomas Zimmermann wrote:
> Hi
>
> Am 09.12.22 um 10:11 schrieb Jammy Huang:
>> With WayLand, there is error log when display waken up from power-off:
>> gnome-shell: Failed to post KMS update: CRTC property (GAMMA_LUT) not 
>> found
>> gnome-shell: Page flip discarded: CRTC property (GAMMA_LUT) not found
>>
>> To fix the issue, enable GAMMA_LUT property on CRTC.
>
> This code has long been replaced by commit ce7fcf700386 ("drm/ast: Add 
> Atomic gamma lut support for aspeed"), which adds proper color 
> management to ast.
>
> Please only submit patches for the latest driver in drm-misc-next.
>
> Best regards
> Thomas
>
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/gpu/drm/ast/ast_drv.h  | 2 ++
>>   drivers/gpu/drm/ast/ast_mode.c | 5 +++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_drv.h 
>> b/drivers/gpu/drm/ast/ast_drv.h
>> index 2e44b971c3a6..fd9af1cf0563 100644
>> --- a/drivers/gpu/drm/ast/ast_drv.h
>> +++ b/drivers/gpu/drm/ast/ast_drv.h
>> @@ -86,6 +86,8 @@ enum ast_tx_chip {
>>   #define AST_DRAM_4Gx16   7
>>   #define AST_DRAM_8Gx16   8
>>   +#define MAX_COLOR_LUT_ENTRIES 256
>> +
>>   /*
>>    * Cursor plane
>>    */
>> diff --git a/drivers/gpu/drm/ast/ast_mode.c 
>> b/drivers/gpu/drm/ast/ast_mode.c
>> index 1bc0220e6783..87bd9697bb44 100644
>> --- a/drivers/gpu/drm/ast/ast_mode.c
>> +++ b/drivers/gpu/drm/ast/ast_mode.c
>> @@ -74,7 +74,7 @@ static void ast_crtc_load_lut(struct ast_private 
>> *ast, struct drm_crtc *crtc)
>>       g = r + crtc->gamma_size;
>>       b = g + crtc->gamma_size;
>>   -    for (i = 0; i < 256; i++)
>> +    for (i = 0; i < MAX_COLOR_LUT_ENTRIES; i++)
>>           ast_load_palette_index(ast, i, *r++ >> 8, *g++ >> 8, *b++ 
>> >> 8);
>>   }
>>   @@ -1323,7 +1323,8 @@ static int ast_crtc_init(struct drm_device *dev)
>>       if (ret)
>>           return ret;
>>   -    drm_mode_crtc_set_gamma_size(crtc, 256);
>> +    drm_crtc_enable_color_mgmt(crtc, 0, false, MAX_COLOR_LUT_ENTRIES);
>> +    drm_mode_crtc_set_gamma_size(crtc, MAX_COLOR_LUT_ENTRIES);
>>       drm_crtc_helper_add(crtc, &ast_crtc_helper_funcs);
>>         return 0;
>>
>> base-commit: 8ed710da2873c2aeb3bb805864a699affaf1d03b
>
-- 
Best Regards
Jammy

