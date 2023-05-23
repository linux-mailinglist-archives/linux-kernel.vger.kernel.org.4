Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBD70D8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjEWJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjEWJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:17:09 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13794
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:17:05 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 110CA5FD61;
        Tue, 23 May 2023 12:17:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684833423;
        bh=+ABvyWQfCXkUi2+uQOAB+8PQel5h0wJF+jP4krYjQWw=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=HvZysagfHA7sgcXd41nR5hvCN81dWokfJKKCFbJtvglsoLqWaq2lZGu5f3RFq4D7t
         o7AYGZMLDm9SQl2CGVu/m9wsInTf/BJLgdhBpHEcY363w04IQyKnYZ8pPx0IH0Phes
         8wWjJwem+NbJKsHwtCEvC74MwcJSDb4sIiLqiw8RomJwBxlesYeUWf5B5p/SOk7mOx
         T3UegBFLjm/T+nxR0YwWPIm6L3hnHVeo0HH8vN5gBaqe/LezzPk8nPfNsSID0Y4yGD
         aOk2Qw6jGwdOBzaVnTmOY1Kco+Cl4o0cL9DUoOKOOdbwkUwWfvI8YY1PdOR1Mz3hAR
         C4ULRLv+08kmA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 23 May 2023 12:17:00 +0300 (MSK)
Message-ID: <9013b0e2-c923-43f8-0bd6-979bf0c23ebc@sberdevices.ru>
Date:   Tue, 23 May 2023 12:12:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] mtd: rawnand: meson: fix command sequence for
 read/write
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
 <20230515094440.3552094-2-AVKrasnov@sberdevices.ru>
 <20230522170526.6486755a@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230522170526.6486755a@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 05:11:00 #21371280
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

Hello Miquel, Liang

On 22.05.2023 18:05, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:35 +0300:
> 
>> This fixes read/write functionality by:
>> 1) Changing NFC_CMD_RB_INT bit value.
> 
> I guess this is a separate fix
> 

Ok, I'll move it to separate patch

>> 2) Adding extra NAND_CMD_STATUS command on each r/w request.
> 
> Is this really needed? Looks like you're delaying the next op only. Is
> using a delay enough? If yes, then it's probably the wrong approach.
> 
>> 3) Adding extra idle commands during r/w request.
> 
> Question about this below, might also be a patch on its own?
> 
>> 4) Adding extra NAND_CMD_READ0 on each read request.
>>
>> Without this patch driver works unstable, for example there are a lot
>> of ECC errors.
> 
> I believe all the fixes should be Cc'ed to stable, please add in your
> commits:
> 
> Cc: stable@...
> 

Ack, after everything will be clear with this patch :)

>>
>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>> Suggested-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 074e14225c06..2f4d8c84186b 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -37,7 +37,7 @@
>>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
>>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>>  #define NFC_CMD_SHORTMODE_DISABLE	0
>> -#define NFC_CMD_RB_INT		BIT(14)
>> +#define NFC_CMD_RB_INT ((0xb << 10) | BIT(18) | BIT(16))
>>  
>>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
>>  
>> @@ -392,7 +392,7 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>  	}
>>  }
>>  
>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, int cmd_read0)
>>  {
>>  	u32 cmd, cfg;
>>  	int ret = 0;
>> @@ -407,17 +407,29 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>  
>>  	reinit_completion(&nfc->completion);
>>  
>> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +	meson_nfc_cmd_idle(nfc, 5);
> 
> Why 5 and 2 below? They look like magic values. Is this totally
> experimental?

@Liang, may be change it to defines ?

> 
>> +
>>  	/* use the max erase time as the maximum clock for waiting R/B */
>> -	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>> -		| nfc->param.chip_select | nfc->timing.tbers_max;
> 
> This is not documented in the commit log, is it?
> 
>> +	cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +	meson_nfc_cmd_idle(nfc, 2);
>>  
>>  	ret = wait_for_completion_timeout(&nfc->completion,
>>  					  msecs_to_jiffies(timeout_ms));
>>  	if (ret == 0)
>> -		ret = -1;
>> +		return -1;
> 
> Please use real error codes, such as ETIMEDOUT.

Ack

> 
>>  
>> -	return ret;
>> +	if (!cmd_read0)
>> +		return 0;
>> +
>> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
> 
> This looks really wrong, I don't get why you would need to send an
> expensive READ0 command.

This logic was suggested by @Liang Yang here to fix this driver (suggested as patch):
https://lore.kernel.org/linux-mtd/8537e736-44a8-d17b-7923-25d5bd406dcc@sberdevices.ru/T/#m0df09d2ab2cac98431fb268a4ce3c00dc5c7a69e
@Liang, could You please give us more details?

Thanks, Arseniy

> 
>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +	meson_nfc_drain_cmd(nfc);
>> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +
>> +	return 0;
>>  }
>>  
>>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>> @@ -623,7 +635,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>  	if (in) {
>>  		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
>> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
>> +		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), 1);
>>  	} else {
>>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>>  	}
>> @@ -669,7 +681,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>  
>>  	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>> +	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), 0);
>>  
>>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>  
>> @@ -952,7 +964,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>  			break;
>>  
>>  		case NAND_OP_WAITRDY_INSTR:
>> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
>> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms, 1);
>>  			if (instr->delay_ns)
>>  				meson_nfc_cmd_idle(nfc, delay_idle);
>>  			break;
> 
> 
> Thanks,
> Miquèl
