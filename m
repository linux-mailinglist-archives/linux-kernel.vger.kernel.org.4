Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9276B69EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjCLSM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjCLSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:10:25 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0266126DE;
        Sun, 12 Mar 2023 11:03:11 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso5619498otr.5;
        Sun, 12 Mar 2023 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2SB5MqmjHsntyI9PujeuGHtzIZgIeiiUVCGqP3jljc=;
        b=Xt1UxEi9TtxboCC33klVA5yaniaBd0xOaF1fWkzjbdZO6IAC5ObFa4yUlyu1/SNjMm
         yUDwBcm27HSJ8kXiwHVYjnPeDVM7ZBsqBXTv5HKzlzfchNpV9BvVCxJxcwyc4EHUHqg+
         fewtJZJ5noTdfsN5C9HkU1hXu2gEd7gaOAkBC/PSS4F2VePBFpqDq0JzfRRpMFPCggnx
         CqnHfvQZ27dZblz0FKPGJtckwh6WjnOeZU0PXXJzeKFEf3W4SSVra3KDY21TJJ4zaDFX
         LxyKvHY+wexUB9oI4wJTpsQKLqL6aKdx8IfvwLtTSJ65Vabb/lZcogXWwp4S/a1us4xJ
         Fu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2SB5MqmjHsntyI9PujeuGHtzIZgIeiiUVCGqP3jljc=;
        b=kd4/RjsXgcB7JHLE1cWBempFIOYwO/BfXYqv3dewv1u2jX0ViJdQr6v13QZum4batB
         6WNxbPPlYKFHANKYDJ6S/V7yfpAym8fV4ImGTuefRdTA/JACUDMWXovJ0IqujU1rkkNw
         2kqd0fj+0CN+9gNWTZY6EcqU/Jxk/Ip/Fl1Tb0/KmnnTCNyu3BWuxzGjzdZwgGH2COgC
         gWVX7X4a7lKr0f7YO/Xlb+7rYjXO/Ono6I521SMkXYmpldqXhxg8fZa/Ql86Ux8I/4Ng
         CQ/B7xHMrqnr7nCvUNL4lU+15EDiSkpFrS5s2mUuVuKfyAgLSjJwJ18IKU/SUSSrCix7
         BDmQ==
X-Gm-Message-State: AO0yUKWjJrpCKwQx98lhcazX9cHV5zr0LmuoyFaKORV2s9YA9A3qeBWX
        6EQewj53eQpgUuLcPgcw5B87E2xhSOg=
X-Google-Smtp-Source: AK7set/CyZZ1GR54/Q7elEiA5smCjMJWt8AWsvn6E8f4nfcrsbBXbYD7dZmnr0+wItyQd7NZJ/d//Q==
X-Received: by 2002:a9d:6091:0:b0:68b:baa9:cc95 with SMTP id m17-20020a9d6091000000b0068bbaa9cc95mr14622323otj.5.1678644046489;
        Sun, 12 Mar 2023 11:00:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l19-20020a4acf13000000b00524faf3d2d7sm2259190oos.41.2023.03.12.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:00:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 11:00:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
Message-ID: <49dfd706-4260-4fd5-ba08-22936ef3c2e5@roeck-us.net>
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

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
