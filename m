Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79C742C85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjF2S47 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjF2S4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:56:50 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AAC1B1;
        Thu, 29 Jun 2023 11:56:48 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-991f9148334so28879766b.1;
        Thu, 29 Jun 2023 11:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065007; x=1690657007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xox1lbxMJs8uqdFdwo8kBUFqLE/PnheZzu/pTWJJ0uA=;
        b=iCKFKBbtsO1WPxG8cq7tv58njQiCwOmgMsxaseXU7gvljR4nZXm4lY+2WoD03Ff3aX
         qKLWZcSsmDccAah+3tgBGJJhSwkFSuHm94zDbqjNdskLX4gVu3i2n5mc5D7hKs2BErLO
         1sXWTf8UoGPf9Lwf3saVcw3nmEXwLYY1LZG5gOmTMjqkN0B9RvUFn/AUYgscGpFGHfTV
         L3+rpg/jCcVzWxAWAWBsDwQRpIl9biQFptWljCQ7BgytO8y64F9YDwy7uUKyv1q6r5wJ
         e1mdtU88HWD7EjnT9BcI7JYcs+kISlbxwv4FIF8BXORndBqKYpzu8pqDNKUItp/86XE4
         DnaQ==
X-Gm-Message-State: ABy/qLa2ifn/LNzkoN2dGwkaw5x783cPFiB/TpFVfNTfKDquDgpKeZ9H
        3X+aeqRfesZc2rBgwvogA+xfL/mDJTVBHlLa8Tk=
X-Google-Smtp-Source: APBJJlG6W63UGRV6g8ERfwuGPkpTggp9Z2YRArBFHOo8saou0q460B0583lHUW11Fl+pcmr0sl5XsfDrqUUdwIZnV6o=
X-Received: by 2002:a17:906:35c5:b0:988:815c:b9fa with SMTP id
 p5-20020a17090635c500b00988815cb9famr272056ejb.3.1688065007058; Thu, 29 Jun
 2023 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com> <20230613042422.5344-16-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230613042422.5344-16-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 20:56:36 +0200
Message-ID: <CAJZ5v0igcMC=u0yQdAiB=tU6N68GCjVg4Y+7D6YA4XuZ4R0Z9w@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] thermal: intel: hfi: Report the IPC class score
 of a CPU
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 6:23 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Implement the arch_get_ipcc_score() interface of the scheduler. Use the
> performance capabilities of the extended Hardware Feedback Interface table
> as the IPC score.
>
> Use the cached per-CPU IPCC scores. A seqcount provides lockless access and
> the required memory ordering to avoid stale data.
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
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v3:
>  * Ordered memory loads using a seqcount.
>  * Removed local variable hfi_class from intel_hfi_get_ipcc_score().
>    (Rafael).
>
> Changes since v2:
>  * None
>
> Changes since v1:
>  * Adjusted the returned HFI class (which starts at 0) to match the
>    scheduler IPCC class (which starts at 1). (PeterZ)
>  * Used the new interface names.
> ---
>  arch/x86/include/asm/topology.h   |  4 ++++
>  drivers/thermal/intel/intel_hfi.c | 40 +++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 7d2ed7f7bb8c..8dd328cdb5cf 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -237,13 +237,17 @@ void init_freq_invariance_cppc(void);
>
>  #ifdef CONFIG_INTEL_HFI_THERMAL
>  int intel_hfi_read_classid(u8 *classid);
> +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
>  #else
>  static inline int intel_hfi_read_classid(u8 *classid) { return -ENODEV; }
> +static inline unsigned long
> +intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu) { return -ENODEV; }
>  #endif
>
>  #ifdef CONFIG_IPC_CLASSES
>  void intel_update_ipcc(struct task_struct *curr);
>  #define arch_update_ipcc intel_update_ipcc
> +#define arch_get_ipcc_score intel_hfi_get_ipcc_score
>  #endif
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index d822ed0bb5c1..fec2c01fda1b 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -199,6 +199,42 @@ static int alloc_hfi_ipcc_scores(void)
>         return hfi_ipcc_scores ? 0 : -ENOMEM;
>  }
>
> +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
> +{
> +       int *scores, score;
> +       unsigned long seq;
> +
> +       scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
> +       if (!scores)
> +               return -ENODEV;
> +
> +       if (cpu < 0 || cpu >= nr_cpu_ids)
> +               return -EINVAL;
> +
> +       if (ipcc == IPC_CLASS_UNCLASSIFIED)
> +               return -EINVAL;
> +
> +       /*
> +        * Scheduler IPC classes start at 1. HFI classes start at 0.
> +        * See note intel_hfi_update_ipcc().
> +        */
> +       if (ipcc >= hfi_features.nr_classes + 1)
> +               return -EINVAL;
> +
> +       /*
> +        * The seqcount implies load-acquire semantics to order loads with
> +        * lockless stores of the write side in set_hfi_ipcc_score(). It
> +        * also implies a compiler barrier.
> +        */
> +       do {
> +               seq = read_seqcount_begin(&hfi_ipcc_seqcount);
> +               /* @ipcc is never 0. */
> +               score = scores[ipcc - 1];
> +       } while (read_seqcount_retry(&hfi_ipcc_seqcount, seq));
> +
> +       return score;
> +}
> +
>  static void set_hfi_ipcc_scores(struct hfi_instance *hfi_instance)
>  {
>         int cpu;
> @@ -213,8 +249,8 @@ static void set_hfi_ipcc_scores(struct hfi_instance *hfi_instance)
>         raw_spin_lock_irq(&hfi_instance->table_lock);
>         /*
>          * The seqcount implies store-release semantics to order stores with
> -        * lockless loads from the seqcount read side. It also implies a
> -        * compiler barrier.
> +        * lockless loads from the seqcount read side in
> +        * intel_hfi_get_ipcc_score(). It also implies a compiler barrier.
>          */
>         write_seqcount_begin(&hfi_ipcc_seqcount);
>         for_each_cpu(cpu, hfi_instance->cpus) {
> --
> 2.25.1
>
