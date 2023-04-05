Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494406D7F95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbjDEOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjDEOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94EC1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680705191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/rUbS50ET7h3fBMgcFR4AAEoQRwM8+dxclPfZ7iXcw=;
        b=Luqgt1AZRKmitIVkw3dN1wGpPOFK79DNSutw1xWRa5SB9fme40NU03+mmU8xKMu5u+9UfR
        dHfaqYgX2Czp6BHmy7u40qeGik47dN7C9fwL7icFBenju9qW/ZNJsGt+DjjUq3EN8x+rbx
        bnEAmsAa3nDGU0Vkdq7j2FTOo0Aa/pw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-PUO1ebKJPZ2E-imz2fpZ3g-1; Wed, 05 Apr 2023 10:33:10 -0400
X-MC-Unique: PUO1ebKJPZ2E-imz2fpZ3g-1
Received: by mail-ed1-f70.google.com with SMTP id v1-20020a50d581000000b0050291cda08aso16619627edi.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/rUbS50ET7h3fBMgcFR4AAEoQRwM8+dxclPfZ7iXcw=;
        b=q9eQipuKIb9SzDm7mWbA7NStlkKAVn+W/ywuK1C0moKem5iwWU+OOcpZnxKCd2WKBo
         sySfweluZLLYjjqh1TAb6vXLB9LPnJx6g0TP5FIofVNkHZ92/srqQ4aAg2ScirqhPFYq
         udSigovYvocPrRp6QVDeWOFkUfXXdgs3KlxMcx38OJeK4znEeoWIjSy9u+G1TsnhJly1
         SUNA5Wwgsk7GPpxJJO60ZVCtvnK0k8SxnvXXUKWX2gjd2vnG1eg5Y/5OJjxtEwmJlb8f
         NBKfLJwKdLH92todIBoMwiNguQ1Mjx/j+bhz+lhu5nzYfptCqbG911bOOSMfOWQUL1In
         nm4A==
X-Gm-Message-State: AAQBX9cfUgPIMhGKEx09PkDM7gleA0DpA/BG4teqOBsqc9Mcl+yBoau8
        W2Do01n8L61/GSS/1wEJzz7sN1yhcp1lqT7KPVw1oJEfl7tLKb+wiexQgcr1GbQT3a8gsQPmn+g
        XVWKD3XdXBwaDz+zHxtQYBvYL
X-Received: by 2002:a17:907:11c8:b0:878:5372:a34b with SMTP id va8-20020a17090711c800b008785372a34bmr2984725ejb.45.1680705188360;
        Wed, 05 Apr 2023 07:33:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPPE1PAdz6Uu4eOmJlSv2zZtAW310HbeekJVe4Ya9JzuFz9kwB3p8Cid3aTR5/yOHZn3/TvQ==
X-Received: by 2002:a17:907:11c8:b0:878:5372:a34b with SMTP id va8-20020a17090711c800b008785372a34bmr2984709ejb.45.1680705188111;
        Wed, 05 Apr 2023 07:33:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b00882f9130eafsm7317706eju.26.2023.04.05.07.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 07:33:07 -0700 (PDT)
Message-ID: <7ec19101-0288-71e1-cdca-cfe7acbbe0e9@redhat.com>
Date:   Wed, 5 Apr 2023 16:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
To:     Khalil Blaiech <kblaiech@nvidia.com>, markgross@kernel.org,
        vadimp@nvidia.com
Cc:     platform-driver-x86@vger.kernel.org, davthompson@nvidia.com,
        linux-kernel@vger.kernel.org
References: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khalil,

On 4/5/23 15:16, Khalil Blaiech wrote:
> Add a new sysfs to initiate firmware reset in isolation mode.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>

Why are you resending this less then 24 hours after the initial submission ?

Regards,

Hans


> ---
>  drivers/platform/mellanox/mlxbf-bootctl.c | 19 +++++++++++++++++++
>  drivers/platform/mellanox/mlxbf-bootctl.h |  6 ++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 1c7a288b59a5..5e41c270195c 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -244,11 +244,29 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
>  	return buf_len;
>  }
>  
> +static ssize_t fw_reset_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long key;
> +	int err;
> +
> +	err = kstrtoul(buf, 16, &key);
> +	if (err)
> +		return err;
> +
> +	if (mlxbf_bootctl_smc(MLXBF_BOOTCTL_FW_RESET, key) < 0)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(post_reset_wdog);
>  static DEVICE_ATTR_RW(reset_action);
>  static DEVICE_ATTR_RW(second_reset_action);
>  static DEVICE_ATTR_RO(lifecycle_state);
>  static DEVICE_ATTR_RO(secure_boot_fuse_state);
> +static DEVICE_ATTR_WO(fw_reset);
>  
>  static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_post_reset_wdog.attr,
> @@ -256,6 +274,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
>  	&dev_attr_second_reset_action.attr,
>  	&dev_attr_lifecycle_state.attr,
>  	&dev_attr_secure_boot_fuse_state.attr,
> +	&dev_attr_fw_reset.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
> index 148fdb43b435..b48243f60a59 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.h
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.h
> @@ -75,6 +75,12 @@
>  
>  #define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
>  
> +/*
> + * Initiate Firmware Reset via TYU. This might be invoked during the reset
> + * flow in isolation mode.
> + */
> +#define MLXBF_BOOTCTL_FW_RESET  0x8200000D
> +
>  /* SMC function IDs for SiP Service queries */
>  #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
>  #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01

