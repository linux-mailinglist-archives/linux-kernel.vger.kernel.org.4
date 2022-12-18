Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E964FF18
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiLROWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLROWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:22:43 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD928B4BD;
        Sun, 18 Dec 2022 06:22:40 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f20so6744808lja.4;
        Sun, 18 Dec 2022 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddM49am3SRjYdaMOdig5YnBjDLqlY8c4aLnn9nULA3Y=;
        b=gy/Qs4C2K7q98DPzcI+2XrUtChI7tO1q3RoaGyg4YErTY556/IFpyEsnCFKYiD+UAW
         XNLLSptbgfDe/GfP0csObzc3plsEkJ1thb0ETeghXKaQdj+b+kPTs13S043vOJvcs/gl
         XlLfVn11WQ9AR96ydWnSwlgvXb84aGb1x7sfDwg0VQ8zCBqcXhyeWptCnp+agf2FusKb
         WhKahUs7ISRB0WSwAMKuSSV6zexYYNsx2NA0Ui1lcBTfw22dnO4a/AhW0iAZ49Sr5jYQ
         PNr5PeJ7IXPv23C6rYspIcMu60TLi3Nfq4pJjdFxV3bcbJHlk6/uzFhPBZCjyxyVplt3
         foxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddM49am3SRjYdaMOdig5YnBjDLqlY8c4aLnn9nULA3Y=;
        b=wtDkuNJDsGG3rA1Piv/YfI8Tlkth5O9c83O2VYB7NtS87+0n5r2d57HOYc7bu93yOx
         fLg6WS+yGXyBWuQMAnBWkOC5Tx1HnwngrdPAdls2wG176HHH2qeKWwNU2E+2UZUPH8ZN
         f/qAo5e80AUgpg4TZZDBGHLQ4OJNE3Deq4pt99pC9HfjHocLP1qDGI6W2dINF6AWjjDU
         JNkXSCGdeRUHnwjbWntxJBaolKMUw3rWubOMUEVGGU+b/vb0i7W67wkeQn6WkWXhdGN/
         00W968bgRL8Fk2MOC4pSGiK+K/NkMPjaDM4A1QBTpxplvz6LCkOBqlYBFcs414VYka89
         hsOQ==
X-Gm-Message-State: ANoB5pn/Rzc3IsCTCYBLaqFMW2e3K1hjmcQOvDEtGozpM8K87ddb0ZRy
        g6kyhy5sEo9AriNTbCABl8A=
X-Google-Smtp-Source: AA0mqf5W3CsG/9L9n1A+HudXfB1S+WWJ0ZLGz9NH/rjCWpl/1EpnoXHKDeTbDOdEQN9fIkgArNBT6Q==
X-Received: by 2002:a2e:b530:0:b0:27a:cd8:dcf with SMTP id z16-20020a2eb530000000b0027a0cd80dcfmr9448315ljm.39.1671373358931;
        Sun, 18 Dec 2022 06:22:38 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t24-20020a2e8e78000000b0027a13ad14afsm548352ljk.125.2022.12.18.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 06:22:38 -0800 (PST)
Date:   Sun, 18 Dec 2022 17:22:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw_bt1: fix MUX_MMIO dependencies
Message-ID: <20221218142231.qhczawk2zhpgh6dl@mobilestation>
References: <20221215165247.1723462-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215165247.1723462-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On Thu, Dec 15, 2022 at 05:52:34PM +0100, Arnd Bergmann wrote:
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
> Alternatively, we could drop this 'select' and require users to manually
> put it into their .config as we do for other drivers.

Thanks for the patch. Seeing the driver is only implicitly dependent
from the mux-mmio driver (via the device described in the device tree
blob) I'd suggest to either drop the MUX_MMIO config reverse
dependency or convert it to the weak one - 'imply' (if it will solve
the problem).

-Serge(y)

> 
> Fixes: 7218838109fe ("spi: dw-bt1: Fix undefined devm_mux_control_get symbol")
> Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/spi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3b1c0878bb85..1884e4083088 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -294,6 +294,7 @@ config SPI_DW_MMIO
>  config SPI_DW_BT1
>  	tristate "Baikal-T1 SPI driver for DW SPI core"
>  	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> +	depends on OF
>  	select MULTIPLEXER
>  	select MUX_MMIO
>  	help
> -- 
> 2.35.1
> 
