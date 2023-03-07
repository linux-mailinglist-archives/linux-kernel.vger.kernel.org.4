Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C36ADE73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCGML1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjCGMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D015617C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678191002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWv9WBhYUIpz5gRzPBlk7mRJoAlDNXXkwrUoCn79BNo=;
        b=goY3rzqQEDL8uKJwrFv3XJOsiFuIG53bNmtrzRUOcYKopAArMPveUJUf79kr8sB9qsKRxy
        iCAWfBhhAlIkCOlrJiw3qXCfxS6QYtoBGUl1kdc+pESxQxcjAVUtz6QbEf+wR9o8d9www4
        LXGRsSINutJwUtSqN/oLfxsl4oDyxgQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-sY83Jr5VN7C2DqoxqP6AYA-1; Tue, 07 Mar 2023 07:10:01 -0500
X-MC-Unique: sY83Jr5VN7C2DqoxqP6AYA-1
Received: by mail-ed1-f71.google.com with SMTP id y1-20020a056402358100b004ea439d57b7so6442602edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191000;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWv9WBhYUIpz5gRzPBlk7mRJoAlDNXXkwrUoCn79BNo=;
        b=gG10BAvB3uPvtlR6teIbdD0Wk2QGzIe7IQLE+sxkdF7uswsovA5aaV/7dtl+1lkQ+T
         yqclqncFsfNkToklorhr3ONqiWnihet2kmfgVBf938LFxykDtHKwMoCa8Om6+q+H8ZAW
         cNlEunyEMitimFsouBw7nITuN1UxpejzrsPQSrIffzJ7W09Thf3VoTPp+N01wYwVso2V
         qP5m8eiE2bkVVF518OhNvPw7b6LBTmX80tfpDhDnglnduxSh6iaAceGUDykDBkyVClKH
         z0p7xIM+7UjRIIN3Mir6RwFDsajobJxa4hL8uiUrZSQ7mE1W1xZCIiTNK7GhRNvvvCOT
         a7UQ==
X-Gm-Message-State: AO0yUKVVMWUAcH5he/5SkTk//SjNU50OQDiaoVgTH+LmlXwcLq3QHDSl
        E4l//cvnsPvpDrGd0j0PWUdXYLlVhHUYaP777t0gtiYSk/dmtirpzI+WjJP3oCTIoAVw+WudP09
        dtOBOjpynIosiXaMTcPxUq/Ign2xEFeoM
X-Received: by 2002:a17:907:1b1e:b0:8b2:8876:2a11 with SMTP id mp30-20020a1709071b1e00b008b288762a11mr20080888ejc.28.1678190999882;
        Tue, 07 Mar 2023 04:09:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/5w1pSIe+vScpQoTiMyXTIER8TAZdTUQnhrRB4sAANhC+o5yJ9527e45yJ8QAtzWUO1gnpzQ==
X-Received: by 2002:a17:907:1b1e:b0:8b2:8876:2a11 with SMTP id mp30-20020a1709071b1e00b008b288762a11mr20080867ejc.28.1678190999618;
        Tue, 07 Mar 2023 04:09:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b008dceec0fd4csm5983434ejc.73.2023.03.07.04.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:09:59 -0800 (PST)
Message-ID: <a83d9acd-a2c5-85ce-36dc-c6a8f0e11a66@redhat.com>
Date:   Tue, 7 Mar 2023 13:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: dell-laptop: Register ctl-led for
 speaker-mute
Content-Language: en-US, nl
To:     Koba Ko <koba.ko@canonical.com>, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230306142454.722020-1-koba.ko@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230306142454.722020-1-koba.ko@canonical.com>
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

On 3/6/23 15:24, Koba Ko wrote:
> Some platforms have the speaker-mute led and
> current driver doesn't control it.
> 
> If the platform support the control of speaker-mute led, register it
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>

Thank you for your patch, one small remark below.

> ---
>  drivers/platform/x86/dell/dell-laptop.c | 43 +++++++++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h |  2 ++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 1321687d923ed..38d95bae8e3ab 100644
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
> @@ -2230,6 +2259,16 @@ static int __init dell_init(void)
>  		micmute_led_registered = true;
>  	}
>  
> +	if (dell_smbios_find_token(GLOBAL_MUTE_DISABLE) &&
> +	    dell_smbios_find_token(GLOBAL_MUTE_ENABLE) &&
> +	    !dell_privacy_has_mic_mute()) {

Since this is a speaker mute LED and since the Dell hw privacy
stuff does not deal with the speaker at all, I believe that you
should drop the "&& !dell_privacy_has_mic_mute()" part of
the if condition here ?

Can you please send a new version with this dropped?

Regards,

Hans


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
> @@ -2277,6 +2316,8 @@ static int __init dell_init(void)
>  fail_backlight:
>  	if (micmute_led_registered)
>  		led_classdev_unregister(&micmute_led_cdev);
> +	if (mute_led_registered)
> +		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
>  fail_rfkill:
> @@ -2299,6 +2340,8 @@ static void __exit dell_exit(void)
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

