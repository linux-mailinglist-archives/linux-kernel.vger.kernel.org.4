Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E596CAAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjC0Quc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjC0Qu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:50:29 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A223AAB;
        Mon, 27 Mar 2023 09:50:26 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id h8so38838055ede.8;
        Mon, 27 Mar 2023 09:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8idM4wCH3YT0BzRYVVGc0WBy65JTYFDuvrsPK69mhY=;
        b=qiXfSZt+uI5shLHUSwY/q9C+mnWXd0/PAshDD5JPb5n3i7pjcTRqNQBlxGZHObSIC4
         enc1irdm/dRQcGnF0gld4DowZy5dw8ZXEQIDlKkwLFu8MKqPLNseoU98IoJQ4DvdD53D
         9JdZz2kJfLKewQ8xyW/G/wFHhcO6a58C3cWlMVHjDVzQGH+XTg3I2FwcHev2VTuqRq4F
         +MmdPUl1sEW8gYIsIAZ9AhW7PV079bkdUofIoBe0qpHT4h9JuXv9u58a+CO2Z2Wh5/XP
         fpWaPnXQ03b+za77wV57ccQjww9F3+x7QK2PrDb8FfoMTSJPyrgcuBUOYb6dumSQsWRG
         Ujog==
X-Gm-Message-State: AAQBX9eBCAORr/yR/FMtKmRRTcAQvdjVJQqupI0s7unkH2YV5BoBjVtg
        LAw8btej5TGRgvZxsV1xNtfb43tukSBWFr5bTWo=
X-Google-Smtp-Source: AKy350aFHkbyoHtdCa3rP8t+epNGq3nozupQ9YFR9UiU3aYUKhiE92L9z8iWLnk1FCR3L/IQtZwlOAnBPm3vcI3VeBo=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr6772711ejc.2.1679935824418; Mon, 27
 Mar 2023 09:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-16-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-16-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:50:13 +0200
Message-ID: <CAJZ5v0iidC0LxqpE60J5HHQhvv8iHjMGdxM89-7p-QQE99qVEQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/24] thermal: intel: hfi: Report the IPC class score
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
> Implement the arch_get_ipcc_score() interface of the scheduler. Use the
> performance capabilities of the extended Hardware Feedback Interface table
> as the IPC score.
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
>  * Adjusted the returned HFI class (which starts at 0) to match the
>    scheduler IPCC class (which starts at 1). (PeterZ)
>  * Used the new interface names.
> ---
>  arch/x86/include/asm/topology.h   |  2 ++
>  drivers/thermal/intel/intel_hfi.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index ffcdac3f398f..c4fcd9c3c634 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -229,8 +229,10 @@ void init_freq_invariance_cppc(void);
>
>  #if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
>  void intel_hfi_update_ipcc(struct task_struct *curr);
> +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
>
>  #define arch_update_ipcc intel_hfi_update_ipcc
> +#define arch_get_ipcc_score intel_hfi_get_ipcc_score
>  #endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 530dcf57e06e..fa9b4a678d92 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -206,6 +206,33 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
>         curr->ipcc = msr.split.classid + 1;
>  }
>
> +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
> +{
> +       unsigned short hfi_class;

It looks like the variable above is only used to save a subtraction or
addition of 1 to something going forward.

> +       int *scores;
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
> +       hfi_class = ipcc - 1;
> +
> +       if (hfi_class >= hfi_features.nr_classes)

Personally, I would do

if (ipcc >= hfi_features.nr_classes + 1)

here and ->

> +               return -EINVAL;
> +
> +       scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
> +       if (!scores)
> +               return -ENODEV;
> +

-> scores[ipcc - 1]

below.

> +       return READ_ONCE(scores[hfi_class]);

And why does this need to use READ_ONCE()?

> +}
> +
>  static int alloc_hfi_ipcc_scores(void)
>  {
>         if (!cpu_feature_enabled(X86_FEATURE_ITD))
> --
