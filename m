Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7084A61FED7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKGTol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKGToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C218E10
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667850219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AnQkkxeXV0W5i5BhTk5A0lEhldRduibOLeYJDu0I1c=;
        b=QF6XU33vyoXNVcKWrIfuUB8Od5/thKpBA+L7cMxzqM9UwxRtp1eLTCt9H4uxOCXqnI0g20
        Xar2s9gGimt/eQRA53CHZp3L3xJDu3+fQdui5wg3Akxm/+Pl+6YziCW+JFr2GTJOl4zLax
        ag3WiYdt/j330BA++Hwif0gPdYlTRqc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-IuSGfYTyMAuLEHjNyvwyng-1; Mon, 07 Nov 2022 14:43:38 -0500
X-MC-Unique: IuSGfYTyMAuLEHjNyvwyng-1
Received: by mail-ej1-f69.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso6937152ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AnQkkxeXV0W5i5BhTk5A0lEhldRduibOLeYJDu0I1c=;
        b=HDQTbMQDBV71uy0BjsVUsa/uFWoQjjY2JPLP7XnZ2rGbUJLYaUCmDybBqYpeYWu4I6
         9wO/PPCjlAntTRgjWTQgOBL+WeXJ1nprqG9qNkzoT2gYt4mAAwkqmvrMD8a+5dH37ke0
         jqdkuNhaVowpIikFPXKkrohuUiH9DaZPp4xZ2bCA7Ua9y/WgJwmMIxB9MFsv5Jn+kJ+3
         +fy+uxADTilHMLXMDBSplSItWNtmmMMJyAwlTDfpSSi0dW7t4bqLuLLyRla6sgwA3+E2
         LmZuN2JE6QJKgOZxzNcqDB/ZO7/O/yZNDd0E20femGwwmG8hcUtQT7Li4w2cLG7BYkXP
         wqCg==
X-Gm-Message-State: ACrzQf1Vvsle674DuWiSvvd+1ZLtiG7GwIrjMRGWt6XA2xmYZPShpmDU
        jJN6ImqxkSsV7A6roow5yBdCwbwGm9tltgnUkarvCk4aQqMj4DWLeFBk01d/JaafxA8uk5jp2Ku
        SfVNlNZaGnNA9JE91Umg5nUHI
X-Received: by 2002:a17:907:5cb:b0:791:96ec:f436 with SMTP id wg11-20020a17090705cb00b0079196ecf436mr51337752ejb.100.1667850216728;
        Mon, 07 Nov 2022 11:43:36 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5RNrhsn5Af//r93f7uPW0HNWc61mhMfbgCMrZaZgjDVlmL3t7weeTQSsc7gXvpt9u7R88CyQ==
X-Received: by 2002:a17:907:5cb:b0:791:96ec:f436 with SMTP id wg11-20020a17090705cb00b0079196ecf436mr51337737ejb.100.1667850216558;
        Mon, 07 Nov 2022 11:43:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id pj27-20020a170906d79b00b007ad96726c42sm3794816ejb.91.2022.11.07.11.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:43:36 -0800 (PST)
Message-ID: <00889f1f-d9e5-9607-6932-f72417953ea7@redhat.com>
Date:   Mon, 7 Nov 2022 20:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 24/26] drm: gm12u320: Remove #ifdef guards for PM related
 functions
Content-Language: en-US, nl
To:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175510.361051-1-paul@crapouillou.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107175510.361051-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/22 18:55, Paul Cercueil wrote:
> Use the pm_ptr() macro to handle the .suspend / .resume / .reset_resume
> callbacks.
> 
> This macro allows the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_PM is disabled, without having
> to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch. It also allows to drop the
> __maybe_unused tags.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/gpu/drm/tiny/gm12u320.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index 7441d992a5d7..0a901201142e 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/usb.h>
>  
>  #include <drm/drm_atomic_helper.h>
> @@ -718,15 +719,15 @@ static void gm12u320_usb_disconnect(struct usb_interface *interface)
>  	drm_atomic_helper_shutdown(dev);
>  }
>  
> -static __maybe_unused int gm12u320_suspend(struct usb_interface *interface,
> -					   pm_message_t message)
> +static int gm12u320_suspend(struct usb_interface *interface,
> +			    pm_message_t message)
>  {
>  	struct drm_device *dev = usb_get_intfdata(interface);
>  
>  	return drm_mode_config_helper_suspend(dev);
>  }
>  
> -static __maybe_unused int gm12u320_resume(struct usb_interface *interface)
> +static int gm12u320_resume(struct usb_interface *interface)
>  {
>  	struct drm_device *dev = usb_get_intfdata(interface);
>  	struct gm12u320_device *gm12u320 = to_gm12u320(dev);
> @@ -747,11 +748,9 @@ static struct usb_driver gm12u320_usb_driver = {
>  	.probe = gm12u320_usb_probe,
>  	.disconnect = gm12u320_usb_disconnect,
>  	.id_table = id_table,
> -#ifdef CONFIG_PM
> -	.suspend = gm12u320_suspend,
> -	.resume = gm12u320_resume,
> -	.reset_resume = gm12u320_resume,
> -#endif
> +	.suspend = pm_ptr(gm12u320_suspend),
> +	.resume = pm_ptr(gm12u320_resume),
> +	.reset_resume = pm_ptr(gm12u320_resume),
>  };
>  
>  module_usb_driver(gm12u320_usb_driver);

