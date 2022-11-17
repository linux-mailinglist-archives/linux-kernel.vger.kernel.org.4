Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4062DCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiKQNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E55100A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668692018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hL/CkDwZ5PSSXNx6AH8Ol5aF9aNMQrd0lYSEYATA1qM=;
        b=SS3HlNfwCpVio4jgvLrqix9J6dfNreIeb1ZnAXafY/cZbC7YNvf9gIA14ElsuZbgQp05GY
        aDdooYhipMHpMociBtMVq7Y9PP9dcuf1cTDqJ8nMQQggRmy1wjTI8jaKsROIz4UR11GI9s
        DAqD2qpyKEjUk8YE9h+OBL15sesCGd8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-NCII16pnNdG4ttHNgj3V-g-1; Thu, 17 Nov 2022 08:33:37 -0500
X-MC-Unique: NCII16pnNdG4ttHNgj3V-g-1
Received: by mail-ej1-f70.google.com with SMTP id sh31-20020a1709076e9f00b007ae32b7eb51so1107674ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL/CkDwZ5PSSXNx6AH8Ol5aF9aNMQrd0lYSEYATA1qM=;
        b=iI/Yk87FMfeq9bGKLZk3uFNIyYSIuR4feAj5fEBUuQWPKi5IwI3eaXsdTJc8UYUEVD
         UhgTWvRRGs8uQrnqPeOXNmeO9OnDyp3p8dtwznMwhWAxsqD0cyKYifF9r8O8yUsFmpfi
         j4kVWMs0psNzlm6X7y2DIt4nHOmFBC6wcV4B3+CC9iTsuHyimnnrB2B13ZxF7ORPhJIb
         ua0eEZqay86OVUL0qu5nFb9NEieTHUYJTM+/eBXHb84CvfFT+zeIOo7v57wzv4WeQBsK
         wZVw1OIvg70phxCv8U5Yk6/anGddSHhxY4S1mfaDDmEwYtQElybWgtDjYdHB2CuCC4MA
         T18A==
X-Gm-Message-State: ANoB5pkaso8DRXW4DKhPNj1sz1c58sv9L4Wo8R9X159axHyrDZSWBKBm
        BmLRYDQgUPY6L76j/5IZpdqfYhRDV755VwFXBUnQEffqc8TSoIAvb8T7MI8oHecyEOAhD34Vl2r
        V8tXsRhcqhSsLsqfXphGXX9wj
X-Received: by 2002:a05:6402:3719:b0:461:4f34:d8f4 with SMTP id ek25-20020a056402371900b004614f34d8f4mr2246349edb.144.1668692016390;
        Thu, 17 Nov 2022 05:33:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sKRk3/86Tcy37XD0YlRzFqUBS6qSiNc9p3JAvWavh0/6bd4NkP7VcJbT4ivuY7CMGPSQC7g==
X-Received: by 2002:a05:6402:3719:b0:461:4f34:d8f4 with SMTP id ek25-20020a056402371900b004614f34d8f4mr2246326edb.144.1668692016139;
        Thu, 17 Nov 2022 05:33:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n22-20020aa7c696000000b00457c85bd890sm543260edq.55.2022.11.17.05.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:33:35 -0800 (PST)
Message-ID: <3995ade6-385c-45cd-3ff4-052835337546@redhat.com>
Date:   Thu, 17 Nov 2022 14:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 4/9] platform/x86/intel/sdsi: Add meter certificate
 support
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-5-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101191023.4150315-5-david.e.box@linux.intel.com>
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

On 11/1/22 20:10, David E. Box wrote:
> Add support for reading the meter certificate from Intel On Demand
> hardware.  The meter certificate [1] is used to access the utilization
> metrics of enabled features in support of the Intel On Demand consumption
> model. Similar to the state certificate, the meter certificate is read by
> mailbox command.
> 
> [1] https://github.com/intel-sandbox/debox1.intel_sdsi/blob/gnr-review/meter-certificate.rst
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Besides Andy's remarks I also have 1 remark myself, see below.

> ---
>  .../ABI/testing/sysfs-driver-intel_sdsi       | 10 ++++
>  drivers/platform/x86/intel/sdsi.c             | 52 +++++++++++++++----
>  2 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> index 9d77f30d9b9a..f8afed127107 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> +++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> @@ -69,6 +69,16 @@ Description:
>  		the CPU configuration is updated. A cold reboot is required to
>  		fully activate the feature. Mailbox command.
>  
> +What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/meter_certificate
> +Date:		Nov 2022
> +KernelVersion:	6.2
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		(RO) Used to read back the current meter certificate for the CPU
> +		from Intel On Demand hardware. The meter certificate contains
> +		utilization metrics of On Demand enabled features. Mailbox
> +		command.
> +
>  What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/state_certificate
>  Date:		Feb 2022
>  KernelVersion:	5.18
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index ab1f65919fc5..1dee10822df7 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -42,6 +42,7 @@
>  
>  #define SDSI_ENABLED_FEATURES_OFFSET	16
>  #define SDSI_FEATURE_SDSI		BIT(3)
> +#define SDSI_FEATURE_METERING		BIT(26)
>  
>  #define SDSI_SOCKET_ID_OFFSET		64
>  #define SDSI_SOCKET_ID			GENMASK(3, 0)
> @@ -80,9 +81,10 @@
>  #define SDSI_GUID_V2			0xF210D9EF
>  
>  enum sdsi_command {
> -	SDSI_CMD_PROVISION_AKC		= 0x04,
> -	SDSI_CMD_PROVISION_CAP		= 0x08,
> -	SDSI_CMD_READ_STATE		= 0x10,
> +	SDSI_CMD_PROVISION_AKC		= 0x0004,
> +	SDSI_CMD_PROVISION_CAP		= 0x0008,
> +	SDSI_CMD_READ_STATE		= 0x0010,
> +	SDSI_CMD_READ_METER		= 0x0014,
>  };
>  
>  struct sdsi_mbox_info {
> @@ -398,13 +400,10 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
>  }
>  static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
>  
> -static long state_certificate_read(struct file *filp, struct kobject *kobj,
> -				   struct bin_attribute *attr, char *buf, loff_t off,
> -				   size_t count)
> +static ssize_t
> +certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
> +		 size_t count)
>  {
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct sdsi_priv *priv = dev_get_drvdata(dev);
> -	u64 command = SDSI_CMD_READ_STATE;
>  	struct sdsi_mbox_info info;
>  	size_t size;
>  	int ret;
> @@ -441,8 +440,31 @@ static long state_certificate_read(struct file *filp, struct kobject *kobj,
>  
>  	return size;
>  }
> +
> +static ssize_t
> +state_certificate_read(struct file *filp, struct kobject *kobj,
> +		       struct bin_attribute *attr, char *buf, loff_t off,
> +		       size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> +
> +	return certificate_read(SDSI_CMD_READ_STATE, priv, buf, off, count);
> +}
>  static BIN_ATTR(state_certificate, 0400, state_certificate_read, NULL, SDSI_SIZE_READ_MSG);
>  
> +static ssize_t
> +meter_certificate_read(struct file *filp, struct kobject *kobj,
> +		       struct bin_attribute *attr, char *buf, loff_t off,
> +		       size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> +
> +	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
> +}
> +static BIN_ATTR(meter_certificate, 0400, meter_certificate_read, NULL, SDSI_SIZE_READ_MSG);
> +
>  static ssize_t registers_read(struct file *filp, struct kobject *kobj,
>  			      struct bin_attribute *attr, char *buf, loff_t off,
>  			      size_t count)
> @@ -472,6 +494,7 @@ static BIN_ATTR(registers, 0400, registers_read, NULL, SDSI_SIZE_REGS);
>  static struct bin_attribute *sdsi_bin_attrs[] = {
>  	&bin_attr_registers,
>  	&bin_attr_state_certificate,
> +	&bin_attr_meter_certificate,
>  	&bin_attr_provision_akc,
>  	&bin_attr_provision_cap,
>  	NULL
> @@ -491,7 +514,16 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
>  	if (!(priv->features & SDSI_FEATURE_SDSI))
>  		return 0;
>  
> -	return attr->attr.mode;
> +	if (attr == &bin_attr_state_certificate ||
> +	    attr == &bin_attr_provision_akc ||
> +	    attr == &bin_attr_provision_cap)
> +		return attr->attr.mode;

I would prefer for you to just drop this and then change:

> +
> +	if (attr == &bin_attr_meter_certificate &&
> +	    !!(priv->features & SDSI_FEATURE_METERING))
> +		return attr->attr.mode;

to:

	if (attr == &bin_attr_meter_certificate)
		return (priv->features & SDSI_FEATURE_METERING) ?
				attr->attr.mode : 0;

And then keep:

	return attr->attr.mode;

at the end of this function, because now you are hiding all
new attributes by default and then you have to add any new
attributes to the if above, leading to an ever growing lists
of attr to check in that if, so just having:

	return attr->attr.mode;

As default for any non-matches attr would be much better IMHO.

Regards,

Hans





> +
> +	return 0;
>  }
>  
>  static ssize_t guid_show(struct device *dev, struct device_attribute *attr, char *buf)

