Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8A61ED42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiKGIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:45:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F689C01
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:45:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E881B60F2F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71230C433B5;
        Mon,  7 Nov 2022 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667810700;
        bh=5bhUp/7RhhEmhXQkR8+nWueOvcoq5Jl/02Kb6lv1QMk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F2dOkFdLo01D1SyGxCwRrxxvk7mi3A9T8CuC8scJ59HG/zbsSW6TPZFinFqfFuiax
         /F0dTfX8yAcxENPtgSDYrjXbP2bAlq7O6KQ3SBUykZD1iIee1U0Rhb9Og7IHQE5Apy
         XEUX0gWrfhLREJH9tlEHrkg5/HPF0ofe53RJWn415OMz2Opohlf0znuDkkHJZZuRG7
         pXCTs7NcEnfZKQHGXlJZQtNhEC7a9iA+iZP1g6DLz+KFZRYXqcNPDP28GZwcnKLtns
         rmDU0q9/SNi0iz//YQS+eJbUdKxzIzWUwyAjSf1u8cI9hpC+4/Gf/RX138zEm6eggT
         ii3FrMRIsTLbA==
Message-ID: <eef60a26-ef23-1b79-22f7-adaee3be9360@kernel.org>
Date:   Mon, 7 Nov 2022 10:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mtd: onenand: omap2: add dependency on GPMC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20221104194934.384371-1-krzysztof.kozlowski@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221104194934.384371-1-krzysztof.kozlowski@linaro.org>
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

Hello Krzysztof,

On 04/11/2022 21:49, Krzysztof Kozlowski wrote:
> OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
> OMAP GPMC driver, so the latter cannot be module if OneNAND driver is
> built-in:
> 
>   /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
>   onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mtd/nand/onenand/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
> index 34d9a7a82ad4..fa94c514626d 100644
> --- a/drivers/mtd/nand/onenand/Kconfig
> +++ b/drivers/mtd/nand/onenand/Kconfig
> @@ -26,6 +26,7 @@ config MTD_ONENAND_OMAP2
>  	tristate "OneNAND on OMAP2/OMAP3 support"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
>  	depends on OF || COMPILE_TEST
> +	depends on OMAP_GPMC || !OMAP_GPMC

Why did you add !OMAP_GPMC?

If OMAP_GPMC is not set we don't want to be able to build this driver correct?

>  	help
>  	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
>  	  via the GPMC memory controller.

cheers,
-roger
