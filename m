Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751136F2ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 23:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjD3VCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 17:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD3VCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 17:02:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0B11B;
        Sun, 30 Apr 2023 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682888503; i=w_armin@gmx.de;
        bh=PEGII6AuxuD7VYFwcTJIQfyjZIFa7pZZJovsYWSdjJ8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cPG90ClOWdrrUD8AegU1JSMS3L3nNl9vH/YxdxmHnqvpHmsJenNL6oJiFW5NH5CIf
         WoVu8DF+EX0vsfkI13mGcnfe2GojekqlIz8vVmcmBnLNTMDvUSQqfx0txP+CSHKQjB
         E5L5uIgJXMUybNeNofJdcAhJeYCiOQ3u6XoNdDY5eiSJBQz3Kab4WLvnmpTKBdgpi4
         nnMqa2mo5ZBQ1bmL2gzl0CG5f1tlBXlWQkHKFGbMOZM+d/vXAoO4hXuKLeNxP4hehk
         BfMI1mKUlVoZOyGi0GVKQONHJtgUDGlnaCswsTGkAAOdQieasDT9mrovfGS904NR8o
         PgF9DAMijzXlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1peYnh37Hr-00O1PH; Sun, 30
 Apr 2023 23:01:42 +0200
Subject: Re: [PATCH 1/2] platform/x86: wmi: Allow retrieving the number of WMI
 object instances
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230430203153.5587-1-W_Armin@gmx.de>
 <20230430203153.5587-2-W_Armin@gmx.de>
 <756215f5-d99c-b172-13f6-1a15e026bf65@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <3bfa4a8c-1260-3fc0-9f83-2958467ca596@gmx.de>
Date:   Sun, 30 Apr 2023 23:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <756215f5-d99c-b172-13f6-1a15e026bf65@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:Oko3MpIp1yJChBT9DzLAUVTCYP5NEVrDj1u2I9ThGjP9YlrvHLI
 8XVK75lzSKGfFVUIe5nbbXbaAAABIDAxINq9xLlIpj0RnPJqCAogoqsMDWGg1bVNee07txR
 MMf1p8SWvrNreeUbHsareVGHGhUduiH/MpaZRYSx6R0CZ9sWlqrx2A1vQulSfoWL9k/44dh
 /NEgVxTpTcmhmmSEWJHWg==
UI-OutboundReport: notjunk:1;M01:P0:21QVCb4GZzU=;nTVL+aiMmmsjssZpXH0UtOA8Hw+
 OJ31wP395vfTIxhLK/SxwpmvAVIBTEo572hTS/huXk/7usk7cMURgcWoMQ1zioRIV1gKMHV89
 olz4K714YkkQkII4UTgPgcajNFlsXHuVCqR/+t4TOcxHgNFh+/w3M4CHdfvXUTyLRy8U+3BbD
 PCpdyh97gYjfyEzulXosg4rTMwGJ6OnDI2ESrGreGnmGXo9gxZPm5VdOC5nCAxQ9S+rG1BEK/
 ej74uEVClGcPXVfeGRKgup1Xvfx3sikFS26ZbwkMQ6QzBEbjEtY8TxgNU/ROm4Ph35HVUQ/nF
 E6+ymM0I6dsfm7UwrECM/bSHZh57b7b9BH/vNy6CbE8l9XljwLtMy3QVGwsxMQeHKgRe0yVHB
 7XMttz9fT6JsWglAHr/AsVHuTgd8PZ+Ks90ljrjOdWf4ndOF0ktautqEuWIkdevrl0qT7+s0P
 VsO++s/fVh8VKOj7mY2qClzd9a8ZITUe6n3APGGI4OIvUrS/p6a+eXIVPu4cJice9jti5eZ9Z
 FKVsgyQUzORjRE71pVRZ0xga2CjkgCkoqH8hG/q2H6h/JULxlrHIya4CMNRvktF/FPKvfm0j4
 L81WvqobA7cFfmaemxktTsS8Egr9ZrVZDFEgs1Ln/37O5Fo44xTXeXb5ltq5s33hoc9GMoVS7
 HmFfarhpLoAVdJ874nV6XjMvCacSWBE/KZimQrpX0MduonDH7S0GRC1Mo4fZH9OcMAuiGskPK
 tAIAkqC+atj4z79RX8UnYO7HlnPSVDeRGmzPHNV4T5waq8CoAYYhLoLq9UwrVz0BMwvCasnoC
 f9/d468DLO8a9Z2zaLL03EtanvY47c3KS2Q4OxXWXezZPIEpaT6EnjDCbS0sOnKzNThRsTf0D
 HPsaOs0PRVIt20y4DkQ5czNZPQSBrM6l4fN/SM8FPdB4ABYxA945hRNiA5gpuXTqcEclEjxAU
 xJ7GIaoSysk+yH1HZMBWHlPKt2o=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.23 um 22:41 schrieb Hans de Goede:

> Hi Armin,
>
> On 4/30/23 22:31, Armin Wolf wrote:
>> Currently, the WMI driver core knows how many instances of a given
>> WMI object exist, but WMI drivers cannot access this information.
>> At the same time, some current and upcoming WMI drivers want to
>> have access to this information. Add wmi_instance_count() and
>> wmidev_instance_count() to allow WMI drivers to get the number of
>> WMI object instances.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thank you for your work on this.
>
>> ---
>>   drivers/platform/x86/wmi.c | 41 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h       |  2 ++
>>   include/linux/wmi.h        |  2 ++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index c226dd4163a1..5b95d7aa5c2f 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -263,6 +263,47 @@ int set_required_buffer_size(struct wmi_device *wdev, u64 length)
>>   }
>>   EXPORT_SYMBOL_GPL(set_required_buffer_size);
>>
>> +/**
>> + * wmi_instance_count - Get number of WMI object instances
>> + * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>> + *
>> + * Get the number of WMI object instances.
>> + *
>> + * Returns: Number of WMI object instances or negative error code.
>> + */
>> +int wmi_instance_count(const char *guid_string)
>> +{
>> +	struct wmi_block *wblock;
>> +	acpi_status status;
>> +
>> +	status = find_guid(guid_string, &wblock);
>> +	if (ACPI_FAILURE(status)) {
>> +		if (status == AE_BAD_PARAMETER)
>> +			return -EINVAL;
>> +
>> +		return -ENODEV;
> Maybe just return 0 here ?
>
> The GUID not existing at all does not seem like
> an error to me, but rather a case of there
> being 0 instances.
>
> This will also allow patch 2/2 to completely
> drop the get_instance_count() function and
> replace its callers with direct calls to
> wmi_instance_count() as the code is known
> to always pass a valid GUID, so it won't hit
> the -EINVAL path.
>
> Regards,
>
> Hans
>
Hi,

i would prefer returning -ENODEV instead of 0, so WMI drivers can
distinguish between "not found" and "zero instances". Also i do not
think that relying on the parameter of get_instance_count() always
being a valid GUID is a good idea, just in case wmi_instance_count()
is later modified to be able to encounter runtime errors.

Armin Wolf

>
>> +	}
>> +
>> +	return wmidev_instance_count(&wblock->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(wmi_instance_count);
>> +
>> +/**
>> + * wmidev_instance_count - Get number of WMI object instances
>> + * @wdev: A wmi bus device from a driver
>> + *
>> + * Get the number of WMI object instances.
>> + *
>> + * Returns: Number of WMI object instances.
>> + */
>> +u8 wmidev_instance_count(struct wmi_device *wdev)
>> +{
>> +	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
>> +
>> +	return wblock->gblock.instance_count;
>> +}
>> +EXPORT_SYMBOL_GPL(wmidev_instance_count);
>> +
>>   /**
>>    * wmi_evaluate_method - Evaluate a WMI method (deprecated)
>>    * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index efff750f326d..e52bf2742eaf 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device *);
>>
>>   typedef void (*wmi_notify_handler) (u32 value, void *context);
>>
>> +int wmi_instance_count(const char *guid);
>> +
>>   extern acpi_status wmi_evaluate_method(const char *guid, u8 instance,
>>   					u32 method_id,
>>   					const struct acpi_buffer *in,
>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>> index c1a3bd4e4838..763bd382cf2d 100644
>> --- a/include/linux/wmi.h
>> +++ b/include/linux/wmi.h
>> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>>   extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>>   					     u8 instance);
>>
>> +u8 wmidev_instance_count(struct wmi_device *wdev);
>> +
>>   extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
>>
>>   /**
>> --
>> 2.30.2
>>
