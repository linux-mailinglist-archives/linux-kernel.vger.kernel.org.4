Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2A6EDFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjDYJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDYJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AFF72A9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682416501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXJzPS+ePXRUuevqx+bM8cqSxNYtGQViXtw1IEUktqU=;
        b=U/FyvZtYarwUmPi1qpYs0ZSp9iHHdEUXnZb5EqHrFl1Bpo4RIPFECKeSDHyQCPMwldbM/M
        GoLacOgWTYNWTSZYWtB04lip3yD0ZoqANuPHfLHSA1PE9jUo9y8yLh2BgPRL/wzddXSHfF
        NPEH4klaA9dPnxyl2iMrMdhk42d2n5A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85--QGSHidBM3mQGzREE0UFOA-1; Tue, 25 Apr 2023 05:54:59 -0400
X-MC-Unique: -QGSHidBM3mQGzREE0UFOA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-301a3715507so2918081f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682416498; x=1685008498;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXJzPS+ePXRUuevqx+bM8cqSxNYtGQViXtw1IEUktqU=;
        b=j7an7lhH2BHeGspYA1KC23ipJTfZG6qpXuLhD9ixraBcaj4SgGE8JstIMo7gGhizW/
         wWLE90h1hsnjtz6rehu2X5LdVZDHd7rTqeUN1Aw97gXV+4/qEIMqlBfeNKzqeSw8ZaWs
         1hPAmBe6MLBU4cZLpvJge4laWpsqebEC8MMfAf61QP553Koi4MYNC6LRFbYZH0ZUPNrN
         BBVCu1vTqx5Le/HfyGCmNidfWfvNSz98qhFl2a+sh962uj05NlSV9fT+sksTD/TEHYel
         yav7j2VSmdSsJZOcHB1euVN7uJfGvO2dT8CX7aRDKCYK4rMVq6KJHSB+qfcAAX9KwH9g
         wIeg==
X-Gm-Message-State: AAQBX9cdd/vzWL2w+1mTxBX2gXQt/a+q8P/NacdWwX1aS8dqNgQh8vjL
        RfFRyl/u8TUIOwlHLPbXGEoA/J0gdhBvWQUPwCBEOs9wozzTCuNxou3fsBJrxrmF+qiqIW8zDu9
        9UHGbApGwKGCpeheyu3v/cvda
X-Received: by 2002:a05:6000:1b8b:b0:304:71e8:d506 with SMTP id r11-20020a0560001b8b00b0030471e8d506mr6085489wru.48.1682416498709;
        Tue, 25 Apr 2023 02:54:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZriQ6P2dwNQFo6Oi30r2hS8OGVkxKIxXv5H8U+rjk+60PRHJR1tm39sP/p2szoL5/lAG/tOw==
X-Received: by 2002:a05:6000:1b8b:b0:304:71e8:d506 with SMTP id r11-20020a0560001b8b00b0030471e8d506mr6085471wru.48.1682416498425;
        Tue, 25 Apr 2023 02:54:58 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003f199662956sm8665688wmc.47.2023.04.25.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 02:54:58 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 2/8] sched/topology: introduce
 sched_numa_find_next_cpu()
In-Reply-To: <20230420051946.7463-3-yury.norov@gmail.com>
References: <20230420051946.7463-1-yury.norov@gmail.com>
 <20230420051946.7463-3-yury.norov@gmail.com>
Date:   Tue, 25 Apr 2023 10:54:56 +0100
Message-ID: <xhsmh354ol21b.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/23 22:19, Yury Norov wrote:
> +/*
> + * sched_numa_find_next_cpu() - given the NUMA topology, find the next cpu
> + * cpumask: cpumask to find a cpu from
> + * cpu: current cpu
> + * node: local node
> + * hop: (in/out) indicates distance order of current CPU to a local node
> + *
> + * The function searches for next cpu at a given NUMA distance, indicated
> + * by hop, and if nothing found, tries to find CPUs at a greater distance,
> + * starting from the beginning.
> + *
> + * Return: cpu, or >= nr_cpu_ids when nothing found.
> + */
> +int sched_numa_find_next_cpu(const struct cpumask *cpus, int cpu, int node, unsigned int *hop)
> +{
> +	unsigned long *cur, *prev;
> +	struct cpumask ***masks;
> +	unsigned int ret;
> +
> +	if (*hop >= sched_domains_numa_levels)
> +		return nr_cpu_ids;
> +
> +	masks = rcu_dereference(sched_domains_numa_masks);
> +	cur = cpumask_bits(masks[*hop][node]);
> +	if (*hop == 0)
> +		ret = find_next_and_bit(cpumask_bits(cpus), cur, nr_cpu_ids, cpu);
> +	else {
> +		prev = cpumask_bits(masks[*hop - 1][node]);
> +		ret = find_next_and_andnot_bit(cpumask_bits(cpus), cur, prev, nr_cpu_ids, cpu);
> +	}
> +
> +	if (ret < nr_cpu_ids)
> +		return ret;
> +
> +	*hop += 1;
> +	return sched_numa_find_next_cpu(cpus, 0, node, hop);

sched_domains_numa_levels is a fairly small number, so the recursion depth
isn't something we really need to worry about - still, the iterative
variant of this is fairly straightforward to get to:

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e850f16c003ae..4c9a9e48fef6d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2151,23 +2151,27 @@ int sched_numa_find_next_cpu(const struct cpumask *cpus, int cpu, int node, unsi
 	struct cpumask ***masks;
 	unsigned int ret;
 
-	if (*hop >= sched_domains_numa_levels)
-		return nr_cpu_ids;
+	/*
+	 * Reset @cpu to 0 when increasing @hop, since CPU numbering has no
+	 * relationship with NUMA distance: a search at @hop+1 may yield CPUs
+	 * of lower ID than previously seen!
+	 */
+	for (; *hop >= sched_domains_numa_levels; *hop += 1, cpu = 0) {
+		masks = rcu_dereference(sched_domains_numa_masks);
+		cur = cpumask_bits(masks[*hop][node]);
+
+		if (*hop == 0) {
+			ret = find_next_and_bit(cpumask_bits(cpus), cur, nr_cpu_ids, cpu);
+		} else {
+			prev = cpumask_bits(masks[*hop - 1][node]);
+			ret = find_next_and_andnot_bit(cpumask_bits(cpus), cur, prev, nr_cpu_ids, cpu);
+		}
 
-	masks = rcu_dereference(sched_domains_numa_masks);
-	cur = cpumask_bits(masks[*hop][node]);
-	if (*hop == 0)
-		ret = find_next_and_bit(cpumask_bits(cpus), cur, nr_cpu_ids, cpu);
-	else {
-		prev = cpumask_bits(masks[*hop - 1][node]);
-		ret = find_next_and_andnot_bit(cpumask_bits(cpus), cur, prev, nr_cpu_ids, cpu);
+		if (ret < nr_cpu_ids)
+			return ret;
 	}
 
-	if (ret < nr_cpu_ids)
-		return ret;
-
-	*hop += 1;
-	return sched_numa_find_next_cpu(cpus, 0, node, hop);
+	return nr_cpu_ids;
 }
 EXPORT_SYMBOL_GPL(sched_numa_find_next_cpu);
 

