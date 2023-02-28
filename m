Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07916A585D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjB1LfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjB1LfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:35:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFB1986
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C33DC61040
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84585C433D2;
        Tue, 28 Feb 2023 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677584075;
        bh=muoZu13YFFbagFg23JYJg8JMsjdpqc+iNwTBr4JKquk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=QKPcWbUrc7bNKd2lBTwd2r/0FYpp/NdGnxHB1pH29oDAkW4JgrRgQDZY/RnlTGB7z
         hHOHA6gR2nXbv5P5RqTRIoyowqAK5gjIxzp6jcvAr092hwaxVu2REX3m738/CzPvRE
         8I0/vEJa8smf/cKBuYWTo2vdM75IujB+wgpBnovhydHOKT5VSc4B+kpOppY/brj31M
         6g7oDrppN7lGf8UUP6/PybJx0G5Znrn63XHVz9UYgAE/4OmBMfbwHEoVOtmtUPmIHE
         ydWq7FazirRoavFG6YRPgtUxwc7ZsYGhNcL04n6W/Ge72eHNK4kl2/LdCRwrA/H91g
         ai7uJCvaL1q6w==
Message-ID: <7037a310-dca0-3486-e560-18ac8c127e26@kernel.org>
Date:   Tue, 28 Feb 2023 12:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] net: dsa: b53: mdio: Add optional reset gpio
Content-Language: en-US
To:     Paul Geurts <paul.geurts@prodrive-technologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
 <20221212135640.3590545-5-paul.geurts@prodrive-technologies.com>
 <AM0PR02MB5524BDEBE80C82BC689C3DD6BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <AM0PR02MB5524BDEBE80C82BC689C3DD6BDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 20:44, Paul Geurts wrote:
> Some Broadcom Ethernet switch devices feature a reset pin driven by GPIO.
> Provide the option to specify a reset gpio.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>  drivers/net/dsa/b53/b53_mdio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c index 8b422b298cd5..32af5881834c 100644
> --- a/drivers/net/dsa/b53/b53_mdio.c
> +++ b/drivers/net/dsa/b53/b53_mdio.c
> @@ -22,6 +22,7 @@
>  #include <linux/delay.h>
>  #include <linux/brcmphy.h>
>  #include <linux/rtnetlink.h>
> +#include <linux/gpio/consumer.h>
>  #include <net/dsa.h>
>  
>  #include "b53_priv.h"
> @@ -303,6 +304,14 @@ static int b53_mdio_probe(struct mdio_device *mdiodev)
>  		return -ENODEV;
>  	}
>  
> +	/* Try to get a reset GPIO and get the switch out of reset when its there */
> +	mdiodev->reset_gpio = devm_gpiod_get_optional(&mdiodev->dev, "reset", GPIOD_OUT_HIGH);

Aren't you adding now undocumented property? Does your DTS passes
dtbs_check?

Best regards,
Krzysztof

