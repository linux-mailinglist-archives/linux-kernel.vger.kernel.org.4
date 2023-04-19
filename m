Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043306E7F25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjDSQGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjDSQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:06:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670AA9778;
        Wed, 19 Apr 2023 09:06:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so1685668a12.2;
        Wed, 19 Apr 2023 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681920371; x=1684512371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ntOoZwYIdz3RXLHuDI1sm+dVRDImiqPD+2FP5+B3d0=;
        b=rqwLSwFdDettqNx1xfjkd0w2A74ffZPjmwffca8AH8y6AFfVEHxYwsE5Jn9Hm8dMA7
         HwdkbpJVnvEFA8ioFs7UJtIw+nZfpUQnp7f+eeEqOkHvV4SpPV4edvJASrhcU2hTiS+2
         5YQtgHJGmjJ8vtGxg4zWlJznLQvo89tG5rh2g8ndTYOQ7Y/Z2kh9vqddB3FgbF06P4qa
         gMG2XUSyonZkj2Q2P/ti49cGO7Jtjsuq39vXeeV14NIuMISjwrgzuTewZDfPBP0+m5Pg
         andMeNvZypMiBLPXzcICxry1cmb51afBTQM0u6Nmr+nn14qhmh7JEX30WFtWy+DUofw3
         1ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920371; x=1684512371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ntOoZwYIdz3RXLHuDI1sm+dVRDImiqPD+2FP5+B3d0=;
        b=StC7e4hABhA/2CeSchthhQfIqZ+62Gmmm2uocqRzfarmdmB2eRXe1Fz/3f8LnfaDGC
         5NvSz6oQZhcjm81smRaiWfp2ybv2f4WCkKLrLZcSW/hRS+VXcdlYmziAWn80IoCexzLJ
         bFxPAl/Gm+k/U/kS4T49GDuwpgbgGGmTeVcl0fTvqtcBgL5ahHCNJv/oJy5YrKKy8mZC
         4QMcQ+OaXnP0Vs8It5OVJVmSqgMtCNh4IGv5ya7u10Nl4v7Ktoq/a2gsHiXTPr1EhFtY
         jCvy7NqLu19As7JYBEfnWjf+84XD/EgkwCXIZyEbdfu0amksOjCSn9nPNvZHjfIPrbxH
         cc+g==
X-Gm-Message-State: AAQBX9fHYt5yTFjVce3AQncOx1ewLCDptE01MzJT3LcnK5crNS2LrWsr
        55ya7E8NPJ3XeVXLvzWtf8E=
X-Google-Smtp-Source: AKy350ZI4BJEnpJ5Def2VOje33VKY5T9ue/5bR1ryQfd0uXM88+GwNwQgXrh8htNYYXW9LTEHSh9YQ==
X-Received: by 2002:a17:90a:e7cf:b0:233:fb7d:845a with SMTP id kb15-20020a17090ae7cf00b00233fb7d845amr3676712pjb.4.1681920370836;
        Wed, 19 Apr 2023 09:06:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a46cf00b00247164c1947sm1960875pjg.0.2023.04.19.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:06:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Apr 2023 09:06:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, manio@skyboo.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property
 APIs
Message-ID: <4d78b62f-1592-45d9-874a-30f1906cd2d3@roeck-us.net>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
 <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
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

On Wed, Apr 19, 2023 at 11:36:56AM +1200, Chris Packham wrote:
> Instead of of_property_read_*() use the equivalent
> device_property_read_*() API. This will allow these properties to be
> used on DT unaware platforms. For DT aware platforms this will be a
> noop.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     This is an additional update for master from the preceeding bugfix
>     commit. I've not added a fixes tag for this one because I don't think
>     there will be a behaviour change for existing usages.
>     
>     I know we have one upcoming DT unaware platform that we may want to use
>     some of these properties via ACPI tables so I won't object if this ends
>     up on the stable track but I don't think it meets the criteria for
>     stable.
> 
>  drivers/hwmon/adt7475.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6a6ebcc896b1..3b9289bc5997 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1468,7 +1468,7 @@ static int load_config3(const struct i2c_client *client, const char *propname)
>  	u8 config3;
>  	int ret;
>  
> -	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	ret = device_property_read_string(&client->dev, propname, &function);

Unfortunately that is a problem because the parameter passed to
load_config3 is a pointer to a const data structure and
device_property_read_string doesn't like that (afaics for
no good reason). You'll also have to change the client parameter
to load_config() and friends to not be const.

Guenter
