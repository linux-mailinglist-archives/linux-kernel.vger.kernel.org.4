Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535C76B7031
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCMHjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:39:22 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74B38E9F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:39:20 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7677B5FD05;
        Mon, 13 Mar 2023 10:39:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678693158;
        bh=Pcu7cuLn4R4Of3LuVtm8P3SexQIJRH9aN9HH3u5OFk0=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
        b=fWBMWtOioo+TiLpuqJYfJ/N+fxST+P6JpJDxPcEJipb4Z2a1wp55Pyc4oQ0J/zDWz
         /xtxDlMWIVr2S+sS1kh0tKRZedr2vBFraS2u9Od7vtyPKR97zoPKKGjntchoPmJR3U
         GJbBPj7xxyXL9ur488jmD3VVYd2rLxMfKeXGzZ2HklGCUkmIE82cYVtptFSxsdZ5tE
         /FSk+hporaaT9EekpzaCrhUX76s8qxsCpz/1pRg37nmmleVded4qG3z63FWvDctaHi
         0lq155iaczSb3INdRxijtNOI2CwSAfKDoEMH8dzMDpfo9O/CUL3w4vDuoInnzVSwJO
         sB1SwGU/0DEaw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 13 Mar 2023 10:39:18 +0300 (MSK)
Message-ID: <20f7f1f8-e8f8-b3e1-251e-27db71ab6840@sberdevices.ru>
Date:   Mon, 13 Mar 2023 10:36:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1] mtd: rawnand: meson: invalidate cache on polling
 ECC bit
Content-Language: en-US
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
References: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
In-Reply-To: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/13 03:18:00 #20941028
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we reproduced this problem on one of our boards. It triggers very rare
when 'usleep_range()' is present, but when sleeping is removed - it fires
always. I suppose problem is with caching, as 'info_buf' memory is mapped by
'dma_map_single()'.

Thanks, Arseniy

On 13.03.2023 10:32, Arseniy Krasnov wrote:
> 'info_buf' memory is cached and driver polls ECC bit in it. This bit
> is set by the NAND controller. If 'usleep_range()' returns before device
> sets this bit, 'info_buf' will be cached and driver won't see update of
> this bit and will loop forever.
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 5ee01231ac4c..2c05c08a0eaf 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -176,6 +176,7 @@ struct meson_nfc {
>  
>  	dma_addr_t daddr;
>  	dma_addr_t iaddr;
> +	u32 info_bytes;
>  
>  	unsigned long assigned_cs;
>  };
> @@ -503,6 +504,7 @@ static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
>  					 nfc->daddr, datalen, dir);
>  			return ret;
>  		}
> +		nfc->info_bytes = infolen;
>  		cmd = GENCMDIADDRL(NFC_CMD_AIL, nfc->iaddr);
>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  
> @@ -520,8 +522,10 @@ static void meson_nfc_dma_buffer_release(struct nand_chip *nand,
>  	struct meson_nfc *nfc = nand_get_controller_data(nand);
>  
>  	dma_unmap_single(nfc->dev, nfc->daddr, datalen, dir);
> -	if (infolen)
> +	if (infolen) {
>  		dma_unmap_single(nfc->dev, nfc->iaddr, infolen, dir);
> +		nfc->info_bytes = 0;
> +	}
>  }
>  
>  static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
> @@ -710,6 +714,8 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>  		usleep_range(10, 15);
>  		/* info is updated by nfc dma engine*/
>  		smp_rmb();
> +		dma_sync_single_for_cpu(nfc->dev, nfc->iaddr, nfc->info_bytes,
> +					DMA_FROM_DEVICE);
>  		ret = *info & ECC_COMPLETE;
>  	} while (!ret);
>  }
