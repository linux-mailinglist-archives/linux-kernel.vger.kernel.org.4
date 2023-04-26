Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527C6EF822
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbjDZQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbjDZQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B84EFA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682525223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBxS5oLtXxq0CeAGehuC7iIyOGBaLrdAmXmeEYKkpSs=;
        b=RflfbHA7N0BBcsAHr0/STSJJGOmr7zKWVL9EVc07B4y2j55fQWuxrOFWbjQ5TjYFdkGJ1+
        M9U+dY5PraMJNX1jjFMb1nlBXq74CKQl1kw8jLQQ3f5+zueSu6dC76szdeGhIrHDcuBimn
        LgNCU5gPSBxXtRN1KYr6tsutLtz1uVk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-Tr14hLAmMY6nrwky4bvbuQ-1; Wed, 26 Apr 2023 12:06:53 -0400
X-MC-Unique: Tr14hLAmMY6nrwky4bvbuQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5083db60747so7857966a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525207; x=1685117207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBxS5oLtXxq0CeAGehuC7iIyOGBaLrdAmXmeEYKkpSs=;
        b=M63bGWg6nP+ZpvVARiDtUCKB1SOLN3uWnW24d0CLl4T/Va/it71GABIeTWHCzlqlPy
         XQTHBHcHMGkoP1/c0BVDI0ldLJ6AKtlMjWtbBmbj7NcbFlgY5ZiBS51tRX9ly4l/c3PC
         ij8zbGW32ZaIv7jSytaO561hI3MYsQz1uyrvGvJahnsuDLAGTT+v62381V00M3dy45qE
         7KyChLR15XijcpGOmuilCZZKZUjZm1yg0/i87g1YfZHNFkmJ7p5UCr9j5/kHubGYSZDg
         jPdqgWwI2ylu14JIk1WNLpuqIrwefI8aPFV2t5iJxC1lSGZnrairGx1Vx5rnHSU1hRrO
         g/hw==
X-Gm-Message-State: AAQBX9fdIRQynLIASk1jGUaYKdxD9EgEHuflm+xDOi0qXHXboG7yQcBF
        BNmYmw+gkqxHSWtyp5aDHJB73smijljxjpD0cBQ13sBq+aHKgD3cy3INtm00uIvLX4esEaXQomc
        Ygm9PwavE0luW3dtcZs6YOwsUTLd1FKod
X-Received: by 2002:a17:907:6025:b0:94d:57d2:7632 with SMTP id fs37-20020a170907602500b0094d57d27632mr17190252ejc.31.1682525207248;
        Wed, 26 Apr 2023 09:06:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350amP4Ezzr+F4HE1L30mCr0f6LWuyaO9wI823Mi5mAH9xd7WTR+3XoX0LqcDh/jViYBw3gV3Hg==
X-Received: by 2002:a17:907:6025:b0:94d:57d2:7632 with SMTP id fs37-20020a170907602500b0094d57d27632mr17190235ejc.31.1682525206891;
        Wed, 26 Apr 2023 09:06:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709065ad300b0095381e27d13sm8234884ejs.184.2023.04.26.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 09:06:45 -0700 (PDT)
Message-ID: <7a3a2c7b-5302-6c56-270c-69c811368118@redhat.com>
Date:   Wed, 26 Apr 2023 18:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] platform/x86: hp-wmi: Add HP WMI camera switch
Content-Language: en-US, nl
To:     Jonathan Singer <jes965@nyu.edu>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20230426152139.1692-1-jes965@nyu.edu>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230426152139.1692-1-jes965@nyu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 4/26/23 17:21, Jonathan Singer wrote:
> Previously, when the camera toggle switch was hit, the hp-wmi driver
> would report an invalid event code. By adding a case for that in the
> event handling switch statement we can eliminate that error code and
> enable a framework for potential further kernel handling of that key.
> This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
> would likely work for any HP laptop with a camera toggle button. Now
> we emit an SW_CAMERA_LENS_COVER event, on a device that gets created
> on the first such event so as to not report incorrectly the state of
> the camera shutter before we can know its state.
> 
> Signed-off-by: Jonathan Singer <jes965@nyu.edu>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 50 ++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 873f59c3e280..a7fb33ac49b8 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
>  	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
>  	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>  	HPWMI_SANITIZATION_MODE		= 0x17,
> +	HPWMI_CAMERA_TOGGLE		= 0x1A,
>  	HPWMI_OMEN_KEY			= 0x1D,
>  	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>  };
> @@ -228,6 +229,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>  };
>  
>  static struct input_dev *hp_wmi_input_dev;
> +static struct input_dev *camera_shutter_input_dev;
>  static struct platform_device *hp_wmi_platform_dev;
>  static struct platform_profile_handler platform_profile_handler;
>  static bool platform_profile_support;
> @@ -739,6 +741,36 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static int camera_shutter_input_setup(void)
> +{
> +	int err;
> +
> +	camera_shutter_input_dev = input_allocate_device();
> +	if (!camera_shutter_input_dev)
> +		return -ENOMEM;
> +
> +	camera_shutter_input_dev->name = "HP WMI camera shutter";
> +	camera_shutter_input_dev->phys = "wmi/input1";
> +	camera_shutter_input_dev->id.bustype = BUS_HOST;
> +
> +	__set_bit(EV_SW, camera_shutter_input_dev->evbit);
> +	__set_bit(SW_CAMERA_LENS_COVER, camera_shutter_input_dev->swbit);
> +
> +	/* Set initial hardware state */
> +	input_sync(camera_shutter_input_dev);

This initial sync is only necessary if you have actually
read + set an initial state, which is not happening here,
so please drop this.

The caller of camera_shutter_input_setup() will set
a state + call input_sync() immediately afterwards anyways,
so there is no need to set an initial state.

Otherwise this looks good to me, thank you for working on this.

Regards,

Hans


> +
> +	err = input_register_device(camera_shutter_input_dev);
> +	if (err)
> +		goto err_free_dev;
> +
> +	return 0;
> +
> + err_free_dev:
> +	input_free_device(camera_shutter_input_dev);
> +	camera_shutter_input_dev = NULL;
> +	return err;
> +}
> +
>  static DEVICE_ATTR_RO(display);
>  static DEVICE_ATTR_RO(hddtemp);
>  static DEVICE_ATTR_RW(als);
> @@ -866,6 +898,20 @@ static void hp_wmi_notify(u32 value, void *context)
>  		break;
>  	case HPWMI_SANITIZATION_MODE:
>  		break;
> +	case HPWMI_CAMERA_TOGGLE:
> +		if (!camera_shutter_input_dev)
> +			if (camera_shutter_input_setup()) {
> +				pr_info("Failed to setup camera shutter input device\n");
> +				break;
> +			}
> +		if (event_data == 0xff)
> +			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 1);
> +		else if (event_data == 0xfe)
> +			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 0);
> +		else
> +			pr_info("Unknown camera shutter state - 0x%x\n", event_data);
> +		input_sync(camera_shutter_input_dev);
> +		break;
>  	case HPWMI_SMART_EXPERIENCE_APP:
>  		break;
>  	default:
> @@ -1564,9 +1610,13 @@ static void __exit hp_wmi_exit(void)
>  	if (wmi_has_guid(HPWMI_EVENT_GUID))
>  		hp_wmi_input_destroy();
>  
> +	if (camera_shutter_input_dev)
> +		input_unregister_device(camera_shutter_input_dev);
> +
>  	if (hp_wmi_platform_dev) {
>  		platform_device_unregister(hp_wmi_platform_dev);
>  		platform_driver_unregister(&hp_wmi_driver);
>  	}
> +
>  }
>  module_exit(hp_wmi_exit);

