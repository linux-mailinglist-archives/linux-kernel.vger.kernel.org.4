Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C306F2FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjEAJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA918DB
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682933502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rfrh+7kaOJeU3MxVxJJhz257T3FA+oAcp5E+/uMsCCQ=;
        b=HGmFKS4QOcUt/QgpRX1+dqbdt2UpIEBsCJnxGRNsOAW4rcvdBY1t144t0PCdpYw2MaIqbg
        AySUzufeLq561z+I4H7DQ4sR8mYr512I4Fn+8y5+ufK71FyPnHxcC5/J8/3dwaowMEXHA/
        sNetNjw251qwzhrSAFwG4oPUjaXXf+A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-yPCzTdbLMqyzbae0xoxelA-1; Mon, 01 May 2023 05:31:41 -0400
X-MC-Unique: yPCzTdbLMqyzbae0xoxelA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bcaaeaec0so137251a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682933500; x=1685525500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfrh+7kaOJeU3MxVxJJhz257T3FA+oAcp5E+/uMsCCQ=;
        b=cd/e4hHe3OTeE+6ThUrSDKeAJ/ChZLI5WcixLobZZ4srKiDUqdE+G2QbR6lNeFhDLv
         Ot8gQKJ/nZAP2mZLvKu6vsWZa7QadlWfTubMpkScKzQotkAVUGN8tPViDWQOVb9hG7BI
         ZWkiCrtczDUqxea+X9RgSC4SQQdMtwFDrhKSQ0AVic/FqiwsyXR/ScKrgywxRRJoe1VX
         /hqup1DM8IGPW+SqYmwPUW7f3K3pPMl4aKGxtjdKh/BUsAqdSIbp16PeJdwynK6Vvisg
         CSf+PhDcssEMX1k8h0RZEb3lEz3CTNIAyCzgT2h2SR/eZmXU28CZ31NuC/NXinKevkDd
         wj3w==
X-Gm-Message-State: AC+VfDw19KhAYowuErCubT7N2o0C/rAhgKjWxl2NG7vYYxBicXEyVQ1o
        Csii6vKb0KdToOzcYKqQ98P23luLLP3Zrfxxgd9XncqkJBdSFRwRD65IDtGAVxhNxWU931MhWpe
        Mb1RPesLfEoouKUxbOmc7sKKC
X-Received: by 2002:a05:6402:184c:b0:506:996a:6721 with SMTP id v12-20020a056402184c00b00506996a6721mr4814475edy.24.1682933500072;
        Mon, 01 May 2023 02:31:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56nTd55vT6dyb8LZhr/WT72L+TkxoXAoU8dfaea896/rR3LIj052CK+0uX7P0biBF+xDurGA==
X-Received: by 2002:a05:6402:184c:b0:506:996a:6721 with SMTP id v12-20020a056402184c00b00506996a6721mr4814462edy.24.1682933499772;
        Mon, 01 May 2023 02:31:39 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id aa21-20020a170907355500b00957dad777c1sm12247743ejc.107.2023.05.01.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 02:31:38 -0700 (PDT)
Message-ID: <1c216a2e-2f97-b6f9-bf09-67b85e932322@redhat.com>
Date:   Mon, 1 May 2023 11:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] platform/x86: wmi: Allow retrieving the number of WMI
 object instances
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230430203153.5587-1-W_Armin@gmx.de>
 <20230430203153.5587-2-W_Armin@gmx.de>
 <756215f5-d99c-b172-13f6-1a15e026bf65@redhat.com>
 <3bfa4a8c-1260-3fc0-9f83-2958467ca596@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3bfa4a8c-1260-3fc0-9f83-2958467ca596@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/30/23 23:01, Armin Wolf wrote:
> Am 30.04.23 um 22:41 schrieb Hans de Goede:
> 
>> Hi Armin,
>>
>> On 4/30/23 22:31, Armin Wolf wrote:
>>> Currently, the WMI driver core knows how many instances of a given
>>> WMI object exist, but WMI drivers cannot access this information.
>>> At the same time, some current and upcoming WMI drivers want to
>>> have access to this information. Add wmi_instance_count() and
>>> wmidev_instance_count() to allow WMI drivers to get the number of
>>> WMI object instances.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> Thank you for your work on this.
>>
>>> ---
>>>   drivers/platform/x86/wmi.c | 41 ++++++++++++++++++++++++++++++++++++++
>>>   include/linux/acpi.h       |  2 ++
>>>   include/linux/wmi.h        |  2 ++
>>>   3 files changed, 45 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index c226dd4163a1..5b95d7aa5c2f 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -263,6 +263,47 @@ int set_required_buffer_size(struct wmi_device *wdev, u64 length)
>>>   }
>>>   EXPORT_SYMBOL_GPL(set_required_buffer_size);
>>>
>>> +/**
>>> + * wmi_instance_count - Get number of WMI object instances
>>> + * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>>> + *
>>> + * Get the number of WMI object instances.
>>> + *
>>> + * Returns: Number of WMI object instances or negative error code.
>>> + */
>>> +int wmi_instance_count(const char *guid_string)
>>> +{
>>> +    struct wmi_block *wblock;
>>> +    acpi_status status;
>>> +
>>> +    status = find_guid(guid_string, &wblock);
>>> +    if (ACPI_FAILURE(status)) {
>>> +        if (status == AE_BAD_PARAMETER)
>>> +            return -EINVAL;
>>> +
>>> +        return -ENODEV;
>> Maybe just return 0 here ?
>>
>> The GUID not existing at all does not seem like
>> an error to me, but rather a case of there
>> being 0 instances.
>>
>> This will also allow patch 2/2 to completely
>> drop the get_instance_count() function and
>> replace its callers with direct calls to
>> wmi_instance_count() as the code is known
>> to always pass a valid GUID, so it won't hit
>> the -EINVAL path.
>>
>> Regards,
>>
>> Hans
>>
> Hi,
> 
> i would prefer returning -ENODEV instead of 0, so WMI drivers can
> distinguish between "not found" and "zero instances".

Ah right, that is a good point, ok lets keep this as is then.

Regards,

Hans




> Also i do not
> think that relying on the parameter of get_instance_count() always
> being a valid GUID is a good idea, just in case wmi_instance_count()
> is later modified to be able to encounter runtime errors.
> 
> Armin Wolf
> 
>>
>>> +    }
>>> +
>>> +    return wmidev_instance_count(&wblock->dev);
>>> +}
>>> +EXPORT_SYMBOL_GPL(wmi_instance_count);
>>> +
>>> +/**
>>> + * wmidev_instance_count - Get number of WMI object instances
>>> + * @wdev: A wmi bus device from a driver
>>> + *
>>> + * Get the number of WMI object instances.
>>> + *
>>> + * Returns: Number of WMI object instances.
>>> + */
>>> +u8 wmidev_instance_count(struct wmi_device *wdev)
>>> +{
>>> +    struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
>>> +
>>> +    return wblock->gblock.instance_count;
>>> +}
>>> +EXPORT_SYMBOL_GPL(wmidev_instance_count);
>>> +
>>>   /**
>>>    * wmi_evaluate_method - Evaluate a WMI method (deprecated)
>>>    * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index efff750f326d..e52bf2742eaf 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device *);
>>>
>>>   typedef void (*wmi_notify_handler) (u32 value, void *context);
>>>
>>> +int wmi_instance_count(const char *guid);
>>> +
>>>   extern acpi_status wmi_evaluate_method(const char *guid, u8 instance,
>>>                       u32 method_id,
>>>                       const struct acpi_buffer *in,
>>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>>> index c1a3bd4e4838..763bd382cf2d 100644
>>> --- a/include/linux/wmi.h
>>> +++ b/include/linux/wmi.h
>>> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>>>   extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>>>                            u8 instance);
>>>
>>> +u8 wmidev_instance_count(struct wmi_device *wdev);
>>> +
>>>   extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
>>>
>>>   /**
>>> -- 
>>> 2.30.2
>>>
> 

