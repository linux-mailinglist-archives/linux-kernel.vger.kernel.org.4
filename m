Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E9723A59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbjFFHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjFFHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:45:01 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A091FD6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:42:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 82DEE5FD25;
        Tue,  6 Jun 2023 10:42:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686037357;
        bh=fzYCuFXNsmnElmKXwU1mIqefZgkp9qnlJKt8LsUnhE8=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=htNuaH49mu4sT39gBJ8bfbjs+HgzQJECYIt3riK7h6CWSuQCGzf9AXkoxGIHnbiWz
         Vq60THo0oCJtx38XNR9ldmslsXSiHi6Lt8jJFkc/FAatYYKvFxxHCxwmfckx2x03m/
         GgqEaynrYw0SOy/h4G7G1qzK1+hfoYqIXB6P5W+Ft/asys14ESaSF6vB5/9ycSdOBg
         yaXa1xAYDGWJYYtZBAHycrE2hq9LAPTr/XzOSpQxT1nfQJZbgzqE/8VEi902ylqaMk
         B3mfdr3STb09U42wpKgTFgVMxLGnSdE3tx4KtcoYLaN/z6uVuQo28DF7NFhpqCcrlt
         dAmGaOuilgwKQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 10:42:36 +0300 (MSK)
Message-ID: <e31be327-b351-3a94-b2d8-0867f29bb9ec@sberdevices.ru>
Date:   Tue, 6 Jun 2023 10:37:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: check buffer length
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
References: <20230605191047.1820016-1-AVKrasnov@sberdevices.ru>
 <20230606091607.7b7b6814@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230606091607.7b7b6814@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 04:28:00 #21442352
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



On 06.06.2023 10:16, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 22:10:46 +0300:
> 
>> Meson NAND controller has limited buffer length, so check it before
>> command execution to avoid length trim. Also check MTD write size on
>> chip attach.
> 
> Almost there :)

Hello Miquel!

You mean to rephrase it? :)

Thanks, Arseniy

> 
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 074e14225c06..bfb5363cac23 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -108,6 +108,8 @@
>>  
>>  #define PER_INFO_BYTE		8
>>  
>> +#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
>> +
>>  struct meson_nfc_nand_chip {
>>  	struct list_head node;
>>  	struct nand_chip nand;
>> @@ -280,7 +282,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>>  
>>  	if (raw) {
>>  		len = mtd->writesize + mtd->oobsize;
>> -		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>> +		cmd = len | scrambler | DMA_DIR(dir);
>>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  		return;
>>  	}
>> @@ -544,7 +546,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>>  	if (ret)
>>  		goto out;
>>  
>> -	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>> +	cmd = NFC_CMD_N2M | len;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  
>>  	meson_nfc_drain_cmd(nfc);
>> @@ -568,7 +570,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>>  	if (ret)
>>  		return ret;
>>  
>> -	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>> +	cmd = NFC_CMD_M2N | len;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  
>>  	meson_nfc_drain_cmd(nfc);
>> @@ -936,6 +938,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>  			break;
>>  
>>  		case NAND_OP_DATA_IN_INSTR:
>> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>> +				return -EINVAL;
> 
> You need to refuse the operation earlier. That's what the check_op
> boolean is about. Maybe you can take inspiration from anfc_check_op()
> in the arasan controller.

Ok! Thanks!

> 
>> +
>>  			buf = meson_nand_op_get_dma_safe_input_buf(instr);
>>  			if (!buf)
>>  				return -ENOMEM;
>> @@ -944,6 +949,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>  			break;
>>  
>>  		case NAND_OP_DATA_OUT_INSTR:
>> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>> +				return -EINVAL;
> 
> Same.
> 
>> +
>>  			buf = meson_nand_op_get_dma_safe_output_buf(instr);
>>  			if (!buf)
>>  				return -ENOMEM;
>> @@ -1181,6 +1189,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>  	struct mtd_info *mtd = nand_to_mtd(nand);
>>  	int nsectors = mtd->writesize / 1024;
>> +	int raw_writesize;
>>  	int ret;
>>  
>>  	if (!mtd->name) {
>> @@ -1192,6 +1201,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>  			return -ENOMEM;
>>  	}
>>  
>> +	raw_writesize = mtd->writesize + mtd->oobsize;
>> +	if (raw_writesize > NFC_CMD_RAW_LEN) {
>> +		dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
>> +			raw_writesize, NFC_CMD_RAW_LEN);
>> +		return -EINVAL;
>> +	}
>> +
>>  	if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>  		nand->bbt_options |= NAND_BBT_NO_OOB;
>>  
> 
> 
> Thanks,
> Miquèl
