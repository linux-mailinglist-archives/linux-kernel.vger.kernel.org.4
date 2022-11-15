Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BC62A33E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKOUof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiKOUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:44:27 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A079205FA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:44:26 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id i2so11496776vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fki+0TCoTrte3/BJmTglaCbQEGDgk5B9kayNvnzRPWM=;
        b=Q+lW7U/1515XSKweAMw5eX05XaxUGZTKGcd7QsyfGV2BIVZ4vO6qOo11M9Bddjyytv
         DDMWMCivk2+y76oMjBHBSQY+HCarazuvA/bDaWBvlCpuPgBu0JOWsyEeHaZhNQHuBJo7
         Hvvh2Ow2EfGNHbJVM3I0K9wIbuiRYtl+5vKvUEA3VjNprdirOnD5UCchWEm1zfcR4U+6
         DuB+MotSK2WwN6SB3IjLk3AuQHc1sb7c4FnPUax24E9fyf75hTVceol07USJCGppACm+
         AjJKpvCwJUjosvIouvjLNOlPczSbirv331O5CJLTyrLn371E5IS1QZKMs9IfyhMR0XGi
         uNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fki+0TCoTrte3/BJmTglaCbQEGDgk5B9kayNvnzRPWM=;
        b=R1IoeG1mMveyk1hCS16O6YK1vKyv5UCYKWiJ+xq6o7cwxmEoiosnDBrmHNnvAJoFIC
         LfC5rJsCC/qCfrd6X2z9WilkLr6dmeOfUZ51aTqXm9pNjo0lEpYdo+ond7Npgxd9qUy4
         dyNhtUFzLuWiFDSjojFgBSAChLQkqo41gGMhq+05ES3aZ1TixmY7JC8T92m4HgL91mrO
         h+xpz/3lrSuj+zx6weR6Y96DqsaUfqxc0ttOoGzoj4ADu/xPy0w7zBdKHhQFFQCkFS9q
         Vz3t+GrDu/wDze0/aJkiCepdXqeE+/zb2as/wafEVh5o8ZBO/CIQ9uEZglgYoewMySsi
         mqyw==
X-Gm-Message-State: ANoB5pnp9oNBHTkSOcNPZX+C/k9mYQmj/5FoSABfeGxOUFsglwS99ZsQ
        u3xH+DW0NRaQ0KDtfSgGwid3A+XKOgZovU5Q+RVo
X-Google-Smtp-Source: AA0mqf49L62DSbkOhy5QdhSFkosUgoRxnZccam6+NPCc0pWQN1kIdQqfHb6qw+qOMl9/YLMbHuvo2aGXdUCt3JVCiug=
X-Received: by 2002:a05:6102:3224:b0:3aa:8846:b9a with SMTP id
 x4-20020a056102322400b003aa88460b9amr9477748vsf.58.1668545065335; Tue, 15 Nov
 2022 12:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20221115200156.12218-1-mario.limonciello@amd.com> <20221115200156.12218-2-mario.limonciello@amd.com>
In-Reply-To: <20221115200156.12218-2-mario.limonciello@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 15 Nov 2022 12:44:14 -0800
Message-ID: <CANDhNCqPWV_dC_wo-CCqBuO0J=5TcRAh5AX335PLft2+w19_tQ@mail.gmail.com>
Subject: Re: [RFC v3 1/4] PM: Add a sysfs file to represent the total sleep duration
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:02 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> For userspace to be able to analyze how much of a suspend cycle was spent
> in the hardware sleep states userspace software has to use kernel trace
> points paired with the file `low_power_idle_system_residency_us` on
> supported systems.
>
> To make this information more discoverable, introduce a new sysfs file
> to represent the duration spent in a sleep state.
> This file will be present and updated during resume for all suspend
> types.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> RFC v2->v3
>  * Drop one of the sysfs files
>  * Use sysfs_emit instead
>  * Fix symbol name (s/type/time/)
>  * Drop is_visible
>  * Use timespec64 type for suspend stats
>  * Update documentation
>  * Update sysfs file name
> ---
>  Documentation/ABI/testing/sysfs-power |  8 ++++++++
>  include/linux/suspend.h               |  2 ++
>  kernel/power/main.c                   | 15 +++++++++++++++
>  kernel/power/suspend.c                |  2 ++
>  kernel/time/timekeeping.c             |  2 ++
>  5 files changed, 29 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index f99d433ff311..3abe20c47e08 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -413,6 +413,14 @@ Description:
>                 The /sys/power/suspend_stats/last_failed_step file contains
>                 the last failed step in the suspend/resume path.
>
> +What:          /sys/power/suspend_stats/last_total
> +Date:          December 2022
> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +               The /sys/power/suspend_stats/last_total file contains
> +               the total duration of the sleep cycle.
> +               This is measured in microseconds.
> +

Nit/bikeshed: "last_total" seems less straightforward then it should
be? Maybe "total_suspend_time" instead?

> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 31ec4a9b9d70..f33012860699 100644
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
> @@ -54,6 +55,11 @@ void unlock_system_sleep(unsigned int flags)
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
>
> +void pm_account_suspend_time(const struct timespec64 t)
> +{
> +       suspend_stats.last_total = timespec64_add(suspend_stats.last_total, t);
> +}
> +
>  void ksys_sync_helper(void)
>  {
>         ktime_t start;
> @@ -377,6 +383,14 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>
> +static ssize_t last_total_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%llu\n",
> +                         timespec64_to_ns(&suspend_stats.last_total) / NSEC_PER_USEC);
> +}
> +static struct kobj_attribute last_total = __ATTR_RO(last_total);
> +
>  static struct attribute *suspend_attrs[] = {
>         &success.attr,
>         &fail.attr,
> @@ -391,6 +405,7 @@ static struct attribute *suspend_attrs[] = {
>         &last_failed_dev.attr,
>         &last_failed_errno.attr,
>         &last_failed_step.attr,
> +       &last_total.attr,
>         NULL,
>  };

While not identical, this has some overlap with the logic in
kernel/time/timekeeping_debug.c
I wonder if it would make sense to consolidate some of this accounting?

thanks
-john
