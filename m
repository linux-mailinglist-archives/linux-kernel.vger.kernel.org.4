Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12C62FE14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiKRTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiKRTkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:40:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3E17E08;
        Fri, 18 Nov 2022 11:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668800419; x=1700336419;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opCvY/mlEDSdLFCRmsz6kJ7j9StDW0nlMnA2cNnXRG4=;
  b=WVnjBDYWyHrT+/DtpXiCP69a5ys6RXknpJP56+YzYg+yKmISGEoT8gtl
   KyhMGXZfctS4iu8/8UH8EBUwYcr4KQErX0aooVKTueaIhnvAwQAv6nJji
   qnVq0VRBWxcP87x/vDabHZO0e+XoGc9XM4s6lisKONGpRlPlSTR1id0eF
   hyVC3UI5fqH3GItkixZ8uhZFlwVb0iAgQzxBwA5E4tZnyuuiHGMYaEyZY
   ePr0rP91J6Q2503i+P6TlzTQidgNg5dc3bQ3z7nbpbAJp8nrCTFxzKkiy
   ejcRxzwXnbwf3MoWwyDMYiwH6kkNEyu8M+mZluTxIBqSlOck+l3ykObqr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313237220"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313237220"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:40:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="642625009"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="642625009"
Received: from mkmoraki-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.144.176])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:40:16 -0800
Message-ID: <ac94b8218de744a1ca9649fc9585292f11b91063.camel@linux.intel.com>
Subject: Re: [PATCH RESEND 2/2] thermal: intel: Protect clearing of thermal
 status bits
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 18 Nov 2022 11:39:39 -0800
In-Reply-To: <CAJZ5v0jrEDkfZbMzdLHzvGwa3jK61vUBBqzUUM8BaQvLLcZnhg@mail.gmail.com>
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
         <20221116025417.2590275-2-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jrEDkfZbMzdLHzvGwa3jK61vUBBqzUUM8BaQvLLcZnhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-18 at 18:57 +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > The clearing of the package thermal status is done by Read-Modify-
> > Write
> > operation. This may result in clearing of some new status bits
> > which are
> > being or about to be processed.
> > 
> > For example, while clearing of HFI status, after read of thermal
> > status
> > register, a new thermal status bit is set by the hardware. But
> > during
> > write back, the newly generated status bit will be set to 0 or
> > cleared.
> > So, it is not safe to do read-modify-write.
> > 
> > Since thermal status Read-Write bits can be set to only 0 not 1, it
> > is
> > safe to set all other bits to 1 which are not getting cleared.
> > 
> > Create a common interface for clearing package thermal status bits.
> > Use
> > this interface to replace existing code to clear thermal package
> > status
> > bits.
> > 
> > It is safe to call from different CPUs without protection as there
> > is no
> > read-modify-write. Also wrmsrl results in just single instruction.
> > For
> > example while CPU 0 and CPU 3 are clearing bit 1 and 3
> > respectively. If
> > CPU 3 wins the race, it will write 0x4000aa2, then CPU 1 will write
> > 0x4000aa8. The bits which are not part of clear are set to 1. The
> > default
> > mask for bits, which can be written here is 0x4000aaa.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> How urgent is this?  Would 6.2 be sufficient?
> 
Not urgent. 6.2 should be enough.

> Also, do you want it to go into -stable?
Yes.

Thanks,
Srinivas

> 
> > ---
> > Email address was wrong, so sending again.
> > 
> >  drivers/thermal/intel/intel_hfi.c            |  8 ++-----
> >  drivers/thermal/intel/therm_throt.c          | 23 ++++++++++------
> > ----
> >  drivers/thermal/intel/thermal_interrupt.h    |  6 +++++
> >  drivers/thermal/intel/x86_pkg_temp_thermal.c |  9 ++------
> >  4 files changed, 22 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/intel_hfi.c
> > b/drivers/thermal/intel/intel_hfi.c
> > index a0640f762dc5..c9e0827c9ebe 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -42,9 +42,7 @@
> > 
> >  #include "../thermal_core.h"
> >  #include "intel_hfi.h"
> > -
> > -#define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | \
> > -                                    BIT(9) | BIT(11) | BIT(26))
> > +#include "thermal_interrupt.h"
> > 
> >  /* Hardware Feedback Interface MSR configuration bits */
> >  #define HW_FEEDBACK_PTR_VALID_BIT              BIT(0)
> > @@ -304,9 +302,7 @@ void intel_hfi_process_event(__u64
> > pkg_therm_status_msr_val)
> >          * Let hardware know that we are done reading the HFI table
> > and it is
> >          * free to update it again.
> >          */
> > -       pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> > -                                  
> > ~PACKAGE_THERM_STATUS_HFI_UPDATED;
> > -       wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
> > pkg_therm_status_msr_val);
> > +       thermal_clear_package_intr_status(PACKAGE_LEVEL,
> > PACKAGE_THERM_STATUS_HFI_UPDATED);
> > 
> >         queue_delayed_work(hfi_updates_wq, &hfi_instance-
> > >update_work,
> >                            HFI_UPDATE_INTERVAL);
> > diff --git a/drivers/thermal/intel/therm_throt.c
> > b/drivers/thermal/intel/therm_throt.c
> > index 9e8ab31d756e..4bb7fddaa143 100644
> > --- a/drivers/thermal/intel/therm_throt.c
> > +++ b/drivers/thermal/intel/therm_throt.c
> > @@ -190,32 +190,33 @@ static const struct attribute_group
> > thermal_attr_group = {
> >  };
> >  #endif /* CONFIG_SYSFS */
> > 
> > -#define CORE_LEVEL     0
> > -#define PACKAGE_LEVEL  1
> > -
> >  #define THERM_THROT_POLL_INTERVAL      HZ
> >  #define THERM_STATUS_PROCHOT_LOG       BIT(1)
> > 
> >  #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
> >  #define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) |
> > BIT(7) | BIT(9) | BIT(11) | BIT(26))
> > 
> > -static void clear_therm_status_log(int level)
> > +/*
> > + * Clear the bits in package thermal status register for bit = 1
> > + * in bitmask
> > + */
> > +void thermal_clear_package_intr_status(int level, u64 bit_mask)
> >  {
> > +       u64 msr_val;
> >         int msr;
> > -       u64 mask, msr_val;
> > 
> >         if (level == CORE_LEVEL) {
> >                 msr  = MSR_IA32_THERM_STATUS;
> > -               mask = THERM_STATUS_CLEAR_CORE_MASK;
> > +               msr_val = THERM_STATUS_CLEAR_CORE_MASK;
> >         } else {
> >                 msr  = MSR_IA32_PACKAGE_THERM_STATUS;
> > -               mask = THERM_STATUS_CLEAR_PKG_MASK;
> > +               msr_val = THERM_STATUS_CLEAR_PKG_MASK;
> >         }
> > 
> > -       rdmsrl(msr, msr_val);
> > -       msr_val &= mask;
> > -       wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
> > +       msr_val &= ~bit_mask;
> > +       wrmsrl(msr, msr_val);
> >  }
> > +EXPORT_SYMBOL_GPL(thermal_clear_package_intr_status);
> > 
> >  static void get_therm_status(int level, bool *proc_hot, u8 *temp)
> >  {
> > @@ -295,7 +296,7 @@ static void __maybe_unused
> > throttle_active_work(struct work_struct *work)
> >         state->average = avg;
> > 
> >  re_arm:
> > -       clear_therm_status_log(state->level);
> > +       thermal_clear_package_intr_status(state->level,
> > THERM_STATUS_PROCHOT_LOG);
> >         schedule_delayed_work_on(this_cpu, &state->therm_work,
> > THERM_THROT_POLL_INTERVAL);
> >  }
> > 
> > diff --git a/drivers/thermal/intel/thermal_interrupt.h
> > b/drivers/thermal/intel/thermal_interrupt.h
> > index 01e7bed2ffc7..01dfd4cdb5df 100644
> > --- a/drivers/thermal/intel/thermal_interrupt.h
> > +++ b/drivers/thermal/intel/thermal_interrupt.h
> > @@ -2,6 +2,9 @@
> >  #ifndef _INTEL_THERMAL_INTERRUPT_H
> >  #define _INTEL_THERMAL_INTERRUPT_H
> > 
> > +#define CORE_LEVEL     0
> > +#define PACKAGE_LEVEL  1
> > +
> >  /* Interrupt Handler for package thermal thresholds */
> >  extern int (*platform_thermal_package_notify)(__u64 msr_val);
> > 
> > @@ -15,4 +18,7 @@ extern bool
> > (*platform_thermal_package_rate_control)(void);
> >  /* Handle HWP interrupt */
> >  extern void notify_hwp_interrupt(void);
> > 
> > +/* Common function to clear Package thermal status register */
> > +extern void thermal_clear_package_intr_status(int level, u64
> > bit_mask);
> > +
> >  #endif /* _INTEL_THERMAL_INTERRUPT_H */
> > diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > index a0e234fce71a..84c3a116ed04 100644
> > --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > @@ -265,7 +265,6 @@ static void
> > pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
> >         struct thermal_zone_device *tzone = NULL;
> >         int cpu = smp_processor_id();
> >         struct zone_device *zonedev;
> > -       u64 msr_val, wr_val;
> > 
> >         mutex_lock(&thermal_zone_mutex);
> >         raw_spin_lock_irq(&pkg_temp_lock);
> > @@ -279,12 +278,8 @@ static void
> > pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
> >         }
> >         zonedev->work_scheduled = false;
> > 
> > -       rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
> > -       wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 |
> > THERM_LOG_THRESHOLD1);
> > -       if (wr_val != msr_val) {
> > -               wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, wr_val);
> > -               tzone = zonedev->tzone;
> > -       }
> > +       thermal_clear_package_intr_status(PACKAGE_LEVEL,
> > THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
> > +       tzone = zonedev->tzone;
> > 
> >         enable_pkg_thres_interrupt();
> >         raw_spin_unlock_irq(&pkg_temp_lock);
> > --
> > 2.31.1
> > 

