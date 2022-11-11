Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4555625665
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiKKJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiKKJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:16:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB745C18;
        Fri, 11 Nov 2022 01:16:44 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DB096602A31;
        Fri, 11 Nov 2022 09:16:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668158203;
        bh=fXz2EtPdQdEQa/qt3zwi6Zf4WPBPrjSTTzWiSWHTcog=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FF0bQLOoX5nlH1pJjV8fEtkatoNtjST5s4M41J/AsMLQxTUfz4Rd9DhyCAkW3aX36
         CQbIPTlzLLDFPJuA2FwyZmOLtMC6o3dMpCJm4HG2NgSj/LbPtXOptgpDjXE4EFW2ZF
         llYG/TnRZMroIxLKfDTmiwQSl/UU572f4haQKcEK4IKrh8mlFxDRaA7tKPAaHiJMX/
         6pwUIFQI6Sfuq9+0TVPmhyvowPYqj52LqdWbq7AJBv5q9UCqAf4Nkeij5ttpUxWZKh
         Kv+XhKqj0A99KFarguf11OTmnBxGMvdNFRoxnxl6a7djWoWf+Bm8fEGu/HcAU/Hi+J
         QC8Kwo1DLqqog==
Message-ID: <34de22c0-1773-10b4-c3fd-387fd311ac11@collabora.com>
Date:   Fri, 11 Nov 2022 10:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Content-Language: en-US
To:     =?UTF-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
 <20221103052843.2025-2-bayi.cheng@mediatek.com>
 <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
 <c612cc0eb4fc463a9bfd9094ff652ac9@AcuMS.aculab.com>
 <617c0b563a2602668fde7d96e1bc98648870d30c.camel@mediatek.com>
 <794a0249500bf90a79f30a3522108e721fe06e17.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <794a0249500bf90a79f30a3522108e721fe06e17.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/11/22 05:16, Bayi Cheng (程八意) ha scritto:
> On Fri, 2022-11-04 at 07:53 +0000, Bayi Cheng (程八意) wrote:
>> On Thu, 2022-11-03 at 22:35 +0000, David Laight wrote:
>>> From: AngeloGioacchino Del Regno
>>>> Sent: 03 November 2022 09:44
>>>>
>>>> Il 03/11/22 06:28, Bayi Cheng ha scritto:
>>>>> From: bayi cheng <bayi.cheng@mediatek.com>
>>>>>
>>>>> The timeout value of the current dma read is unreasonable. For
>>>>> example,
>>>>> If the spi flash clock is 26Mhz, It will takes about 1.3ms to
>>>>> read a
>>>>> 4KB data in spi mode. But the actual measurement exceeds 50s
>>>>> when
>>>>> a
>>>>> dma read timeout is encountered.
>>>>>
>>>>> In order to be more accurately, It is necessary to use
>>>>> msecs_to_jiffies,
>>>>> After modification, the measured timeout value is about 130ms.
>>>>>
>>>>> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
>>>>> ---
>>>>>    drivers/spi/spi-mtk-nor.c | 7 ++++---
>>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-
>>>>> nor.c
>>>>> index d167699a1a96..3d989db80ee9 100644
>>>>> --- a/drivers/spi/spi-mtk-nor.c
>>>>> +++ b/drivers/spi/spi-mtk-nor.c
>>>>> @@ -354,7 +354,7 @@ static int mtk_nor_dma_exec(struct mtk_nor
>>>>> *sp, u32 from, unsigned int length,
>>>>>    			    dma_addr_t dma_addr)
>>>>>    {
>>>>>    	int ret = 0;
>>>>> -	ulong delay;
>>>>> +	ulong delay, timeout;
>>>>>    	u32 reg;
>>>>>
>>>>>    	writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
>>>>> @@ -376,15 +376,16 @@ static int mtk_nor_dma_exec(struct
>>>>> mtk_nor
>>>>> *sp, u32 from, unsigned int length,
>>>>>    	mtk_nor_rmw(sp, MTK_NOR_REG_DMA_CTL, MTK_NOR_DMA_START,
>>>>> 0);
>>>>>
>>>>>    	delay = CLK_TO_US(sp, (length + 5) * BITS_PER_BYTE);
>>>>> +	timeout = (delay + 1) * 100;
>>>>>
>>>>>    	if (sp->has_irq) {
>>>>>    		if (!wait_for_completion_timeout(&sp->op_done,
>>>>> -						 (delay + 1) *
>>>>> 100))
>>>>> +		    msecs_to_jiffies(max_t(size_t, timeout /
>>>>> 1000,
>>>>> 10))))
>>>>
>>>> You're giving a `size_t` variable to msecs_to_jiffies(), but
>>>> checking `jiffies.h`,
>>>> this function takes a `const unsigned int` param.
>>>> Please change the type to match that.
>>>
>>> The type shouldn't matter at all.
>>> What matters is the domain of the value.
>>>
>>> Quite why you need to use max_t(size_t, ...) is another matter.
>>> timeout is ulong so max(timeout/1000, 10ul) should be fine.
>>>
>>> But is ulong even right?
>>> The domain of the value is almost certainly the same on 32bit and
>>> 64bit.
>>> So you almost certainly need u32 or u64.
>>>
>>> 	David
>>>
>>
>> Hi David & Angelo
>>
>> Thank you for your comments!
>> To sum up, I think the next version will make the following two
>> changes:
>> 1, The timeout value will not exceed u32, so the type of timeout will
>> be changed from ulong to u32.
>> 2, Change msecs_to_jiffies(max_t(size_t, timeout / 1000, 10)) to be
>> msecs_to_jiffies(max(timeout / 1000, 10U)).
>>
>> If you think these changes are not enough, please let me know,
>> Thanks！
>>
>> Best Regards,
>> Bayi
>>
> 
> Hi Angelo, Hi David,
> 
> Just a gentle ping on this.
> Could you please review this patch and give us some suggestion?
> 
> PS: With your permission, I will make the following changes in the next
> version:
> 
> Change in v2:
>    -Change the type of "timeout" from ulong to u32.
>    -Replace max_t with max.
> 

I still recommend to use usecs_to_jiffies() when appropriate, instead of
converting usecs to msecs and using msecs_to_jiffies().

As for the rest in your list: yes, please.

Regards,
Angelo

> 
> Thanks.
> 
> BRs,
> Bayi Cheng
> 
>>>>
>>>> Aside from that, your `timeout` variable contains a timeout in
>>>> microseconds and
>>>> this means that actually using msecs_to_jiffies() is suboptimal
>>>> here.
>>>>
>>>> Please use usecs_to_jiffies() instead.
>>>>
>>>> Regards,
>>>> Angelo
>>>
>>> -
>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton
>>> Keynes,
>>> MK1 1PT, UK
>>> Registration No: 1397386 (Wales)

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

