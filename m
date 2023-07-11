Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6974EB79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGKKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F7BF9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689070038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZ1Zgpgj63HwlWEwsThyu6JQTmo8pm99b3bKVT/0+Bg=;
        b=TF+PxuUPt6YCzAkLp6iEsplm4Zo+Ajd512Jwcrls+8uCT7Hwmtqt7yRm7hStxl63wlIDT8
        UFI3LtZzuD/txldRabect52wajAB4S8xhCvIDSQ67u5CtzFYX4oUV3S0GWHxFDGZjrFt+s
        lj6gdyOhM9vlkRya73598PCGvBN6vsM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-FCNK8GS9PlSekO8RzJ33TA-1; Tue, 11 Jul 2023 06:07:17 -0400
X-MC-Unique: FCNK8GS9PlSekO8RzJ33TA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34a0b75eso347366266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070036; x=1691662036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ1Zgpgj63HwlWEwsThyu6JQTmo8pm99b3bKVT/0+Bg=;
        b=VDdy60GQE7PSXi0oxZzgd6qSRxZzjCkFhnn1g+/xV+QIe6TTlJxeEHt7Z8byqEiduZ
         +X0CIYVCDvZILBhG1ZaV990r1VSXJkg3aXJKdGlwUDm+B5oV2tyl6uULMuYzT7969QNj
         B2ZJiOpieuLooxk1zYcsmRIngcuyKDWSfnngvQ9xQTiPkv95nSgScjYWP0mtPj1ZnJdR
         5HNgNvCIHW522ziiF9SHWcnXoF9PxSABQ3SrBEU8a/1lfXAAiKBEoCSsTq8XER0oSlDE
         Sfz91FhjOnlcXpDNqUWO2IuhiX9/olmfBFCxmnBtzxIcfVNND9voJPm17CZ7120ex3ps
         0zgw==
X-Gm-Message-State: ABy/qLYy72/Qx/yFQpoP8XV4rehnPNdczVzbc6Kw868e2P1Lrg+Bc+6U
        N4cJLBwOm858HdkIAiR1h0W3e4Je5XQsHfTXJQHT1WauRBbR594MaelBdEv8AH+gOeaKIGPeDKG
        OnFf8DS6GIDePNE/3WdzOgX4I
X-Received: by 2002:a17:906:7a0a:b0:993:d6bc:a48c with SMTP id d10-20020a1709067a0a00b00993d6bca48cmr14516421ejo.1.1689070036100;
        Tue, 11 Jul 2023 03:07:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+/om4tcSMyQz1hCZ852VhrJeYEsGhn+t+zR2tDcDzsnqJcXQM+57d0CWh2h2C5po5WopocQ==
X-Received: by 2002:a17:906:7a0a:b0:993:d6bc:a48c with SMTP id d10-20020a1709067a0a00b00993d6bca48cmr14516399ejo.1.1689070035842;
        Tue, 11 Jul 2023 03:07:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lf16-20020a170907175000b00993928e4d1bsm960476ejc.24.2023.07.11.03.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:07:15 -0700 (PDT)
Message-ID: <be62be68-d69a-9081-68d2-8202da3a49f1@redhat.com>
Date:   Tue, 11 Jul 2023 12:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Improve error handling
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707010333.12954-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230707010333.12954-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/7/23 03:03, Armin Wolf wrote:
> If for some reason a external function returns -ENODEV,
> no error message is being displayed because the driver
> assumes that -ENODEV can only be returned internally if
> no sensors, etc where found.
> Fix this by explicitly returning 0 in such a case since
> missing hardware is no error. Also remove the now obsolete
> check for -ENODEV.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your series, I've applied this series to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

I will include this series in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 2750dee99c3e..db1e9240dd02 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -616,7 +616,8 @@ static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
>  	}
> 
>  	if (index < 2) {
> -		ret = -ENODEV;
> +		/* Finding no available sensors is not an error */
> +		ret = 0;
> 
>  		goto err_release;
>  	}
> @@ -841,13 +842,13 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
> 
>  	if (IS_REACHABLE(CONFIG_ACPI_BATTERY)) {
>  		ret = dell_wmi_ddv_battery_add(data);
> -		if (ret < 0 && ret != -ENODEV)
> +		if (ret < 0)
>  			dev_warn(&wdev->dev, "Unable to register ACPI battery hook: %d\n", ret);
>  	}
> 
>  	if (IS_REACHABLE(CONFIG_HWMON)) {
>  		ret = dell_wmi_ddv_hwmon_add(data);
> -		if (ret < 0 && ret != -ENODEV)
> +		if (ret < 0)
>  			dev_warn(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
>  	}
> 
> --
> 2.30.2
> 

