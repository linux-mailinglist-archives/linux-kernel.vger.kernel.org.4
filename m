Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA82722F24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjFETEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjFETDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB84EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685991772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HgdXzA8bdDwPq3PKBOP9VV5rvUGTehn183zDvLMapls=;
        b=YpC4X5ipFKv8JRCPLYSxzkpnGFqUXu4qbjrYQT0p8Cuc7/nRwTLGhpaHropJ0wTC50CVL+
        MKntsWFc3KdPUGusARU+/keohodtGhITnsFP9qzJJ+PoqxVoInYQLrTFF48Mc8WOjyFYQU
        UXtHMsNfZpYGXsRqEtApSF/U43nGTHU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-PsIrh79mM7mEmfoGH_DiIw-1; Mon, 05 Jun 2023 15:02:51 -0400
X-MC-Unique: PsIrh79mM7mEmfoGH_DiIw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EFB63C0BE39;
        Mon,  5 Jun 2023 19:02:50 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31999492B00;
        Mon,  5 Jun 2023 19:02:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 3C0C140103220; Mon,  5 Jun 2023 16:02:31 -0300 (-03)
Message-ID: <20230605190132.087124739@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 05 Jun 2023 15:56:30 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 3/3] mm/vmstat: do not refresh stats for isolated CPUs
References: <20230605185627.923698377@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_work_on API uses the workqueue mechanism to
queue a work item on a queue. A kernel thread, which
runs on the target CPU, executes those work items.

Therefore, when using the schedule_work_on API,
it is necessary for the kworker kernel thread to
be scheduled in, for the work function to be executed.

Time sensitive applications such as SoftPLCs
(https://tum-esi.github.io/publications-list/PDF/2022-ETFA-How_Real_Time_Are_Virtual_PLCs.pdf),
have their response times affected by such interruptions.

The /proc/sys/vm/stat_refresh file was originally introduced
with the goal to:

"Provide /proc/sys/vm/stat_refresh to force an immediate update of
 per-cpu into global vmstats: useful to avoid a sleep(2) or whatever
 before checking counts when testing.  Originally added to work around a
 bug which left counts stranded indefinitely on a cpu going idle (an
 inaccuracy magnified when small below-batch numbers represent "huge"
 amounts of memory), but I believe that bug is now fixed: nonetheless,
 this is still a useful knob."

Other than the potential interruption to a time sensitive application,
if using SCHED_FIFO or SCHED_RR priority on the isolated CPU, then
system hangs can occur:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=978688

To avoid the problems above, do not schedule the work to synchronize
per-CPU mm counters on isolated CPUs. Given the possibility for
breaking existing userspace applications, avoid returning
errors from access to /proc/sys/vm/stat_refresh.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v3: improve changelog		  (Michal Hocko)
v2: opencode schedule_on_each_cpu (Michal Hocko)

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -1881,8 +1881,13 @@ int vmstat_refresh(struct ctl_table *tab
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
-	int err;
 	int i;
+	int cpu;
+	struct work_struct __percpu *works;
+
+	works = alloc_percpu(struct work_struct);
+	if (!works)
+		return -ENOMEM;
 
 	/*
 	 * The regular update, every sysctl_stat_interval, may come later
@@ -1896,9 +1901,24 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
-	if (err)
-		return err;
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work;
+
+		if (cpu_is_isolated(cpu))
+			continue;
+		work = per_cpu_ptr(works, cpu);
+		INIT_WORK(work, refresh_vm_stats);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu) {
+		if (cpu_is_isolated(cpu))
+			continue;
+		flush_work(per_cpu_ptr(works, cpu));
+	}
+	cpus_read_unlock();
+	free_percpu(works);
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		/*
 		 * Skip checking stats known to go negative occasionally.


