Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2876CC744
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjC1P7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjC1P7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:59:47 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08DF187
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:59:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B5DBB5FD14;
        Tue, 28 Mar 2023 18:59:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680019181;
        bh=+9QzWAPZdJiLUFjtZdhRNkgT3cxt2ae3HLNCpRJ9kPU=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
        b=PwgMmjo/Kxzg/W6eWz0KRU0W4mpnwLI0b2PGpnnEHBendI5jN+SPPADZbqqLV6euH
         ODQIzsGZOr4FywYx22t44lrXwORZSrVAnhznj8BlSlHtvlvU3l0UTZpU/jFgJMtymK
         /aV2tVjrcNWOdy7PmlSZ0OXpohPZ0cLuNnWbpl2MX+YdNLhH+rWfpVB+MLnf/28Rwp
         9Bkr8/nD29zsgiPZgEDYFr8dUvoXOjWiaY2T1bUnJHO7G3oh55KWzgA3kGk4QwZN6U
         VE3a6Rq98oPpBFqZ89orGrucuBj8ixwkMLXkruYhGlFVCnqvpd47E1W9kKnLOWLcST
         xpUmrL6S9Xi5w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 28 Mar 2023 18:59:40 +0300 (MSK)
Message-ID: <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
Date:   Tue, 28 Mar 2023 18:56:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Language: en-US
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
 <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
 <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
In-Reply-To: <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/28 12:08:00 #21021610
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

@Miquel Raynal, what is the status of this patch?

Thanks, Arseniy

On 23.03.2023 10:57, Arseniy Krasnov wrote:
> 
> 
> On 22.03.2023 23:10, Martin Blumenstingl wrote:
>> Hello Arseniy,
>>
>> thank you for submitting this fix!
> Thanks!
>>
>> On Wed, Mar 22, 2023 at 7:45 PM Arseniy Krasnov
>> <avkrasnov@sberdevices.ru> wrote:
>>>
>>> Valid mask is 0x3FFF, without this patch the following problems were
>>> found:
>>>
>>> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
>>>                   bit-wise majority to recover it
>>>    [    0.947384] ONFI parameter recovery failed, aborting
>>>
>>> 2) Read with disabled ECC mode was broken.
>>>
>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> This matches what I can see in the old vendor driver, so:
> Moreover it was clear that mask of 0x3f is too small for length of data in
> bytes, for example for 2048 + OOB size.
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> [...]
>>> -               cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
>>> +               cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>> My understanding of the vendor driver is that this "len" is only used
>> for "raw" access (my own words: any access that doesn't use the HW ECC
>> engine).
> Exactly, 'len' is only for raw access.
>> As a future improvement (no need to update re-send this patch) it
>> would be great to have a #define with a meaningful name for
>> "GENMASK(13, 0)" (maybe something like NFC_CMD_RAW_LENGTH) as it's
>> used in multiple places now
> Ack
> 
> Thanks, Arseniy
>>
>>
>> Best regards,
>> Martin
