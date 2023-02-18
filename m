Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2C69B979
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBRKoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBRKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A013DC7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676716996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQPC+W/GGOaiPhupQkL+fioSZnAdQgjaIafObYt5jdo=;
        b=Q9GxZReFRAUbv5BnjhfvczSmWJZtwGKHzsoH1jB7u+pj5dNc/8fmKzzQNSHojhzIed23Ot
        iEuYOJMMwfKyZNASEm+rGvLsHDgZHO/GjhG/mLU/I5rnMPkXusCaMB+gQQy7woB2SIiUYT
        SIKTHaqtsKmB+QhT+0cwtnIeSoOVpJM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-bBmKl5fnPYKqwhtpJNiElQ-1; Sat, 18 Feb 2023 05:43:13 -0500
X-MC-Unique: bBmKl5fnPYKqwhtpJNiElQ-1
Received: by mail-ed1-f71.google.com with SMTP id g19-20020a056402091300b004acbf564d75so271347edz.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQPC+W/GGOaiPhupQkL+fioSZnAdQgjaIafObYt5jdo=;
        b=GHyi98qUFsD2vAJCtCRKdNDXrGPDAlZ5Xj5VMp3xDSybMwIycTYm6PW2qcNj/b2ks/
         2vkY+EmnJTsHFxyqS1gGx7xiXx/EjS+hZ9gDy+/Umulmx/PslKcm+5v3ac0Ll7WWXyfA
         Xztztn7uvEs64hi76EHhMZr0km9P67ICVE3AcgNX391U130pXjHYdva8OuHlyDinqeCz
         jxX7Mympd91Puvcmb+aXF3AVLtgG5/c0wxDWttLAjJD6DoN+8UfCAXxFNEzXYCpmHOt4
         7GofYHMYAny9YvJbvfSYYndmM6rdwtJu/RBbapzQ6UQ7ymxd2UdLkmU+Q8XWmvbX9Ypu
         fHwQ==
X-Gm-Message-State: AO0yUKWUDchIS87MdARpzodFfLdCDP9GIDz+fWI3mpj2vh7QZREl3WgA
        0haiTq7h+YZwCniBEetqG1iOHMf5KlQC4umKYM8jWVmikv2YkQJ+VzuVKixlRXbZEhBCWYoF7BJ
        xDTRVml4iBwn4nJV6jVc0vj8M
X-Received: by 2002:a17:906:9f25:b0:8b1:2eef:154c with SMTP id fy37-20020a1709069f2500b008b12eef154cmr7620894ejc.0.1676716992929;
        Sat, 18 Feb 2023 02:43:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+hLeFT07Usv4u1EkM1gYgFZeoXCyWmGNpNmdKLWF/8jBaMBmtOx0UaGDU283iz13s90G3Q/w==
X-Received: by 2002:a17:906:9f25:b0:8b1:2eef:154c with SMTP id fy37-20020a1709069f2500b008b12eef154cmr7620882ejc.0.1676716992636;
        Sat, 18 Feb 2023 02:43:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906714700b008b17b0f5d07sm2390553ejj.217.2023.02.18.02.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:43:11 -0800 (PST)
Message-ID: <eee025e7-be05-92cb-854c-ece82eb23552@redhat.com>
Date:   Sat, 18 Feb 2023 11:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Fix cache invalidation on
 resume
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213182215.53703-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230213182215.53703-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 2/13/23 19:22, Armin Wolf wrote:
> If one or both sensor buffers could not be initialized, either
> due to missing hardware support or due to some error during probing,
> the resume handler will encounter undefined behaviour when
> attempting to lock buffers then protected by an uninitialized or
> destroyed mutex.
> Fix this by introducing a "active" flag which is set during probe,
> and only invalidate buffers which where flaged as "active".
> 
> Tested on a Dell Inspiron 3505.
> 
> Fixes: 3b7eeff93d29 ("platform/x86: dell-ddv: Add hwmon support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Can you move the "if (...active)" check to inside
dell_wmi_ddv_hwmon_cache_invalidate() please ?

Otherwise this patch as well as patch 2/2 look good to me.

Regards,

Hans



> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index d547c9d09725..58f996b3b374 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -96,6 +96,7 @@ struct combined_chip_info {
>  };
> 
>  struct dell_wmi_ddv_sensors {
> +	bool active;
>  	struct mutex lock;	/* protect caching */
>  	unsigned long timestamp;
>  	union acpi_object *obj;
> @@ -530,6 +531,7 @@ static void dell_wmi_ddv_hwmon_cache_destroy(void *data)
>  {
>  	struct dell_wmi_ddv_sensors *sensors = data;
> 
> +	sensors->active = false;
>  	mutex_destroy(&sensors->lock);
>  	kfree(sensors->obj);
>  }
> @@ -549,6 +551,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *w
>  		return ERR_PTR(ret);
> 
>  	mutex_init(&sensors->lock);
> +	sensors->active = true;
> 
>  	ret = devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_destroy, sensors);
>  	if (ret < 0)
> @@ -852,9 +855,12 @@ static int dell_wmi_ddv_resume(struct device *dev)
>  {
>  	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> 
> -	/* Force re-reading of all sensors */
> -	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
> -	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
> +	/* Force re-reading of all active sensors */
> +	if (data->fans.active)
> +		dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
> +
> +	if (data->temps.active)
> +		dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
> 
>  	return 0;
>  }
> --
> 2.30.2
> 

