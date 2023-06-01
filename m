Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9693871F66E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjFAXOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjFAXOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:14:19 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A513D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:14:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4E26F5FD02;
        Fri,  2 Jun 2023 02:14:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685661254;
        bh=yY10i4tFiygC/q2Mwa06vFWsbLJ57hqtFOism3JK554=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=nD7397aI4a5g/ICffhuUhWnEkMETIqLlDV9U0SxZ7Kq0rNaNIeUV1Q1cbd8KjTpf/
         9LZBUqClC2s44J6L3x3OheKAuVZ+Md01t3663QWX1FAmS9I1bTALvWudUf1fwH+EDI
         4g14Y6QvW2EGF5lwKm0DSX/LKlSfvLgOSPkqW8ZEJtMxZCTJ1l51w0qVgeNqfUYp+x
         uAxp9KtipulhtquZcL1TgbDCBWMJQdeECROG3bE7J+atX+a2m8lPPgeKz0EgmNlXw/
         7XTVNI9PFfm+zBpgWn2YyyJ7hDZyzkYc2VSTzdzD3jP25TBmSJpx3EkamQOtq0e335
         ip2NEr5TXv8qg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Jun 2023 02:14:13 +0300 (MSK)
Message-ID: <9e106d50-2524-c999-48b1-a20760238aaf@sberdevices.ru>
Date:   Fri, 2 Jun 2023 02:09:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
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
 <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
 <20230601100751.41c3ff0b@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230601100751.41c3ff0b@xps-13>
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



On 01.06.2023 11:07, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:45 +0300:
> 
>> This adds support of waiting for command completion in sofyware polling
> 
> 							software
> 
>> mode. It is needed when ready/busy pin is not implemented in hardware.
> 
> Please also use (here and in all your commits) the affirmative tense:
> 
> "Add support for "
> 
> instead of
> 
> "This adds support"
> 
> or
> 
> "This commit adds"
> 
> Also, this is not a fix but a feature, so it should be introduced after
> all the fixes. This way I can take all the fixes first without
> dependency.

Ack

> 
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 53 ++++++++++++++++++-------------
>>  1 file changed, 31 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 9dd4a676497b..82a629025adc 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -179,6 +179,7 @@ struct meson_nfc {
>>  	u32 info_bytes;
>>  
>>  	unsigned long assigned_cs;
>> +	bool use_polling;
> 
> Very ambiguous wording. Polling is usually what you do to get the data.
> Here you want a control signal so I would rename this flag with
> something like "no_rb_pin".

Ack

> 
> Do you have a driver structure to represent the nand chip? Because
> there is one RB per chip (even per die), not per controller.
> 
>>  };
>>  
>>  enum {
>> @@ -392,32 +393,38 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>  	}
>>  }
>>  
>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>> +static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
> 
> I would rather prefer keeping the controller pointer here. It's your
> main structure here.

Ack

> 
>>  {
>> -	u32 cmd, cfg;
>> -	int ret = 0;
>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>  
>> -	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>> -	meson_nfc_drain_cmd(nfc);
>> -	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +	if (nfc->use_polling) {
>> +		return nand_soft_waitrdy(nand, timeout_ms);
> 
> You could simplify the diff by a lot by avoiding this extra tab
> you added in the second part of the function, using:
> 
> 	if (no_rb_pin)
> 		return nand_soft_waitrdy();
> 
> 	...
> 
>> +	} else {
>> +		u32 cmd, cfg;
>> +		int ret = 0;
>>  
>> -	cfg = readl(nfc->reg_base + NFC_REG_CFG);
>> -	cfg |= NFC_RB_IRQ_EN;
>> -	writel(cfg, nfc->reg_base + NFC_REG_CFG);
>> +		meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>> +		meson_nfc_drain_cmd(nfc);
>> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>  
>> -	reinit_completion(&nfc->completion);
>> +		cfg = readl(nfc->reg_base + NFC_REG_CFG);
>> +		cfg |= NFC_RB_IRQ_EN;
>> +		writel(cfg, nfc->reg_base + NFC_REG_CFG);
>>  
>> -	/* use the max erase time as the maximum clock for waiting R/B */
>> -	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>> -		| nfc->param.chip_select | nfc->timing.tbers_max;
>> -	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +		reinit_completion(&nfc->completion);
>>  
>> -	ret = wait_for_completion_timeout(&nfc->completion,
>> -					  msecs_to_jiffies(timeout_ms));
>> -	if (ret == 0)
>> -		ret = -1;
>> +		/* use the max erase time as the maximum clock for waiting R/B */
>> +		cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>> +			| nfc->param.chip_select | nfc->timing.tbers_max;
>> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>  
>> -	return ret;
>> +		ret = wait_for_completion_timeout(&nfc->completion,
>> +						  msecs_to_jiffies(timeout_ms));
>> +		if (ret == 0)
>> +			return -ETIMEDOUT;
>> +
>> +		return 0;
>> +	}
>>  }
>>  
>>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>> @@ -623,7 +630,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>  	if (in) {
>>  		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
>> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
>> +		meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tR_max));
> 
> Let's avoid that.
> 
>>  	} else {
>>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>>  	}
>> @@ -669,7 +676,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>  
>>  	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>> +	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
>>  
>>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>  
>> @@ -952,7 +959,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>  			break;
>>  
>>  		case NAND_OP_WAITRDY_INSTR:
>> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
>> +			meson_nfc_queue_rb(nand, instr->ctx.waitrdy.timeout_ms);
>>  			if (instr->delay_ns)
>>  				meson_nfc_cmd_idle(nfc, delay_idle);
>>  			break;
>> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> +	nfc->use_polling = of_property_read_bool(dev->of_node, "polling");
> 
> This is a problem. You cannot add a polling property like that.
> 
> There is already a nand-rb property which is supposed to carry how are
> wired the RB lines. I don't see any in-tree users of the compatibles, I
> don't know how acceptable it is to consider using soft fallback when
> this property is missing, otherwise take the values of the rb lines
> provided in the DT and user hardware control, but I would definitely
> prefer that.

I see. So i need to implement processing of this property here? And if it
is missed -> use software waiting. I think interesting thing will be that:

1) Even with support of this property here, I really don't know how to pass
   RB values to this controller - I just have define for RB command and that's
   it. I found that this property is an array of u32 - IIUC each element is
   RB pin per chip. May be i need to dive into the old vendor's driver to find
   how to use RB values (although this driver uses software waiting so I'm not
   sure that I'll find something in it).
2) I can't test RB mode - I don't have such device :( 

Also for example in arasan-nand-controller.c parsed 'nand-rb' values are used
in controller specific register for waiting (I guess Meson controller has something
like that, but I don't have doc). While in marvell_nand.c it looks like that they parse
'nand-rb' property, but never use it.

> 
> In any case you'll need a dt-binding update which must be acked by
> dt-binding maintainers.

You mean to add this property desc to Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml ?

Thanks, Arseniy

> 
>> +
>>  	writel(0, nfc->reg_base + NFC_REG_CFG);
>>  	ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
>>  	if (ret) {
> 
> 
> Thanks,
> Miquèl
