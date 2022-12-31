Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790B65A649
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiLaT2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaT23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:28:29 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9F6548;
        Sat, 31 Dec 2022 11:28:28 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1442977d77dso28280065fac.6;
        Sat, 31 Dec 2022 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AacQ+BIU1NHX+HGWy2UaEC3c651ZlmPMNCs6AfkyBMA=;
        b=LqUva2Wm6OqLHlGRHfJtVRhZrWxYiPRL2PgvFyNsRS9LfPLwk4r+mb+eCVA1IbmWok
         jSzNxXaWnbVuk8gW8xx6VR38r8sFGvl/gnEM9+DRzCYJpdvCbS1fo2kobZ6aTJy8E2sS
         o7xTqo17U7F0tFcsN53l8V9+Jp0rNNUTtRbNvo51ySrqZhQIdLDLjZgO8Rpp8wvddf22
         dDb+JwjVZAZx73vhLoPEDlgQkW/7KmSCttf58SjBSiW5WHhZ0t8dBKjjEvO/VGit2nIG
         JU9cVvyR4VM9puBYZty1mqbjWLkxuZHB5MaXK0X3zM2NQy7/KaFSNOE9htsluCzrc/bs
         Xeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AacQ+BIU1NHX+HGWy2UaEC3c651ZlmPMNCs6AfkyBMA=;
        b=m8w/VK6ejU4cIoFiTZBHi4U7HmSlTuCCuhxWRnmBDVqnhviBpVqkVolXkorf+i/m7l
         f8WSYv+R+VRsIuPNB/guhAjUFEj2ain7PyzyOjb5Tz9pOLA+eJl/P0bJR/USjmmb/1Ss
         0r+SVNt6Jz7XtyeF2jhKekYd1dtaYhIT5Oy6YtvjprHEaTNFZmRlqUJ0Guku4JMGEsn0
         ZEYoYYTqfytalZFv8+j6ZgvRZ7RfycP+vcO7vEZlvA+N4l74dwPVe7geG2sMXYnV9L1e
         D4DrnS1Wxq4RkQ0wcQklt65JGgXXhukliYDSBaATdWJ9HMcqPeLo+xvTjjeDxhsn09PT
         e67w==
X-Gm-Message-State: AFqh2krnkBzf0gBBidZ5irglDbRMJvOZQTHPWm0FvxF2ipABvHVCAtfk
        KDpgKRNeDeLuNDXSvASPLnEt1N4wXxY=
X-Google-Smtp-Source: AMrXdXubNlFqmaDlYAzmKzsC5OUs7R1upuNYVGc/H7bns+wwN16DlMUT8Pojeg0Zofrpfj+0Y3fw2w==
X-Received: by 2002:a05:6870:1b09:b0:144:c28c:f7da with SMTP id hl9-20020a0568701b0900b00144c28cf7damr17978434oab.39.1672514907251;
        Sat, 31 Dec 2022 11:28:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12-20020a4a9c0c000000b004a09df5a1dbsm9693998ooj.8.2022.12.31.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 11:28:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 11:28:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: apple: Use devm_clk_get_enabled() helper
Message-ID: <20221231192824.GA3434944@roeck-us.net>
References: <6f312af6160d1e10b616c9adbd1fd8f822db964d.1672473415.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f312af6160d1e10b616c9adbd1fd8f822db964d.1672473415.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Dec 31, 2022 at 08:57:22AM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/apple_wdt.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index 16aca21f13d6..eddeb0fede89 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -136,11 +136,6 @@ static int apple_wdt_restart(struct watchdog_device *wdd, unsigned long mode,
>  	return 0;
>  }
>  
> -static void apple_wdt_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static struct watchdog_ops apple_wdt_ops = {
>  	.owner = THIS_MODULE,
>  	.start = apple_wdt_start,
> @@ -162,7 +157,6 @@ static int apple_wdt_probe(struct platform_device *pdev)
>  	struct apple_wdt *wdt;
>  	struct clk *clk;
>  	u32 wdt_ctrl;
> -	int ret;
>  
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
> @@ -172,19 +166,9 @@ static int apple_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->regs))
>  		return PTR_ERR(wdt->regs);
>  
> -	clk = devm_clk_get(dev, NULL);
> +	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, apple_wdt_clk_disable_unprepare,
> -				       clk);
> -	if (ret)
> -		return ret;
> -
>  	wdt->clk_rate = clk_get_rate(clk);
>  	if (!wdt->clk_rate)
>  		return -EINVAL;
> -- 
> 2.34.1
> 
