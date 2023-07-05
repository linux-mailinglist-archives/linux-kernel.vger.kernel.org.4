Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C1747FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGEI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGEI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:27:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818E1720
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:27:04 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qGxqf-0007MU-GH; Wed, 05 Jul 2023 10:26:53 +0200
Message-ID: <18d8a6d4-78fb-7046-b796-86f527d074f6@pengutronix.de>
Date:   Wed, 5 Jul 2023 10:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] ARM: dts: imx6: pfla02: Fix SD card reboot problem
Content-Language: en-US
To:     Andrej Picej <andrej.picej@norik.com>
References: <20230704080304.816942-1-andrej.picej@norik.com>
 <20230704080304.816942-3-andrej.picej@norik.com>
 <b382e51d-2f57-c4ab-7590-2083bd771abd@pengutronix.de>
 <02d491bb-2a40-4909-ebc3-be2e183cfcbb@norik.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@phytec.de
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <02d491bb-2a40-4909-ebc3-be2e183cfcbb@norik.com>
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

Hi Andrej,

[Restoring Cc-list]

On 05.07.23 10:18, Andrej Picej wrote:
> Hi Ahmad,
> 
> On 4. 07. 23 10:15, Ahmad Fatoum wrote:
>> Hello Andrej,
>>
>> On 04.07.23 10:03, Andrej Picej wrote:
>>> If regulator is not marked as always-on the regulator gets disabled on
>>> reboot breaking the next boot.
>>
>> While this is ok as a fix, the real issue is that your system reset doesn't
>> restore PMIC rails to a good state. Are you perhaps doing a SoC-internal
>> reset only or have the PMIC misconfigured?
> 
> yes I would agree, this is just a fix since system reset doesn't reset the PMIC, leaving the configuration as it is in a misconfigured state. The i.MX6 reset is done with imx watchdog.

If PMIC doesn't have own watchdog, i.MX watchdog can be configured to toggle
WDOG_B line, which may be routed to PMIC.

But fix is ok for now:

Acked-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Cheers,
Ahmad

> 
> Best regards,
> Andrej
> 
>>
>> Cheers,
>> Ahmad
>>
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
>>>               };
>>>                 vdd_sd1_reg: ldo10 {
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

