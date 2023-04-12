Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248006DF03D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDLJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDLJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:24:51 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FE61B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:24:47 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 322025FD61;
        Wed, 12 Apr 2023 12:24:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681291485;
        bh=Tghv5UH8zv7I4pRNO5QISMHmKjV0z5XxnvqtmlhyC0I=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=sRo4D8wMqr26oBvkPBtliboyQR2sbiUMF5De1jscGX3zCgevX41L8qQc05dZNqzZv
         sDAA2csxJldkJrWlXePNFQk0izMjf9bF9FINlXbWLCNyt1+mE9KzZ4Hm/l8jZUfcbF
         kx8+02TQmnhDqDRbPtg4aAQZgfB6nEhlpbeIxJoEJOgHjF3Tp4erfwqAPjq5MBfSBZ
         kEQBx+QmiFn1pMHmdaM7CUC0Gm/83q5+wRpiKciZoni+UTkMY5RA4+CCu9vSCIqj8r
         RMdjQxhObGTyVq9uUEO0c/kXLDpn7jyRpAM/E8nKUf6JT9FQqXu1qacRO0N2wXY2uG
         xuKXcOshcfohQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 12 Apr 2023 12:24:43 +0300 (MSK)
Message-ID: <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
Date:   Wed, 12 Apr 2023 12:20:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
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
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230412094400.3c82f631@xps-13>
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



On 12.04.2023 10:44, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
> 
>> This NAND reads only few user's bytes in ECC mode (not full OOB), so
> 
> "This NAND reads" does not look right, do you mean "Subpage reads do
> not retrieve all the OOB bytes,"?
> 
>> fill OOB buffer with zeroes to not return garbage from previous reads
>> to user.
>> Otherwise 'nanddump' utility prints something like this for just erased
>> page:
>>
>> ...
>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>   OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
>>   OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
>>   OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
>>   OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index f84a10238e4d..f2f2472cb511 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>  static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>  				   int oob_required, int page)
>>  {
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>  	u8 *oob_buf = nand->oob_poi;
>>  	int ret;
>>  
>> +	memset(oob_buf, 0, mtd->oobsize);
> 
> I'm surprised raw reads do not read the entire OOB?

Yes! Seems in case of raw access (what i see in this driver) number of OOB bytes read
still depends on ECC parameters: for each portion of data covered with ECC code we can
read it's ECC code and "user bytes" from OOB - it is what i see by dumping DMA buffer by
printk(). For example I'm working with 2K NAND pages, each page has 2 x 1K ECC blocks.
For each ECC block I have 16 OOB bytes which I can access by read/write. Each 16 bytes
contains 2 bytes of user's data and 14 bytes ECC codes. So when I read page in raw mode
controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is reported as 64 bytes.

Thanks, Arseniy

> 
>> +
>>  	ret = meson_nfc_read_page_sub(nand, page, 1);
>>  	if (ret)
>>  		return ret;
>> @@ -881,6 +884,8 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>  	u8 *oob_buf = nand->oob_poi;
>>  	int ret, i;
>>  
>> +	memset(oob_buf, 0, mtd->oobsize);
>> +
>>  	ret = meson_nfc_read_page_sub(nand, page, 0);
>>  	if (ret)
>>  		return ret;
> 
> 
> Thanks,
> Miquèl
