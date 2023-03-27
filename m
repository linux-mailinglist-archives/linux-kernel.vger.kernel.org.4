Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458DA6CAB79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjC0RFV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjC0RFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:05:02 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE2659E;
        Mon, 27 Mar 2023 10:03:40 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id b20so39094090edd.1;
        Mon, 27 Mar 2023 10:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrDYYOMYb+x8U/wfL/PFhG97cTznz+G4jcEke1v/IHU=;
        b=EwbSTXreQsrMaHpCFAoZ4myc0v9x3hDILiBAVzvBtLhWJ4a7be3+nyBi2cA3OT8kb1
         gH3KlFfbu3NF99r9i1AKa3V8qoow7ZygUs4bcSjJ47PEy39Mc41wwJHJkvNai7DY1lsx
         2xt5ulPeQ2GV7lleDox46L27PwzX2L5zRjPnZk9KV31JqOwdme1ktBHQZokb/W2NtoOf
         O9u/rr6QS8k0/jmuUXOPbe3I+JYb/3JMFEAuLm/ERpXqsvUws/el34GpYDcsdl0aQn8X
         1Gb/Dm4dpgOLbTsBxm2NMiC0MKTjagkPcnAJNSU/ojTRWocPpq/F7QwrbRRH2QXum19k
         lQ2Q==
X-Gm-Message-State: AAQBX9c7NddHwgEXVqwzScSUudcA8GGfxHOJGe9iSWRRXDXi13MFtoRJ
        jSV0Wxna18KutGb4FNYQuc7RuwKSTCcbO8Mw3ghrZ6NG
X-Google-Smtp-Source: AKy350YxZ9UwICWr6Z8iBfwYyXlNdUeDwwOy0xuisjczUTXuz9epYy1WkEmilorXcZnLu0BVS6UEYLiCBrH7r6ZgGGM=
X-Received: by 2002:a50:d54f:0:b0:502:4f7:d287 with SMTP id
 f15-20020a50d54f000000b0050204f7d287mr6124726edj.3.1679936599286; Mon, 27 Mar
 2023 10:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-22-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-22-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:03:08 +0200
Message-ID: <CAJZ5v0hxKg_u4GKMkdGEp-JbvnymEtxSZT7fB2kbhWoQFSK1fw@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] thermal: intel: hfi: Implement model-specific
 checks for task classification
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
> In Alder Lake and Raptor Lake, the result of thread classification is more
> accurate when only one SMT sibling is busy. Classification results for
> class 2 and 3 are always reliable.
>
> To avoid unnecessary migrations, only update the class of a task if it has
> been the same during 4 consecutive user ticks.
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
>  * None
>
> Changes since v1:
>  * Adjusted the result the classification of Intel Thread Director to start
>    at class 1. Class 0 for the scheduler means that the task is
>    unclassified.
>  * Used the new names of the IPC classes members in task_struct.
>  * Reworked helper functions to use sched_smt_siblings_idle() to query
>    the idle state of the SMT siblings of a CPU.
> ---
>  drivers/thermal/intel/intel_hfi.c | 60 ++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 35d947f47550..fdb53e4cabc1 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -40,6 +40,7 @@
>  #include <linux/workqueue.h>
>
>  #include <asm/msr.h>
> +#include <asm/intel-family.h>
>
>  #include "../thermal_core.h"
>  #include "intel_hfi.h"
> @@ -209,9 +210,64 @@ static int __percpu *hfi_ipcc_scores;
>   */
>  #define HFI_UNCLASSIFIED_DEFAULT 1
>
> +#define CLASS_DEBOUNCER_SKIPS 4
> +
> +/**
> + * debounce_and_update_class() - Process and update a task's classification
> + *
> + * @p:         The task of which the classification will be updated
> + * @new_ipcc:  The new IPC classification
> + *
> + * Update the classification of @p with the new value that hardware provides.
> + * Only update the classification of @p if it has been the same during
> + * CLASS_DEBOUNCER_SKIPS consecutive ticks.
> + */
> +static void debounce_and_update_class(struct task_struct *p, u8 new_ipcc)
> +{
> +       u16 debounce_skip;
> +
> +       /* The class of @p changed. Only restart the debounce counter. */
> +       if (p->ipcc_tmp != new_ipcc) {
> +               p->ipcc_cntr = 1;
> +               goto out;
> +       }
> +
> +       /*
> +        * The class of @p did not change. Update it if it has been the same
> +        * for CLASS_DEBOUNCER_SKIPS user ticks.
> +        */
> +       debounce_skip = p->ipcc_cntr + 1;
> +       if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
> +               p->ipcc_cntr++;
> +       else
> +               p->ipcc = new_ipcc;
> +
> +out:
> +       p->ipcc_tmp = new_ipcc;
> +}

Why does the code above belong to the Intel HFI driver?  It doesn't
look like there is anything driver-specific in it.

> +
> +static bool classification_is_accurate(u8 hfi_class, bool smt_siblings_idle)
> +{
> +       switch (boot_cpu_data.x86_model) {
> +       case INTEL_FAM6_ALDERLAKE:
> +       case INTEL_FAM6_ALDERLAKE_L:
> +       case INTEL_FAM6_RAPTORLAKE:
> +       case INTEL_FAM6_RAPTORLAKE_P:
> +       case INTEL_FAM6_RAPTORLAKE_S:
> +               if (hfi_class == 3 || hfi_class == 2 || smt_siblings_idle)
> +                       return true;
> +
> +               return false;
> +
> +       default:
> +               return true;
> +       }
> +}
> +
>  void intel_hfi_update_ipcc(struct task_struct *curr)
>  {
>         union hfi_thread_feedback_char_msr msr;
> +       bool idle;
>
>         /* We should not be here if ITD is not supported. */
>         if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
> @@ -227,7 +283,9 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
>          * 0 is a valid classification for Intel Thread Director. A scheduler
>          * IPCC class of 0 means that the task is unclassified. Adjust.
>          */
> -       curr->ipcc = msr.split.classid + 1;
> +       idle = sched_smt_siblings_idle(task_cpu(curr));
> +       if (classification_is_accurate(msr.split.classid, idle))
> +               debounce_and_update_class(curr, msr.split.classid + 1);
>  }

I still think that this function should just return a number, possibly
including a special "no IPCC" value.  It may be passed a bool argument
indicating whether or not the SMT siblings are idle.

>
>  unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
> --
