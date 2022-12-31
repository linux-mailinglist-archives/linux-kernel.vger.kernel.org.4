Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870E765A2DC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiLaGHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaGHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:07:12 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2231B4A5;
        Fri, 30 Dec 2022 22:07:10 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1322d768ba7so26838594fac.5;
        Fri, 30 Dec 2022 22:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXaXaysXPbPqROOfEXq6yZCBBqbbsw4F/suhux8TP7I=;
        b=WgxBUgz09A4l/ZjEh8EEPEMZ6/1Fo8A3VqVzRh5lpsuA93yXl6ylY7pGG8j1uh7gJg
         chUI6FRQic7DLXhxDc7v8ARSqimQBHZ/nUNS1TA7bcby+72mfegrafp0gEDry9guLnvk
         720L7A1F8ygUiMFeYMEvvRQ9rGTvKI3pd6TYGzhrAbx9RGh5Hkx/iVRZ0ZJazXhNpubf
         oilf3UzA9YNRtQCS0BpEA25kPJ+acP2QRvJ2OyQjIN4xhSqEgCcsEJ2fyPfb+eP7TydJ
         zysR0Dzv7onSi8J7Fiw7aIb4qSD0c7AsdTskALpOoh6fFmqkO4pHRjt3K4132NOK4EnF
         nVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXaXaysXPbPqROOfEXq6yZCBBqbbsw4F/suhux8TP7I=;
        b=svvtDnkaRREwhEsmKZwpqvk3rID2a9G3fu4ITKQAx7bT4u4Ay4eUFMJ68FTZG7sNHP
         hQYVB6V+ADUf6gYN9lAlJWAuDsnWjXEZlJFzO2AESBcg0HSb2Cn1FynNVSrHwNOvKmAP
         NhRKBkLzJ9WEORqSP55QWbkiVlKU7827DQWlW4YYfnriD4dKcTHcAYxNhkk8tsm3ifG2
         CRmd5W6J1W4DsptxQ1JkQtnUEv+5GrtKL2hpDydkV2jArsqLdCRrvHNlLl3vpyadM0hw
         +RNAyDx4+oXR6+BZCDdg6hR2XLAEhtC8a+T4y/c8nEH/env7kJFCpR0ddxG76ZG/iYzX
         VHQQ==
X-Gm-Message-State: AFqh2kplrZeWpOCo+5hIk8LH/UGRy1B9Dd/q57+LhAClfjDxJmi+qYwh
        WrHWorn0voi2hS7BVSlZVIQ=
X-Google-Smtp-Source: AMrXdXs4hcymSV8eBwdYvJfjVINQYyVV085l1H52p/TSeSxzsIW8SSv3E7ygWXAE6SL5jWiwMD1MKQ==
X-Received: by 2002:a05:6871:714:b0:14e:ab8c:8735 with SMTP id f20-20020a056871071400b0014eab8c8735mr18913187oap.57.1672466829151;
        Fri, 30 Dec 2022 22:07:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a056870179000b0014813cc4a51sm6529590oae.29.2022.12.30.22.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 22:07:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Dec 2022 22:07:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: visconti: Use devm_clk_get_enabled() helper
Message-ID: <20221231060707.GA2927444@roeck-us.net>
References: <13e8cdf17556da111d1d98a8fe0b1dc1c78007e2.1672417940.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e8cdf17556da111d1d98a8fe0b1dc1c78007e2.1672417940.git.christophe.jaillet@wanadoo.fr>
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

On Fri, Dec 30, 2022 at 05:32:42PM +0100, Christophe JAILLET wrote:
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
>  drivers/watchdog/visconti_wdt.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/visconti_wdt.c b/drivers/watchdog/visconti_wdt.c
> index 83ef55e66ca8..cef0794708e7 100644
> --- a/drivers/watchdog/visconti_wdt.c
> +++ b/drivers/watchdog/visconti_wdt.c
> @@ -112,11 +112,6 @@ static const struct watchdog_ops visconti_wdt_ops = {
>  	.set_timeout	= visconti_wdt_set_timeout,
>  };
>  
> -static void visconti_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int visconti_wdt_probe(struct platform_device *pdev)
>  {
>  	struct watchdog_device *wdev;
> @@ -134,20 +129,10 @@ static int visconti_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>  
> -	clk = devm_clk_get(dev, NULL);
> +	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
>  		return dev_err_probe(dev, PTR_ERR(clk), "Could not get clock\n");
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "Could not enable clock\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev, visconti_clk_disable_unprepare, clk);
> -	if (ret)
> -		return ret;
> -
>  	clk_freq = clk_get_rate(clk);
>  	if (!clk_freq)
>  		return -EINVAL;
> -- 
> 2.34.1
> 
