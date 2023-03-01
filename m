Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936A6A6C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCAMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA0166C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677672911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu+EPKiqWaJlFT+E8yHfU9ZpiuzC1YRS6XYz2PiEsE8=;
        b=NI1cnLbWyuVfOIcj1X7UWnVfc6GAbDhNmqciq68dphk1dOj73n4uZOAwm8yowTtAxybsaE
        nd6VtwmGcW1xfUHFXoT2SOxoZ1xj1NE3VZ4+sZ9vgCCPPrxNuHRWWfRk91UOn88hpo/JJv
        bXEwZh+ZkRa2TjYrkUso6qTJsKYKcbM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-esgU-nxEP06o9O7GZ_mK4Q-1; Wed, 01 Mar 2023 07:15:07 -0500
X-MC-Unique: esgU-nxEP06o9O7GZ_mK4Q-1
Received: by mail-ed1-f70.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so18944596edh.14
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu+EPKiqWaJlFT+E8yHfU9ZpiuzC1YRS6XYz2PiEsE8=;
        b=gRJqkFsP+yvrAsCTsyACNOBsCfEYgDwsz/VwNxtrCRIL+WWslnLC7cZwZMVP4+j76y
         6eIjm1gRBTCZ5ANSQl2S7P8RILZ8ihFePxcBOIWvRBxAkqLBAG9Dc0UoNs8PRjem+BF3
         WP2umHjYrdMyKFnjGB+NkmTj6j6WgDv+WipibsxqPD26RVjOT4Qihcd9JWIjMtpOc5Pj
         CgDmf5KpdoDZ4m+nUmVqtkLb28T2vMiTIKJshQjTZDzLj3Me126LowRFco1l5TSG8tSj
         gj7y90uZi8d6FxdUvPe30cqwQWEXULXJvzmd4imVPpfCffl35mCzZtm73hK/4v0wb86S
         gWYw==
X-Gm-Message-State: AO0yUKXr8xOyocp+2veLD1OLNNrKydMKM2KgxYbrAn0TVn24NfwF4IGq
        3I7ODaG9OwVFzG7o4xK7nTPJSfMb1BDTMRLuImJWNI/dH/GtstWXkBANSGPyNTxBR1SzPUU42Gf
        GjHuE2O6UNlFiJUWnzJqM7CreJ+1HKw==
X-Received: by 2002:a17:907:38e:b0:88d:3c85:4ccf with SMTP id ss14-20020a170907038e00b0088d3c854ccfmr5340027ejb.25.1677672906130;
        Wed, 01 Mar 2023 04:15:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9OTmWktppMquATQgyqnsl8b3YgTg0F/aRqE8fQ+5iI4ZqkI5gqr4VvdiSzTD1tE+BDH+TxbA==
X-Received: by 2002:a17:907:38e:b0:88d:3c85:4ccf with SMTP id ss14-20020a170907038e00b0088d3c854ccfmr5340018ejb.25.1677672905806;
        Wed, 01 Mar 2023 04:15:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709061ecf00b00882f9130eafsm5717500ejj.26.2023.03.01.04.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:15:05 -0800 (PST)
Message-ID: <15d7b77d-c66e-6e31-e930-7595cdabcd11@redhat.com>
Date:   Wed, 1 Mar 2023 13:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] platform/x86: dell-ddv: Fix cache invalidation on
 resume
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230218115318.20662-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230218115318.20662-1-W_Armin@gmx.de>
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

Hi,

On 2/18/23 12:53, Armin Wolf wrote:
> If one or both sensor buffers could not be initialized, either
> due to missing hardware support or due to some error during probing,
> the resume handler will encounter undefined behaviour when
> attempting to lock buffers then protected by an uninitialized or
> destroyed mutex.
> Fix this by introducing a "active" flag which is set during probe,
> and only invalidate buffers which where flaged as "active".
> 
> Tested on a Dell Inspiron 3505.
> 
> Fixes: 3b7eeff93d29 ("platform/x86: dell-ddv: Add hwmon support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - move checking of the "active" flag inside
>   dell_wmi_ddv_hwmon_cache_invalidate()

Thanks, I've applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll rebase that branch once 6.3-rc1 is out and then push the rebased
patch to the fixes branch and include it in my next 6.3 fixes pull-req
to Linus.

Regards,

Hans




> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index d547c9d09725..eff4e9649faf 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -96,6 +96,7 @@ struct combined_chip_info {
>  };
> 
>  struct dell_wmi_ddv_sensors {
> +	bool active;
>  	struct mutex lock;	/* protect caching */
>  	unsigned long timestamp;
>  	union acpi_object *obj;
> @@ -520,6 +521,9 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct device *dev
> 
>  static void dell_wmi_ddv_hwmon_cache_invalidate(struct dell_wmi_ddv_sensors *sensors)
>  {
> +	if (!sensors->active)
> +		return;
> +
>  	mutex_lock(&sensors->lock);
>  	kfree(sensors->obj);
>  	sensors->obj = NULL;
> @@ -530,6 +534,7 @@ static void dell_wmi_ddv_hwmon_cache_destroy(void *data)
>  {
>  	struct dell_wmi_ddv_sensors *sensors = data;
> 
> +	sensors->active = false;
>  	mutex_destroy(&sensors->lock);
>  	kfree(sensors->obj);
>  }
> @@ -549,6 +554,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *w
>  		return ERR_PTR(ret);
> 
>  	mutex_init(&sensors->lock);
> +	sensors->active = true;
> 
>  	ret = devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_destroy, sensors);
>  	if (ret < 0)
> @@ -852,7 +858,7 @@ static int dell_wmi_ddv_resume(struct device *dev)
>  {
>  	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> 
> -	/* Force re-reading of all sensors */
> +	/* Force re-reading of all active sensors */
>  	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
>  	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
> 
> --
> 2.30.2
> 

