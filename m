Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49A6681414
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjA3PGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjA3PGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8617140
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8UBrsW791ANKIZLkk9Wg2fhlw6FmVWSXIe4mUfTd40=;
        b=HMoPArzN8cehhhdVpg7VCo2lOaynM3ghwQcaeDlbPY2IbI5/rT35wXJLVE4UEk/kC7q1IK
        eTdBTUwQ3GfiE0jZjoJDIYI1CKN0hU9kkyerO7p3b30/f+2M3syWKHctKSELy7kawN0BHn
        tPsPyBK6QIM7Mxb39GlxGrfrDfjc3oQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-Iq_SbwgrMeSOpcp6QCVVFw-1; Mon, 30 Jan 2023 10:05:55 -0500
X-MC-Unique: Iq_SbwgrMeSOpcp6QCVVFw-1
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b0049e385d5830so8485179edw.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8UBrsW791ANKIZLkk9Wg2fhlw6FmVWSXIe4mUfTd40=;
        b=18YOd6zDpex0y57srnRJvXy8FDf/5sSc+HXQl9us5AzCMJn10vROclP780GSy9wmWm
         fknJAzmOTc4BRa76I9DwhfkmZZV1hLZqhq/1Wyo6stLy0dRTfIvqPSKhIAtxrJJbHCpf
         90U8/ycMfpC8WCYVU5PHts3I83Y59AI2FtuZSJeaVwJQmwyitwRdBNeQB3LqeeIcz4GI
         M9cD3yfWENTBH0AQoPe25Ym38Ta8XQAibJKJZLIIC9Y1PrKzYXLkLBflFWrg8FKTtvI6
         JGvail5kowf0VTStt28nGEZp2bXuxggkvw5M3TnAGb92iYKvO2FSfD7wpglk3DuwxIfC
         NkzQ==
X-Gm-Message-State: AO0yUKXWNzMgjjLQSq5Gi//hzWpi6gQpEx+xcU+6aB3FM62nLVNNddzN
        jqAuoD2NopUWa3egd6cLTcXbKM3KxFBjtfxD6QtMhlp+f566+NF0xf3Ux16B3gyy8R/4POrrB11
        MCPv1Fqo/8S1neCg83Tsc2DXE
X-Received: by 2002:a17:906:3991:b0:878:46ed:6a29 with SMTP id h17-20020a170906399100b0087846ed6a29mr20823497eje.3.1675091154843;
        Mon, 30 Jan 2023 07:05:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+M8H6/btJef9MAU3wiesmw8IQmNvnJHDjvDsh87w+A3bvgME+Oqdzx0HYQEKqQoFX3yS2j8g==
X-Received: by 2002:a17:906:3991:b0:878:46ed:6a29 with SMTP id h17-20020a170906399100b0087846ed6a29mr20823485eje.3.1675091154658;
        Mon, 30 Jan 2023 07:05:54 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709064dd100b0087853fbb55dsm6863912ejw.40.2023.01.30.07.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:05:54 -0800 (PST)
Message-ID: <94ae8042-89f7-9210-1bda-a22dd9fe7d4d@redhat.com>
Date:   Mon, 30 Jan 2023 16:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/5] platform/x86: dell-ddv: Return error if buffer is
 empty
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-3-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230126194021.381092-3-W_Armin@gmx.de>
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

On 1/26/23 20:40, Armin Wolf wrote:
> In several cases, the DDV WMI interface can return buffers
> with a length of zero. Return -ENODATA in such a case for
> proper error handling. Also replace some -EIO errors with
> more specialized ones.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 9cb6ae42dbdc..f99c4cb686fd 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -11,6 +11,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/dev_printk.h>
> +#include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/kstrtox.h>
>  #include <linux/math.h>
> @@ -125,21 +126,27 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device *wdev, enum dell_ddv_meth
>  	if (ret < 0)
>  		return ret;
> 
> -	if (obj->package.count != 2)
> -		goto err_free;
> +	if (obj->package.count != 2 ||
> +	    obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
> +	    obj->package.elements[1].type != ACPI_TYPE_BUFFER) {
> +		ret = -ENOMSG;
> 
> -	if (obj->package.elements[0].type != ACPI_TYPE_INTEGER)
>  		goto err_free;
> +	}
> 
>  	buffer_size = obj->package.elements[0].integer.value;
> 
> -	if (obj->package.elements[1].type != ACPI_TYPE_BUFFER)
> +	if (!buffer_size) {
> +		ret = -ENODATA;
> +
>  		goto err_free;
> +	}
> 
>  	if (buffer_size > obj->package.elements[1].buffer.length) {
>  		dev_warn(&wdev->dev,
>  			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer size (%d)\n",
>  			 buffer_size, obj->package.elements[1].buffer.length);
> +		ret = -EMSGSIZE;
> 
>  		goto err_free;
>  	}
> @@ -151,7 +158,7 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device *wdev, enum dell_ddv_meth
>  err_free:
>  	kfree(obj);
> 
> -	return -EIO;
> +	return ret;
>  }
> 
>  static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_method method,
> --
> 2.30.2
> 

