Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A4686F96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBAUP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBAUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:15:55 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB266187F;
        Wed,  1 Feb 2023 12:15:52 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id B826F1257;
        Wed,  1 Feb 2023 21:15:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675282550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dw3R/I+yQHjbga5kkUsb3LzIPZtMRUNJ7Qu6UJsxVlc=;
        b=Ecugun7uzW1hw7a3z38sfJT+nhgz3Z1Q3neEokWdTu86aqzBtqesqoSFkhm3jA8Rvh/ftl
        5dwia8olYcp67iwQ8YxIp1DiTo79YKVtrDC/IbFp2h9Z1EJSj9rCMLJle1/ZFdy4rzNA4o
        6wMVHimniMcNaMjAI8i91cRTRD7Qm8Q/HrCDKcQykwB6dw4844dKiy5gjdzMjyQkT1GKWI
        V71hCZexWpugNzXH8n8/Flbbpberea0MN08Zviv0ywthtaAxBolNtlqtEGvBHgV+3i/3CI
        nGfoTZPsg0eikF19TNwkz1u+PsESr3ZCvjU6JidAD/Xoi//8ZbCBXFGHI3qnzA==
MIME-Version: 1.0
Date:   Wed, 01 Feb 2023 21:15:50 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO
 one
In-Reply-To: <20230201185402.GA4084724-robh@kernel.org>
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
 <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
 <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
 <20230201185402.GA4084724-robh@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1b3024876259eab4464db9ca676a884f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-02-01 19:54, schrieb Rob Herring:
> On Wed, Feb 01, 2023 at 11:46:01AM +0100, Michael Walle wrote:
>> > Before I convert brcm,nvram to NVMEM layout I need some binding & driver
>> > providing MMIO device access. How to handle that?
>> 
>> I'm not arguing against having the mmio nvmem driver. But I don't
>> think we should sacrifice possible write access with other drivers. 
>> And
>> I presume write access won't be possible with your generic driver as 
>> it
>> probably isn't just a memcpy_toio().
>> 
>> It is a great fallback for some nvmem peripherals which just maps a
>> memory region, but doesn't replace a proper driver for an nvmem 
>> device.
>> 
>> What bothers me the most isn't the driver change. The driver can be
>> resurrected once someone will do proper write access, but the generic
>> "mediatek,efuse" compatible together with the comment above the older
>> compatible string. These imply that you should use "mediatek,efuse",
>> but we don't know if all mediatek efuse peripherals will be the
>> same - esp. for writing which is usually more complex than the 
>> reading.
> 
> Because the kernel can't pick the "best" driver when there are multiple
> matches, it's all Mediatek platforms use the generic driver or all use
> the Mediatek driver.

Isn't that the whole point of having multiple compatible strings?
   compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
The OS might either load the driver for "fsl,imx21-mmc" or one for
"fsl,imx27-mmc", with the latter considered to be the preferred one.

> Personally, I think it is easy enough to revive the driver if needed
> unless writing is a soon and likely feature.

That what was actually triggered my initial reply. We are planning a
new board with a mediatek SoC and we'll likely need the write support.

But I thought the "mediatek,efuse" was a new compatible with this patch
and the (new!) comment make it looks like these compatible are 
deprecated
in favor of "mmio-nvmem". Which would make it impossible to distinguish
between the different efuse peripherals and thus make it impossible to
add write support.

> The other way to share is providing library functions for drivers to
> use. Then the Mediatek driver can use the generic read functions and
> custom write functions.
> 
>> nitpick btw: why not "nvmem-mmio"?
>> 
>> So it's either:
>>  (1) compatible = "mediatek,mt8173-efuse"
>>  (2) compatible = "mediatek,mt8173-efuse", "mmio-nvmem"
>> 
>> (1) will be supported any anyway for older dts and you need to add
>> the specific compatibles to the nvmem-mmio driver - or keep the
>> driver as is.
>> 
>> With (2) you wouldn't need to do that and the kernel can load the
>> proper driver if available or fall back to the nvmem-mmio one. I'd
>> even make that one "default y" so it will be available on future
>> kernels and boards can already make use of the nvmem device even
>> if there is no proper driver for them.
>> 
>> I'd prefer (2). Dunno what the dt maintainers agree.
> 
> No because you are changing the DT. The DT can't change when you want 
> to
> change drivers. This thinking is one reason why 'generic' bindings are
> rejected.

There is no change in the DT. Newer bindings will have

   compatible = "vendor,ip-block", "mmio-nvmem"

when the ip block is compatible with mmio-nvmem. Otherwise I don't get
why there is a mmio-nvmem compatible at all. Just having

   compatible = "mmio-nvmem"

looks wrong as it would just work correctly in some minor cases, i.e.
when write support is just a memcpy_toio() - or we deliberately ignore
any write support. But even then, you always tell people to add specific
compatibles for the case when quirks are needed..

-michael
