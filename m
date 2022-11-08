Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEDC621DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKHU1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiKHU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:27:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD70220D9;
        Tue,  8 Nov 2022 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667939230; x=1699475230;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9OJVrP5HibV82CPzM2N25a3tmIRq2KGayA0fJg0eLk=;
  b=U2vt0B6t62oO9355xmS2/0/SsK0q/+s4NDlJrkxOiF3+VxnbK0NsUyHi
   MA664hpjh1XsblfnW2UKrIAYpIb9em7yUWTTf/HtDn4DFy0FRY02JR0XX
   9cg4IuP1x3UbzR2hsa16kC4WrEIXtps0ZWy7ZdtdWgT/8698ifHHf09zq
   TeMV8F1mZ0fWwBW4M4rGpQtvykq74HWJ5sKuecPU3SLn6Ghosu5tFo+r/
   wMPuAT9BxpeZ6htHWLUP7NHdzjlSsSGMrhEgvr/yA835uIqFZ/9YVUNDs
   aNibhd+WpnQAv8W3eEc/xP4vccRFvc401S0e4UaTCrld9Ae71BhglASPn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="311958381"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="311958381"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 12:27:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="761623725"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="761623725"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2022 12:27:09 -0800
Received: from khouck-mobl3.amr.corp.intel.com (unknown [10.212.155.200])
        by linux.intel.com (Postfix) with ESMTP id EEDA9580B0E;
        Tue,  8 Nov 2022 12:27:08 -0800 (PST)
Message-ID: <7b85cb8d5cc1cf1293045ba89a590569f0130baa.camel@linux.intel.com>
Subject: Re: [RFC 1/3] PM: Add a sysfs file to represent whether hardware
 reached the deepest state
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, platform-driver-x86@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 08 Nov 2022 12:27:08 -0800
In-Reply-To: <20221031204320.22464-2-mario.limonciello@amd.com>
References: <20221031204320.22464-1-mario.limonciello@amd.com>
         <20221031204320.22464-2-mario.limonciello@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Mon, 2022-10-31 at 15:43 -0500, Mario Limonciello wrote:
> Both AMD and Intel SoCs have a concept of reporting whether the hardware
> reached the deepest possible hardware state over s2idle as well as how much
> time was spent in that state.
> 
> This information is valuable to both chip designers and system designers as
> it helps to identify when there are problems with power consumption over
> an s2idle cycle.
> 
> To make the information discoverable, create a new sysfs file and a symbol
> that drivers from supported manufacturers can use to advertise this
> information.
> 
> Suggested-by: David E Box <david.e.box@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-power |  8 ++++++++
>  include/linux/suspend.h               |  2 ++
>  kernel/power/main.c                   | 14 ++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power
> b/Documentation/ABI/testing/sysfs-power
> index f99d433ff3117..25c52d7469b9c 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -413,6 +413,14 @@ Description:
>  		The /sys/power/suspend_stats/last_failed_step file contains
>  		the last failed step in the suspend/resume path.
>  
> +What:		/sys/power/suspend_stats/last_hw_deepest_state
> +Date:		December 2022
> +Contact:	Mario Limonciello <mario.limonciello@amd.com>
> +Description:
> +		The /sys/power/suspend_stats/last_hw_deepest_state file contains
> +		the amount of time spent in the deepest hardware sleep state.
> +		This is measured in microseconds.

The name doesn't really fit with the measurement. Maybe last_hw_state_residency
or last_low_power_idle_res (using the spec description of this feature).

I left out deepest in the name because it would be my preference, in case of
multiple hardware states, that this defaults to the total time spent in any low
power idle state rather than just the deepest. At least we would use it that
way.

> +
>  What:		/sys/power/sync_on_suspend
>  Date:		October 2019
>  Contact:	Jonas Meurer <jonas@freesources.org>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cfe19a0289185..30b8a8018299b 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -68,6 +68,7 @@ struct suspend_stats {
>  	int	last_failed_errno;
>  	int	errno[REC_FAILED_NUM];
>  	int	last_failed_step;
> +	u64	last_hw_deepest_state;
>  	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
>  };
>  
> @@ -489,6 +490,7 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern void pm_set_hw_deepest_state(u64 duration);
>  
>  #define pm_notifier(fn, pri) {				\
>  	static struct notifier_block fn##_nb =			\
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 31ec4a9b9d704..1bda5d2d26c53 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -54,6 +54,12 @@ void unlock_system_sleep(unsigned int flags)
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
>  
> +void pm_set_hw_deepest_state(u64 duration)
> +{
> +	suspend_stats.last_hw_deepest_state = duration;
> +}
> +EXPORT_SYMBOL_GPL(pm_set_hw_deepest_state);
> +
>  void ksys_sync_helper(void)
>  {
>  	ktime_t start;
> @@ -377,6 +383,13 @@ static ssize_t last_failed_step_show(struct kobject
> *kobj,
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>  
> +static ssize_t last_hw_deepest_state_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%llu\n", suspend_stats.last_hw_deepest_state);
> +}
> +static struct kobj_attribute last_hw_deepest_state =
> __ATTR_RO(last_hw_deepest_state);
> +
>  static struct attribute *suspend_attrs[] = {
>  	&success.attr,
>  	&fail.attr,
> @@ -391,6 +404,7 @@ static struct attribute *suspend_attrs[] = {
>  	&last_failed_dev.attr,
>  	&last_failed_errno.attr,
>  	&last_failed_step.attr,
> +	&last_hw_deepest_state.attr,
>  	NULL,
>  };
>  

This would appear on all systems, whether or not they support low power idle. It
would make sense to either prevent its display on unsupported systems or provide
another file to show if low power idle is supported.

David

