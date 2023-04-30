Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896EB6F27ED
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjD3HRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 03:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjD3HRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 03:17:09 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E110DC;
        Sun, 30 Apr 2023 00:17:07 -0700 (PDT)
Message-ID: <bc9bcf4f-5075-8a60-e554-593df22d4a52@gentoo.org>
Date:   Sun, 30 Apr 2023 09:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Matthias Schwarzott <zzam@gentoo.org>
Subject: Re: [PATCH] media: ov5693: Simplify an error message
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
References: <928f2f70de241d0fa66801b46d736ad0f881eb72.1681576102.git.christophe.jaillet@wanadoo.fr>
 <b4aea4b5-d86a-1604-c646-346ea7b59476@gentoo.org>
 <c140045b-967f-df56-22b7-8df11da97884@wanadoo.fr>
Content-Language: en-GB
In-Reply-To: <c140045b-967f-df56-22b7-8df11da97884@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.23 um 17:50 schrieb Christophe JAILLET:
> Le 21/04/2023 à 09:38, Matthias Schwarzott a écrit :
>> Am 15.04.23 um 18:28 schrieb Christophe JAILLET:
>>> dev_err_probe() already display the error code. There is no need to
>>> duplicate it explicitly in the error message.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>>   drivers/media/i2c/ov5693.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
>>> index e3c3bed69ad6..d23786afd754 100644
>>> --- a/drivers/media/i2c/ov5693.c
>>> +++ b/drivers/media/i2c/ov5693.c
>>> @@ -404,8 +404,8 @@ static int ov5693_read_reg(struct ov5693_device 
>>> *ov5693, u32 addr, u32 *value)
>>>       ret = i2c_transfer(client->adapter, msg, 2);
>>>       if (ret < 0)
>>
>> i2c_transfer returns the number of transmitted messages. So I think 
>> the values 0 <= ret < 2 also need to be handled.
> 
> Ok, agreed.
> 
> If ok for you, I'll send a follow-up patch when/if this one is applied,
> because what you spotted is unrelated to the dev_err_probe() behavior.
> 
Sure, fine for me.
> CJ
>>
>>>           return dev_err_probe(&client->dev, ret,
>>> -                     "Failed to read register 0x%04x: %d\n",
>>> -                     addr & OV5693_REG_ADDR_MASK, ret);
>>> +                     "Failed to read register 0x%04x\n",
>>> +                     addr & OV5693_REG_ADDR_MASK);
>>>       *value = 0;
>>>       for (i = 0; i < len; ++i) {
>>
>>
> 

