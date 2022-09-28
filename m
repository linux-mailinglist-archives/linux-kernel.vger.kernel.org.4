Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C17E5EDBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiI1LeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiI1LeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5FE8768D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664364838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VeawPEceN+pwXUUW/zmLlav8YN5wm0rpt26Ow1zsZo=;
        b=daR44wPRKioS/nH/6kGULGlnjzT3Zu4+3VhiV7yd5bvkRk97BeFa9GoBJELkubLJjTvZY3
        CaqOZtgUcGXqxZvth8W0DrVcDZLt2m2jwnaq73DGZuaC+sA40G0EVEiSurF2HkRoTDNJG0
        9BjKt5W56XF7mwD4K8WXLEy8ZMh8Jc4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461-kg9lfwCVNyeI9BEvp4pBxA-1; Wed, 28 Sep 2022 07:33:57 -0400
X-MC-Unique: kg9lfwCVNyeI9BEvp4pBxA-1
Received: by mail-ej1-f72.google.com with SMTP id dm10-20020a170907948a00b00781fa5e140fso5387236ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7VeawPEceN+pwXUUW/zmLlav8YN5wm0rpt26Ow1zsZo=;
        b=76PzQjXAIJTBYgAd29bo+fP17N667FBJtlf+eLxMcpb0hM1dknXepngMv3cKMXOLz7
         3WTbPDgqtplxjEtNHVEWSngtPhGvAGfToranvthwLStNBkTb9NVorecMwh1cAY5rmMaz
         qA6s/pryH2iZmNCN7YwS3jf729wKlx7uecy3N78W7Hgtrr0eNbSbqUftAouvsXKv9EfR
         V31zbmvIWAl00otEx6Ui5DzxBBP0x8YeJUv1ueCuM8gQWNHt5KV5rbDXeGWH4bB5lexf
         zm7QAasIAWur4XlsugJWN3mmpObUrWFE5HKn7kh5k72yXRw6n5YVwxxjIKTW6ix3inT/
         tm7A==
X-Gm-Message-State: ACrzQf3HkJ2hgGIMuqXnZPPHNbTuhl/NsmJ/ckpF/CFrbAZ9qlpNI+mc
        89HnKKD6fyPPU8kUNSMKRLD/y2Igrzpxbwlukf2/JasO/Pf/aqpti+g+3dhPu01a1Xh2JOfEMZh
        UHRxAAjjH2ucCDhlWrxuRs2vF
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id nd15-20020a170907628f00b0072f58fc3815mr26800435ejc.719.1664364836241;
        Wed, 28 Sep 2022 04:33:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Vgmkd143Xk/e7/oWKmjX1NPF5j5X0zLls0y2CgyjF+3pegkCzVm2mn9sbJ7adTkCjioK9qQ==
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id nd15-20020a170907628f00b0072f58fc3815mr26800415ejc.719.1664364835994;
        Wed, 28 Sep 2022 04:33:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b00783f32d7eaesm2209172ejg.164.2022.09.28.04.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:33:55 -0700 (PDT)
Message-ID: <aaacb093-c5b2-09b4-2ddc-966b3b11544e@redhat.com>
Date:   Wed, 28 Sep 2022 13:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Armin Wolf <W_Armin@gmx.de>
Cc:     markgross@kernel.org, rafael@kernel.org, lenb@kernel.org,
        hmh@hmh.eng.br, matan@svgalib.org, corentin.chary@gmail.com,
        jeremy@system76.com, productdev@system76.com,
        mario.limonciello@amd.com, pobrn@protonmail.com,
        coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/22 12:47, Andy Shevchenko wrote:
> On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:
>> The dell-wmi-ddv driver adds support for reading
>> the current temperature and ePPID of ACPI batteries
>> on supported Dell machines.
>>
>> Since the WMI interface used by this driver does not
>> do any input validation and thus cannot be used for probing,
>> the driver depends on the ACPI battery extension machanism
>> to discover batteries.
>>
>> The driver also supports a debugfs interface for retrieving
>> buffers containing fan and thermal sensor information.
>> Since the meaing of the content of those buffers is currently
>> unknown, the interface is meant for reverse-engineering and
>> will likely be replaced with an hwmon interface once the
>> meaning has been understood.
>>
>> The driver was tested on a Dell Inspiron 3505.
> 
> ...
> 
>> +config DELL_WMI_DDV
>> +	tristate "Dell WMI sensors Support"
> 
>> +	default m
> 
> Why? (Imagine I have Dell, but old machine)

Then you can select N if you really want to.

> (And yes, I see that other Kconfig options are using it, but we shall avoid
>  cargo cult and each default choice like this has to be explained at least.)

This has been discussed during the review of v1 already.

There are quite a few dell modules and the choice has
been made to put these all behind a dell platform drivers
options and then default all the individual modules to 'm'.

> ...
> 
>> + * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell notebooks.
> 
> Please, remove file name from the file. This will be an additional burden in
> the future in case it will be renamed.
> 
> ...
> 
>> +#include <acpi/battery.h>
> 
> Is it required to be the first? Otherwise it seems ACPI specific to me and the
> general rule is to put inclusions from generic towards custom. I.o.w. can you
> move it after linux/wmi.h with a blank line in between?
> 
>> +#include <linux/acpi.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kstrtox.h>
>> +#include <linux/math.h>
>> +#include <linux/module.h>
>> +#include <linux/limits.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/wmi.h>
> 
> ...
> 
>> +struct dell_wmi_ddv_data {
>> +	struct acpi_battery_hook hook;
>> +	struct device_attribute temp_attr, eppid_attr;
> 
> It's hard to read and easy to miss that the data type has two members here.
> Please, put one member per one line.
> 
>> +	struct wmi_device *wdev;
>> +};
> 
> ...
> 
>> +	if (obj->type != type) {
>> +		kfree(obj);
>> +		return -EIO;
> 
> EINVAL?
> 
>> +	}
> 
> ...
> 
>> +	kfree(obj);
> 
> I'm wondering what is the best to use in the drivers:
>  1) kfree()
>  2) acpi_os_free()
>  3) ACPI_FREE()
> 
> ?

Most ACPI driver code I know of just uses kfree() the other 2
are more ACPI-core / ACPICA internal helpers.


> 
> ...
> 
>> +static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
>> +{
> 
>> +	const char *uid_str = acpi_device_uid(acpi_dev);
>> +
>> +	if (!uid_str)
>> +		return -ENODEV;
> 
> It will be better for maintaining to have
> 
> 	const char *uid_str...;
> 
> 	uid_str = ...
> 	if (!uid_str)
> 		...
> 
>> +	return kstrtou32(uid_str, 10, index);
>> +}
> 
> ...
> 
>> +	/* Return 0 instead of error to avoid being unloaded */
>> +	ret = dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), &index);
>> +	if (ret < 0)
>> +		return 0;
> 
> How index is used?

index is used in the registered sysfs attr show functions,
so if this fails then the sysfs attr should not be registered.

> 
> ...
> 
>> +	ret = device_create_file(&battery->dev, &data->temp_attr);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = device_create_file(&battery->dev, &data->eppid_attr);
>> +	if (ret < 0) {
>> +		device_remove_file(&battery->dev, &data->temp_attr);
>> +
>> +		return ret;
>> +	}
> 
> Why dev_groups member can't be utilized?

Because this is an extension to the ACPI battery driver, IOW
this adds extra attributes to the power-supply-class device
registered by the ACPI battery driver. Note that the device
in this case is managed by the power-supply-class code, so
there is no access to dev_groups even in the ACPI battery code.

> 
> ...
> 
>> +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
> 
> Strictly speaking this should return int (see below).
> 
>> +{
>> +	struct dentry *entry;
>> +	char name[64];
>> +
>> +	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
>> +	entry = debugfs_create_dir(name, NULL);
>> +
>> +	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
>> +				    dell_wmi_ddv_fan_read);
>> +	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", entry,
>> +				    dell_wmi_ddv_temp_read);
>> +
>> +	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry);
> 
> return devm...
> 
> This is not related to debugfs and there is no rule to avoid checking error
> codes from devm_add_action_or_reset().
> 
>> +}
> 
> ...
> 
>> +static struct wmi_driver dell_wmi_ddv_driver = {
>> +	.driver = {
>> +		.name = DRIVER_NAME,
> 
> I would use explicit literal since this is a (semi-) ABI, and having it as
> a define feels not fully right.
> 
>> +	},
>> +	.id_table = dell_wmi_ddv_id_table,
>> +	.probe = dell_wmi_ddv_probe,
>> +};
> 


Regards,

Hans

