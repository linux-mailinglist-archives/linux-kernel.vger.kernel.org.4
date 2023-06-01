Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680F471F639
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjFAWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFAWsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:48:50 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F22133
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:48:47 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 31F6C5FD02;
        Fri,  2 Jun 2023 01:48:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685659725;
        bh=VFidQvl3y3zrfaQQyb5A6bOTwv1n+pl8gYzCSMq0tZc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=FS5h0aamVGhHwetjkii0tUR+hbLjg73z7zFfXQlLo/OpJBiu7G/MtEI0/iaSq4JB2
         SQQf9eKnTP+OytF8lMuTnAcLoXhIFl9W9Q+ys+agut3gcLDBRNMHK/7nuwYqiIq8vH
         A9V8JTsry+C99zNvqM/at4z5o0FKP0VBvS3AD5Gs+1txf6FXtx5bqNco5+KyqB5i8i
         Mr5N6hLknC/h8ATutHtWkYBNOVulF6egVpICdP8SWOLtjAwKfe4lxLbs2RZpuocZPo
         zFR/pUXqM2cGSXn+Y2HVZH2y2ocNSe1PJsbiMSTB6FxgpHpktoaOjz1EfVqNrQT/Yw
         /ooU8aGmJomFQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Jun 2023 01:48:43 +0300 (MSK)
Message-ID: <1ede0f53-8513-e346-b5a8-fc8a804cfa8d@sberdevices.ru>
Date:   Fri, 2 Jun 2023 01:44:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5 1/6] mtd: rawnand: meson: fix ready/busy command
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
 <20230601061850.3907800-2-AVKrasnov@sberdevices.ru>
 <20230601095142.3a611b5a@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230601095142.3a611b5a@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/01 16:24:00 #21397712
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel!

May be I can exclude this patch from this patchset and send it as a single patch
as it is fix and not related with other patches?

Thanks, Arseniy

On 01.06.2023 10:51, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:44 +0300:
> 
>> This fixes ready/busy command value.
> 
> nit: "Fix the ready/busy command value."
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 074e14225c06..9dd4a676497b 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -37,7 +37,7 @@
>>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
>>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>>  #define NFC_CMD_SHORTMODE_DISABLE	0
>> -#define NFC_CMD_RB_INT		BIT(14)
>> +#define NFC_CMD_RB_INT		((0xb << 10) | BIT(18) | BIT(16))
>>  
>>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
>>  
> 
> 
> Thanks,
> Miquèl
