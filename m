Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E306B62A0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKORxE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 12:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiKORxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:53:01 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD88E12;
        Tue, 15 Nov 2022 09:52:59 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id l2so9188979qtq.11;
        Tue, 15 Nov 2022 09:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muMc7CbTJu6jHHGM+CaKZtSCR1f+dMagxKkifG2lh0A=;
        b=fOQbg10j+xagOG8iHOW3EZcJ525uB3hiXPzwNbDXbFS5lNZoa9my6gayPsDZXScMYp
         xJh/hyWmv42NjdcnLngSA1QzuU1fB+w4MmaAEGzpalwUyg58pE6v7tE4del5n6V+E2B7
         TPfBw3eFwDbJ89WyGQuxlEdrHvS8nyE1/DSff4OXR7PWMxTVT1JiIdCMb0Txt9rJ7PYT
         FZVnVy1G8O0bl/Zk9FlE8WvOWqW0TjWPT0rU/LqQ8W2/RNpyBtEPs1x3W//0i89HLnW9
         3/7SIb0UIvAd4++rejy+4jSJUOUz4DjS5dH2i5V8203R16gG2Dxtr20CWCPMJgw7cGrc
         s1fw==
X-Gm-Message-State: ANoB5pnApTcHWcFZksnf/Hf9qajGXBsuV1qMIKwhRwa55JEBmKdC72Zk
        HJMh5tCPXtPlrNjOdD2/qNUh+b98HU7yH4pb+bk=
X-Google-Smtp-Source: AA0mqf42Jnke7GUCpdg1g5IJRCh06ak7VmPXSJsFN8sWjqZ7ysqO4QhQwO7d+IuC2GQhoju4ltLmw4fT0zLG8fB6OxI=
X-Received: by 2002:ac8:758b:0:b0:3a5:a53d:a102 with SMTP id
 s11-20020ac8758b000000b003a5a53da102mr17551608qtq.153.1668534778539; Tue, 15
 Nov 2022 09:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com> <CAJZ5v0iwpSkd_8CS1dq6+rkszeKGygBbeifvugAEEKqA0w1s7w@mail.gmail.com>
 <460b23ee-16ed-f1e3-0e14-35051c908671@amd.com> <CAJZ5v0id3atXfu1OAsr4kWNwYgyMVo90u9Lu2j4ZNFWQX+QX0g@mail.gmail.com>
 <CAHQZ30BCXtyJ9qqHHX5eztXbgA_A8yH48+AQVMCB64CXjqE+hQ@mail.gmail.com> <bb86ba1f-c0cd-ae71-520c-b94d4d71b261@amd.com>
In-Reply-To: <bb86ba1f-c0cd-ae71-520c-b94d4d71b261@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Nov 2022 18:52:44 +0100
Message-ID: <CAJZ5v0hj1yc8JZTD+_WfG0FZPPne41uw1RLj06FECzgSZSNuHw@mail.gmail.com>
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Raul Rangel <rrangel@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 6:27 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 11/15/2022 11:20, Raul Rangel wrote:
> >
> >
> > On Tue, Nov 15, 2022 at 9:35 AM Rafael J. Wysocki <rafael@kernel.org
> > <mailto:rafael@kernel.org>> wrote:
> >
> >     On Tue, Nov 15, 2022 at 4:17 PM Limonciello, Mario
> >     <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
> >      >
> >      > On 11/15/2022 08:45, Rafael J. Wysocki wrote:
> >      > > On Thu, Nov 10, 2022 at 7:49 AM Mario Limonciello
> >      > > <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>>
> >     wrote:
> >      > >>
> >      > >> Both AMD and Intel SoCs have a concept of reporting whether
> >     the hardware
> >      > >> reached a hardware sleep state over s2idle as well as how much
> >      > >> time was spent in such a state.
> >      > >>
> >      > >> This information is valuable to both chip designers and system
> >     designers
> >      > >> as it helps to identify when there are problems with power
> >     consumption
> >      > >> over an s2idle cycle.
> >      > >>
> >      > >> To make the information discoverable, create a new sysfs file
> >     and a symbol
> >      > >> that drivers from supported manufacturers can use to advertise
> >     this
> >      > >> information. This file will only be exported when the system
> >     supports low
> >      > >> power idle in the ACPI table.
> >      > >>
> >      > >> In order to effectively use this information you will ideally
> >     want to
> >      > >> compare against the total duration of sleep, so export a
> >     second sysfs file
> >      > >> that will show total time. This file will be exported on all
> >     systems and
> >      > >> used both for s2idle and s3.
> >      > >
> >      > > Well, my first question would be how this is related to
> >      > >
> >      > > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> >      > >
> >      >
> >      > This has a dependency on the platform firmware offering an ACPI LPIT
> >      > table.  I don't know how common that is.
> >
> >     Required for running Windows with Modern Standby AFAICS.
> >
> >      > As this series started from the needs on ChromeOS I would ask is
> >     that typically populated by coreboot?
> >
> >     It should be, but I'd need to ask for confirmation.
> >
> >
> > It looks like Intel platforms have support for the LPIT table:
> > https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/coreboot/src/soc/intel/common/block/acpi/lpit.c?q=f:LPIT%20f:coreboot&ss=chromiumos <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.chromium.org%2Fchromiumos%2Fchromiumos%2Fcodesearch%2F%2B%2Fmain%3Asrc%2Fthird_party%2Fcoreboot%2Fsrc%2Fsoc%2Fintel%2Fcommon%2Fblock%2Facpi%2Flpit.c%3Fq%3Df%3ALPIT%2520f%3Acoreboot%26ss%3Dchromiumos&data=05%7C01%7Cmario.limonciello%40amd.com%7C701602845ad14f37abbb08dac72db514%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041296400209575%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=9ig2jlDevXMjzmTUf42WS5Ey3rLd2lDUXjncz3mbyMI%3D&reserved=0>
> >
> > For AMD, we had some patches to add _LPIL
> > https://review.coreboot.org/c/coreboot/+/52381/1
> > <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F52381%2F1&data=05%7C01%7Cmario.limonciello%40amd.com%7C701602845ad14f37abbb08dac72db514%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041296400209575%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=KV6ASbdfNOex%2FZtJYcdItZU1gdjCIXEcP1ExiY0pkf8%3D&reserved=0>
> > They never got merged though. We could add an LPIT table to coreboot for
> > AMD platforms if necessary.
>
> _LPI I don't think makes a lot of sense on X86 today, which is why this
> was sent up:
> eb087f305919e ("ACPI: processor idle: Check for architectural support
> for LPI")

Well, LPI has nothing to do with LPIT.  [I guess this could not be
even more confusing, but that's what you get in the world of 4-letter
TLAs.]

> As for LPIT - I've never seen LPIT on AMD UEFI systems either.  I guess
> it's an Intel specific table?

It used to be.  The spec is UEFI-hosted now.

> >
> >      > I would hope it's the same number that is populated in that file on
> >      > supported systems though.
> >
> >     Well, which is exactly where I'm going.
> >
> >     Since there is one sysfs file for exposing this value already and it
> >     is used (for example, by sleepgraph), perhaps the way to go would be
> >     to extend this interface to systems that don't have LPIT instead of
> >     introducing a new one possibly exposing the same value?
> >
>
> Ah; so since Raul confirmed coreboot on Chrome exports that maybe we
> just need to add another way to populate that sysfs file for systems
> without LPIT (IE AMD).  I think that's a very good idea; thanks.
>
> I think we still probably want to have a way to get the total suspend
> time out programmatically though to compare to.  So perhaps the other
> sysfs file I had in the RFC v2 makes sense still.

Well there are trace points to get that (sleepgraph uses these too),
see Documentation/trace/events-power.rst (and you can git grep for
"machine_suspend" to find where this comes from).

I guess there could be a sysfs file in addition to them, but I'm not
sure if the extra overhead would be worth the benefit.

> >      > > and
> >      > >
> >      > > /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> >      > >
> >      >
> >      > No relation to this one for what's in the series.
> >      >
> >      > >> Suggested-by: David E Box <david.e.box@intel.com
> >     <mailto:david.e.box@intel.com>>
> >      > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com
> >     <mailto:mario.limonciello@amd.com>>
> >      > >> ---
> >      > >>   Documentation/ABI/testing/sysfs-power | 17 +++++++++++
> >      > >>   include/linux/suspend.h               |  4 +++
> >      > >>   kernel/power/main.c                   | 42
> >     +++++++++++++++++++++++++++
> >      > >>   kernel/power/suspend.c                |  2 ++
> >      > >>   kernel/time/timekeeping.c             |  2 ++
> >      > >>   5 files changed, 67 insertions(+)
> >      > >>
> >      > >> diff --git a/Documentation/ABI/testing/sysfs-power
> >     b/Documentation/ABI/testing/sysfs-power
> >      > >> index f99d433ff311..5b47cbb4dc9e 100644
> >      > >> --- a/Documentation/ABI/testing/sysfs-power
> >      > >> +++ b/Documentation/ABI/testing/sysfs-power
> >      > >> @@ -413,6 +413,23 @@ Description:
> >      > >>                  The /sys/power/suspend_stats/last_failed_step
> >     file contains
> >      > >>                  the last failed step in the suspend/resume path.
> >      > >>
> >      > >> +What:          /sys/power/suspend_stats/last_hw_state_residency
> >      > >> +Date:          December 2022
> >      > >> +Contact:       Mario Limonciello <mario.limonciello@amd.com
> >     <mailto:mario.limonciello@amd.com>>
> >      > >> +Description:
> >      > >> +               The
> >     /sys/power/suspend_stats/last_hw_state_residency file contains
> >      > >> +               the amount of time spent in a hardware sleep
> >     state.
> >      > >> +               This attribute is only available if the system
> >     supports
> >      > >> +               low power idle.  This is measured in microseconds.
> >      > >> +
> >      > >> +What:          /sys/power/suspend_stats/last_suspend_total
> >      > >> +Date:          December 2022
> >      > >> +Contact:       Mario Limonciello <mario.limonciello@amd.com
> >     <mailto:mario.limonciello@amd.com>>
> >      > >> +Description:
> >      > >> +               The
> >     /sys/power/suspend_stats/last_suspend_total file contains
> >      > >> +               the total duration of the sleep cycle.
> >      > >> +               This is measured in microseconds.
> >      > >> +
> >      > >>   What:          /sys/power/sync_on_suspend
> >      > >>   Date:          October 2019
> >      > >>   Contact:       Jonas Meurer <jonas@freesources.org
> >     <mailto:jonas@freesources.org>>
> >      > >> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> >      > >> index cfe19a028918..af343c3f8198 100644
> >      > >> --- a/include/linux/suspend.h
> >      > >> +++ b/include/linux/suspend.h
> >      > >> @@ -68,6 +68,8 @@ struct suspend_stats {
> >      > >>          int     last_failed_errno;
> >      > >>          int     errno[REC_FAILED_NUM];
> >      > >>          int     last_failed_step;
> >      > >> +       u64     last_hw_state_residency;
> >      > >> +       u64     last_suspend_total;
> >      > >>          enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
> >      > >>   };
> >      > >>
> >      > >> @@ -489,6 +491,8 @@ void restore_processor_state(void);
> >      > >>   extern int register_pm_notifier(struct notifier_block *nb);
> >      > >>   extern int unregister_pm_notifier(struct notifier_block *nb);
> >      > >>   extern void ksys_sync_helper(void);
> >      > >> +extern void pm_set_hw_state_residency(u64 duration);
> >      > >> +extern void pm_account_suspend_type(const struct timespec64 *t);
> >      > >>
> >      > >>   #define pm_notifier(fn, pri) {                         \
> >      > >>          static struct notifier_block fn##_nb =                  \
> >      > >> diff --git a/kernel/power/main.c b/kernel/power/main.c
> >      > >> index 31ec4a9b9d70..11bd658583b0 100644
> >      > >> --- a/kernel/power/main.c
> >      > >> +++ b/kernel/power/main.c
> >      > >> @@ -6,6 +6,7 @@
> >      > >>    * Copyright (c) 2003 Open Source Development Lab
> >      > >>    */
> >      > >>
> >      > >> +#include <linux/acpi.h>
> >      > >>   #include <linux/export.h>
> >      > >>   #include <linux/kobject.h>
> >      > >>   #include <linux/string.h>
> >      > >> @@ -54,6 +55,19 @@ void unlock_system_sleep(unsigned int flags)
> >      > >>   }
> >      > >>   EXPORT_SYMBOL_GPL(unlock_system_sleep);
> >      > >>
> >      > >> +void pm_set_hw_state_residency(u64 duration)
> >      > >> +{
> >      > >> +       suspend_stats.last_hw_state_residency = duration;
> >      > >> +}
> >      > >> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
> >      > >> +
> >      > >> +void pm_account_suspend_type(const struct timespec64 *t)
> >      > >> +{
> >      > >> +       suspend_stats.last_suspend_total += (s64)t->tv_sec *
> >     USEC_PER_SEC +
> >      > >> +                                                t->tv_nsec /
> >     NSEC_PER_USEC;
> >      > >> +}
> >      > >> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
> >      > >> +
> >      > >>   void ksys_sync_helper(void)
> >      > >>   {
> >      > >>          ktime_t start;
> >      > >> @@ -377,6 +391,20 @@ static ssize_t
> >     last_failed_step_show(struct kobject *kobj,
> >      > >>   }
> >      > >>   static struct kobj_attribute last_failed_step =
> >     __ATTR_RO(last_failed_step);
> >      > >>
> >      > >> +static ssize_t last_hw_state_residency_show(struct kobject *kobj,
> >      > >> +               struct kobj_attribute *attr, char *buf)
> >      > >> +{
> >      > >> +       return sprintf(buf, "%llu\n",
> >     suspend_stats.last_hw_state_residency);
> >      > >> +}
> >      > >> +static struct kobj_attribute last_hw_state_residency =
> >     __ATTR_RO(last_hw_state_residency);
> >      > >> +
> >      > >> +static ssize_t last_suspend_total_show(struct kobject *kobj,
> >      > >> +               struct kobj_attribute *attr, char *buf)
> >      > >> +{
> >      > >> +       return sprintf(buf, "%llu\n",
> >     suspend_stats.last_suspend_total);
> >      > >> +}
> >      > >> +static struct kobj_attribute last_suspend_total =
> >     __ATTR_RO(last_suspend_total);
> >      > >> +
> >      > >>   static struct attribute *suspend_attrs[] = {
> >      > >>          &success.attr,
> >      > >>          &fail.attr,
> >      > >> @@ -391,12 +419,26 @@ static struct attribute *suspend_attrs[] = {
> >      > >>          &last_failed_dev.attr,
> >      > >>          &last_failed_errno.attr,
> >      > >>          &last_failed_step.attr,
> >      > >> +       &last_hw_state_residency.attr,
> >      > >> +       &last_suspend_total.attr,
> >      > >>          NULL,
> >      > >>   };
> >      > >>
> >      > >> +static umode_t suspend_attr_is_visible(struct kobject *kobj,
> >     struct attribute *attr, int idx)
> >      > >> +{
> >      > >> +       if (attr != &last_hw_state_residency.attr)
> >      > >> +               return 0444;
> >      > >> +#ifdef CONFIG_ACPI
> >      > >> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> >      > >> +               return 0444;
> >      > >> +#endif
> >      > >> +       return 0;
> >      > >> +}
> >      > >> +
> >      > >>   static const struct attribute_group suspend_attr_group = {
> >      > >>          .name = "suspend_stats",
> >      > >>          .attrs = suspend_attrs,
> >      > >> +       .is_visible = suspend_attr_is_visible,
> >      > >>   };
> >      > >>
> >      > >>   #ifdef CONFIG_DEBUG_FS
> >      > >> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> >      > >> index fa3bf161d13f..b6c4a3733212 100644
> >      > >> --- a/kernel/power/suspend.c
> >      > >> +++ b/kernel/power/suspend.c
> >      > >> @@ -423,6 +423,8 @@ static int suspend_enter(suspend_state_t
> >     state, bool *wakeup)
> >      > >>          if (suspend_test(TEST_PLATFORM))
> >      > >>                  goto Platform_wake;
> >      > >>
> >      > >> +       suspend_stats.last_suspend_total = 0;
> >      > >> +
> >      > >>          if (state == PM_SUSPEND_TO_IDLE) {
> >      > >>                  s2idle_loop();
> >      > >>                  goto Platform_wake;
> >      > >> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> >      > >> index f72b9f1de178..e1b356787e53 100644
> >      > >> --- a/kernel/time/timekeeping.c
> >      > >> +++ b/kernel/time/timekeeping.c
> >      > >> @@ -24,6 +24,7 @@
> >      > >>   #include <linux/compiler.h>
> >      > >>   #include <linux/audit.h>
> >      > >>   #include <linux/random.h>
> >      > >> +#include <linux/suspend.h>
> >      > >>
> >      > >>   #include "tick-internal.h"
> >      > >>   #include "ntp_internal.h"
> >      > >> @@ -1698,6 +1699,7 @@ static void
> >     __timekeeping_inject_sleeptime(struct timekeeper *tk,
> >      > >>          tk_set_wall_to_mono(tk,
> >     timespec64_sub(tk->wall_to_monotonic, *delta));
> >      > >>          tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
> >      > >>          tk_debug_account_sleep_time(delta);
> >      > >> +       pm_account_suspend_type(delta);
> >      > >>   }
> >      > >>
> >      > >>   #if defined(CONFIG_PM_SLEEP) &&
> >     defined(CONFIG_RTC_HCTOSYS_DEVICE)
> >      > >> --
> >      > >> 2.34.1
> >      > >>
> >      >
> >
>
