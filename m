Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5748714FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjE2Tvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2Tvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:51:39 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C30E0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:51:37 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5F1165FD1A;
        Mon, 29 May 2023 22:51:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685389895;
        bh=3d6U0HghAzN5LgdrsysRgTv1ZTeSOPS8yDHMndRcRb4=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=fYlo62nD/OyjWWBooBcikbstYg73KtRuFpPjLKl+qfAJ32gGYj+WrVzW94ZKb50Vj
         2Rom3xRokEEIqTXMjrfhGTjGZkBqTzrACtHRenVortQbYxYw0ch/5kqn1x6WrVxf8f
         GZ8OchM8DbMsZP1fLbdVjB+2tG3BG0FKA6287E+dEKwjnwweppRHs5kuXWSMagp+8v
         2PB6S+MpewAwOpLqsB/0hipOi0fdmN6ZL4EA5EnLdCHEnYOfO6cb8VPV0iOjCGTTzs
         Aam3MMlutg4PkEnOfjK/ajHYeUEPiDGZyznmoHYNxGi0pVK2fbkuHkKlz/oiNljgmD
         z2aU8RjZC0cJg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 29 May 2023 22:51:35 +0300 (MSK)
Message-ID: <ae791be4-1c44-240d-2559-37523b654506@sberdevices.ru>
Date:   Mon, 29 May 2023 22:46:59 +0300
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
 <84a2e0c4-cc6f-1743-ee93-c13bc8bf09f1@sberdevices.ru>
 <20230526190905.1d5a3821@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230526190905.1d5a3821@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/29 07:59:00 #21367693
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



On 26.05.2023 20:09, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Tue, 23 May 2023 20:27:35 +0300:
> 
>> On 22.05.2023 18:38, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:37 +0300:
>>>   
>>>> This changes size of read access to OOB area by reading all bytes of
>>>> OOB (free bytes + ECC engine bytes).  
>>>
>>> This is normally up to the user (user in your case == jffs2). The
>>> controller driver should expose a number of user accessible bytes and
>>> then when users want the OOB area, they should access it entirely. On
>>> top of that read, they can extract (or "write only") the user bytes.  
>>
>> Sorry, I didn't get it. If driver exposes N bytes of user accessible bytes,
>> I must always return whole OOB yes? E.g. N + rest of OOB
> 
> Yes. At the NAND controller level, you get asked for either a page of
> data (sometimes a subpage, but whatever), and/or the oob area. You need
> to provide what is requested, no more, no less. The upper layers will
> trim down what's uneeded and extract the bytes they want.

I see, so in this case I think this patch could be merged to the patch which
changes OOB layout be moving it out of ECC area? Because driver MUST return all
bytes of OOB area.

> 
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>>  drivers/mtd/nand/raw/meson_nand.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index 8526a6b87720..a31106c943d7 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -755,6 +755,30 @@ static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
>>>>  	u32 oob_bytes;
>>>>  	u32 page_size;
>>>>  	int ret;
>>>> +	int i;
>>>> +
>>>> +	/* Read ECC codes and user bytes. */
>>>> +	for (i = 0; i < nand->ecc.steps; i++) {
>>>> +		u32 ecc_offs = nand->ecc.size * (i + 1) +
>>>> +			       NFC_OOB_PER_ECC(nand) * i;
>>>> +
>>>> +		ret = nand_read_page_op(nand, page, 0, NULL, 0);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		/* Use temporary buffer, because 'nand_change_read_column_op()'
>>>> +		 * seems work with some alignment, so we can't read data to
>>>> +		 * 'oob_buf' directly.  
>>>
>>> DMA?  
>>
>> Yes I guess, this address passed to exec_op code and used as DMA.
> 
> If your controller uses DMA on exec_op accesses, then yes. Exec_op
> reads/writes are usually small enough (or not time sensitive at all if
> they are bigger) so it's not required to use DMA there. Anyhow, oob_buf
> is suitable for DMA purposes, so I'm a bit surprised you need a bounce
> buffer, if that's the only reason. Maybe you need a bounce buffer to
> reorganize the data. That would be a much better explanation.

Yes! I remove this temporary buffer, seems my mistake! Without it everything works
good, I'll remove it from the next version!

Thanks, Arseniy

> 
>>>> +		 */
>>>> +		ret = nand_change_read_column_op(nand, ecc_offs, meson_chip->oob_buf,
>>>> +						 NFC_OOB_PER_ECC(nand), false);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		memcpy(oob_buf + i * NFC_OOB_PER_ECC(nand),
>>>> +		       meson_chip->oob_buf,
>>>> +		       NFC_OOB_PER_ECC(nand));
>>>> +	}
>>>>  
>>>>  	oob_bytes = meson_nfc_get_oob_bytes(nand);
>>>>    
>>>
>>>
>>> Thanks,
>>> Miquèl  
>>
>> Thanks, Arseniy
> 
> 
> Thanks,
> Miquèl
