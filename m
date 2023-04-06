Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCB6D970B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjDFMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjDFMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A07A8D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680784223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xD7hj7hSemwYY6sHaFv6k5ztDu5BI61myixhJCprZ0M=;
        b=YFMQQ1RSXBhe81oIUfOT5rx74q7IoZLfuuwHpa9X0EaJWnDkSqQ57XL/KYEOiIV5jaxuAK
        IwVnR2dYo7Qos2SO4jVP0coxK0G1peEBJrayNADrs708PltO9DKZXAMXlboFrZHegh51E+
        /Q1k1Sml2B4si6Fdj11pgONqy+uYF28=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Z08hOWFqOReXugySznLatA-1; Thu, 06 Apr 2023 08:30:19 -0400
X-MC-Unique: Z08hOWFqOReXugySznLatA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5029d37b3a6so868014a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 05:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680784218; x=1683376218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xD7hj7hSemwYY6sHaFv6k5ztDu5BI61myixhJCprZ0M=;
        b=LOLIo6R860GiRtP/3rHTwkbziZOn0BnbnbbPcMb/BuimA6H86no/a39OUbFIzJh9Ao
         u7ovRWERg/ysKGNgHTy5MMVnAE9Rt5vfrzmvsImIath4+29y7BAA+FNk9hvDVqzQ6mw7
         lzTA5fcftV9MpfgnbkFcJKFKvfKEV2jWuf9M033MD5vTuSOebjGTRGA4060i5S5i1Wqt
         OFGyd1Ega72dk4VW+LOF1vUHfs02sDi9GhWV/arI7eo/GNSpQSqIDs+f7mDu4rMnAgci
         4e/JVgHB9b7LwsqGToEI+3MtkXOBi9aY+1lOVYsao5WwDUR38xLQGm9krU8yJh1/rxEa
         Wl/A==
X-Gm-Message-State: AAQBX9eIzL0s02iDoxnE8kDfCyUmp7nnnLSPplTA/MHqrZf59R5zi7he
        GKsIfqpr0mD3e14KrdPOaEmwDRTSjcVLo6S81Zw6DIdjA7Oga9uKSxKuI/QNDqI2KhBbGOo7bNX
        VugvBOL2TgSa65Mb+/vrVRkiU
X-Received: by 2002:aa7:d5c5:0:b0:504:6646:79c4 with SMTP id d5-20020aa7d5c5000000b00504664679c4mr1265157eds.36.1680784218400;
        Thu, 06 Apr 2023 05:30:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350bY3wYpTv7liGIGAM0M8n4OqySssmNVXXhHnh41GtzcXrfJ0LqFvmAqIy5PFOwgu5pkxb+cmQ==
X-Received: by 2002:aa7:d5c5:0:b0:504:6646:79c4 with SMTP id d5-20020aa7d5c5000000b00504664679c4mr1265140eds.36.1680784218122;
        Thu, 06 Apr 2023 05:30:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 2-20020a508742000000b004f9e6495f94sm697222edv.50.2023.04.06.05.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:30:17 -0700 (PDT)
Message-ID: <8609778b-7bbe-fb05-7317-d88f15daba6b@redhat.com>
Date:   Thu, 6 Apr 2023 14:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Content-Language: en-US, nl
To:     "Box, David E" <david.e.box@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
 <20230403211831.4010-2-mario.limonciello@amd.com>
 <b6000a3d5d4d6a3e9f8a57414c0b795e8cff6855.camel@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b6000a3d5d4d6a3e9f8a57414c0b795e8cff6855.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/5/23 02:42, Box, David E wrote:
> Hi Mario,
> 
> On Mon, 2023-04-03 at 16:18 -0500, Mario Limonciello wrote:
>> Userspace can't easily discover how much of a sleep cycle was spent in a
>> hardware sleep state without using kernel tracing and vendor specific sysfs
>> or debugfs files.
>>
>> To make this information more discoverable, introduce two new sysfs files:
>> 1) The time spent in a hw sleep state for last cycle.
>> 2) The time spent in a hw sleep state since the kernel booted
>> Both of these files will be present only if the system supports s2idle.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v5->v6:
>>  * Add total attribute as well
>>  * Change text for documentation
>>  * Adjust flow of is_visible callback.
>>  * If overflow was detected in total attribute return -EOVERFLOW
>>  * Rename symbol
>>  * Add stub for symbol for builds without CONFIG_PM_SLEEP
>> v4->v5:
>>  * Provide time in microseconds instead of percent. Userspace can convert
>>    this if desirable.
>> ---
>>  Documentation/ABI/testing/sysfs-power | 27 ++++++++++++++++
>>  include/linux/suspend.h               |  5 +++
>>  kernel/power/main.c                   | 45 +++++++++++++++++++++++++++
>>  3 files changed, 77 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-power
>> b/Documentation/ABI/testing/sysfs-power
>> index f99d433ff311..37240575d282 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -413,6 +413,33 @@ Description:
>>                 The /sys/power/suspend_stats/last_failed_step file contains
>>                 the last failed step in the suspend/resume path.
>>  
>> +What:          /sys/power/suspend_stats/last_hw_sleep
>> +Date:          June 2023
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:
>> +               The /sys/power/suspend_stats/last_hw_sleep file
>> +               contains the duration of time spent in a hardware sleep
>> +               state in the most recent system suspend-resume cycle.
>> +               This number is measured in microseconds.
>> +
>> +               NOTE: Limitations in the size of the hardware counters may
>> +               cause this value to be inaccurate in longer sleep cycles.
>> +
>> +What:          /sys/power/suspend_stats/total_hw_sleep
>> +Date:          June 2023
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:
>> +               The /sys/power/suspend_stats/total_hw_sleep file
>> +               contains the aggregate of time spent in a hardware sleep
>> +               state since the kernel was booted. This number
>> +               is measured in microseconds.
>> +
>> +               NOTE: Limitations in the size of the hardware counters may
>> +               cause this value to be inaccurate in longer sleep cycles.
>> +
>> +               If an overflow has been detected this file will return
>> +               -EOVERFLOW.
>> +
>>  What:          /sys/power/sync_on_suspend
>>  Date:          October 2019
>>  Contact:       Jonas Meurer <jonas@freesources.org>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index cfe19a028918..069ef0c0ae57 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -68,6 +68,8 @@ struct suspend_stats {
>>         int     last_failed_errno;
>>         int     errno[REC_FAILED_NUM];
>>         int     last_failed_step;
>> +       u64     last_hw_sleep;
>> +       u64     total_hw_sleep;
>>         enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>>  };
>>  
>> @@ -489,6 +491,7 @@ void restore_processor_state(void);
>>  extern int register_pm_notifier(struct notifier_block *nb);
>>  extern int unregister_pm_notifier(struct notifier_block *nb);
>>  extern void ksys_sync_helper(void);
>> +extern void pm_report_hw_sleep_time(u64 t);
>>  
>>  #define pm_notifier(fn, pri) {                         \
>>         static struct notifier_block fn##_nb =                  \
>> @@ -526,6 +529,8 @@ static inline int unregister_pm_notifier(struct
>> notifier_block *nb)
>>         return 0;
>>  }
>>  
>> +static inline void pm_report_hw_sleep_time(u64 t) {};
>> +
>>  static inline void ksys_sync_helper(void) {}
>>  
>>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 31ec4a9b9d70..ffd4dd43cbdd 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -6,6 +6,7 @@
>>   * Copyright (c) 2003 Open Source Development Lab
>>   */
>>  
>> +#include <linux/acpi.h>
>>  #include <linux/export.h>
>>  #include <linux/kobject.h>
>>  #include <linux/string.h>
>> @@ -83,6 +84,18 @@ int unregister_pm_notifier(struct notifier_block *nb)
>>  }
>>  EXPORT_SYMBOL_GPL(unregister_pm_notifier);
>>  
>> +void pm_report_hw_sleep_time(u64 t)
>> +{
>> +       suspend_stats.last_hw_sleep = t;
>> +       if (suspend_stats.total_hw_sleep == -EOVERFLOW)
>> +               return;
>> +       if (suspend_stats.total_hw_sleep + t < suspend_stats.total_hw_sleep)
>> +               suspend_stats.total_hw_sleep = -EOVERFLOW;
>> +       else
>> +               suspend_stats.total_hw_sleep += t;
> 
> total_hw_sleep is u64. At microsecond granularity it will never realistically
> overflow and isn't worth the check IMO. The overflow concern comes from the u32
> hardware counter, but I don't think there's a good way to detect it.
> 
> You could just report the maximum hardware counter time as max_hw_sleep so users
> know the value isn't reliable if suspended for longer than that.

Yes I think we need to let userspace know the longest hw-sleep time
the hw can reliably record and then userspace can (and should) chose
to not use/check the counters when the total suspend time is bigger
then the max hw-sleep time.

Other then that this patch-set seems like a good idea to me
and I have no objections / remarks on the pdx86 bits.

Regards,

Hans



>> +}
>> +EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
>> +
>>  int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long
>> val_down)
>>  {
>>         int ret;
>> @@ -377,6 +390,22 @@ static ssize_t last_failed_step_show(struct kobject
>> *kobj,
>>  }
>>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>>  
>> +static ssize_t last_hw_sleep_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
>> +}
>> +static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
>> +
>> +static ssize_t total_hw_sleep_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       if (suspend_stats.total_hw_sleep == -EOVERFLOW)
>> +               return suspend_stats.total_hw_sleep;
>> +       return sysfs_emit(buf, "%llu\n", suspend_stats.total_hw_sleep);
>> +}
>> +static struct kobj_attribute total_hw_sleep = __ATTR_RO(total_hw_sleep);
>> +
>>  static struct attribute *suspend_attrs[] = {
>>         &success.attr,
>>         &fail.attr,
>> @@ -391,12 +420,28 @@ static struct attribute *suspend_attrs[] = {
>>         &last_failed_dev.attr,
>>         &last_failed_errno.attr,
>>         &last_failed_step.attr,
>> +       &last_hw_sleep.attr,
>> +       &total_hw_sleep.attr,
>>         NULL,
>>  };
>>  
>> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute
>> *attr, int idx)
>> +{
>> +       if (attr != &last_hw_sleep.attr &&
>> +           attr != &total_hw_sleep.attr)
>> +               return 0444;
>> +
>> +#ifdef CONFIG_ACPI
>> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>> +               return 0444;
>> +#endif
>> +       return 0;
>> +}
>> +
>>  static const struct attribute_group suspend_attr_group = {
>>         .name = "suspend_stats",
>>         .attrs = suspend_attrs,
>> +       .is_visible = suspend_attr_is_visible,
>>  };
>>  
>>  #ifdef CONFIG_DEBUG_FS

