Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07765CF71
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjADJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbjADJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:19:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97B1CB29
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:19:41 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pCzvs-0003S0-38; Wed, 04 Jan 2023 10:19:36 +0100
Message-ID: <31d7df1d-f77e-94df-942e-3d703c414a76@pengutronix.de>
Date:   Wed, 4 Jan 2023 10:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] soc: imx8m: fix wrong return value check of
 of_clk_get_by_name()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     xiaolei.wang@windriver.com, alexander.stein@ew.tq-group.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de
References: <20230104092702.2553290-1-yangyingliang@huawei.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230104092702.2553290-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 10:27, Yang Yingliang wrote:
> of_clk_get_by_name() never returns NULL pointer, it will return
> ERR_PTR() when it fails, so replace the check with IS_ERR().
> 
> Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the register")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
> v1 -> v2:
>   Check WARN_ON() instead of checking IS_ERR().
> ---
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

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

