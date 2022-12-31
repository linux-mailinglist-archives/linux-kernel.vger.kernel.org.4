Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591465A43B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiLaMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiLaMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:55:44 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD516584
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:55:40 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BbOjpHciEYnG1BbOjpSbRh; Sat, 31 Dec 2022 13:55:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 13:55:39 +0100
X-ME-IP: 86.243.100.34
Message-ID: <b34f4f8a-f169-a634-c2b9-1ac7d2ba7fb8@wanadoo.fr>
Date:   Sat, 31 Dec 2022 13:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] watchdog: of_xilinx_wdt: Use devm_clk_get_enabled()
 helper
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <71551233b18f57037be9e75d2d6428534d7572d3.1672491065.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <71551233b18f57037be9e75d2d6428534d7572d3.1672491065.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/12/2022 à 13:51, Christophe JAILLET a écrit :
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Note that the order of operations is slightly modified by this patch. The
> clk is now prepare_enable()'ed before calling clk_get_rate().
> ---
>   drivers/watchdog/of_xilinx_wdt.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 3318544366b8..f184843380a3 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -193,7 +193,7 @@ static int xwdt_probe(struct platform_device *pdev)
>   
>   	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>   
> -	xdev->clk = devm_clk_get(dev, NULL);
> +	xdev->clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(xdev->clk)) {
>   		if (PTR_ERR(xdev->clk) != -ENOENT)
>   			return PTR_ERR(xdev->clk);
> @@ -211,15 +211,6 @@ static int xwdt_probe(struct platform_device *pdev)
>   				 "The watchdog clock freq cannot be obtained\n");
>   	} else {
>   		pfreq = clk_get_rate(xdev->clk);
> -		rc = clk_prepare_enable(xdev->clk);
> -		if (rc) {
> -			dev_err(dev, "unable to enable clock\n");
> -			return rc;
> -		}
> -		rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
> -					      xdev->clk);
> -		if (rc)
> -			return rc;
>   	}
>   
>   	/*

NACK.

This one is incomplet, xwdt_clk_disable_unprepare() should be removed 
as-well.

I'll send a v2.

CJ
