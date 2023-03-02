Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367B36A87BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCBRTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCBRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:19:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4768F113EC;
        Thu,  2 Mar 2023 09:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEC9DB811F8;
        Thu,  2 Mar 2023 17:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A95AC4339B;
        Thu,  2 Mar 2023 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677777546;
        bh=i3x0hEAvwMO1Hlbu0xv9iys3WfKl3C4x9NRYdvyKmeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SelwuPdr4PrPXwRyd32ta13tkvqBCvRh3Y9QJzAAIV3zVdE9LYHzj6ARVXyXI10Mv
         TU00hCzfct5U7XTkPjE32lOH1k05XJQh9i1vA5yG6RmzbJZrot5TTpxY7kO7Q21qer
         bKjHgAudKZd4un79mf6y/KZ+pPF/r+9SH7HVJkjLtYyXot+18efrxHgl+9n2cIu/rC
         gLoUWQi7a+w4BH471vWihyoc+g6j95RMBkQQS0Fzx9seBw2HIKIcYXk3Jve8QWkj8y
         p6zzvrTo8XBNm5o6YH3QQHUUP2GOvNst+TdJhiprNTiQ9MZs8NlJLns4Bt+Jn/TCaJ
         8NQ+25i89lmgg==
Received: by pali.im (Postfix)
        id 68ED8AA6; Thu,  2 Mar 2023 18:19:03 +0100 (CET)
Date:   Thu, 2 Mar 2023 18:19:03 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] platform/x86: dell: dell-smo8800: Convert to
 platform remove callback returning void
Message-ID: <20230302171903.mzwcxe4pfefknds3@pali>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
 <20230302144732.1903781-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302144732.1903781-11-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2023 15:47:13 Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/platform/x86/dell/dell-smo8800.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
> index 8d6b7a83cf24..f7ec17c56833 100644
> --- a/drivers/platform/x86/dell/dell-smo8800.c
> +++ b/drivers/platform/x86/dell/dell-smo8800.c
> @@ -154,14 +154,13 @@ static int smo8800_probe(struct platform_device *device)
>  	return err;
>  }
>  
> -static int smo8800_remove(struct platform_device *device)
> +static void smo8800_remove(struct platform_device *device)
>  {
>  	struct smo8800_device *smo8800 = platform_get_drvdata(device);
>  
>  	free_irq(smo8800->irq, smo8800);
>  	misc_deregister(&smo8800->miscdev);
>  	dev_dbg(&device->dev, "device /dev/freefall unregistered\n");
> -	return 0;
>  }
>  
>  /* NOTE: Keep this list in sync with drivers/i2c/busses/i2c-i801.c */
> @@ -180,7 +179,7 @@ MODULE_DEVICE_TABLE(acpi, smo8800_ids);
>  
>  static struct platform_driver smo8800_driver = {
>  	.probe = smo8800_probe,
> -	.remove = smo8800_remove,
> +	.remove_new = smo8800_remove,
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.acpi_match_table = smo8800_ids,
> -- 
> 2.39.1
> 
