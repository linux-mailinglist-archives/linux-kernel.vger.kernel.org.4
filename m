Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1358F70E330
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjEWRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjEWRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:33:15 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C601A7
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:32:48 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A7CAF5FD0E;
        Tue, 23 May 2023 20:31:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684863117;
        bh=H0dShj9ZDjo/qM96gvuxTIEKDSr9ga1R0nehMCt3V4Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=Zej3Ig1IoOl93IpqGJz3now4Xd46rc42PD5Wx1qtwdzL5HRKXJr8NQbLESiHNOOUb
         Sm9ukyTYOyMaUSrgPqNwJ28qqhGnwaXt/llkp6D+v/+X1zc474oUB96YZQgHYxT80i
         2AwMESZqomknJEqBilSqyh90T5MkOa3vAT+AT5nXzbJfBCVsu7hoFiS3NFkAxB2//i
         a5mdFtJBJtq+7oqdaq2rLPaMZLZ6YUPeiR/gosmvG8jTCYYUkSW++MzhJDMvvm0gVt
         RS4RAQ/lVQCupm6A81xvHJmRGqTaSFYHxfL4e+vQnHZ3iCCKnxiuu3OJ3qqMQvYL8N
         VnafpG39cht3g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 23 May 2023 20:31:57 +0300 (MSK)
Message-ID: <84a2e0c4-cc6f-1743-ee93-c13bc8bf09f1@sberdevices.ru>
Date:   Tue, 23 May 2023 20:27:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/5] mtd: rawnand: meson: always read whole OOB bytes
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
 <20230515094440.3552094-4-AVKrasnov@sberdevices.ru>
 <20230522173813.08afe6b8@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230522173813.08afe6b8@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 12:15:00 #21372692
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



On 22.05.2023 18:38, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:37 +0300:
> 
>> This changes size of read access to OOB area by reading all bytes of
>> OOB (free bytes + ECC engine bytes).
> 
> This is normally up to the user (user in your case == jffs2). The
> controller driver should expose a number of user accessible bytes and
> then when users want the OOB area, they should access it entirely. On
> top of that read, they can extract (or "write only") the user bytes.

Sorry, I didn't get it. If driver exposes N bytes of user accessible bytes,
I must always return whole OOB yes? E.g. N + rest of OOB

> 
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  drivers/mtd/nand/raw/meson_nand.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 8526a6b87720..a31106c943d7 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -755,6 +755,30 @@ static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
>>  	u32 oob_bytes;
>>  	u32 page_size;
>>  	int ret;
>> +	int i;
>> +
>> +	/* Read ECC codes and user bytes. */
>> +	for (i = 0; i < nand->ecc.steps; i++) {
>> +		u32 ecc_offs = nand->ecc.size * (i + 1) +
>> +			       NFC_OOB_PER_ECC(nand) * i;
>> +
>> +		ret = nand_read_page_op(nand, page, 0, NULL, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Use temporary buffer, because 'nand_change_read_column_op()'
>> +		 * seems work with some alignment, so we can't read data to
>> +		 * 'oob_buf' directly.
> 
> DMA?

Yes I guess, this address passed to exec_op code and used as DMA.

> 
>> +		 */
>> +		ret = nand_change_read_column_op(nand, ecc_offs, meson_chip->oob_buf,
>> +						 NFC_OOB_PER_ECC(nand), false);
>> +		if (ret)
>> +			return ret;
>> +
>> +		memcpy(oob_buf + i * NFC_OOB_PER_ECC(nand),
>> +		       meson_chip->oob_buf,
>> +		       NFC_OOB_PER_ECC(nand));
>> +	}
>>  
>>  	oob_bytes = meson_nfc_get_oob_bytes(nand);
>>  
> 
> 
> Thanks,
> Miquèl

Thanks, Arseniy
