Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F72607D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJURLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJURLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:11:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D8C275DEF;
        Fri, 21 Oct 2022 10:11:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1322d768ba7so4330676fac.5;
        Fri, 21 Oct 2022 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afEUghWz7sOxgv3FmvGEE+cUfKZxWWGQrmHoQD9JZfU=;
        b=Zy+MEmavVhLdGV+K3T/Q5I9ztrxIuxp+DE/ygf+755KVRMPMRIM38TDVt7Ch9XGLgG
         qE3pMh3UmBMOZxzChAGlhMTxWbGsC7JlWvrWD8T/tv3mcRypPG2aIb6g+mNO2xiUvkLx
         5hXXZUqQfGKzO+WdTEO0IqmB+yu0lbcjzRddkpx6ofJELF092Zq7Fij+zUQ5HeLcQokz
         0kJ7YcuKniWa835q++bpcxziF0rFhYHl4kuDlCwc3+yg3PP/HqIap9EQtSGICK26jldI
         N+1Z23TDS1/hs5nN1gqwAKMOdEu4vWqpVkzIvnqG7LtCiP06XVwTB6Ixz0T1jpMObOQT
         Mx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afEUghWz7sOxgv3FmvGEE+cUfKZxWWGQrmHoQD9JZfU=;
        b=7l/AWgz+f3lLf41GamIKQhI5IMDg3PMGlJcVrt2Lj+GYt3Mg585G5v+7QXZLs6cVLL
         ZB5tIRuX6n7ApsvWdgzRCU4xX/v1w6lc6EqJ5Wrt/Lav3c+qFWgV3L0A1GgIdPXOa1ZT
         ihWYbr8M0loinYWI6k4K5d/fBpb3ic21QHLIo27C+Lc1nJmqzEPNLn64HCgkbA32Z3wY
         e6jaDv2ygzTCb2ATVtOtBxgdpKbxHOUyk/4oqiNHukerrk5u5UsUclx/wq1lu1Q8WUbw
         7hwG3eLDCJCFdgEZd2GoL+OJ85aRrrOYvBomCuPLcCPxliXerahIGfyBdc614p1rkFw2
         giGg==
X-Gm-Message-State: ACrzQf1/RlUvuL9aG5ylpkUicWFlmi5qkDhksaU9uzMSTqDUMRO7ZDRn
        1ccLH/PRrbh0R2BRJ2Si7JKSforXKRs=
X-Google-Smtp-Source: AMsMyM44j3t4Wz/XNPXP5iCopLHBMtmW0llHbqaBA8JXbnhLqI14kTX66Gt/CqHW5/1v30dPaK4RJA==
X-Received: by 2002:a05:6870:2107:b0:137:a7:3d3c with SMTP id f7-20020a056870210700b0013700a73d3cmr4929660oae.34.1666372289303;
        Fri, 21 Oct 2022 10:11:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y20-20020a4a6254000000b0047f89d8c7ebsm8858982oog.46.2022.10.21.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:11:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Oct 2022 10:11:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (jc42) Convert register access and caching
 to regmap/regcache
Message-ID: <20221021171127.GB1888515@roeck-us.net>
References: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
 <20221021165000.1865615-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021165000.1865615-2-martin.blumenstingl@googlemail.com>
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

On Fri, Oct 21, 2022 at 06:49:59PM +0200, Martin Blumenstingl wrote:
> Switch the jc42 driver to use an I2C regmap to access the registers.
> Also move over to regmap's built-in caching instead of adding a
> custom caching implementation. This works for JC42_REG_TEMP_UPPER,
> JC42_REG_TEMP_LOWER and JC42_REG_TEMP_CRITICAL as these values never
> change except when explicitly written. The cache For JC42_REG_TEMP is
> dropped (regmap can't cache it because it's volatile, meaning it can
> change at any time) as well for simplicity and consistency with other
> drivers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

...

>  	case hwmon_temp_crit_hyst:
> +		ret = regmap_read(data->regmap, JC42_REG_TEMP_CRITICAL,
> +				  &regval);
> +		if (ret)
> +			return ret;
> +
>  		/*
>  		 * JC42.4 compliant chips only support four hysteresis values.
>  		 * Pick best choice and go from there.
> @@ -356,7 +349,7 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
>  		val = clamp_val(val, (data->extended ? JC42_TEMP_MIN_EXTENDED
>  						     : JC42_TEMP_MIN) - 6000,
>  				JC42_TEMP_MAX);
> -		diff = jc42_temp_from_reg(data->temp[t_crit]) - val;
> +		diff = jc42_temp_from_reg(regval) - val;
>  		hyst = 0;
>  		if (diff > 0) {
>  			if (diff < 2250)
> @@ -368,17 +361,14 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
>  		}
>  		data->config = (data->config & ~JC42_CFG_HYST_MASK) |
>  				(hyst << JC42_CFG_HYST_SHIFT);
> -		ret = i2c_smbus_write_word_swapped(data->client,
> -						   JC42_REG_CONFIG,
> -						   data->config);
> +		ret = regmap_write(data->regmap, JC42_REG_CONFIG,
> +				   data->config);
>  		break;

This code sequence still requires a mutex since another thread could modify
the upper limit (and/or the hysteresis) while the hysteresis is in the process
of being written. Worst case there could be a mismatch between the value in
data->config and the value actually written into the chip. Granted, that is
unlikely to happen, but the race still exists.

Thanks,
Guenter
