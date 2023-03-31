Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C086D2776
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjCaSCL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjCaSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:01:55 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670C2368D;
        Fri, 31 Mar 2023 11:01:26 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id b20so92874236edd.1;
        Fri, 31 Mar 2023 11:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7ILAI9xgsrv2CUqZcgKibSQHX480a+0uL0n4h1D8/Y=;
        b=CoczZ3AzmndNpFoOOzXWYGXvbnKOoJghI63AJwFHsJe2S8j7kUUEUHzbW21vOmizwo
         sgIzJlUOCfEPrbVSMQIBel0uV1XIy1sYnlyeDlZyTrJYhpj44L8jW1uvOYoyvOTFz10S
         xcgOYyvTlRO4f6+oJmabZAkk4g4uF2FZddsP7mfhxmsAY7sR3IGeRRf2DkFeDmiU34JX
         5h3/+6cfSzTN6rQ3AcAzI8SarvXtmmtIDfD+va2J17j0TQOBgbKBHAL8I5kYU+OECOQh
         zpHGdEh+M4xKiZ7KNmXVSyFDlBvOh433UmXBQIzkhB7YPv7/Ro7jAu1XDYvS9UdVdSoV
         gURw==
X-Gm-Message-State: AAQBX9cw8PE6+IHr4fdkbAX0r4QVVJP6E9kTSBINrU56+RC3mvZ0JlRk
        1CPos3U/LfJKNeyBoZjI0PtR8PgjZYq7rEn70xQ=
X-Google-Smtp-Source: AKy350brxbsTDKjCTT/ajAFrxPEwoCv3Ui+iRpDOJ+kJUqQcbF3+5/FWXEjIUjIVTFQuMrmr/cdJZ10UqGeWk7atlJI=
X-Received: by 2002:a50:d49e:0:b0:4fc:ebe2:2fc9 with SMTP id
 s30-20020a50d49e000000b004fcebe22fc9mr13616496edi.3.1680285685066; Fri, 31
 Mar 2023 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230330194439.14361-1-mario.limonciello@amd.com> <20230330194439.14361-2-mario.limonciello@amd.com>
In-Reply-To: <20230330194439.14361-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 20:01:14 +0200
Message-ID: <CAJZ5v0jbMXk5k_KG19bQnffhCkGnu=MQXjGrBPipZxA_Cg8O9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PM: Add a sysfs file to represent time spent in
 hardware sleep state
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Userspace can't easily discover how much of a sleep cycle was spent in a
> hardware sleep state without using kernel tracing and vendor specific sysfs
> or debugfs files.
>
> To make this information more discoverable, introduce a new sysfs file
> to represent the time spent in a sleep state.

This is only in the most recent suspend-resume cycle, isn't it?

Wouldn't it be useful to have another attribute printing the
accumulated total HW sleep time?

> This file will be present only if the system supports s2idle.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Provide time in microseconds instead of percent. Userspace can convert
>    this if desirable.
> ---
>  Documentation/ABI/testing/sysfs-power |  9 +++++++++
>  include/linux/suspend.h               |  2 ++
>  kernel/power/main.c                   | 29 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index f99d433ff311..9e0c31b9ce85 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -413,6 +413,15 @@ Description:
>                 The /sys/power/suspend_stats/last_failed_step file contains
>                 the last failed step in the suspend/resume path.
>
> +What:          /sys/power/suspend_stats/last_hw_sleep
> +Date:          June 2023
> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +               The /sys/power/suspend_stats/last_hw_sleep file
> +               contains the duration of time spent in a hardware sleep
> +               state during from the previous suspend cycle. This number

"during from"?

I would say "in the most recent system suspend-resume cycle".

> +               is measured in microseconds.
> +
>  What:          /sys/power/sync_on_suspend
>  Date:          October 2019
>  Contact:       Jonas Meurer <jonas@freesources.org>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cfe19a028918..e0f2ac5f4406 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -68,6 +68,7 @@ struct suspend_stats {
>         int     last_failed_errno;
>         int     errno[REC_FAILED_NUM];
>         int     last_failed_step;
> +       u64     last_hw_sleep;
>         enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>  };
>
> @@ -489,6 +490,7 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern void pm_set_hw_sleep_time(u64 t);
>
>  #define pm_notifier(fn, pri) {                         \
>         static struct notifier_block fn##_nb =                  \
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 31ec4a9b9d70..6a2bf8784ce8 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2003 Open Source Development Lab
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/export.h>
>  #include <linux/kobject.h>
>  #include <linux/string.h>
> @@ -83,6 +84,12 @@ int unregister_pm_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(unregister_pm_notifier);
>
> +void pm_set_hw_sleep_time(u64 t)
> +{
> +       suspend_stats.last_hw_sleep = t;
> +}
> +EXPORT_SYMBOL_GPL(pm_set_hw_sleep_time);
> +
>  int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
>  {
>         int ret;
> @@ -377,6 +384,13 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>
> +static ssize_t last_hw_sleep_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
> +}
> +static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
> +
>  static struct attribute *suspend_attrs[] = {
>         &success.attr,
>         &fail.attr,
> @@ -391,12 +405,27 @@ static struct attribute *suspend_attrs[] = {
>         &last_failed_dev.attr,
>         &last_failed_errno.attr,
>         &last_failed_step.attr,
> +       &last_hw_sleep.attr,
>         NULL,
>  };
>
> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +       if (attr == &last_hw_sleep.attr) {
> +#ifdef CONFIG_ACPI
> +               if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> +                       return 0444;
> +#endif
> +               return 0;
> +       }
> +
> +       return 0444;

if (attr != &last_hw_sleep.attr)
        return 0444;

#ifdef CONFIG_ACPI
if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
        return 0444;
#endif

return 0;

> +}
> +
>  static const struct attribute_group suspend_attr_group = {
>         .name = "suspend_stats",
>         .attrs = suspend_attrs,
> +       .is_visible = suspend_attr_is_visible,
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> --
