Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696A965EB39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjAEM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjAEM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B51081
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672923403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C8n9DE0ruCcCCK7cY6ZY83QBYvGpdJ8qqUIL+bP6IWU=;
        b=gb/ZNANVaX//SnP38qcHV9CxNSKD1LwWgAx3xjgkLUe4DALRnhpUvZJKNEQVUv1RTFNHMs
        bbyfGGIVstryDsNhXirltawYbqhVjdJJw/EUNPXoVzGsz+lhiU6jYcJHuOJrKxTgVP1kiv
        eDrPi2xDmTK899hM10zOmpqjeNL4wUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-zOn_0ctvMduyru0HaogF3g-1; Thu, 05 Jan 2023 07:56:41 -0500
X-MC-Unique: zOn_0ctvMduyru0HaogF3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A49B8802C1C;
        Thu,  5 Jan 2023 12:56:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3529E53A0;
        Thu,  5 Jan 2023 12:56:40 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id A7E8340502F46; Thu,  5 Jan 2023 09:54:47 -0300 (-03)
Message-ID: <20230105125248.971432211@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 05 Jan 2023 09:52:24 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@atomlin.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v13 6/6] mm/vmstat: avoid queueing work item if cpu stats are clean
References: <20230105125218.031928326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to queue work item to run refresh_vm_stats
on a remote CPU if that CPU has no dirty stats and no per-CPU
allocations for remote nodes.

This fixes sosreport hang (which uses vmstat_refresh) with
spinning SCHED_FIFO process.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1931,6 +1931,31 @@ static const struct seq_operations vmsta
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PROC_FS
+static bool need_drain_remote_zones(int cpu)
+{
+#ifdef CONFIG_NUMA
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pages *pcp;
+
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		if (!pcp->count)
+			continue;
+
+		if (!pcp->expire)
+			continue;
+
+		if (zone_to_nid(zone) == cpu_to_node(cpu))
+			continue;
+
+		return true;
+	}
+#endif
+
+	return false;
+}
+
 static void refresh_vm_stats(struct work_struct *work)
 {
 	refresh_cpu_vm_stats(true);
@@ -1940,8 +1965,12 @@ int vmstat_refresh(struct ctl_table *tab
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
-	int err;
-	int i;
+	int i, cpu;
+	struct work_struct __percpu *works;
+
+	works = alloc_percpu(struct work_struct);
+	if (!works)
+		return -ENOMEM;
 
 	/*
 	 * The regular update, every sysctl_stat_interval, may come later
@@ -1955,9 +1984,21 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
-	if (err)
-		return err;
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+		struct vmstat_dirty *vms = per_cpu_ptr(&vmstat_dirty_pcpu, cpu);
+
+		INIT_WORK(work, refresh_vm_stats);
+
+		if (vms->dirty || need_drain_remote_zones(cpu))
+			schedule_work_on(cpu, work);
+	}
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(works, cpu));
+	cpus_read_unlock();
+	free_percpu(works);
+
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		/*
 		 * Skip checking stats known to go negative occasionally.


