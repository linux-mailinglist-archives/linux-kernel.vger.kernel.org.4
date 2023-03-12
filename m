Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB606B6BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCLVMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:12:41 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8E2A6FA;
        Sun, 12 Mar 2023 14:12:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1767a208b30so11912832fac.2;
        Sun, 12 Mar 2023 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRf3mLCzUA4+4MpWno3pfPgTTCi05J8JG/5CDX3VFTI=;
        b=i4BAQuAPVu7dAMV2dkuNDHgb/GzIKm2xM1JTx4phUScgO9Gh8snxDw6ki2Ls68Qe58
         9nIuZgGe9QAOUkv6+GMc+DROYulHUCD6/Zva0VOJs/80FAg1xDOLx4sBossQsZFXjwZg
         iiQuxUu4IIpUlHJf71Pgz4qFfq/983Og37rAzmGmy2hEooA7/FWXGUy7SlfhauMVfmCT
         RD0/4zvwfIa0j4vTMn1RLUBHSNwGs5yfvNrf1gjj1+uRCr8w1Fz1fy+hnC81TH2aw6Va
         2Gy/h4HkWP30kSLhU5eJ2p7Onz4JT2xbZ+hnS56XpAaT2xh5ul5nZs70zt68ZmXfa2hv
         olWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRf3mLCzUA4+4MpWno3pfPgTTCi05J8JG/5CDX3VFTI=;
        b=M602exba0w0Jrdj/EAy3XGK6SvkSY0soBBxTmU/z52QmCGzvx3u3zWiaNd51koFDt1
         L4CVkN1yDhZujjOdqnvEDLPFsugYYdtd9vmBsvFygD3UAJ+PDj/Z2cypZbFLf1cT+N2d
         0mvPSpy6E+4nFbG3C9VDILOTylZA5HoLVIrlJ+LzkVz4Um8uaSbZvm7ODgLb6LpvmDnL
         2KA5VapgHIUXhvREg5BpGZfa9tb8ETytehaH9oenoGf/mfUNO20kj1bwC93ibjRbYfw0
         k7xs68MNnQRzveuH4eNKwxCHsOxWnOzCqeCW4p7sjnqiDk4Xdvt8zq/33C2h95IdYTI8
         4aDA==
X-Gm-Message-State: AO0yUKW6tVG+B2d1ers6EuaojTOPWV48U7xuOHehdQB+oBnnIOnPKYtw
        geZMwIe08YgBWS0C8S7vH2AA2uyCujA=
X-Google-Smtp-Source: AK7set+2IC9ptJ7WwM5o2em2AVoBodj0+QxVVIyuDh3OTB4i4NE22LzuyPEnGeBLizMJaM8B9ayWdA==
X-Received: by 2002:a05:6870:4393:b0:16d:c094:2743 with SMTP id r19-20020a056870439300b0016dc0942743mr26346697oah.27.1678655559284;
        Sun, 12 Mar 2023 14:12:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i83-20020acaea56000000b00383e0c1f6cdsm2417863oih.27.2023.03.12.14.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:12:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 14:12:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: gpio-fan: drop of_match_ptr for ID table
Message-ID: <ec48188f-0978-431c-9771-7bda97210c81@roeck-us.net>
References: <20230312193723.478032-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312193723.478032-1-krzysztof.kozlowski@linaro.org>
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

On Sun, Mar 12, 2023 at 08:37:22PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
> 
>   drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, though I added a note describing that the above build error can
only be seen if the OF -> GPIO_OF dependency is broken.

Thanks,
Guenter

> ---
> 
> Changes since v1:
> 1. Rework patch and commit msg - drop of_match_ptr.
> ---
>  drivers/hwmon/gpio-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index e75db6f64e8c..d92c536be9af 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -586,7 +586,7 @@ static struct platform_driver gpio_fan_driver = {
>  	.driver	= {
>  		.name	= "gpio-fan",
>  		.pm	= pm_sleep_ptr(&gpio_fan_pm),
> -		.of_match_table = of_match_ptr(of_gpio_fan_match),
> +		.of_match_table = of_gpio_fan_match,
>  	},
>  };
>  
