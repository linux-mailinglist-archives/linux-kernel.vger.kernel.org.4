Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F76DACB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjDGMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjDGMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:46:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DBAD02;
        Fri,  7 Apr 2023 05:46:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r40-20020a05683044a800b006a14270bc7eso18725824otv.6;
        Fri, 07 Apr 2023 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680871610; x=1683463610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7OOaJWRsqF5f3cp/B9FDAMADpbCuFWKQIWMGzgwGG4I=;
        b=PnjN0Q3tykVW8UtftVm7wAXYCY0sHkDutOu46Z5WOJvciTHyr9GgP3o5jPpu0TH9mx
         2de22563QodepzobSaq7qmDvZJSaynTQIqqW4RS/SwpGcHebMzsaA7oHn3wwW4HLvMgS
         ECMnv05+ZSxLlw/7aruZSq93ynHFKDLPmavwIWP60k/kXx9DMJL+ZUxeiC//DH9Tk/Qi
         PtJGPFgzA6TDGupFnp3Mib60ieivq0s24xZpkZrpFa1tnvPOfiq0w+aPpm+MS1Cjb5Q1
         ewcmU6fAeRE/ZpWvVFKkiUoOmOFjPNR5rHm6gqBdhhUHkpZqrH8iLe9D7o7nsIAqWxuh
         8k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680871610; x=1683463610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OOaJWRsqF5f3cp/B9FDAMADpbCuFWKQIWMGzgwGG4I=;
        b=CS8hx1CBLioOmlAjYN9GHI2MEszOIBHQQu87ebRdFB3dXV0A4Ytd7zln666rufMRwx
         GFoVpWbIQRscKb6q6RG/wuQJE1XLm7cCtWFXsbLK0l4+JFlLju8ubzJhVjdKv6uJhJYs
         Nm+O2G8QoBBbKbW2uDMgYEnm3BoRj8iG9Q21/ijTnOoSqP3zexmYa7Q9cjgC2hggQk7/
         4rlSjKxca2kSaWBEWPgNkMNTuwlxLBwb1cDoqeI9KG9igclP7F8wP6np2G+M1gdx8Onw
         kEx1aiCmt/4EVkJdtsG0c3gpHgivAQLqiWiAdao/d62Jx6CxiWB2YOhJ5XMvGR+twZM4
         DH5A==
X-Gm-Message-State: AAQBX9fI0l5YEZo6mrq7r+qIlNw0KKsvEd76v4aaGn3x6uGiOJgXH/zN
        ll06tJh+GeWrMdg3v/zAEW16OnuXp+g=
X-Google-Smtp-Source: AKy350buYaLh+KrmXZBo0/Wm/s1AM5CYsV+B4+BDSnrmL3bR9QqWEkb4sIeE5zhomhkFx9ka+WDYiA==
X-Received: by 2002:a9d:6c0c:0:b0:68b:d61c:168f with SMTP id f12-20020a9d6c0c000000b0068bd61c168fmr953370otq.11.1680871610135;
        Fri, 07 Apr 2023 05:46:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d16-20020a9d5e10000000b006a305c68617sm1664872oti.53.2023.04.07.05.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 05:46:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <27bafe2b-6fc0-2e5c-8c4e-99ed74caa5d6@roeck-us.net>
Date:   Fri, 7 Apr 2023 05:46:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] watchdog: loongson1_wdt: Add DT support
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>
References: <20230407110025.516405-1-keguang.zhang@gmail.com>
 <20230407110025.516405-3-keguang.zhang@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407110025.516405-3-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 04:00, Keguang Zhang wrote:
> This patch adds the of_match_table to enable DT support
> of Loongson-1 watchdog driver.
> And modify the parameter of devm_clk_get() accordingly.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>   drivers/watchdog/loongson1_wdt.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> index bb3d075c0633..c2694222ea86 100644
> --- a/drivers/watchdog/loongson1_wdt.c
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/clk.h>
>   #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   #include <loongson1.h>
> @@ -100,7 +101,7 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(drvdata->base))
>   		return PTR_ERR(drvdata->base);
>   
> -	drvdata->clk = devm_clk_get(dev, pdev->name);
> +	drvdata->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(drvdata->clk))
>   		return PTR_ERR(drvdata->clk);
>   
> @@ -142,10 +143,19 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_OF
> +static const struct of_device_id ls1x_wdt_dt_ids[] = {
> +	{ .compatible = "loongson,ls1x-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);
> +#endif
> +
>   static struct platform_driver ls1x_wdt_driver = {
>   	.probe = ls1x_wdt_probe,
>   	.driver = {
>   		.name = "ls1x-wdt",
> +		.of_match_table = ls1x_wdt_dt_ids,

If CONFIG_OF=n, this would result in a missing symbol.

Guenter

