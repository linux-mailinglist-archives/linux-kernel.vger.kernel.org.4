Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5DB727642
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjFHEmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjFHEm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:42:28 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1526AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:42:27 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 776BE5FD71;
        Thu,  8 Jun 2023 07:42:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686199345;
        bh=IAnc+P5Gpmwrdbjcq4XWUi/tBUzXQwXd+sGwHhWawas=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=WHYQrPQ+dgjs+YVdjzC8s5JVHKusuiIVYP1bQoaSs/xFeWCL36GoeUL5hwN3q9Poa
         uD/4BBrglS4yKmIC39oKK4qW3vQvfu6vtGrAEWeiJeD6AHcK3XVbk4K+fG/qiop0fP
         6iDZktO8SG0gjU+eU2/2J7nYw3yFKrQXtm8/kP8ir9Wn/OGHWHqIqGfSzMlOa0SQIx
         q3EfDdcMvTT6zUwIMxmpjTog+AqNuUpYuz2fKWlRPxftai1uxDD+DhBafX2FH49Yfo
         GjcyEC3jwq17qy0R5nDRh8CvyiV+EBZ8U0G2u0SP5rbuN5CvOkOuC5QpjEipXHxYdk
         Ar7NrR/PbohXw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  8 Jun 2023 07:42:25 +0300 (MSK)
Message-ID: <05cc07ce-f412-456f-74c0-57bfebe660da@sberdevices.ru>
Date:   Thu, 8 Jun 2023 07:37:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: remove unneeded bitwise OR with
 zeroes
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230605191508.1826853-1-AVKrasnov@sberdevices.ru>
 <9319a8f6-3774-0dc8-2262-8033f8016a50@sberdevices.ru>
 <429589f6-d946-9bc9-d54e-e892d513a91b@amlogic.com>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <429589f6-d946-9bc9-d54e-e892d513a91b@amlogic.com>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/08 00:23:00 #21457426
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



On 08.06.2023 06:23, Liang Yang wrote:
> 
> 
> On 2023/6/8 5:18, Arseniy Krasnov wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi again Miquel, Liang!
>>
>> What do You think about this patch?
>>
>> Thanks, Arseniy
>>
>> On 05.06.2023 22:15, Arseniy Krasnov wrote:
>>> Both operations have no effect.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>>   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index 074e14225c06..50d3110ad321 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -595,12 +595,12 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>        cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
>>>        nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
>>>
>>> -     addrs[0] = cs | NFC_CMD_ALE | 0;
>>> +     addrs[0] = cs | NFC_CMD_ALE;
>>>        if (mtd->writesize <= 512) {
>>>                cmd_num--;
>>>                row_start = 1;
>>>        } else {
>>> -             addrs[1] = cs | NFC_CMD_ALE | 0;
>>> +             addrs[1] = cs | NFC_CMD_ALE;
>>>                row_start = 2;
>>>        }
> Hi Arseniy and Miquel,
> 
> The two zeros indcates two column address. maybe we could use the micro "COLUMN_ADDR_0" and "COLUMN_ADDR_1" to keep the nfc command format "CE | ALE | addr" consistency and also let function "meson_nfc_rw_cmd_prepare_and_execute" be more readable.

Liang, done in v2:)

Thanks, Arseniy

> 
> Thanks,
> Liang
> 
>>>
