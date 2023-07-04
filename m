Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0CF7471C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGDMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGDMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:51:33 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00DB1;
        Tue,  4 Jul 2023 05:51:31 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C178B120056;
        Tue,  4 Jul 2023 15:51:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C178B120056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688475087;
        bh=TLQ4bVsJ6/y2FcfOGOxoCr2CNTZbBW/B4otEHDJxOy4=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=JOBlX3JdnBRO3v4641iouALiZVk/6soMmfxeiXQ6L6bX/KJgtrB4XL+7i1ImqgSTy
         4IjM358Sd6o4ANjJDDzT+d3S+LbBVHEADyuSnGowSptC5WYwXibt93E5SobQO4V04l
         kP5y2tU9H/GjegWASj5XNId+X06Df+Hq2C/6W20ZkFetEyxfBM0alD8q/ev++49WqN
         aAer9SGgecYFCTXBToLsvNKJzXYEdoPJ8Go6/q2Kv3pGHXlyXFWnejdr+FwBY4bo7T
         o7jugOycNCxvMFd8WFtaSPPHeuLrV+2LDSdF1qr5naPdH6L47sWYv+ENXxlZfB3YHD
         a67YQaFgAeaLw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 15:51:27 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 15:51:17 +0300
Message-ID: <47994f36-27d4-e5e4-73a9-6d4225671eec@sberdevices.ru>
Date:   Tue, 4 Jul 2023 15:46:18 +0300
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
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230704144357.286281dc@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178418 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
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



On 04.07.2023 15:43, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Thu, 8 Jun 2023 07:47:28 +0300:
> 
>> If there is no wired ready/busy pin, classic way to wait for command
>> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
>> special command which allows to wait for NAND_STATUS_READY bit without
>> reading status in a software loop (as 'nand_soft_waitrdy()' does). To
>> use it send this command along with NAND_CMD_STATUS, then wait for an
>> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
>> allows to use interrupt driven waiting without wired ready/busy pin.
>>
>> Suggested-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 77 +++++++++++++++++++++++++++++--
>>  1 file changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 074e14225c06..9f05e113b4ea 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -38,6 +38,7 @@
>>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>>  #define NFC_CMD_SHORTMODE_DISABLE	0
>>  #define NFC_CMD_RB_INT		BIT(14)
>> +#define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
>>  
>>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
>>  
>> @@ -179,6 +180,7 @@ struct meson_nfc {
>>  	u32 info_bytes;
>>  
>>  	unsigned long assigned_cs;
>> +	bool no_rb_pin;
>>  };
>>  
>>  enum {
>> @@ -392,7 +394,42 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>  	}
>>  }
>>  
>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_ms,
>> +				    bool need_cmd_read0)
>> +{
>> +	u32 cmd, cfg;
>> +
>> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>> +	meson_nfc_drain_cmd(nfc);
>> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +
>> +	cfg = readl(nfc->reg_base + NFC_REG_CFG);
>> +	cfg |= NFC_RB_IRQ_EN;
>> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
>> +
>> +	reinit_completion(&nfc->completion);
>> +	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +
>> +	/* use the max erase time as the maximum clock for waiting R/B */
>> +	cmd = NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +
>> +	if (!wait_for_completion_timeout(&nfc->completion,
>> +					 msecs_to_jiffies(timeout_ms)))
>> +		return -ETIMEDOUT;
>> +
>> +	if (need_cmd_read0) {
>> +		cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
>> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +		meson_nfc_drain_cmd(nfc);
>> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +	}
> 
> I forgot about this, you should avoid open coding core helpers, can you
> please send a followup patch to use nand_status_op() and
> nand_exit_status_op() ?

A ok, so:
1) Sending NAND_CMD_STATUS goes to nand_status_op()
2) Sending NAND_CMD_READ0 goes to nand_exit_status_op()

Ok, no problem! I'll prepare and send it on this week!

Thanks, Arseniy

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>>  {
>>  	u32 cmd, cfg;
>>  	int ret = 0;
>> @@ -420,6 +457,27 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>  	return ret;
>>  }
>>  
>> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms,
>> +			      bool need_cmd_read0)
>> +{
>> +	if (nfc->no_rb_pin) {
>> +		/* This mode is used when there is no wired R/B pin.
>> +		 * It works like 'nand_soft_waitrdy()', but instead of
>> +		 * polling NAND_CMD_STATUS bit in the software loop,
>> +		 * it will wait for interrupt - controllers checks IO
>> +		 * bus and when it detects NAND_CMD_STATUS on it, it
>> +		 * raises interrupt. After interrupt, NAND_CMD_READ0 is
>> +		 * sent as terminator of the ready waiting procedure if
>> +		 * needed (for all cases except page programming - this
>> +		 * is reason of 'need_cmd_read0' flag).
>> +		 */
>> +		return meson_nfc_wait_no_rb_pin(nfc, timeout_ms,
>> +						need_cmd_read0);
>> +	} else {
>> +		return meson_nfc_wait_rb_pin(nfc, timeout_ms);
>> +	}
>> +}
>> +
>>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>  {
>>  	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> @@ -623,7 +681,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>  	if (in) {
>>  		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
>> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
>> +		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), true);
>>  	} else {
>>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>>  	}
>> @@ -669,7 +727,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>  
>>  	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>> +	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), false);
>>  
>>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>  
>> @@ -952,7 +1010,8 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>  			break;
>>  
>>  		case NAND_OP_WAITRDY_INSTR:
>> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
>> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms,
>> +					   true);
>>  			if (instr->delay_ns)
>>  				meson_nfc_cmd_idle(nfc, delay_idle);
>>  			break;
>> @@ -1248,6 +1307,7 @@ meson_nfc_nand_chip_init(struct device *dev,
>>  	struct mtd_info *mtd;
>>  	int ret, i;
>>  	u32 tmp, nsels;
>> +	u32 nand_rb_val = 0;
>>  
>>  	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
>>  	if (!nsels || nsels > MAX_CE_NUM) {
>> @@ -1287,6 +1347,15 @@ meson_nfc_nand_chip_init(struct device *dev,
>>  	mtd->owner = THIS_MODULE;
>>  	mtd->dev.parent = dev;
>>  
>> +	ret = of_property_read_u32(np, "nand-rb", &nand_rb_val);
>> +	if (ret == -EINVAL)
>> +		nfc->no_rb_pin = true;
>> +	else if (ret)
>> +		return ret;
>> +
>> +	if (nand_rb_val)
>> +		return -EINVAL;
>> +
>>  	ret = nand_scan(nand, nsels);
>>  	if (ret)
>>  		return ret;
> 
> 
> Thanks,
> Miquèl
