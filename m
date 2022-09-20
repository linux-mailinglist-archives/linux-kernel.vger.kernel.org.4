Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88D5BE0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiITIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiITIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:52:44 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2569362A8C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:52:42 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28K8V8cB023314;
        Tue, 20 Sep 2022 16:31:08 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Sep
 2022 16:51:55 +0800
Message-ID: <eaff5c3e-23a8-1a5e-efe8-27828faa19fd@aspeedtech.com>
Date:   Tue, 20 Sep 2022 16:51:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/ast: Fix video broken in some resolutions on ast2600
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220916091706.4559-1-jammy_huang@aspeedtech.com>
 <2d62d61d-b000-9918-2cd4-b7fb3d1196d2@suse.de>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <2d62d61d-b000-9918-2cd4-b7fb3d1196d2@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28K8V8cB023314
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2022/9/20 下午 04:43, Thomas Zimmermann wrote:
> Hi
>
> Am 16.09.22 um 11:17 schrieb Jammy Huang:
>> Some cases are not handled well for ast2600.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/gpu/drm/ast/ast_mode.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_mode.c 
>> b/drivers/gpu/drm/ast/ast_mode.c
>> index d327dcbaf032..be9bbc888ac3 100644
>> --- a/drivers/gpu/drm/ast/ast_mode.c
>> +++ b/drivers/gpu/drm/ast/ast_mode.c
>> @@ -314,7 +314,7 @@ static void ast_set_crtc_reg(struct ast_private 
>> *ast,
>>       u8 jreg05 = 0, jreg07 = 0, jreg09 = 0, jregAC = 0, jregAD = 0, 
>> jregAE = 0;
>>       u16 temp, precache = 0;
>>   -    if ((ast->chip == AST2500) &&
>> +    if ((ast->chip == AST2500 || ast->chip == AST2600) &&
>>           (vbios_mode->enh_table->flags & AST2500PreCatchCRT))
>>           precache = 40;
>>   @@ -355,6 +355,12 @@ static void ast_set_crtc_reg(struct 
>> ast_private *ast,
>>       ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xAC, 0x00, jregAC);
>>       ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xAD, 0x00, jregAD);
>>   +    // Workaround for HSync Time non octave pixels (1920x1080@60Hz 
>> HSync 44 pixels);
>
> Applied to drm-misc-next, but what is an 'octave pixel'?

It means to make the pixel number a multiple of 8.


>
> Best regards
> Thomas
>
>> +    if ((ast->chip == AST2600) && (mode->crtc_vdisplay == 1080))
>> +        ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xFC, 0xFD, 
>> 0x02);
>> +    else
>> +        ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xFC, 0xFD, 
>> 0x00);
>> +
>>       /* vert timings */
>>       temp = (mode->crtc_vtotal) - 2;
>>       if (temp & 0x100)
>> @@ -432,7 +438,7 @@ static void ast_set_dclk_reg(struct ast_private 
>> *ast,
>>   {
>>       const struct ast_vbios_dclk_info *clk_info;
>>   -    if (ast->chip == AST2500)
>> +    if ((ast->chip == AST2500) || (ast->chip == AST2600))
>>           clk_info = 
>> &dclk_table_ast2500[vbios_mode->enh_table->dclk_index];
>>       else
>>           clk_info = &dclk_table[vbios_mode->enh_table->dclk_index];
>
-- 
Best Regards
Jammy

