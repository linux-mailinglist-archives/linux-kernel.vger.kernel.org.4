Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F56DE69C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDKVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541D449E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681249345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0LgOe8KSCslKxe/w6rSjFnwFITuPCX3cpOmYflRUzY=;
        b=hmgvzjF2KrljNcRJ9zpLF1+gQ+pKtaTuTwpNt3eZd5lNYRBJj3T3tvYqkMrOf5hepjyPbc
        jLE+Yy0Vwo8073GxldcuFNLGq35YWnFh8cyC2ei+9Ex9tK/gzQGCcGhgLzx7o3YyJ7i5GY
        ijly90Wu/vwfDK/J0lOw4DY1hg9bI84=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-zNp0oIoXN1i3k4MzY0WXVw-1; Tue, 11 Apr 2023 17:42:24 -0400
X-MC-Unique: zNp0oIoXN1i3k4MzY0WXVw-1
Received: by mail-ed1-f71.google.com with SMTP id 30-20020a508e1e000000b00504bac1fafbso2112735edw.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681249343; x=1683841343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0LgOe8KSCslKxe/w6rSjFnwFITuPCX3cpOmYflRUzY=;
        b=px6GuiI1OlHJNLz1KFejtYrdlZIOkVp2HVSzXrn3Id33rYe6dGn5HB4KVyHAV2wYl7
         TbwP0RoM2/r/bdhiGo9HWlMKFXRvna2x7PBcRsd2ydbDFwuprAn+V32vs+5/b9mFYPtE
         clKrr7Plrmczq6l7BVI5fqGbMsKSgWN2+NlgwQyN/mw/lkmkc/02/HlPhdlGCd+fyAXJ
         Fvzd1sxgerhBCwxtvQpp2OE3+ZS+VBoDZol6FB8y7yCMopKV3u64RKrpSnSWcpJ0O7Fp
         TNIbBkYIogkOE2jrz3k9oAkDbLNNEdDpb5+SmH6BXGJGdvwp81W6u3wVls/AgxP5Ygp6
         uxiA==
X-Gm-Message-State: AAQBX9dktd6WbV5byHYrda1XczLbcNDIcW2i+VStFSYXN0Rfks4oUWT2
        49NzNy2JVoqUL6Ro9w53QxNx1MoJl3fd0SYoNx3p3pU6pTdteRbrSJ07G+/QkxwN3DyF9rF+msL
        XBeMIa7CvLllemC0d+SPt+w08
X-Received: by 2002:a17:906:bcc2:b0:94b:4a4:2836 with SMTP id lw2-20020a170906bcc200b0094b04a42836mr5739173ejb.69.1681249343094;
        Tue, 11 Apr 2023 14:42:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350aEVhWLGYDyJMjydqu4cO4CP6xANfxoY3iKE5HNvggtZ+QZ1oJg7oqIVwTpHEWQbs5gF2HTUg==
X-Received: by 2002:a17:906:bcc2:b0:94b:4a4:2836 with SMTP id lw2-20020a170906bcc200b0094b04a42836mr5739157ejb.69.1681249342780;
        Tue, 11 Apr 2023 14:42:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gt35-20020a1709072da300b008c327bef167sm6574543ejc.7.2023.04.11.14.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 14:42:22 -0700 (PDT)
Message-ID: <2a6a377b-4c39-6c2a-c0ee-733120270424@redhat.com>
Date:   Tue, 11 Apr 2023 23:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Box David E <david.e.box@intel.com>, jstultz@google.com,
        pavel@ucw.cz, svenva@chromium.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Shyam-sundar.S-k@amd.com, rrangel@chromium.org,
        Jain Rajat <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230411211719.4549-1-mario.limonciello@amd.com>
 <20230411211719.4549-2-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230411211719.4549-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/11/23 23:17, Mario Limonciello wrote:
> Userspace can't easily discover how much of a sleep cycle was spent in a
> hardware sleep state without using kernel tracing and vendor specific sysfs
> or debugfs files.
> 
> To make this information more discoverable, introduce two new sysfs files:
> 1) The time spent in a hw sleep state for last cycle.
> 2) The time spent in a hw sleep state since the kernel booted
> Both of these files will be present only if the system supports s2idle.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6->v7:
>  * Rename to max_hw_sleep (David E Box)
>  * Drop overflow checks (David E Box)
> v5->v6:
>  * Add total attribute as well
>  * Change text for documentation
>  * Adjust flow of is_visible callback.
>  * If overflow was detected in total attribute return -EOVERFLOW
>  * Rename symbol
>  * Add stub for symbol for builds without CONFIG_PM_SLEEP
> v4->v5:
>  * Provide time in microseconds instead of percent. Userspace can convert
>    this if desirable.
> ---
>  Documentation/ABI/testing/sysfs-power | 24 ++++++++++++++++
>  include/linux/suspend.h               |  5 ++++
>  kernel/power/main.c                   | 40 +++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index f99d433ff311..0723b4dadfbe 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -413,6 +413,30 @@ Description:
>  		The /sys/power/suspend_stats/last_failed_step file contains
>  		the last failed step in the suspend/resume path.
>  
> +What:		/sys/power/suspend_stats/last_hw_sleep
> +Date:		June 2023
> +Contact:	Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +		The /sys/power/suspend_stats/last_hw_sleep file
> +		contains the duration of time spent in a hardware sleep
> +		state in the most recent system suspend-resume cycle.
> +		This number is measured in microseconds.
> +
> +		NOTE: Limitations in the size of the hardware counters may
> +		cause this value to be inaccurate in longer sleep cycles.

Hmm I thought that the plan was to add a separate sysfs attr with
the max time that the hw could represent here, so that userspace
actually know what constitutes a "longer sleep cycle" ?

That would seem better then such a handwavy comment in the ABI docs?

> +
> +What:		/sys/power/suspend_stats/max_hw_sleep
> +Date:		June 2023
> +Contact:	Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +		The /sys/power/suspend_stats/max_hw_sleep file
> +		contains the aggregate of time spent in a hardware sleep
> +		state since the kernel was booted. This number
> +		is measured in microseconds.
> +
> +		NOTE: Limitations in the size of the hardware counters may
> +		cause this value to be inaccurate in longer sleep cycles.

Maybe "total_hw_sleep" instead of "max_hw_sleep" ? Also since max to
me sounds like the limit of the longest sleep the hw counters can
register, so that is bit confusing with the discussion about those
limits.

Regards,

Hans



> +
>  What:		/sys/power/sync_on_suspend
>  Date:		October 2019
>  Contact:	Jonas Meurer <jonas@freesources.org>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cfe19a028918..819e9677fd10 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -68,6 +68,8 @@ struct suspend_stats {
>  	int	last_failed_errno;
>  	int	errno[REC_FAILED_NUM];
>  	int	last_failed_step;
> +	u64	last_hw_sleep;
> +	u64	max_hw_sleep;
>  	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
>  };
>  
> @@ -489,6 +491,7 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern void pm_report_hw_sleep_time(u64 t);
>  
>  #define pm_notifier(fn, pri) {				\
>  	static struct notifier_block fn##_nb =			\
> @@ -526,6 +529,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
>  	return 0;
>  }
>  
> +static inline void pm_report_hw_sleep_time(u64 t) {};
> +
>  static inline void ksys_sync_helper(void) {}
>  
>  #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 31ec4a9b9d70..a5546b91ecc9 100644
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
> @@ -83,6 +84,13 @@ int unregister_pm_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(unregister_pm_notifier);
>  
> +void pm_report_hw_sleep_time(u64 t)
> +{
> +	suspend_stats.last_hw_sleep = t;
> +	suspend_stats.max_hw_sleep += t;
> +}
> +EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
> +
>  int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
>  {
>  	int ret;
> @@ -377,6 +385,22 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>  
> +static ssize_t last_hw_sleep_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
> +}
> +static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
> +
> +static ssize_t max_hw_sleep_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	if (suspend_stats.max_hw_sleep == -EOVERFLOW)
> +		return suspend_stats.max_hw_sleep;
> +	return sysfs_emit(buf, "%llu\n", suspend_stats.max_hw_sleep);
> +}
> +static struct kobj_attribute max_hw_sleep = __ATTR_RO(max_hw_sleep);
> +
>  static struct attribute *suspend_attrs[] = {
>  	&success.attr,
>  	&fail.attr,
> @@ -391,12 +415,28 @@ static struct attribute *suspend_attrs[] = {
>  	&last_failed_dev.attr,
>  	&last_failed_errno.attr,
>  	&last_failed_step.attr,
> +	&last_hw_sleep.attr,
> +	&max_hw_sleep.attr,
>  	NULL,
>  };
>  
> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	if (attr != &last_hw_sleep.attr &&
> +	    attr != &max_hw_sleep.attr)
> +		return 0444;
> +
> +#ifdef CONFIG_ACPI
> +	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> +		return 0444;
> +#endif
> +	return 0;
> +}
> +
>  static const struct attribute_group suspend_attr_group = {
>  	.name = "suspend_stats",
>  	.attrs = suspend_attrs,
> +	.is_visible = suspend_attr_is_visible,
>  };
>  
>  #ifdef CONFIG_DEBUG_FS

