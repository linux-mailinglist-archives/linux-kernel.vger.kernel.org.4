Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095F667C28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjALRAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbjALQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF496B5DB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673541664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJOxkN8927tnEj4ZfQyHiTgr5i+wmZJvSnDXmvUIIRc=;
        b=B0+pNnLEI5ZUV4xu9+u9+p+c1xoph7V2WAqcM0Jg4IiUZfYhVqzOCFk+mmT6f63UjgDQg8
        Q08oVRASZ0O4a5v9IkFHNKJauy+5dSiI6IjPSrLEnjjVVCbzRF3Dwh2jQ1grgZo7t3aHXw
        y/cmFu3dp2/VUTxXCS74NJc9htJLc1E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-12m2oIBUM9qpsusW4RVRfw-1; Thu, 12 Jan 2023 11:41:00 -0500
X-MC-Unique: 12m2oIBUM9qpsusW4RVRfw-1
Received: by mail-ed1-f70.google.com with SMTP id b16-20020a056402279000b0046fb99731e6so12497419ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJOxkN8927tnEj4ZfQyHiTgr5i+wmZJvSnDXmvUIIRc=;
        b=aFJhS62ZI7EmpdKFD404UK3iIn5s33jtf0eHSXVPb7DYm3r7asMIvJudxpN8+q6mIz
         27pfzRcipq3B6071cW0u2aszZIdKp6hl7xeHOca25AHJzTJ1faTnK7tDfRC0ayYHKtG+
         tB3oMbRzNxZLOLC0FXOaZT4lJGKVMJSvJXJWvnn5WbZpVgYRIR/d26NnVUqo+DelwcuE
         YfLC+tJixvNvdt47XBxOKfUZGfgE982+hHSuvkSpwQe7a0555D5sPYo5RCkpH9T35G3I
         6jB66DTPSG9mf8afkOgGKwiM5Ag/dTaUCsi7qCRLFbCrhf/4cKwPzvFU9PNC0JCZALuA
         wBUA==
X-Gm-Message-State: AFqh2krDilmDtvGOfCllc2aSTv5zIT2TXthO+MQ9WMnYcIOz2vYw/kUU
        sYjcWZHuhOr5u2NVsHnl56qCxEYphm0W8eaJWOeojcmrP1ln4Bw9ow1+7xC5wlQapmgOdsdaPwt
        uaPMEvD4R3ecVJCnlKLtI3DS2
X-Received: by 2002:a05:6402:2420:b0:463:a84c:6805 with SMTP id t32-20020a056402242000b00463a84c6805mr72404050eda.15.1673541659456;
        Thu, 12 Jan 2023 08:40:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSifSqx/0Hoj/B9OhNbDfeP6kFYOCC9Z88oZrvAET0YY4nVBR5FuPZPs/QoCkumgS6SlY98A==
X-Received: by 2002:a05:6402:2420:b0:463:a84c:6805 with SMTP id t32-20020a056402242000b00463a84c6805mr72404031eda.15.1673541659255;
        Thu, 12 Jan 2023 08:40:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7cd8d000000b0047e6fdbf81csm7360238edv.82.2023.01.12.08.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:40:58 -0800 (PST)
Message-ID: <83323dac-3bb7-91a5-5e44-b78141fe63c5@redhat.com>
Date:   Thu, 12 Jan 2023 17:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dell-smbios: fix double free in dell_smbios_init() and
 fixes in dell_smbios_exit()
Content-Language: en-US, nl
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     Mark Gross <markgross@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20221215231741.154355-1-subkhankulov@ispras.ru>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221215231741.154355-1-subkhankulov@ispras.ru>
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

On 12/16/22 00:17, Rustam Subkhankulov wrote:
> If an error occurs in function build_tokens_sysfs(), then all the memory
> that has been allocated is correctly freed at certain labels at the end
> of this function.
> 
> build_tokens_sysfs() returns a non-zero value on error, function
> free_group() is called, resulting in a double-free. Removing
> free_group() function call will fix this problem.

You say that removing the free_group() function call will fix this problem
and I agree, but the patch does not actually remove the free_group()
call.

> Also, it seems that instead of free_group() call, there should be
> exit_dell_smbios_smm() and exit_dell_smbios_wmi() calls, since there is
> initialization, but there is no release of resources in case of an error.

This is correct too, but again not what the patch does ...

Please submit a new patch which actually replaces the free_group
call in this error-path with calling exit_dell_smbios_wmi() +
exit_dell_smbios_smm()

> Since calling 'exit' functions for 'smm' and 'wmi' is unsafe if
> initialization failed, in dell_smbios_exit() and dell_smbios_init()
> we need to call 'exit' only if initialization before was successful.

This is actually not correct, exit_dell_smbios_wmi() checks
an internal wmi_supported flag and exit_dell_smbios_smm()
checks if init_dell_smbios_smm() has created its platform_device.

There are some error-exit paths in init_dell_smbios_wmi() and
exit_dell_smbios_smm() which do not properly clear wmi_supported
resp. platform_device. Fixing those would be good, but adding new
variables inside dell-smbios-base.c to track this is not necessary.

Note the fix clearing wmi_supported / platform_device should
be done in a separate patch from the one replacing the free_group()
call.

Regards,

Hans





> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
> Fixes: 25d47027e100 ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index fc086b66f70b..cfef8cdd1215 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -29,6 +29,8 @@ static struct device_attribute *token_location_attrs;
>  static struct device_attribute *token_value_attrs;
>  static struct attribute **token_attrs;
>  static DEFINE_MUTEX(smbios_mutex);
> +static bool wmi_initialized;
> +static bool smm_initialized;
>  
>  struct smbios_device {
>  	struct list_head list;
> @@ -607,6 +609,9 @@ static int __init dell_smbios_init(void)
>  			goto fail_sysfs;
>  	}
>  
> +	wmi_initialized = !(wmi);
> +	smm_initialized = !(smm);
> +
>  	return 0;
>  
>  fail_sysfs:
> @@ -628,8 +633,16 @@ static int __init dell_smbios_init(void)
>  
>  static void __exit dell_smbios_exit(void)
>  {
> -	exit_dell_smbios_wmi();
> -	exit_dell_smbios_smm();
> +	if (wmi_initialized) {
> +		exit_dell_smbios_wmi();
> +		wmi_initialized = 0;
> +	}
> +
> +	if (smm_initialized) {
> +		exit_dell_smbios_smm();
> +		smm_initialized = 0;
> +	}
> +
>  	mutex_lock(&smbios_mutex);
>  	if (platform_device) {
>  		if (da_tokens)

