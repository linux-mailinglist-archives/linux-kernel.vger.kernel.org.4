Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA465E948F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIYRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:00:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF62B1A9;
        Sun, 25 Sep 2022 10:00:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so4608321pgi.10;
        Sun, 25 Sep 2022 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=mQCpHD3b/oNCevN1QdhnwOd9ghkLwiR4HAI/Op4UuAA=;
        b=bf8hrf7c6j8YQs+sOdKjxNXSefn9xJG6UauB5PFVUdvSCMOO06soFxo6uSM5d7CdTu
         Lq8zhjPSjKXyQq/x4t+UHwoeEZJP3A2o2wAP+1EwbE8PLnmcJ4/Uq0SHXE4kJN1LgZlh
         KyusDiO+XksJkRFbDE1UtOHZ3THL9uS9I5h3pVP1TQzDoQ3oWYOV8uWe2wQ4DLhzO6xM
         BTngVtZnw+6VKOH3hVXK/w5hifpw43RzmpqAiWxK5qJo07ryAthcV5UNgb9BTdV4L32l
         gVB4YacWjbp3ZFKmy6/NDzbWf+7wMrwl+EfXYp2z5+DdT23dnJdvEhkiWRvN5Mimgnz3
         AFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mQCpHD3b/oNCevN1QdhnwOd9ghkLwiR4HAI/Op4UuAA=;
        b=cTYhVYlGh6lTFF8qKyfj+4IyL269BJozQsMLIt/UJD6UbdaQkc0w1Hqow2I/RS9JUm
         mOVNaWLs+HA4JRhPiISsmXQiVOLoUeeYtpJTuvAczW+Pdh+QCHbVfWp1cPvZ+AVELz2w
         ao6Tl8b5I25yhdHro6j+Ic9wZDDhNaZBhvNVEAdT2BnHf1vOAaZMp8I/QUUZZKTkO5ds
         B5H4K1RA0qxVHCokyTmH29O6mbF6ua4aSfuoIp2ojwy8ALIbuFlScdXWX+LcCqIXLn9J
         P+FqtG28eW+VbVxihDewwIt009JneQ2BhUZhZs4OgLP0RCLVx6PgM4CV8FHelso0b8eH
         SX9g==
X-Gm-Message-State: ACrzQf0mL/hssyz11uYMZJS6YjbREgAtoARd2qSjDv1vgGhR0XPeT6W3
        n085Gf5c+YQxVp0kQtGN0mxnnp5u3Zrjjw==
X-Google-Smtp-Source: AMsMyM6jgUS4ubKgESzfz+N9IM1J19XaOtd5m/aHe9WxopcH66fZ8/ZlVBJuzJsUTY/l33Io5pHCoQ==
X-Received: by 2002:a63:86c8:0:b0:43b:63ae:dc8a with SMTP id x191-20020a6386c8000000b0043b63aedc8amr16647335pgd.578.1664125256819;
        Sun, 25 Sep 2022 10:00:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a631e02000000b0042b5b036da4sm8998400pge.68.2022.09.25.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:00:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:00:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v4 2/6] watchdog: npcm: Enable clock if provided
Message-ID: <20220925170053.GA1761191@roeck-us.net>
References: <20220610072141.347795-1-j.neuschaefer@gmx.net>
 <20220610072141.347795-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610072141.347795-3-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 09:21:37AM +0200, Jonathan Neuschäfer wrote:
> On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
> clocks are individually gated and ungated. Therefore, the watchdog
> driver must be able to ungate the watchdog clock.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v4:
> - Don't disable clock in npcm_wdt_restart function
> 
> v3:
> - https://lore.kernel.org/lkml/20220508194333.2170161-4-j.neuschaefer@gmx.net/
> - Add enable/disable calls to npcm_wdt_restart handler
> - Not applied due to the above change:  Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> v2:
> - https://lore.kernel.org/lkml/20220429172030.398011-4-j.neuschaefer@gmx.net/
> - Add clk_disable_unprepare call, suggested by Guenter Roeck
> 
> v1:
> - https://lore.kernel.org/lkml/20220422183012.444674-4-j.neuschaefer@gmx.net/
> ---
>  drivers/watchdog/npcm_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --
> 2.35.1
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 28a24caa2627c..a5dd1c2301374 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -3,6 +3,7 @@
>  // Copyright (c) 2018 IBM Corp.
> 
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -43,6 +44,7 @@
>  struct npcm_wdt {
>  	struct watchdog_device  wdd;
>  	void __iomem		*reg;
> +	struct clk		*clk;
>  };
> 
>  static inline struct npcm_wdt *to_npcm_wdt(struct watchdog_device *wdd)
> @@ -66,6 +68,9 @@ static int npcm_wdt_start(struct watchdog_device *wdd)
>  	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
>  	u32 val;
> 
> +	if (wdt->clk)
> +		clk_prepare_enable(wdt->clk);
> +
>  	if (wdd->timeout < 2)
>  		val = 0x800;
>  	else if (wdd->timeout < 3)
> @@ -100,6 +105,9 @@ static int npcm_wdt_stop(struct watchdog_device *wdd)
> 
>  	writel(0, wdt->reg);
> 
> +	if (wdt->clk)
> +		clk_disable_unprepare(wdt->clk);
> +
>  	return 0;
>  }
> 
> @@ -147,6 +155,10 @@ static int npcm_wdt_restart(struct watchdog_device *wdd,
>  {
>  	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> 
> +	/* For reset, we start the WDT clock and leave it running. */
> +	if (wdt->clk)
> +		clk_prepare_enable(wdt->clk);
> +
>  	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
>  	udelay(1000);
> 
> @@ -191,6 +203,10 @@ static int npcm_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->reg))
>  		return PTR_ERR(wdt->reg);
> 
> +	wdt->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(wdt->clk))
> +		return PTR_ERR(wdt->clk);
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
