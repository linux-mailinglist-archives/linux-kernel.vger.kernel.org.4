Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9790766B90A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjAPI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjAPI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:27:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2273612056
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:27:48 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pHKq7-00077u-R8; Mon, 16 Jan 2023 09:27:35 +0100
Message-ID: <12080bf5-2cc4-e215-555e-5438ed1bd851@pengutronix.de>
Date:   Mon, 16 Jan 2023 09:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the
 reset controller
Content-Language: en-US
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
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 16.01.23 09:20, Krzysztof Kozlowski wrote:
> On 13/01/2023 18:32, Bastian Krause wrote:
>> The actual syscon-reboot-mode child node can be added by a board
>> device-tree or fixed up by the bootloader. For the child node to be
>> probed, the compatible needs to include simple-mfd. The binding now
>> specifies this, so have the SoC dtsi adhere to it.
>>
>> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> Signed-off-by: Bastian Krause <bst@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index ff1e0173b39be..b16be39458aa6 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -865,7 +865,8 @@ epit2: epit@20d4000 { /* EPIT2 */
>>  			};
>>  
>>  			src: reset-controller@20d8000 {
>> -				compatible = "fsl,imx6q-src", "fsl,imx51-src";
>> +				compatible = "fsl,imx6q-src", "fsl,imx51-src",
>> +					     "syscon", "simple-mfd";
> 
> You need children here. Otherwise simple-mfd does not make sense. If you
> expect something else to add children (I don't understand why, usually
> reboot capability is fixed per SoC and only sometimes extended with some
> other means), then this "else" will also change compatible.

It's about syscon-reboot-mode, not syscon-reboot. Such modes are board-
not soc-specific. Yes, a board DTS can override a compatible, but this
is error prone as you can't just add a compatible, you need to hardcode
the other compatibles in the SoC dtsi, which may change for good reason
in future. barebox supports fixing up syscon-reboot-mode nodes defined
in its own device tree to the Linux DT. While in theory, it could check
if the parent node contains syscon/simple-mfd and fix it up if necessary,
it sounds to me like this should be rather part of the upstream DT.

Cheers,
Ahmad

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

