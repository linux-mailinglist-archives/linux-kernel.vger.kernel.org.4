Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48786CAAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjC0Qhs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjC0Qhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:37:46 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0C268F;
        Mon, 27 Mar 2023 09:37:44 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id y4so38798017edo.2;
        Mon, 27 Mar 2023 09:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCUgcNjEyWvD6sTwdUsnBUalyH9Ao6KbTN9qB87isrs=;
        b=liZ09ojyiPa/c3FjJXr7uEle7/0fEtLJTJjVcwQh9+788V7S+MGzRhq1EwpiAQSmpV
         QFO8HFNpEQjZIQ5yeVt5vm7DSawuphA+rHoiPsTi+CrnHNaPcXXSeJSxYcmimuSzLZnB
         lhwZ+rv4mAD1QyVlRH57cca9PKh0cjG+tC9oIFQbytFOWMXqc/OiZIngRaShoI3YJWT3
         bQbecOVD/O6czpSlBfNXZKNxsdSkwIUegG7kUYncQAY7kmW1TCy+IKKUqqvizDi4UFsK
         G3W8gAv9xbxlGsQX35DV+VqbK2rjQbJBG2/uCX+KOxkUgscSOJxLVn96I4Y2HBche0EX
         OLhw==
X-Gm-Message-State: AAQBX9eTYWUDeiUvkmpjTZBv3eGPJL0iP36vApX7uCOVvcNPE1zWagOX
        SJ4AR+G0orFAVvabSM4q2o2KJIIlxhsCOnPT+KU=
X-Google-Smtp-Source: AKy350bm4a5N//wgIe5Wng8uUcDgLjI5L6PYP4mpAWWYjRulhFdv87bGt6Yikb1YiDdE1xG01SmMwN+2H3RGgLEmUqk=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr5066951ejc.2.1679935063106; Mon, 27
 Mar 2023 09:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-14-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-14-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:37:32 +0200
Message-ID: <CAJZ5v0hooaHtM8=KCx6XYZjPFh66kVBSbPTX4GwiMTgovxoVzg@mail.gmail.com>
Subject: Re: [PATCH v3 13/24] thermal: intel: hfi: Store per-CPU IPCC scores
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
> The scheduler reads the IPCC scores when balancing load. These reads can
> be quite frequent. Hardware can also update the HFI table frequently.
> Concurrent access may cause a lot of lock contention. It gets worse as the
> number of CPUs increases.
>
> Instead, create separate per-CPU IPCC scores that the scheduler can read
> without the HFI table lock.
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
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  * Only create these per-CPU variables when Intel Thread Director is
>    supported.
>
> Changes since v1:
>  * Added this patch.
> ---
>  drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 2527ae3836c7..b06021828892 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -29,6 +29,7 @@
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/mutex.h>
> +#include <linux/percpu.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
> @@ -170,6 +171,43 @@ static struct workqueue_struct *hfi_updates_wq;
>  #define HFI_UPDATE_INTERVAL            HZ
>  #define HFI_MAX_THERM_NOTIFY_COUNT     16
>
> +#ifdef CONFIG_IPC_CLASSES

It would be good to provide a (concise) description of this variable.

> +static int __percpu *hfi_ipcc_scores;
> +
> +static int alloc_hfi_ipcc_scores(void)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_ITD))
> +               return 0;
> +
> +       hfi_ipcc_scores = __alloc_percpu(sizeof(*hfi_ipcc_scores) *
> +                                        hfi_features.nr_classes,
> +                                        sizeof(*hfi_ipcc_scores));
> +
> +       return !hfi_ipcc_scores;

I would do

if (!hfi_ipcc_scores)
        return -ENOMEM;

return 0;

Or make the function return bool.

> +}
> +
> +static void set_hfi_ipcc_score(void *caps, int cpu)
> +{
> +       int i, *hfi_class;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_ITD))
> +               return;
> +
> +       hfi_class = per_cpu_ptr(hfi_ipcc_scores, cpu);
> +
> +       for (i = 0;  i < hfi_features.nr_classes; i++) {
> +               struct hfi_cpu_data *class_caps;
> +
> +               class_caps = caps + i * hfi_features.class_stride;
> +               WRITE_ONCE(hfi_class[i], class_caps->perf_cap);

As it stands, it is unclear why WRITE_ONCE() is needed here.

> +       }
> +}
> +
> +#else
> +static int alloc_hfi_ipcc_scores(void) { return 0; }
> +static void set_hfi_ipcc_score(void *caps, int cpu) { }
> +#endif /* CONFIG_IPC_CLASSES */
> +
>  static void get_hfi_caps(struct hfi_instance *hfi_instance,
>                          struct thermal_genl_cpu_caps *cpu_caps)
>  {
> @@ -192,6 +230,8 @@ static void get_hfi_caps(struct hfi_instance *hfi_instance,
>                 cpu_caps[i].efficiency = caps->ee_cap << 2;
>
>                 ++i;
> +
> +               set_hfi_ipcc_score(caps, cpu);
>         }
>         raw_spin_unlock_irq(&hfi_instance->table_lock);
>  }
> @@ -580,8 +620,14 @@ void __init intel_hfi_init(void)
>         if (!hfi_updates_wq)
>                 goto err_nomem;
>
> +       if (alloc_hfi_ipcc_scores())
> +               goto err_ipcc;
> +
>         return;
>
> +err_ipcc:
> +       destroy_workqueue(hfi_updates_wq);
> +
>  err_nomem:
>         for (j = 0; j < i; ++j) {
>                 hfi_instance = &hfi_instances[j];
> --
