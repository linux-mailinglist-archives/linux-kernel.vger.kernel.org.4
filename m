Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C452697D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBONkQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 08:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBONkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:40:10 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E082E0E3;
        Wed, 15 Feb 2023 05:40:06 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 03D0C18642E4;
        Wed, 15 Feb 2023 16:40:03 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XGOBKfcppwyV; Wed, 15 Feb 2023 16:40:02 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id A445B18642DC;
        Wed, 15 Feb 2023 16:40:02 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eBofTCWdSboM; Wed, 15 Feb 2023 16:40:02 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 238531864059;
        Wed, 15 Feb 2023 16:40:02 +0300 (MSK)
Message-ID: <39993564-7310-a2e0-8139-14ccb9a03ba9@astralinux.ru>
Date:   Wed, 15 Feb 2023 16:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH] goku_udc: Add check for NULL in goku_irq
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230203101828.14799-1-abelova@astralinux.ru>
 <Y9zly1vrj9z4c1qT@kroah.com>
From:   =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCR0LXQu9C+0LLQsA==?= 
        <abelova@astralinux.ru>
In-Reply-To: <Y9zly1vrj9z4c1qT@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


03.02.2023 13:45, Greg Kroah-Hartman пишет:
> On Fri, Feb 03, 2023 at 01:18:28PM +0300, Anastasia Belova wrote:
>> Before dereferencing dev->driver check it for NULL.
>>
>> If an interrupt handler is called after assigning
>> NULL to dev->driver, but before resetting dev->int_enable,
>> NULL-pointer will be dereferenced.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> ---
>>   drivers/usb/gadget/udc/goku_udc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
>> index bdc56b24b5c9..896bba8b47f1 100644
>> --- a/drivers/usb/gadget/udc/goku_udc.c
>> +++ b/drivers/usb/gadget/udc/goku_udc.c
>> @@ -1616,8 +1616,9 @@ static irqreturn_t goku_irq(int irq, void *_dev)
>>   pm_next:
>>   		if (stat & INT_USBRESET) {		/* hub reset done */
>>   			ACK(INT_USBRESET);
>> -			INFO(dev, "USB reset done, gadget %s\n",
>> -				dev->driver->driver.name);
>> +			if (dev->driver)
>> +				INFO(dev, "USB reset done, gadget %s\n",
>> +					dev->driver->driver.name);
> How can this ever happen?  Can you trigger this somehow?  If not, I
> don't think this is going to be possible (also what's up with printk
> from an irq handler???)

Unfortunately, I can't find the way to trigger this at the moment.

What about printk, should trace_printk be used instead?

>
> Odds are, no one actually has this hardware anymore, right?

Despite of this, such vulnerability should be fixed because

there is a possibility to exploit it.

> thanks,
>
> greg k-h

Best regards,

Anastasia Belova

