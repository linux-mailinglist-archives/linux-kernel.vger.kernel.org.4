Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD85B4FA5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiIKPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIKPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:31:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C3220C1;
        Sun, 11 Sep 2022 08:31:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m15so10946770lfl.9;
        Sun, 11 Sep 2022 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FR2LQYhmh24/jvbFJEqUXHAimtlXaB7dyxf/F1JlBQE=;
        b=Xyf5zmpfCpIpLkgjhtnwn32uL2/+UFtLA/MPznDiaLP5p2Y9JdopnvvuzQKIinV2je
         pwQxupWCt8jJ3aCCa5lmP+XyBYEsZP4HpHox5gALXpgP3gz9WJCgsGvINMNVdNpliD9L
         32RzpD7wiwia9Et1Dd6768qrjfPN0yYwh0SiEHzRmgGftQWVYRvjsPH7Ax5eRSTrvZFr
         64nUl2MUFgRdTwpt8lwl/fHfF7shO9pJqr8qgElOnmYlL6/9YU/GN15vK4DUXBQYfWka
         TV+N5/d2u/oolAO0jBGgnqhCI+fI2Az/snxZkHwtrat/AU74gEmPJvhpuiBMIUn+7Udk
         3WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FR2LQYhmh24/jvbFJEqUXHAimtlXaB7dyxf/F1JlBQE=;
        b=Txgj9rVlDECc1AMTs2vLBFSVXAXg2YrnjCe99Q9nlBYR2oJ69l19hpUsMN8kuMvE6i
         zs8eAhm5NeYX5NUZfYYbZhuY4qQe2qYF1n/smTa6NHgBkKEI8iwOPHNHvkPjkm+6F4n9
         4U50Iv7PvUIv/AtwrYzRjKJs513KY01a4Bw0823EadFh4gzJu2FHdt9/A+VnGM3jOV2I
         qkDRWEZ2aD/cxFqu8LogVSUT5ZQj0O0a33xoClgM+OqTR7Fk0GXN0sAjIT1/yrLCxvZh
         0gaVM8NnbsmA4yoJwglFv+lW/blsopeCtHRyc9RjsEJHa8B0uJO12RBm4E1gcLg8poKM
         wopQ==
X-Gm-Message-State: ACgBeo0VFlvR9S6/fflSVHpGLqOmcSulHQtW+iPvGFu+2iWfT2oaU/9f
        D65kTp/2S/ygntDmDArTo3g=
X-Google-Smtp-Source: AA6agR7t1KEji9tYMUVaP/hOTupdrCJN/pmKwD0ss07/MYSwxux+Ujy3fVjOwseVTTfInua0ppvMcw==
X-Received: by 2002:ac2:4e0f:0:b0:492:c214:9675 with SMTP id e15-20020ac24e0f000000b00492c2149675mr8016215lfr.614.1662910266938;
        Sun, 11 Sep 2022 08:31:06 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b00492c549f845sm651384lfc.1.2022.09.11.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 08:31:06 -0700 (PDT)
Date:   Sun, 11 Sep 2022 18:31:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MIPS: loongson32: Fix the validation failure of LS1B &
 LS1C Ethernet PHY
Message-ID: <20220911153104.e4ilb36xs3wc4z6a@mobilestation>
References: <20220818050019.1924408-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818050019.1924408-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,
Just so you know. This patch is supposed to be superseded with the next one:
https://lore.kernel.org/linux-mips/20220911072251.25024-1-keguang.zhang@gmail.com
* or with v2 of the later one.

-Sergey

On Thu, Aug 18, 2022 at 01:00:19PM +0800, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> The Ethernet of LS1B/LS1C doesn't work due to the stmmac driver
> using phylink_generic_validate() instead of stmmac_validate().
> Moreover the driver assumes the PHY interface mode
> passed in platform data is always supported.
> 
> stmmaceth stmmaceth.0 eth0: validation of gmii with support 00000000,00000000,000062cf and advertisement 00000000,00000000,000062cf failed: -EINVAL
> stmmaceth stmmaceth.0 eth0: stmmac_open: Cannot attach to PHY (error: -22)
> 
> This patch sets phy_interface field of platform data.
> 
> Fixes: 04a0683f7db4 ("net: stmmac: convert to phylink_generic_validate()")
> Fixes: d194923d51c9 ("net: stmmac: fill in supported_interfaces")
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  arch/mips/loongson32/common/platform.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> index 794c96c2a4cd..741aace80b80 100644
> --- a/arch/mips/loongson32/common/platform.c
> +++ b/arch/mips/loongson32/common/platform.c
> @@ -147,8 +147,10 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
>  	.phy_addr		= -1,
>  #if defined(CONFIG_LOONGSON1_LS1B)
>  	.interface		= PHY_INTERFACE_MODE_MII,
> +	.phy_interface		= PHY_INTERFACE_MODE_MII,
>  #elif defined(CONFIG_LOONGSON1_LS1C)
>  	.interface		= PHY_INTERFACE_MODE_RMII,
> +	.phy_interface		= PHY_INTERFACE_MODE_RMII,
>  #endif
>  	.mdio_bus_data		= &ls1x_mdio_bus_data,
>  	.dma_cfg		= &ls1x_eth_dma_cfg,
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.34.1
> 
