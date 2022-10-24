Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2634560AE4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiJXO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiJXO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:56:21 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70311E44E;
        Mon, 24 Oct 2022 06:33:37 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id c23so5566765qtw.8;
        Mon, 24 Oct 2022 06:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6pkCirM1du0QLowyMeKb8k7GUt9xLskqf6a9AwgXus=;
        b=xcgiEm+h04p37vKW51s4aB5Lr1YlTh/SgVBQrDqQi2SMA7Ox7USZhePQZYN3awp5ye
         E6ZxLnyJXem2+kXWVK6BwjSZvRimUyWocdoP48vgYXNc4rupoxHHtirc8ulMaAaMWCaJ
         Rl8b2BAGYSc2fmRIVaoVX5sno18/ZjwC3eKOLzEnzuq7+EcqW6mpKcQkUdHqRPBCD+AU
         rpq6sByb1OOIkIiBvE7KUmkW+FPNtajiluVS7NEo/I3pXRcvMLuMF2lX7hi6ZQj+UU1W
         WesuyvMatgqjSnOYDjdxbbAU4rKaisfFspZcmZKXzpYJcxQRk5Yf8l/QpOYJwyDGPv/Y
         Qvnw==
X-Gm-Message-State: ACrzQf1mC3aq5I/7rxjz2sAwQgTYGkrGrlwQghaxVn4CEIvLEMrAZ0sn
        Yv6Kr9EmGBER9oL7v4xuqnamxhqc34KsnE/rxz1VtfMC
X-Google-Smtp-Source: AMsMyM6nHQNDAFsnz11hM7elkW90vDxD612pgJ8PqL+4eJNr7sCUj4zpzAqx7f2z/tRu//4XBPmTIs3UGfilHd58//U=
X-Received: by 2002:ac8:7d02:0:b0:39c:bbef:178a with SMTP id
 g2-20020ac87d02000000b0039cbbef178amr27032604qtb.357.1666617567783; Mon, 24
 Oct 2022 06:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220927204521.601887-1-W_Armin@gmx.de> <20220927204521.601887-2-W_Armin@gmx.de>
In-Reply-To: <20220927204521.601887-2-W_Armin@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Oct 2022 15:19:13 +0200
Message-ID: <CAJZ5v0gMow5T3ty8UN9e6zZmQf+GhFWbrP-ab9x5scoAwsZOqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: battery: Pass battery hook pointer to hook callbacks
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:45 PM Armin Wolf <W_Armin@gmx.de> wrote:
>
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
>         if (lock)
>                 mutex_lock(&hook_mutex);
>         list_for_each_entry(battery, &acpi_battery_list, list) {
> -               hook->remove_battery(battery->bat);
> +               hook->remove_battery(battery->bat, hook);
>         }
>         list_del(&hook->list);
>         if (lock)
> @@ -724,7 +724,7 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>          * its attributes.
>          */
>         list_for_each_entry(battery, &acpi_battery_list, list) {
> -               if (hook->add_battery(battery->bat)) {
> +               if (hook->add_battery(battery->bat, hook)) {
>                         /*
>                          * If a add-battery returns non-zero,
>                          * the registration of the extension has failed,
> @@ -762,7 +762,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>          * during the battery module initialization.
>          */
>         list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
> -               if (hook_node->add_battery(battery->bat)) {
> +               if (hook_node->add_battery(battery->bat, hook_node)) {
>                         /*
>                          * The notification of the extensions has failed, to
>                          * prevent further errors we will unload the extension.
> @@ -785,7 +785,7 @@ static void battery_hook_remove_battery(struct acpi_battery *battery)
>          * custom attributes from the battery.
>          */
>         list_for_each_entry(hook, &battery_hook_list, list) {
> -               hook->remove_battery(battery->bat);
> +               hook->remove_battery(battery->bat, hook);
>         }
>         /* Then, just remove the battery from the list */
>         list_del(&battery->list);
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
>         /* The WMI method does not provide a way to specific a battery, so we
>          * just assume it is the first battery.
> @@ -909,7 +909,7 @@ static int asus_wmi_battery_add(struct power_supply *battery)
>         return 0;
>  }
>
> -static int asus_wmi_battery_remove(struct power_supply *battery)
> +static int asus_wmi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>         device_remove_file(&battery->dev,
>                            &dev_attr_charge_control_end_threshold);
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
>         int err = 0;
>
> @@ -483,7 +483,7 @@ static int huawei_wmi_battery_add(struct power_supply *battery)
>         return err;
>  }
>
> -static int huawei_wmi_battery_remove(struct power_supply *battery)
> +static int huawei_wmi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>         device_remove_file(&battery->dev, &dev_attr_charge_control_start_threshold);
>         device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold);
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
>         if (device_create_file(&battery->dev,
>                                &dev_attr_charge_control_end_threshold))
> @@ -555,7 +555,7 @@ static int lg_battery_add(struct power_supply *battery)
>         return 0;
>  }
>
> -static int lg_battery_remove(struct power_supply *battery)
> +static int lg_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>         device_remove_file(&battery->dev,
>                            &dev_attr_charge_control_end_threshold);
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
>         // System76 EC only supports 1 battery
>         if (strcmp(battery->desc->name, "BAT0") != 0)
> @@ -266,7 +266,7 @@ static int system76_battery_add(struct power_supply *battery)
>         return 0;
>  }
>
> -static int system76_battery_remove(struct power_supply *battery)
> +static int system76_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>         device_remove_groups(&battery->dev, system76_battery_groups);
>         return 0;
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
>         int batteryid = tpacpi_battery_get_id(battery->desc->name);
>
> @@ -9908,7 +9908,7 @@ static int tpacpi_battery_add(struct power_supply *battery)
>         return 0;
>  }
>
> -static int tpacpi_battery_remove(struct power_supply *battery)
> +static int tpacpi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>         device_remove_groups(&battery->dev, tpacpi_battery_groups);
>         return 0;
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
>         if (toshiba_acpi == NULL) {
>                 pr_err("Init order issue\n");
> @@ -3126,7 +3126,7 @@ static int toshiba_acpi_battery_add(struct power_supply *battery)
>         return 0;
>  }
>
> -static int toshiba_acpi_battery_remove(struct power_supply *battery)
> +static int toshiba_acpi_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>         device_remove_groups(&battery->dev, toshiba_acpi_battery_groups);
>         return 0;
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index b8d56b702c7a..611a2561a014 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -12,8 +12,8 @@
>
>  struct acpi_battery_hook {
>         const char *name;
> -       int (*add_battery)(struct power_supply *battery);
> -       int (*remove_battery)(struct power_supply *battery);
> +       int (*add_battery)(struct power_supply *battery, struct acpi_battery_hook *hook);
> +       int (*remove_battery)(struct power_supply *battery, struct acpi_battery_hook *hook);
>         struct list_head list;
>  };
>
> --
> 2.30.2
>
