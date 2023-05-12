Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7372700820
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbjELMcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbjELMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:31:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C714340;
        Fri, 12 May 2023 05:31:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aafa41116fso68219765ad.1;
        Fri, 12 May 2023 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683894657; x=1686486657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgmnmf2ymuGoE3rTvNE6Y+wZktuyVcuE0gYUTPiZ1N0=;
        b=OsEtrs9AgO9b/dg8PrEkoQPyDZN4hrLmQXyKGpv4bS+/A7DwMDFISjGEpiF/zW5L2d
         B+yjvHE7wNXagjGDwG13Idvl7DWGKumZJ4Bw4uvjIqdtB+Hq6iWOgKhUJVNVeLVEZSeM
         gihnWc0qJNKYI9nG08dHRBQAoprp54KI/zgSUZzlr7IUUTFjY7ZB+pNaLeJY2+jOJGXF
         zL0XiWVUZ2fDKKMjGpU4kOGbHsCFbR7ZujpbVKJrBV2DI5OzKIPg3HgRP/gfgvjdcl/0
         NDhfMJi9cEERrZ/vBbtInhndvS75wegT+p5bcY03bab5v92TXoZuRUOHlMMHbh2H3kIe
         F2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683894657; x=1686486657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgmnmf2ymuGoE3rTvNE6Y+wZktuyVcuE0gYUTPiZ1N0=;
        b=TFPsRBEIonhf0NyP42aTRmfZopOnZFIemNa5x7wf5ujtJjNfpbrV21gAc19qHCDPt1
         ouba182Yg3M3igIwF8GOL707hwlj0ihkZajQL4ZN5Q7jJ0vP/XHka7njW9fiqBsQ6BJ0
         c53Z5RZJ8zWs9g/GLDD+HDy1NubQT/s1PswHndNjVUY31DwC8dlLj5EHGPufh9pLsknE
         hvpe0bUA774YgeniiKh8rFupIe2QvE39rsNN72vdYhGtZu09JBDVWgry1UZSkfWZe5pa
         h8zzzziTsnKaZaFH3tqE/l+PvtvvugWQe4gvL2Vo6v8wyRRxt4wJ3iGydZJj8lK3pR/W
         byVw==
X-Gm-Message-State: AC+VfDwjHfCZfwkfiQWSoFV1wcPcA1fO24EGWPOgHO/LuGHFUvhJD5lx
        oow/7IBqq2vgPRsfluFahu1h4OirRdk=
X-Google-Smtp-Source: ACHHUZ7dYxrzIgrFpdLbRQaOS7qMx/qMp+mM1g8R8+pvXgvZpIoUk54KvkC2gzXL7SN4Yi18lGF3nw==
X-Received: by 2002:a17:902:dac3:b0:1ad:b459:a7e4 with SMTP id q3-20020a170902dac300b001adb459a7e4mr11323211plx.7.1683894657619;
        Fri, 12 May 2023 05:30:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001aaeaa27dd5sm7759887plt.252.2023.05.12.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:30:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 May 2023 05:30:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: loongson1_wdt: Add DT support
Message-ID: <f9a15bd7-6346-4ae7-97f1-98480da83a8f@roeck-us.net>
References: <20230511121159.463645-1-keguang.zhang@gmail.com>
 <20230511121159.463645-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511121159.463645-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:11:59PM +0800, Keguang Zhang wrote:
> This patch adds the of_match_table to enable DT support
> of Loongson-1 watchdog driver.
> And modify the parameter of devm_clk_get_enabled() accordingly.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V1 -> V2: Change the wildcard compatible string to specific ones
>           Use of_match_ptr() to aviod the build error when CONFIG_OF=n
> ---
>  drivers/watchdog/loongson1_wdt.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> index 3c651c50a98c..4ac7810a314d 100644
> --- a/drivers/watchdog/loongson1_wdt.c
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  
> @@ -112,7 +113,7 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(drvdata->base))
>  		return PTR_ERR(drvdata->base);
>  
> -	drvdata->clk = devm_clk_get_enabled(dev, pdev->name);
> +	drvdata->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(drvdata->clk))
>  		return PTR_ERR(drvdata->clk);
>  
> @@ -144,10 +145,20 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id ls1x_wdt_dt_ids[] = {
> +	{ .compatible = "loongson,ls1b-wdt", },
> +	{ .compatible = "loongson,ls1c-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);
> +#endif
> +
>  static struct platform_driver ls1x_wdt_driver = {
>  	.probe = ls1x_wdt_probe,
>  	.driver = {
>  		.name = "ls1x-wdt",
> +		.of_match_table = of_match_ptr(ls1x_wdt_dt_ids),
>  	},
>  };
>  
> -- 
> 2.39.2
> 
