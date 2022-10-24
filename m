Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4A460BE15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJXXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiJXXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F42D7831
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666646521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVRO3j9qqyjNwzxuSIwp8DYZYKQpY+C+UFUUt3t3mH4=;
        b=bXUWXPZL9u3CEgzARQQUJcUWNaIOTFEA/+fpycY0sSS2rC2HvejRQz2OWQ8oSZTuZQrvIg
        1REU/x0onep2TBv5fW+qEmPo99DYYdq8cGeTfrZpXwIDpUkxny2kbVDADOCBSbr8OZDkie
        ryU4LLz1yeIvX4+m81nZ1OmK5sd3JJc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-2FvLlJv9PWKs8Y-6El-6Zg-1; Mon, 24 Oct 2022 09:47:45 -0400
X-MC-Unique: 2FvLlJv9PWKs8Y-6El-6Zg-1
Received: by mail-ed1-f69.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso9727658edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVRO3j9qqyjNwzxuSIwp8DYZYKQpY+C+UFUUt3t3mH4=;
        b=ryZ3ABrqXr7lRsDa6h6nTYzwHdWcfHNtETKnyPNoXdH5lyOrQfz201NQu1EBKcSeD3
         nAfZ/7fXLVa57WERxyaUe0vzgpb6+j6FFzFzqVcaLPCuiveYcPeL86gL2QDxz+iKp7eX
         HKcEKqCP/C91ZcqGZ1r5AxhicIFSKqKtHrM9KgojfrFC9aEwHzEireqIDrk8N6YkePij
         OqsDCrUPYxc2/6tG6xzuhdogpUoARoiYE30zAfiyPZIeiJwISYmNg7NJVFJPoZCPvciw
         wDDlmozl0LPjPf16gkMrCBlmAtSKgLfH/9VzlGHoXJVtOreYjxPsBlLVGdAVrOVPDR0I
         zX1A==
X-Gm-Message-State: ACrzQf01+9uFyo0PmdAXpc5JqWQhbWBvt90p3DOhT/FrmsWhugK2zYs4
        gts6wv7IslNIMs3ewVOUpE7/EddWNj4+Ta6438pNsomfxZNnq10iehnVp2/2ojPh6ORRZQahhRP
        A5flbzhkpvtlq/BghjwKOXevv
X-Received: by 2002:a05:6402:520f:b0:45f:b7a0:a31 with SMTP id s15-20020a056402520f00b0045fb7a00a31mr23729494edd.379.1666619253418;
        Mon, 24 Oct 2022 06:47:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77TrWL37aD3oIh8CjP9KR7MTWZ1JhaaHUJ4YmD2AUz0uLtJaRkhwi6YqyRrX3krnc9Ce+4jA==
X-Received: by 2002:a05:6402:520f:b0:45f:b7a0:a31 with SMTP id s15-20020a056402520f00b0045fb7a00a31mr23729476edd.379.1666619253161;
        Mon, 24 Oct 2022 06:47:33 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id jy17-20020a170907763100b00781d411a63csm15549696ejc.151.2022.10.24.06.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:47:32 -0700 (PDT)
Message-ID: <34114ce8-8809-7791-8d7e-ccad6ff7b1a1@redhat.com>
Date:   Mon, 24 Oct 2022 15:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] ACPI: battery: Pass battery hook pointer to hook
 callbacks
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-2-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220927204521.601887-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/22 22:45, Armin Wolf wrote:
> Right now, is impossible for battery hook callbacks
> to access instance-specific data, forcing most drivers
> to provide some sort of global state. This however is
> difficult for drivers which can be instantiated multiple
> times and/or are hotplug-capable.
> 
> Pass a pointer to the batetry hook to those callbacks
> for usage with container_of().
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/acpi/battery.c               | 8 ++++----
>  drivers/platform/x86/asus-wmi.c      | 4 ++--
>  drivers/platform/x86/huawei-wmi.c    | 4 ++--
>  drivers/platform/x86/lg-laptop.c     | 4 ++--
>  drivers/platform/x86/system76_acpi.c | 4 ++--
>  drivers/platform/x86/thinkpad_acpi.c | 4 ++--
>  drivers/platform/x86/toshiba_acpi.c  | 4 ++--
>  include/acpi/battery.h               | 4 ++--
>  8 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 306513fec1e1..9482b0b6eadc 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -696,7 +696,7 @@ static void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
>  	if (lock)
>  		mutex_lock(&hook_mutex);
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
> -		hook->remove_battery(battery->bat);
> +		hook->remove_battery(battery->bat, hook);
>  	}
>  	list_del(&hook->list);
>  	if (lock)
> @@ -724,7 +724,7 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  	 * its attributes.
>  	 */
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
> -		if (hook->add_battery(battery->bat)) {
> +		if (hook->add_battery(battery->bat, hook)) {
>  			/*
>  			 * If a add-battery returns non-zero,
>  			 * the registration of the extension has failed,
> @@ -762,7 +762,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>  	 * during the battery module initialization.
>  	 */
>  	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
> -		if (hook_node->add_battery(battery->bat)) {
> +		if (hook_node->add_battery(battery->bat, hook_node)) {
>  			/*
>  			 * The notification of the extensions has failed, to
>  			 * prevent further errors we will unload the extension.
> @@ -785,7 +785,7 @@ static void battery_hook_remove_battery(struct acpi_battery *battery)
>  	 * custom attributes from the battery.
>  	 */
>  	list_for_each_entry(hook, &battery_hook_list, list) {
> -		hook->remove_battery(battery->bat);
> +		hook->remove_battery(battery->bat, hook);
>  	}
>  	/* Then, just remove the battery from the list */
>  	list_del(&battery->list);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ae46af731de9..446669d11095 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -882,7 +882,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
> 
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
> 
> -static int asus_wmi_battery_add(struct power_supply *battery)
> +static int asus_wmi_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	/* The WMI method does not provide a way to specific a battery, so we
>  	 * just assume it is the first battery.
> @@ -909,7 +909,7 @@ static int asus_wmi_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int asus_wmi_battery_remove(struct power_supply *battery)
> +static int asus_wmi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	device_remove_file(&battery->dev,
>  			   &dev_attr_charge_control_end_threshold);
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index eac3e6b4ea11..1dec4427053a 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -468,7 +468,7 @@ static DEVICE_ATTR_RW(charge_control_start_threshold);
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
>  static DEVICE_ATTR_RW(charge_control_thresholds);
> 
> -static int huawei_wmi_battery_add(struct power_supply *battery)
> +static int huawei_wmi_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	int err = 0;
> 
> @@ -483,7 +483,7 @@ static int huawei_wmi_battery_add(struct power_supply *battery)
>  	return err;
>  }
> 
> -static int huawei_wmi_battery_remove(struct power_supply *battery)
> +static int huawei_wmi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	device_remove_file(&battery->dev, &dev_attr_charge_control_start_threshold);
>  	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold);
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 332868b140ed..d662b64b0ba9 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -546,7 +546,7 @@ static DEVICE_ATTR_RW(fn_lock);
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
>  static DEVICE_ATTR_RW(battery_care_limit);
> 
> -static int lg_battery_add(struct power_supply *battery)
> +static int lg_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	if (device_create_file(&battery->dev,
>  			       &dev_attr_charge_control_end_threshold))
> @@ -555,7 +555,7 @@ static int lg_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int lg_battery_remove(struct power_supply *battery)
> +static int lg_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	device_remove_file(&battery->dev,
>  			   &dev_attr_charge_control_end_threshold);
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
> index 958df41ad509..9031bd53253f 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -254,7 +254,7 @@ static struct attribute *system76_battery_attrs[] = {
> 
>  ATTRIBUTE_GROUPS(system76_battery);
> 
> -static int system76_battery_add(struct power_supply *battery)
> +static int system76_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	// System76 EC only supports 1 battery
>  	if (strcmp(battery->desc->name, "BAT0") != 0)
> @@ -266,7 +266,7 @@ static int system76_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int system76_battery_remove(struct power_supply *battery)
> +static int system76_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	device_remove_groups(&battery->dev, system76_battery_groups);
>  	return 0;
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 8fbe21ebcc52..75ba9e61264e 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9897,7 +9897,7 @@ ATTRIBUTE_GROUPS(tpacpi_battery);
> 
>  /* ACPI battery hooking */
> 
> -static int tpacpi_battery_add(struct power_supply *battery)
> +static int tpacpi_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	int batteryid = tpacpi_battery_get_id(battery->desc->name);
> 
> @@ -9908,7 +9908,7 @@ static int tpacpi_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int tpacpi_battery_remove(struct power_supply *battery)
> +static int tpacpi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	device_remove_groups(&battery->dev, tpacpi_battery_groups);
>  	return 0;
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 43cc25351aea..c8f01f8f435d 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3113,7 +3113,7 @@ static struct attribute *toshiba_acpi_battery_attrs[] = {
> 
>  ATTRIBUTE_GROUPS(toshiba_acpi_battery);
> 
> -static int toshiba_acpi_battery_add(struct power_supply *battery)
> +static int toshiba_acpi_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	if (toshiba_acpi == NULL) {
>  		pr_err("Init order issue\n");
> @@ -3126,7 +3126,7 @@ static int toshiba_acpi_battery_add(struct power_supply *battery)
>  	return 0;
>  }
> 
> -static int toshiba_acpi_battery_remove(struct power_supply *battery)
> +static int toshiba_acpi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	device_remove_groups(&battery->dev, toshiba_acpi_battery_groups);
>  	return 0;
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index b8d56b702c7a..611a2561a014 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -12,8 +12,8 @@
> 
>  struct acpi_battery_hook {
>  	const char *name;
> -	int (*add_battery)(struct power_supply *battery);
> -	int (*remove_battery)(struct power_supply *battery);
> +	int (*add_battery)(struct power_supply *battery, struct acpi_battery_hook *hook);
> +	int (*remove_battery)(struct power_supply *battery, struct acpi_battery_hook *hook);
>  	struct list_head list;
>  };
> 
> --
> 2.30.2
> 

