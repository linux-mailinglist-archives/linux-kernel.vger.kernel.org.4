Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC062C054
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiKPOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiKPN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:58:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322411B1E7;
        Wed, 16 Nov 2022 05:55:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2435988pjc.0;
        Wed, 16 Nov 2022 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSWYalwf+bf6KkReRCTGSxhMbvjbEeV9ckPBymc027w=;
        b=D6rz4DWIklKq67U6tVHPdzRfnfHf5nC9hwr6c1H2FNt8TZY4zkAEz6MEiXnBMGiQvI
         wG9v39SukQ+3GzZLjNa2Yei+NQQQ5wdrTp9mf40A/hwKWTfU0/c2/fzcGy3zeaJ/qXiM
         ks+O1Be7vk/A6qE2DzBW5+rXl2iY0W+5xAbNHENdt5jcCrboH1jFLdA7R5+YVj6NKlly
         JsTIV4isUjUwfj2NCPSTNiRLmeNBQ1JHCmVZ8kgfO+QcpMgj2zZ8FSHKOrVKI1+AI/Oz
         FCqAifR18yvA6+dO2b7UVPGTcdCtoNzyCvqxMYEfACR4w4x0ClUUX7jNRq2SvDlFc7hx
         vR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSWYalwf+bf6KkReRCTGSxhMbvjbEeV9ckPBymc027w=;
        b=3cCulgRExdRxl7PkCz1lDn1F08XlnMwK1/uYCfRSpLYxF5UbSUHWXVtGFUOJfYWlhK
         uVrvIcYceQMekwpdVkrTsVt/j7Bt809hnyzJhB3W08kGaLPkvRaZycOG7h0Q5NQRL6xw
         p7l5VOfZaKXkZvH6j5jRTbLAT7aXKgvUiS12Nwkf2U5OFQ2nRbnCsV8ntSUEEqv02yDG
         vdaMg4S2GPe4wvJiqAEXyNRfVvI4bhKsRIGtpZx8/DwaRTQJ6WjG+/zVPEa7lAJ3wMZe
         Kml8Xn44sGKazMjVbKozI3OqUstPf2boQEud06LkJTXNuTR7K/ZAI8WGTdQYGWkMq/8Z
         C6lg==
X-Gm-Message-State: ANoB5pndx2by6MkbqIJ1xB8MFmayF0baf64iqlTrE4qAQhUtHzyK0DlM
        Mba4pYd7bMRK1q5i7eopu/8=
X-Google-Smtp-Source: AA0mqf5nRzKr/LTwaiR9xgiihHLCehwGtyQfOKHIF9WlN9lSrWL0Z8pNcx4yZhUh4vbjVluSJ/Lo1g==
X-Received: by 2002:a17:90a:1b61:b0:213:cfb4:719 with SMTP id q88-20020a17090a1b6100b00213cfb40719mr3808743pjq.188.1668606901702;
        Wed, 16 Nov 2022 05:55:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001871461688esm12291304plg.175.2022.11.16.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:55:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Nov 2022 05:55:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     wim@linux-watchdog.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        bbrezillon@kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: at91sam9_wdt: use devm_request_irq to avoid
 missing free_irq() in error path
Message-ID: <20221116135500.GC3498904@roeck-us.net>
References: <20221116094950.3141943-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116094950.3141943-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:49:50PM +0800, ruanjinjie wrote:
> free_irq() is missing in case of error in at91_wdt_init(), use
> devm_request_irq to fix that.
> 
> Fixes: 5161b31dc39a ("watchdog: at91sam9_wdt: better watchdog support")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


> ---
>  drivers/watchdog/at91sam9_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 292b5a1ca831..b9e8572c707d 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -206,7 +206,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
>  			 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
>  
>  	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
> -		err = request_irq(wdt->irq, wdt_interrupt,
> +		err = devm_request_irq(dev, wdt->irq, wdt_interrupt,
>  				  IRQF_SHARED | IRQF_IRQPOLL |
>  				  IRQF_NO_SUSPEND,
>  				  pdev->name, wdt);
> -- 
> 2.25.1
> 
