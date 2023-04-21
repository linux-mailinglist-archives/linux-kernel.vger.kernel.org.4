Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551556EAE4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDUPvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDUPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:51:05 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16B2125A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:50:55 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id pt2CpbpyDXlCrpt2DpoK8S; Fri, 21 Apr 2023 17:50:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682092254;
        bh=t1TEmUYnBQfKUk9IiYey2KXGx45GAaChHBRzn6BO3a8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j14T+T1kdzz0//YQVODDpDsTeza50Migo5+JdIpjWJdMyDW2l9NBrX6JSxBgz+3dR
         HVkWeQVDeLYD4jxpM1TS7KGXt1h+13kDyJKAzbV3CTZnMKnLG/zPBCvlFJx1TQ3CPs
         i7eBmzb6pHkL0uu8DLMQfpLggnw7Wfr51HZMcn5zdbMHHp4C5kdeFmYJbl2d6QZvAb
         mtgSAAvb3w4S+Ime0sfS3VfL0bMKNlu5/H0bzJDDRExtKyd22V9DR8/BPWqg0nSGq1
         IroJieFdKwLw3zkklWdUqk8qo/9BPZ7kU7+1v6a44uP1CIjWeOTj3G1JuUt1fRFiy8
         7tqNT17hggl3w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Apr 2023 17:50:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c140045b-967f-df56-22b7-8df11da97884@wanadoo.fr>
Date:   Fri, 21 Apr 2023 17:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] media: ov5693: Simplify an error message
To:     Matthias Schwarzott <zzam@gentoo.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
References: <928f2f70de241d0fa66801b46d736ad0f881eb72.1681576102.git.christophe.jaillet@wanadoo.fr>
 <b4aea4b5-d86a-1604-c646-346ea7b59476@gentoo.org>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b4aea4b5-d86a-1604-c646-346ea7b59476@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/04/2023 à 09:38, Matthias Schwarzott a écrit :
> Am 15.04.23 um 18:28 schrieb Christophe JAILLET:
>> dev_err_probe() already display the error code. There is no need to
>> duplicate it explicitly in the error message.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/media/i2c/ov5693.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
>> index e3c3bed69ad6..d23786afd754 100644
>> --- a/drivers/media/i2c/ov5693.c
>> +++ b/drivers/media/i2c/ov5693.c
>> @@ -404,8 +404,8 @@ static int ov5693_read_reg(struct ov5693_device 
>> *ov5693, u32 addr, u32 *value)
>>       ret = i2c_transfer(client->adapter, msg, 2);
>>       if (ret < 0)
> 
> i2c_transfer returns the number of transmitted messages. So I think the 
> values 0 <= ret < 2 also need to be handled.

Ok, agreed.

If ok for you, I'll send a follow-up patch when/if this one is applied,
because what you spotted is unrelated to the dev_err_probe() behavior.

CJ
> 
>>           return dev_err_probe(&client->dev, ret,
>> -                     "Failed to read register 0x%04x: %d\n",
>> -                     addr & OV5693_REG_ADDR_MASK, ret);
>> +                     "Failed to read register 0x%04x\n",
>> +                     addr & OV5693_REG_ADDR_MASK);
>>       *value = 0;
>>       for (i = 0; i < len; ++i) {
> 
> 

