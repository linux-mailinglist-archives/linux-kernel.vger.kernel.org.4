Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA265A823
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiLaXRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiLaXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:16:44 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CCE0E;
        Sat, 31 Dec 2022 15:16:43 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id m7-20020a9d73c7000000b00683e2f36c18so10160997otk.0;
        Sat, 31 Dec 2022 15:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=titGmMACh08I+gZF78l7dxO0gfs6TqDOLGPsWxkWX8g=;
        b=k/Wz7j9sDY3c115l7f970aJbRtl51jy4Jyxu9nkuoeY3sEwxEXnddhX5tzZB3ORW9H
         20VusWZV/YeKD1SYYwMtzV6PJ4y3mUwicJEE3hnUhk53X812VUKWCO6eJZp4EMIP8Nar
         PLnlPJmamVYNSEx4GOxi3gYxPJkGZeudr5aTH278CNsuku/5TuKcbk0YS547i15yoG4s
         LBXRK8bKvWObWdgvPFpGxbQmnc62xcp0lDf9q95IpWkntf7EZWkdEQBoR4u3dQtVRkKX
         WonsJkIJpWv4LTq2ZNYj1MyLTxAAlivIY5GgxPIt3pWlFWisKa11yUTFH6BQVwGC2RS8
         t+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=titGmMACh08I+gZF78l7dxO0gfs6TqDOLGPsWxkWX8g=;
        b=OZJO32C61VoJ1eC92lfZT/8wR5WgOF3CBp9qD1fuyAvpOs49nf1T1qnBkZ6kGWBQsv
         Zs+i5aOFweey5libyWQ81Zk9AUc0VHeBGi+xsv8v8St67VFXtD40R1Ys57XITA5raoeP
         cdyBnIzRJdyHuTh7BlQyfRdpoolwxgsM5i3pAcN2YIRqUAwSFrbg0B2STyfuHOu+A+ci
         yRVOObmYoUNzGXlZimJkW3tT/AB6e/fnS2+oOW4DI8bpX7pe+woUTK5834/r7h+pPcPx
         s+g+2e3cwkzyyLDJv7RmT/A38e3PYoXCXfvGbwrQxWCoe/mT0ryhlXEtTEKoDx7aptBV
         mnFw==
X-Gm-Message-State: AFqh2kohZOoeBrLgkvJoFEfNJxVKtMT9cnNicmAR6EswLZr+iSfdWpCC
        6cLZnWrwJ0rMpNnjpoRMqeJpwMBwz+o=
X-Google-Smtp-Source: AMrXdXu7t+92LdYYcgmqdYqvvdYfXLEGD32C2N1JHFoDn4oE3AwRJOBTt5GFiCwa0hfxidETJINjgQ==
X-Received: by 2002:a05:6830:410e:b0:670:69ac:f7fc with SMTP id w14-20020a056830410e00b0067069acf7fcmr27068704ott.25.1672528602963;
        Sat, 31 Dec 2022 15:16:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6-20020a056830244600b006705829996fsm11887465otr.56.2022.12.31.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 15:16:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 15:16:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: loongson1: Use devm_clk_get_enabled() helper
Message-ID: <20221231231641.GE2706156@roeck-us.net>
References: <624106aa86ef7e49f16b11b229528eabd63de8f7.1672485257.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624106aa86ef7e49f16b11b229528eabd63de8f7.1672485257.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 12:14:30PM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Note that I get a compilation error because <loongson1.h> is not found on
> my system (x86_64).
> So I think that a "depends on LOONG<something>" in missing in a KConfig
> file.
> 
> Fixing it could help compilation farms build-bots.

Why would

	depends on MACH_LOONGSON32

be insufficient ?

Not reviewing the series further until this is resolved. It looks like
I am missing something serious.

Guenter

> ---
>  drivers/watchdog/loongson1_wdt.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> index bb3d075c0633..c55656cfb403 100644
> --- a/drivers/watchdog/loongson1_wdt.c
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -79,11 +79,6 @@ static const struct watchdog_ops ls1x_wdt_ops = {
>  	.set_timeout = ls1x_wdt_set_timeout,
>  };
>  
> -static void ls1x_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int ls1x_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -100,20 +95,10 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(drvdata->base))
>  		return PTR_ERR(drvdata->base);
>  
> -	drvdata->clk = devm_clk_get(dev, pdev->name);
> +	drvdata->clk = devm_clk_get_enabled(dev, pdev->name);
>  	if (IS_ERR(drvdata->clk))
>  		return PTR_ERR(drvdata->clk);
>  
> -	err = clk_prepare_enable(drvdata->clk);
> -	if (err) {
> -		dev_err(dev, "clk enable failed\n");
> -		return err;
> -	}
> -	err = devm_add_action_or_reset(dev, ls1x_clk_disable_unprepare,
> -				       drvdata->clk);
> -	if (err)
> -		return err;
> -
>  	clk_rate = clk_get_rate(drvdata->clk);
>  	if (!clk_rate)
>  		return -EINVAL;
> -- 
> 2.34.1
> 
