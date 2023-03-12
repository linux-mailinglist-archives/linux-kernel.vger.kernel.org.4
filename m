Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959076B6A48
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCLSjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjCLSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:39:05 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F64A1CF49;
        Sun, 12 Mar 2023 11:38:26 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-540cb2fb5b9so97853967b3.3;
        Sun, 12 Mar 2023 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnb0dKcLzw28cDBfIxGuYGwFb2Xzg2MgU49yATawFzQ=;
        b=HHuzDBI8QbcfoYyI9RNI0wtTs/aEIs8iJlVvVBORRWqBnMXgutJEEQt4+SWcE33gj4
         Za88ajiZdHp09lBKzHCWiZRjJM+kMWeMs/uK0rK3OUh3twP3tKzdMF9vzt41JhQ3uKY+
         4OAyz51YtLfhIdLJSKql1BRYP9oCPMGj0/vvv24WjCJgmbtPsXGvAwe5AjVOlghtiKA3
         HteW5o707M7RFErfxK/mnvEHYig9OMyEsdWYMe1YbhjH6hZh05CEAIrb+m55bduDMxj0
         iwJohfnfWgxuMl89mS9682mMVquFWoWnvdwhzGYiWDuJ7TfC5HQAQU6+Tikp+swHJ9yO
         xffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnb0dKcLzw28cDBfIxGuYGwFb2Xzg2MgU49yATawFzQ=;
        b=ono0lqabbpH6Ph9cywtDynbAbTU2J6JRP6MtSvGCjK1zWmk1lpm7Pu6vPDZjmB9l/Y
         Qf1jyEyra2annj9c++Fo+o4iBCSVS1vDk029yEM7HEn3ctCEPwDJXT8jjfylX+39JoGV
         mA1XSJQ6NRetxLk2S2hkGhhbVeRlk/krZgMlDwU7G7krwSn878FtVerfH55C+g0dXp21
         vI0W5i97zKOUceO7SJmpoO8eOTrfpCbMkSHd/q63e/jqTpJabn/TOKEaPmj9UzxMFo/1
         mh4Yp9YbMgoe5BALJlzNcjpHiNEMC9iCPJL2aToeD1XbuVbkb0RgyIbn288fpSAiAFDl
         KEpw==
X-Gm-Message-State: AO0yUKWziMZdsv2mkrxWEToWOxNJb/DFyiKeDDa9NdzWrpXIMoncy6Ad
        BAQiDy41Y1Bkyyt9mGVzmBREf6jKC+o=
X-Google-Smtp-Source: AK7set9R4SgLkHVNTLHhlrxZzXV2YNSukVDBRm4hwiOlAnyi+R2T+EF/tKGW+bUIh/OiPzHZuDv96A==
X-Received: by 2002:a05:6870:3048:b0:177:a8a8:660 with SMTP id u8-20020a056870304800b00177a8a80660mr2434075oau.9.1678644417405;
        Sun, 12 Mar 2023 11:06:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r37-20020a05683044a500b0068bcd200247sm2322584otv.75.2023.03.12.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:06:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 11:06:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
Message-ID: <cd9067c7-0b99-4d62-9d5a-cdc028f33ba5@roeck-us.net>
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
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

On Sat, Mar 11, 2023 at 12:16:09PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]
> 

How do you trigger that ? The driver depends on OF_GPIO which
in turn depends on OF. Arguably that means that of_match_ptr()
doesnot really make sense, but still I don't see how you can
trigger the above error message.

Thanks,
Guenter

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/hwmon/gpio-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index e75db6f64e8c..be7f06fb7f78 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -481,7 +481,7 @@ static int gpio_fan_get_of_data(struct gpio_fan_data *fan_data)
>  	return 0;
>  }
>  
> -static const struct of_device_id of_gpio_fan_match[] = {
> +static const struct of_device_id of_gpio_fan_match[] __maybe_unused = {
>  	{ .compatible = "gpio-fan", },
>  	{},
>  };
