Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55161EE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiKGJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiKGJTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:19:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50A2634
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD8860F46
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCFCC433C1;
        Mon,  7 Nov 2022 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812742;
        bh=8r25nnibsdc3RDPgthhVh3turSFna9yd2wbYKCt5cLY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ug+LL3GusENNx0gWQU4+vqNIi3xm1RCBLayMbowK0F8hmADjpnHyzFeJJHXnTQHhE
         Xlf92xDfaCImGzZr7oOF/5VgG0PxCS4xlwCrF18w2HP/82iWyF2tHbHg9lMM2yjROy
         JrSi2a9wGw1cmrGT3iX2ab51NWMItpyBT6FNzKau5tIBJFPIrRZucTu6T0tNmZ9V5G
         LBYGjQJbZnSmsxNgCNJSafUlTJw/5ULTZp2FzGxoTjP7tG2R37G3V6YocQLyJRg8Nk
         CnykwccDs8E9ExmL7nPV2YV5FLQ1XlFC+IxSpa4nQFAd3pP2T4mR6zxE2jnBcuvIyR
         lDyG58fSxFStQ==
Message-ID: <3d1ec690-78ef-19e9-3bb6-6daae1504878@kernel.org>
Date:   Mon, 7 Nov 2022 11:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mtd: onenand: omap2: add dependency on GPMC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20221107091520.127053-1-krzysztof.kozlowski@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221107091520.127053-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 11:15, Krzysztof Kozlowski wrote:
> OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
> OMAP_GPMC driver, so the latter cannot be module if OneNAND driver is
> built-in:
> 
>   /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
>   onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'
> 
> The OMAP_GPMC is also a runtime dependency.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> 
> ---
> 
> Changes since v1:
> 1. Always require OMAP_GPMC (drop !OMAP_GPMC).
> 2. Adjust commit msg.
> ---
>  drivers/mtd/nand/onenand/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
> index 34d9a7a82ad4..c94bf483541e 100644
> --- a/drivers/mtd/nand/onenand/Kconfig
> +++ b/drivers/mtd/nand/onenand/Kconfig
> @@ -26,6 +26,7 @@ config MTD_ONENAND_OMAP2
>  	tristate "OneNAND on OMAP2/OMAP3 support"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
>  	depends on OF || COMPILE_TEST
> +	depends on OMAP_GPMC
>  	help
>  	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
>  	  via the GPMC memory controller.

--
cheers,
-roger
