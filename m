Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0563A258
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiK1H42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiK1H4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:56:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1DEA46B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:56:19 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1ozYzl-0001p1-Dv; Mon, 28 Nov 2022 08:56:05 +0100
Message-ID: <489b24e6-fe75-caa7-1a97-2f1921b0c242@pengutronix.de>
Date:   Mon, 28 Nov 2022 08:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] soc: imx8m: Fix return value check in
 imx8mq_soc_revision()
Content-Language: en-US
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     festevam@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de
References: <20221126092433.91150-1-zhengyongjun3@huawei.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20221126092433.91150-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

On 26.11.22 10:24, Zheng Yongjun wrote:
> In case of error, the function of_clk_get_by_name()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
> 
> Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the register")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 28144c699b0c..32ed9dc88e45 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -66,8 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
>  	ocotp_base = of_iomap(np, 0);
>  	WARN_ON(!ocotp_base);
>  	clk = of_clk_get_by_name(np, NULL);
> -	if (!clk) {
> -		WARN_ON(!clk);
> +	if (IS_ERR(clk)) {
> +		WARN_ON(IS_ERR(clk));
>  		return 0;

You could also rewrite as

if (WARN_ON(IS_ERR(clk))
	return 0;

To make it more concise. Change looks good though:

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Cheers,
Ahmad

>  	}
> 
> --
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

