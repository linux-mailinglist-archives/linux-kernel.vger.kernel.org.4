Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD85BAF60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiIPO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiIPO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:26:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFBDB40FD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338388; x=1694874388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=712YwNQdrWKANR3vHtT8MY/Ny21R8h1VOwwEWwMdGyA=;
  b=BZw7Z2EnjG6bETiZH3L4DaJMVIpvW4wxxa3Oi5dE6K5sE4SUR5d9EIW6
   hfJJmUp8TY0JrvGwUE/hTqNKoXdnW/m9wenw+hslV5GgHITTmT1W76juR
   8FOlXS5t5B9dnVjdKGJ4EvQfWyyw+qU83sBiRrbTl4K6lR841cpqizx3M
   hLB34rEeNxY/p7WN/9SexsPf5ka6/qXyebu3afmOmZyY2D9CYq4g1rCh9
   RpxKy7EDxn407zpAIBk9yTm/zry8023QwzrUIPxiEGA1Cr0rjr2c+nJLv
   CjeGELcJ8xV82owycue3oy9/GSB9VfMyveSC2o1ImCEvCQAsJj3HlmxSt
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216707955"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:26:25 +0800
IronPort-SDR: 2vpw03tyTZfByOVG2mrQXwQdVEq/8XwH88fAxD3VW4+iu+WvkRvS4L+U0yxOvNaKaQP4oyiGPh
 TvjXEE0+vQ1oA5ZOwZ//7MV4s0vxhttRG1rCwWViDvjwfeAqQ221WydkyQbuf62+ri9+QiLwGL
 7d8VI5gFmdmio2bTpjG40+Uc815SB2auOhYvvwVakHlW/R+pvXZXz0FrQiODG698y3wmldixoh
 QwJxamlkt119KOFp4s/2Sauc7UYP//xvWfg/nQRFyvZVRFuJ83oEaKS+LrqkxvOIjC/MGKKAMa
 wpM6J+zO4FPx1uxe4GXMGygZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:46:35 -0700
IronPort-SDR: faGMPnut0dI5ZbMfDrE20pmDwUVOo00ukgPsnRgSQPj0FPxDGGOg63r+sQkv6/7MQ5Efe1oMk9
 ROu1ueDj8JVNXRCgxbOAA9jWYzWtLJ3wvhtwZHnzqCHVb9l2GnOFJ9J5H0w/9DQkUkVnDwJpQL
 Fh4TnxEtTyfe55+7Qa2+hRCcCfsjVma6hlRnZT66dOie7vOCAVhm451tZhbiPK8r+aD5oYR2yz
 3Z3gehhI5aLwFxnWQNnGb9fUkMPjZ5y+bL8Nc0jFQGZA6Gnc2HHG6tQFx7Y2m8sbBZYh7s/WRK
 5h4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:26:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTbwd09d8z1RvTp
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:26:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338384; x=1665930385; bh=712YwNQdrWKANR3vHtT8MY/Ny21R8h1VOww
        EWwMdGyA=; b=nui88Tz6XmVlW/uX2NYRfBM8HoFt17amgZmD7YwHtCgm69K0Jya
        TOYQ7pMJ6nR6XVR8YPNH9UzCfYwe0Lf1B1VO/SfB7sVoRNdYLIPGirmlPHj2TMUX
        Wwgc16GAtf33mMfK7nvQkn3ZXRUKkHUlJALDkYsC5ta9Zce4kQkrGil+5zHw2Qs2
        ehRIAhq7F0f/GIdZZ1u5rqCAHgfdFLU49Zvh7hFR7T5ym9VlovKrrqV5P4Vbu8EZ
        dy9N80AQHORzOgDfrZxkjqqCC2S5BfkZB+XM2rhZWcQvSLDRJyXsJ989dEBQQ1oN
        xlg7Ytl3iL4LZARTkrhYbBLH8ivwY5MaM3A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mqg_0sA0IKBB for <linux-kernel@vger.kernel.org>;
        Fri, 16 Sep 2022 07:26:24 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTbwX3hFkz1RvLy;
        Fri, 16 Sep 2022 07:26:20 -0700 (PDT)
Message-ID: <6cb1bb99-be0d-f2db-a59e-76e6b8d14aa0@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] ata: clean up how architectures enable PATA_PLATFORM
 and PATA_OF_PLATFORM
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/14 15:27, Lukas Bulwahn wrote:
> There are two options for platform device PATA support:
> 
>   PATA_PLATFORM: Generic platform device PATA support
>   PATA_OF_PLATFORM: OpenFirmware platform device PATA support
> 
> If an architecture allows the generic platform device PATA support, it
> shall select HAVE_PATA_PLATFORM. Then, Generic platform device PATA support
> is available and can be selected.
> 
> If an architecture has OpenFirmware support, which it indicates by
> selecting OF, OpenFirmware platform device PATA support is available
> and can be selected.
> If OpenFirmware platform device PATA support is selected, then the
> functionality (code files) from Generic platform device PATA support needs
> to be integrated in the kernel build for the OpenFirmware platform device
> PATA support to work. Select PATA_PLATFORM in PATA_OF_PLATFORM to make sure
> the needed files are added in the build.
> 
> So, architectures with OpenFirmware support, do not need to additionally
> select HAVE_PATA_PLATFORM. It is only needed by architecture that want the
> non-OF pata-platform module.
> 
> Reflect this way of intended use of config symbols in the ata Kconfig and
> adjust all architecture definitions.
> 
> This follows the suggestion from Arnd Bergmann (see Link).
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com/
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied this patch and 2/2 to for-6.1. Thanks !

> ---
>  arch/arm/mach-versatile/Kconfig | 1 -
>  arch/arm64/Kconfig              | 1 -
>  drivers/ata/Kconfig             | 6 +++---
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
> index 2ef226194c3a..b1519b4dc03a 100644
> --- a/arch/arm/mach-versatile/Kconfig
> +++ b/arch/arm/mach-versatile/Kconfig
> @@ -256,7 +256,6 @@ menuconfig ARCH_VEXPRESS
>  	select GPIOLIB
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
> -	select HAVE_PATA_PLATFORM
>  	select CLK_ICST
>  	select NO_IOPORT_MAP
>  	select PLAT_VERSATILE
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 51f3f07c3efd..036bd67e662e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -194,7 +194,6 @@ config ARM64
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KVM
>  	select HAVE_NMI
> -	select HAVE_PATA_PLATFORM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 1c9f4fb2595d..c93d97455744 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1102,8 +1102,7 @@ config PATA_PCMCIA
>  	  If unsure, say N.
>  
>  config PATA_PLATFORM
> -	tristate "Generic platform device PATA support"
> -	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
> +	tristate "Generic platform device PATA support" if EXPERT || HAVE_PATA_PLATFORM
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems.
> @@ -1112,7 +1111,8 @@ config PATA_PLATFORM
>  
>  config PATA_OF_PLATFORM
>  	tristate "OpenFirmware platform device PATA support"
> -	depends on PATA_PLATFORM && OF
> +	depends on OF
> +	select PATA_PLATFORM
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems with OpenFirmware

-- 
Damien Le Moal
Western Digital Research

