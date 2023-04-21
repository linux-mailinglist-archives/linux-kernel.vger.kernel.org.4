Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192016EA727
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjDUJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDUJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD4A5C6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682069815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzH8QW/csXN0CxzGkETec+n4HWfPUmGi/veY0RKNigI=;
        b=d9Z1ewWim8EUz8Rshr/DJ5otnCo8vhaSbpZsz1fwu/+KWDJlHUXHSxtbeOMUJPEF8ZiaAK
        cAPbTrbzgrB4KwemynWWp2LX/3QpvxWI9qQtA5QwrRQmPjaEV0p+D/CT6kaR5woR1mMibW
        nUbFvmFupDrmFiD7xsYMs19lsKsMN38=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-KWA3DhtiN_mo801N1TjrRg-1; Fri, 21 Apr 2023 05:36:54 -0400
X-MC-Unique: KWA3DhtiN_mo801N1TjrRg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94f271ebbc2so149066566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682069812; x=1684661812;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzH8QW/csXN0CxzGkETec+n4HWfPUmGi/veY0RKNigI=;
        b=HP3j+vkX75ZP8BGG0epVZV/ebxOxnSy6WeDRTh0rxtloKxX9uRbR8I5F/8MNvK34tJ
         SE3d9+zV5W1sEGMZvXbJ70+lXJwqsmmAiaY6QUn4qpMrIi3n4uy1vRXv0LDddn4qKDQM
         1b/a6ZipWE4GlcK+YuKrilhl8RtZwPD9PyWFqzGGoWkG0RRYap0X2cQ/TELsyfFreFz0
         oOkxUFOZXd1zU41mk4x6R07lfkkF+giD24dS38JxK2AQ48aSe2YPV+g1r724G1L9Po/a
         /E+8rkYepFGBQRExzHlpesE0gb6OlJtzHpT8eSFcq4l+nENwqsaTd+Qn7xPlX4x/mqoU
         SMHA==
X-Gm-Message-State: AAQBX9fN7JZHH3Y44MHcuSrc71KuqIuXg9Ax7b76f+uUSiw8wp/R+LOq
        NKvMQ3MZeWIuEpgx/xzP0iQyJktbcuAvhH22fBbgDJx4pSirjY8VWpa9zPMU9uF7ZZPuQDhV+7g
        kTqVb1Ka4SALx3EHFbEBVfUW9z4dICpR6
X-Received: by 2002:a17:906:b354:b0:953:3e29:f35c with SMTP id cd20-20020a170906b35400b009533e29f35cmr1733511ejb.45.1682069812659;
        Fri, 21 Apr 2023 02:36:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350baQKAMD9B4o30q5gQRB/0ZHP7CQjqkTnOQkVeItXf6HwlW8pFLFiptNIBKmQfsiYwSmMf3yA==
X-Received: by 2002:a17:906:b354:b0:953:3e29:f35c with SMTP id cd20-20020a170906b35400b009533e29f35cmr1733498ejb.45.1682069812419;
        Fri, 21 Apr 2023 02:36:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0094f432f2429sm1827793ejb.109.2023.04.21.02.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 02:36:51 -0700 (PDT)
Message-ID: <6feb48c8-6d74-6605-b7d1-48103ca9187e@redhat.com>
Date:   Fri, 21 Apr 2023 11:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] iio: light: al3320a: Handle ACPI device CALS0001
Content-Language: en-US, nl
To:     Marius Hoch <mail@mariushoch.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420232631.68864-1-mail@mariushoch.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230420232631.68864-1-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/21/23 01:26, Marius Hoch wrote:
> This sensor can be found as CALS0001 on the Lenovo Yoga
> Tablet 2 series.
> 
> Tested on a Lenovo Yoga Tablet 2 1051-F.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>
> ---
> v2: Explicitly include <linux/mod_devicetable.h> (don't rely on
> linux/i2c.h including it)

Thanks, the patch looks good to me and I have
tested this successfully on a Lenovo Yoga Tablet 2 851F :

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/iio/light/al3320a.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 9ff28bbf34bb..36214d790f71 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -16,6 +16,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -247,11 +248,18 @@ static const struct of_device_id al3320a_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, al3320a_of_match);
>  
> +static const struct acpi_device_id al3320a_acpi_match[] = {
> +	{"CALS0001"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
> +
>  static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
>  		.of_match_table = al3320a_of_match,
>  		.pm = pm_sleep_ptr(&al3320a_pm_ops),
> +		.acpi_match_table = al3320a_acpi_match,
>  	},
>  	.probe_new	= al3320a_probe,
>  	.id_table	= al3320a_id,
> 
> base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f

