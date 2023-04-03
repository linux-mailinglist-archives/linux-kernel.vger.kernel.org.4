Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916226D3F2A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjDCIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjDCIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:38:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C86EAF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:38:30 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pjFhk-0007cH-Ub; Mon, 03 Apr 2023 10:38:20 +0200
Message-ID: <325d0023-9dd1-f1af-302e-d32b9b5f2f6b@pengutronix.de>
Date:   Mon, 3 Apr 2023 10:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] clk: imx: imx6sx: spdif clock rate is too high for
 asrc
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230403082138.3195452-1-peng.fan@oss.nxp.com>
 <a23f486a-e08f-f1ce-5f1b-bc34e4c92e67@pengutronix.de>
 <DU0PR04MB9417853B92B651A69452006088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU0PR04MB9417853B92B651A69452006088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.23 10:36, Peng Fan wrote:
>> Subject: Re: [PATCH V2] clk: imx: imx6sx: spdif clock rate is too high for asrc
>>
>> Hello Peng,
>>
>> On 03.04.23 10:21, Peng Fan (OSS) wrote:
>>> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>>>
>>> spdif clock is one of the asrc clock source, which is used for ideal
>>> ratio mode. when set to 98.304MHz, it cause the divider of asrc input
>>> clock and output clock exceed the maximum value, and asrc driver
>>> saturate the value to maximum value, which will cause the ASRC's
>>> performance very bad.
>>> So we need to set spdif clock to a proper rate. which make asrc
>>> divider not exceed maximum value, at least one of divider not exceed
>>> maximum value.
>>> The target is spdif clock rate / output(or input) sample rate less
>>> than 1024(which is maximum divider).
>>>
>>> Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
>>
>> Before referenced commit, it looked like this:
>>
>>   clk_set_rate(clks[IMX6SX_CLK_SPDIF_PODF], 98304000);
>>
>> I think commit d55135689019 ("ARM: imx: add clock driver for imx6sx") is
>> what you're after.
> 
> Should I add both the commits as Fixes? Or only the one your listed?

AFAICS, f1541e15e38e introduced no functional change with regards to the
SPDIF clock, so you should only reference the original commit introducing
the issue you aim to resolve.

Cheers,
Ahmad

> 
> Thanks,
> Peng.
> 
>>
>> Cheers,
>> Ahmad
>>
>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V2:
>>>  Add Fixes tag
>>>
>>>  drivers/clk/imx/clk-imx6sx.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/imx/clk-imx6sx.c
>>> b/drivers/clk/imx/clk-imx6sx.c index 7cf86707bc39..3face052527d 100644
>>> --- a/drivers/clk/imx/clk-imx6sx.c
>>> +++ b/drivers/clk/imx/clk-imx6sx.c
>>> @@ -520,7 +520,7 @@ static void __init imx6sx_clocks_init(struct
>> device_node *ccm_node)
>>>  	clk_set_rate(hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk, 393216000);
>>>
>>>  	clk_set_parent(hws[IMX6SX_CLK_SPDIF_SEL]->clk,
>> hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
>>> -	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 98304000);
>>> +	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 24576000);
>>>
>>>  	clk_set_parent(hws[IMX6SX_CLK_AUDIO_SEL]->clk,
>> hws[IMX6SX_CLK_PLL3_USB_OTG]->clk);
>>>  	clk_set_rate(hws[IMX6SX_CLK_AUDIO_PODF]->clk, 24000000);
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       |
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
>> pengutronix.de%2F&data=05%7C01%7Cpeng.fan%40nxp.com%7Cc7131cb2
>> 058346303de208db341e3824%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
>> 0%7C0%7C638161076614883851%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
>> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
>> 00%7C%7C%7C&sdata=bmXiNAsD5SCoNrZF7pTgPFpjbColwBdBsO2qxR0KVO
>> U%3D&reserved=0  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

