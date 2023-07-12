Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF0750B64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGLOs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjGLOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5451993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689173252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIuzB3x3+itiPANCeMD8GY8b1oc0WBnANtFmR+T6S8U=;
        b=Tr907ov8sGLmcgLIIO+t+H2WLZnwoQuiMlGpvlk+mc01Vja1yPzqq9vr7mv8CdP091k+EI
        D0Nef3ko5ZWZCWv0bTN/QPwFRch8EdeaLCHlJ+jg5YY5KRvuEpfqxnALDuh1D1Ig/sTfTI
        fVqEi4yZZeM7SIuujIl1NU/nUEooIOw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-rpPW7lqaOXSr_HaXfmjZdQ-1; Wed, 12 Jul 2023 10:47:31 -0400
X-MC-Unique: rpPW7lqaOXSr_HaXfmjZdQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d5006993so352089366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173250; x=1691765250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIuzB3x3+itiPANCeMD8GY8b1oc0WBnANtFmR+T6S8U=;
        b=QqdVoIoN9EZd/8bFfHx9RRGbrm740tn2HngcCaHp9fpECVInPHULJgsQf3qZD7mL0S
         ow3jAZMx/tSUpHrDrOe9LPOtYt4eLhSeZb1fohebGswjq7wjkKCoJmuMgtDIKbmprlkx
         rtu6oJZwwoMcQYTxJ3KnfthcXnaDVFglWFUxjtqzDjk2fQW3aWDSk15zkGzS9jWEqKJG
         ZHCXmVfOPg5p6RsnpmKl92v4WhXyi8+KJxEuctC3JBIuRZOddyNCWRipqk0xq63FbOJA
         6IcNOrjrB9G0GXcPksirMvo0RI7XPofh4Q2+Znzw6PrU/dP5McRMO+qpcLuqHNy7WiCn
         8JRA==
X-Gm-Message-State: ABy/qLZpl/T1Q77+3rNtlZrdXsvj0L55tmdFwUCyQ1iXgJI3G57GPLN+
        hbg34XVaEVjZ6MJe4punxQA42ROnufbStWGYBoNIkSMhzIAc5JS17FySlPLSxevP6WKr7FGVuSk
        Be0aiHq7HXo40Xi1j1kiH9OY0
X-Received: by 2002:a17:906:af65:b0:994:34a2:8724 with SMTP id os5-20020a170906af6500b0099434a28724mr242704ejb.52.1689173250191;
        Wed, 12 Jul 2023 07:47:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGaWvX/O8w27SGpuJdmu612qxbMowaKIYLZTLJgaTMD9S3lDFGlByoIHJEs+K1fptL66r0HIQ==
X-Received: by 2002:a17:906:af65:b0:994:34a2:8724 with SMTP id os5-20020a170906af6500b0099434a28724mr242695ejb.52.1689173249925;
        Wed, 12 Jul 2023 07:47:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m27-20020a1709060d9b00b009932337747esm2643633eji.86.2023.07.12.07.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:47:29 -0700 (PDT)
Message-ID: <7ad305d4-3acb-1447-bdbe-077c83972978@redhat.com>
Date:   Wed, 12 Jul 2023 16:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 6/8] platform/x86: asus-wmi: add safety checks to gpu
 switching
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630053552.976579-1-luke@ljones.dev>
 <20230630053552.976579-7-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230630053552.976579-7-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/23 07:35, Luke D. Jones wrote:
> Add safety checking to dgpu_disable, egpu_enable, gpu_mux_mode.
> 
> These checks prevent users from doing such things as:
> - disabling the dGPU while is muxed to drive the internal screen
> - enabling the eGPU which also disables the dGPU, while muxed to
>   the internal screen
> - switching the MUX to dGPU while the dGPU is disabled
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 50 ++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 821addb284d7..602426a7fb41 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -645,6 +645,18 @@ static ssize_t dgpu_disable_store(struct device *dev,
>  	if (disable > 1)
>  		return -EINVAL;
>  
> +	if (asus->gpu_mux_mode_available) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> +		if (result < 0)
> +			/* An error here may signal greater failure of GPU handling */
> +			return result;
> +		if (!result && disable) {
> +			err = -ENODEV;
> +			pr_warn("Can not disable dGPU when the MUX is in dGPU mode: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &result);
>  	if (err) {
>  		pr_warn("Failed to set dgpu disable: %d\n", err);
> @@ -693,7 +705,7 @@ static ssize_t egpu_enable_store(struct device *dev,
>  	if (enable > 1)
>  		return -EINVAL;
>  
> -	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
>  	if (err < 0)
>  		return err;
>  	if (err < 1) {

This seems like a stray and undesired change. I'll drop this err -> result change
when merging this.

Otherwise looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> @@ -702,6 +714,18 @@ static ssize_t egpu_enable_store(struct device *dev,
>  		return err;
>  	}
>  
> +	if (asus->gpu_mux_mode_available) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> +		if (result < 0)
> +			/* An error here may signal greater failure of GPU handling */
> +			return result;
> +		if (!result && enable) {
> +			err = -ENODEV;
> +			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>  	if (err) {
>  		pr_warn("Failed to set egpu disable: %d\n", err);
> @@ -764,6 +788,30 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
>  	if (optimus > 1)
>  		return -EINVAL;
>  
> +	if (asus->dgpu_disable_available) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_DGPU);
> +		if (result < 0)
> +			/* An error here may signal greater failure of GPU handling */
> +			return result;
> +		if (result && !optimus) {
> +			err = -ENODEV;
> +			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	if (asus->egpu_enable_available) {
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU);
> +		if (result < 0)
> +			/* An error here may signal greater failure of GPU handling */
> +			return result;
> +		if (result && !optimus) {
> +			err = -ENODEV;
> +			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
>  	if (err) {
>  		dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);

