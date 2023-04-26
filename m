Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1936EECD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjDZDxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjDZDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:53:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119E10FE;
        Tue, 25 Apr 2023 20:53:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso5253555b3a.0;
        Tue, 25 Apr 2023 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682481185; x=1685073185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T84k22guZdFj0eqvciEN7w/jnaWDxB129g0NkuXgv90=;
        b=nVQnxT7Ujq8l/BMZU4lBB8Sx6QfMieJZIORl0WfOVAkHd4Ndqr1MZnBOl8KIJzeN6w
         C2iiqk04sW5o8RuDPODdqOdQDYR5z8XBrV11wEmO13C4mUeTOWyW3pi4YD9FlfOypD9J
         f6q1v74Swu9Mnfu7kUcEVvxGFm+0xYmRXRe2Ah7/vRW8yboJ+33auKoMq6XoP5gW3WuE
         EqC0i69vre8oxxfZkHBQGa2vuTp4EJvgFlvc6EFIvdp3Q+Ls8Zh2rNOkHvP5OpuvNVlV
         8rVkvvXViYPOZ5UISih3GeVx2x7bK3iSkp6NVHPIx7jAZq0f4+j6Yd/Wb+b3SRfMkJe8
         C5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682481185; x=1685073185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T84k22guZdFj0eqvciEN7w/jnaWDxB129g0NkuXgv90=;
        b=hRVk7ZRYqggsUVZNGNdiXk6d4MXrFT7v1P0OOosLP7EP7tgcrTSOCYKk127wstydYA
         RPSDWuLZRw+TF3T7YEq/rZvl8mrU0jIGF6FjLJ6fMFRulxgriLnQS/P1P4uMZmWiMK7U
         NonA27O7E45ZjHyihx1pSD3J9t3cEYSJgMR/fB2i04YMnaKnPkpbXYI58T/ZmZZjlxih
         MmNqEECgMI4mRrhkVAFbzX3UBic6DDQI89P+3qWSdmUI3ZeffEUaW79Ecl4VeE7N29Lu
         hlw2zJs+gjPk96yPP9DwgvVuVIfOebOeYp8yupSLlQfIge2UMGvldyYIT3jQ70OG0C8a
         LMgg==
X-Gm-Message-State: AC+VfDx8uFjcGmFOBYX378NRiE3Dvi00QFs4gxdkww5dkqagCqQoPx+H
        yWkeVT92/2G5tYKISChsOzJVjw1a/Ng=
X-Google-Smtp-Source: ACHHUZ54gzrZVInYq0e3pi+VN+AkIxzxGE7/bsUD3FvZwDHyTd7JPuehyGiv+oNBMCQzizOWYj8D3A==
X-Received: by 2002:a05:6a00:1493:b0:641:558:8e2e with SMTP id v19-20020a056a00149300b0064105588e2emr780356pfu.15.1682481185555;
        Tue, 25 Apr 2023 20:53:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10-20020a62f94a000000b00640df8c536csm3423192pfm.12.2023.04.25.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 20:53:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Apr 2023 20:53:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: starfive: Fix the probe return error if PM
 and early_enable are both disabled
Message-ID: <3048a57d-1761-41c7-9528-ed722a8f77e9@roeck-us.net>
References: <20230426031216.37981-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426031216.37981-1-xingyu.wu@starfivetech.com>
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

On Wed, Apr 26, 2023 at 11:12:16AM +0800, Xingyu Wu wrote:
> When the starfive watchdog driver uses 'pm_runtime_put_sync()' as probe
> return value at last and 'early_enable' is disabled, it could return the
> error '-ENOSYS' if the CONFIG_PM is disabled, but the driver should works
> normally.
> 
> Drop the 'return' and keep the 'pm_runtime_put_sync()', but do not use it
> as the return value.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Hi, Guenter and Wim,
> 
> This patch fixes the issue of StarFive watchdog driver and rebases on
> the master branch of linux-next.
> 
> Thanks.
> 
> Changes since v1:
> - Dropped the check of PM and used the 'pm_runtime_put_sync()' directly.
> 
> v1: https://lore.kernel.org/all/20230425100456.32718-1-xingyu.wu@starfivetech.com/
>  
> ---
>  drivers/watchdog/starfive-wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 1995cceca51e..8f378900624d 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -492,7 +492,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>  		goto err_exit;
>  
>  	if (!early_enable)
> -		return pm_runtime_put_sync(&pdev->dev);
> +		pm_runtime_put_sync(&pdev->dev);
>  
>  	return 0;
>  
> -- 
> 2.25.1
> 
