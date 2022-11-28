Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00463A51D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiK1JcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiK1JcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:32:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDEB5F62
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:32:10 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1ozaUa-0007kl-1X; Mon, 28 Nov 2022 10:32:00 +0100
Message-ID: <dc7071c9-480b-15d8-2647-00f9ee25e6cf@pengutronix.de>
Date:   Mon, 28 Nov 2022 10:31:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] soc: imx8m: Fix return value check in
 imx8mq_soc_revision()
Content-Language: en-US
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     festevam@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de
References: <20221128083755.80445-1-zhengyongjun3@huawei.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20221128083755.80445-1-zhengyongjun3@huawei.com>
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

Hello Zheng,

On 28.11.22 09:37, Zheng Yongjun wrote:
> In case of error, the function of_clk_get_by_name()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
> 
> Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the register")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Maintainers will usually collect tags replied to the current patch revision when they
apply a series. However, If you send a new revision, please make sure to incorporate
any tags yourself.

Cheers,
Ahmad

> ---
> Changes in v2:
> - Rewrite code and make it more concise.
>  drivers/soc/imx/soc-imx8m.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 28144c699b0c..d1dbe318be53 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -66,10 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
>  	ocotp_base = of_iomap(np, 0);
>  	WARN_ON(!ocotp_base);
>  	clk = of_clk_get_by_name(np, NULL);
> -	if (!clk) {
> -		WARN_ON(!clk);
> +	if (WARN_ON(IS_ERR(clk)))
>  		return 0;
> -	}
> 
>  	clk_prepare_enable(clk);
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

