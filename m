Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1CE6EE15F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjDYLxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjDYLxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:53:50 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E560CC18;
        Tue, 25 Apr 2023 04:53:26 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0A34B24E257;
        Tue, 25 Apr 2023 19:53:06 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 19:53:06 +0800
Received: from [192.168.125.87] (113.72.145.137) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 19:53:05 +0800
Message-ID: <aab34ed5-5b83-7e90-0bf9-a24fdf4c55a5@starfivetech.com>
Date:   Tue, 25 Apr 2023 19:53:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/1] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be
 selected in a specified case
Content-Language: en-US
To:     <linux-clk@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@kvack.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Paul Gazzillo" <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230418123756.62495-1-hal.feng@starfivetech.com>
 <20230418123756.62495-2-hal.feng@starfivetech.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230418123756.62495-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 20:37:56 +0800, Hal Feng wrote:
> When (ARCH_STARFIVE [=n] && COMPILE_TEST [=y] && RESET_CONTROLLER [=n]),
> RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
> and CLK_STARFIVE_JH7110_AON.
> 
> Add a condition `if RESET_CONTROLLER` to fix it. Also, delete redundant
> selected options of CLK_STARFIVE_JH7110_AON because these options are
> already selected by the dependency.
> 
> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
> Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on clock driver")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Hi, Stephen,

Could this patch be merged into v6.4? Thanks.

Best regards,
Hal

> ---
>  drivers/clk/starfive/Kconfig | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 71c1148ee5f6..5d2333106f13 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -26,7 +26,7 @@ config CLK_STARFIVE_JH7110_SYS
>  	depends on ARCH_STARFIVE || COMPILE_TEST
>  	select AUXILIARY_BUS
>  	select CLK_STARFIVE_JH71X0
> -	select RESET_STARFIVE_JH7110
> +	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
>  	default ARCH_STARFIVE
>  	help
>  	  Say yes here to support the system clock controller on the
> @@ -35,9 +35,6 @@ config CLK_STARFIVE_JH7110_SYS
>  config CLK_STARFIVE_JH7110_AON
>  	tristate "StarFive JH7110 always-on clock support"
>  	depends on CLK_STARFIVE_JH7110_SYS
> -	select AUXILIARY_BUS
> -	select CLK_STARFIVE_JH71X0
> -	select RESET_STARFIVE_JH7110
>  	default m if ARCH_STARFIVE
>  	help
>  	  Say yes here to support the always-on clock controller on the

