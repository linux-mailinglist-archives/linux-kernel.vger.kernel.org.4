Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB496E3A3D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjDPQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDPQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 12:16:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD51BF;
        Sun, 16 Apr 2023 09:16:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32942f4b670so16904325ab.0;
        Sun, 16 Apr 2023 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681661802; x=1684253802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l1dPVCsBREBPaNplQqRXfU3+a1O21BXYl2UEtPALx8=;
        b=TLi6HiNlOC2Ox8RT5MP3+mY2gdtLljfEssddiSDHZrvJqnuURtAmG5mElsm/5Xou6I
         H4WIEbuHnB1mxituWDdQyEXkMmXSMA50eg/ckqUkTYYdsL8pOPcShLAIRdj8I8ZCJziF
         SrKqXKQ5krvj0HRUGwP5EMkBAQ2SJgWeEJXgIcS5ddYQ14K4GayLJ9LVs1uqRiiBZY24
         l7HyuxvZk6Q+Uv9X5qSG5K1mqdWOGxfra3ZzoZMu7H7RU06x/W3QDNc5nobphgZ4lDDl
         WVx+3GD5UIquu40DvYgtybWoyID3FmB8NWHSu7hTmIomPrhz53J94PYcpp4P8qLz1Jlz
         TTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681661802; x=1684253802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l1dPVCsBREBPaNplQqRXfU3+a1O21BXYl2UEtPALx8=;
        b=WaBpK9mKEj0t0Z6XvfDoG4UIltCw33r6T6US9XwGT6gwGtcASc+W6o2xA71coR3K0G
         LkZjT1J0Y5L+8mCH1DPyLtdSPCSwgAIrjImQ+4kpe7wup0ZjNQ60VkSIc3bEWTdjIV2+
         aQE2mjE2gjVzGjDXwuwKRnj5ox94T+sCogl4P9ZRpIw6CJjOznr61mC6XYY3RcIEsq5m
         v+dpbF1BHuvRzamH48IcrlSZJ1GMW1Bo8u20lL4FW5F+jAgh25QsDr7woKZli0tim352
         LX25muZp3/S5NHHjFRXYyBtQl8YTOeioKPezniT6s/D0zOMxf3xqvfI2cS5X2spdsTh1
         IzQw==
X-Gm-Message-State: AAQBX9cfDkFi/FGRYutU3xb0/X54EjvPtcyYOouoBlBrvuOLGOdvc5H+
        q7DL/lSMtZA5u3FwUHU2JEY=
X-Google-Smtp-Source: AKy350Zeoi8KGnj0y0vS8PjkkZ4WmsQB9qoWE7x07Mm55E7MAvTeyEB8EysU84E4C12fsFuzTfS9Vw==
X-Received: by 2002:a92:cec9:0:b0:317:9818:ea49 with SMTP id z9-20020a92cec9000000b003179818ea49mr8282243ilq.2.1681661801789;
        Sun, 16 Apr 2023 09:16:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cn11-20020a0566383a0b00b0040f72526b1fsm1516212jab.16.2023.04.16.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 09:16:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 09:16:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: loongson1_wdt: Implement restart handler
Message-ID: <89b3c1c9-025f-4157-ba99-af3a7097ae85@roeck-us.net>
References: <20230330112051.551648-1-keguang.zhang@gmail.com>
 <20230330112051.551648-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330112051.551648-3-keguang.zhang@gmail.com>
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

On Thu, Mar 30, 2023 at 07:20:51PM +0800, Keguang Zhang wrote:
> Implement restart handler for the Loongson-1 watchdog driver and
> define the watchdog registers instead of including the legacy header.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V1 -> V2: None
> ---
>  drivers/watchdog/loongson1_wdt.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> index bb3d075c0633..a0b6fe62e516 100644
> --- a/drivers/watchdog/loongson1_wdt.c
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -7,7 +7,11 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
> -#include <loongson1.h>
> +
> +/* Loongson 1 Watchdog Register Definitions */
> +#define WDT_EN			0x0
> +#define WDT_TIMER		0x4
> +#define WDT_SET			0x8
>  
>  #define DEFAULT_HEARTBEAT	30
>  
> @@ -66,6 +70,18 @@ static int ls1x_wdt_stop(struct watchdog_device *wdt_dev)
>  	return 0;
>  }
>  
> +static int ls1x_wdt_restart(struct watchdog_device *wdt_dev,
> +			    unsigned long action, void *data)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0x1, drvdata->base + WDT_EN);
> +	writel(0x1, drvdata->base + WDT_TIMER);
> +	writel(0x1, drvdata->base + WDT_SET);
> +
> +	return 0;
> +}
> +
>  static const struct watchdog_info ls1x_wdt_info = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  	.identity = "Loongson1 Watchdog",
> @@ -77,6 +93,7 @@ static const struct watchdog_ops ls1x_wdt_ops = {
>  	.stop = ls1x_wdt_stop,
>  	.ping = ls1x_wdt_ping,
>  	.set_timeout = ls1x_wdt_set_timeout,
> +	.restart = ls1x_wdt_restart,
>  };
>  
>  static void ls1x_clk_disable_unprepare(void *data)
