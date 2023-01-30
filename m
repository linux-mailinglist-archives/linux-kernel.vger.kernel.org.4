Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA91681411
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjA3PGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjA3PGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9211814C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUM0dPONsUdhNpTsUP0aFbzs6vKtU/sYkU05mhf9k4M=;
        b=Y4Lku+Wvn48JYls6T86SfHMekrc7y22lRsMR1S/Fyia4eBhwYsdpX9Gf5m7HjC1UofVt8m
        MlyklhqDWSP8hOoChsjp3/lQSmZhEVx55b07F/fqp8uyCPKz2ki0D7VwQoR3igQgKkiNyH
        gICkov7n7lHVIfG3ml6iRCLCeeaR7ZE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-WvrO0_GMMumpbjFvAyvgAQ-1; Mon, 30 Jan 2023 10:05:45 -0500
X-MC-Unique: WvrO0_GMMumpbjFvAyvgAQ-1
Received: by mail-ed1-f72.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso8441833edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUM0dPONsUdhNpTsUP0aFbzs6vKtU/sYkU05mhf9k4M=;
        b=32FODdGC5KzwLtTgaZhng8tUK0/L5gnN421Uc/+5Dh182a/UHIJLccgwUjkqBGXwpU
         Gywjt76Ict50M0Bjqe1S0KI04RU/YTg9r8Ki+1QVKAQbnF+tqJSc82HZc+o0HKK3PsA5
         wcpEjr7+nF4uZN16GX1AQPL6nK/8ImjtHP83FuAgnJP1qOIPRMfuLkOPgOvwhnmRxCrF
         qeOIghYjBqsL6mdOMVYkL11U/YxxxH7+bC1fx1gOdVl2QPmO1v/ljlRmMrDrQZSkNXgj
         I9061uPHWt0uDUE9i4R8NYi68PXSQNhOFCjmWwFWjREIkXDlOVnSm3DW95MsgHL8F8Ch
         zBZQ==
X-Gm-Message-State: AFqh2koC8wDcKUXEVNrC4SOc4YGSUOpeH3PNFzWUVjDNbbgFfXQWI1Ix
        SOcf7oDlvddy2GrkNuwfmVFycmKImO64PfKn31Il5hJYRubyDMC8zB/8Hdcsgnqo+SWE2Fw1VfA
        3O9A/nvKtDV485HIS3jcUZW8v
X-Received: by 2002:a05:6402:28cb:b0:49e:db43:1722 with SMTP id ef11-20020a05640228cb00b0049edb431722mr38656372edb.18.1675091143708;
        Mon, 30 Jan 2023 07:05:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuQOsjZdhW/i+bNK1dRKHsjjmyb26SL93PMVoyqdZSzL8SNaRBxQ88jkzC8E8k04Wif130wzw==
X-Received: by 2002:a05:6402:28cb:b0:49e:db43:1722 with SMTP id ef11-20020a05640228cb00b0049edb431722mr38656350edb.18.1675091143523;
        Mon, 30 Jan 2023 07:05:43 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ec2-20020a0564020d4200b004a21d03155bsm4346533edb.88.2023.01.30.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:05:42 -0800 (PST)
Message-ID: <c7f18127-6be2-87b4-d462-af312cc68032@redhat.com>
Date:   Mon, 30 Jan 2023 16:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/5] platform/x86: dell-ddv: Add support for interface
 version 3
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-2-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230126194021.381092-2-W_Armin@gmx.de>
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
> While trying to solve a bugreport on bugzilla, i learned that
> some devices (for example the Dell XPS 17 9710) provide a more
> recent DDV WMI interface (version 3).
> Since the new interface version just adds an additional method,
> no code changes are necessary apart from whitelisting the version.
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
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 2bb449845d14..9cb6ae42dbdc 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -26,7 +26,8 @@
> 
>  #define DRIVER_NAME	"dell-wmi-ddv"
> 
> -#define DELL_DDV_SUPPORTED_INTERFACE 2
> +#define DELL_DDV_SUPPORTED_VERSION_MIN	2
> +#define DELL_DDV_SUPPORTED_VERSION_MAX	3
>  #define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"
> 
>  #define DELL_EPPID_LENGTH	20
> @@ -49,6 +50,7 @@ enum dell_ddv_method {
>  	DELL_DDV_BATTERY_RAW_ANALYTICS_START	= 0x0E,
>  	DELL_DDV_BATTERY_RAW_ANALYTICS		= 0x0F,
>  	DELL_DDV_BATTERY_DESIGN_VOLTAGE		= 0x10,
> +	DELL_DDV_BATTERY_RAW_ANALYTICS_A_BLOCK	= 0x11, /* version 3 */
> 
>  	DELL_DDV_INTERFACE_VERSION		= 0x12,
> 
> @@ -340,7 +342,7 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
>  		return ret;
> 
>  	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
> -	if (version != DELL_DDV_SUPPORTED_INTERFACE)
> +	if (version < DELL_DDV_SUPPORTED_VERSION_MIN || version > DELL_DDV_SUPPORTED_VERSION_MAX)
>  		return -ENODEV;
> 
>  	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
> --
> 2.30.2
> 

