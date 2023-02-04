Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9B68A8DA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjBDHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBDHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:47:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D838020;
        Fri,  3 Feb 2023 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Cbez7xsfY4MkNROF6v40RsR64/eF53uzf9QET049CiU=; b=h2yKIPZKALZ/Fa5lajMCu+tN32
        yrIEABdRQ+BpLahqh1URk5TrSGccOqf/LC+aiKFFUYrPUkth4lNha0V/UrZSYn8Snl/q5m1Og2BPb
        cPEfgryi3ILOTADo7de6ZFMv1wetvEJ2mpzca2URZlt/eYcXZY3xlYbGDqpwNiZDIaShWoMA7XrbA
        M0z2c7qANyyyY93e2XUuFxItlwwsmp9c0A8sv5+R7mFXTkizr91GKFilIUPzImy8pi4zChh1q6QQZ
        2OPyzkbzrBYLOLaSdWRVvZYcjFWWm0JK5NcdEKrOcqFuNWoGC3jG/NMm3M/3iyD2RUbGhEuIMBAHp
        dXbUbMGQ==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pODH1-004fK3-SZ; Sat, 04 Feb 2023 07:47:47 +0000
Message-ID: <46dafb64-81d2-c084-97c5-8d01e8b9785b@infradead.org>
Date:   Fri, 3 Feb 2023 23:47:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: sunxi: select CONFIG_PM
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        sparclinux <sparclinux@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230130130453.379749-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230130130453.379749-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/30/23 05:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting CONFIG_PM_GENERIC_DOMAINS without CONFIG_PM leads to a
> build failure:
> 
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
>   Depends on [n]: PM [=n]
>   Selected by [y]:
>   - SUN20I_PPU [=y] && (ARCH_SUNXI [=n] || COMPILE_TEST [=y])
> 
> drivers/base/power/domain_governor.c: In function 'default_suspend_ok':
> drivers/base/power/domain_governor.c:85:24: error: 'struct dev_pm_info' has no member named 'ignore_children'
>    85 |         if (!dev->power.ignore_children)
>       |                        ^
> drivers/base/power/domain.c: In function 'genpd_queue_power_off_work':
> drivers/base/power/domain.c:657:20: error: 'pm_wq' undeclared (first use in this function)
>   657 |         queue_work(pm_wq, &genpd->power_off_work);
>       |                    ^~~~~
> 
> Unfortunately platforms are inconsistent between using 'select PM'
> and 'depends on PM' here. CONFIG_PM is a user-visible symbol, so
> in principle we should be using 'depends on', but on the other hand
> using 'select' here is more common among drivers/soc. Go with the
> majority for now, as this has a smaller risk of introducing circular
> dependencies. We may need to clean this up for consistency later.
> 
> Fixes: 0e30ca5ab0a8 ("soc: sunxi: Add Allwinner D1 PPU driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With this patch (in linux-next-20230203), building on sparc32 with
COMPILE_TEST=y and ARCH_SUNXI not set:

WARNING: unmet direct dependencies detected for PM
  Depends on [n]: SPARC64 [=n]
  Selected by [y]:
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for PM
  Depends on [n]: SPARC64 [=n]
  Selected by [y]:
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
  Depends on [n]: SPARC64 [=n] && PM [=y]
  Selected by [y]:
  - QCOM_GDSC [=y] && COMMON_CLK [=y] && PM [=y]
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])
  - MESON_GX_PM_DOMAINS [=y] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]
  - BCM2835_POWER [=y] && (ARCH_BCM2835 || COMPILE_TEST [=y] && OF [=y]) && PM [=y]
  - BCM_PMB [=y] && (ARCH_BCMBCA || COMPILE_TEST [=y] && OF [=y]) && PM [=y]
  - ROCKCHIP_PM_DOMAINS [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y]) && PM [=y]
  Selected by [m]:
  - ARM_SCPI_POWER_DOMAIN [=m] && (ARM_SCPI_PROTOCOL [=m] || COMPILE_TEST [=y] && OF [=y]) && PM [=y]
  - MESON_EE_PM_DOMAINS [=m] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]
  - QCOM_AOSS_QMP [=m] && (ARCH_QCOM || COMPILE_TEST [=y]) && MAILBOX [=y] && COMMON_CLK [=y] && PM [=y]

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
  Depends on [n]: SPARC64 [=n] && PM_GENERIC_DOMAINS [=y] && OF [=y]
  Selected by [y]:
  - MESON_GX_PM_DOMAINS [=y] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]
  Selected by [m]:
  - MESON_EE_PM_DOMAINS [=m] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]

Apparently sparc32 does not support PM (arch/sparc/Kconfig):

if SPARC64
source "kernel/power/Kconfig"
endif

so I think that SUN20I_PPU should also depend on !SPARC32.
Does that make sense?

Thanks.

> ---
>  drivers/soc/sunxi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
> index 29e9ba2d520d..02d0b338feb3 100644
> --- a/drivers/soc/sunxi/Kconfig
> +++ b/drivers/soc/sunxi/Kconfig
> @@ -23,6 +23,7 @@ config SUNXI_SRAM
>  config SUN20I_PPU
>  	bool "Allwinner D1 PPU power domain driver"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> +	select PM
>  	select PM_GENERIC_DOMAINS
>  	help
>  	  Say y to enable the PPU power domain driver. This saves power

-- 
~Randy
