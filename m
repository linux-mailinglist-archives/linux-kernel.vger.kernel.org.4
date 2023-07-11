Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535F74F06B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjGKNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjGKNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:39:44 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608E1700
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:39:36 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJDaT-0008Kg-GE; Tue, 11 Jul 2023 15:39:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] phy: rockchip: phy-rockchip-typec: Use
 devm_platform_get_and_ioremap_resource()
Date:   Tue, 11 Jul 2023 15:39:28 +0200
Message-ID: <4152701.ElGaqSPkdT@phil>
In-Reply-To: <20230705090126.26854-2-frank.li@vivo.com>
References: <20230705090126.26854-1-frank.li@vivo.com>
 <20230705090126.26854-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juli 2023, 11:01:24 CEST schrieb Yangtao Li:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Though I guess we should check if the res variable can be removed
too.

devm_platform_get_and_ioremap_resource() checks for its "res"
parameter to be not-NULL. So if nothing in the driver itself
is using the actual resource, res could be removed and get
replaced by "NULL" when calling devm_platform_get_and_ioremap_resource()


Heiko

> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 8b1667be4915..4efcb78b0ab1 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -1116,8 +1116,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	tcphy->base = devm_ioremap_resource(dev, res);
> +	tcphy->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(tcphy->base))
>  		return PTR_ERR(tcphy->base);
>  
> 




