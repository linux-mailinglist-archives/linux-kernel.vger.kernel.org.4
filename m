Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F2262FC19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbiKRR5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbiKRR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:57:38 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25116A6B3;
        Fri, 18 Nov 2022 09:57:36 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id 8so3972237qka.1;
        Fri, 18 Nov 2022 09:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPOY8H/nva/RTm1wL2a9BnQoOcQF/xp9kAd5iElmOWk=;
        b=5VmBCYYHMsaFwe8ZaM3zuTBteLqHoDnFia0+IV6AQu2mzXrexzX27ECuhdRH60R5Tm
         rbOwTabFtvx7jBtvyj6gX+v44qjyezh+yzlmt69dCOoauIqcezuv/rfFtvUKCkJWmOKp
         VqeHRb6AzItuq4FVFsRPHs9/kY33IFHn+awvu8wniUjfjX+ozfDq4W32lDQ6eLWs3VoO
         BTLaygNRuXUhSsj8t54+e0Fv7DkWDfgnButMvVk1qcibvsUa7egfoS9uuGN0XzCXyf6t
         T7lmeFGx5eSgz7UbddF8Dr2NBIYul0j3w7p92dSNlrNhuOAq32LxJel9byxehq21AC8l
         lefw==
X-Gm-Message-State: ANoB5plD54yYfWX3VljK6yf4QyMe5/J7xXgNXa7kx13G+5YAigPjlIwA
        wzTrg0sh4tBUq+m335NWPqHr6ULXi3y8xcwGR9g=
X-Google-Smtp-Source: AA0mqf6oILKfVzT80cNC1LRmBDysLHBtD2rfy1247zDFyUr2DVxTAyNrrpf2D9iQr4qOiEiuKYh2+PPD6Y7wo+Yc9nE=
X-Received: by 2002:a37:b901:0:b0:6ec:2b04:5099 with SMTP id
 j1-20020a37b901000000b006ec2b045099mr6912151qkf.501.1668794255566; Fri, 18
 Nov 2022 09:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com> <20221116025417.2590275-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221116025417.2590275-2-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Nov 2022 18:57:24 +0100
Message-ID: <CAJZ5v0jrEDkfZbMzdLHzvGwa3jK61vUBBqzUUM8BaQvLLcZnhg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] thermal: intel: Protect clearing of thermal
 status bits
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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

On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The clearing of the package thermal status is done by Read-Modify-Write
> operation. This may result in clearing of some new status bits which are
> being or about to be processed.
>
> For example, while clearing of HFI status, after read of thermal status
> register, a new thermal status bit is set by the hardware. But during
> write back, the newly generated status bit will be set to 0 or cleared.
> So, it is not safe to do read-modify-write.
>
> Since thermal status Read-Write bits can be set to only 0 not 1, it is
> safe to set all other bits to 1 which are not getting cleared.
>
> Create a common interface for clearing package thermal status bits. Use
> this interface to replace existing code to clear thermal package status
> bits.
>
> It is safe to call from different CPUs without protection as there is no
> read-modify-write. Also wrmsrl results in just single instruction. For
> example while CPU 0 and CPU 3 are clearing bit 1 and 3 respectively. If
> CPU 3 wins the race, it will write 0x4000aa2, then CPU 1 will write
> 0x4000aa8. The bits which are not part of clear are set to 1. The default
> mask for bits, which can be written here is 0x4000aaa.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

How urgent is this?  Would 6.2 be sufficient?

Also, do you want it to go into -stable?

> ---
> Email address was wrong, so sending again.
>
>  drivers/thermal/intel/intel_hfi.c            |  8 ++-----
>  drivers/thermal/intel/therm_throt.c          | 23 ++++++++++----------
>  drivers/thermal/intel/thermal_interrupt.h    |  6 +++++
>  drivers/thermal/intel/x86_pkg_temp_thermal.c |  9 ++------
>  4 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index a0640f762dc5..c9e0827c9ebe 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -42,9 +42,7 @@
>
>  #include "../thermal_core.h"
>  #include "intel_hfi.h"
> -
> -#define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
> -                                    BIT(9) | BIT(11) | BIT(26))
> +#include "thermal_interrupt.h"
>
>  /* Hardware Feedback Interface MSR configuration bits */
>  #define HW_FEEDBACK_PTR_VALID_BIT              BIT(0)
> @@ -304,9 +302,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
>          * Let hardware know that we are done reading the HFI table and it is
>          * free to update it again.
>          */
> -       pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> -                                   ~PACKAGE_THERM_STATUS_HFI_UPDATED;
> -       wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
> +       thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
>
>         queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
>                            HFI_UPDATE_INTERVAL);
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
> index 9e8ab31d756e..4bb7fddaa143 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -190,32 +190,33 @@ static const struct attribute_group thermal_attr_group = {
>  };
>  #endif /* CONFIG_SYSFS */
>
> -#define CORE_LEVEL     0
> -#define PACKAGE_LEVEL  1
> -
>  #define THERM_THROT_POLL_INTERVAL      HZ
>  #define THERM_STATUS_PROCHOT_LOG       BIT(1)
>
>  #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
>  #define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(26))
>
> -static void clear_therm_status_log(int level)
> +/*
> + * Clear the bits in package thermal status register for bit = 1
> + * in bitmask
> + */
> +void thermal_clear_package_intr_status(int level, u64 bit_mask)
>  {
> +       u64 msr_val;
>         int msr;
> -       u64 mask, msr_val;
>
>         if (level == CORE_LEVEL) {
>                 msr  = MSR_IA32_THERM_STATUS;
> -               mask = THERM_STATUS_CLEAR_CORE_MASK;
> +               msr_val = THERM_STATUS_CLEAR_CORE_MASK;
>         } else {
>                 msr  = MSR_IA32_PACKAGE_THERM_STATUS;
> -               mask = THERM_STATUS_CLEAR_PKG_MASK;
> +               msr_val = THERM_STATUS_CLEAR_PKG_MASK;
>         }
>
> -       rdmsrl(msr, msr_val);
> -       msr_val &= mask;
> -       wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
> +       msr_val &= ~bit_mask;
> +       wrmsrl(msr, msr_val);
>  }
> +EXPORT_SYMBOL_GPL(thermal_clear_package_intr_status);
>
>  static void get_therm_status(int level, bool *proc_hot, u8 *temp)
>  {
> @@ -295,7 +296,7 @@ static void __maybe_unused throttle_active_work(struct work_struct *work)
>         state->average = avg;
>
>  re_arm:
> -       clear_therm_status_log(state->level);
> +       thermal_clear_package_intr_status(state->level, THERM_STATUS_PROCHOT_LOG);
>         schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
>  }
>
> diff --git a/drivers/thermal/intel/thermal_interrupt.h b/drivers/thermal/intel/thermal_interrupt.h
> index 01e7bed2ffc7..01dfd4cdb5df 100644
> --- a/drivers/thermal/intel/thermal_interrupt.h
> +++ b/drivers/thermal/intel/thermal_interrupt.h
> @@ -2,6 +2,9 @@
>  #ifndef _INTEL_THERMAL_INTERRUPT_H
>  #define _INTEL_THERMAL_INTERRUPT_H
>
> +#define CORE_LEVEL     0
> +#define PACKAGE_LEVEL  1
> +
>  /* Interrupt Handler for package thermal thresholds */
>  extern int (*platform_thermal_package_notify)(__u64 msr_val);
>
> @@ -15,4 +18,7 @@ extern bool (*platform_thermal_package_rate_control)(void);
>  /* Handle HWP interrupt */
>  extern void notify_hwp_interrupt(void);
>
> +/* Common function to clear Package thermal status register */
> +extern void thermal_clear_package_intr_status(int level, u64 bit_mask);
> +
>  #endif /* _INTEL_THERMAL_INTERRUPT_H */
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index a0e234fce71a..84c3a116ed04 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -265,7 +265,6 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
>         struct thermal_zone_device *tzone = NULL;
>         int cpu = smp_processor_id();
>         struct zone_device *zonedev;
> -       u64 msr_val, wr_val;
>
>         mutex_lock(&thermal_zone_mutex);
>         raw_spin_lock_irq(&pkg_temp_lock);
> @@ -279,12 +278,8 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
>         }
>         zonedev->work_scheduled = false;
>
> -       rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
> -       wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
> -       if (wr_val != msr_val) {
> -               wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, wr_val);
> -               tzone = zonedev->tzone;
> -       }
> +       thermal_clear_package_intr_status(PACKAGE_LEVEL, THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
> +       tzone = zonedev->tzone;
>
>         enable_pkg_thres_interrupt();
>         raw_spin_unlock_irq(&pkg_temp_lock);
> --
> 2.31.1
>
