Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3029D61574F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKBCFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKBCE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF863DB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667354636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2RYvVpIxnZB4mRhcfM8kpuAulQpsyxXS11J9gDFkxg=;
        b=Zwzdmd6DfrLyphZlYUUq0lM/DoE0GLwAiWkYmwOq4W2QG/2jVAwrI97VRX2M6GDGQ0QL2e
        smmMDj6UwOImmMZqm1vWfoekoH6A2gB8lguxmTKX+0/AFipCZ5oqHCPe9wtnTDoTBiyMed
        +avQ5VVJ/e1YFQXTqblIR0arPqNNiXk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-kZgHHuwuMuK0uDK0MYwmmQ-1; Tue, 01 Nov 2022 22:03:55 -0400
X-MC-Unique: kZgHHuwuMuK0uDK0MYwmmQ-1
Received: by mail-oo1-f71.google.com with SMTP id g6-20020a4a6b06000000b0049d1e5cd0cfso59052ooc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2RYvVpIxnZB4mRhcfM8kpuAulQpsyxXS11J9gDFkxg=;
        b=daQWhjFCY87bRZwHaEI7uE8crvpGuzT+af2x5ho1/LQscqPAXt0E7a+tvAO3gTk1bc
         RloW9fYfX9Csk7JzpU5wc4ROPR2lq0rTE3O46juYPjgLV+/5QlRdOdNKVYfaqQBMzyQR
         7m9lWal2dPkxRiSZAxFyeuOSFTxcfsgm5r2NFMtow1WGZVXyo4eLgIMo+edLOQGGp1EP
         g6Ycsxxp1nrjYgB2ZiRoL4JU2gbvp+rOAYhWtDuqlbgBkAn+a/7evM20jEBJnDM+9SPa
         C8sYYMOH/kIs8FW3K8UHlGJv3sorwUS9bBq6rp/b4bnyhLrcCHSY0eJ9XPAqkX9bfZ3l
         NQWA==
X-Gm-Message-State: ACrzQf0als6DnJLnEs67IKfUKCBR1/UdT7djIbiZ1r3Z/+LC/1ywNmGN
        qhrQq6FYyKwFzbq9id0w0Lbiar6WlYToKLaPyA1+OV6mI55CH6nUl6L0k0NcNORqJPtxqEA2CIZ
        6tEqvb7cIGrwMTxUNSEO/qc4H
X-Received: by 2002:a05:6870:4212:b0:13c:d544:8e2a with SMTP id u18-20020a056870421200b0013cd5448e2amr10233067oac.28.1667354634222;
        Tue, 01 Nov 2022 19:03:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5TucfJr70Pv/6ho03ND1IeMhGN5op58YZ9rbaUJ10xOKWU2YOlELtwuMUjwXZ9y/ol3qVj0Q==
X-Received: by 2002:a05:6870:4212:b0:13c:d544:8e2a with SMTP id u18-20020a056870421200b0013cd5448e2amr10233044oac.28.1667354633998;
        Tue, 01 Nov 2022 19:03:53 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:1099:7cb2:3a49:6197:5307])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b00665919f7823sm4526624otq.8.2022.11.01.19.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:03:53 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 3/3] mm/memcontrol: Add drain_remote_stock(), avoid drain_stock on isolated cpus
Date:   Tue,  1 Nov 2022 23:02:43 -0300
Message-Id: <20221102020243.522358-4-leobras@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102020243.522358-1-leobras@redhat.com>
References: <20221102020243.522358-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drain_all_stock() is called, some CPUs will be required to have their
per-CPU caches drained. This currently happens by scheduling a call to
drain_local_stock() to run in each affected CPU.

This, as a consequence, may end up scheduling work to CPUs that are
isolated, and therefore should have as little interruption as possible.

In order to avoid this, make drain_all_stock() able to detect isolated CPUs
and schedule draining the perCPU stock to happen in another non-isolated
CPU.

But since the current implementation only allows the drain to happen in
local CPU, implement a function to drain stock on a remote CPU:
drain_remote_stock().

Given both drain_local_stock() and drain_remote_stock() do almost the same
work, implement a inline drain_stock_helper() that is called by both.

Also, since drain_stock() will be able to run on a remote CPU, protect
memcg_hotplug_cpu_dead() with stock_lock.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index add46da2e6df1..7ad6e4f4b79ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -30,6 +30,7 @@
 #include <linux/cgroup.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/isolation.h>
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
@@ -2263,7 +2264,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 	stock->cached = NULL;
 }
 
-static void drain_local_stock(struct work_struct *dummy)
+static inline void drain_stock_helper(int cpu)
 {
 	struct memcg_stock_pcp *stock;
 	struct obj_cgroup *old = NULL;
@@ -2271,10 +2272,9 @@ static void drain_local_stock(struct work_struct *dummy)
 
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
-	 * drain_stock races is that we always operate on local CPU stock
-	 * here with IRQ disabled
+	 * drain_stock races is stock_lock, a percpu spinlock.
 	 */
-	stock = this_cpu_ptr(&memcg_stock);
+	stock = per_cpu_ptr(&memcg_stock, cpu);
 	spin_lock_irqsave(&stock->stock_lock, flags);
 
 	old = drain_obj_stock(stock);
@@ -2286,6 +2286,16 @@ static void drain_local_stock(struct work_struct *dummy)
 		obj_cgroup_put(old);
 }
 
+static void drain_remote_stock(struct work_struct *work)
+{
+	drain_stock_helper(atomic_long_read(&work->data));
+}
+
+static void drain_local_stock(struct work_struct *dummy)
+{
+	drain_stock_helper(smp_processor_id());
+}
+
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
@@ -2352,10 +2362,16 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 
 		if (flush &&
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
-			if (cpu == curcpu)
+			if (cpu == curcpu) {
 				drain_local_stock(&stock->work);
-			else
+			} else if (housekeeping_cpu(cpu, HK_TYPE_WQ)) {
 				schedule_work_on(cpu, &stock->work);
+			} else {
+				int hkcpu = housekeeping_any_cpu_from(HK_TYPE_WQ, cpu);
+
+				atomic_long_set(&stock->work.data, cpu);
+				schedule_work_on(hkcpu, &stock->work);
+			}
 		}
 	}
 	migrate_enable();
@@ -2367,7 +2383,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	struct memcg_stock_pcp *stock;
 
 	stock = &per_cpu(memcg_stock, cpu);
+	spin_lock(&stock->stock_lock);
 	drain_stock(stock);
+	spin_unlock(&stock->stock_lock);
 
 	return 0;
 }
@@ -7272,9 +7290,20 @@ static int __init mem_cgroup_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
-	for_each_possible_cpu(cpu)
-		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-			  drain_local_stock);
+	/*
+	 * CPUs that are isolated should not spend cpu time for stock draining,
+	 * so allow them to export this task to the nearest housekeeping enabled
+	 * cpu available.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (housekeeping_cpu(cpu, HK_TYPE_WQ)) {
+			INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
+				  drain_local_stock);
+		} else {
+			INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
+				  drain_remote_stock);
+		}
+	}
 
 	for_each_node(node) {
 		struct mem_cgroup_tree_per_node *rtpn;
-- 
2.38.1

