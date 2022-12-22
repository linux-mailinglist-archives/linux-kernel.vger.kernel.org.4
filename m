Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67D654568
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiLVQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLVQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86BC18E07
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671728186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlp17/58Tt0fnoE4NSJJ90eJ41XW+fAlC4kIuMp7uqI=;
        b=StdTWGX7CE/W1uIFRD3QUHoLrEmK49/akKCNSIcDWL/CqCHURk5vye2Yy7/gx0iQG5keYH
        aYwRahleWzZB/ydVvQOtcaa2KjhA/Cfrkc6r4eHqdwRaz28BE4QXPYja4n8x4vFmAq8+Up
        ulMYpcdHDowCfU9rXEQ+0e15xctjXas=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-AgSSBaIlO-mPM10iqZnQXw-1; Thu, 22 Dec 2022 11:56:25 -0500
X-MC-Unique: AgSSBaIlO-mPM10iqZnQXw-1
Received: by mail-wr1-f71.google.com with SMTP id q16-20020adfab10000000b00271460582b6so523618wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlp17/58Tt0fnoE4NSJJ90eJ41XW+fAlC4kIuMp7uqI=;
        b=e+H5aqZ9/R7j9qiVA2dAC9pOoj998yh/k+5izLMg93GwDXV2mdvPiMB/FHrP7OfWv3
         halVVcDo4X/hdXxPMa9J6pqA49DA+9kmT0HXOZpQaMH7Zm9IJiUaPSFeNW5SdZGH/9ep
         K0a1VKvm3iERZxQ5uGm0bjxjZpefqMajnkkMLbwO1tuSHtuyGdbGy8hCkOkCR8dqzEmM
         Qd2nsAtLDt/ReBNUH0Ye49+NRxgY2wIrHdWwqvfb4vCJSgwo7T0xI4SaxjpyzJAk7R8W
         uT1+E7Q9olc65ghsrvJP87tHe4KWHHV3WZkmP0IrzLDDUuuzJEnAbcZ1K3P/40x2gGdn
         xcTQ==
X-Gm-Message-State: AFqh2kqYBmWy/fQ79nwlIItyBsz0JXKVBL5+hLeVAI4vbdJ/HQIYPGFd
        3T65oOwdVOfEUhHPL7EfBUHkGMlp1F3kKaH8A4GkIP0/RiMG20WK7bOwM5LMZ/uUay/BfPKUoir
        D38s5LFcVlZMgSA4QOONGAqAt
X-Received: by 2002:a1c:3887:0:b0:3d2:26cd:3b1e with SMTP id f129-20020a1c3887000000b003d226cd3b1emr4857119wma.28.1671728184562;
        Thu, 22 Dec 2022 08:56:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsRrPQh7eA2NY2acTEbP3AJ32bo0iEjaZr7kwlePoHW7ktgOSmPd+0CFvutXpFHlHqQDiu1LQ==
X-Received: by 2002:a1c:3887:0:b0:3d2:26cd:3b1e with SMTP id f129-20020a1c3887000000b003d226cd3b1emr4857106wma.28.1671728184413;
        Thu, 22 Dec 2022 08:56:24 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003c6f8d30e40sm7098863wms.31.2022.12.22.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:56:23 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
In-Reply-To: <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
Date:   Thu, 22 Dec 2022 16:56:22 +0000
Message-ID: <xhsmhsfh7e5s9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/22 12:35, Ricardo Neri wrote:
> Architectures that implement arch_asym_cpu_priority() may need to know the
> idle state of the SMT siblings of a CPU. The scheduler has this information
> and functionality. Expose it.
>
> Move the existing functionality outside of the NUMA code.
>

test_idle_cores() does something similar without an iteration, did you
consider using that instead?

> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v1:
>  * Introduced this patch.
> ---
>  include/linux/sched.h |  2 ++
>  kernel/sched/fair.c   | 39 ++++++++++++++++++++++-----------------
>  2 files changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffb6eb55cd13..0d01c64ac737 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2426,4 +2426,6 @@ static inline void sched_core_fork(struct task_struct *p) { }
>  
>  extern void sched_set_stop_task(int cpu, struct task_struct *stop);
>  
> +extern bool sched_smt_siblings_idle(int cpu);
> +
>  #endif
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0e4251f83807..9517c48df50e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1052,6 +1052,28 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   * Scheduling class queueing methods:
>   */
>  
> +static inline bool is_core_idle(int cpu)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	int sibling;
> +
> +	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
> +		if (cpu == sibling)
> +			continue;
> +
> +		if (!idle_cpu(sibling))
> +			return false;
> +	}
> +#endif
> +
> +	return true;
> +}
> +
> +bool sched_smt_siblings_idle(int cpu)
> +{
> +	return is_core_idle(cpu);
> +}
> +
>  #ifdef CONFIG_NUMA
>  #define NUMA_IMBALANCE_MIN 2
>  
> @@ -1691,23 +1713,6 @@ struct numa_stats {
>  	int idle_cpu;
>  };
>  
> -static inline bool is_core_idle(int cpu)
> -{
> -#ifdef CONFIG_SCHED_SMT
> -	int sibling;
> -
> -	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
> -		if (cpu == sibling)
> -			continue;
> -
> -		if (!idle_cpu(sibling))
> -			return false;
> -	}
> -#endif
> -
> -	return true;
> -}
> -
>  struct task_numa_env {
>  	struct task_struct *p;
>  
> -- 
> 2.25.1

