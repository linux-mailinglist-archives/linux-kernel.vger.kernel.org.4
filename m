Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE362510D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiKKCtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiKKCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:49:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F469DED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 697EA61E7E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67ECC433D6;
        Fri, 11 Nov 2022 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668134776;
        bh=hK0Hb0SQpdbGB49liGsSZv160x+zEaDEMydY7ou7aws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lILdkFCMaBoscWIl4NtDFMMToWNX8NSQ+0QtDj8UNCC2TvTO4PVAOKcCUzSLWiR2D
         p2BpuIgBHL/WJ1x7APKPq2tvCBwPJmM2sHWZXL7krm8U7d4IcBuMb8cabyWoaQg9iu
         Y3bLQUpNyjvNaTaEM+m4dCq+hiTcMLcYAJl1jNBMSTrUQJ1o6cn9SY0iL01rLRl7E2
         Itg05poKP0+wV7qxhYD1nu+REbsuIhgy9HQaskB7EAYG8H8kwkiu1fxpOoRBV9WD8j
         ShWS7cHrLyN13EzvBwbctgDztLRAdWTLxLo1R/BbxhqclyuhTMN5W3FI7CnWpItxV6
         BJJpU30cYeqXg==
Date:   Fri, 11 Nov 2022 10:46:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx8m: Increase the clock enable before reading the
 register
Message-ID: <20221111024607.GH125525@dragon>
References: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:14:18PM +0800, Xiaolei Wang wrote:
> When executing kdump to start the second kernel,
> since IMX-OCOTP has turned off the clock, the clock
> needs to be re-enabled, otherwise the system will hang.
> 
> Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")

Are you saying this fixes a regression caused by ac34de14ac30?

Shawn

> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index cc57a384d74d..28144c699b0c 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -11,6 +11,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/of.h>
> +#include <linux/clk.h>
>  
>  #define REV_B1				0x21
>  
> @@ -56,6 +57,7 @@ static u32 __init imx8mq_soc_revision(void)
>  	void __iomem *ocotp_base;
>  	u32 magic;
>  	u32 rev;
> +	struct clk *clk;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
>  	if (!np)
> @@ -63,6 +65,13 @@ static u32 __init imx8mq_soc_revision(void)
>  
>  	ocotp_base = of_iomap(np, 0);
>  	WARN_ON(!ocotp_base);
> +	clk = of_clk_get_by_name(np, NULL);
> +	if (!clk) {
> +		WARN_ON(!clk);
> +		return 0;
> +	}
> +
> +	clk_prepare_enable(clk);
>  
>  	/*
>  	 * SOC revision on older imx8mq is not available in fuses so query
> @@ -79,6 +88,8 @@ static u32 __init imx8mq_soc_revision(void)
>  	soc_uid <<= 32;
>  	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
>  
> +	clk_disable_unprepare(clk);
> +	clk_put(clk);
>  	iounmap(ocotp_base);
>  	of_node_put(np);
>  
> -- 
> 2.25.1
> 
