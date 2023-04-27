Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46216F09D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbjD0Q1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjD0Q1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:27:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83B187;
        Thu, 27 Apr 2023 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682612791; i=w_armin@gmx.de;
        bh=+1f6qLR2Zj5oazs/gvAaitNiZ4FVbaZBODlc7qum8cQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UedrkshOS6iWVzJpQb3+MNK4UuzsxEeyofjdbnCCRTBWJNN2wdx2eW2qJbT0F8kzU
         b2KYm9GnYPoVPIX5Bu096eFm53rVwZD8yP2e4RSOSrrBf2W/27E6W74oF60814qBiP
         36jilC+YZQ9q9hohL6A9U9MPxkQS1uRn6dAAh0E6+e+mCESVHVgc9vLVdobOPV8Z/E
         S28xbuFwlPik5GqKMU1ShBgDC2O5PKfpf7nZeWL8YsrSBAadXqIb4ivn3tCk2YaVXs
         i9FLPKdxnfg7EjEejyS1z6Mdmbc7ll/ub4szYh9G9MW1bixJcUL0o5We1VEtUaeDdc
         pgsGiOp3eQ6Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1q16zW0qQ5-0097vV; Thu, 27
 Apr 2023 18:26:31 +0200
Subject: Re: [RFC v2 1/2] platform/x86: wmi: Allow retrieving the number of
 WMI object instances
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230426212848.108562-1-W_Armin@gmx.de>
 <20230426212848.108562-2-W_Armin@gmx.de>
 <339c6ba5-6d60-8271-1b5d-6c4165801187@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <4db0e619-7f18-3f6b-9fb3-769f95233a72@gmx.de>
Date:   Thu, 27 Apr 2023 18:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <339c6ba5-6d60-8271-1b5d-6c4165801187@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:ktEPUv9WL2iRyTIsTuXn7do3XeljJWvsHzY2nwiRY4N8rK8i/4K
 5eSpC7nbP8ggvbuEAt2gL9O+6HoHevg6zb1hrwZ5BK0vYOZT2uxrZt3s+jxYe4qgbynGNyY
 nkZLJqFAOM4sqsPK8D/1mqtq8MZPp/p0lwfiM58jOrC/PlP9SftwyCUyRb1wIjBMFHt2h8W
 GCMC/EfIJ8DMhRBfpbWUQ==
UI-OutboundReport: notjunk:1;M01:P0:i2L+AHv1eN8=;ZtumYekCO9qsx13dapsN/FGcVd4
 5O2dA87x0FfjkqEvPm3Dcl+v7RL4GM/QCI5qHU+OObx+Fj988NR4gtrSkFbsalgSu/GQ8IVZR
 aD6vCgBDtUB9VWhYV//VEBICtncYYR47j6vLr5Zwi5aWuIw3+bXBlJF5marp1qgOa2b6CCIe0
 dRPLmcI/suUgjD0RpZN5Snr2jWgoQjLPTtQb5wGlEyXngNimM1Kton2gB1Zdb20uAKECQcwRa
 6qqJ9vUmnMC6i78iio8PLgLb1A0D5EeGPFQVq4rm8coh1pAmBo5HETI9vPSzu631tncpbpgI1
 GU29Zjf+qCrF1j/OBHXghtcbCUzT6VZteXernHGP41PHQ3Cc+ePGXBzev4Is1okqNMRKbJalk
 Pu1eZdodufjqUYVLsAvOxvFuuod9k8qW7n4UfTm7YARm9kSCS1qloTH890lTgpUxL7ovWvVrZ
 nFOzi+gvwPpcYtWZnGaoeE1dPxw02EVJq6KCapPtmnA0fLuqMKu+X3OGECxKbx/KjRCvW3zsq
 r8Mk3ggz5Fk4rL+9Fr//UyTBl4xNhTrqssr1cfxv/L3I54nAxQNG9Lt0AS1KQqufWYztq1vHn
 l9zy00x3qP4Idi3jxslL1z5me1PbO+cs6P9ZlgQsuxQY/nCkZjRmL7ZlBSDOn9oKz5/UYelD3
 xAhSNyMcQJtbDRQMPgGpHQ9hxwhu3cTO05ap7qQjXZtDlkvxeTRSS1guBVVoxXgvWTJUr5lq8
 qwlYtU0iiWAbjBy7RCEeS2so2QFtP3MDAwyPsoAwwLUK8VkGxkZpYiHdTYabgZg7/VwN+Atoc
 bGXl67HiLagtYjrcjH0rJDaRk8U8OqPsFjHTTCc5wMLX1OYAQbbTsBlnqBMnqH48qqt8ZmNTm
 vRhVUWQ0TOApO1rsTW1JUZxVxAZCWhDtSMwmT+0BG8xT4enUPRXAZSwUHpzZum5TLkmDU85c7
 QrGy8t0DV08uRemhFseapwPflPs=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.04.23 um 11:43 schrieb Hans de Goede:

> Hi Armin,
>
> Thank you for your work on this.
>
> On 4/26/23 23:28, Armin Wolf wrote:
>> Currently, the WMI driver core knows how many instances of a given
>> WMI object exist, but WMI drivers cannot access this information.
>> At the same time, some current and upcoming WMI drivers want to
>> have access to this information. Add wmi_instance_count() and
>> wmidev_instance_count() to allow WMI drivers to get the number of
>> WMI object instances.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/wmi.c | 40 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h       |  2 ++
>>   include/linux/wmi.h        |  2 ++
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index c226dd4163a1..7c1a904dec5f 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -263,6 +263,46 @@ int set_required_buffer_size(struct wmi_device *wdev, u64 length)
>>   }
>>   EXPORT_SYMBOL_GPL(set_required_buffer_size);
>>
>> +/**
>> + * wmi_instance_count - Get number of WMI object instances
>> + * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>> + * @instance_count: variable to hold the instance count
>> + *
>> + * Get the number of WMI object instances.
>> + *
>> + * Returns: acpi_status signaling success or error.
>> + */
>> +acpi_status wmi_instance_count(const char *guid_string, u8 *instance_count)
>> +{
>> +	struct wmi_block *wblock;
>> +	acpi_status status;
>> +
>> +	status = find_guid(guid_string, &wblock);
>> +	if (ACPI_FAILURE(status))
>> +		return status;
>> +
>> +	*instance_count = wmidev_instance_count(&wblock->dev);
>> +
>> +	return AE_OK;
>> +}
>> +EXPORT_SYMBOL_GPL(wmi_instance_count);
> I would prefer this to have a normal kernel function prototype
> which returns -errno rather then returning an acpi_status. E.g. :
>
> /**
>   * wmi_instance_count - Get number of WMI object instances
>   * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>   *
>   * Get the number of WMI object instances.
>   *
>   * Returns: The number of WMI object instances, 0 if the GUID is not found.
>   */
> int wmi_instance_count(const char *guid_string)
> {
> 	struct wmi_block *wblock;
> 	acpi_status status;
>
> 	status = find_guid(guid_string, &wblock);
> 	if (ACPI_FAILURE(status))
> 		return 0;
>
> 	return wmidev_instance_count(&wblock->dev);
> }
> EXPORT_SYMBOL_GPL(wmi_instance_count);
>
> This will also allow this to completely replace
> the get_instance_count() function in dell-wmi-sysman.
>
> Note I have just gone with always returning 0 here
> on error. I guess you could look at the status and
> return 0 for not-found and -errno for other errors
> but I don't think any callers will care for the difference,
> so just always returning 0 seems easier for callers to
> deal with.
>
> As always this is just a suggestion, let me know if
> you think this is a bad idea.
>
> Regards,
>
> Hans
>
I like this idea. Returning a negative errno on error would allow drivers to
distinguish between "WMI object not found" and "zero instances found", which
might be useful for some drivers.

Maybe a function for converting ACPI errors to POSIX errors already exists,
otherwise i will just write one myself.

Armin Wolf

>
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
>> index efff750f326d..ab2a4b23e7a3 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device *);
>>
>>   typedef void (*wmi_notify_handler) (u32 value, void *context);
>>
>> +acpi_status wmi_instance_count(const char *guid, u8 *instance_count);
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
