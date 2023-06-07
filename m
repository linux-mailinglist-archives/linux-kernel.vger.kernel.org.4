Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216D9726960
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjFGTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFGTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:03:35 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BB1FDC;
        Wed,  7 Jun 2023 12:03:31 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 60FB15FD05;
        Wed,  7 Jun 2023 22:03:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686164608;
        bh=wt1HwINmc7U0q2LSsk2GPrtGj8yXHDwpkKdceOnG6Ao=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=FIy47jn+U+y0e9M9AW8GTjok9l0tt+7nIHy7lMrSPSp9TGaaWXUfB4RgF5HlvHdk7
         4AknVxtuGEWWUo78yxdctTIVBcQ+i/Qz43TBhw7QJg0/o6YkUtldpOn2nSOtf8/qak
         dcZ178suDSV4i5839U/WEXSut14reoOM4Qwm10tziH2vkSZ62GUz2Kp53nkPYX5dwV
         4Rk82+iW1cKFPaSrhcPUZs2wLd96ysoyWyNvqOX/WPwgIockh6Z0EO21SdB7oJOD/U
         TYrjKWCbvjgv0aHpXlDHlZA59Ns8DSjCiV2klkyit3UtYczH5YoFTiM8fsCrQ8Jnon
         2GIUFeLlkeogw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 22:03:26 +0300 (MSK)
Message-ID: <cb316711-7792-a4f6-9491-2529cfd5cba6@sberdevices.ru>
Date:   Wed, 7 Jun 2023 21:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 0/2] Meson NAND: waiting w/o wired ready/busy pin
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230607145026.2899547-1-AVKrasnov@sberdevices.ru>
 <a1e048aa-ec64-bd0b-aa17-e3e9bdf18090@sberdevices.ru>
 <bd2d1770-9856-d022-5e91-6a2cdc302b73@linaro.org>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <bd2d1770-9856-d022-5e91-6a2cdc302b73@linaro.org>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 13:30:00 #21453197
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



On 07.06.2023 21:48, Krzysztof Kozlowski wrote:
> On 07/06/2023 17:18, Arseniy Krasnov wrote:
>>
>>
>> On 07.06.2023 17:50, Arseniy Krasnov wrote:
>>> Main thing that this patchset adds is support for waiting for command
>>> completion when there is no wired ready/busy pin. This is implemented
>>> by using Meson specific command which operates without wired pin, but
>>> supports interrupt driven waiting (default way for waiting without
>>> hardware pin is 'nand_soft_waitrdy()' which uses software loop instead
>>> of interrupt). To select which mode to use during driver initialization,
>>> common NAND controller property is used - 'nand-rb'. It is described in
>>> 'nand-controller.yaml'. But for Meson, its description was missed in
>>> 'amlogic,meson-nand.yaml', so this patchset also adds support for it.
>>>
>>> Patch for bindings was tested with dt_binding_check and dtbs_check.
>>>
>>> Arseniy Krasnov (2):
>>>   dt-bindings: nand: meson: Fix 'nand-rb' property
>>>   mtd: rawnand: meson: waiting w/o wired ready/busy pin
>>>
>>>  .../bindings/mtd/amlogic,meson-nand.yaml      |  7 ++
>>>  drivers/mtd/nand/raw/meson_nand.c             | 82 ++++++++++++++++++-
>>>  2 files changed, 85 insertions(+), 4 deletions(-)
>>>
>>
>> Changelog:
>> * Two separate patches:
>>   For bindings: https://lore.kernel.org/linux-mtd/20230606193507.35024-1-AVKrasnov@sberdevices.ru/
>>   For driver: https://lore.kernel.org/linux-mtd/20230607073015.1280085-1-AVKrasnov@sberdevices.ru/
>>   Now fixed/updated and combined to this patchset with v1 version.
>>
>> * In binding patch:
>>   * Invalid type of 'nand-rb' is fixed, it was 'bool', now it is 'uint32 array' as required. Also
>>     new declaration of 'nand-rb' contains several restrictions like number of elements and min/max
>>     value of elements.
>>   * Location of 'nand-rb' is moved from the controller object to the chip object as required.
> 
> Version your patchsets. This is v2, not v1.

Ack, next will be v3

Thanks, Arseniy

> 
> Best regards,
> Krzysztof
> 
