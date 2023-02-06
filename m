Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7268BFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBFOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjBFOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B77122A2B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675692805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02/B40HSR0LR8YaNzHPjtA1YkymmZvawyv7jl3hVYyU=;
        b=TqpNaqSnkZS9aDXVppLJypNh4i5HMUR7NXPzEpSFYFpt8LXNqMw/+bHgv4mNP6EyKHWUz3
        oY4Y7gpzRdQFM3gmDMunRahcQJVp5vfiM2Orrv/V6Xk0z4TxgKSq9XbuoHZgmEaIbk3hOT
        pOmKb/TuNVTHq0LLcDAGz62ijWRhgdY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-hgFAyIBbMIat_NV_jHn0Sw-1; Mon, 06 Feb 2023 09:13:24 -0500
X-MC-Unique: hgFAyIBbMIat_NV_jHn0Sw-1
Received: by mail-ed1-f72.google.com with SMTP id d21-20020aa7c1d5000000b004a6e1efa7d0so7573905edp.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02/B40HSR0LR8YaNzHPjtA1YkymmZvawyv7jl3hVYyU=;
        b=dcVx8JfbFKONpOxKTvXrEFH4bEfHefQIfCy5byInjAz4GZEDFvlgFlCxWfPpmZG5XG
         JlTfuqNQUjoJ9jkFD/6DxMVgt7BbvEU5XR49fP2/DeVb6DtchTXWl3SKw0epehMEvVZQ
         0qGC3CU0YOhRV7zJfoicPcWbiyeGehYlgg8EYDZ6Wbc90B4yxvSy4MLgTlz0/Lob2Z65
         oV1Y4zbBXtFAeAdxPhGMLBZ1xm75aNKSPerg2/wMFBd/qz4g2a49NUbhswe7OlglxsFa
         ZDkcT+UPxzyxRpRQVWpP8lU8QcoGPty47noYY1m/9zvftPvU0VI4qP12XsWEFEMLAs2w
         Bp7g==
X-Gm-Message-State: AO0yUKWPegROaqUJ7FpHKJW9rxzfGkyT3hpzf7s9XAHeOmlb3Z4BIlwp
        FuOovW8/nkCYH24puoRB42qakOOQeU+sY+Yhqo90wzB4v/6DjjnYgnMDhrEFaqQfxLNKkJLtqcI
        NByXdW8x84zvdLPSR1XkT0pJy
X-Received: by 2002:a50:ccc6:0:b0:4aa:bae3:f4bd with SMTP id b6-20020a50ccc6000000b004aabae3f4bdmr1823858edj.25.1675692802650;
        Mon, 06 Feb 2023 06:13:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/OmMRaUkWqA9rkq2iEAeoZTCss06qO9F1Xew4pbnxsmaEn1EufcA1OXsVcnJS3wu8Xhm6evA==
X-Received: by 2002:a50:ccc6:0:b0:4aa:bae3:f4bd with SMTP id b6-20020a50ccc6000000b004aabae3f4bdmr1823841edj.25.1675692802461;
        Mon, 06 Feb 2023 06:13:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e14-20020a50d4ce000000b004aab66d34c7sm815563edj.7.2023.02.06.06.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:13:21 -0800 (PST)
Message-ID: <296c2403-9ba3-f070-c939-ec845c7410a1@redhat.com>
Date:   Mon, 6 Feb 2023 15:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] platform/x86: dell-ddv: Prefer asynchronous probing
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230205205456.2364-1-W_Armin@gmx.de>
 <20230205205456.2364-3-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230205205456.2364-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/5/23 21:54, Armin Wolf wrote:
> During probe, both sensor buffers need to be queried to
> initialize the hwmon channels. This might be slow on some
> machines, causing a unnecessary delay during boot.
> Mark the driver with PROBE_PREFER_ASYNCHRONOUS so that it
> can be probed asynchronously.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index b7ac483eff12..cffbba5e2d9a 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> +#include <linux/device/driver.h>
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
> @@ -872,6 +873,7 @@ MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
>  static struct wmi_driver dell_wmi_ddv_driver = {
>  	.driver = {
>  		.name = DRIVER_NAME,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.id_table = dell_wmi_ddv_id_table,
>  	.probe = dell_wmi_ddv_probe,
> --
> 2.30.2
> 

