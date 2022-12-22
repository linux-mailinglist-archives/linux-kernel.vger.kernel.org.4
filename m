Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A42654857
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiLVWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLVWXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791627CD4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671747741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJEghjc//bUeirJO3BVHy7SfdNAruAMz/OF8PYUtCm8=;
        b=RNkceL74ws9oEes6GzfJH5n2ZgpYdmHpZcpZsCSLwV2RQDHgEUtE8m/W28Xx9s0w2UwC4G
        P77yTUDddhobEnwpRcHuhzEvBIGm71o//OutfKdUYXMFmsSAUAJTAPRXQsEtLoLqQn2/l0
        2hVnXe3F+x3butDuAtz0hDzh43p3JXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-QwBHc0_PMPCg6TDJhEwweg-1; Thu, 22 Dec 2022 17:22:20 -0500
X-MC-Unique: QwBHc0_PMPCg6TDJhEwweg-1
Received: by mail-wm1-f69.google.com with SMTP id h126-20020a1c2184000000b003d96bdce12fso481439wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJEghjc//bUeirJO3BVHy7SfdNAruAMz/OF8PYUtCm8=;
        b=0eRO6wp5TAz3VrmAhHhNUTz0g8AQZdXlyaofZy/cMwNB4C6dJ3hMuu+I0RHxum+06Z
         kg9/matSDKZiX6OKBX1uIZuebN9zUyqmbndMqmkkIx+kB+8o585zm1XNHUqqaXrfCy15
         2SpGsBkpqo0c/cnbFi7l/0GHQP+sQYy7oVUV7KNms4v5q+299dDIVVBmG8bxNa3th5VX
         nF+YJlS5jr5B7wOcZmwRGIIe+mC+NiOFyzE3Ba60sxOPNUnN2PiCts7sOK9Y33swUdF7
         tkX9MMAB5G9odI7a76zHwPawWk0KZjAogJcm1H7+FlSM8QwmaX5KCHxwYWCnYk+t+/PL
         xNUg==
X-Gm-Message-State: AFqh2kpI7bm/5koTsf+MDYGU0bc3UasDe1Xjw6FJINVlOuuit1h6GEdy
        Yt/FwpQmSNtbUWWX+5SEl0+7jgdjgLxyiC/UE5ICBg4XMhfHpJ9+EjXgwGhSyjDtcoYQFkde8ii
        ojXSrrHKcGhuYg1/G2z8FdnV0
X-Received: by 2002:adf:f2cd:0:b0:242:29fc:ad51 with SMTP id d13-20020adff2cd000000b0024229fcad51mr8268073wrp.20.1671747739182;
        Thu, 22 Dec 2022 14:22:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv9To1v5Iv9TiwO8kmYC/5NHNtZZRcyqV34bOlzRZgspniUuLr0DE8wZ3mzxPXLDhw/Fztolw==
X-Received: by 2002:adf:f2cd:0:b0:242:29fc:ad51 with SMTP id d13-20020adff2cd000000b0024229fcad51mr8268051wrp.20.1671747738899;
        Thu, 22 Dec 2022 14:22:18 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d514b000000b0022cdeba3f83sm1496111wrt.84.2022.12.22.14.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 14:22:18 -0800 (PST)
Message-ID: <d45f52c1-1fe7-3210-25d2-259e3c07b5db@redhat.com>
Date:   Thu, 22 Dec 2022 23:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 038/606] drm/i2c/ch7006: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-39-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-39-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On 11/18/22 23:36, Uwe Kleine-König wrote:
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/i2c/ch7006_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
> index 578b738859b9..e0476a5bf84c 100644
> --- a/drivers/gpu/drm/i2c/ch7006_drv.c
> +++ b/drivers/gpu/drm/i2c/ch7006_drv.c
> @@ -386,7 +386,7 @@ static const struct drm_encoder_slave_funcs ch7006_encoder_funcs = {
>  
>  /* I2C driver functions */
>  
> -static int ch7006_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +static int ch7006_probe(struct i2c_client *client)
>  {
>  	uint8_t addr = CH7006_VERSION_ID;
>  	uint8_t val;
> @@ -495,7 +495,7 @@ static const struct dev_pm_ops ch7006_pm_ops = {
>  
>  static struct drm_i2c_encoder_driver ch7006_driver = {
>  	.i2c_driver = {
> -		.probe = ch7006_probe,
> +		.probe_new = ch7006_probe,
>  		.remove = ch7006_remove,
>  
>  		.driver = {

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

