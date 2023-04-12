Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477B6DF1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDLKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDLKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:14:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07052D73
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:14:55 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6548A5FD61;
        Wed, 12 Apr 2023 13:14:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681294493;
        bh=syojLji4UO4OZzZa1DKzyOBdJQxEr9LBga4/LUwWp54=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=AsqjhC+ZuNZF9s+691wOoLc2Ms9TdXBrCtbe1z3r4DU9424pHzoR9EJ2vyD5qeyFx
         RoQtdP+XZlG/xPwgS3vDuneYvqbm+oFCjJ3aY6UNR2PWIPOcU9Z1qdAkNIonADo4GF
         xi7bBozi1jcO7BN7A/40SZWL5JAWYhFHEKxuecS9RGlEnzBDPZHpx3/bEffxxntC+3
         g0oqkt35UShx9ksK7X6MPA8a7e+9OfYn0W5F384QzCjQl6w4jCbh5MW8iicWtvNCf2
         mFnVp9gVquC6FHYDIqXDc2puNdX5zy2cgWTwsdLl9NLvdXi6FR6aueXFsDBLcuqYUh
         o4RjCPQ87yiUQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 12 Apr 2023 13:14:52 +0300 (MSK)
Message-ID: <8f8d4a22-11ea-3b30-9b95-f27c5209fe5f@sberdevices.ru>
Date:   Wed, 12 Apr 2023 13:11:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 2/5] mtd: rawnand: meson: replace GENMASK() macro with
 define
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
        "kernel@sberdevices.ru" <kernel@sberdevices.ru>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-3-AVKrasnov@sberdevices.ru>
 <2f89000bdbbb4e2bb7f1dd96c1b498f9@AcuMS.aculab.com>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <2f89000bdbbb4e2bb7f1dd96c1b498f9@AcuMS.aculab.com>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/12 04:12:00 #21090163
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 13:06, David Laight wrote:
> From: Arseniy Krasnov
>> Sent: 12 April 2023 07:17
>> Subject: [PATCH v1 2/5] mtd: rawnand: meson: replace GENMASK() macro with define
>>
> ...
>>  		len = mtd->writesize + mtd->oobsize;
>> -		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>> +		cmd = (len & NFC_CMD_RAW_LEN) | scrambler | DMA_DIR(dir);
>>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> 
> What is the point of the mask?
> If the length is too big it just generates a different
> 'hard to debug' error.
> If the length can't be too bit there is no point masking it.

Exactly, thanks for pointing!

Thanks, Arseniy

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
