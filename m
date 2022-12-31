Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D105765A2DF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiLaGHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiLaGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:07:48 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D413CE1;
        Fri, 30 Dec 2022 22:07:47 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id c133so20951347oif.1;
        Fri, 30 Dec 2022 22:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d092Pq0ceVkxiOdSKMnf5fA3NMBl2SWRNXgwb3nxm08=;
        b=PshJv3v3/1C249BVwiQBxYK/N/2jl74FKn+Sc+Ac2U2P3hLfO5yeTvmG9OYXHnIZCg
         KNT2dQAln/dE5tuCvx7kVVTRrgPHJ8GDSP52gKe4Hv7tGy4MNf8oq+0GduxZZNE82FJU
         emQgJ9P29Rm90KD8GqsXzPKvaKvjw7NZlCUsHSa6OtELCday0wRjHO3NiY3BD/8fsW3y
         mHJY6cOmChjJPXaH5skhPfOYVBeEzhKzJVqGUXo4Y4b/wOz5N5SdvkG2GmKXO60t6D9V
         +FAeZve0q8Un4TsTSRH0wXrH4uXGZZGymiD2xaD/K1Bad2kHrtCqKVxZTUIk72/VcWCq
         xWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d092Pq0ceVkxiOdSKMnf5fA3NMBl2SWRNXgwb3nxm08=;
        b=jYltN0MCC3kHc8Hrpfvc5dwuIa8UFxHT/liEYRDyvzUyf0qw6QU3tWAYvd3X8vwxvb
         OtR1I2f/zVhGPpkF3qD26wE/W9lx1zwlDi9H7MoxwN5IohFwjJ4Vl0nTZ6GlPC7kQ9HF
         D5r7CuB/x0T3S9aWiOL9dwTRD2AWPdxXwFr2ZYVryNrcAf/WVIUP5RPUMW/pQIPzajaA
         DzNVfq84KDXTWw1cVH0hIOXuRXm6KqTXGFFQXnvHR22WnUgHyZ7X3IU5OHnvreKQT6t+
         +h+I8yMyY67vhK2tALsOsGhkXQwtLtIwkoRedXs+pMSrvHLs7onRooMtyJ61d0gOYFqs
         FOhQ==
X-Gm-Message-State: AFqh2kpuRaC1flhh5a2EDdxioWLcHFbWsmbl/rZIxm/nAuAbhOUIy0No
        nagSUgPfC3m0OBFJaJ2wd2Tl47+mQWM=
X-Google-Smtp-Source: AMrXdXvBT7MBaWHFmV5boliYhJ0C8GZgddfn0IuspRQ/RH2ei8BjDPNALXfcJIboh73oa+ve2IOIZQ==
X-Received: by 2002:a54:480e:0:b0:361:8fa:1a97 with SMTP id j14-20020a54480e000000b0036108fa1a97mr20489918oij.3.1672466866988;
        Fri, 30 Dec 2022 22:07:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h187-20020acab7c4000000b0035468f2d410sm10012488oif.55.2022.12.30.22.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 22:07:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Dec 2022 22:07:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: rzn1: Use devm_clk_get_enabled() helper
Message-ID: <20221231060745.GB2927444@roeck-us.net>
References: <b1f8b5453791035ad534bd5ed36b49798ff4d9b2.1672418166.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f8b5453791035ad534bd5ed36b49798ff4d9b2.1672418166.git.christophe.jaillet@wanadoo.fr>
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

On Fri, Dec 30, 2022 at 05:36:20PM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rzn1_wdt.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> index 55ab384b9965..980c1717adb5 100644
> --- a/drivers/watchdog/rzn1_wdt.c
> +++ b/drivers/watchdog/rzn1_wdt.c
> @@ -98,11 +98,6 @@ static const struct watchdog_ops rzn1_wdt_ops = {
>  	.ping = rzn1_wdt_ping,
>  };
>  
> -static void rzn1_wdt_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int rzn1_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -132,23 +127,12 @@ static int rzn1_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	clk = devm_clk_get(dev, NULL);
> +	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(dev, "failed to get the clock\n");
>  		return PTR_ERR(clk);
>  	}
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "failed to prepare/enable the clock\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
> -				       clk);
> -	if (ret)
> -		return ret;
> -
>  	clk_rate = clk_get_rate(clk);
>  	if (!clk_rate) {
>  		dev_err(dev, "failed to get the clock rate\n");
> -- 
> 2.34.1
> 
