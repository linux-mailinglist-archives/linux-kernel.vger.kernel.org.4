Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0F629C82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiKOOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKOOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:46:13 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549771136;
        Tue, 15 Nov 2022 06:46:11 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id r2so7473542ilg.8;
        Tue, 15 Nov 2022 06:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPibUbyRD8E0Sr9UpaapCyLEtpD2/vpkhppwHqljR88=;
        b=W3t52/lqky/muzDWZbxxP3cCdAHYtfb9SiVkd/0mBA2D4r/WO5nXXKxe5dK6CuSd0r
         qL7BZ4F9gcyOZF6DgVInfy34OLcUeiCVqbbOqr4eNB5GumHTO6z+1khTErU2/oNNPGdm
         mQ8VMp+YUib9Bs34RZ3dKpLhzpYg5r7CsIj+v2TN+H6BL5cZDL/b/WRVHUvsFMFHRUmH
         WjESbC2VO9aTt2xUMXg7TFcyNpKUC8edkRJH6u0YbaQacF/sDt1tCsAQlo8XcP3dI8qI
         uQYH8f7rCHjtQN/FC+AU59bihOrvq9fqGAusNyyrcB0uL3+yHnMLysK1jeekzKOV8S8Z
         4/8Q==
X-Gm-Message-State: ANoB5plNhNolrtdeC7KD4H0cg3JV8OlR4qovUqWQIGaecz0904xCS2sS
        X93xkEcDZlYFHUsba/hfWtxb2FWZj2aWKkEICLY=
X-Google-Smtp-Source: AA0mqf40hNEyGUhxX5z/spo7WgjmpbQN3OydBI2WjOcJjaI4G+0Ura7+b67ALOqbiJo3jgF+8Wg8g1VCR6fdVsbhY7E=
X-Received: by 2002:a92:c907:0:b0:300:f44c:bfeb with SMTP id
 t7-20020a92c907000000b00300f44cbfebmr8294851ilp.106.1668523570539; Tue, 15
 Nov 2022 06:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20221110064723.8882-1-mario.limonciello@amd.com> <20221110064723.8882-2-mario.limonciello@amd.com>
In-Reply-To: <20221110064723.8882-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Nov 2022 15:45:58 +0100
Message-ID: <CAJZ5v0iwpSkd_8CS1dq6+rkszeKGygBbeifvugAEEKqA0w1s7w@mail.gmail.com>
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 7:49 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Both AMD and Intel SoCs have a concept of reporting whether the hardware
> reached a hardware sleep state over s2idle as well as how much
> time was spent in such a state.
>
> This information is valuable to both chip designers and system designers
> as it helps to identify when there are problems with power consumption
> over an s2idle cycle.
>
> To make the information discoverable, create a new sysfs file and a symbol
> that drivers from supported manufacturers can use to advertise this
> information. This file will only be exported when the system supports low
> power idle in the ACPI table.
>
> In order to effectively use this information you will ideally want to
> compare against the total duration of sleep, so export a second sysfs file
> that will show total time. This file will be exported on all systems and
> used both for s2idle and s3.

Well, my first question would be how this is related to

/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us

and

/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us

> Suggested-by: David E Box <david.e.box@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-power | 17 +++++++++++
>  include/linux/suspend.h               |  4 +++
>  kernel/power/main.c                   | 42 +++++++++++++++++++++++++++
>  kernel/power/suspend.c                |  2 ++
>  kernel/time/timekeeping.c             |  2 ++
>  5 files changed, 67 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index f99d433ff311..5b47cbb4dc9e 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -413,6 +413,23 @@ Description:
>                 The /sys/power/suspend_stats/last_failed_step file contains
>                 the last failed step in the suspend/resume path.
>
> +What:          /sys/power/suspend_stats/last_hw_state_residency
> +Date:          December 2022
> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +               The /sys/power/suspend_stats/last_hw_state_residency file contains
> +               the amount of time spent in a hardware sleep state.
> +               This attribute is only available if the system supports
> +               low power idle.  This is measured in microseconds.
> +
> +What:          /sys/power/suspend_stats/last_suspend_total
> +Date:          December 2022
> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +               The /sys/power/suspend_stats/last_suspend_total file contains
> +               the total duration of the sleep cycle.
> +               This is measured in microseconds.
> +
>  What:          /sys/power/sync_on_suspend
>  Date:          October 2019
>  Contact:       Jonas Meurer <jonas@freesources.org>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cfe19a028918..af343c3f8198 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -68,6 +68,8 @@ struct suspend_stats {
>         int     last_failed_errno;
>         int     errno[REC_FAILED_NUM];
>         int     last_failed_step;
> +       u64     last_hw_state_residency;
> +       u64     last_suspend_total;
>         enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>  };
>
> @@ -489,6 +491,8 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern void pm_set_hw_state_residency(u64 duration);
> +extern void pm_account_suspend_type(const struct timespec64 *t);
>
>  #define pm_notifier(fn, pri) {                         \
>         static struct notifier_block fn##_nb =                  \
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 31ec4a9b9d70..11bd658583b0 100644
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
> @@ -54,6 +55,19 @@ void unlock_system_sleep(unsigned int flags)
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
>
> +void pm_set_hw_state_residency(u64 duration)
> +{
> +       suspend_stats.last_hw_state_residency = duration;
> +}
> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
> +
> +void pm_account_suspend_type(const struct timespec64 *t)
> +{
> +       suspend_stats.last_suspend_total += (s64)t->tv_sec * USEC_PER_SEC +
> +                                                t->tv_nsec / NSEC_PER_USEC;
> +}
> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
> +
>  void ksys_sync_helper(void)
>  {
>         ktime_t start;
> @@ -377,6 +391,20 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>
> +static ssize_t last_hw_state_residency_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%llu\n", suspend_stats.last_hw_state_residency);
> +}
> +static struct kobj_attribute last_hw_state_residency = __ATTR_RO(last_hw_state_residency);
> +
> +static ssize_t last_suspend_total_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%llu\n", suspend_stats.last_suspend_total);
> +}
> +static struct kobj_attribute last_suspend_total = __ATTR_RO(last_suspend_total);
> +
>  static struct attribute *suspend_attrs[] = {
>         &success.attr,
>         &fail.attr,
> @@ -391,12 +419,26 @@ static struct attribute *suspend_attrs[] = {
>         &last_failed_dev.attr,
>         &last_failed_errno.attr,
>         &last_failed_step.attr,
> +       &last_hw_state_residency.attr,
> +       &last_suspend_total.attr,
>         NULL,
>  };
>
> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +       if (attr != &last_hw_state_residency.attr)
> +               return 0444;
> +#ifdef CONFIG_ACPI
> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> +               return 0444;
> +#endif
> +       return 0;
> +}
> +
>  static const struct attribute_group suspend_attr_group = {
>         .name = "suspend_stats",
>         .attrs = suspend_attrs,
> +       .is_visible = suspend_attr_is_visible,
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index fa3bf161d13f..b6c4a3733212 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -423,6 +423,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>         if (suspend_test(TEST_PLATFORM))
>                 goto Platform_wake;
>
> +       suspend_stats.last_suspend_total = 0;
> +
>         if (state == PM_SUSPEND_TO_IDLE) {
>                 s2idle_loop();
>                 goto Platform_wake;
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index f72b9f1de178..e1b356787e53 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -24,6 +24,7 @@
>  #include <linux/compiler.h>
>  #include <linux/audit.h>
>  #include <linux/random.h>
> +#include <linux/suspend.h>
>
>  #include "tick-internal.h"
>  #include "ntp_internal.h"
> @@ -1698,6 +1699,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>         tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
>         tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
>         tk_debug_account_sleep_time(delta);
> +       pm_account_suspend_type(delta);
>  }
>
>  #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
> --
> 2.34.1
>
