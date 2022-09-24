Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5E5E8DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiIXPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiIXPWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0873915
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664032959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vx+xKpue7wTXyWig6qL4Y2Lw1zImsNhejs2t+QDspOc=;
        b=bJMhfLNK1xtCnEArt9hJDC5ZhpWay7n7F/3hZsBSg7iSgKZP3F1tpdsee8ngMZbz/ur/JF
        54ME2gxOsH2dN+iHB7ANKCBZll2zYf5UOdHWsFcGyY+iwro1PEMiXR8bKq2NNs6c48xKHT
        Tm+hb6BQ24P2AsIZS3e2nsH11gBt+so=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-SVyM0o3lPXesBOLvJl9BFw-1; Sat, 24 Sep 2022 11:22:38 -0400
X-MC-Unique: SVyM0o3lPXesBOLvJl9BFw-1
Received: by mail-wm1-f72.google.com with SMTP id fc12-20020a05600c524c00b003b5054c70d3so1630459wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vx+xKpue7wTXyWig6qL4Y2Lw1zImsNhejs2t+QDspOc=;
        b=nvafOnyqK8k11VDs+Tnkn1fU3QEojqLm8ZdR9PFfH47wnpWbkt9qAy4t2gBwD6+boy
         hF1FvAB2o49d16b6ZhkV5C2F0cMVmGrRcXhyx/sxChYpOwvz32lkg9EptXYoX8mkCN8y
         7afBv2tVNj0gErekH1MAQ8woNuu0gE+6SRJIWAFoFXJnXLQbidAFpO6DJ2AM2/NWAhRl
         Z/gUh1OYncGhxgirIGxtD5jyxXwWFIfcfvlvLA5VU5vB0MFXfCole6Q+n1xSv+LCZMrS
         ElN5hKMYREN9oxUCJJH9T2EG3bvnPbBFyTz7wcOOYyc1bhtEP8zfD/VKqMF5Fw1DJzg7
         rIAg==
X-Gm-Message-State: ACrzQf3fQ1zA5eyDLn6DZu8UWQ2TkKpXNI1PSTRyL4GZNA2/VZ+qmSuh
        W+FvAWvMTWt2QNGb27sjoH3qOQHBt1J4c54AqqXmtB2YcqwfilrZ/mtDbV6jg3v4/tmXOYWlMb5
        LEG2AFUDO8ttwevpdqZRz+oU=
X-Received: by 2002:adf:ea86:0:b0:22b:9f9f:a3b with SMTP id s6-20020adfea86000000b0022b9f9f0a3bmr5684010wrm.130.1664032957440;
        Sat, 24 Sep 2022 08:22:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XlRA/1nNXyboTHo5AUkSzsW77JkBgIWvz5OJ8eCCBl08evcHlFngS43fDNqZ1Sk/si/OyYQ==
X-Received: by 2002:adf:ea86:0:b0:22b:9f9f:a3b with SMTP id s6-20020adfea86000000b0022b9f9f0a3bmr5683998wrm.130.1664032957196;
        Sat, 24 Sep 2022 08:22:37 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d664b000000b0022af63bb6f2sm9701817wrw.113.2022.09.24.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:22:36 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 2/5] mm/vmstat: Use vmstat_dirty to track CPU-specific vmstat discrepancies
Date:   Sat, 24 Sep 2022 16:22:24 +0100
Message-Id: <20220924152227.819815-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924152227.819815-1-atomlin@redhat.com>
References: <20220924152227.819815-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will now use the previously introduced CPU-specific variable
namely vmstat_dirty to indicate if a vmstat differential/or imbalance is
present for a given CPU. So, at the appropriate time, vmstat processing can
be initiated. The hope is that this particular approach is "cheaper" when
compared to need_update(). The idea is based on Marcelo's patch [1].

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/vmstat.c | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 24c67b2e58fd..472175642bd9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -383,6 +383,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	vmstat_mark_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -421,6 +422,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	vmstat_mark_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -619,6 +621,7 @@ static inline void mod_zone_state(struct zone *zone,
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	vmstat_mark_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -687,6 +690,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	vmstat_mark_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -841,6 +845,14 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 	int changes = 0;
 
+	/*
+	 * Clear vmstat_dirty before clearing the percpu vmstats.
+	 * If interrupts are enabled, it is possible that an interrupt
+	 * or another task modifies a percpu vmstat, which will
+	 * set vmstat_dirty to true.
+	 */
+	vmstat_clear_dirty();
+
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
 #ifdef CONFIG_NUMA
@@ -1971,35 +1983,6 @@ static void vmstat_update(struct work_struct *w)
 	}
 }
 
-/*
- * Check if the diffs for a certain cpu indicate that
- * an update is needed.
- */
-static bool need_update(int cpu)
-{
-	pg_data_t *last_pgdat = NULL;
-	struct zone *zone;
-
-	for_each_populated_zone(zone) {
-		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		struct per_cpu_nodestat *n;
-
-		/*
-		 * The fast way of checking if there are any vmstat diffs.
-		 */
-		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
-			return true;
-
-		if (last_pgdat == zone->zone_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
-		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
-		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
-			return true;
-	}
-	return false;
-}
-
 /*
  * Switch off vmstat processing and then fold all the remaining differentials
  * until the diffs stay at zero. The function is used by NOHZ and can only be
@@ -2010,10 +1993,7 @@ void quiet_vmstat(void)
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
-	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
-		return;
-
-	if (!need_update(smp_processor_id()))
+	if (!is_vmstat_dirty())
 		return;
 
 	/*
@@ -2044,7 +2024,7 @@ static void vmstat_shepherd(struct work_struct *w)
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
+		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();
-- 
2.37.1

