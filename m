Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7334C75074B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGLL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGLL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:58:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D4D1BC5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FB8C6179A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46615C433C8;
        Wed, 12 Jul 2023 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163090;
        bh=BPwn7ycrAHdiOF8yVt+5jZUIynmY0GSHF1SaS+Uh9HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twit5vP4HZmDg1OUtV3zp39IIdA3GcgdIFUcCwXcZ2MQqpD9wlLeMZZZT44WlJmOW
         Czhz2zQdWB0zYX2prS7nSsn71GE67kUDe7EBCOr6eBfGS59iCkVGyA2/V9xb9A7jSy
         SJ/HO+uAwR7KEAKnOdLanjQeovqKN3YJZnT5XuzawSoKw5QRqIBRP2C2ev6fc14wbM
         I8Bmm1iKe1Gtqgw2o8KyiUC/0fSlfCzl/1WiYvXa9t1GCgHlvaalRrQgpJjG7AJOny
         bG66eHoqx+0ae76mvknhjvW0Oc4zqvhSIQ3JutlwQoHgms7Asaj9vjku8leLQyTR77
         kbfOiGwmNZEeQ==
Date:   Wed, 12 Jul 2023 12:58:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] regmap: REGMAP_SLIMBUS should select REGMAP
Message-ID: <20230712115804.GC10768@google.com>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023, Geert Uytterhoeven wrote:

> If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
> CONFIG_MFD_WCD934X=n, CONFIG_REGMAP=n:
> 
>     sound/soc/codecs/wcd934x.c:518:38: error: array type has incomplete element type ‘struct regmap_range_cfg’
>       518 | static const struct regmap_range_cfg wcd934x_ifc_ranges[] = {
> 	  |                                      ^~~~~~~~~~~~~~~~~~
> 
> Fix this by making REGMAP_SLIMBUS select REGMAP.
> 
> Drop the selection of REGMAP by MFD_WCD934X, as this is not needed
> (now both REGMAP_SLIMBUS and REGMAP_IRQ select REGMAP).
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/base/regmap/Kconfig | 1 +
>  drivers/mfd/Kconfig         | 1 -

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index e25cc619c75de3d9..c3a260ed4e864959 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -34,6 +34,7 @@ config REGMAP_I2C
>  config REGMAP_SLIMBUS
>  	tristate
>  	depends on SLIMBUS
> +	select REGMAP
>  
>  config REGMAP_SPI
>  	tristate
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0b6af476f554a191..5857dad2c64828fa 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2121,7 +2121,6 @@ config MFD_STMFX
>  config MFD_WCD934X
>  	tristate "Support for WCD9340/WCD9341 Codec"
>  	depends on SLIMBUS
> -	select REGMAP
>  	select REGMAP_SLIMBUS
>  	select REGMAP_IRQ
>  	select MFD_CORE
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
