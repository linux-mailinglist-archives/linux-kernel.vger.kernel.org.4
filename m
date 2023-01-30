Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D210D68175D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbjA3RO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjA3ROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:14:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86487166C9;
        Mon, 30 Jan 2023 09:14:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so20084631lfv.2;
        Mon, 30 Jan 2023 09:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78I7yuvVDhXwux1Rr6oWaCpB7U9gfTI3feUAU2gmhu4=;
        b=C3FA0Zd6jpB1RueE+PArS6BL1/ImvQEjFEXSI1FjeTnch+RQpLvBguFTOJtThxnCvN
         rb3YGXTbQ6l2eLZnYfKP4CyG1onToAibU86PnpTxw+14b21+H77al2rOpNVhk3YXjgA0
         PQfFC5aDUwrbYm10BbVQ0oWkuFVmoVSVfSOXB4GfxZZfk0EKrfvCqLAVXPeC2nEDaAOE
         tsP/0qC/SEJ896j7scqe2uzZaJD40LIVfTIF7LTYqPkSJVAZVTZA9win0tl39rblD/NN
         EKk4eW3jGQ7R4M5k/g+8nT5MpoNzzzBKfyDsAK9KZCrm/AedDtS+wEdNdNW0bA4iqXwr
         Frjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78I7yuvVDhXwux1Rr6oWaCpB7U9gfTI3feUAU2gmhu4=;
        b=gUrxbmv0QhbbQwUyfhH5YhwVilMYQCNVZgdKPYnYOMZ8xZrkq0ev3/jx/RZdk7IMsn
         akB0z1joGziaxzvKWr2+Fjb2miNMSLiAkZLLh+4RNM6NT+2OEwEb9mbrmA3xM42A4eX3
         gzsKEoXlvTnwfUELi/PeqMCQpY3B/XDiWiHbDA7/8W+B9XgFH0YAyki3J4YngA8SAxBt
         ohkQPSNmb5U556zceFVuPbX5SAKB2W8Iagb5gzomSrB2845kWuGD+apMRFUcMXbAoXk/
         mBjYixcWM3hMBwJq9J6jWltHQY2HMO7XPeeHcUMGtnZ2c1Z5aYKxQor0d+2kDMcnSCjD
         PzHg==
X-Gm-Message-State: AFqh2krqWlHbYpMODkzaWfrZw/Ia1mUc+3vZzIzJw17hl0lgRYw8udRG
        soVJhyfWDgmhGebyt59m/hc=
X-Google-Smtp-Source: AMrXdXvq5+IviY9icd7Uv84hidwJgaM47kFGEbBBfw28Iu8YYIfMBDU6B/G8MYa9JeIhQnUjcaMMzA==
X-Received: by 2002:a19:5211:0:b0:4b5:6042:d136 with SMTP id m17-20020a195211000000b004b56042d136mr12328066lfb.22.1675098860676;
        Mon, 30 Jan 2023 09:14:20 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v25-20020a056512349900b004d57ca1c96csm880573lfr.172.2023.01.30.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:14:20 -0800 (PST)
Date:   Mon, 30 Jan 2023 20:14:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] spi: dw_bt1: fix MUX_MMIO dependencies
Message-ID: <20230130171418.s7d5nnp6z7cxxpjz@mobilestation>
References: <20230130140156.3620863-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130140156.3620863-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:01:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting a symbol with additional dependencies requires
> adding the same dependency here:
> 
> WARNING: unmet direct dependencies detected for MUX_MMIO
>   Depends on [n]: MULTIPLEXER [=y] && OF [=n]
>   Selected by [y]:
>   - SPI_DW_BT1 [=y] && SPI [=y] && SPI_MASTER [=y] && SPI_DESIGNWARE [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
> 
> Drop the 'select' here to avoid the problem. Anyone using
> the dw-bt1 SPI driver should make sure they include the
> mux driver as well now.
> 
> Fixes: 7218838109fe ("spi: dw-bt1: Fix undefined devm_mux_control_get symbol")
> Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
> Link: https://lore.kernel.org/all/20221218192523.c6vnfo26ua6xqf26@mobilestation/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/spi/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 61fffc8eecc7..711c1c3bbd78 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -295,7 +295,6 @@ config SPI_DW_BT1
>  	tristate "Baikal-T1 SPI driver for DW SPI core"
>  	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
>  	select MULTIPLEXER
> -	select MUX_MMIO
>  	help
>  	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
>  	  controllers. Two of them are pretty much normal: with IRQ, DMA,
> -- 
> 2.39.0
> 
