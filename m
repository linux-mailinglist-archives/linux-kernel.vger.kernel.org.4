Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2888D6980CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBOQY6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 11:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBOQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:24:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C232E57
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:24:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pSKaR-0006lE-3r; Wed, 15 Feb 2023 17:24:51 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pSKaG-0059Cl-4j; Wed, 15 Feb 2023 17:24:41 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pSKaG-000AxO-Lk; Wed, 15 Feb 2023 17:24:40 +0100
Message-ID: <11f16ccda4f3809caa5b43a955472a7c6e83a8f1.camel@pengutronix.de>
Subject: Re: [PATCH] reset: ath79: Use
 devm_platform_get_and_ioremap_resource()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     ye.xingchen@zte.com.cn
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 15 Feb 2023 17:24:40 +0100
In-Reply-To: <202302151705068837948@zte.com.cn>
References: <202302151705068837948@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2023-02-15 at 17:05 +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> ---
>  drivers/reset/reset-ath79.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
> index e48d8fcb3133..801a65db2e15 100644
> --- a/drivers/reset/reset-ath79.c
> +++ b/drivers/reset/reset-ath79.c
> @@ -86,7 +86,6 @@ static int ath79_reset_restart_handler(struct notifier_block *nb,
>  static int ath79_reset_probe(struct platform_device *pdev)
>  {
>  	struct ath79_reset *ath79_reset;
> -	struct resource *res;
>  	int err;
> 
>  	ath79_reset = devm_kzalloc(&pdev->dev,
> @@ -96,8 +95,7 @@ static int ath79_reset_probe(struct platform_device *pdev)
> 
>  	platform_set_drvdata(pdev, ath79_reset);
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ath79_reset->base = devm_ioremap_resource(&pdev->dev, res);
> +	ath79_reset->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);


Thank you for the patches. Since the resource not used, it seems to me
that devm_platform_ioremap_resource() would be a better fit.

regards
Philipp
