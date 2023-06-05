Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE871721E79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjFEGpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjFEGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:44:56 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F6D3;
        Sun,  4 Jun 2023 23:44:34 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id F39885FD15;
        Mon,  5 Jun 2023 09:44:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685947471;
        bh=a3TTZqZescYVkmvQpRp/TvBnNAhNz1UEIZ0m5Ewqc2k=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=Ag0KQMZn10/9B82BPaqBC2nMj8aP+RDgZh7DcUUb9XsCNl+0zeeSmLUgmi+aFBoPL
         XWXOM7SMGy+3CS68dAcXnQn9e9OtBoH04sYduBARpYXcjYqbAd29yKP55OoheNyivj
         9NpvQ08gngec9yh2Kj3U9F6gUaIsE7Y2qMEevMJW26ZR1GDvZNSRl2U980lsvC+WZx
         dgzHFZWfJBJlrEul/7Ezu47ZwfTCryxr7qYujJ9kvlwrlDew6gVMkoW/f9lbhBw0qk
         TRCU1BPq9gAeqjVxU3akP7IwdBXApNOywV7NyXQoavulDl0qcNsl2o4du37i4VHFBS
         gbqVYlycdBUiw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  5 Jun 2023 09:44:30 +0300 (MSK)
Message-ID: <19f809ab-218e-8da5-6d5e-ac47902fa706@sberdevices.ru>
Date:   Mon, 5 Jun 2023 09:39:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix ready/busy command
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <stable@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
References: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/05 04:52:00 #21434197
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

Hello Miquel!

I exclude this patch from the recent Meson patchset, as it is fix and not related to another patches.
Also I think that I can split Meson patchset (from links below) in the following way:
1) Patch/patchset for OOB layout
2) Patchset for "nand-rb" logic (meson_nand.c + DT bindings)
These two can also go independently:
3) https://lore.kernel.org/linux-mtd/20230601061850.3907800-6-AVKrasnov@sberdevices.ru/
4) https://lore.kernel.org/linux-mtd/20230601061850.3907800-7-AVKrasnov@sberdevices.ru/

What do You think?

Thanks, Arseniy

On 05.06.2023 09:10, Arseniy Krasnov wrote:
> Fix the ready/busy command value.
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Cc: stable@vger.kernel.org
> Suggested-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 074e14225c06..9dd4a676497b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -37,7 +37,7 @@
>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>  #define NFC_CMD_SHORTMODE_DISABLE	0
> -#define NFC_CMD_RB_INT		BIT(14)
> +#define NFC_CMD_RB_INT		((0xb << 10) | BIT(18) | BIT(16))
>  
>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
>  
