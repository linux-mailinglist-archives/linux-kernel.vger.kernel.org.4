Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63061681428
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbjA3PLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjA3PLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BCC3433B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXaa3DxLrmj9P5CFA6+P4O7CQaN/r3DN91sytM0riZA=;
        b=Gdm38pDeJo4+LTy7TutvKybXMYZ1B/5AtO060MyWIbqcxUlPIEAEvae5x9SPzc3egXE4i1
        DUb9Nw9ItkUouZs6nuaQhYMx0xRxxG4j1CujsDlT7mepaxzo/A5V6SfmEu2oiMQB291nGL
        oE/WgrhuhNkHlMHE1K5q+Zundm7t7xc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-TGhZ-yHEN2O0pJlbXLgI-w-1; Mon, 30 Jan 2023 10:09:59 -0500
X-MC-Unique: TGhZ-yHEN2O0pJlbXLgI-w-1
Received: by mail-ej1-f72.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so7635213ejb.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXaa3DxLrmj9P5CFA6+P4O7CQaN/r3DN91sytM0riZA=;
        b=6L3RAQwY6w13DHJbDxrUw44oVa4zTNXSecKV/8Q1gsRBnIx4s2wb5QmqaEZxt5rCgC
         4gmz8elaCF3Yx2P3ewOBo7XbUSJhKfpgcDgqM2Vo8ejqHDvoIJdmuKNUMB7nq+pmczc5
         2kJFu2jIucBPqGu03wS0cGygpN/gW6b/IElnq9GURG4lT116yrI83FcnVDSbGuFUTv6z
         nXcuYFEbfQLKAx5a2bzQmn66AhXpEpO9/KYUXvZd4d8+sTyBeeOBqFplU/Ax6QDFqO41
         wEpWbZRFOyEmxvju310aAPV8iJqvLeCGPD0rOasCtvMclbAMKy6GBxNUUq3sv0/Am57w
         4gWw==
X-Gm-Message-State: AO0yUKVCCvw+koDicj5NBsiam4el6w/i5pzI/H0DsgYRnFQ+6SGx1oN2
        TpIjXJb704gQPgw7PY6Z5H1piwuCqSDqAEVryHxY1PX8Mk0sbdTQmhRJ18WmrC43Zd1XRHG5ECE
        YRZK2C+qwAsE5510bhgwm6dcB
X-Received: by 2002:a17:907:a42a:b0:881:277:b77a with SMTP id sg42-20020a170907a42a00b008810277b77amr13917619ejc.65.1675091393854;
        Mon, 30 Jan 2023 07:09:53 -0800 (PST)
X-Google-Smtp-Source: AK7set+m64JOYL+W8N2xStqLCn2LIri/OxzmCve7tq3poUgaFHI1YtYrom+bRDUx2q7haW+ByFQuQQ==
X-Received: by 2002:a17:907:a42a:b0:881:277:b77a with SMTP id sg42-20020a170907a42a00b008810277b77amr13917600ejc.65.1675091393673;
        Mon, 30 Jan 2023 07:09:53 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090639d000b008711cab8875sm6874138eje.216.2023.01.30.07.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:09:53 -0800 (PST)
Message-ID: <f163ef7e-41ee-cfa4-67c5-4325d1381110@redhat.com>
Date:   Mon, 30 Jan 2023 16:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/5] platform/x86: dell-ddv: Add "force" module param
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-5-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230126194021.381092-5-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 1/26/23 20:40, Armin Wolf wrote:
> Until now, the dell-wmi-ddv driver needs to be manually
> patched and compiled to test compatibility with unknown
> DDV WMI interface versions.
> Add a module param to allow users to force loading even
> when a unknown interface version was detected. Since this
> might cause various unwanted side effects, the module param
> is marked as unsafe.
> Also update kernel-parameters.txt.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  drivers/platform/x86/dell/dell-wmi-ddv.c        | 13 +++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..9bbff5113427 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1024,6 +1024,9 @@
>  	dell_smm_hwmon.fan_max=
>  			[HW] Maximum configurable fan speed.
> 
> +	dell_wmi_ddv.force=
> +			[HW] Do not check for supported WMI interface versions.
> +
>  	dfltcc=		[HW,S390]
>  			Format: { on | off | def_only | inf_only | always }
>  			on:       s390 zlib hardware support for compression on

In my previous email I forgot to add that I have dropped this bit. I appreciate
the effort to document this parameter, but if we add documentation for all
existing parameters to Documentation/admin-guide/kernel-parameters.txt then
the file will become quite unyielding / unusable.

So in general we only add new parameters which we expect to be important for
a large group of users or necessary to debug serious problems like machines
not booting.

I realize that a bunch of parameters in there do not match this, like
e.g. dell_smm_hwmon.fan_max, these are just from older times when
there were just less parameters, so listing them all was still ok.

So I have merged this patch, but with the Documentation/admin-guide/kernel-parameters.txt
bit dropped.

Regards,

Hans






> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 58fadb74e86a..9695bf493ea6 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -34,6 +34,10 @@
>  #define DELL_EPPID_LENGTH	20
>  #define DELL_EPPID_EXT_LENGTH	23
> 
> +static bool force;
> +module_param_unsafe(force, bool, 0);
> +MODULE_PARM_DESC(force, "Force loading without checking for supported WMI interface versions");
> +
>  enum dell_ddv_method {
>  	DELL_DDV_BATTERY_DESIGN_CAPACITY	= 0x01,
>  	DELL_DDV_BATTERY_FULL_CHARGE_CAPACITY	= 0x02,
> @@ -349,8 +353,13 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
>  		return ret;
> 
>  	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
> -	if (version < DELL_DDV_SUPPORTED_VERSION_MIN || version > DELL_DDV_SUPPORTED_VERSION_MAX)
> -		return -ENODEV;
> +	if (version < DELL_DDV_SUPPORTED_VERSION_MIN || version > DELL_DDV_SUPPORTED_VERSION_MAX) {
> +		if (!force)
> +			return -ENODEV;
> +
> +		dev_warn(&wdev->dev, "Loading despite unsupported WMI interface version (%u)\n",
> +			 version);
> +	}
> 
>  	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> --
> 2.30.2
> 

