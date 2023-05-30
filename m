Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA08716247
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjE3Nks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE3Nkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:40:45 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214BBE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:40:42 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 567DC5FD2F;
        Tue, 30 May 2023 16:40:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685454038;
        bh=kfnGf2TnFF3l/TM6PHY5pyKAC4DBRs5GCmPiUL4wufc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=ovSpV1EXdSKCWhRP04go3ZXhIR8SJZxBaE44f5ozw2ltrAt+fFUZJdEP2Ry7D/f5N
         UuigiIhUrYhhkcpiG7+NagJFoer+Z9k+kNYOM43DAz3D472YMpkadz5CPBqjWsSVob
         0kJ5ufbxHMtdMRNWx34GN9nSJThLUuU6RDXvbpddKPanw1uPdmrkdX6JdcHMfRJFHb
         PY8wCzRNSicirI94g7/+xxC/HebfEpXMQmNhw/8lXX8xc3nFN1CCmZu6HSxDO8sOFr
         NPzfeK/F6OWOBrt4s+wr+Mc7T0HchVoQP4w9VWK7VS9kozRxmmbWnEes70d1FQKyKP
         uKHrxcVYgmb3Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 30 May 2023 16:40:36 +0300 (MSK)
Message-ID: <9d3ada22-0176-2113-bff2-27f8a4ad5c23@sberdevices.ru>
Date:   Tue, 30 May 2023 16:35:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] mtd: rawnand: meson: fix command sequence for
 read/write
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        JeromeBrunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru><20230515094440.3552094-2-AVKrasnov@sberdevices.ru><20230522170526.6486755a@xps-13><9013b0e2-c923-43f8-0bd6-979bf0c23ebc@sberdevices.ru><abeadc03-a69c-be1c-3c6a-6ce492a5e4f6@sberdevices.ru><20230526192205.4a69ca79@xps-13><6077c959-f566-d399-d2be-8460eb063415@sberdevices.ru><20230530150556.498c1fae@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230530150556.498c1fae@xps-13>
Content-Type: text/plain;
 charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/30 11:20:00 #21377521
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 16:05, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Tue, 30 May 2023 14:19:08 +0300:
> 
>> On 26.05.2023 20:22, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Wed, 24 May 2023 12:05:47 +0300:
>>>   
>>>> On 23.05.2023 12:12, Arseniy Krasnov wrote:  
>>>>> Hello Miquel, Liang
>>>>>
>>>>> On 22.05.2023 18:05, Miquel Raynal wrote:    
>>>>>> Hi Arseniy,
>>>>>>
>>>>>> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:35 +0300:
>>>>>>    
>>>>>>> This fixes read/write functionality by:
>>>>>>> 1) Changing NFC_CMD_RB_INT bit value.    
>>>>>>
>>>>>> I guess this is a separate fix
>>>>>>    
>>>>>
>>>>> Ok, I'll move it to separate patch
>>>>>     
>>>>>>> 2) Adding extra NAND_CMD_STATUS command on each r/w request.    
>>>>>>
>>>>>> Is this really needed? Looks like you're delaying the next op only. Is
>>>>>> using a delay enough? If yes, then it's probably the wrong approach.    
>>>>
>>>> Hi Miquel, small update, I found some details from @Liang's message in v1 talks from the last month:
>>>>
>>>> *
>>>> After sending NAND_CMD_READ0, address, NAND_CMD_READSTART and read status(NAND_CMD_STATUS = 0x70) commands, it should send
>>>> NAND_CMD_READ0 command for exiting the read status mode from the datasheet from NAND device.  
>>>
>>> That is true.
>>>   
>>>> but previous meson_nfc_queue_rb()
>>>> only checks the Ready/Busy pin and it doesn't send read status(NAND_CMD_STATUS = 0x70) command.
>>>> i think there is something wrong with the Ready/Busy pin(please check the hardware whether this
>>>> Ready/Busy pin is connected with SOC) or the source code. i have the board without Ready/Busy pin and prefer to use the
>>>> nfc command called RB_IO6. it sends NAND_CMD_STATUS command and checks bit6 of the status register of NAND device from the
>>>> data bus and generate IRQ if ready.
>>>> *
>>>>
>>>> I guess, that sequence of commands from this patch is described in datasheet (unfortunately I don't have it and relied on the old driver).
>>>> Yesterday I tried to remove sending of NAND_CMD_STATUS from this patch, but it broke current driver - i had ECC errors, so it looks like
>>>> "shot in the dark" situation, to understand this logic.  
>>>
>>> When an operation on the NAND array happens (eg. read, prog, erase),
>>> you need to wait "some time" before accessing the internal sram or even
>>> the chip which is "busy" until it gets "ready" again. You can probe the
>>> ready/busy pin (that's the hardware way, fast and reliable) or you can
>>> poll a status with NAND_CMD_STATUS. The chips are designed so they can
>>> actually process that command while they are doing time consuming tasks
>>> to update the host. But IIRC every byte read will return the status
>>> until you send READ0 again, which means "I'm done with the status
>>> read" somehow.
>>>
>>> Please see nand_soft_waitrdy() in order to understand how this is
>>> supposed to work. You can even use that helper (which is exported)
>>> instead of open-coding it in your driver. See atmel or sunxi
>>> implementations for instance.
>>>
>>> As using the native RB pin is better, you would need to identify
>>> whether you have one or not at probe time and then either poll the
>>> relevant bit of your controller if there is one, or fallback to the
>>> soft read (which should fallback on exec_op in the end).  
>>
>> Thanks for this information! I'll use 'nand_soft_waitrdy()' at least, because i guess that
>> there is no RB pin on my device.
> 
> Currently there is only support for the physical pin IIRC. This means
> you cannot just drop it. You need to support both.

Yes, i'm not going to drop RB pin support, but as I don't have device to test it(i guess), i'll add
'nand_sort_waitrdy()' anyway.

Thanks, Arseniy

> 
> Thanks,
> Miquèl

УВЕДОМЛЕНИЕ О КОНФИДЕНЦИАЛЬНОСТИ: Это электронное сообщение и любые документы, приложенные к нему, содержат конфиденциальную информацию. Настоящим уведомляем Вас о том, что если это сообщение не предназначено Вам, использование, копирование, распространение информации, содержащейся в настоящем сообщении, а также осуществление любых действий на основе этой информации, строго запрещено. Если Вы получили это сообщение по ошибке, пожалуйста, сообщите об этом отправителю по электронной почте и удалите это сообщение.
CONFIDENTIALITY NOTICE: This email and any files attached to it are confidential. If you are not the intended recipient you are notified that using, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited. If you have received this email in error please notify the sender and delete this email.
