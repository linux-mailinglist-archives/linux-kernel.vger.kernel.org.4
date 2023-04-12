Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB26DEF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjDLIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDLIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096486A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681289252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iN9iuuEdf2eZEpLYwbblOJe07ZKDLT7v+uTdJ1g2Tko=;
        b=blhplTrOOQ6tcvxy2eudUdwZM9ugKHRQ1GIvKtv7c4SWiQJX8oepiotjzo6G135m1Lh5ii
        7FqXnL135umSjdUeA/T90VGtLzWrgSealJra7F9g3Y/Zz2emVjxKB+VcUKCVJxPlMCOMZK
        p8UFCj2TF91hxnN7IJFwE1CjHrx4SHQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-fi8o0tA8O1GTzbFBWFW8Yg-1; Wed, 12 Apr 2023 04:47:31 -0400
X-MC-Unique: fi8o0tA8O1GTzbFBWFW8Yg-1
Received: by mail-ed1-f70.google.com with SMTP id a5-20020a509e85000000b0050504899d78so668182edf.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681289249; x=1683881249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN9iuuEdf2eZEpLYwbblOJe07ZKDLT7v+uTdJ1g2Tko=;
        b=BXqt60dP7xinj6TuqzS3zsv+iDCLrg0e59a8GJ2Px+VTbH3NUJjA4W0gSKhCx1suig
         iz2ZwvsdGPbozIfsa5qihgE3Ps1QcoYIt3VmzhoejfEFaLauPreXVj07+ZfkERgcUE8u
         9rJiCPQdbZGx3DSBFYyQnHal+GGP6l3jHmlr2ccNsy+v6XzloEya0UWgwiuupl9Ni78I
         H7QocUwmeLAGQOxvO6Lo7MUUcyX253rguEU+wSxMOYYYqg+2TekiZ4BsYwVnfAd+4fqK
         JEkvCIqReuJFhaF/BG2IfGafJIUZSQl3++JovbZWct0wcFD3+tHdwE3eiHlDPjBRKPNd
         kd/w==
X-Gm-Message-State: AAQBX9dJmWs3lZFjrlQgaSlZ+pbI/8wN5te1ACHG6TfAALKHrp7KAXH/
        17uU1Z0C33OcWpuAKVoebjso2tyC1U5G0r5A1TCB2iaHQUrhmhVOjNeqn7Y3dskt+UqwBW4I6VG
        zPQbNC0O79EF0Vf9BOtnJm6mjhyMCv9am
X-Received: by 2002:a17:907:75e8:b0:94a:67fc:896a with SMTP id jz8-20020a17090775e800b0094a67fc896amr5528797ejc.18.1681289249448;
        Wed, 12 Apr 2023 01:47:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350YKq2IJo7LIvJDM/petKEKrPW2GRl11UKcdhXRDjFSDC9Dp9rmcjwe5GrxKjPQFdHMd8q2xDw==
X-Received: by 2002:a17:907:75e8:b0:94a:67fc:896a with SMTP id jz8-20020a17090775e800b0094a67fc896amr5528774ejc.18.1681289249070;
        Wed, 12 Apr 2023 01:47:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906091300b00923f05b2931sm6954296ejd.118.2023.04.12.01.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:47:28 -0700 (PDT)
Message-ID: <a5e4a968-5167-ed4d-fe7a-0a6cf70cb946@redhat.com>
Date:   Wed, 12 Apr 2023 10:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
To:     "Box, David E" <david.e.box@intel.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
 <20230411211719.4549-2-mario.limonciello@amd.com>
 <2a6a377b-4c39-6c2a-c0ee-733120270424@redhat.com>
 <MN0PR12MB6101BDD7A3DB5AD251B63495E29A9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <279c5b5c9fca4bd933aa1b98796ac7219f91c389.camel@intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <279c5b5c9fca4bd933aa1b98796ac7219f91c389.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 4/12/23 02:58, Box, David E wrote:
> Hi,
> 
> On Tue, 2023-04-11 at 21:49 +0000, Limonciello, Mario wrote:
>> [Public]
>>
>>>
>>> On 4/11/23 23:17, Mario Limonciello wrote:
>>>> Userspace can't easily discover how much of a sleep cycle was spent in a
>>>> hardware sleep state without using kernel tracing and vendor specific
>>>> sysfs
>>>> or debugfs files.
>>>>
>>>> To make this information more discoverable, introduce two new sysfs files:
>>>> 1) The time spent in a hw sleep state for last cycle.
>>>> 2) The time spent in a hw sleep state since the kernel booted
>>>> Both of these files will be present only if the system supports s2idle.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v6->v7:
>>>>  * Rename to max_hw_sleep (David E Box)
>>>>  * Drop overflow checks (David E Box)
>>>> v5->v6:
>>>>  * Add total attribute as well
>>>>  * Change text for documentation
>>>>  * Adjust flow of is_visible callback.
>>>>  * If overflow was detected in total attribute return -EOVERFLOW
>>>>  * Rename symbol
>>>>  * Add stub for symbol for builds without CONFIG_PM_SLEEP
>>>> v4->v5:
>>>>  * Provide time in microseconds instead of percent. Userspace can convert
>>>>    this if desirable.
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-power | 24 ++++++++++++++++
>>>>  include/linux/suspend.h               |  5 ++++
>>>>  kernel/power/main.c                   | 40 +++++++++++++++++++++++++++
>>>>  3 files changed, 69 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-power
>>> b/Documentation/ABI/testing/sysfs-power
>>>> index f99d433ff311..0723b4dadfbe 100644
>>>> --- a/Documentation/ABI/testing/sysfs-power
>>>> +++ b/Documentation/ABI/testing/sysfs-power
>>>> @@ -413,6 +413,30 @@ Description:
>>>>                 The /sys/power/suspend_stats/last_failed_step file
>>>> contains
>>>>                 the last failed step in the suspend/resume path.
>>>>
>>>> +What:          /sys/power/suspend_stats/last_hw_sleep
>>>> +Date:          June 2023
>>>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>>>> +Description:
>>>> +               The /sys/power/suspend_stats/last_hw_sleep file
>>>> +               contains the duration of time spent in a hardware sleep
>>>> +               state in the most recent system suspend-resume cycle.
>>>> +               This number is measured in microseconds.
>>>> +
>>>> +               NOTE: Limitations in the size of the hardware counters may
>>>> +               cause this value to be inaccurate in longer sleep cycles.
>>>
>>> Hmm I thought that the plan was to add a separate sysfs attr with
>>> the max time that the hw could represent here, so that userspace
>>> actually know what constitutes a "longer sleep cycle" ?
>>>
>>> That would seem better then such a handwavy comment in the ABI docs?
>>
>> I obviously misunderstood what you were suggesting.
>> I don't believe we have a way to programmatically determine what the hardware
>> Internally uses for it's counter to know this.
>>
>> So it would need to be a table of some sorts that a given system can support
>> such value.  If we do that, we can actually know whether to return an error
>> code
>> like -EOVERFLOW or -EINVAL too if the suspend was too long.
>>
>> I would need Intel guys to share this information though which systems have
>> which size of counters to make this happen.
> 
> For Intel all the s0ix counters are 32 bit. If the maximum sleep time is
> reported in microseconds it's just
> 
>         ((1UL << 32) - 1) * slp_s0_res_counter_step,
> 
> where slp_s0_res_counter_step is the platform specific counter granularity in
> microseconds. There are some platform specific tweaks (of course). If you
> provide a function to call, I can write the patch for intel_pmc_core.

FWIW the above plan sounds go to me. 

Regards,

Hans





>>>> +What:          /sys/power/suspend_stats/max_hw_sleep
>>>> +Date:          June 2023
>>>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>>>> +Description:
>>>> +               The /sys/power/suspend_stats/max_hw_sleep file
>>>> +               contains the aggregate of time spent in a hardware sleep
>>>> +               state since the kernel was booted. This number
>>>> +               is measured in microseconds.
>>>> +
>>>> +               NOTE: Limitations in the size of the hardware counters may
>>>> +               cause this value to be inaccurate in longer sleep cycles.
>>>
>>> Maybe "total_hw_sleep" instead of "max_hw_sleep" ? Also since max to
>>> me sounds like the limit of the longest sleep the hw counters can
>>> register, so that is bit confusing with the discussion about those
>>> limits.
>>
>> total_hw_sleep is actually what was in v6 and max_hw_sleep is what suggested.
>> That's why I got confused about what you guys meant.
> 
> Sorry, I meant max_hw_sleep for the additional attribute as Hans mentioned.
> 
> David
> 
>>
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>> +
>>>>  What:          /sys/power/sync_on_suspend
>>>>  Date:          October 2019
>>>>  Contact:       Jonas Meurer <jonas@freesources.org>
>>>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>>>> index cfe19a028918..819e9677fd10 100644
>>>> --- a/include/linux/suspend.h
>>>> +++ b/include/linux/suspend.h
>>>> @@ -68,6 +68,8 @@ struct suspend_stats {
>>>>         int     last_failed_errno;
>>>>         int     errno[REC_FAILED_NUM];
>>>>         int     last_failed_step;
>>>> +       u64     last_hw_sleep;
>>>> +       u64     max_hw_sleep;
>>>>         enum suspend_stat_step  failed_steps[REC_FAILED_NUM];
>>>>  };
>>>>
>>>> @@ -489,6 +491,7 @@ void restore_processor_state(void);
>>>>  extern int register_pm_notifier(struct notifier_block *nb);
>>>>  extern int unregister_pm_notifier(struct notifier_block *nb);
>>>>  extern void ksys_sync_helper(void);
>>>> +extern void pm_report_hw_sleep_time(u64 t);
>>>>
>>>>  #define pm_notifier(fn, pri) {                         \
>>>>         static struct notifier_block fn##_nb =                  \
>>>> @@ -526,6 +529,8 @@ static inline int unregister_pm_notifier(struct
>>> notifier_block *nb)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static inline void pm_report_hw_sleep_time(u64 t) {};
>>>> +
>>>>  static inline void ksys_sync_helper(void) {}
>>>>
>>>>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
>>>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>>>> index 31ec4a9b9d70..a5546b91ecc9 100644
>>>> --- a/kernel/power/main.c
>>>> +++ b/kernel/power/main.c
>>>> @@ -6,6 +6,7 @@
>>>>   * Copyright (c) 2003 Open Source Development Lab
>>>>   */
>>>>
>>>> +#include <linux/acpi.h>
>>>>  #include <linux/export.h>
>>>>  #include <linux/kobject.h>
>>>>  #include <linux/string.h>
>>>> @@ -83,6 +84,13 @@ int unregister_pm_notifier(struct notifier_block *nb)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(unregister_pm_notifier);
>>>>
>>>> +void pm_report_hw_sleep_time(u64 t)
>>>> +{
>>>> +       suspend_stats.last_hw_sleep = t;
>>>> +       suspend_stats.max_hw_sleep += t;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
>>>> +
>>>>  int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long
>>> val_down)
>>>>  {
>>>>         int ret;
>>>> @@ -377,6 +385,22 @@ static ssize_t last_failed_step_show(struct kobject
>>> *kobj,
>>>>  }
>>>>  static struct kobj_attribute last_failed_step =
>>> __ATTR_RO(last_failed_step);
>>>>
>>>> +static ssize_t last_hw_sleep_show(struct kobject *kobj,
>>>> +               struct kobj_attribute *attr, char *buf)
>>>> +{
>>>> +       return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
>>>> +}
>>>> +static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
>>>> +
>>>> +static ssize_t max_hw_sleep_show(struct kobject *kobj,
>>>> +               struct kobj_attribute *attr, char *buf)
>>>> +{
>>>> +       if (suspend_stats.max_hw_sleep == -EOVERFLOW)
>>>> +               return suspend_stats.max_hw_sleep;
>>>> +       return sysfs_emit(buf, "%llu\n", suspend_stats.max_hw_sleep);
>>>> +}
>>>> +static struct kobj_attribute max_hw_sleep =
>>> __ATTR_RO(max_hw_sleep);
>>>> +
>>>>  static struct attribute *suspend_attrs[] = {
>>>>         &success.attr,
>>>>         &fail.attr,
>>>> @@ -391,12 +415,28 @@ static struct attribute *suspend_attrs[] = {
>>>>         &last_failed_dev.attr,
>>>>         &last_failed_errno.attr,
>>>>         &last_failed_step.attr,
>>>> +       &last_hw_sleep.attr,
>>>> +       &max_hw_sleep.attr,
>>>>         NULL,
>>>>  };
>>>>
>>>> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct
>>> attribute *attr, int idx)
>>>> +{
>>>> +       if (attr != &last_hw_sleep.attr &&
>>>> +           attr != &max_hw_sleep.attr)
>>>> +               return 0444;
>>>> +
>>>> +#ifdef CONFIG_ACPI
>>>> +       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>>>> +               return 0444;
>>>> +#endif
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static const struct attribute_group suspend_attr_group = {
>>>>         .name = "suspend_stats",
>>>>         .attrs = suspend_attrs,
>>>> +       .is_visible = suspend_attr_is_visible,
>>>>  };
>>>>
>>>>  #ifdef CONFIG_DEBUG_FS
> 

