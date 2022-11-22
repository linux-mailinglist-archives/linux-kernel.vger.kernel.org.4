Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23806337FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiKVJJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiKVJIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:08:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79845EF2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:08:43 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oxPGd-0001NA-6P; Tue, 22 Nov 2022 10:08:35 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oxPGc-0004Sf-0k; Tue, 22 Nov 2022 10:08:34 +0100
Date:   Tue, 22 Nov 2022 10:08:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     ye.xingchen@zte.com.cn
Cc:     shawnguo@kernel.org, chi.minghao@zte.com.cn,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20221122090833.5nqm52jzoxxxu2sj@pengutronix.de>
References: <202211220940526866294@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211220940526866294@zte.com.cn>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chi,

thanks for your patch.

On 22-11-22, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

LGTM, feel free to add my

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  drivers/bus/imx-weim.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 828c66bbaa67..2a6b4f676458 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -263,7 +263,6 @@ static int weim_parse_dt(struct platform_device *pdev)
>  static int weim_probe(struct platform_device *pdev)
>  {
>  	struct weim_priv *priv;
> -	struct resource *res;
>  	struct clk *clk;
>  	void __iomem *base;
>  	int ret;
> @@ -273,8 +272,7 @@ static int weim_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	/* get the resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 
> -- 
> 2.25.1
> 
> 
