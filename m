Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00463E9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLAGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLAGgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:36:25 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 22:36:23 PST
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083386598
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:36:23 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8215DDD02B;
        Thu,  1 Dec 2022 06:18:41 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tGMXzyLGw1aJ; Thu,  1 Dec 2022 06:18:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id ABBABDD17D;
        Thu,  1 Dec 2022 06:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WhquvPf26IpU; Thu,  1 Dec 2022 06:18:40 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2CC03DCFC6;
        Thu,  1 Dec 2022 06:18:40 +0000 (UTC)
Date:   Thu, 1 Dec 2022 07:31:10 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     zhang.songyi@zte.com.cn
Cc:     arnd@arndb.de, robert.jarzmik@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] pxa: Remove dev_err() after platform_get_irq()
Message-ID: <Y4hKLp2IZkL52l2F@demiurge.local>
References: <202211301556064978448@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211301556064978448@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:56:06PM +0800, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> /drivers/soc/pxa/ssp.c:150:2-9: line 150 is redundant because
> platform_get_irq() already prints an error
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  drivers/soc/pxa/ssp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
> index 93449fb3519e..7085901b4e4b 100644
> --- a/drivers/soc/pxa/ssp.c
> +++ b/drivers/soc/pxa/ssp.c
> @@ -147,7 +147,6 @@ static int pxa_ssp_probe(struct platform_device *pdev)
> 
>         ssp->irq = platform_get_irq(pdev, 0);
>         if (ssp->irq < 0) {
> -               dev_err(dev, "no IRQ resource defined\n");
>                 return -ENODEV;
>         }
> 
> --
> 2.15.2
