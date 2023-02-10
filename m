Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDAA69230C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjBJQOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjBJQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FB265B8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676045583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NitvGIVmtCGdtK4e3hCaRDRoUP9N0qyct+Wt53Ooibg=;
        b=ZLSPzJMSUHxRQFHCqfNnG8364gCjhSzHIZzI0Ve+A2qgU1r/L3UA2k9JFkUeXVhyQ1w7gl
        WMHuXnHOG2/gsClP6aQinrfya3YxIFeLBo5jotYoTPWArE+s64puGj3XVitFmg1/S2QFAJ
        iAE+zFdQMjFV3N05Hlk93zrfpjnO+SE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-M9E3FtJEOxKD1u6GysmUQg-1; Fri, 10 Feb 2023 11:13:02 -0500
X-MC-Unique: M9E3FtJEOxKD1u6GysmUQg-1
Received: by mail-ed1-f72.google.com with SMTP id b12-20020a056402278c00b004aad86c5723so3833768ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NitvGIVmtCGdtK4e3hCaRDRoUP9N0qyct+Wt53Ooibg=;
        b=bsIU2JJ+dU3nRqiftmXaTnWxNfnrjyMwa5nO3PF08u+rn2JBFOtUQmovZl0S8S8X3m
         IjxoTHi83CBimExVWkTrZo+VKMsrsS1NR2DaSTATZ4cRcGQTzd//+Yh4Ls95QGZoJ0eu
         5hSmkYnqcK59RZ/udK8RrcDKgC/PhrzeLckWIuj+IbXTuKTUbPKzqkaxZIiRa/dgxJi1
         r4HWkUEUTo0bNKGAvtc9uZhYn+GSHejb0wwYGeHGQy6z5s1+FROg4bQlJoY7Tyo1gJx4
         UT29S3OaCcJlsRGwfkKPr+TCgwiORV1H4cqpckhN+iU6b7wzdF+ie6pPBGtShWZvSFY6
         QuOA==
X-Gm-Message-State: AO0yUKXtvus4KdhInOj4cDpXS8wipZNs6IQ3qQ0FsJrPVklOWsyRe8dr
        VeXOZFiGAKhpIqObJTEyu0uZG9CqH9qch/UAp1cnl4awx/2/mN/i4nldo5H4AkHlw7y/Rul7G2O
        U+9T7357FrnRmMDX67m1Zky2QmORIHg==
X-Received: by 2002:a17:906:1e8a:b0:870:6554:92ac with SMTP id e10-20020a1709061e8a00b00870655492acmr14804257ejj.18.1676045581034;
        Fri, 10 Feb 2023 08:13:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8hAhx38R4lRnN0INGPOv9WONSN2liSQMfWSG6A5B/EUiM768qjOXvYv/ftWYu9UUPGghqrbg==
X-Received: by 2002:a17:906:1e8a:b0:870:6554:92ac with SMTP id e10-20020a1709061e8a00b00870655492acmr14804245ejj.18.1676045580880;
        Fri, 10 Feb 2023 08:13:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709066a8b00b0087f68a2681bsm2591215ejr.96.2023.02.10.08.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:13:00 -0800 (PST)
Message-ID: <c64cd8f8-a441-0fa6-2c78-fa80a937311e@redhat.com>
Date:   Fri, 10 Feb 2023 17:12:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: int3472/discrete: add LEDS_CLASS dependency
Content-Language: en-US, nl
To:     Arnd Bergmann <arnd@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230208163658.2129009-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230208163658.2129009-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/8/23 17:36, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> int3472 now fails to link when the LED support is disabled:
> 
> x86_64-linux-ld: drivers/platform/x86/intel/int3472/led.o: in function `skl_int3472_register_pled':
> led.c:(.text+0xf4): undefined reference to `led_classdev_register_ext'
> x86_64-linux-ld: led.c:(.text+0x131): undefined reference to `led_add_lookup'
> x86_64-linux-ld: drivers/platform/x86/intel/int3472/led.o: in function `skl_int3472_unregister_pled':
> led.c:(.text+0x16b): undefined reference to `led_remove_lookup'
> x86_64-linux-ld: led.c:(.text+0x177): undefined reference to `led_classdev_unregister'
> 
> Add an explicit Kconfig dependency.
> 
> Fixes: 5ae20a8050d0 ("platform/x86: int3472/discrete: Create a LED class device for the privacy LED")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for your patch, I've applied this to the pdx86/for-next
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

Regards,

Hans




> ---
>  drivers/platform/x86/intel/int3472/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/int3472/Kconfig b/drivers/platform/x86/intel/int3472/Kconfig
> index 62e5d4cf9ee5..17ae997f93ea 100644
> --- a/drivers/platform/x86/intel/int3472/Kconfig
> +++ b/drivers/platform/x86/intel/int3472/Kconfig
> @@ -4,6 +4,7 @@ config INTEL_SKL_INT3472
>  	depends on COMMON_CLK
>  	depends on I2C
>  	depends on GPIOLIB
> +	depends on LEDS_CLASS
>  	depends on REGULATOR
>  	select MFD_CORE
>  	select REGMAP_I2C

