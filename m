Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267527097E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjESNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjESNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:00:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2FB6;
        Fri, 19 May 2023 06:00:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5343c3daff0so2178418a12.0;
        Fri, 19 May 2023 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501200; x=1687093200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAVZ/hcKkVx3SOcsuiVqtU8lahyp0IGSQNT0LUV/NnQ=;
        b=drvh6gtgE45NmbhBhrcPPtNZ/nk584pEPv08g1awcZCFZ32cQ0FYbn+gjJD35As3AZ
         41okulVz8jzzBm9oUZcCSiL42bV/ots28rzlAY8V5KrYNyOr8uh6WpiWsDjyikfJbjlD
         5mfYuksC7bHFGiSWdHFpb+xi0NodAYcG9G4Nn0W7iZ8YThfFQyzqd+sKOP4zKqgMOLmI
         i2RRrfCdRvF+SMQAanzH/Qq+DeU5Fd4E4zQIFaGkt6LwIjs58ER2xpuG+2hqp+h+7zQq
         iXZOR9djA/D38JZd2UL+PjfAmFiAIf6Mqr8deurxtpN+C4UnNtmECOmZoVqlcOZbfrUV
         6uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501200; x=1687093200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAVZ/hcKkVx3SOcsuiVqtU8lahyp0IGSQNT0LUV/NnQ=;
        b=jpHJlZm9/EnbI8LhOEaC84yurH/Bb+2zFnLMK5z9ib72LoiJZEYMMzSYOsH+e3LW/O
         M9YR71NVqSJAQfcd0guxPOVYaJtPXhHxAULbAZP1moS/5Sggr60ot2ibvT4w+WX4GDkU
         9Hx+GsNjHxvI+OjrWGoSc4Gv8fLKb2RkRkUxQpbNubsPzZdF3uKU/ZWGDhH1IdOFasoH
         x3QK9QgG4w8p1/73YI0CQNThdLfU0WmBJFCtpsYn/xQtX9vSEEXXmkOc8zHvn8B5Cai7
         LldkcitGBL3QKBdKQ7yKLiqKvfKeFQgwlRdOcW6NbxrT5jnAHHWS3HckbBOrKk1PjCPb
         se0A==
X-Gm-Message-State: AC+VfDwHr4QVx9gTV0jVncp7MucfiicgtlEtG7dryQudx1SnTyIJXzOy
        ZNlIUSRqXA7AJoPbp5gJcpc=
X-Google-Smtp-Source: ACHHUZ5Ne0SC1ojcfWREVJ6pYIonctRWlaLc8jNCHR7v4xDIInky3rzMMR563d0mO1C4qENHEodyuw==
X-Received: by 2002:a17:902:cecf:b0:1ae:6003:2ded with SMTP id d15-20020a170902cecf00b001ae60032dedmr2620513plg.65.1684501200052;
        Fri, 19 May 2023 06:00:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b001ae4edacce5sm2796046pll.94.2023.05.19.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:59:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 May 2023 05:59:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] hwmon: (f71882fg) prevent possible division by zero
Message-ID: <af1f4106-62a7-4cd0-9891-2d9aaa77f057@roeck-us.net>
References: <20230510143537.145060-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510143537.145060-1-n.zhandarovich@fintech.ru>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 07:35:37AM -0700, Nikita Zhandarovich wrote:
> In the unlikely event that something goes wrong with the device and
> its registers, the fan_from_reg() function may return 0. This value
> will cause a division-by-zero error in the show_pwm() function.
> 
> To prevent this, test the value of
> fan_from_reg(data->fan_full_speed[nr]) against 0 before performing
> the division. If the division-by-zero error is avoided, assign 0 to
> the val variable.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: df9ec2dae094 ("hwmon: (f71882fg) Reorder symbols to get rid of a few forward declarations")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/f71882fg.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 70121482a617..27207ec6f7fe 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -1096,8 +1096,11 @@ static ssize_t show_pwm(struct device *dev,
>  		val = data->pwm[nr];
>  	else {
>  		/* RPM mode */
> -		val = 255 * fan_from_reg(data->fan_target[nr])
> -			/ fan_from_reg(data->fan_full_speed[nr]);
> +		if (fan_from_reg(data->fan_full_speed[nr]))
> +			val = 255 * fan_from_reg(data->fan_target[nr])
> +				/ fan_from_reg(data->fan_full_speed[nr]);
> +		else
> +			val = 0;
>  	}
>  	mutex_unlock(&data->update_lock);
>  	return sprintf(buf, "%d\n", val);
