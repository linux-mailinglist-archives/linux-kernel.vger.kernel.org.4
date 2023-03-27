Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC46CAAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC0QnC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjC0Qmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:42:45 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DE269A;
        Mon, 27 Mar 2023 09:42:40 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id y4so38855166edo.2;
        Mon, 27 Mar 2023 09:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUPHgvLfynF1cW2avQZPE6tiBmDlV9HQFs1/wQ1dwVM=;
        b=eoPMcnkC9rM06FqUv0sPMik9DZMBBtJWMDD0M1esxNmyTefZVqoxAt9uam7QYF9GjC
         H09dU2AMlCR+n1HYObC8igf8oQgIF7lf8Byxgz6oBKnG7+1yS7+Ydasog/mr6kitcvNp
         UYsE84Xb+ZueMC7OEWvyg4kMxLTw+4F+s6Mh2ljhgf4oQQjXlHmfYszCVZCAcwhVcw47
         Pa+LSIGGQksXpJQQwVLbk3JQwvbT5AEap42xNO9uGEU5gXpf3DuV8bRjstQXJHmiN54g
         pc+EGqo+vQ05R3DC4l1eJFyFO/iwTgjFd+ZQz5h2JHw8Je63KrWdu6JWPJ1D9B0apeln
         qzyQ==
X-Gm-Message-State: AAQBX9eVkACzBkA4gFqcpHzKA4qFGWtTKTVj3MCxPxdfd24NpIISbr/t
        SWxDnun/qsTaO/tFD1WlSDyVwWugqJGsAN8i8xM=
X-Google-Smtp-Source: AKy350b72okw9liyVfLi4WzanTU70F/d4X8oDQ6ArNMbl9jCRmQNvcZbkkmCL2nUxLcxWsROTyahAtKojt+G8XvFC04=
X-Received: by 2002:a50:d54f:0:b0:502:4f7:d287 with SMTP id
 f15-20020a50d54f000000b0050204f7d287mr6090063edj.3.1679935359304; Mon, 27 Mar
 2023 09:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-15-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-15-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:42:28 +0200
Message-ID: <CAJZ5v0hGKKPiK86Z5PcG-EEHU7a=3d-4S2miRqNPuwjS1tF0BQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/24] thermal: intel: hfi: Update the IPC class of the
 current task
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
> Use Intel Thread Director classification to update the IPC class of a
> task. Implement the arch_update_ipcc() interface of the scheduler.
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
> ---
> Changes since v2:
>  * Removed the implementation of arch_has_ipc_classes().
>
> Changes since v1:
>  * Adjusted the result the classification of Intel Thread Director to start
>    at class 1. Class 0 for the scheduler means that the task is
>    unclassified.
>  * Redefined union hfi_thread_feedback_char_msr to ensure all
>    bit-fields are packed. (PeterZ)
>  * Removed CONFIG_INTEL_THREAD_DIRECTOR. (PeterZ)
>  * Shortened the names of the functions that implement IPC classes.
>  * Removed argument smt_siblings_idle from intel_hfi_update_ipcc().
>    (PeterZ)
> ---
>  arch/x86/include/asm/topology.h   |  6 ++++++
>  drivers/thermal/intel/intel_hfi.c | 32 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 458c891a8273..ffcdac3f398f 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -227,4 +227,10 @@ void init_freq_invariance_cppc(void);
>  #define arch_init_invariance_cppc init_freq_invariance_cppc
>  #endif
>
> +#if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
> +void intel_hfi_update_ipcc(struct task_struct *curr);
> +
> +#define arch_update_ipcc intel_hfi_update_ipcc
> +#endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
> +
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index b06021828892..530dcf57e06e 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -72,6 +72,17 @@ union cpuid6_edx {
>         u32 full;
>  };
>
> +#ifdef CONFIG_IPC_CLASSES
> +union hfi_thread_feedback_char_msr {
> +       struct {
> +               u64     classid : 8;
> +               u64     __reserved : 55;
> +               u64     valid : 1;
> +       } split;
> +       u64 full;
> +};
> +#endif
> +
>  /**
>   * struct hfi_cpu_data - HFI capabilities per CPU
>   * @perf_cap:          Performance capability
> @@ -174,6 +185,27 @@ static struct workqueue_struct *hfi_updates_wq;
>  #ifdef CONFIG_IPC_CLASSES
>  static int __percpu *hfi_ipcc_scores;
>
> +void intel_hfi_update_ipcc(struct task_struct *curr)
> +{
> +       union hfi_thread_feedback_char_msr msr;
> +
> +       /* We should not be here if ITD is not supported. */
> +       if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
> +               pr_warn_once("task classification requested but not supported!");
> +               return;
> +       }
> +
> +       rdmsrl(MSR_IA32_HW_FEEDBACK_CHAR, msr.full);
> +       if (!msr.split.valid)
> +               return;
> +
> +       /*
> +        * 0 is a valid classification for Intel Thread Director. A scheduler
> +        * IPCC class of 0 means that the task is unclassified. Adjust.
> +        */
> +       curr->ipcc = msr.split.classid + 1;
> +}

Wouldn't it be better to return the adjusted value from this function
and let the caller store it where appropriate?

It doesn't look like it is necessary to pass the task_struct pointer to it.

> +
>  static int alloc_hfi_ipcc_scores(void)
>  {
>         if (!cpu_feature_enabled(X86_FEATURE_ITD))
> --
