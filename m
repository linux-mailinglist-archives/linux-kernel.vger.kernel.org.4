Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770565C8AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjACVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjACVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:13:51 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00614026;
        Tue,  3 Jan 2023 13:13:50 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s187so28090061oie.10;
        Tue, 03 Jan 2023 13:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XE75YtvOdvDomo8uXrOVQKva/Jfq1iADNtB4zYNap7c=;
        b=Lpowg12mxYqoiJ4BdljvIs/bARRrYXIOFjq+fs8Y/8lZbX4Vrm/ihZGZyXrwtTDRGt
         4qarAynnfhSVeEb0jVrmjqG4XpQ+h/HGOyy9J9mlsjT01v+Kg3a6lWnk6Iu2cPUxh9mU
         N+aFsvWoqJ3eezpDT9RQTS391H9EupZbcTGDqamdY2frrRyeDbl+KnGCTFpc25tBDD6+
         dHnvlZYrv2+PTwYEVThC5180SsdwTPnuvgm/LYnlsIgpscPdfIUNimPQsM3RFZ0CHZzl
         Nk2bo61/wgKPFM/6Bzlbhkb7AZUZACncwGR4hObH5YmghEVk5a+vMWgKOwG9L9TyP6ox
         OOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE75YtvOdvDomo8uXrOVQKva/Jfq1iADNtB4zYNap7c=;
        b=kLKt/KdtYD6UyINq8TFh6gdzPpEZbjZ46avY6ptTf2SC3yWPRG2HD+dOFYAtbvmt12
         qCBHxkANQ3gZ/s5uvkWdegRsxaZjFtrzctl/2nD1docE39KKyPfcV1WK/N03pE8fJB2m
         QoAmws6Rn3T4cUE0ljuNo23zI46lng1GLbJFK9kqIhFefqVA2BGrFSC8E5HCUBhw2gi0
         n7NFdiq910ncKA3JQmWixBfEjtmj9Lo+tWBILhuOlCESy++qvjeE+DrR9piYU5EUW9o6
         RMc7dR+386qFUwfihnAWzbsCDXkIKBLRGGyYanBS1QRSMM1GojnFzWqUnZwDfC9AkZnz
         55Xg==
X-Gm-Message-State: AFqh2kokPrG1MgHslJIbuqCMLwilgMufQdBpmv2TLODlVFUSjgINCjZw
        xCjY7qvW0gYyXinS5Xx7Mak=
X-Google-Smtp-Source: AMrXdXvnKs27s2VbrRKfzPeMKbw05RGDjEKZXjegoX/C5hhIayzISy2/C4p1r+mZBK8lmDMr+nJaYQ==
X-Received: by 2002:a05:6808:7c9:b0:35e:7748:5899 with SMTP id f9-20020a05680807c900b0035e77485899mr19383004oij.50.1672780429799;
        Tue, 03 Jan 2023 13:13:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s22-20020a0568080b1600b0035b439a4b81sm13513958oij.31.2023.01.03.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:13:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:13:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] watchdog: meson_gxbb: Use devm_clk_get_enabled() helper
Message-ID: <20230103211348.GB212337@roeck-us.net>
References: <6c5948373d309408095c1a098b7b4c491c5265f7.1672490071.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5948373d309408095c1a098b7b4c491c5265f7.1672490071.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 01:34:44PM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/meson_gxbb_wdt.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 981a2f7c3bec..35d80cb39856 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -146,16 +146,10 @@ static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
>  
> -static void meson_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct meson_gxbb_wdt *data;
> -	int ret;
>  	u32 ctrl_reg;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> @@ -166,18 +160,10 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->reg_base))
>  		return PTR_ERR(data->reg_base);
>  
> -	data->clk = devm_clk_get(dev, NULL);
> +	data->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
> -	ret = clk_prepare_enable(data->clk);
> -	if (ret)
> -		return ret;
> -	ret = devm_add_action_or_reset(dev, meson_clk_disable_unprepare,
> -				       data->clk);
> -	if (ret)
> -		return ret;
> -
>  	platform_set_drvdata(pdev, data);
>  
>  	data->wdt_dev.parent = dev;
> -- 
> 2.34.1
> 
