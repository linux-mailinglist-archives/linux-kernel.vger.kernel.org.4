Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D265CFF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjADJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjADJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:51:14 -0500
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 01:51:12 PST
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF1140D6;
        Wed,  4 Jan 2023 01:51:12 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1pD0QG-00G85N-8X; Wed, 04 Jan 2023 09:51:00 +0000
Message-ID: <49bd7b4a-b0e1-3213-8aed-9f39604f3935@codethink.co.uk>
Date:   Wed, 4 Jan 2023 09:50:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC v5.1 6/9] cache,soc: Move SiFive CCache driver & create
 drivers/cache
Content-Language: en-GB
To:     Conor Dooley <conor@kernel.org>, arnd@arndb.de, palmer@dabbelt.com,
        prabhakar.csengg@gmail.com
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@rivosinc.com, biju.das.jz@bp.renesas.com,
        devicetree@vger.kernel.org, geert@linux-m68k.org,
        guoren@kernel.org, hch@infradead.org, heiko@sntech.de,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-riscv@lists.infradead.org, magnus.damm@gmail.com,
        nathan@kernel.org, paul.walmsley@sifive.com,
        philipp.tomsich@vrull.eu, prabhakar.mahadev-lad.rj@bp.renesas.com,
        robh+dt@kernel.org, samuel@sholland.org, soc@kernel.org
References: <Y62nOqzyuUKqYDpq@spud>
 <20230103210400.3500626-7-conor@kernel.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230103210400.3500626-7-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 21:03, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Zicbo* set of extensions for cache maintenance arrived too late &
> several SoCs exist without them that require non-coherent DMA.
> As things stand, the StarFive JH7100, Microchip PolarFire SoC & Renesas
> RZ/Five all require cache maintenance and lack instructions for this
> purpose.
> Create a subsystem for cache drivers so that vendor specific behaviour
> can be isolated from arch code, but keep the interfaces etc consistent.
> Move the existing SiFive CCache driver to create drivers/cache.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   MAINTAINERS                                   | 15 ++++++++-------
>   drivers/Kconfig                               |  2 ++
>   drivers/Makefile                              |  2 ++
>   drivers/{soc/sifive => cache}/Kconfig         |  8 +++++++-
>   drivers/{soc/sifive => cache}/Makefile        |  0
>   drivers/{soc/sifive => cache}/sifive_ccache.c |  2 +-
>   drivers/edac/sifive_edac.c                    |  2 +-
>   drivers/soc/Kconfig                           |  1 -
>   drivers/soc/Makefile                          |  1 -
>   include/{soc/sifive => cache}/sifive_ccache.h |  0
>   10 files changed, 21 insertions(+), 12 deletions(-)
>   rename drivers/{soc/sifive => cache}/Kconfig (56%)
>   rename drivers/{soc/sifive => cache}/Makefile (100%)
>   rename drivers/{soc/sifive => cache}/sifive_ccache.c (99%)
>   rename include/{soc/sifive => cache}/sifive_ccache.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f61eb221415b..4437e96a657b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19054,13 +19054,6 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
>   F:	drivers/dma/sf-pdma/
>   
> -SIFIVE SOC DRIVERS
> -M:	Conor Dooley <conor@kernel.org>
> -L:	linux-riscv@lists.infradead.org
> -S:	Maintained
> -T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> -F:	drivers/soc/sifive/
> -
>   SILEAD TOUCHSCREEN DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   L:	linux-input@vger.kernel.org
> @@ -19873,6 +19866,14 @@ S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>   F:	drivers/staging/
>   
> +STANDALONE CACHE CONTROLLER DRIVERS
> +M:	Conor Dooley <conor@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:	drivers/cache
> +F:	include/cache
I thought the riscv list was subscribers only?

Maybe if we do the suggestion of other cache drivers here we should
either use the main kernel one or find some arch non-specific list.

> +
>   STARFIRE/DURALAN NETWORK DRIVER
>   M:	Ion Badulescu <ionut@badula.org>
>   S:	Odd Fixes
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 968bd0a6fd78..e592ba5276ae 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -241,4 +241,6 @@ source "drivers/peci/Kconfig"
>   
>   source "drivers/hte/Kconfig"
>   
> +source "drivers/cache/Kconfig"
> +
>   endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index bdf1c66141c9..6ff60cf21823 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -38,6 +38,8 @@ obj-y				+= clk/
>   # really early.
>   obj-$(CONFIG_DMADEVICES)	+= dma/
>   
> +obj-y				+= cache/
> +
>   # SOC specific infrastructure drivers.
>   obj-y				+= soc/
>   
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/cache/Kconfig
> similarity index 56%
> rename from drivers/soc/sifive/Kconfig
> rename to drivers/cache/Kconfig
> index ed4c571f8771..bc852f005c10 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -1,9 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -if SOC_SIFIVE
> +menuconfig CACHE_CONTROLLER
> +	bool "Cache controller driver support"
> +	default y if RISCV
> +
> +if CACHE_CONTROLLER
>   
>   config SIFIVE_CCACHE
>   	bool "Sifive Composable Cache controller"
> +	depends on RISCV
> +	default y
>   	help
>   	  Support for the composable cache controller on SiFive platforms.
>   

Maybe we should find and move the ARM PL cache controllers and
have them here too?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

