Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0374B2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGGONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:13:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB60B2;
        Fri,  7 Jul 2023 07:13:38 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qHmDG-0000Sg-8C; Fri, 07 Jul 2023 16:13:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/18] soc: rockchip: Mover power-domain driver to the genpd dir
Date:   Fri, 07 Jul 2023 16:13:33 +0200
Message-ID: <4517610.cEBGB3zze1@diego>
In-Reply-To: <20230707140434.723349-11-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 7. Juli 2023, 16:04:26 CEST schrieb Ulf Hansson:
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: <linux-rockchip@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I guess this is part of a bigger series moving these things around, so
Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/genpd/Makefile                                          | 1 +
>  drivers/genpd/rockchip/Makefile                                 | 2 ++
>  .../{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c}  | 0
>  drivers/soc/rockchip/Makefile                                   | 1 -
>  4 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/genpd/rockchip/Makefile
>  rename drivers/{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c} (100%)
> 
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index 286598ce7620..c178421e0cbc 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -6,3 +6,4 @@ obj-y					+= bcm/
>  obj-y					+= mediatek/
>  obj-y					+= qcom/
>  obj-y					+= renesas/
> +obj-y					+= rockchip/
> diff --git a/drivers/genpd/rockchip/Makefile b/drivers/genpd/rockchip/Makefile
> new file mode 100644
> index 000000000000..8fb9d88a3492
> --- /dev/null
> +++ b/drivers/genpd/rockchip/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ROCKCHIP_PM_DOMAINS)	+= pm-domains.o
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/genpd/rockchip/pm-domains.c
> similarity index 100%
> rename from drivers/soc/rockchip/pm_domains.c
> rename to drivers/genpd/rockchip/pm-domains.c
> diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
> index 05f31a4e743c..23d414433c8c 100644
> --- a/drivers/soc/rockchip/Makefile
> +++ b/drivers/soc/rockchip/Makefile
> @@ -4,5 +4,4 @@
>  #
>  obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
>  obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
> -obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
>  obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
> 




