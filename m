Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227A750B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjGLOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjGLOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4914F10B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689172997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwTNGJ/hdYZ+xK2vGDnfq6wxMTM0TCxvXYqihV24QFU=;
        b=BtLJmt8VbBTOVYGNJ8U+bMgGEKzmpajRB7axZttxWly7IMswuvsccz6rT3I/55TibZSL+I
        A6iIReUnsq4Auybjlf3hwA+Ro5ZQ6j8Lwy7VgIYlFmGNEBAra3FHmo9K8M79ebN3dpX0jB
        F7ouvxK3pZ/pDsLyJmnNT79IRs/6W+Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-wsWX_UvvMlSJx4lDkHjkhQ-1; Wed, 12 Jul 2023 10:43:16 -0400
X-MC-Unique: wsWX_UvvMlSJx4lDkHjkhQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993c2d9e4a0so406922066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689172995; x=1691764995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwTNGJ/hdYZ+xK2vGDnfq6wxMTM0TCxvXYqihV24QFU=;
        b=dnZu74DuNGiET4Y3s8p2bQp82xOl+doKdzceU5Z0nJsr3nhBciI2AbRJbmRRYdpHGp
         ZBfaLKcTeTjQPQsAcSTuj8s09Kx5/M2Tq4FQBYoALa4OpZk1lrF5Z8VOfb0I0CgF3Q+z
         divX1/dUHa9ThhAAopWUFEFJBFPaIZ02wGEGyIoQ03XkQa52/e7QbF0n+RMtwu/0/N6i
         EjtO4M/9jwxK1khZ72Ju5oHxQGwP8eDWdIBX1VBAs21+Ru6U+yoZNvWAQAeov1OaHYZZ
         S2QZrnHT2eGu1IAHCEFVao/45bMDo9Q464zY18spFCWCvcPEZaHnAKuXoe/8ydS7G5aq
         oVOg==
X-Gm-Message-State: ABy/qLaID+5SZrL9+Oly0VBA8mM7HVVqESCCNFVREpC3vshUWHGhvnVc
        x4CWYLboqSic1SBAnXCS+DjEej1iX3b7X6jCMsdxihlxEQQPgR6Axz/2s95/b+wTGQMfZbLrjoq
        qy8HE8I4O7iUFWupksooiCRb/
X-Received: by 2002:a17:906:1099:b0:994:3037:c27 with SMTP id u25-20020a170906109900b0099430370c27mr1567218eju.30.1689172994929;
        Wed, 12 Jul 2023 07:43:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH/EZtl60L1VjcZkRd5rj6HKTcZr+yqIAMrE9EwcYPoXTubTfVk2/6+n1d0Iyx7bDnP23e5SQ==
X-Received: by 2002:a17:906:1099:b0:994:3037:c27 with SMTP id u25-20020a170906109900b0099430370c27mr1567203eju.30.1689172994645;
        Wed, 12 Jul 2023 07:43:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h14-20020a170906110e00b009829dc0f2a0sm2694602eja.111.2023.07.12.07.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:43:13 -0700 (PDT)
Message-ID: <611e5609-3013-7ac7-efd8-af41431aa2be@redhat.com>
Date:   Wed, 12 Jul 2023 16:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/8] platform/x86: asus-wmi: add WMI method to show if
 egpu connected
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630053552.976579-1-luke@ljones.dev>
 <20230630053552.976579-5-luke@ljones.dev>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230630053552.976579-5-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/23 07:35, Luke D. Jones wrote:
> Exposes the WMI method which tells if the eGPU is properly connected
> on the devices that support it.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++++++++-
>  drivers/platform/x86/asus-wmi.c               | 21 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  4 +++-
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index eb29e3023c7b..878daf7c2036 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -107,4 +107,13 @@ Description:
>  		Get the current charging mode being used:
>  			* 1 - Barrel connected charger,
>  			* 2 - USB-C charging
> -			* 3 - Both connected, barrel used for charging
> \ No newline at end of file
> +			* 3 - Both connected, barrel used for charging
> +
> +What:		/sys/devices/platform/<platform>/egpu_connected
> +Date:		Jun 2023
> +KernelVersion:	6.5
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Show if the egpu (XG Mobile) is correctly connected:
> +			* 0 - False,
> +			* 1 - True
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index fb27218e51cf..0c8a4a46b121 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -243,6 +243,7 @@ struct asus_wmi {
>  
>  	bool charge_mode_available;
>  	bool egpu_enable_available;
> +	bool egpu_connect_available;
>  	bool dgpu_disable_available;
>  	bool gpu_mux_mode_available;
>  
> @@ -709,6 +710,22 @@ static ssize_t egpu_enable_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(egpu_enable);
>  
> +/* Is eGPU connected? *********************************************************/
> +static ssize_t egpu_connected_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result;
> +
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
> +	if (result < 0)
> +		return result;
> +
> +	return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static DEVICE_ATTR_RO(egpu_connected);
> +
>  /* gpu mux switch *************************************************************/
>  static ssize_t gpu_mux_mode_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
> @@ -3645,6 +3662,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_charge_mode.attr,
>  	&dev_attr_egpu_enable.attr,
> +	&dev_attr_egpu_connected.attr,
>  	&dev_attr_dgpu_disable.attr,
>  	&dev_attr_gpu_mux_mode.attr,
>  	&dev_attr_lid_resume.attr,
> @@ -3677,6 +3695,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->charge_mode_available;
>  	else if (attr == &dev_attr_egpu_enable.attr)
>  		ok = asus->egpu_enable_available;
> +	else if (attr == &dev_attr_egpu_connected.attr)
> +		ok = asus->egpu_connect_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
>  	else if (attr == &dev_attr_gpu_mux_mode.attr)
> @@ -3943,6 +3963,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  
>  	asus->charge_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CHARGE_MODE);
>  	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
> +	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
>  	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>  	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>  	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 329efc086993..2034648f8cdf 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -100,7 +100,9 @@
>  /* Charging mode - 1=Barrel, 2=USB */
>  #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
>  
> -/* dgpu on/off */
> +/* epu is connected? 1 == true */
> +#define ASUS_WMI_DEVID_EGPU_CONNECTED	0x00090018
> +/* egpu on/off */
>  #define ASUS_WMI_DEVID_EGPU		0x00090019
>  
>  /* dgpu on/off */

