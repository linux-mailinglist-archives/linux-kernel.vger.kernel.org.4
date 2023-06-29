Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C358E742C86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjF2Sxy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjF2Sxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:53:45 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A3E4B;
        Thu, 29 Jun 2023 11:53:44 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98e1fc9d130so27908966b.0;
        Thu, 29 Jun 2023 11:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064823; x=1690656823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laGLrkBdlR4pzlW7ZgruwiIg0n1c0MsEO99gwzd8a6U=;
        b=RCn1M6dIvNQ1FIyfzgZfmEJDQnMtEIKjgtor+95jfk/oy4UGtSRYX63WKeX0EfzmdZ
         ivzR7quiT7F7YtVD6xeexpxVcuqoYwLnIq0qb8WJu0hF48ppM4wqtiux5zQdfJE5KIQ0
         U+YAReUr9DVgTlUdhv2951aM1ZxGgDOxIKipSfn6AUo4PGU5b/z8u/FoEU97CHmLBn2V
         qecTI3vcypM8mLs2pLIVd5pqB5qSQwj4673xJkAQd0sA54zrc1fOd1wM+fpX5+tvtIAW
         UQbKslRaaLCXf0tq9FU1ofe9M7cS6zpCiP/1+AyGnmMq0CyeVXujy3Au/WZer38Z2wPt
         XCkQ==
X-Gm-Message-State: ABy/qLbRBXACgi9zgdPTXnLtkUMqchpY29BH9+E3AkuCtKIRuZgHfxxw
        oz+ofHg4o2BhGEb16QhgTHSfM7OfQUB/yYZoxHo=
X-Google-Smtp-Source: ACHHUZ6DF541aWQRsCqsBI2gxIHf5q4Rej8BsX/FMRbeJYUzns1av64A4trkrK/40VW+7nVSVcvKv6NDcmw4n0Ob+I8=
X-Received: by 2002:a17:906:35c5:b0:988:8220:2af0 with SMTP id
 p5-20020a17090635c500b0098882202af0mr252553ejb.5.1688064822642; Thu, 29 Jun
 2023 11:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com> <20230613042422.5344-15-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230613042422.5344-15-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 20:53:31 +0200
Message-ID: <CAJZ5v0hRCJTwcZm2ZCzA3sZZce-FBU9-zaApsDqJ_3oE=qAmKg@mail.gmail.com>
Subject: Re: [PATCH v4 14/24] thermal: intel: hfi: Store per-CPU IPCC scores
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 6:23 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The scheduler reads the IPCC scores when balancing load. These reads can
> occur frequently and originate from many CPUs. Hardware may also
> occasionally update the HFI table. Controlling access with locks would
> cause contention.
>
> Cache the IPCC scores in separate per-CPU variables that the scheduler can
> use. Use a seqcount to synchronize memory accesses to these cached values.
> This eliminates the need for locks, as the sequence counter provides the
> memory ordering required to prevent the use of stale data.
>
> The HFI delayed workqueue guarantees that only one CPU writes the cached
> IPCC scores. The frequency of updates is low (every CONFIG_HZ jiffies or
> less), and the number of writes per update is in the order of tens. Writes
> should not starve reads.
>
> Only cache IPCC scores in this changeset. A subsequent changeset will
> use these scores.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Perry Yuan <Perry.Yuan@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v3:
>  * As Rafael requested, I reworked the memory ordering of the cached IPCC
>    scores. I selected a seqcount as is less expensive than a memory
>    barrier, which is not necessary anyways.
>  * Made alloc_hfi_ipcc_scores() return -ENOMEM on allocation failure.
>    (Rafael)
>  * Added a comment to describe hfi_ipcc_scores. (Rafael)
>
> Changes since v2:
>  * Only create these per-CPU variables when Intel Thread Director is
>    supported.
>
> Changes since v1:
>  * Added this patch.
> ---
>  drivers/thermal/intel/intel_hfi.c | 66 +++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 20ee4264dcd4..d822ed0bb5c1 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -29,9 +29,11 @@
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/mutex.h>
> +#include <linux/percpu.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/printk.h>
>  #include <linux/processor.h>
> +#include <linux/seqlock.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> @@ -180,6 +182,62 @@ static struct workqueue_struct *hfi_updates_wq;
>  #define HFI_UPDATE_INTERVAL            HZ
>  #define HFI_MAX_THERM_NOTIFY_COUNT     16
>
> +/* A cache of the HFI perf capabilities for lockless access. */
> +static int __percpu *hfi_ipcc_scores;
> +/* Sequence counter for hfi_ipcc_scores */
> +static seqcount_t hfi_ipcc_seqcount = SEQCNT_ZERO(hfi_ipcc_seqcount);
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
> +       return hfi_ipcc_scores ? 0 : -ENOMEM;
> +}

This doesn't need to return an int.  It could be a bool function
returning !!hfi_ipcc_scores (or false for the feature missing case).

Apart from this minor thing, the patch looks reasonable to me.

> +
> +static void set_hfi_ipcc_scores(struct hfi_instance *hfi_instance)
> +{
> +       int cpu;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_ITD))
> +               return;
> +
> +       /*
> +        * Serialize with writes to the HFI table. It also protects the write
> +        * loop against seqcount readers running in interrupt context.
> +        */
> +       raw_spin_lock_irq(&hfi_instance->table_lock);
> +       /*
> +        * The seqcount implies store-release semantics to order stores with
> +        * lockless loads from the seqcount read side. It also implies a
> +        * compiler barrier.
> +        */
> +       write_seqcount_begin(&hfi_ipcc_seqcount);
> +       for_each_cpu(cpu, hfi_instance->cpus) {
> +               int c, *scores;
> +               s16 index;
> +
> +               index = per_cpu(hfi_cpu_info, cpu).index;
> +               scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
> +
> +               for (c = 0;  c < hfi_features.nr_classes; c++) {
> +                       struct hfi_cpu_data *caps;
> +
> +                       caps = hfi_instance->data +
> +                              index * hfi_features.cpu_stride +
> +                              c * hfi_features.class_stride;
> +                       scores[c] = caps->perf_cap;
> +               }
> +       }
> +
> +       write_seqcount_end(&hfi_ipcc_seqcount);
> +       raw_spin_unlock_irq(&hfi_instance->table_lock);
> +}
> +
>  /**
>   * intel_hfi_read_classid() - Read the currrent classid
>   * @classid:   Variable to which the classid will be written.
> @@ -275,6 +333,8 @@ static void update_capabilities(struct hfi_instance *hfi_instance)
>                 thermal_genl_cpu_capability_event(cpu_count, &cpu_caps[i]);
>
>         kfree(cpu_caps);
> +
> +       set_hfi_ipcc_scores(hfi_instance);
>  out:
>         mutex_unlock(&hfi_instance_lock);
>  }
> @@ -618,8 +678,14 @@ void __init intel_hfi_init(void)
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
> 2.25.1
>
