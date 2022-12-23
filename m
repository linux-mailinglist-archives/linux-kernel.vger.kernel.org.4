Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6B6549DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLWAzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLWAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:55:23 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69C21259;
        Thu, 22 Dec 2022 16:55:18 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1443a16b71cso4407245fac.13;
        Thu, 22 Dec 2022 16:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrXYNrQBTvwm5ci+yZvQJOUeh50hcJmA0AcwoEvKjqo=;
        b=Dt2/YI7FLlGpPodOaERqxcPF5edwtNrT6F3ULIEs+86T6q6lNxHAAQvKf5jcaSghKE
         sRdFhT8Ys8J7SxK5gdV0xOrp+H4bwbl51PTGloiH9xAubw+ta3ZgD4p0kBtBUV3P+Uqv
         atYSK9xbh+ebysr/3zlU3GS7yjawYoddJY+hAXiUKwxWEML2JmNeYFgdxFOz7KotQaIT
         St0qfhsviAMFVjYx46tWfCZf/ab7DvcvtuWT3r9sVsXe7bm1hHrrke0DOXkTBoxRrhbJ
         AOKjT7+K7fLz3XiXVgziG/6LcsL+h2pV7QYW1f+CbhMVS0bgeiB1IcbM9mmk/ahI0jNM
         +CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrXYNrQBTvwm5ci+yZvQJOUeh50hcJmA0AcwoEvKjqo=;
        b=wFISvWlc2SQvodUGK4nU9nGYJsUXiExGcPgVTJnixjAh5TyXI9vMiPoVZsVGgm9OWB
         IMY6foASDlEg7fkgyMYynDIIaSXLzW0Q08/J7l+Dw/Re8CxADX+euR4A29Oa4KwoPUe8
         HG6lN2cfrClq7jwhpuvvsndWKgtjj+ZvRo806Qc7uQOV1fiV02gxli3MiwXVBrorzdqQ
         Lc5A/FzZLDEMq+3c3vXz4XB18wm9qU6ZxbXIYHJZShjH9VxFqU+oA1lft1MYzgkz5vvz
         nG8uOLsk4sqEMqVyJaX9zWAMbKOA1Y3kQvM062HxCOlHve5HwTls8lfm/sdmXtL3EmEr
         YpBA==
X-Gm-Message-State: AFqh2kpT2QCZbpVgkSnU8huiGiiSbB3Mlaxlol7jn6G6P9RhDOFjjYpP
        vA0oZh3xn7efsAdBhpUe3k2ht2qc1Po=
X-Google-Smtp-Source: AMrXdXt2liwJEGraAOCv5U06fS33bED+3NZjifWq1+qZMjCYqRTO1sx38seCHdywHIz3UNhKh7U+YA==
X-Received: by 2002:a05:6870:9f89:b0:144:ace9:ef83 with SMTP id xm9-20020a0568709f8900b00144ace9ef83mr3752485oab.57.1671756917385;
        Thu, 22 Dec 2022 16:55:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15-20020a05687073cf00b00144bb1013e6sm957382oan.4.2022.12.22.16.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 16:55:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 22 Dec 2022 16:55:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: wdat_wdt: Avoid unimplemented get_timeleft
Message-ID: <20221223005514.GA3188712@roeck-us.net>
References: <20221221-wdat_wdt-timeleft-v1-1-8e8a314c36cc@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221221-wdat_wdt-timeleft-v1-1-8e8a314c36cc@weissschuh.net>
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

On Thu, Dec 22, 2022 at 11:43:31PM +0000, Thomas Weiﬂschuh wrote:
> As per the specification the action QUERY_COUNTDOWN_PERIOD is optional.
> If the action is not implemented by the physical device the driver would
> always report "0" from get_timeleft().
> Avoid confusing userspace by only providing get_timeleft() when
> implemented by the hardware.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Assuming that there can be only one of those watchdogs in the system,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/watchdog/wdat_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index ce7a4a9e4b03..0ba99bed59fc 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -301,13 +301,12 @@ static const struct watchdog_info wdat_wdt_info = {
>  	.identity = "wdat_wdt",
>  };
>  
> -static const struct watchdog_ops wdat_wdt_ops = {
> +static struct watchdog_ops wdat_wdt_ops = {
>  	.owner = THIS_MODULE,
>  	.start = wdat_wdt_start,
>  	.stop = wdat_wdt_stop,
>  	.ping = wdat_wdt_ping,
>  	.set_timeout = wdat_wdt_set_timeout,
> -	.get_timeleft = wdat_wdt_get_timeleft,
>  };
>  
>  static int wdat_wdt_probe(struct platform_device *pdev)
> @@ -436,6 +435,9 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  		list_add_tail(&instr->node, instructions);
>  	}
>  
> +	if (wdat->instructions[ACPI_WDAT_GET_CURRENT_COUNTDOWN])
> +		wdat_wdt_ops.get_timeleft = wdat_wdt_get_timeleft;
> +
>  	wdat_wdt_boot_status(wdat);
>  	wdat_wdt_set_running(wdat);
>  
> 
> ---
> base-commit: 0a924817d2ed9396401e0557c6134276d2e26382
> change-id: 20221221-wdat_wdt-timeleft-b38d0db39d9f
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
