Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB2727720
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjFHGNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjFHGN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:13:27 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3008011A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:13:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4B7C75FD08;
        Thu,  8 Jun 2023 09:13:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686204799;
        bh=or7Yqg5C8h/byyRbSI5VeLfJdpcuYjeWvRTn0qMospo=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=hLnMn/mS2xDWj7QdtHWax6BzgtHNmuMvOa4tiIFqAfne5yxTuzZ1aMDsH7cZbjpL/
         2A5Cct3PtpJP6HVZdDhYbhv4uHiDKt936Yr8BH1CNY0clEku/4l4QXSEzHAni4Ujfb
         Z+OZMLOdsTWF//glyFNr4IW2N1b/zvjcSXeyo8fafMuBvPObFoYU70fqqg51EnAPLM
         Xf/3FwqvKGusSca946ppijY62I5l2Ooqjw++ZCnFKTeOgKd+uaiXfe3imatyOI0vRa
         5LwEl8r2Dc70Ikq5YBDpROsYtrlAIb8e1AESyeyNmttYD74t4FooL7v1BOjDBjZlBx
         TEWRdVA2He6BA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  8 Jun 2023 09:13:17 +0300 (MSK)
Message-ID: <c5702961-2a95-aac8-a60f-a652ade457b3@sberdevices.ru>
Date:   Thu, 8 Jun 2023 09:08:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mtd: rawnand: meson: check buffer length
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
References: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
 <9adef6da-5930-dcaa-f148-e4a398d39f2d@sberdevices.ru>
 <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
 <20230608081040.78e74eb1@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230608081040.78e74eb1@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/08 03:34:00 #21458136
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



On 08.06.2023 09:10, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Thu, 8 Jun 2023 00:17:35 +0300:
> 
>> Hi again Miquel, Liang!
>>
>> What do You think about this patch?
> 
> I really appreciate all the effort you are putting into this but
> please consider giving me a little bit of air as well, I'm already
> spending a lot of time reviewing all your patches. Please mind a ping
> is not relevant before a couple of weeks in general.

Sorry for that! Sure, no problem!

> 
> In this case I had it in my "to apply" list but actually looking at it
> again I have a minor comment below.

Got it!

Thanks, Arseniy

> 
>>
>> Thanks, Arseniy
>>
>> On 06.06.2023 19:29, Arseniy Krasnov wrote:
>>> Sorry, here is changelog:
>>> v1 -> v2:
>>> * Move checks from 'switch/case' which executes commands in 'meson_nfc_exec_op()' to a special
>>>   separated function 'meson_nfc_check_op()' which is called before commands processing.
>>>
>>> On 06.06.2023 13:16, Arseniy Krasnov wrote:  
>>>> Meson NAND controller has limited buffer length, so check it before
>>>> command execution to avoid length trim. Also check MTD write size on
>>>> chip attach.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>>  drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++++++----
>>>>  1 file changed, 42 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index 23a73268421b..db6b18753071 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -111,6 +111,8 @@
>>>>  
>>>>  #define PER_INFO_BYTE		8
>>>>  
>>>> +#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
>>>> +
>>>>  struct meson_nfc_nand_chip {
>>>>  	struct list_head node;
>>>>  	struct nand_chip nand;
>>>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>>>>  
>>>>  	if (raw) {
>>>>  		len = mtd->writesize + mtd->oobsize;
>>>> -		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>>>> +		cmd = len | scrambler | DMA_DIR(dir);
>>>>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>  		return;
>>>>  	}
>>>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>>>>  	if (ret)
>>>>  		goto out;
>>>>  
>>>> -	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>>>> +	cmd = NFC_CMD_N2M | len;
>>>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>  
>>>>  	meson_nfc_drain_cmd(nfc);
>>>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> -	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>>>> +	cmd = NFC_CMD_M2N | len;
>>>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>  
>>>>  	meson_nfc_drain_cmd(nfc);
>>>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
>>>>  		kfree(buf);
>>>>  }
>>>>  
>>>> +static int meson_nfc_check_op(struct nand_chip *chip,
>>>> +			      const struct nand_operation *op)
>>>> +{
>>>> +	int op_id;
>>>> +
>>>> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>> +		const struct nand_op_instr *instr;
>>>> +
>>>> +		instr = &op->instrs[op_id];
>>>> +
>>>> +		switch (instr->type) {
>>>> +		case NAND_OP_DATA_IN_INSTR:
>>>> +		case NAND_OP_DATA_OUT_INSTR:
>>>> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>>>> +				return -ENOTSUPP;
>>>> +
>>>> +			break;
>>>> +		default:
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int meson_nfc_exec_op(struct nand_chip *nand,
>>>>  			     const struct nand_operation *op, bool check_only)
>>>>  {
>>>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>>>  	const struct nand_op_instr *instr = NULL;
>>>>  	void *buf;
>>>>  	u32 op_id, delay_idle, cmd;
>>>> +	int err;
>>>>  	int i;
>>>>  
>>>> -	if (check_only)
>>>> -		return 0;
>>>> +	err = meson_nfc_check_op(nand, op);
>>>> +	if (err || check_only)
>>>> +		return err;
> 
> For the sake of readability it is really important that we keep using
> standard constructions, so don't mix orthogonal checks and please use
> something like:
> 
> 	err = check();
> 	if (err)
> 		return err;
> 
> 	if (check_only)
> 		return 0;
> 
>>>>  
>>>>  	meson_nfc_select_chip(nand, op->cs);
>>>>  	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>  	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>  	int nsectors = mtd->writesize / 1024;
>>>> +	int raw_writesize;
>>>>  	int ret;
>>>>  
>>>>  	if (!mtd->name) {
>>>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>  			return -ENOMEM;
>>>>  	}
>>>>  
>>>> +	raw_writesize = mtd->writesize + mtd->oobsize;
>>>> +	if (raw_writesize > NFC_CMD_RAW_LEN) {
>>>> +		dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
>>>> +			raw_writesize, NFC_CMD_RAW_LEN);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>>  	if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>>>  		nand->bbt_options |= NAND_BBT_NO_OOB;
>>>>    
> 
> 
> Thanks,
> Miquèl
