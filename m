Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C316E5D34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDRJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDRJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB914ED0;
        Tue, 18 Apr 2023 02:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ECF262490;
        Tue, 18 Apr 2023 09:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BBEC433EF;
        Tue, 18 Apr 2023 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681809555;
        bh=Svp3HE2lDRT/RkOmVvDK0r8RUqSzBH52rMiCcg32II8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je0VA4fz+MdWYlrnt12/fFEEzKkm2vWeNU2YU6wB8D3jJdtd9WRpxprMEOll2jdov
         VappEiiIgtM+412XgeUKjX0aX/s+Kzygb1TwpQRd629JXlVM3CrdWrYpu5ci5gaINz
         x44v4kb5giF6jUcCx9p9KLHkOzLq4BCygwiQtXzQ=
Date:   Tue, 18 Apr 2023 11:19:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Yang <lidaxian@hust.edu.cn>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()
Message-ID: <2023041832-parakeet-claim-b458@gregkh>
References: <20230418090758.18756-1-lidaxian@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418090758.18756-1-lidaxian@hust.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:07:57PM +0800, Li Yang wrote:
> Smatch reports:
> drivers/usb/phy/phy-tahvo.c: tahvo_usb_probe()
> warn: missing unwind goto?
> 
> After geting irq, if ret < 0, it will return without error handling to
> free memory.
> Just add error handling to fix this problem.
> 
> Fixes: 0d45a1373e66 ("usb: phy: tahvo: add IRQ check")
> Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is found by static analysis, and the patch remains untest.
> ---
>  drivers/usb/phy/phy-tahvo.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> index f2d2cc586c5b..184a5f3d7473 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -390,8 +390,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  	dev_set_drvdata(&pdev->dev, tu);
>  
>  	tu->irq = ret = platform_get_irq(pdev, 0);
> -	if (ret < 0)
> -		return ret;
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not get irq: %d\n",
> +				ret);

Why print this out?  And why the odd line-wrapping?

thanks,

greg k-h
