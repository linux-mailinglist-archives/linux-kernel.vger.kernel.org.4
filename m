Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC24625FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiKKQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiKKQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:38:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FAD2497A;
        Fri, 11 Nov 2022 08:38:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x21so3303389qkj.0;
        Fri, 11 Nov 2022 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc79vdpftLtKCsTxy/EdUCgt0SXSyffM6ZriKdKDbtw=;
        b=n1RXtrlzLU+n02CT3soAPseTrXYQVpst+DE5CreTvGRr30AXGfdTHJAwTl5z881kL+
         4LGEERExB03/Yq1vr6GzRpwkwSaKPi24hnT5xlWWEo9wki0gXDZiJ2kdh91/eoZWqtce
         YN8dnyK4Ig4DFp/JA3DF3HgJm3iOWfFsD+YfLpg3WMwwLr/0q2yyLMa16q2PWZwlo7c+
         A3RJwQNMhQT7aEFguxGUvn94tuj5v3Auw0RQPueXCBGczDqhhmhOqT87TdZw4BWB2zqG
         UpG3eqKjuO05RFHM8jsAQdSqOqf7+B5IwnKB8cCp0fVon9oqGYQ+RTKgb81UW4MrCHiM
         LHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc79vdpftLtKCsTxy/EdUCgt0SXSyffM6ZriKdKDbtw=;
        b=oZ7zMys6ebWoI3YpBhFQy5m/q8gu6zjbEVO14KnrLxMkQnwn5GCMfN3DbTWY6kGcZ+
         18Vk0s9z+T8aRFM3SLJt3Zq4dBX0ZFAJ6ddpsq20VN+fQa2r0msCx5xKMI5p5ktE/ys4
         D0xtbvp569LNlPnIp73bsIcWz0C1uBoarW/CE1mxUcvowCaR1e8veSG9/QyiAtopSigG
         f0WSeSTiMtQ4xAvlWtWx0RC2lfqyz2mA8zIaP+W3N4jL5R13kh7hBd3Vg8gHka5WD/Ur
         /yIWxmi7SHviC5jf6/IJA6RQRz6KnBLpye9P2vnEHQmwJiGcZMun9DG5s09KwIJzZvNQ
         oy+w==
X-Gm-Message-State: ANoB5pkFKGQOK7hSdqUKeHpxaLlasfd9o0aDe1h4xzYClVyq8ymLA+vA
        vGJujkR+Tnjg8iYDb8oD0Y8OIB+WCgI=
X-Google-Smtp-Source: AA0mqf7UFI1m8W80QsrDOx3KAYJvkESRmsawupXo5W/rx00YTtgm89UZ7Lic9sd1Nb5bjpF9d6s9MQ==
X-Received: by 2002:a37:bf46:0:b0:6ec:5409:5eaf with SMTP id p67-20020a37bf46000000b006ec54095eafmr1716543qkf.404.1668184712630;
        Fri, 11 Nov 2022 08:38:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15-20020a05622a054f00b003434d3b5938sm1536008qtx.2.2022.11.11.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:38:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 11 Nov 2022 08:38:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] ina3221: correct the update_interval value
Message-ID: <20221111163828.GA323658@roeck-us.net>
References: <20221108050029.24576-1-nmalwade@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108050029.24576-1-nmalwade@nvidia.com>
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

On Tue, Nov 08, 2022 at 01:00:29PM +0800, Ninad Malwade wrote:
> As per the INA3221 datasheet the samples value should not be
> considered while calculating the update_interval value.
> Section 8.4.2.2 from datasheet says - "The conversion-time
> settings, along with the programmable-averaging mode, enable
> the INA3221 to optimize available timing requirements in a given
> application. For example, if a system requires data to be read
> every 2 ms with all three channels monitored, configure the INA3221
> with the conversion times for the shunt- and bus-voltage
> measurements set to 332 μs"
> 
> As per above only conversion time and number of channels are
> required to set the update_interval value. Correcting the same in
> the driver.
> 
> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>

As a bug fix, this patch should come before any functional changes.

> ---
>  Documentation/hwmon/ina3221.rst | 3 +--
>  drivers/hwmon/ina3221.c         | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina3221.rst
> index 8c12c54d2c24..a4f107d1e489 100644
> --- a/Documentation/hwmon/ina3221.rst
> +++ b/Documentation/hwmon/ina3221.rst
> @@ -61,10 +61,9 @@ samples                 Number of samples using in the averaging mode.
>  
>  update_interval         Data conversion time in millisecond, following:
>  
> -                          update_interval = C x S x (BC + SC)
> +                          update_interval = C x (BC + SC)
>  
>                            * C:	number of enabled channels
> -                          * S:	number of samples
>                            * BC:	bus-voltage conversion time in millisecond
>                            * SC:	shunt-voltage conversion time in millisecond
>  
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 2a57f4b60c29..e3aa57e3b039 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -183,11 +183,9 @@ static const int ina3221_avg_samples[] = {
>  static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
>  {
>  	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
> -	u32 samples_idx = INA3221_CONFIG_AVG(config);
> -	u32 samples = ina3221_avg_samples[samples_idx];
>  
>  	/* Bisect the result to Bus and Shunt conversion times */
> -	return DIV_ROUND_CLOSEST(interval * 1000 / 2, channels * samples);
> +	return DIV_ROUND_CLOSEST(interval / 2, channels);

Same question as Thierry: Why drop the multiplication ?

Guenter

>  }
>  
>  /* Converting CONFIG register value to update_interval in usec */
