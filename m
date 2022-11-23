Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2334E6369B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiKWTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiKWTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:15:10 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9AC285C;
        Wed, 23 Nov 2022 11:15:08 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id h7so12193841qvs.3;
        Wed, 23 Nov 2022 11:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3o6MkKq/7S4rIf80AzBAsCBUSmJmfeCflELllVHs1U=;
        b=BYE4wsvQ9tGuNq15Znon/tYiENs8Y1knDYKhkpn1QG3EhDvagF/Z4zSxERyWERKLcK
         jGkiv/H6gKIwUhpa/yjA5yHDd6reI3KDMURJnt+5ChWygKEzBmYLdkVWSDlfuy3hlHii
         webf3XXdrjayPexsv64u8oV50vIBd1lkgxO7vdJyxeBFn8otwL/zkwlMWwzjvonQVu6Z
         V5R/sTJa0ycllAjDUxIbk0dDHdzt43udw16WR8qwC9nXkaEqLkYR4mVTexecPDaEc3BT
         mmtTjlezJgbcxbTtt0rPEZjudZaTZWthFxJMbgoPQzRNEU+91HKQ0bQJ5ndAUadqKbH7
         6sgw==
X-Gm-Message-State: ANoB5pmpgALeN4IXDuxWJcYNoTtKoRX9Pwn/74Y3K6Wsu4IgABTT+MRu
        5efphvkn6e9TBUA23RW5ZrWSZrG8zKqtQ7qhvpY=
X-Google-Smtp-Source: AA0mqf5hAfGrtvhmz5pPQ7mNcI2INM++ldabPtqJwMbahFDutKUZ401EwKCs+ngBTYUI2ShzzlMVX9LJPRUV8T17xoc=
X-Received: by 2002:a0c:ed50:0:b0:4bb:f952:c799 with SMTP id
 v16-20020a0ced50000000b004bbf952c799mr9636772qvq.3.1669230907328; Wed, 23 Nov
 2022 11:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20221116231459.2632710-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221116231459.2632710-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 20:14:56 +0100
Message-ID: <CAJZ5v0isKTVG--+PDzDDt=NRuySbwATiwdeFbkVA3C0hMgUiow@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: hfi: ACK HFI for the same timestamp
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Adeel <adeel.arshad@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:15 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Some processors issue more than one HFI interrupt with the same
> timestamp. Each interrupt must be acknowledged to let the hardware issue
> new HFI interrupts. But this can't be done without some additional flow
> modification in the existing interrupt handling.
>
> For background, the HFI interrupt is a package level thermal interrupt
> delivered via a LVT. This LVT is common for both the CPU and package
> level interrupts. Hence, all CPUs receive the HFI interrupts. But only
> one CPU should process interrupt and others simply exit by issuing EOI
> to LAPIC.
>
> The current HFI interrupt processing flow:
>
> 1. Receive Thermal interrupt
> 2. Check if there is an active HFI status in MSR_IA32_THERM_STATUS
> 3. Try and get spinlock, one CPU will enter spinlock and others
> will simply return from here to issue EOI.
>    (Let's assume CPU 4 is processing interrupt)
> 4. Check the stored time-stamp from the HFI memory time-stamp
> 5. if same
> 6.      ignore interrupt, unlock and return
> 7. Copy the HFI message to local buffer
> 8. unlock spinlock
> 9. ACK HFI interrupt
> 10. Queue the message for processing in a work-queue
>
> It is tempting to simply acknowledge all the interrupts even if they
> have the same timestamp. This may cause some interrupts to not be
> processed.
>
> Let's say CPU5 is slightly late and reaches step 4 while CPU4 is
> between steps 8 and 9.
>
> Currently we simply ignore interrupts with the same timestamp. No
> issue here for CPU5. When CPU4 acknowledges the interrupt, the next
> HFI interrupt can be delivered.
>
> If we acknowledge interrupts with the same timestamp (at step 6), there
> is a race condition. Under the same scenario, CPU 5 will acknowledge
> the HFI interrupt. This lets hardware generate another HFI interrupt,
> before CPU 4 start executing step 9. Once CPU 4 complete step 9, it
> will acknowledge the newly arrived HFI interrupt, without actually
> processing it.
>
> Acknowledge the interrupt when holding the spinlock. This avoids
> contention of the interrupt acknowledgment.
>
> Updated flow:
>
> 1. Receive HFI Thermal interrupt
> 2. Check if there is an active HFI status in MSR_IA32_THERM_STATUS
> 3. Try and get spin-lock
>    Let's assume CPU 4 is processing interrupt
> 4.1 Read MSR_IA32_PACKAGE_THERM_STATUS and check HFI status bit
> 4.2     If hfi status is 0
> 4.3             unlock spinlock
> 4.4             return
> 4.5 Check the stored time-stamp from the HFI memory time-stamp
> 5. if same
> 6.1      ACK HFI Interrupt,
> 6.2     unlock spinlock
> 6.3     return
> 7. Copy the HFI message to local buffer
> 8. ACK HFI interrupt
> 9. unlock spinlock
> 10. Queue the message for processing in a work-queue
>
> To avoid taking the lock unnecessarily, intel_hfi_process_event() checks
> the status of the HFI interrupt before taking the lock. If CPU5 is late,
> when it starts processing the interrupt there are two scenarios:
>
> a) CPU4 acknowledged the HFI interrupt before CPU5 read
> MSR_IA32_THERM_STATUS. CPU5 exits.
>
> b) CPU5 reads MSR_IA32_THERM_STATUS before CPU4 has acknowledged the
> interrupt. CPU5 will take the lock if CPU4 has released it. It then
> re-reads MSR_IA32_THERM_STATUS. If there is not a new interrupt, the HFI
> status bit is clear and CPU5 exits. If a new HFI interrupt was generated
> it will find that the status bit is set and it will continue to process
> the interrupt. In this case even if timestamp is not changed, the ACK
> can be issued as this is a new interrupt.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Tested-by: Arshad, Adeel<adeel.arshad@intel.com>
> ---
> This patch depends on two other patches posted before:
> [PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing of HFI status
> [PATCH RESEND 2/2] thermal: intel: Protect clearing of thermal status bits
>
>  drivers/thermal/intel/intel_hfi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index c9e0827c9ebe..c543a967cd50 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -250,7 +250,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
>         struct hfi_instance *hfi_instance;
>         int cpu = smp_processor_id();
>         struct hfi_cpu_info *info;
> -       u64 new_timestamp;
> +       u64 new_timestamp, msr, hfi;
>
>         if (!pkg_therm_status_msr_val)
>                 return;
> @@ -279,9 +279,21 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
>         if (!raw_spin_trylock(&hfi_instance->event_lock))
>                 return;
>
> -       /* Skip duplicated updates. */
> +       rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr);
> +       hfi = msr & PACKAGE_THERM_STATUS_HFI_UPDATED;
> +       if (!hfi) {
> +               raw_spin_unlock(&hfi_instance->event_lock);
> +               return;
> +       }
> +
> +       /*
> +        * Ack duplicate update. Since there is an active HFI
> +        * status from HW, it must be a new event, not a case
> +        * where a lagging CPU entered the locked region.
> +        */
>         new_timestamp = *(u64 *)hfi_instance->hw_table;
>         if (*hfi_instance->timestamp == new_timestamp) {
> +               thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
>                 raw_spin_unlock(&hfi_instance->event_lock);
>                 return;
>         }
> @@ -295,15 +307,15 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
>         memcpy(hfi_instance->local_table, hfi_instance->hw_table,
>                hfi_features.nr_table_pages << PAGE_SHIFT);
>
> -       raw_spin_unlock(&hfi_instance->table_lock);
> -       raw_spin_unlock(&hfi_instance->event_lock);
> -
>         /*
>          * Let hardware know that we are done reading the HFI table and it is
>          * free to update it again.
>          */
>         thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
>
> +       raw_spin_unlock(&hfi_instance->table_lock);
> +       raw_spin_unlock(&hfi_instance->event_lock);
> +
>         queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
>                            HFI_UPDATE_INTERVAL);
>  }
> --

Applied as 6.2 material, thanks!
