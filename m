Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9059C6F0398
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbjD0JpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbjD0Jom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7640F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682588634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6JNrboTICkCA0BY79Z1IaELuWkwaAi5ABacmsTvXwY=;
        b=YvqW2bfVtZpbkoHMq7Gd+uJwKudnChxYk6mRo85mzeDiuQg8Mr9BYrvPBYFN4AyQSTRB18
        EH3V9kF4+PWmD/ly1RvJkU9k5M048dbi0OF7McK0NFXGwCAt3E6M+M/4ZTGPK9+G2AA1Xn
        oPtYtNmB0DHUeWZLXHnxZgzh8agqPDs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-2r2EDhgfPeOThm2zoozL-Q-1; Thu, 27 Apr 2023 05:43:52 -0400
X-MC-Unique: 2r2EDhgfPeOThm2zoozL-Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-95836419a73so703230666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682588631; x=1685180631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6JNrboTICkCA0BY79Z1IaELuWkwaAi5ABacmsTvXwY=;
        b=T8w0kD+aM3WLT9TKOKkX5IGUSB7g/uVQ0TTG/ngC53kT8mUbmvIfOLYSw54SjLWbba
         gLGpFvDnNIKDFZ5eXMrsOVGNmV/DAVbcxJMFWZPX8oTYBb+EHg9YU11xac53YvO2hTvB
         HrX/CZm0nAJp797MpU3IXNFf/m+W+qMkILaJWvxnZjzpsCheh1aAF6Z0fO+HGUMoaWj/
         rkwEsVHDwdNgrFSxp7Hq0qGRm8xQNl8ymv3aUr0jxoh6dd9BHIOpTMxD3iBmAoE8ICTK
         sGArflt8RXVdmYvjlZ/iE//b9vYxci2Kh4/GnkBndeus1I68Wqw8fBSadMVOxrNk6uKt
         9nHQ==
X-Gm-Message-State: AC+VfDw8LL39u5hhArBe0J9DRuhxt7v6LRG8UzgEl+bAPKnr0TFEIoSL
        AaGhBJ/P3bDqPBkbdRhWTAqtZXLpdnDXUVia0UnNQ53p0hfzhX0QUR3Jzgn4rhOiU/ENTz2F9Y5
        83XX5ch9cPrwhHbN7xBWvCIcT
X-Received: by 2002:a17:907:3e9f:b0:953:7e25:2156 with SMTP id hs31-20020a1709073e9f00b009537e252156mr1130337ejc.51.1682588631505;
        Thu, 27 Apr 2023 02:43:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43HHGtLslcXYwrKnh8zTeDWIfmsPLEiefCtU+a6HKi1x2REffqexk8ukXXfxHoYfi2/kUjCQ==
X-Received: by 2002:a17:907:3e9f:b0:953:7e25:2156 with SMTP id hs31-20020a1709073e9f00b009537e252156mr1130320ejc.51.1682588631160;
        Thu, 27 Apr 2023 02:43:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id md23-20020a170906ae9700b0094fa846be48sm9308908ejb.132.2023.04.27.02.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 02:43:50 -0700 (PDT)
Message-ID: <339c6ba5-6d60-8271-1b5d-6c4165801187@redhat.com>
Date:   Thu, 27 Apr 2023 11:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v2 1/2] platform/x86: wmi: Allow retrieving the number of
 WMI object instances
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230426212848.108562-1-W_Armin@gmx.de>
 <20230426212848.108562-2-W_Armin@gmx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230426212848.108562-2-W_Armin@gmx.de>
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

Hi Armin,

Thank you for your work on this.

On 4/26/23 23:28, Armin Wolf wrote:
> Currently, the WMI driver core knows how many instances of a given
> WMI object exist, but WMI drivers cannot access this information.
> At the same time, some current and upcoming WMI drivers want to
> have access to this information. Add wmi_instance_count() and
> wmidev_instance_count() to allow WMI drivers to get the number of
> WMI object instances.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 40 ++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h       |  2 ++
>  include/linux/wmi.h        |  2 ++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index c226dd4163a1..7c1a904dec5f 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -263,6 +263,46 @@ int set_required_buffer_size(struct wmi_device *wdev, u64 length)
>  }
>  EXPORT_SYMBOL_GPL(set_required_buffer_size);
> 
> +/**
> + * wmi_instance_count - Get number of WMI object instances
> + * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
> + * @instance_count: variable to hold the instance count
> + *
> + * Get the number of WMI object instances.
> + *
> + * Returns: acpi_status signaling success or error.
> + */
> +acpi_status wmi_instance_count(const char *guid_string, u8 *instance_count)
> +{
> +	struct wmi_block *wblock;
> +	acpi_status status;
> +
> +	status = find_guid(guid_string, &wblock);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	*instance_count = wmidev_instance_count(&wblock->dev);
> +
> +	return AE_OK;
> +}
> +EXPORT_SYMBOL_GPL(wmi_instance_count);

I would prefer this to have a normal kernel function prototype
which returns -errno rather then returning an acpi_status. E.g. :

/**
 * wmi_instance_count - Get number of WMI object instances
 * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
 *
 * Get the number of WMI object instances.
 *
 * Returns: The number of WMI object instances, 0 if the GUID is not found.
 */
int wmi_instance_count(const char *guid_string)
{
	struct wmi_block *wblock;
	acpi_status status;

	status = find_guid(guid_string, &wblock);
	if (ACPI_FAILURE(status))
		return 0;

	return wmidev_instance_count(&wblock->dev);
}
EXPORT_SYMBOL_GPL(wmi_instance_count);

This will also allow this to completely replace
the get_instance_count() function in dell-wmi-sysman.

Note I have just gone with always returning 0 here
on error. I guess you could look at the status and
return 0 for not-found and -errno for other errors
but I don't think any callers will care for the difference,
so just always returning 0 seems easier for callers to
deal with.

As always this is just a suggestion, let me know if
you think this is a bad idea.

Regards,

Hans










> +
> +/**
> + * wmidev_instance_count - Get number of WMI object instances
> + * @wdev: A wmi bus device from a driver
> + *
> + * Get the number of WMI object instances.
> + *
> + * Returns: Number of WMI object instances.
> + */
> +u8 wmidev_instance_count(struct wmi_device *wdev)
> +{
> +	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
> +
> +	return wblock->gblock.instance_count;
> +}
> +EXPORT_SYMBOL_GPL(wmidev_instance_count);
> +
>  /**
>   * wmi_evaluate_method - Evaluate a WMI method (deprecated)
>   * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index efff750f326d..ab2a4b23e7a3 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device *);
> 
>  typedef void (*wmi_notify_handler) (u32 value, void *context);
> 
> +acpi_status wmi_instance_count(const char *guid, u8 *instance_count);
> +
>  extern acpi_status wmi_evaluate_method(const char *guid, u8 instance,
>  					u32 method_id,
>  					const struct acpi_buffer *in,
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index c1a3bd4e4838..763bd382cf2d 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>  extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>  					     u8 instance);
> 
> +u8 wmidev_instance_count(struct wmi_device *wdev);
> +
>  extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
> 
>  /**
> --
> 2.30.2
> 

