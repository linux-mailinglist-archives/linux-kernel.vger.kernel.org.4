Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F1698E48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBPIHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:07:17 -0500
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3EF1DB90
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:07:15 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SZINpy0rG7c7GSZINpcPrN; Thu, 16 Feb 2023 09:07:13 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 16 Feb 2023 09:07:13 +0100
X-ME-IP: 86.243.2.178
Message-ID: <736566bd-b8bc-07d0-bb07-b8abb8bc09eb@wanadoo.fr>
Date:   Thu, 16 Feb 2023 09:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 4/5] usb: fotg210: Switch to use dev_err_probe()
Content-Language: fr, en-US
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
 <20230120154437.22025-4-andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230120154437.22025-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/01/2023 à 16:44, Andy Shevchenko a écrit :
> Switch to use dev_err_probe() to simplify the error paths and
> unify message template.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/usb/fotg210/fotg210-core.c | 6 ++----
>   drivers/usb/fotg210/fotg210-hcd.c  | 8 +++-----
>   drivers/usb/fotg210/fotg210-udc.c  | 2 +-
>   3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
> index c06f8eb3acbd..ce00d9407ce5 100644
> --- a/drivers/usb/fotg210/fotg210-core.c
> +++ b/drivers/usb/fotg210/fotg210-core.c
> @@ -50,10 +50,8 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
>   	int ret;
>   
>   	map = syscon_regmap_lookup_by_phandle(np, "syscon");
> -	if (IS_ERR(map)) {
> -		dev_err(dev, "no syscon\n");
> -		return PTR_ERR(map);
> -	}
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map), "no syscon\n");
>   	fotg->map = map;
>   	wakeup = of_property_read_bool(np, "wakeup-source");
>   
> diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
> index 5a934f5343a7..613d29f04bcb 100644
> --- a/drivers/usb/fotg210/fotg210-hcd.c
> +++ b/drivers/usb/fotg210/fotg210-hcd.c
> @@ -5575,8 +5575,7 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
>   	hcd = usb_create_hcd(&fotg210_fotg210_hc_driver, dev,
>   			dev_name(dev));
>   	if (!hcd) {
> -		dev_err(dev, "failed to create hcd\n");
> -		retval = -ENOMEM;
> +		retval = dev_err_probe(dev, -ENOMEM, "failed to create hcd\n");
>   		goto fail_create_hcd;
>   	}
>   
> @@ -5600,7 +5599,7 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
>   
>   	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
>   	if (retval) {
> -		dev_err(dev, "failed to add hcd with err %d\n", retval);
> +		dev_err_probe(dev, retval, "failed to add hcd\n");
>   		goto failed_put_hcd;
>   	}
>   	device_wakeup_enable(hcd->self.controller);
> @@ -5611,8 +5610,7 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
>   failed_put_hcd:
>   	usb_put_hcd(hcd);
>   fail_create_hcd:
> -	dev_err(dev, "init %s fail, %d\n", dev_name(dev), retval);
> -	return retval;
> +	return dev_err_probe(dev, retval, "init %s fail\n", dev_name(dev));

Hi,
the patch is already applied, but is dev_name(dev) needed here?

CJ

>   }
>   
>   /*
> diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
> index 18d254125186..5b515f5cb2d7 100644
> --- a/drivers/usb/fotg210/fotg210-udc.c
> +++ b/drivers/usb/fotg210/fotg210-udc.c
> @@ -1258,7 +1258,7 @@ int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg)
>   	ret = request_irq(irq, fotg210_irq, IRQF_SHARED,
>   			  udc_name, fotg210);
>   	if (ret < 0) {
> -		dev_err(dev, "request_irq error (%d)\n", ret);
> +		dev_err_probe(dev, ret, "request_irq error\n");
>   		goto err_req;
>   	}
>   

