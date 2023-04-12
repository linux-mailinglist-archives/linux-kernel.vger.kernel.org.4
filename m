Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817546DF43B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDLLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjDLLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:51:27 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48262769A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:51:25 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 752E55FD67;
        Wed, 12 Apr 2023 14:51:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681300283;
        bh=Icigs/+dNEkOIVVLZCgcX2mmuvfiMc9wUaxUOYoE5Bk=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=CRvTKduR13lI73ljFO6tctKOrbx+BMK1Pjxcqcx96s6IioL0j2CxCnI1qQiZShF+f
         PJbp2LksX9x6Y4lAtscWbhth0Mv1hE3oUYos7cDp56UBixGZMFwp6v6x1592YVN8QU
         a86/N9aENk4o4ikzO5aca0I/51BGZl5i+XY1nMBpFyLCaqaEHSdrKWWCDSlItt5ctM
         kbpShStoWWpmXf0COOopQ1KeGSEH+iBLg2LOCkkF2TDkD7/bhkvpWwGhzBYLoWefEj
         tDwD6IAbel8BOy0f6+g5dPmMv4vlghoZnzRvU795hDQcyGGK/8oGSPa2eNoF2EDXlJ
         tp5aHaIxhEE2A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 12 Apr 2023 14:51:23 +0300 (MSK)
Message-ID: <db1d3904-0da1-bfad-6bb6-da78999dcf01@sberdevices.ru>
Date:   Wed, 12 Apr 2023 14:47:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
 <20230412094400.3c82f631@xps-13>
 <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
 <20230412113654.183350d0@xps-13>
 <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
 <4baac18b-c223-d346-503c-f5f9ae49320d@amlogic.com>
 <fe03919a-3468-b79e-5971-1f7671684ee9@amlogic.com>
 <20230412114326.fn3nm5r3rzlnqgg7@CAB-WSD-L081021>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230412114326.fn3nm5r3rzlnqgg7@CAB-WSD-L081021>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/12 04:12:00 #21090163
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 14:43, Dmitry Rokosov wrote:
> Hello Liang,
> 
> On Wed, Apr 12, 2023 at 07:36:30PM +0800, Liang Yang wrote:
>> Hi,
>>
>> On 2023/4/12 18:51, Liang Yang wrote:
>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> @@ -858,9 +858,12 @@ static int
>>>>>>>> meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>   static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>>>>                      int oob_required, int page)
>>>>>>>>   {
>>>>>>>> +    struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>       u8 *oob_buf = nand->oob_poi;
>>>>>>>>       int ret;
>>>>>>>> +    memset(oob_buf, 0, mtd->oobsize);
>>>>>>>
>>>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>>>
>>>>>> Yes! Seems in case of raw access (what i see in this driver)
>>>>>> number of OOB bytes read
>>>>>> still depends on ECC parameters: for each portion of data
>>>>>> covered with ECC code we can
>>>>>> read it's ECC code and "user bytes" from OOB - it is what i
>>>>>> see by dumping DMA buffer by
>>>>>> printk(). For example I'm working with 2K NAND pages, each
>>>>>> page has 2 x 1K ECC blocks.
>>>>>> For each ECC block I have 16 OOB bytes which I can access by
>>>>>> read/write. Each 16 bytes
>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So
>>>>>> when I read page in raw mode
>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB
>>>>>> is reported as 64 bytes.
>>>>>
>>>>> In all modes, when you read OOB, you should get the full OOB. The fact
>>>>> that ECC correction is enabled or disabled does not matter. If the NAND
>>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>>>
>>>>> What happens sometimes, is that some of the bytes are not protected
>>>>> against bitflips, but the policy is to return the full buffer.
>>>>
>>>> Ok, so to clarify case for this NAND controller:
>>>> 1) In both ECC and raw modes i need to return the same raw OOB data
>>>> (e.g. user bytes
>>>>     + ECC codes)?
>>>> 2) If I have access to only 32 bytes of OOB (in case above), I must
>>>> report that size
>>>>     of OOB is only 32 bytes during initialization?
>>>>
>>>> Thanks, Arseniy
>>>
>>> Yes. it should return all the OOB data. i make a mistake on raw read and
>>> there is wrong code in meson_nfc_read_page_raw().
>>>      meson_nfc_get_data_oob(nand, buf, oob_buf);
>>> changed to:
>>>      if (oob_required)
>>>          memcpy(oob_buf, buf + mtd->writesize, mtd->oobsize)
>>
>> Sorry, please ignore this. the previous code is right.
>>
>> the controller changes the layout of one page; the physical layout is 2048
>> main data + 64 oob data. after writing into NAND page, it is stored
>> like this: 1024 main data + 2 user bytes + 14 ECC parity bytes + 1024 main
>> data + 2 user bytes + 14 ECC parity bytes. so that is right we only get 4
>> user bytes and 28 ECC parity bytes, total 32 bytes. that is the behavior of
>> the controller that transferring one ECC page(1KB) brings back only 2 user
>> bytes.

So i perform the following test, using file with the following pattern:
[ 1024 x 0x11 ][ 1024 x 0x22 ][ 16 x 0x33 ][ 16 x 0x44 ][ 16 x 0x55 ][ 16 x 0x66 ]

Total 2112 bytes (2048 data + 64 oob)

I write it using 'nandwrite' tool with flags '--oob' and '--noecc' - e.g. raw mode.
meson_nfc_set_data_oob() places to DMA buffer only parts with 0x11, 0x22, 0x33, 0x44.
After write data bytes will be 0x11 and 0x22, first 32 bytes of OOB will be 0x33 and 0x44.
Parts with 0x55 and 0x66 will be obviously missed.

So it is Amlogic limitation for 32 bytes of OOB (in case of 1K ECC as You mentioned above)?

And there is no way to access to the whole 64 bytes of OOB even in raw mode (and therefore in
ECC mode)?

Thanks, Arseniy

>>
>> because layout is changed by controller, so go back to the function.
>> meson_nfc_get_data_oob(nand, buf, oob_buf) try to get the right user and ecc
>> parity bytes from the right pos. after that, the other oob bytes is not
>> reading from NAND flash.
> 
> I have always been under the impression that NAND OOB layout falls under the
> responsibility of the flash driver. Is this specific to the Amlogic NAND,
> and does it map the flash layout to the internal controller layout?
> For example, different OOB layouts exist between Macronix and ESMT.
> 
> Apologies for any confusion, and thank you in advance for any help in
> clarifying this matter.
> 
