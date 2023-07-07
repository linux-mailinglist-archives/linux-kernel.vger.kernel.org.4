Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8D74AC0A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjGGHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGGHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:38:05 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7619B2;
        Fri,  7 Jul 2023 00:38:02 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5EDF124E1AC;
        Fri,  7 Jul 2023 15:37:48 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Jul
 2023 15:37:48 +0800
Received: from [192.168.125.128] (113.72.145.114) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Jul
 2023 15:37:47 +0800
Message-ID: <a664ad04-561d-5060-6e69-10f79c1398d0@starfivetech.com>
Date:   Fri, 7 Jul 2023 15:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] watchdog: starfive: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Samin Guo <samin.guo@starfivetech.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230706082928.10869-1-paul@crapouillou.net>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230706082928.10869-1-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.114]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/6 16:29, Paul Cercueil wrote:
> Use the new PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/watchdog/starfive-wdt.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 8058fca4d05d..7c8a1c5e75be 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -526,7 +526,6 @@ static void starfive_wdt_shutdown(struct platform_device *pdev)
>  	starfive_wdt_pm_stop(&wdt->wdd);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int starfive_wdt_suspend(struct device *dev)
>  {
>  	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> @@ -556,9 +555,7 @@ static int starfive_wdt_resume(struct device *dev)
>  
>  	return starfive_wdt_start(wdt);
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
> -#ifdef CONFIG_PM
>  static int starfive_wdt_runtime_suspend(struct device *dev)
>  {
>  	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> @@ -574,11 +571,10 @@ static int starfive_wdt_runtime_resume(struct device *dev)
>  
>  	return starfive_wdt_enable_clock(wdt);
>  }
> -#endif /* CONFIG_PM */
>  
>  static const struct dev_pm_ops starfive_wdt_pm_ops = {
> -	SET_RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
> +	RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
>  };
>  
>  static const struct of_device_id starfive_wdt_match[] = {
> @@ -594,7 +590,7 @@ static struct platform_driver starfive_wdt_driver = {
>  	.shutdown = starfive_wdt_shutdown,
>  	.driver = {
>  		.name = "starfive-wdt",
> -		.pm = &starfive_wdt_pm_ops,
> +		.pm = pm_ptr(&starfive_wdt_pm_ops),
>  		.of_match_table = starfive_wdt_match,
>  	},
>  };

Great, Thank you for the improvements.

Best regards,
Xingyu Wu
