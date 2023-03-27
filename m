Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9276CAB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjC0QyZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjC0QyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:54:09 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694E40CE;
        Mon, 27 Mar 2023 09:53:53 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id w9so38960519edc.3;
        Mon, 27 Mar 2023 09:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN+Iaybb1iiVqV2uil6/2jZC7AiW3B44s8UTj7v5RWo=;
        b=nNHlSN6bJ2IoNiK8RfuQD7oAT9WH9VEMm+F5Ly3zoYW/IgSsdrfb3X9Etc8U80M3LZ
         Gx56MHxM//z7oUBGhOY6Azbcq4SHSBwrCYok6Rio00JCJNb3ggHm/NEOByqaICYKgRGY
         /qw63QU3AJ2KkopofgXfp8gx2TatILeXeV520h0izqd7/CX0Y+1Sa9fX9KWJmC+16NBZ
         m0O/Lpxymlhvsw7FZJyTJE/M2DKrd/9qYyw3/dCpY6Y5ODtz5AJSKPrI4LhbWoT4fqhX
         dfBadT0BQVc0cM6Lr3gcVQjNeQXujZn68g8tyHj1VsjtpWXz50MdhC9/5fWrkDuUhoAQ
         Dtig==
X-Gm-Message-State: AAQBX9fFRFKpfOhqNXgXTefM/Dm+FUR3cOuAhVD7CBYHomrrlIAXQ0yU
        OeBAnL03fikf59TrsGG0UBhXKKtoj4iLGKTt5mQ=
X-Google-Smtp-Source: AKy350ZM+aevf5AXvKH2scrKR+I4K9ZvXkizJjuisW1Wx0im49PYK3bxOBS6CSwpSc+bzCM3U0vMMGHlEARdC86gkdA=
X-Received: by 2002:a50:d6d6:0:b0:4fb:c8e3:1adb with SMTP id
 l22-20020a50d6d6000000b004fbc8e31adbmr5998695edj.3.1679936031994; Mon, 27 Mar
 2023 09:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-18-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-18-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:53:40 +0200
Message-ID: <CAJZ5v0jZrW0106DR7Rk2xov--dgJsw+h7g9AGzyyrg3=_znbvQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/24] thermal: intel: hfi: Enable the Intel Thread Director
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Enable Intel Thread Director from the CPU hotplug callback: globally from
> CPU0 and then enable the thread-classification hardware in each logical
> processor individually.
>
> Also, initialize the number of classes supported.
>
> Let the scheduler know that it can start using IPC classes.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

For the changes in intel_hfi.c

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v2:
>  * Use the new sched_enable_ipc_classes() interface to enable the use of
>    IPC classes in the scheduler.
>
> Changes since v1:
>  * None
> ---
>  arch/x86/include/asm/msr-index.h  |  2 ++
>  drivers/thermal/intel/intel_hfi.c | 40 +++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index ad35355ee43e..0ea25cc9c621 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1106,6 +1106,8 @@
>  /* Hardware Feedback Interface */
>  #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
>  #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
> +#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
> +#define MSR_IA32_HW_FEEDBACK_CHAR      0x17d2
>
>  /* x2APIC locked status */
>  #define MSR_IA32_XAPIC_DISABLE_STATUS  0xBD
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 7ea6acce7107..35d947f47550 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -48,6 +48,8 @@
>  /* Hardware Feedback Interface MSR configuration bits */
>  #define HW_FEEDBACK_PTR_VALID_BIT              BIT(0)
>  #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT      BIT(0)
> +#define HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT      BIT(1)
> +#define HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT   BIT(0)
>
>  /* CPUID detection and enumeration definitions for HFI */
>
> @@ -72,6 +74,15 @@ union cpuid6_edx {
>         u32 full;
>  };
>
> +union cpuid6_ecx {
> +       struct {
> +               u32     dont_care0:8;
> +               u32     nr_classes:8;
> +               u32     dont_care1:16;
> +       } split;
> +       u32 full;
> +};
> +
>  #ifdef CONFIG_IPC_CLASSES
>  union hfi_thread_feedback_char_msr {
>         struct {
> @@ -506,6 +517,11 @@ void intel_hfi_online(unsigned int cpu)
>
>         init_hfi_cpu_index(info);
>
> +       if (cpu_feature_enabled(X86_FEATURE_ITD)) {
> +               msr_val = HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT;
> +               wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
> +       }
> +
>         /*
>          * Now check if the HFI instance of the package/die of @cpu has been
>          * initialized (by checking its header). In such case, all we have to
> @@ -561,8 +577,22 @@ void intel_hfi_online(unsigned int cpu)
>          */
>         rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
>         msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
> +
> +       if (cpu_feature_enabled(X86_FEATURE_ITD))
> +               msr_val |= HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT;
> +
>         wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
>
> +       /*
> +        * We have all we need to support IPC classes. Task classification is
> +        * now working.
> +        *
> +        * All class scores are zero until after the first HFI update. That is
> +        * OK. The scheduler queries these scores at every load balance.
> +        */
> +       if (cpu_feature_enabled(X86_FEATURE_ITD))
> +               sched_enable_ipc_classes();
> +
>  unlock:
>         mutex_unlock(&hfi_instance_lock);
>         return;
> @@ -640,8 +670,14 @@ static __init int hfi_parse_features(void)
>          */
>         hfi_features.class_stride = nr_capabilities;
>
> -       /* For now, use only one class of the HFI table */
> -       hfi_features.nr_classes = 1;
> +       if (cpu_feature_enabled(X86_FEATURE_ITD)) {
> +               union cpuid6_ecx ecx;
> +
> +               ecx.full = cpuid_ecx(CPUID_HFI_LEAF);
> +               hfi_features.nr_classes = ecx.split.nr_classes;
> +       } else {
> +               hfi_features.nr_classes = 1;
> +       }
>
>         /*
>          * The header contains change indications for each supported feature.
> --
> 2.25.1
>
