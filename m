Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB160748F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJUJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBB2591F8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666346317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDp3pjUHLMb0BayuCEe4by55GyjbnGvv6ScgCkhmq58=;
        b=XH6uzZmqS/TU9lUdK9Z9m3aIjkWoQWTJKpPFpdNAQwQC/QInrhj5ppcSrn/hjFyE2VA5wU
        zFzaS9+4mXy5HljRldOoB8T8o3iinukS30Bi3Q0trek/9tHtt8XzNFw9i3yCc4ZBpn/Yid
        J2SOode3N/xDHeMVOLZ/BKBRRDaWUfA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-91-t9n9KRqzOmecV2G1To7YoA-1; Fri, 21 Oct 2022 05:58:36 -0400
X-MC-Unique: t9n9KRqzOmecV2G1To7YoA-1
Received: by mail-ed1-f70.google.com with SMTP id h9-20020a05640250c900b0045cfb639f56so1824783edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDp3pjUHLMb0BayuCEe4by55GyjbnGvv6ScgCkhmq58=;
        b=7fcMJe9qF4Zr00skfF0+C1h6b5rTR63jJZKlEeg1rFRFjzDcy/vkqs6F9VBl1agTSy
         9N5UTze+YJ2w3eRDuAIbEiomRFNfGjHDGKO/Uu79E1Xzp/uBOEqyF/d2u1LRMakMWEeL
         cOGCNLUv5Vn/D2aqFmS+km5XvdJ3zVCg7aWi0dsJ8reiRmY6xM238HsINKbskSWDEFS6
         zDecgpsAcXBlETvVm4ojtbUMcvCr6pUtXX1x0BlStqnrhSFizmoeFwf2fF5IPl/GVuT9
         xyKnSrqFz1bgLZ/d2lElonhYqVruPmQ9z9lrFDfla0NAchPY0DBvrOSAuahrFwxGvJXX
         rdyw==
X-Gm-Message-State: ACrzQf1UFSHecssjSMa7qL1Oepo7OJFMnViWd9I8bvJMiSeiz5v94BKb
        KJmanfV5P8Od2IjlSui3VroIS99TW6eLcgx7Y71lnaZM9M1BpCw4un+JYz0siF9jRcUQW9KzXVY
        D4yN/h7OLS7VkxIuDNi6itf4G
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id x99-20020a50baec000000b004614c5912bfmr1721385ede.54.1666346314935;
        Fri, 21 Oct 2022 02:58:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7IpllFfSlcsB9cnniC+JkU6q8pFaj/gj2gDvVFmCHYZPU1i9Aa2yLQTTT6VSP9K119azM6cA==
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id x99-20020a50baec000000b004614c5912bfmr1721358ede.54.1666346314652;
        Fri, 21 Oct 2022 02:58:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b007867dcd3f15sm11416600ejh.104.2022.10.21.02.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 02:58:33 -0700 (PDT)
Message-ID: <ca8222fe-4b15-eb1f-46be-2e8288ea1cd1@redhat.com>
Date:   Fri, 21 Oct 2022 11:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org
Cc:     markgross@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
 <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
 <YzVqbSBHm3OrjIaQ@smile.fi.intel.com>
 <bf84f13d-f76a-c0ac-8a1f-f4e1b55e6f51@redhat.com>
 <11964cd1-94b5-dc6a-a6c9-7fd5fe335ed4@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <11964cd1-94b5-dc6a-a6c9-7fd5fe335ed4@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin, Rafael,

On 10/21/22 11:34, Armin Wolf wrote:
> Am 29.09.22 um 15:12 schrieb Hans de Goede:
> 
>> Hi,
>>
>> On 9/29/22 11:50, Andy Shevchenko wrote:
>>> On Wed, Sep 28, 2022 at 10:57:16PM +0200, Armin Wolf wrote:
>>>> Am 28.09.22 um 12:47 schrieb Andy Shevchenko:
>>>>> On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:
>>> ...
>>>
>>>>>> +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
>>>>> Strictly speaking this should return int (see below).
>>>>>
>>>>>> +{
>>>>>> +    struct dentry *entry;
>>>>>> +    char name[64];
>>>>>> +Fujitsu Academy
>>>>>>
>>>>>> +    scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
>>>>>> +    entry = debugfs_create_dir(name, NULL);
>>>>>> +
>>>>>> +    debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
>>>>>> +                    dell_wmi_ddv_fan_read);
>>>>>> +    debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", entry,
>>>>>> +                    dell_wmi_ddv_temp_read);
>>>>>> +
>>>>>> +    devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry);
>>>>> return devm...
>>>>>
>>>>> This is not related to debugfs and there is no rule to avoid checking error
>>>>> codes from devm_add_action_or_reset().
>>>>>
>>>> According to the documentation of debugfs_create_dir(), drivers should work fine if debugfs
>>>> initialization fails. Thus the the return value of dell_wmi_ddv_debugfs_init() would be ignored
>>>> when called, which means that returning an error would serve no purpose.
>>>> Additionally, devm_add_action_or_reset() automatically executes the cleanup function if devres
>>>> registration fails, so we do not have to care about that.
>>> The problem with your code that if devm_ call fails and you ain't stop probing
>>> the remove-insert module (or unbind-bind) cycle will fail, because of existing
>>> (leaked) debugfs dentries.
>> No it won't if the devm_ call fails then it will directly call
>> the passed in handler so in this case we can simply continue
>> without debugfs entries (which will have been removed by the
>> handler). The directly calling of the action handler on
>> failure is the whole difference between devm_add_action()
>> and devm_add_action_or_reset()
>>
>> So using it this way in the case of a debugfs init function
>> is fine.
>>
>>>>>> +        .name = DRIVER_NAME,
>>>>> I would use explicit literal since this is a (semi-) ABI, and having it as
>>>>> a define feels not fully right.
>>>> The driver name is used in two places (init and debugfs), so having a define for it
>>>> avoids problems in case someone forgets to change both.
>>> Which is exactly what we must prevent developer to do. If changing debugfs it
>>> mustn't change the driver name, because the latter is ABI, while the former is
>>> not.
>> Arguably both are not really ABI. Drivers have been renamed in the past
>> without issues for userspace.
>>
>> Regards,
>>
>> Hans
>>
> What is the current status of this patch set?

I indicated to Rafael (ACPI subsys maintainer) that I consider this ready
for merging and tried to coordinate this with Rafael, but that email
seems to have fallen through the cracks, likely due to it being pretty
close to the 6.1 merge window. So lets try again:

Rafael, from my pov this patch-set is ready for merging, since 2/2 depends
on "[PATCH v2 1/2] ACPI: battery: Pass battery hook pointer to hook callbacks"
we need to coordinate this.

Since even patch 1/2 mostly touches files under drivers/platform/x86 I would
prefer to merge this through the pdx86 tree, may I have your ack for this ?

> If necessary, i can submit an v3 patch set which includes the
> patch regarding the minor style fixes. I also tested the driver on my Dell Insprion 3505 for some time, so
> i can proof it works.

I can squash the follow up patch into 2/2 when merging this myself. From
my pov no action is needed from you on this at this moment on time. But
it is good that you send a friendly ping about this :)

Regards,

Hans



