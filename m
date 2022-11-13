Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F26273A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 00:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiKMXxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 18:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 18:53:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476965C6;
        Sun, 13 Nov 2022 15:53:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668383623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usu1Jbl/QfHlQ4fwbl7hFFCitKurN4NTivq3m52aG2s=;
        b=ymtWyICczNuomXRJQ/Q/kZ87F4kDt4okvuIclCOx4AT1zQPD2qJ/nPgRwvKzrzKDgC46lr
        coSENk6hS0q1APGUuXwq3xuKJTnr/XBD6O11HN0A5DTT1ygR3wErmWL1pMAv6XXGXiPLdF
        WjySVV1KwVve19jxWBfdsjJZUgcfcV/93iO3sjCUk+Wvie5rj6nkUpTPh8gam4Ma9VtRdw
        cHa7dGRZ2MliXuIptYx/TmiBIsdlYXjWpYDQUHq5ZNWQfmZncrdCwGU6GVxCZ/Kpuav/mW
        BsLx7HCYBGLihMYvxpl0kspBuvKj1wZ6Qt5YocQLPY/PStlQpRnKiN/fyt2zMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668383623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usu1Jbl/QfHlQ4fwbl7hFFCitKurN4NTivq3m52aG2s=;
        b=+UXbGF8aBfdcAUFCu9uPwKTjI17fHs8XYFAuvvZSfD91Z+RtzQLH9SuawluCjv0+fXJWKL
        hBoPHg0WDViTfiBA==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
In-Reply-To: <20221110064723.8882-2-mario.limonciello@amd.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com>
Date:   Mon, 14 Nov 2022 00:53:42 +0100
Message-ID: <871qq6tnqx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2022 at 00:47, Mario Limonciello wrote:

'Add a sysfs files'?

Can you please decide whether that's 'a file' or 'multiple files'?

> Both AMD and Intel SoCs have a concept of reporting whether the hardware
> reached a hardware sleep state over s2idle as well as how much
> time was spent in such a state.

Nice, but ...

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

The above is incomprehensible word salad. Can you come up with some
coherent explanation of what you are trying to achieve please?

> +void pm_set_hw_state_residency(u64 duration)
> +{
> +	suspend_stats.last_hw_state_residency = duration;
> +}
> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
> +
> +void pm_account_suspend_type(const struct timespec64 *t)
> +{
> +	suspend_stats.last_suspend_total += (s64)t->tv_sec * USEC_PER_SEC +
> +						 t->tv_nsec / NSEC_PER_USEC;

Conversion functions for timespecs to scalar nanoseconds exist for a
reason. Why does this need special treatment and open code it?

> +}
> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);

So none of these functions has any kind of documentation. kernel-doc
exists for a reason especially for exported functions.

That said, what's the justification to export any of these functions at
all? AFAICT pm_account_suspend_type() is only used by builtin code...

> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	if (attr != &last_hw_state_residency.attr)
> +		return 0444;
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

How is this change related to the changelog above? We are not hiding
subtle changes to the existing code in some conglomorate patch. See
Documentation/process/...

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
>  	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
>  	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
>  	tk_debug_account_sleep_time(delta);
> +	pm_account_suspend_type(delta);

That function name is really self explaining - NOT !

     pm_account_suspend_type(delta);

So this will account a suspend type depending on the time spent in
suspend, right?

It's totally obvious that the suspend type (whatever it is) depends on
the time delta argument... especially when the function at hand has
absolutely nothing to do with a type:

> +void pm_account_suspend_type(const struct timespec64 *t)
> +{
> +	suspend_stats.last_suspend_total += (s64)t->tv_sec * USEC_PER_SEC +
> +						 t->tv_nsec / NSEC_PER_USEC;
> +}

Sigh....

Thanks,

        tglx
