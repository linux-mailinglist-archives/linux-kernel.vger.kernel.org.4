Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEF5ED567
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiI1GwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI1Gvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7833A38;
        Tue, 27 Sep 2022 23:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C90D2B81F0F;
        Wed, 28 Sep 2022 06:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B57C433C1;
        Wed, 28 Sep 2022 06:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664347802;
        bh=o+nRXqkkwdCJaeYY4UaIw9xe00VMoE3ss64Xo8fvh04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F2My4uoDUvyjqqbn3FHH4fLvaj3uNAF2UTVtsbk9sf6w71LInwqLU34TGzBOMdrLU
         N9XyIUqej/J6wnfp8LKgOFgQfWOM7ypFV5gPJLOw/zDVvur6hsuQLBCVJpwj3epH5O
         Tcvq4qps5/9KnrMAQOp+IfEBarnjwve4fRMqx3rvyCajUXKbsD4RRMHzf4ruffWUEi
         EWWtNREXGB/A7Kb9rFkZrKiKjZ7OeMPp7tFBr9+26Yk4PaPwZX1yhTPsu1H6A89Xpv
         S+pbwvUEdJMT9EmU0SBJIK0jepsAqqP0Buyuitod6aWVWbbHVbP4Y/3gnO4TP4RIeM
         wnu+zW3g7JhSw==
Message-ID: <8db6ca9c-6ceb-001e-3427-c7e320111d80@kernel.org>
Date:   Wed, 28 Sep 2022 09:49:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: cdns3: remove dead code
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926135922.24541-1-dzm91@hust.edu.cn>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220926135922.24541-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2022 16:59, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Smatch reports the following error:
> 
> drivers/usb/cdns3/cdns3-plat.c:113 cdns3_plat_probe() warn:
> platform_get_irq() does not return zero
> 
> From the document, platform_get_irq_byname_optional only returns
> non-zero value, and negative value on failure.
> 
> Fix this by removing the zero value checking.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
>  drivers/usb/cdns3/cdns3-plat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index dc068e940ed5..2bc5d094548b 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -110,8 +110,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  	cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
>  	if (cdns->wakeup_irq == -EPROBE_DEFER)
>  		return cdns->wakeup_irq;
> -	else if (cdns->wakeup_irq == 0)
> -		return -EINVAL;
>  
>  	if (cdns->wakeup_irq < 0) {
>  		dev_dbg(dev, "couldn't get wakeup irq\n");


cheers,
-roger
