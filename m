Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4569E8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBUUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjBUUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD013A5C3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677010073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qpdG6iKIBJ4zOLct1o98gqMjf+lLUq2a3+uCPXW4xs=;
        b=GWXIejlRqYR3EEfIrhhFUAX7eR0Sak8Ohaqx4TqGmEPRG+lSnpLpIaBX32+KaJMj3lO8iK
        7MFdMzWiJVsI7zz0YM2VOsU5tXj4pQvgTw0D0syg1cQPn59RL+pKk+lBiHm5DpsyamU4bx
        E4Mq/cqpyLfX+yRJS9dOC1uzZVwwGuY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-BSHQdcOtNrqX92G8-u1AuQ-1; Tue, 21 Feb 2023 15:07:52 -0500
X-MC-Unique: BSHQdcOtNrqX92G8-u1AuQ-1
Received: by mail-ed1-f71.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso4935829edh.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qpdG6iKIBJ4zOLct1o98gqMjf+lLUq2a3+uCPXW4xs=;
        b=Ff0nlOZuW94w4LqV2+86KWByp7mFCY6qDy+aBtC4oBVZiL85oTI2lB9kfamnHbDeOp
         I2gRcwHiegD9ep2ynXTbRoVL8x1BOB2FYVwmtV9H+tVY/roXgcFoVT4GPn2NNOap+/TX
         nHJ+uNX8DXKMwYAYMA/D9FNDYcShaqAsiQiQuVA6ZEqQ+pHRJt5tc1msjtD5SAg6IpCz
         mGXln2zaxKxDyhX5wuVxnOrGWKnpYNkUh4wguvN5VABZViaBhscsTRhxf4V4oZmkTMwL
         TC5EzkGlYzNwjYx07nMjGgu2zbzzafE+/ihvvM0Yqbo4p1LAMSJElkjRxoc7q09izxb8
         jaXw==
X-Gm-Message-State: AO0yUKWMhMBiHuzEiFYV6UlNTJazYoETxKTygxYFR1db8SANTFZJYSef
        T+PWrgzLDi2ecKzT77HFfOMFMGrn7HfaQbS0UQ8fgOUHFgH8Rzw3dGP8I+VzIlwR/8hCe3qm9/o
        N6bvLrtm0olbJHQpMiyqVWUiD
X-Received: by 2002:a17:906:e254:b0:883:3299:91c8 with SMTP id gq20-20020a170906e25400b00883329991c8mr13701396ejb.55.1677010070611;
        Tue, 21 Feb 2023 12:07:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8JSgQB2j+KXMBpdvloSA1D/uWImDztEf7Gh1E8fMoAElhGPP1EXm2/Lugx0E34K0NqDRu3aQ==
X-Received: by 2002:a17:906:e254:b0:883:3299:91c8 with SMTP id gq20-20020a170906e25400b00883329991c8mr13701377ejb.55.1677010070268;
        Tue, 21 Feb 2023 12:07:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id f6-20020a170906494600b008e240be0bddsm781916ejt.140.2023.02.21.12.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:07:49 -0800 (PST)
Message-ID: <9a796049-3a6e-90dd-6af5-8c4f659a53f7@redhat.com>
Date:   Tue, 21 Feb 2023 21:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 14/16] thermal/drivers/acerhdf: Make interval setting
 only at module load time
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-15-daniel.lezcano@linaro.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230221180710.2781027-15-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/23 19:07, Daniel Lezcano wrote:
> The thermal zone device structure is in the process of being private
> to the thermal framework core code. This driver is directly accessing
> and changing the monitoring polling rate.
> 
> After discussing with the maintainers of this driver, having the
> polling interval at module loading time is enough for their purpose.
> 
> Change the code to take into account the interval when the module is
> loaded but restrict the permissions so the value can not be changed
> afterwards.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Peter Kaestle <peter@piie.net>

Thanks, looks good to me, here is my ack for merging this through
the thermal tree.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/acerhdf.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 1956469c3457..61f1c3090867 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -79,7 +79,6 @@ static unsigned int list_supported;
>  static unsigned int fanstate = ACERHDF_FAN_AUTO;
>  static char force_bios[16];
>  static char force_product[16];
> -static unsigned int prev_interval;
>  static struct thermal_zone_device *thz_dev;
>  static struct thermal_cooling_device *cl_dev;
>  static struct platform_device *acerhdf_dev;
> @@ -346,20 +345,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>  	trips[0].temperature = fanon;
>  	trips[0].hysteresis  = fanon - fanoff;
>  
> -	if (kernelmode && prev_interval != interval) {
> +	if (kernelmode) {
>  		if (interval > ACERHDF_MAX_INTERVAL) {
>  			pr_err("interval too high, set to %d\n",
>  			       ACERHDF_MAX_INTERVAL);
>  			interval = ACERHDF_MAX_INTERVAL;
>  		}
> +
>  		if (verbose)
>  			pr_notice("interval changed to: %d\n", interval);
> -
> -		if (thermal)
> -			thermal->polling_delay_jiffies =
> -				round_jiffies(msecs_to_jiffies(interval * 1000));
> -
> -		prev_interval = interval;
>  	}
>  }
>  
> @@ -807,5 +801,5 @@ static const struct kernel_param_ops interval_ops = {
>  	.get = param_get_uint,
>  };
>  
> -module_param_cb(interval, &interval_ops, &interval, 0600);
> +module_param_cb(interval, &interval_ops, &interval, 0000);
>  MODULE_PARM_DESC(interval, "Polling interval of temperature check");

