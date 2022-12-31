Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2F65A2E2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiLaGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiLaGII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:08:08 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE85CB4A8;
        Fri, 30 Dec 2022 22:08:07 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so503291oom.9;
        Fri, 30 Dec 2022 22:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPFaitZsnWnz75ly8AVu9W3WrCBoFnTi3sspHqtEc2w=;
        b=SlG5MgNsVw+diW4ZltLgj+u+vifKXqRFIO/yxM8Ddp7OnQEJAr1acBA5W/gTQlWCq6
         iY+4fm4XjITwM2Xh6WDbhrQKIVWGbGVc840QNG0I5jqbbvkLrl+VNLijaCKMCovpH4/L
         8TlSrepQWPoRzB1Elf1vBHmdr/3ADCAXc35FQcrhA8bRNIvlmEHb4eAJOLZXP6PNaxqH
         bpr/yWAWyQH0RBtNAwbsW0gVF+f5EtOz5Rq6rSB6Yshx/KpX6TJTlHVERxIkJvbiNqad
         v1IRji8OErIZehjXkgiZcaMuAz0o/U/mkIVAaXfLF3AQBUNIMbGIdS22fvFyLOpo0/6g
         dmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPFaitZsnWnz75ly8AVu9W3WrCBoFnTi3sspHqtEc2w=;
        b=pqUDAyxh+d0ICcTIwXGj+See+PQTHEgkhU/SCGnOVeAbHtBbPWabW7Dpp9Ta9pLIyR
         sg8G+ARWjlAHpugxuC9LqBU1Jj4RrVVKRQQVTnIjArOTbLsRIykudmAbAANOmAQy3FYa
         hXkBNpNJnP8ANZijz1uBG0jnhh3hkrtkuVTqdRishgOfi99Iv88qkzzPcQIkd0iQJDCN
         m0qMstAVKGtUabfL+b4HPa4pESr/azjJQ09tlXNrni5us9iv9TZ/ln6kVnySpW1RdeJX
         Vdch/2hcJEGcZwYjnuRY2Z8DUv51+mi0oMfcEeBaDXXlDE4loL+YsAtEUrL79tpfKTae
         xlHQ==
X-Gm-Message-State: AFqh2kqd34KVn/SRn2WULrLmJBurZFVw80ldrg3axBjJHjyK/2GtORaT
        aNXXFJgLpgqA00iaXHYVue13guxA4L4=
X-Google-Smtp-Source: AMrXdXtGzXsY/si6/5IXp2Jxpf/kOzjFgo5hb3fIRQm0efhAQGxbVy9XxsfYBPl8Z5yMPY7Wa5qdyQ==
X-Received: by 2002:a4a:d0b5:0:b0:4ad:ae22:beee with SMTP id t21-20020a4ad0b5000000b004adae22beeemr15961052oor.4.1672466887311;
        Fri, 30 Dec 2022 22:08:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p66-20020a4a4845000000b004908a9542f8sm9222929ooa.31.2022.12.30.22.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 22:08:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Dec 2022 22:08:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: rtd119x: Use devm_clk_get_enabled() helper
Message-ID: <20221231060805.GC2927444@roeck-us.net>
References: <14b521b821279bc5111dc80b55d0936c5767c737.1672418470.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b521b821279bc5111dc80b55d0936c5767c737.1672418470.git.christophe.jaillet@wanadoo.fr>
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

On Fri, Dec 30, 2022 at 05:41:31PM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/rtd119x_wdt.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
> index 834b94ff3f90..95c8d7abce42 100644
> --- a/drivers/watchdog/rtd119x_wdt.c
> +++ b/drivers/watchdog/rtd119x_wdt.c
> @@ -94,16 +94,10 @@ static const struct of_device_id rtd119x_wdt_dt_ids[] = {
>  	 { }
>  };
>  
> -static void rtd119x_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int rtd119x_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rtd119x_watchdog_device *data;
> -	int ret;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -113,18 +107,10 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->base))
>  		return PTR_ERR(data->base);
>  
> -	data->clk = devm_clk_get(dev, NULL);
> +	data->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
> -	ret = clk_prepare_enable(data->clk);
> -	if (ret)
> -		return ret;
> -	ret = devm_add_action_or_reset(dev, rtd119x_clk_disable_unprepare,
> -				       data->clk);
> -	if (ret)
> -		return ret;
> -
>  	data->wdt_dev.info = &rtd119x_wdt_info;
>  	data->wdt_dev.ops = &rtd119x_wdt_ops;
>  	data->wdt_dev.timeout = 120;
> -- 
> 2.34.1
> 
