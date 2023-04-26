Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B66EF5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbjDZNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:46:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2649FA;
        Wed, 26 Apr 2023 06:46:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b73203e0aso43211640b3a.1;
        Wed, 26 Apr 2023 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682516813; x=1685108813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HOqBk1UlEcgm2Kf38PAS6YSfqtoyj6leA2i8Xni3cU=;
        b=hKlyJwuCjKjSlG7MX/ZQbo0uLhclgmUlGqyrTng/F7fGntOAtJYmueJDG31t60h/71
         XEQq5GpYVzOrjx+QFwRiTAgQhFgsPkPG3+c0pzoII8MukvEA9Gq0xehazR8nMdemZ3pw
         TN2+6XQjKdVYQaFtTuqddqQ3NSeIR/cD0dk3H63PxljrY9p9u2geid11J23AH+WM/vhG
         NAsQjd0y6vVfr/dsH5SzGszIMJP9gPcFIfvxcUdXS/MGpKsCqjRV99xSKwhiCtROK+jY
         Cey2lQBJKzMXrYBlHGJr4PzThDGiqEZqMfXdToevYx8Js+P0QJy3qjhs1/Akxin1rkju
         CCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516813; x=1685108813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HOqBk1UlEcgm2Kf38PAS6YSfqtoyj6leA2i8Xni3cU=;
        b=Zf/3cISWjcSzAzdzww73oU96USDMdYN16DgVITNBFx9axzoobTgB3oQRBNPsQpsE85
         M1P5SHQ9abM2zJrCFgnU6ttrXn1ep6nh5dpv6j3fMw0JHtwhHX6DpXMlIHyevQs9CNDI
         zE9mt+16MR8TJcXWVV03UBXaDpRvEq0/935s5f+Dzk2RNHCK5vmnihX8DNULp0HTDPXF
         wvs92kkMtSXcTxZF5oI2UJCz3a8EdJQgdihefcJnsCmDs3Q1LGf2ymXrlZeyk5IGzw1W
         UvNk9QEleXAdVRvF0mtEncBCcDnJgIzirKo98RHHnlHdKbl3k8vEX/DwuaxD8Ys1y2r7
         CRmg==
X-Gm-Message-State: AC+VfDxfYAZ2lXkjOAtMhD0HLsrFI3meomCxAE3xYqzIR1+y9wjSM5BJ
        7MDD75HDMYoENoD6p5M13KT/hm5wfq8=
X-Google-Smtp-Source: ACHHUZ7RYk6DH3HP8+DJ5dcBFidAC4UWydn7vFoRUwx5IDtmg3Klzwh2am44w7r6rz0FG8uKx5swiw==
X-Received: by 2002:a17:902:dacd:b0:1a2:a904:c42e with SMTP id q13-20020a170902dacd00b001a2a904c42emr2938434plx.24.1682516812701;
        Wed, 26 Apr 2023 06:46:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b00192aa53a7d5sm10016419pln.8.2023.04.26.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:46:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Apr 2023 06:46:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: Fix the error handling path of
 dw_wdt_drv_probe()
Message-ID: <61138390-378d-499d-bb62-7c944f0569c3@roeck-us.net>
References: <fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr>
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

On Wed, Apr 26, 2023 at 08:52:48AM +0200, Christophe JAILLET wrote:
> The commit in Fixes has only updated the remove function and missed the
> error handling path of the probe.
> 
> Add the missing reset_control_assert() call.
> 
> Fixes: 65a3b6935d92 ("watchdog: dw_wdt: get reset lines from dt")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/dw_wdt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 6f88bd81f8a1..a1354a59eb37 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -635,7 +635,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  
>  	ret = dw_wdt_init_timeouts(dw_wdt, dev);
>  	if (ret)
> -		goto out_disable_clk;
> +		goto out_assert_rst;
>  
>  	wdd = &dw_wdt->wdd;
>  	wdd->ops = &dw_wdt_ops;
> @@ -667,12 +667,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  
>  	ret = watchdog_register_device(wdd);
>  	if (ret)
> -		goto out_disable_pclk;
> +		goto out_assert_rst;
>  
>  	dw_wdt_dbgfs_init(dw_wdt);
>  
>  	return 0;
>  
> +out_assert_rst:
> +	reset_control_assert(dw_wdt->rst);
> +
>  out_disable_pclk:
>  	clk_disable_unprepare(dw_wdt->pclk);
>  
> -- 
> 2.34.1
> 
