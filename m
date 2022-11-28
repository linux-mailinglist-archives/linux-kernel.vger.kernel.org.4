Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5686763A26D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiK1ICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiK1ICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:02:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C234B24
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:02:33 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1ozZ5n-0002Vz-TR; Mon, 28 Nov 2022 09:02:19 +0100
Message-ID: <96c1ed7e-a2b7-a9a3-f7d4-12eeb099e14b@pengutronix.de>
Date:   Mon, 28 Nov 2022 09:02:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] nvmem: imx-ocotp: reverse MAC on imx6qdl
Content-Language: en-US
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221128074901.8D80B135A@mail.steuer-voss.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20221128074901.8D80B135A@mail.steuer-voss.de>
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

Hello Nikolaus,

On 24.11.22 17:50, Nikolaus Voss wrote:
> Ethernet MAC on iMX6Q/DL is stored in OTP in little-endian byte order. I
> suspect that this is true for all iMX flavors. If so, we could get rid
> of the .reverse_mac_address attribute entirely.

I also think all i.MX flavors are similar here. The barebox driver has had
a MAC address parsing function for a few years[1] and it's the same for
all i.MX variants. The only different SoC is VF610, but that has a standalone
driver in Linux.

[1]: https://elixir.bootlin.com/barebox/v2022.11.0/source/drivers/nvmem/ocotp.c#L551

> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Cheers,
Ahmad

> ---
>  drivers/nvmem/imx-ocotp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 14284e866f26e..a39a0defb070a 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -496,6 +496,7 @@ static const struct ocotp_params imx6q_params = {
>  	.bank_address_words = 0,
>  	.set_timing = imx_ocotp_set_imx6_timing,
>  	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
> +	.reverse_mac_address = true,
>  };
>  
>  static const struct ocotp_params imx6sl_params = {

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

