Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167CF715816
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjE3IN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjE3INz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:13:55 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F30D9D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:13:51 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id AFA065FD1D;
        Tue, 30 May 2023 11:13:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685434428;
        bh=MFEWIxYnC181XBgiG50LZAhwCaHLPl/kqKrPyecHE1I=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=JEk6ebn38b9Q6RBpaFJWRp8oVsTENXxa1tDoQOHw+ZB0gnaYBivfELHFolDn1OU8W
         7/DK9/PnEwMtf5TPeIAZUHsyYDfVQe4SNAztgcPSmU+/MyiZmpbOiBHuMyHE3TTn9n
         zh0CjeXvKAb+3lto2GLi2+2FtFPWS+YGShPjyQ8yMby8y7KRwYbydnWzg5kKiWy7Fg
         wlYqs868xlWRjfc8T4E+FyHelt0ZZH0OpTUdWY1xy+Md2NhzVbhkAcDAubwFIwPs6L
         t3RHc5mwcLMcFDru2ULNtaFP1q96eh6IxRsVLd20dZmFCY/MhbHnChgYpR5NG7K0rl
         +jUcDXzx3YlVA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 30 May 2023 11:13:46 +0300 (MSK)
Message-ID: <1f4c90c4-e436-c53f-bb6f-416db374ae52@sberdevices.ru>
Date:   Tue, 30 May 2023 11:09:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/5] mtd: rawnand: meson: move OOB to non-protected ECC
 area
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
 <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
 <20230522173334.7aa6f917@xps-13>
 <ebbc26e3-6a1c-eead-051c-8f93beba41f3@sberdevices.ru>
 <20230526190347.6e34a2be@xps-13>
 <b9f0a38a-0d50-23f0-4509-c38362d05f12@sberdevices.ru>
 <20230530094420.06281ab5@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230530094420.06281ab5@xps-13>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/30 04:52:00 #21374971
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

Hi Miquel,

On 30.05.2023 10:44, Miquel Raynal wrote:
> Hi Arseniy,
> 
>>>>>> -static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>>>>> -{
>>>>>> -	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>> -	__le64 *info;
>>>>>> -	int i, count;
>>>>>> +	int i;
>>>>>>  
>>>>>> -	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
>>>>>> +	for (i = 0; i < nand->ecc.steps; i++) {
>>>>>>  		info = &meson_chip->info_buf[i];
>>>>>> -		oob_buf[count] = *info;
>>>>>> -		oob_buf[count + 1] = *info >> 8;
>>>>>> +		/* Always ignore user bytes programming. */    
>>>>>
>>>>> Why?    
>>>>
>>>> I think comment message is wrong a little bit. Here "user bytes" are
>>>> user bytes protected by ECC (e.g. location of these bytes differs from new
>>>> OOB layout introduced by this patch). During page write this hardware
>>>> always writes these bytes along with data. But, new OOB layout always ignores
>>>> these 4 bytes, so set them to 0xFF always.  
>>>
>>> When performing page reads/writes, you need to take the data as it's
>>> been provided. You may move the data around in the buffer provided to
>>> the controller, so that it get the ECC data at the right location, and
>>> you need of course to reorganize the data when reading as well, so that
>>> the user sees XkiB of data + YB of OOB. That's all you need to do in
>>> these helpers.
>>>   
>>
>> I think there is some misunderstanding about these "user bytes" above: there are 4
>> bytes which this NAND controller always writes to page in ECC mode - it was free OOB
>> bytes covered by ECC. Controller grabs values from DMA buffer (second DMA buffer which
>> doesn't contains page data) and writes it along with data and ECC codes. Idea of this
>> change is to always suppress this write by setting them to 0xFF (may be there is some
>> command option to not write it, but I don't have doc), because all of them (4 bytes)
>> become unavailable to reader/writer.
> 
> At the NAND controller level, I would rather avoid doing things like
> that.
> 
> I believe you can just update the ooblayout so that protected OOB bytes
> are not exposed to the user as free bytes. Then your buffers should
> already contain 0xffffff at the problematic location.

So Your idea is to continue fill DMA buffer (for these 4 bytes) from provided OOB buffer,
relying on that as these bytes are unused, they will be 0xFF in OOB buffer so we get the same result?

Thanks, Arseniy

> 
> Thanks,
> Miquèl
