Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142A365B297
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjABNWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjABNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:22:02 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CAFB66;
        Mon,  2 Jan 2023 05:22:01 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D997D89;
        Mon,  2 Jan 2023 14:21:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672665719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFvEm4TS0m0oMTUcPbTdYrNtVbBi+eT7RCIgcBGxXUk=;
        b=Q/IU0tbBUb3lVx+NKUnYufg7JfbR6kQfbqGofZoUs3fLrhEke7TsnNoS+yi/Yw/ONaYMC0
        +Uhg+eP9/g+OHogid2o1V+cRdwce5mB0TTOrLf1f1XbuSffbZH9gMXajbTPDILPivYAfUf
        2wBnuNuDueeqfFcX7BCTRLJIpCbcbWXYFVwEAbWzOaVtB3CiTxACymLERTnACkFM9J/6eo
        nLxHYQ/xR5czBH0h8FipaWYKpc6pt0P7iBKXlqU2vEftiYYpidFsZuMcPdctpagFFkg054
        K5gjlBhwiKRvUnlCCRoO+J2tm8eHHXezVOwK/ooDZHMfI1EGk2drC5Rj7nZDxw==
MIME-Version: 1.0
Date:   Mon, 02 Jan 2023 14:21:59 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, tudor.ambarus@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
In-Reply-To: <1ee9cf77-1ca0-6e4e-ba7d-896838bd71de@linaro.org>
References: <20221117105249.115649-2-tudor.ambarus@microchip.com>
 <20221118141458.954646-1-michael@walle.cc> <Y3elIdM3Xz1H4kKk@sirena.org.uk>
 <28da9e33-57e8-7ac1-7e6c-13c297a945d6@gmail.com>
 <a2f58ad34ba74ff135852bc1e24da4d6@walle.cc>
 <1ee9cf77-1ca0-6e4e-ba7d-896838bd71de@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5ed88e3c3c105fdce1bb16ff16cde32f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> +  spi-cs-setup-ns:
>>>>>> +    description:
>>>>>> +      Delay in nanosecods to be introduced by the controller 
>>>>>> after CS is
>>>>>> +      asserted.
>>>> 
>>>>> Does this need a type as the spi-cs-setup-ns is apparently just 
>>>>> 16bit? At
>>>>> least the driver uses it that way.
>>>> 
>>>>> But IMHO this should just be a normal uint32 value to be consistent 
>>>>> with
>>>>> all the other properties. Also the max value with 16bit will be 
>>>>> 'just'
>>>>> 65us.
>>>> 
>>>> Making it 32 bit does seem safer.  I've applied the series
>>> 
>>> Thanks. There are few implications to consider before making this 
>>> prop a
>>> u32, and I'd like to check them with you.
>>> 
>>> struct spi_delay will have to be updated to have a u32 value, now 
>>> it's a
>>> u16. This means that we'll have to update spi_delay_to_ns() to either
>>> return a s64 or to add a u64 *delay parameter to the function so that 
>>> we
>>> can still handle the conversions from usecs and the error codes in 
>>> the
>>> SPI_DELAY_UNIT_SCK case. Then all its callers have to be updated to
>>> consider the u64 delay.
>> 
>> I was talking about the device tree property. Even if the driver 
>> continue
>> to use just 16bit, the DT property could be 32bit IMHO.
> 
> but then you'll have an implicit cast to u16 at:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c#n2314
> which will make the u32 dt prop misleading.

Nothing will prevent you from checking for a valid range and return an
error :)
But I agree, that converting the u16 to u32 in the driver is probably
the better way.

>> At the moment, the schema says its 32bit (if I'm not mistaken, because
>> it doesn't have a type), but the driver will parse the property as
>> 16bit and your device tree also has this /bits/ thingy. So regardless
>> if the driver is using 16bit or 32bit for the value, there seems to be
>> a discrepancy between the schema and the devicetree (and driver).
> 
> okay, thanks for pointing it out. Let's decide how we fix this.
> 
>> 
>> All other properties are just the regular 32bit values, thus I was
>> suggesting to change the DT property to 32bit.
> 
> If we want to change the dt prop to 32bit I think we should also handle
> the parsed value as u32, not as u16.

Strictly speaking, your device tree is wrong, because the schema
already says it's 32bit.

-michael
