Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C163A34D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiK1InJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiK1InH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:43:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB151144F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:43:06 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1ozZjB-0008M9-90; Mon, 28 Nov 2022 09:43:01 +0100
Message-ID: <a13c2e92-cfa6-04fd-c32a-c4d444894660@pengutronix.de>
Date:   Mon, 28 Nov 2022 09:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabre: Add mmc aliases
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20221028141811.101122-1-detlev.casanova@collabora.com>
 <20221111025232.GI125525@dragon> <2868543.tdWV9SEqCh@falcon9>
Content-Language: en-US
In-Reply-To: <2868543.tdWV9SEqCh@falcon9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Detlev,
Hello Shawn,

On 11.11.22 20:35, Detlev Casanova wrote:
> On Thursday, November 10, 2022 9:52:32 P.M. EST Shawn Guo wrote:
>> On Fri, Oct 28, 2022 at 10:18:11AM -0400, Detlev Casanova wrote:
>>> If not specified, the mmc0 and mmc1 devices will be the devices
>>> mmc@2190000 and mmc@2194000, which are in disabled state on the iMX.6
>>> Sabrelite devices.
>>>
>>> The actual SD card reader devices are the ones at mmc@2198000 and
>>> mmc@219c000.
>>>
>>> Set aliases to use the correct mmc devices order.
>>
>> Is this something never worked or a regression?  For the latter, we may
>> need a Fixes tag?
> 
> These were apparently never set in the kernel device-tree and added manually 
> in u-boot when dts are synced.
> 
> Because most distributions use UUIDs in fstab, it is not a big problem in 
> Linux, just that the SD card is called /dev/mmcblk2. I would say that this has 
> always been an issue in Linux.

We already have aliases in imx6qdl.dtsi. Existing Installations that hardcode
root=mmcblk2 _will_ be broken by this change. Installations that are fixed
by this change have never worked properly, because prior to commit fa2d0aa96941
("mmc: core: Allow setting slot index via device tree alias"), it depended
on probe order and/or whether a card was present.

Whether SD/eMMC comes first or if they start at 0 or 2 is just cosmetic.
The alias order corresponds with the order in the data sheet and that's a
good default and I see no reason to change this here and risk breakage.

I thus don't think this patch should go mainline.

Thanks,
Ahmad

> 
>> Shawn
>>
>>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>>> ---
>>>
>>>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
>>> b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi index
>>> 22f8e2783cdf..12573e1f917c 100644
>>> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
>>> @@ -14,6 +14,11 @@ chosen {
>>>
>>>  		stdout-path = &uart2;
>>>  	
>>>  	};
>>>
>>> +	aliases {
>>> +		mmc0 = &usdhc3;
>>> +		mmc1 = &usdhc4;
>>> +	};
>>> +
>>>
>>>  	memory@10000000 {
>>>  	
>>>  		device_type = "memory";
>>>  		reg = <0x10000000 0x40000000>;
> 
> 
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

