Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2A74724F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGDNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:13:09 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C91E7A;
        Tue,  4 Jul 2023 06:13:07 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8B27C120054;
        Tue,  4 Jul 2023 16:13:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8B27C120054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688476385;
        bh=GlVkjDGUz+TG2KzYPrtHEhH8cUxqlz7tg0ytJOgmFnk=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=heH7xLD0G9O248QeBQKzS6wk28tLWNSdCUYDhg0JXnXl1g+A2NQcU/bkwepT2EdtA
         R6CVhTpsitP2OyUN5DgQeUBqG46IJeZBh18XrQjyM4L1kLE4T8vdIXrF2vK9xqptW1
         s7C+3naoP1u4u+uWYLttBcacIOv84bcE/gk3/3baFboZV+eXAFCg93ukMlpWy5Pb4J
         QREvr7YkogO/7yIC+j0xFy63Hlxvoxgx1XTdn7le9Q2bpj0sRuLL+fDO4FKJZ966C9
         PAlfYnLiNz28mFXUndIlb0LX9Gzq71R13qI6EkgEH+hxNNtsWj/IxDLosB4Lne+clS
         DjF9u6dOr3WWA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 16:13:05 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 16:12:54 +0300
Message-ID: <73849b9c-0700-4946-84a2-428f98f0a6d6@sberdevices.ru>
Date:   Tue, 4 Jul 2023 16:07:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] mtd: rawnand: meson: waiting w/o wired ready/busy
 pin
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
 <20230608044728.1328506-3-AVKrasnov@sberdevices.ru>
 <20230704144357.286281dc@xps-13>
 <47994f36-27d4-e5e4-73a9-6d4225671eec@sberdevices.ru>
 <20230704151220.67857861@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230704151220.67857861@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178419 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
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



On 04.07.2023 16:12, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Tue, 4 Jul 2023 15:46:18 +0300:
> 
>> On 04.07.2023 15:43, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> AVKrasnov@sberdevices.ru wrote on Thu, 8 Jun 2023 07:47:28 +0300:
>>>   
>>>> If there is no wired ready/busy pin, classic way to wait for command
>>>> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
>>>> special command which allows to wait for NAND_STATUS_READY bit without
>>>> reading status in a software loop (as 'nand_soft_waitrdy()' does). To
>>>> use it send this command along with NAND_CMD_STATUS, then wait for an
>>>> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
>>>> allows to use interrupt driven waiting without wired ready/busy pin.
>>>>
>>>> Suggested-by: Liang Yang <liang.yang@amlogic.com>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>>  drivers/mtd/nand/raw/meson_nand.c | 77 +++++++++++++++++++++++++++++--
>>>>  1 file changed, 73 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index 074e14225c06..9f05e113b4ea 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -38,6 +38,7 @@
>>>>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>>>>  #define NFC_CMD_SHORTMODE_DISABLE	0
>>>>  #define NFC_CMD_RB_INT		BIT(14)
>>>> +#define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
>>>>  
>>>>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
>>>>  
>>>> @@ -179,6 +180,7 @@ struct meson_nfc {
>>>>  	u32 info_bytes;
>>>>  
>>>>  	unsigned long assigned_cs;
>>>> +	bool no_rb_pin;
>>>>  };
>>>>  
>>>>  enum {
>>>> @@ -392,7 +394,42 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>>>  	}
>>>>  }
>>>>  
>>>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>>> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_ms,
>>>> +				    bool need_cmd_read0)
>>>> +{
>>>> +	u32 cmd, cfg;
>>>> +
>>>> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>> +	meson_nfc_drain_cmd(nfc);
>>>> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>>> +
>>>> +	cfg = readl(nfc->reg_base + NFC_REG_CFG);
>>>> +	cfg |= NFC_RB_IRQ_EN;
>>>> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
>>>> +
>>>> +	reinit_completion(&nfc->completion);
>>>> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	/* use the max erase time as the maximum clock for waiting R/B */
>>>> +	cmd = NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +	if (!wait_for_completion_timeout(&nfc->completion,
>>>> +					 msecs_to_jiffies(timeout_ms)))
>>>> +		return -ETIMEDOUT;
>>>> +
>>>> +	if (need_cmd_read0) {
>>>> +		cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
>>>> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +		meson_nfc_drain_cmd(nfc);
>>>> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>>> +	}  
>>>
>>> I forgot about this, you should avoid open coding core helpers, can you
>>> please send a followup patch to use nand_status_op() and
>>> nand_exit_status_op() ?  
>>
>> A ok, so:
>> 1) Sending NAND_CMD_STATUS goes to nand_status_op()
>> 2) Sending NAND_CMD_READ0 goes to nand_exit_status_op()
>>
>> Ok, no problem! I'll prepare and send it on this week!
> 
> Exactly. Sorry I had this in mind but I likely forgot to write it
> down.

Ok, got it!

Thanks, Arseniy

> 
> Thanks,
> Miquèl
