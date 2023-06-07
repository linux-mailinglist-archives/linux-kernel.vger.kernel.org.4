Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E837255F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbjFGHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbjFGHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:37:26 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432B1BEB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:36:21 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4CC315FD57;
        Wed,  7 Jun 2023 10:36:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686123380;
        bh=75SP1N4UkgIS2BxcoY5IwqI2WDe7/P9Otn75kDJLOpY=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=nTKrvOnWXIWI8VYLK8ckEYm0r6x5wxk2qYYCVwqq0SlRW0TU7buBF4iNGjCuFlfjE
         Kt2MdhytT2wXCUBDKy+duE8EZGyIExVNaTp277shwT71ZryL2EDmK1r4+nUnTdg59r
         VggpoR2Bpm16eBClKzdvzkzYxQUdfp7c/QiUR2zGt9baGwmUqI+a565/QVTVkuf0PX
         bil4a44AdfjMa06HQ1u0LCuqXQI72z1c4/JCd5T73vkkZP8Jp4WF0RhiOY377E/J8o
         rsCurra2WO9QCJ1lV/5D0fAVkO1p4BSMPzHMJjwaR6eF7CdGZVBMQQ9KrOybQzYBR3
         iojWQlub35BrQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 10:36:20 +0300 (MSK)
Message-ID: <6c0b4c3c-fd7b-f6e9-34b3-27901c5c7d18@sberdevices.ru>
Date:   Wed, 7 Jun 2023 10:31:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: waiting w/o wired ready/busy pin
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
References: <20230606195128.83432-1-AVKrasnov@sberdevices.ru>
 <2ed06841-6c9f-46c9-2d2d-2daffb0a9010@sberdevices.ru>
 <688909b3-fb0a-1001-d38e-57dba23d3bae@amlogic.com>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <688909b3-fb0a-1001-d38e-57dba23d3bae@amlogic.com>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 04:52:00 #21449589
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



On 07.06.2023 06:14, Liang Yang wrote:
> Hi Arseniy,
> 
> On 2023/6/7 3:54, Arseniy Krasnov wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 06.06.2023 22:51, Arseniy Krasnov wrote:
>>> If there is no wired ready/busy pin, classic way to wait for command
>>> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
>>> special command which allows to wait for NAND_STATUS_READY bit without
>>> reading status in a software loop (as 'nand_soft_waitrdy()' does). To
>>> use it send this command along with NAND_CMD_STATUS, then wait for an
>>> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
>>> allows to use interrupt driven waiting without wired ready/busy pin.
>>>
>>> Suggested-by: Liang Yang <liang.yang@amlogic.com>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>>   drivers/mtd/nand/raw/meson_nand.c | 58 ++++++++++++++++++++++++++++++-
>>>   1 file changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index 074e14225c06..f4c5309a9527 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -38,6 +38,7 @@
>>>   #define NFC_CMD_SCRAMBLER_DISABLE    0
>>>   #define NFC_CMD_SHORTMODE_DISABLE    0
>>>   #define NFC_CMD_RB_INT               BIT(14)
>>> +#define NFC_CMD_RB_INT_NO_PIN        ((0xb << 10) | BIT(18) | BIT(16))
>>>
>>>   #define NFC_CMD_GET_SIZE(x)  (((x) >> 22) & GENMASK(4, 0))
>>>
>>> @@ -94,6 +95,7 @@
>>>
>>>   /* nand flash controller delay 3 ns */
>>>   #define NFC_DEFAULT_DELAY    3000
>>> +#define NFC_NO_RB_PIN_DELAY  5
>>>
>>>   #define ROW_ADDER(page, index)       (((page) >> (8 * (index))) & 0xff)
>>>   #define MAX_CYCLE_ADDRS              5
>>> @@ -179,6 +181,7 @@ struct meson_nfc {
>>>        u32 info_bytes;
>>>
>>>        unsigned long assigned_cs;
>>> +     bool no_rb_pin;
>>>   };
>>>
>>>   enum {
>>> @@ -392,7 +395,41 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>>        }
>>>   }
>>>
>>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>>> +{
>>> +     u32 cmd, cfg;
>>> +
>>> +     meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>> +     meson_nfc_drain_cmd(nfc);
>>> +     meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>> +
>>> +     cfg = readl(nfc->reg_base + NFC_REG_CFG);
>>> +     cfg |= NFC_RB_IRQ_EN;
>>> +     writel(cfg, nfc->reg_base + NFC_REG_CFG);
>>> +
>>> +     reinit_completion(&nfc->completion);
>>> +     cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>> +     writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>> +     meson_nfc_cmd_idle(nfc, NFC_NO_RB_PIN_DELAY);
>>
>> ^^^
>>
>>> +
>>> +     /* use the max erase time as the maximum clock for waiting R/B */
>>> +     cmd = NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
>>> +     writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>> +     meson_nfc_cmd_idle(nfc, NFC_NO_RB_PIN_DELAY);
>>
>> ^^^
>> Liang, I've implemented "new RB_INT" way instead of 'nand_soft_waitrdy()'. There were two numbers
>> 2 and 5 in 'meson_nfc_cmd_idle()' as time argument (here and above). I've replaced both with
>> define of 5 == NFC_NO_RB_PIN_DELAY. Is it correct? 2 and 5 were from doc?
> 
> You can do like that. as i know, bigger has no impact.
> yes, them come from the example code of the controller datasheet; but i think we can delete them also.

Done, removed in v2.

Thanks, Arseniy

> 
>>
>> Thanks, Arseniy
>>
>>> +
>>> +     if (!wait_for_completion_timeout(&nfc->completion,
>>> +                                      msecs_to_jiffies(timeout_ms)))
>>> +             return -ETIMEDOUT;
>>> +
>>> +     cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
>>> +     writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>> +     meson_nfc_drain_cmd(nfc);
>>> +     meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>>>   {
>>>        u32 cmd, cfg;
>>>        int ret = 0;
>>> @@ -420,6 +457,23 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>>        return ret;
>>>   }
>>>
>>> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>> +{
>>> +     if (nfc->no_rb_pin) {
>>> +             /* This mode is used when there is no wired R/B pin.
>>> +              * It works like 'nand_soft_waitrdy()', but instead of
>>> +              * polling NAND_CMD_STATUS bit in the software loop,
>>> +              * it will wait for interrupt - controllers checks IO
>>> +              * bus and when it detects NAND_CMD_STATUS on it, it
>>> +              * raises interrupt. After interrupt, NAND_CMD_READ0 is
>>> +              * sent as terminator of the ready waiting procedure.
>>> +              */
>>> +             return meson_nfc_wait_no_rb_pin(nfc, timeout_ms);
>>> +     } else {
>>> +             return meson_nfc_wait_rb_pin(nfc, timeout_ms);
>>> +     }
>>> +}
>>> +
>>>   static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>   {
>>>        struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>> @@ -1412,6 +1466,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>>                return ret;
>>>        }
>>>
>>> +     nfc->no_rb_pin = !of_property_read_bool(dev->of_node, "nand-rb");
>>> +
>>>        writel(0, nfc->reg_base + NFC_REG_CFG);
>>>        ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
>>>        if (ret) {
