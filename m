Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DB5BCA42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiISLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7B95A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663585703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwyU2KnuE+2XvBMTG3lUyXjwxhJE1NI7m29fH5pw0Co=;
        b=Xu4FjHf+EGa1nqrcxa4YFmI1yWNgftTNQ/ig2mvlJQk91LdQQq+/d4EjlXpIxsWug9mvlS
        LORrzx3QagnEQByBd0G5C/AVV4T9aT8bGnZyFJT0v3XnyjN9LAhv6251AdaFBNtFbSIAXb
        dgvxoi2eL2v6d5by3Nry+1ygoD8r0cQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-Zf_rtn8dPtuV88zv75g_XQ-1; Mon, 19 Sep 2022 07:08:22 -0400
X-MC-Unique: Zf_rtn8dPtuV88zv75g_XQ-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b0045249bc17a9so13438420edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jwyU2KnuE+2XvBMTG3lUyXjwxhJE1NI7m29fH5pw0Co=;
        b=LzvrBaz0byvYwHEBCMZcpC09VjSJQWxDTLRf7JdZzn0OlNzMOpgcNpTaw898crR83C
         Dt+NG4Ore1+jye3jUr2/IpiaNBhvRPjv6u66PMlMy4rycjEMtGz6SpHuk/7VVUhl6lR3
         7h3iQGKm4MmSkEdvjawiiCFdl3/gZ0l2eMj3j2XPtShXPYue+J4DihJBQbsxmVPt5ebu
         B7Akw3mFDZW5dWZDTWB6B6bJPJ/oahy2GxNVSPapPSEFq+jlpqW9O3TMeJFUE5Qx72/Q
         imQ9EJ1i7g29GAPGQ9x0pDdtSv9QABJpJR806GFXcuyz80VUoVXqkNv6se/O54TDu3vB
         wBjg==
X-Gm-Message-State: ACrzQf30OeUHHVCFSUhNMp5LCXW8EtLHcXxZ99uZyRjiGmth3uDkujbS
        TIzbGfRHZVdH6+reRDt+pdGNV7sXjwvuwBOZNb5zNCRWOp6R0773Cyf8eYmRgpYUuTtVNvZqOFC
        AxuJ4XlgO0x3XwUDTrquagPOQ
X-Received: by 2002:aa7:c792:0:b0:453:98b7:213c with SMTP id n18-20020aa7c792000000b0045398b7213cmr9733748eds.159.1663585701133;
        Mon, 19 Sep 2022 04:08:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6qRPJbqMLzWIF5o6Bz9+pNwdb52w7wMQDBAImSbvrcpq5cqyDuCg7z+HurZxw1TprXyrk4WA==
X-Received: by 2002:aa7:c792:0:b0:453:98b7:213c with SMTP id n18-20020aa7c792000000b0045398b7213cmr9733727eds.159.1663585700862;
        Mon, 19 Sep 2022 04:08:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402075800b0045081dc93dfsm20033362edy.78.2022.09.19.04.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:08:20 -0700 (PDT)
Message-ID: <2f76bf4d-4e7a-14fb-2247-5eb55112ad8e@redhat.com>
Date:   Mon, 19 Sep 2022 12:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 4/5] ACPI: battery: Allow for passing data to battery
 hooks.
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-5-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912125342.7395-5-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/22 13:53, Armin Wolf wrote:
> Since a driver may register multiple instances of a
> battery hook, passing data to each instance is
> convenient.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/battery.c               | 11 ++++++-----
>  drivers/platform/x86/asus-wmi.c      |  7 ++++---
>  drivers/platform/x86/huawei-wmi.c    |  6 +++---
>  drivers/platform/x86/lg-laptop.c     |  6 +++---
>  drivers/platform/x86/system76_acpi.c |  6 +++---
>  drivers/platform/x86/thinkpad_acpi.c |  6 +++---
>  include/acpi/battery.h               |  7 ++++---
>  7 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 15bb5d868a56..396a7324216c 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -696,7 +696,7 @@ void battery_hook_unregister(struct acpi_battery_hook *hook)
>  	mutex_lock(&hook_mutex);
> 
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
> -		hook->ops->remove_battery(battery->bat);
> +		hook->ops->remove_battery(hook->data, battery->bat);
>  	}
>  	list_del(&hook->list);
> 
> @@ -706,7 +706,7 @@ void battery_hook_unregister(struct acpi_battery_hook *hook)
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
> 
> -struct acpi_battery_hook *battery_hook_register(const char *name,
> +struct acpi_battery_hook *battery_hook_register(const char *name, void *data,
>  						const struct acpi_battery_hook_ops *ops)
>  {
>  	struct acpi_battery_hook *hook = kzalloc(sizeof(*hook), GFP_KERNEL);
> @@ -716,6 +716,7 @@ struct acpi_battery_hook *battery_hook_register(const char *name,
>  		return ERR_PTR(-ENOMEM);
> 
>  	hook->name = name;
> +	hook->data = data;
>  	hook->ops = ops;
> 
>  	mutex_lock(&hook_mutex);
> @@ -728,7 +729,7 @@ struct acpi_battery_hook *battery_hook_register(const char *name,
>  	 * its attributes.
>  	 */
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
> -		hook->ops->add_battery(battery->bat);
> +		hook->ops->add_battery(hook->data, battery->bat);
>  	}
>  	pr_info("new extension: %s\n", hook->name);
> 
> @@ -758,7 +759,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>  	 * during the battery module initialization.
>  	 */
>  	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
> -		hook_node->ops->add_battery(battery->bat);
> +		hook_node->ops->add_battery(hook_node->data, battery->bat);
>  	}
>  	mutex_unlock(&hook_mutex);
>  }
> @@ -773,7 +774,7 @@ static void battery_hook_remove_battery(struct acpi_battery *battery)
>  	 * custom attributes from the battery.
>  	 */
>  	list_for_each_entry(hook, &battery_hook_list, list) {
> -		hook->ops->remove_battery(battery->bat);
> +		hook->ops->remove_battery(hook->data, battery->bat);
>  	}
>  	/* Then, just remove the battery from the list */
>  	list_del(&battery->list);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 37d8649418f4..18afcf38931f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -882,7 +882,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
> 
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
> 
> -static int asus_wmi_battery_add(struct power_supply *battery)
> +static int asus_wmi_battery_add(void *data, struct power_supply *battery)
>  {
>  	/* The WMI method does not provide a way to specific a battery, so we
>  	 * just assume it is the first battery.
> @@ -909,7 +909,7 @@ static int asus_wmi_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int asus_wmi_battery_remove(struct power_supply *battery)
> +static int asus_wmi_battery_remove(void *data, struct power_supply *battery)
>  {
>  	device_remove_file(&battery->dev,
>  			   &dev_attr_charge_control_end_threshold);
> @@ -924,7 +924,8 @@ static const struct acpi_battery_hook_ops battery_hook_ops = {
>  static void asus_wmi_battery_init(struct asus_wmi *asus)
>  {
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
> -		asus->hook = battery_hook_register("ASUS Battery Extension", &battery_hook_ops);
> +		asus->hook = battery_hook_register("ASUS Battery Extension", NULL,
> +						   &battery_hook_ops);
>  	}
>  }
> 
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index 6fd02b25a97b..f23806299c1a 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -469,7 +469,7 @@ static DEVICE_ATTR_RW(charge_control_start_threshold);
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
>  static DEVICE_ATTR_RW(charge_control_thresholds);
> 
> -static int huawei_wmi_battery_add(struct power_supply *battery)
> +static int huawei_wmi_battery_add(void *data, struct power_supply *battery)
>  {
>  	int err = 0;
> 
> @@ -484,7 +484,7 @@ static int huawei_wmi_battery_add(struct power_supply *battery)
>  	return err;
>  }
> 
> -static int huawei_wmi_battery_remove(struct power_supply *battery)
> +static int huawei_wmi_battery_remove(void *data, struct power_supply *battery)
>  {
>  	device_remove_file(&battery->dev, &dev_attr_charge_control_start_threshold);
>  	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold);
> @@ -507,7 +507,7 @@ static void huawei_wmi_battery_setup(struct device *dev)
>  		return;
>  	}
> 
> -	huawei->hook = battery_hook_register("Huawei Battery Extension",
> +	huawei->hook = battery_hook_register("Huawei Battery Extension", NULL,
>  					     &huawei_wmi_battery_hook_ops);
>  	device_create_file(dev, &dev_attr_charge_control_thresholds);
>  }
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index d8a61a07313e..f1abb1924150 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -547,7 +547,7 @@ static DEVICE_ATTR_RW(fn_lock);
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
>  static DEVICE_ATTR_RW(battery_care_limit);
> 
> -static int lg_battery_add(struct power_supply *battery)
> +static int lg_battery_add(void *data, struct power_supply *battery)
>  {
>  	if (device_create_file(&battery->dev,
>  			       &dev_attr_charge_control_end_threshold))
> @@ -556,7 +556,7 @@ static int lg_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int lg_battery_remove(struct power_supply *battery)
> +static int lg_battery_remove(void *data, struct power_supply *battery)
>  {
>  	device_remove_file(&battery->dev,
>  			   &dev_attr_charge_control_end_threshold);
> @@ -750,7 +750,7 @@ static int acpi_add(struct acpi_device *device)
>  	led_classdev_register(&pf_device->dev, &tpad_led);
> 
>  	wmi_input_setup();
> -	hook = battery_hook_register("LG Battery Extension", &battery_hook_ops);
> +	hook = battery_hook_register("LG Battery Extension", NULL, &battery_hook_ops);
> 
>  	return 0;
> 
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
> index 1ec22db32bd0..9414b9491806 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -255,7 +255,7 @@ static struct attribute *system76_battery_attrs[] = {
> 
>  ATTRIBUTE_GROUPS(system76_battery);
> 
> -static int system76_battery_add(struct power_supply *battery)
> +static int system76_battery_add(void *data, struct power_supply *battery)
>  {
>  	// System76 EC only supports 1 battery
>  	if (strcmp(battery->desc->name, "BAT0") != 0)
> @@ -267,7 +267,7 @@ static int system76_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int system76_battery_remove(struct power_supply *battery)
> +static int system76_battery_remove(void *data, struct power_supply *battery)
>  {
>  	device_remove_groups(&battery->dev, system76_battery_groups);
>  	return 0;
> @@ -280,7 +280,7 @@ static const struct acpi_battery_hook_ops system76_battery_hook_ops = {
> 
>  static void system76_battery_init(struct system76_data *data)
>  {
> -	data->hook = battery_hook_register("System76 Battery Extension",
> +	data->hook = battery_hook_register("System76 Battery Extension", NULL,
>  					   &system76_battery_hook_ops);
>  }
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 8adafc3c31fa..6008d88e0727 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9898,7 +9898,7 @@ ATTRIBUTE_GROUPS(tpacpi_battery);
> 
>  /* ACPI battery hooking */
> 
> -static int tpacpi_battery_add(struct power_supply *battery)
> +static int tpacpi_battery_add(void *data, struct power_supply *battery)
>  {
>  	int batteryid = tpacpi_battery_get_id(battery->desc->name);
> 
> @@ -9909,7 +9909,7 @@ static int tpacpi_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int tpacpi_battery_remove(struct power_supply *battery)
> +static int tpacpi_battery_remove(void *data, struct power_supply *battery)
>  {
>  	device_remove_groups(&battery->dev, tpacpi_battery_groups);
>  	return 0;
> @@ -9943,7 +9943,7 @@ static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
>  					battery_quirk_table,
>  					ARRAY_SIZE(battery_quirk_table));
> 
> -	battery_info.hook = battery_hook_register("ThinkPad Battery Extension",
> +	battery_info.hook = battery_hook_register("ThinkPad Battery Extension", NULL,
>  						  &battery_hook_ops);
> 
>  	return 0;
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index b3c81abada1e..cca401b793b2 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -11,17 +11,18 @@
>  #define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
> 
>  struct acpi_battery_hook_ops {
> -	int (*add_battery)(struct power_supply *battery);
> -	int (*remove_battery)(struct power_supply *battery);
> +	int (*add_battery)(void *data, struct power_supply *battery);
> +	int (*remove_battery)(void *data, struct power_supply *battery);
>  };
> 
>  struct acpi_battery_hook {
>  	const char *name;
>  	const struct acpi_battery_hook_ops *ops;
> +	void *data;
>  	struct list_head list;
>  };
> 
> -struct acpi_battery_hook *battery_hook_register(const char *name,
> +struct acpi_battery_hook *battery_hook_register(const char *name, void *data,
>  						const struct acpi_battery_hook_ops *hook);
>  void battery_hook_unregister(struct acpi_battery_hook *hook);
> 
> --
> 2.30.2
> 

