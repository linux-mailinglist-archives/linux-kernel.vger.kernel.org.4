Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16C0747FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGEIbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:31:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC341A2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:31:01 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qGxuX-0008CU-Mg; Wed, 05 Jul 2023 10:30:53 +0200
Message-ID: <14cd16df-ef47-05b3-5266-ffff109a8326@pengutronix.de>
Date:   Wed, 5 Jul 2023 10:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] ARM: dts: imx6: pfla02: Fix SD card reboot problem
Content-Language: en-US
To:     Andrej Picej <andrej.picej@norik.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     devicetree@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        upstream@phytec.de
References: <20230704080304.816942-1-andrej.picej@norik.com>
 <20230704080304.816942-3-andrej.picej@norik.com>
 <20230704081712.7dyj2mspj2m25rp7@pengutronix.de>
 <7ed6fde0-37a4-a667-2629-0a6b8a202a69@norik.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <7ed6fde0-37a4-a667-2629-0a6b8a202a69@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.23 10:28, Andrej Picej wrote:
> Hi Marco,
> 
> On 4. 07. 23 10:17, Marco Felsch wrote:
>> On 23-07-04, Andrej Picej wrote:
>>> If regulator is not marked as always-on the regulator gets disabled on
>>> reboot breaking the next boot.
>>>
>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>> ---
>>>   arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>>> index 80adb2a02cc9..25d6a036d5b8 100644
>>> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>>> @@ -192,6 +192,7 @@ vdd_3v3_pmic_io_reg: ldo6 {
>>>               vdd_sd0_reg: ldo9 {
>>>                   regulator-min-microvolt = <3300000>;
>>>                   regulator-max-microvolt = <3300000>;
>>> +                regulator-always-on;
>>
>> I think this is the supply for the sd-card, so you can make use of
>> 'vmmc-supply'.
> 
> This is already the case:
> 
>> &usdhc3 {
>>     pinctrl-names = "default";
>>     pinctrl-0 = <&pinctrl_usdhc3
>>              &pinctrl_usdhc3_cdwp>;
>>     cd-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
>>     wp-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
>>     vmmc-supply = <&vdd_sd0_reg>;
>>     status = "disabled";
>> };
> 
> I think the main reason for a failed boot is that the PMIC doesn't get reset and that the bootloader doesn't specifically enable the SD card regulator.
> 
> Could this patch still be applied or should we put the fix in reset routine/bootloader?

Is SD-Card not main boot medium? From your description, I thought BootROM
will fail to boot before bootloader has a chance to do anything about it.

> 
> Best regards,
> Andrej
> 
>>
>> Regards,
>>    Marco
>>
>>>               };
>>>                 vdd_sd1_reg: ldo10 {
>>> -- 
>>> 2.25.1
>>>
>>>
>>>
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

