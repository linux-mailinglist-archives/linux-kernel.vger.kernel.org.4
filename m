Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5782F66BD3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjAPLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjAPLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:53:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681571ABED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:53:55 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pHO3d-0006DK-Kq; Mon, 16 Jan 2023 12:53:45 +0100
Message-ID: <0ac8e221-e88c-a05d-bc6f-9465783be866@pengutronix.de>
Date:   Mon, 16 Jan 2023 12:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the
 reset controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-2-0dd31b7de373@pengutronix.de>
 <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
 <12080bf5-2cc4-e215-555e-5438ed1bd851@pengutronix.de>
 <1b5613ad-6d0d-0979-ddd0-4677ade7beb9@linaro.org>
 <e492a90c-147c-a50b-80aa-86f47306cff0@pengutronix.de>
 <7cffc639-3b61-1479-115c-34dffdfd8cc9@linaro.org>
Content-Language: en-US
In-Reply-To: <7cffc639-3b61-1479-115c-34dffdfd8cc9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 16.01.23 11:15, Krzysztof Kozlowski wrote:
>>>> It's about syscon-reboot-mode, not syscon-reboot. Such modes are board-
>>>> not soc-specific. 
>>>
>>> syscon-reboot-mode is also mostly SoC specific. What exactly would
>>> differ on different boards? Register offsets of SoC component? Register
>>> values used by SoC power management unit?
>>
>> The modes supported. Let's say you want a bootloader mode that drops
>> the board's bootloader into a fastboot gadget mode. You'd add a
>> syscon-reboot-mode pointing at one of the non-volatile registers and
>> you would define a magic value to indicate fastboot, both in the
>> bootloader and Linux.
> 
> Bootloader and other firmware (e.g. ATF) is tightly tied to SoC, not to
> board. There might be differences between firmware used and OS (e.g.
> ChromeOS uses their own bootloader, different than Linux and Android on
> the same SoC), but again this is not board specific.

The bootloader probes from a board device tree and it also implements
initialization, update, boot and fallback logic specific to the board and
part of that is what reboot modes are supported. E.g. ST had particular
reboot modes in mind (e.g. reboot into eMMC as usb mass storage gadget),
but that's just a convention they chose for the platform, not something
inherent to the SoC.

>> In theory, the reboot mode could also talk to the bootrom[1] to change
>> the bootsource. This is also not board-agnostic, because it may not
>> make sense to have a spinor reboot mode if your board doesn't have one.
>>
>> We have this scheme for STM32MP1 already and that's why I suggested
>> Bastian to do it likewise for i.MX as he needs this functionality:
>> https://lore.kernel.org/all/20201021102855.18026-1-a.fatoum@pengutronix.de/
> 
> I don't understand why you use clearly wrong patches as examples. Bad
> patterns and bugs are not reason to use same approach.

I am trying to give you some context. It may be evident to you what's
so clearly wrong about them, but for me it worked and I am trying to
understand where you see a problem.

> The binding is wrong - you do not allow syscon-reboot-mode and if you
> ever tested your patches, you would see the errors.

I did indeed not dump the device tree after the bootloader fixed it up and
run into through the DT bindings checker. 

>> https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/stm32mp151.dtsi#L44
> 
> Whether this part is correct, tricky to say. Why these offsets are not
> valid for other board?

The offsets are valid, it may just not work. Also the user may choose to place
the reboot mode somewhere else within the syscon if the register is unused
otherwise.

Still we could probably add a reboot-mode child node to the device tree
with no extra modes and leave it disabled. That way boards can fill in the
modes they support, enable it and use it. Does this work for you?

Thanks,
Ahmad


> 
> 
> Best regards,
> Krzysztof
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

