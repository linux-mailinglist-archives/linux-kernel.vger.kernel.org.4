Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5E703BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbjEOSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbjEOSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5931560A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jkb4dlPC4zyep6CJ8cMLWwNNaJdusa90HtfOUuDaHEw=;
        b=XfGnLl3Np54PnRFn+fQaF1eUHilrj4ugMZE4hvTwrjlQREw9jZQujPOZkUUnUpK+Efn2DZ
        blHFzb1+Yk/ZMWufurmEjQLBq4vIFM6LLYJoC6kgDvLsga9r+13RNJk4NgHRpWWZ1E56fj
        NWEjOkUbvMxaSWqEwzIgwpwM3yBxk0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-gp1bspFaPzeFbxO02PyHjg-1; Mon, 15 May 2023 14:03:43 -0400
X-MC-Unique: gp1bspFaPzeFbxO02PyHjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27D73185A79C;
        Mon, 15 May 2023 18:03:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1C7340C2063;
        Mon, 15 May 2023 18:03:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 81D6B4161E52E; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180138.692835888@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:26 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v8 11/13] mm/vmstat: switch vmstat shepherd to flush per-CPU counters remotely
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a task that busy loops on a given CPU,
the kworker interruption to execute vmstat_update
is undesired and may exceed latency thresholds
for certain applications.

Performance details for the kworker interruption:

oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...

The example above shows an additional 7us for the

        oslat -> kworker -> oslat

switches. In the case of a virtualized CPU, and the vmstat_update
interruption in the host (of a qemu-kvm vcpu), the latency penalty
observed in the guest is higher than 50us, violating the acceptable
latency threshold for certain applications.

To fix this, now that the counters are modified via cmpxchg
both CPU locally (via the account functions), and remotely (via
cpu_vm_stats_fold), its possible to switch vmstat_shepherd to perform
the per-CPU vmstats folding remotely.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -2049,6 +2049,23 @@ static void vmstat_shepherd(struct work_
 
 static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
 
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+/* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
+static void vmstat_shepherd(struct work_struct *w)
+{
+	int cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		cpu_vm_stats_fold(cpu);
+		cond_resched();
+	}
+	cpus_read_unlock();
+
+	schedule_delayed_work(&shepherd,
+		round_jiffies_relative(sysctl_stat_interval));
+}
+#else
 static void vmstat_shepherd(struct work_struct *w)
 {
 	int cpu;
@@ -2068,6 +2085,7 @@ static void vmstat_shepherd(struct work_
 	schedule_delayed_work(&shepherd,
 		round_jiffies_relative(sysctl_stat_interval));
 }
+#endif
 
 static void __init start_shepherd_timer(void)
 {


