Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCA6DE0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDKQSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDKQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:17:53 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689345251;
        Tue, 11 Apr 2023 09:16:57 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id gb34so21958028ejc.12;
        Tue, 11 Apr 2023 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681229816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3ITv/vwrFDX7sYlzoF644RlJZcwlzODzuaMxOLuck8=;
        b=tKDdwxiVRX5/QTrfCpBOZ/KytM9uQqpvQ+U9NOj/iyfkPgmuLMfbXOyO+Sc9eGqpO1
         3WdxNQgvlgJ8SGPF7/NOY5ABmxgYfxpYDKad0aXKoV7Agfr30uR8IZ5fnipZVRb1O/Db
         FlN0yrRvHQ/BG+xmj/gv5fVlCg2FJZirN33mPAgHTfOafSUM8AhylW9dwkxIVYhNmofh
         mY+DrVXPv3rqVcsIG844oDnMucgqUwCcVtk/2K4L7sMxYeGkyygR7tnmqXgSMd+sFMvN
         IkcbPCkTRmWFBQWMKBUzEQzi2ve0CdTXKhYzjuUQq1WO1Bb7AFGAknfx6XisNnm/wSf7
         pagQ==
X-Gm-Message-State: AAQBX9dzlE3zWLry+qtL2JqikvpsP1Br/EmbdVHi8JPg1FmEDOKyX7q3
        sDyxTQzxB/j6bDgmQDNKLtLStmEUyjZhSokYJa4=
X-Google-Smtp-Source: AKy350ZjuHx4d562qUue3FORfHEXX3QonWvdKxaU+gmEhl8iQtoJ6Ly+7aQw3jmu/6b9ujlBdFoyamBkfah7pbj2XvQ=
X-Received: by 2002:a17:907:6287:b0:93e:c1ab:ae67 with SMTP id
 nd7-20020a170907628700b0093ec1abae67mr5882234ejc.2.1681229815612; Tue, 11 Apr
 2023 09:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230410173501.3743570-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230410173501.3743570-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 18:16:44 +0200
Message-ID: <CAJZ5v0iAHY6pOQb2N=AQbks7JKnVa1T29-zTT1XFBcVXEdZuwg@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Fix unchecked MSR issue
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, Rui Salvaterra <rsalvaterra@gmail.com>,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 7:35 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Some older processors don't allow BIT(13) and BIT(15) in the current
> mask set by "THERM_STATUS_CLEAR_CORE_MASK". This results in:
>
> unchecked MSR access error: WRMSR to 0x19c (tried to
> write 0x000000000000aaa8) at rIP: 0xffffffff816f66a6
> (throttle_active_work+0xa6/0x1d0)
>
> To avoid unchecked MSR issues, check cpuid for each feature and then
> form core mask. Do the same for package mask set by
> "THERM_STATUS_CLEAR_PKG_MASK".
>
> Introduce functions thermal_intr_core_clear_mask() and
> thermal_intr_pkg_clear_mask()

I've renamed these two functions to
thermal_intr_init_core_clear_mask() and
thermal_intr_init_pkg_clear_mask(), respectively.

> to set core and package mask respectively.
> These functions are called during initialization.
>
> Fixes: 6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI status")
> Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Link: https://lore.kernel.org/lkml/cdf43fb423368ee3994124a9e8c9b4f8d00712c6.camel@linux.intel.com/T/
> Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@kernel.org # 6.2+
> ---
>  drivers/thermal/intel/therm_throt.c | 73 ++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
> index 2e22bb82b738..d5047676f3d2 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -193,8 +193,67 @@ static const struct attribute_group thermal_attr_group = {
>  #define THERM_THROT_POLL_INTERVAL      HZ
>  #define THERM_STATUS_PROCHOT_LOG       BIT(1)
>
> -#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
> -#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
> +static u64 def_therm_core_clear_mask;
> +static u64 def_therm_pkg_clear_mask;

And I've renamed these two variables to therm_intr_core_clear_mask and
therm_intr_pkg_clear_mask, respectively.

Also I've changed the subject (to "thermal: intel: Avoid updating
unsupported THERM_STATUS_CLEAR mask bits") and made some assorted
changelog edits.

With the above changes, the patch has been queued up for 6.3-rc7.

> +
> +static void thermal_intr_core_clear_mask(void)
> +{
> +       if (def_therm_core_clear_mask)
> +               return;
> +
> +       /*
> +        * Reference: Intel SDM  Volume 4
> +        * "Table 2-2. IA-32 Architectural MSRs", MSR 0x19C
> +        * IA32_THERM_STATUS.
> +        */
> +
> +       /*
> +        * Bit 1, 3, 5: CPUID.01H:EDX[22] = 1. This driver will not
> +        * enable interrupts, when 0 as it checks for X86_FEATURE_ACPI.
> +        */
> +       def_therm_core_clear_mask = (BIT(1) | BIT(3) | BIT(5));
> +
> +       /*
> +        * Bit 7 and 9: Thermal Threshold #1 and #2 log
> +        * If CPUID.01H:ECX[8] = 1
> +        */
> +       if (boot_cpu_has(X86_FEATURE_TM2))
> +               def_therm_core_clear_mask |= (BIT(7) | BIT(9));
> +
> +       /* Bit 11: Power Limitation log (R/WC0) If CPUID.06H:EAX[4] = 1 */
> +       if (boot_cpu_has(X86_FEATURE_PLN))
> +               def_therm_core_clear_mask |= BIT(11);
> +
> +       /*
> +        * Bit 13: Current Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
> +        * Bit 15: Cross Domain Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
> +        */
> +       if (boot_cpu_has(X86_FEATURE_HWP))
> +               def_therm_core_clear_mask |= (BIT(13) | BIT(15));
> +}
> +
> +static void thermal_intr_pkg_clear_mask(void)
> +{
> +       if (def_therm_pkg_clear_mask)
> +               return;
> +
> +       /*
> +        * Reference: Intel SDM  Volume 4
> +        * "Table 2-2. IA-32 Architectural MSRs", MSR 0x1B1
> +        * IA32_PACKAGE_THERM_STATUS.
> +        */
> +
> +       /* All bits except BIT 26 depends on CPUID.06H: EAX[6] = 1 */
> +       if (boot_cpu_has(X86_FEATURE_PTS))
> +               def_therm_pkg_clear_mask = (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11));
> +
> +       /*
> +        * Intel SDM Volume 2A: Thermal and Power Management Leaf
> +        * Bit 26: CPUID.06H: EAX[19] = 1
> +        */
> +       if (boot_cpu_has(X86_FEATURE_HFI))
> +               def_therm_pkg_clear_mask |= BIT(26);
> +}
>
>  /*
>   * Clear the bits in package thermal status register for bit = 1
> @@ -207,13 +266,10 @@ void thermal_clear_package_intr_status(int level, u64 bit_mask)
>
>         if (level == CORE_LEVEL) {
>                 msr  = MSR_IA32_THERM_STATUS;
> -               msr_val = THERM_STATUS_CLEAR_CORE_MASK;
> +               msr_val = def_therm_core_clear_mask;
>         } else {
>                 msr  = MSR_IA32_PACKAGE_THERM_STATUS;
> -               msr_val = THERM_STATUS_CLEAR_PKG_MASK;
> -               if (boot_cpu_has(X86_FEATURE_HFI))
> -                       msr_val |= BIT(26);
> -
> +               msr_val = def_therm_pkg_clear_mask;
>         }
>
>         msr_val &= ~bit_mask;
> @@ -708,6 +764,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
>         h = THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
>         apic_write(APIC_LVTTHMR, h);
>
> +       thermal_intr_core_clear_mask();
> +       thermal_intr_pkg_clear_mask();
> +
>         rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
>         if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
>                 wrmsr(MSR_IA32_THERM_INTERRUPT,
> --
> 2.39.1
>
