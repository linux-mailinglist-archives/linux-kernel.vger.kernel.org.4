Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D66CD4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjC2IhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjC2IhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:37:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8724494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:37:03 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 419BC5FD06;
        Wed, 29 Mar 2023 11:37:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680079021;
        bh=mKsNAk5/DGfisdq4xh+Klk//35W39m5NPIJzVVuCimY=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=RDDBiiKhVJfhYOypMlNNyTitm6+/iUKEn/jGOKyRarwEHZEC2iJjfS8Ah5aiDeD49
         lJ7ILFyRr4jr2l6oOTUHNXqzrOYs/qeTP9tcgzrxpZtrodfSYyEdmCvsqV7tLz8vaE
         /KKChUqBwHMvRf5uCrukudvSHhST/DV8evYD7eyfuwbMYsPPupBWjDKmyEwA+ne8xN
         H5c/HXVsNpyY/j6hjaiws1JNlMsjldtStD06yIiI3/e5LaJArqqPA3bX1xD+hRbrkz
         e8fL/uQnpu4XoZuu8STC9xGpznXXaBobHIUS/FuLfTNX9EMZl+JixrY1bVCS9XxE5k
         1pjssiu+j2MHw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 29 Mar 2023 11:37:00 +0300 (MSK)
Message-ID: <c110bd0f-f25a-a74a-07cb-4c3fdb8ef306@sberdevices.ru>
Date:   Wed, 29 Mar 2023 11:33:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
References: <3794ffbf-dfea-e96f-1f97-fe235b005e19@sberdevices.ru>
 <447abc1b-b4a3-5848-c99a-ecbff11486fe@linaro.org>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <447abc1b-b4a3-5848-c99a-ecbff11486fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/29 04:10:00 #21025776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.03.2023 11:09, Tudor Ambarus wrote:
> 
> 
> On 3/29/23 08:47, Arseniy Krasnov wrote:
>> Valid mask is 0x3FFF, without this patch the following problems were
>> found:
>>
>> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
>>                   bit-wise majority to recover it
>>    [    0.947384] ONFI parameter recovery failed, aborting
>>
>> 2) Read with disabled ECC mode was broken.
>>
>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index a28574c00900..074e14225c06 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -280,7 +280,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>>  
>>  	if (raw) {
>>  		len = mtd->writesize + mtd->oobsize;
>> -		cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
>> +		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> 
> What happens when len > GENMASK(13, 0)? Do you check this somewhere?

'len' will be trimmed. I'm not sure that this case is possible here, because GENMASK(13, 0)
is hardware limit for this NAND controller, so 'writesize' and 'oobsize' will be initialized
to fit this value. Moreover GENMASK(13, 0) is 16Kb - i think it is big enough for single
read. Also i'm not sure that it is good approach to check 'len' here - we are in the middle
of NAND read processing.

> 
> Please introduce a macro/field for GENMASK(13, 0), having such mask
> scattered along the code looks hackish and doesn't help readability.
> You'll get to use FIELD_PREP as well.

Ack, i'll do it in v3

Thanks, Arseniy

> 
>>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  		return;
>>  	}
>> @@ -544,7 +544,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>>  	if (ret)
>>  		goto out;
>>  
>> -	cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));
>> +	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  
>>  	meson_nfc_drain_cmd(nfc);
>> @@ -568,7 +568,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>>  	if (ret)
>>  		return ret;
>>  
>> -	cmd = NFC_CMD_M2N | (len & GENMASK(5, 0));
>> +	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  
>>  	meson_nfc_drain_cmd(nfc);
