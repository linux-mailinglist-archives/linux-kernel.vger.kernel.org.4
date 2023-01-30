Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8D68141C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbjA3PHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjA3PHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE432C667
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWv+9lQErEOpmvS1MXMOKghi6wkYZ4ZVqaYkbA6HKOE=;
        b=a9k9KH/hwSYTb2bebZS/vIonFbVUW08V7Bxb/RpFuv39j1kGoTYNXdSF7UZs6Ul7SoErEm
        Lu3eDdpwpZIkkZNykv4ugsRh9pvjPR+9N86qcYmFwcWJpRq16X0h9LdR3ww0ZjPdN9+ZY5
        Y4tuVn3Lga74dV82V4O94/wry6p+cMk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-6qYC6vCzM7qDLduksJah3Q-1; Mon, 30 Jan 2023 10:06:34 -0500
X-MC-Unique: 6qYC6vCzM7qDLduksJah3Q-1
Received: by mail-ej1-f69.google.com with SMTP id z2-20020a1709060be200b0088b579825f9so333726ejg.18
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWv+9lQErEOpmvS1MXMOKghi6wkYZ4ZVqaYkbA6HKOE=;
        b=HjYGaDn3pSBJoEoSYnqZ/hDnLmrd1BR5h80ht++5m3uRnzwDa8vLmjAJZDI2rBeLd3
         Fiw2UIw3Tf3+eAUQwV+SfBsH+yS+hgwaL2+bL9XJ+Haj64kvxBCMtVqVAk5iJbg3GwVd
         8OwwcjMeHwqVFyJhtpt0qpI2RI3UI2W+Mhju2cVb3MyiaSe6Z7BM1nqw/ylU3Uysdq6K
         JmdfRj3O6IYkQA1/JKbMpMeO2a4Pt9HWxiDezKvrFNbtxaTikWabG6OiLQnXR9hOCovP
         CI1HDyM4VQg3A2Fn+H29xIUnm9BYijLeIlagGp+P3mo4ajERv1g8Gb6AZh4+QWSPLACZ
         PJlw==
X-Gm-Message-State: AO0yUKXiRN6O2AYf12z9iCgofyXC2l4Dv0gF2+6xi5ymiJm8JAtuclof
        pgHHA6X/tn4Hyvd2BpEVxcz3gbdZ1iQwQeCDeuOgVEGj/rhitFWfKKf4he+b4a1jiiwDme21USU
        ggu0vDMct4QUOgZyOHoTHlA2l
X-Received: by 2002:a17:906:af98:b0:87b:bbd4:1bd2 with SMTP id mj24-20020a170906af9800b0087bbbd41bd2mr13347827ejb.52.1675091193122;
        Mon, 30 Jan 2023 07:06:33 -0800 (PST)
X-Google-Smtp-Source: AK7set9RUd8d/tjAsEpde550T5Fz/25S75eV1kk7Bmtd/vwtBaPShn52VDaj7HHlTyPxNWuTkfX4qw==
X-Received: by 2002:a17:906:af98:b0:87b:bbd4:1bd2 with SMTP id mj24-20020a170906af9800b0087bbbd41bd2mr13347815ejb.52.1675091192889;
        Mon, 30 Jan 2023 07:06:32 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b0087848a5daf5sm6942304ejo.225.2023.01.30.07.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:06:32 -0800 (PST)
Message-ID: <3a13b29e-e1f1-ef0b-338b-b89797981287@redhat.com>
Date:   Mon, 30 Jan 2023 16:06:31 +0100
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

