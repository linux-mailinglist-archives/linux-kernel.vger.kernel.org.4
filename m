Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCAC6BD159
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCPNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCPNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CFC5252
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678974588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8gcYdCXFrCHWug0ZbLiId66xJ6yNt/t9Gqv4mKkphs=;
        b=TYjSptsUrcJYp6lkZjQz/6VggC3eSfGVm2BL565gqglhHuoqx7C0TtrUQI1cqsRvOJeUPr
        r/e25kyXqgcD7qZsi5UggazwZ0+gsAkLQbyCorNSMu7/SJWlp8hmZvBbNIDjSmmKwW0h/t
        fuo3jPNA3fetOWlxVuwaku3d6TQdEOY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-5srba-y8OIaCfJjQfaSpHg-1; Thu, 16 Mar 2023 09:49:47 -0400
X-MC-Unique: 5srba-y8OIaCfJjQfaSpHg-1
Received: by mail-ed1-f71.google.com with SMTP id er23-20020a056402449700b004fed949f808so3138336edb.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974585;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8gcYdCXFrCHWug0ZbLiId66xJ6yNt/t9Gqv4mKkphs=;
        b=gafperpmGZ9f35iCiSJ7IKNLdvakbUDmsLsO29jNvSd4YJZURy0ME4PqB2c3xI+zjI
         MJ7wJ0zxVDTdOuGz5sed125IatmtQA9r41xVjwVcCcsB6y+k3UBPBxV2pgQxjneEtn5F
         eOnbrn1tRqr2wKbWv/J1jjdcKhvcY1mj7gXvGmQ70I7yiK5BGlR10U1/s2idiceqziFu
         AbpqfjMEoub8mbe1DQ/lNjyqGCxmZqM60SUOZ8f0N2E/XO0oLBy0Wfha3lOeILIL+rYQ
         ht59KqkbIrqeteVhtEuQcf16GWRvnqhy5onyTrg7XSL4Lp1wTOrQGA0neqU7PqLmtqEX
         qCOg==
X-Gm-Message-State: AO0yUKXNPqKKmb1L6AeRJqkeZaBNkpQTalLFL3fQNHgdOAo9mO+VHDo/
        ynfxYm/H/ATd4QVNlnQt4/nYc7+SdAnulBEgsiOJ6PALOWsGNlPDLrETa+NEIoWgC15MCUOZao8
        Jl8XaSq5/yazzFR/JUeWuwjFP3LqvXpPD
X-Received: by 2002:a17:907:7609:b0:925:a96a:8b98 with SMTP id jx9-20020a170907760900b00925a96a8b98mr9623663ejc.67.1678974585359;
        Thu, 16 Mar 2023 06:49:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set8V/tBTDRK2wbpXPYkzR7kHk5YzVUqm8+mGtRBQbQUtv77VK+ssdF8ENomBd7Bj12xfZpXOUg==
X-Received: by 2002:a17:907:7609:b0:925:a96a:8b98 with SMTP id jx9-20020a170907760900b00925a96a8b98mr9623648ejc.67.1678974585121;
        Thu, 16 Mar 2023 06:49:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id wt10-20020a170906ee8a00b0092ce8344078sm3448927ejb.33.2023.03.16.06.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:49:44 -0700 (PDT)
Message-ID: <8df8f02c-6dd0-e9bd-e2de-6b0d132b2b77@redhat.com>
Date:   Thu, 16 Mar 2023 14:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] platform/x86: dell-laptop: Register ctl-led for
 speaker-mute
Content-Language: en-US, nl
To:     Koba Ko <koba.ko@canonical.com>, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308062414.1048913-1-koba.ko@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230308062414.1048913-1-koba.ko@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/8/23 07:24, Koba Ko wrote:
> Some platforms have the speaker-mute led and
> current driver doesn't control it.
> 
> If the platform support the control of speaker-mute led, register it
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>


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


> 
> V2: Remove the dell-privacy rule for speaker-mute.
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 42 +++++++++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h |  2 ++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index e92c3ad06d696..5ed628617f63c 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -97,6 +97,7 @@ static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
>  static bool force_rfkill;
>  static bool micmute_led_registered;
> +static bool mute_led_registered;
>  
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
> @@ -2177,6 +2178,34 @@ static struct led_classdev micmute_led_cdev = {
>  	.default_trigger = "audio-micmute",
>  };
>  
> +static int mute_led_set(struct led_classdev *led_cdev,
> +			   enum led_brightness brightness)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +	int state = brightness != LED_OFF;
> +
> +	if (state == 0)
> +		token = dell_smbios_find_token(GLOBAL_MUTE_DISABLE);
> +	else
> +		token = dell_smbios_find_token(GLOBAL_MUTE_ENABLE);
> +
> +	if (!token)
> +		return -ENODEV;
> +
> +	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> +	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +
> +	return 0;
> +}
> +
> +static struct led_classdev mute_led_cdev = {
> +	.name = "platform::mute",
> +	.max_brightness = 1,
> +	.brightness_set_blocking = mute_led_set,
> +	.default_trigger = "audio-mute",
> +};
> +
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;
> @@ -2230,6 +2259,15 @@ static int __init dell_init(void)
>  		micmute_led_registered = true;
>  	}
>  
> +	if (dell_smbios_find_token(GLOBAL_MUTE_DISABLE) &&
> +	    dell_smbios_find_token(GLOBAL_MUTE_ENABLE)) {
> +		mute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MUTE);
> +		ret = led_classdev_register(&platform_device->dev, &mute_led_cdev);
> +		if (ret < 0)
> +			goto fail_led;
> +		mute_led_registered = true;
> +	}
> +
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return 0;
>  
> @@ -2277,6 +2315,8 @@ static int __init dell_init(void)
>  fail_backlight:
>  	if (micmute_led_registered)
>  		led_classdev_unregister(&micmute_led_cdev);
> +	if (mute_led_registered)
> +		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
>  fail_rfkill:
> @@ -2299,6 +2339,8 @@ static void __exit dell_exit(void)
>  	backlight_device_unregister(dell_backlight_device);
>  	if (micmute_led_registered)
>  		led_classdev_unregister(&micmute_led_cdev);
> +	if (mute_led_registered)
> +		led_classdev_unregister(&mute_led_cdev);
>  	dell_cleanup_rfkill();
>  	if (platform_device) {
>  		platform_device_unregister(platform_device);
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index 75fa8ea0476dc..eb341bf000c67 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -34,6 +34,8 @@
>  #define KBD_LED_AUTO_100_TOKEN	0x02F6
>  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
> +#define GLOBAL_MUTE_ENABLE	0x058C
> +#define GLOBAL_MUTE_DISABLE	0x058D
>  
>  struct notifier_block;
>  

