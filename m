Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208266E71FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjDSD5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjDSD5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:57:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E618D;
        Tue, 18 Apr 2023 20:57:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b73203e0aso13373752b3a.1;
        Tue, 18 Apr 2023 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681876628; x=1684468628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grc+ub6ijDlFnEvTScV9a0JXsVYmXuW0YDqW8bPTTxA=;
        b=sg0qDVyj7ncELAnlDx/lX9rtsRNxPX6piPkYXBpO6EMQlvVTLJ0A14gEhXS61SKqqF
         c5nB2Zd2JlaKmxsDxecI0OcSH7PUTvirh9xZM1guVJNHGV+vh/9yZoAEhxHAVJyv/GMS
         Gg987wsYDkenge12wtyUMIvVV1hojoKc2tugYW5tikKsLxm3x0V6b0JP6QzAPC3BnAdc
         xTOCX4+SbzbvMVfPbq3sA8rD7RTKBhdC9/GVu1fd8ith9GN6b7U9XwTMsCQeuGNxQPcf
         HvfaEiUMGg8i7XwmkCFp4VZE7PDiu9cIZjy5sO+BkP/c3Len/hkYZM2QGnq48Lco/Yh+
         XqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681876628; x=1684468628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grc+ub6ijDlFnEvTScV9a0JXsVYmXuW0YDqW8bPTTxA=;
        b=HSe+c/9hSHUipIYsYT6whEtHIPRO6XYj5UXDgUCRpPlfUKt9/JqpZJGn5OZsIo+mlg
         6CMWGxq9Dbdq5rbD3jafkdPNbQUvR0RcRhsFsJrblXEo8c8xczBAX+i4gmSlMBK3URDv
         nQd2xr/ARNQPWNVaGHla6X+/2KrQWlC3ZG4R0nBPl7R6U+ASKImWgnoacmtcmSKXbIZ1
         p+FqR9RJXv5j1K86GqwbrOtLVHgtpt98KZKZlJ+84DjKjDzXafWPJ4A1Sk/GwFLXh8UI
         UcrfHQD4LLxrMxot1QnSAWcbNwS56ddnS0yHwwq0jA9p0xsG+EZir/yNoJdrMxlXk88s
         Lnrw==
X-Gm-Message-State: AAQBX9en81G4Y6MjvYYyW7Zb16vomPOqtm5cXJSZYZtZjF1sAfkNHi0P
        atNGWxzNo3aXkbfLRZeqm0fHOTF2aVc=
X-Google-Smtp-Source: AKy350alx0Kv3OCpTXkKHT49l4ihSjQWmIkJPoVmq+M/ZGlZ0bPBLL4s09v7ve2StIWHDvxIS1G/GQ==
X-Received: by 2002:a05:6a00:4489:b0:63b:7bab:26ff with SMTP id cu9-20020a056a00448900b0063b7bab26ffmr1063217pfb.16.1681876628243;
        Tue, 18 Apr 2023 20:57:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22-20020a62ae16000000b0063b778f0952sm6984420pff.70.2023.04.18.20.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:57:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Apr 2023 20:57:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, manio@skyboo.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (adt7475) Use device_property APIs when
 configuring polarity
Message-ID: <3b4b7e11-9df5-489a-8e72-86ab6bbecab7@roeck-us.net>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
 <20230418233656.869055-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418233656.869055-2-chris.packham@alliedtelesis.co.nz>
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

On Wed, Apr 19, 2023 at 11:36:55AM +1200, Chris Packham wrote:
> On DT unaware platforms of_property_read_u32_array() returns -ENOSYS
> which wasn't handled by the code treating adi,pwm-active-state as
> optional. Update the code to use device_property_read_u32_array() which
> deals gracefully with DT unaware platforms.
> 
> Fixes: 86da28eed4fb ("hwmon: (adt7475) Add support for inverting pwm output")
> Reported-by: Mariusz Białończyk <manio@skyboo.net>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     I've not currently got access to a DT unaware platform with an ADT7475
>     chip so I'm not 100% sure that this will fix the problem Mariusz
>     reported but looking at drivers I think this approach is correct.
>     

What happens if there is no such property anywhere, neither in
devicetree nor in acpi ?

Guenter

>     Changes in v2:
>     - use device_property_read_u32_array instead of checking for -ENOSYS
> 
>  drivers/hwmon/adt7475.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6e4c92b500b8..6a6ebcc896b1 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1604,9 +1604,9 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
>  	int ret, i;
>  	u8 val;
>  
> -	ret = of_property_read_u32_array(client->dev.of_node,
> -					 "adi,pwm-active-state", states,
> -					 ARRAY_SIZE(states));
> +	ret = device_property_read_u32_array(&client->dev,
> +					     "adi,pwm-active-state", states,
> +					     ARRAY_SIZE(states));
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.40.0
> 
