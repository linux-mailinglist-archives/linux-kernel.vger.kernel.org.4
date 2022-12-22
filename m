Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68202654566
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLVQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBECE1D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671728163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaGEUC5NpZEnqXuEjyTjG34ENE+oZENE152mO+Zr2Po=;
        b=V1xQtp/vuHv81CssnakJAjgHnm6usPfuolEnUGDNfUm+/7T1qdrTdULtWedpCwlWqOqjzm
        y1Dq5gGInBCMaziQ+MO6wvCVYNZQg5DtwbwPKXnTM2ZZGR8Sw4qrwZTu8racbsowBjRLdB
        seC5EasBDKTbDYaSRwH+jfLRk/EexIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-RUMkhi07PZKW-dsXsrxIEA-1; Thu, 22 Dec 2022 11:56:01 -0500
X-MC-Unique: RUMkhi07PZKW-dsXsrxIEA-1
Received: by mail-wm1-f72.google.com with SMTP id m38-20020a05600c3b2600b003d23f8c6ebdso2317875wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaGEUC5NpZEnqXuEjyTjG34ENE+oZENE152mO+Zr2Po=;
        b=r9zV1QUF617CNzzYwh8GrqkzzrYYEs3TiLVrypOQ1linck5T35x7JaDrfYd/JZYWxB
         DdcXKJxe6ggrLGHS6LwjXmILnJtc6R3kBQfSEu/VWCh33OAiZ2BNOcv8Nv8DSQQVt9Nr
         dPkLLpvkCDO8MuCBSLWmURipE7w0+Zd1HQzjs2j4Fr8n79lx9fKVSBI2lWXbVutZyE+j
         HLibA427q8RSOtcFW/Nd1M+CG//kDCU92j58jU+HC7lg+84OX6hNya/kQeVaYJfEivfp
         oEKEiZiYz4EsSeXcjMNgAh/2pWxXCrYdTLnmwxfJvQbNvLb0taN/TfXxoWYDsEnpZdeE
         wa9Q==
X-Gm-Message-State: AFqh2krbFtzF6yiQBi6T2Egi7k2lwxTcg5KrLOLqosIfrJS/4XMlC86Z
        FFnZPNKtFOEUdkq6R4qzNYoQoxtdnwXybu/QZuTQI9hkb95Q/eHcSnHNcZJOJ8zriOastxDul5K
        oc1XenzIXgEKcaCRMRxd1vozi
X-Received: by 2002:a5d:6808:0:b0:272:3a86:29c1 with SMTP id w8-20020a5d6808000000b002723a8629c1mr759667wru.16.1671728160176;
        Thu, 22 Dec 2022 08:56:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtWwrFMKiteegNlODYaQZvnEoEKfVdIKNsvuEH6//zL/45YL8hFm/IfD7I/jdUsDJu9Z1X8QQ==
X-Received: by 2002:a5d:6808:0:b0:272:3a86:29c1 with SMTP id w8-20020a5d6808000000b002723a8629c1mr759645wru.16.1671728159997;
        Thu, 22 Dec 2022 08:55:59 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d40c7000000b00241cfe6e286sm1019529wrq.98.2022.12.22.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:55:59 -0800 (PST)
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
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for
 SMT local sched group
In-Reply-To: <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
Date:   Thu, 22 Dec 2022 16:55:58 +0000
Message-ID: <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
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
> @@ -8926,25 +8924,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
>               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
>       }
>
> -	/* @dst_cpu has SMT siblings. */
> -
> -	if (sg_is_smt) {
> -		int local_busy_cpus = sds->local->group_weight -
> -				      sds->local_stat.idle_cpus;
> -		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> -
> -		if (busy_cpus_delta == 1)
> -			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> -
> -		return false;
> -	}
> -
>       /*
> -	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
> -	 * up with more than one busy SMT sibling and only pull tasks if there
> -	 * are not busy CPUs (i.e., no CPU has running tasks).
> +	 * @dst_cpu has SMT siblings. Do asym_packing load balancing only if
> +	 * all its siblings are idle (moving tasks between physical cores in
> +	 * which some SMT siblings are busy results in the same throughput).
> +	 *
> +	 * If the difference in the number of busy CPUs is two or more, let
> +	 * find_busiest_group() take care of it. We only care if @sg has
> +	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
>        */
> -	if (!sds->local_stat.sum_nr_running)
> +	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
>               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
>

Some of this is new to me - I had missed the original series introducing
this. However ISTM that this is conflating two concepts: SMT occupancy
balancing, and asym packing.

Take the !local_is_smt :: sg_busy_cpus >= 2 :: return true; path. It does
not involve asym packing priorities at all. This can end up in an
ASYM_PACKING load balance, which per calculate_imbalance() tries to move
*all* tasks to the higher priority CPU - in the case of SMT balancing,
we don't want to totally empty the core, just its siblings.

Is there an ITMT/big.LITTLE (or however x86 calls it) case that invalidates
the above?

Say, what's not sufficient with the below? AFAICT the only thing that isn't
covered is the sg_busy_cpus >= 2 thing, but IMO that's SMT balancing, not
asym packing - if the current calculate_imbalance() doesn't do it, it
should be fixed to do it. Looking at the

  local->group_type == group_has_spare

case, it looks like it should DTRT.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 224107278471f..15eb2d3cff186 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9176,12 +9176,15 @@ static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
 {
-	/* Only do SMT checks if either local or candidate have SMT siblings */
-	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
-	    (group->flags & SD_SHARE_CPUCAPACITY))
-		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+	/*
+	 * For SMT, env->idle != CPU_NOT_IDLE isn't sufficient, we need to make
+	 * sure the whole core is idle.
+	 */
+	if (((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
+	     (group->flags & SD_SHARE_CPUCAPACITY)) &&
+	    !test_idle_cores(env->dst_cpu))
+		return false;
 
-	/* Neither env::dst_cpu nor group::asym_prefer_cpu have SMT siblings. */
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu, false);
 }
 
 

