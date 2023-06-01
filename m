Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236B87194F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjFAICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFAICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:02:39 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34B1B6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:02:30 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5FF405FD7D;
        Thu,  1 Jun 2023 11:02:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685606548;
        bh=05ZloG7zqiJsyOiLjkyE+HV8a6tzHOTec90OEL4emow=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=KDNV4hypqz71qUV2Y/CXm3QLm9UEOOv8THT7kz6pBYCHZybbd3RfHvBrtbcHfxRqF
         9Wa2wUZT7gGsXAZWafUJ0fsBQxaF83zJatnm2m541B/JHG3IjVBs69yqf/ZsBYks4V
         O/OmuL7WLdUtayXlXNZhFJwDswKCvffwrY3eQQeGKEMYa74MnwWuwyvsaR9G+r12a+
         zqZdKXA+ZkJjSllWFHwDl/Fp+xFl2vR939foySnaLr4kHGjXZCLTlJxPlhciU14SGB
         AJjSvu/cPgNU8LK0FWuXp6jdYJ/4KYRyBn5ibPFi0BLf3zbtZqDWvFjWxdzN9PGGJY
         mfSNqtBaV91Og==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 11:02:28 +0300 (MSK)
Message-ID: <439ff8b6-4282-08f7-46ef-425c0c009f09@sberdevices.ru>
Date:   Thu, 1 Jun 2023 10:57:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
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
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
 <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/01 03:13:00 #21393813
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



On 01.06.2023 09:18, Arseniy Krasnov wrote:
> This adds support of waiting for command completion in sofyware polling

                                                         ^^^ will fix it

> mode. It is needed when ready/busy pin is not implemented in hardware.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 53 ++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 9dd4a676497b..82a629025adc 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -179,6 +179,7 @@ struct meson_nfc {
>  	u32 info_bytes;
>  
>  	unsigned long assigned_cs;
> +	bool use_polling;
>  };
>  
>  enum {
> @@ -392,32 +393,38 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>  	}
>  }
>  
> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
>  {
> -	u32 cmd, cfg;
> -	int ret = 0;
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>  
> -	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> -	meson_nfc_drain_cmd(nfc);
> -	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +	if (nfc->use_polling) {
> +		return nand_soft_waitrdy(nand, timeout_ms);
> +	} else {
> +		u32 cmd, cfg;
> +		int ret = 0;
>  
> -	cfg = readl(nfc->reg_base + NFC_REG_CFG);
> -	cfg |= NFC_RB_IRQ_EN;
> -	writel(cfg, nfc->reg_base + NFC_REG_CFG);
> +		meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +		meson_nfc_drain_cmd(nfc);
> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>  
> -	reinit_completion(&nfc->completion);
> +		cfg = readl(nfc->reg_base + NFC_REG_CFG);
> +		cfg |= NFC_RB_IRQ_EN;
> +		writel(cfg, nfc->reg_base + NFC_REG_CFG);
>  
> -	/* use the max erase time as the maximum clock for waiting R/B */
> -	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
> -		| nfc->param.chip_select | nfc->timing.tbers_max;
> -	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +		reinit_completion(&nfc->completion);
>  
> -	ret = wait_for_completion_timeout(&nfc->completion,
> -					  msecs_to_jiffies(timeout_ms));
> -	if (ret == 0)
> -		ret = -1;
> +		/* use the max erase time as the maximum clock for waiting R/B */
> +		cmd = NFC_CMD_RB | NFC_CMD_RB_INT
> +			| nfc->param.chip_select | nfc->timing.tbers_max;
> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  
> -	return ret;
> +		ret = wait_for_completion_timeout(&nfc->completion,
> +						  msecs_to_jiffies(timeout_ms));
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +
> +		return 0;
> +	}
>  }
>  
>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
> @@ -623,7 +630,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>  	if (in) {
>  		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
> +		meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tR_max));
>  	} else {
>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>  	}
> @@ -669,7 +676,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>  
>  	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
> +	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
>  
>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>  
> @@ -952,7 +959,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
>  
>  		case NAND_OP_WAITRDY_INSTR:
> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
> +			meson_nfc_queue_rb(nand, instr->ctx.waitrdy.timeout_ms);
>  			if (instr->delay_ns)
>  				meson_nfc_cmd_idle(nfc, delay_idle);
>  			break;
> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	nfc->use_polling = of_property_read_bool(dev->of_node, "polling");
> +
>  	writel(0, nfc->reg_base + NFC_REG_CFG);
>  	ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
>  	if (ret) {
