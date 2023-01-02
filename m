Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A250565B17A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjABLt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjABLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:48:56 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF32F18;
        Mon,  2 Jan 2023 03:48:53 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9C6CC1661;
        Mon,  2 Jan 2023 12:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672660128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZB9xNSjKSHWfa/0Wrk0B5Q8Ldv30xzUAM4GGiavhek=;
        b=GdDrEvrpX2g6ZBosVIBuPXzFEmP+DGE3t2MEYRL+D77UWkCO5gkLzzPnnZZUnqvQB0Wnvt
        ITWhkTF5ZlgdLOv5EHKZyDW5hcg0Cyrhl/WsMi6k1yK95MEJpaGA8xvDqsnWyj66GkQ4pY
        HmFBRrzJhQDtLKzaZYQWMkeA+poNYkOujYHSHb7gxBW4Y2UNguCY73/YIUAFC7ernct+hf
        mOAQxtSlbkW4bQllAT+nlbuQCZSdESHaQoME4rxRCBB2bJbJbSPnGGK34kE8DIfPN/aHDm
        6ScpVVlLKN74aGqXuLO05ji0nYEs6bMOiRFDg1PkDW9kvDTmmUqbC2zmJCQPSA==
MIME-Version: 1.0
Date:   Mon, 02 Jan 2023 12:48:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, tudor.ambarus@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/8] spi: dt-bindings: Introduce spi-cs-setup-ns property
In-Reply-To: <28da9e33-57e8-7ac1-7e6c-13c297a945d6@gmail.com>
References: <20221117105249.115649-2-tudor.ambarus@microchip.com>
 <20221118141458.954646-1-michael@walle.cc> <Y3elIdM3Xz1H4kKk@sirena.org.uk>
 <28da9e33-57e8-7ac1-7e6c-13c297a945d6@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a2f58ad34ba74ff135852bc1e24da4d6@walle.cc>
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

Hi,

Am 2023-01-02 10:37, schrieb Tudor Ambarus:
> Hi,
> 
> On 18.11.2022 17:30, Mark Brown wrote:
>> On Fri, Nov 18, 2022 at 03:14:58PM +0100, Michael Walle wrote:
>>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>> 
>>>> +  spi-cs-setup-ns:
>>>> +    description:
>>>> +      Delay in nanosecods to be introduced by the controller after 
>>>> CS is
>>>> +      asserted.
>> 
>>> Does this need a type as the spi-cs-setup-ns is apparently just 
>>> 16bit? At
>>> least the driver uses it that way.
>> 
>>> But IMHO this should just be a normal uint32 value to be consistent 
>>> with
>>> all the other properties. Also the max value with 16bit will be 
>>> 'just'
>>> 65us.
>> 
>> Making it 32 bit does seem safer.  I've applied the series
> 
> Thanks. There are few implications to consider before making this prop 
> a
> u32, and I'd like to check them with you.
> 
> struct spi_delay will have to be updated to have a u32 value, now it's 
> a
> u16. This means that we'll have to update spi_delay_to_ns() to either
> return a s64 or to add a u64 *delay parameter to the function so that 
> we
> can still handle the conversions from usecs and the error codes in the
> SPI_DELAY_UNIT_SCK case. Then all its callers have to be updated to
> consider the u64 delay.

I was talking about the device tree property. Even if the driver 
continue
to use just 16bit, the DT property could be 32bit IMHO.

At the moment, the schema says its 32bit (if I'm not mistaken, because
it doesn't have a type), but the driver will parse the property as
16bit and your device tree also has this /bits/ thingy. So regardless
if the driver is using 16bit or 32bit for the value, there seems to be
a discrepancy between the schema and the devicetree (and driver).

All other properties are just the regular 32bit values, thus I was
suggesting to change the DT property to 32bit.

-michael

> I don't know what to say, I'm in between. 65us delays are improbable,
> but I'm fine to update this as well. Let me know your preference.
> 
> Thanks,
> ta
