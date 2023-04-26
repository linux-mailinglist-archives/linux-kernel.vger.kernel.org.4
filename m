Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1696EF5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjDZNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjDZNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:47:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BD4EC8;
        Wed, 26 Apr 2023 06:47:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b67a26069so9168265b3a.0;
        Wed, 26 Apr 2023 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682516840; x=1685108840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d80Fxi14ZhTK4JCpEAwVBnJRLSP70m+i/0hY9bwC/QY=;
        b=dNrHhXxUWtjpOFO5xd3wjVJ6GENvTeCPaK55MT4zKeBaIfMKhE3qr0ZrgEp0Zt/yAk
         wB39TaSgXqDD73clTSr35kouqznX/TTCbuCtWITmW82d73NEew347EWsl2ab8Mezpj1J
         kNvG04hU5z6nNbuSJkRoe99u5gH7PLmtDh7guSA5rIRBsOGTWBZ9goB57HJZHiVys/E3
         il1XKJzyCNcwMIP10xqeZtCiVYxQUdmaSIKnjUhgCnkJ6v7+g0v9IpXL5a/MXyZQYkoE
         OkXYJ89LpGt7ZJ49fVnGH1Pga5FiyCyN/QzEkC62L3fQAgXDeRRFYoUiuCVf9thAoIjV
         VV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516840; x=1685108840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d80Fxi14ZhTK4JCpEAwVBnJRLSP70m+i/0hY9bwC/QY=;
        b=IGpzJcMTqWVGjzpIL53WRBeUS1eO4T09pySnUIdHuLQWoYOocSM9cRGqEe+4QVtxn7
         7sHq/ZofrD4pWekBygouPYJC+eMRPWVqrmaKX0s6Fvn3kWgMlG+4+1TP76cRERVJlmDP
         EE4MN/KdtqzWY+LKccSAAJKJVOO8jw1KJjTnpYRqoGKhgQL7uZ9+xVMEEhNBIQbzO5i/
         o4+83bpIJ0CF17I8ZskqN2rJj7q1qPucUt7YuzK315XuZdZaFCzq4BgdJLc707qX7NC+
         Yae4efAs/3IKN7V8CDYUelwNSj9E0jZ9rZzrCS/Cl9uvOOqzTgOAmUarX4B/xTk5OGsO
         NhYg==
X-Gm-Message-State: AAQBX9eZoGy6bV6eOgCFC1h1kPi9x3UWeD247bgwaG/J5eB++K2CP25W
        w3CApLPVR3FXXEnqY7Fr6ZDXKss3pIM=
X-Google-Smtp-Source: AKy350a5KdU9F5GIqMFSCBKHu1wKbhSIkhzBUbUFSRAGqYq34zJkxG15hmdcb6gioppEYASwR4adEA==
X-Received: by 2002:a05:6a00:cd3:b0:627:f1f1:a97d with SMTP id b19-20020a056a000cd300b00627f1f1a97dmr28956543pfv.24.1682516840338;
        Wed, 26 Apr 2023 06:47:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4-20020aa784c4000000b0063d238b1e4bsm11260281pfn.160.2023.04.26.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:47:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Apr 2023 06:47:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: dw_wdt: Simplify clk management
Message-ID: <1847a4dc-cd02-41ff-9294-5d19e8367b3e@roeck-us.net>
References: <fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr>
 <f6094c55cacf9637d835cd49290d9e888faeb0f7.1682491863.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6094c55cacf9637d835cd49290d9e888faeb0f7.1682491863.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 08:52:49AM +0200, Christophe JAILLET wrote:
> Use devm_clk_get_enabled() instead of hand-writing it.
> This saves some LoC.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> This change the order the resources will be released, so review with care.
> ---
>  drivers/watchdog/dw_wdt.c | 44 ++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index a1354a59eb37..84dca3695f86 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -566,22 +566,16 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	 * to the common timer/bus clocks configuration, in which the very
>  	 * first found clock supply both timer and APB signals.
>  	 */
> -	dw_wdt->clk = devm_clk_get(dev, "tclk");
> +	dw_wdt->clk = devm_clk_get_enabled(dev, "tclk");
>  	if (IS_ERR(dw_wdt->clk)) {
> -		dw_wdt->clk = devm_clk_get(dev, NULL);
> +		dw_wdt->clk = devm_clk_get_enabled(dev, NULL);
>  		if (IS_ERR(dw_wdt->clk))
>  			return PTR_ERR(dw_wdt->clk);
>  	}
>  
> -	ret = clk_prepare_enable(dw_wdt->clk);
> -	if (ret)
> -		return ret;
> -
>  	dw_wdt->rate = clk_get_rate(dw_wdt->clk);
> -	if (dw_wdt->rate == 0) {
> -		ret = -EINVAL;
> -		goto out_disable_clk;
> -	}
> +	if (dw_wdt->rate == 0)
> +		return -EINVAL;
>  
>  	/*
>  	 * Request APB clock if device is configured with async clocks mode.
> @@ -590,21 +584,13 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	 * so the pclk phandle reference is left optional. If it couldn't be
>  	 * found we consider the device configured in synchronous clocks mode.
>  	 */
> -	dw_wdt->pclk = devm_clk_get_optional(dev, "pclk");
> -	if (IS_ERR(dw_wdt->pclk)) {
> -		ret = PTR_ERR(dw_wdt->pclk);
> -		goto out_disable_clk;
> -	}
> -
> -	ret = clk_prepare_enable(dw_wdt->pclk);
> -	if (ret)
> -		goto out_disable_clk;
> +	dw_wdt->pclk = devm_clk_get_optional_enabled(dev, "pclk");
> +	if (IS_ERR(dw_wdt->pclk))
> +		return PTR_ERR(dw_wdt->pclk);
>  
>  	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> -	if (IS_ERR(dw_wdt->rst)) {
> -		ret = PTR_ERR(dw_wdt->rst);
> -		goto out_disable_pclk;
> -	}
> +	if (IS_ERR(dw_wdt->rst))
> +		return PTR_ERR(dw_wdt->rst);
>  
>  	/* Enable normal reset without pre-timeout by default. */
>  	dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
> @@ -621,12 +607,12 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  				       IRQF_SHARED | IRQF_TRIGGER_RISING,
>  				       pdev->name, dw_wdt);
>  		if (ret)
> -			goto out_disable_pclk;
> +			return ret;
>  
>  		dw_wdt->wdd.info = &dw_wdt_pt_ident;
>  	} else {
>  		if (ret == -EPROBE_DEFER)
> -			goto out_disable_pclk;
> +			return ret;
>  
>  		dw_wdt->wdd.info = &dw_wdt_ident;
>  	}
> @@ -675,12 +661,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  
>  out_assert_rst:
>  	reset_control_assert(dw_wdt->rst);
> -
> -out_disable_pclk:
> -	clk_disable_unprepare(dw_wdt->pclk);
> -
> -out_disable_clk:
> -	clk_disable_unprepare(dw_wdt->clk);
>  	return ret;
>  }
>  
> @@ -692,8 +672,6 @@ static void dw_wdt_drv_remove(struct platform_device *pdev)
>  
>  	watchdog_unregister_device(&dw_wdt->wdd);
>  	reset_control_assert(dw_wdt->rst);
> -	clk_disable_unprepare(dw_wdt->pclk);
> -	clk_disable_unprepare(dw_wdt->clk);
>  }
>  
>  #ifdef CONFIG_OF
> -- 
> 2.34.1
> 
