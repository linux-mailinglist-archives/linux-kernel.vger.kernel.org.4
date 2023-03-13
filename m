Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728536B7D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjCMQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCMQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4007A916
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678724866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tZRdfptRFY5Vlp762UsZ6/anX9gl/kIpoSRft9xlHEw=;
        b=LkVeQsIpg4eov5ys/gCa7TqaVVh+yMyluryLRj681wNyA6jewTXz+Fkz/MioR1Fx8SYZ0j
        0LS9cf+YPsUJV/tjewCILWYjvcXGYltv41i7YBH5y9+/z6T9v5I/pI5+Ny64JoGTwXb6+1
        U+EfEGo32/ZlxVA0lHVsTgOO82uiBHw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-Z4BMmYaWPeK5kERbohyfSA-1; Mon, 13 Mar 2023 12:27:43 -0400
X-MC-Unique: Z4BMmYaWPeK5kERbohyfSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0022B3814949;
        Mon, 13 Mar 2023 16:27:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6F47C164E7;
        Mon, 13 Mar 2023 16:27:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 38FD44038AB8A; Mon, 13 Mar 2023 13:26:44 -0300 (-03)
Message-ID: <20230313162634.509267576@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Mar 2023 13:25:17 -0300
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
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 10/12] mm/vmstat: switch vmstat shepherd to flush per-CPU counters remotely
References: <20230313162507.032200398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the counters are modified via cmpxchg both CPU locally
(via the account functions), and remotely (via cpu_vm_stats_fold),
its possible to switch vmstat_shepherd to perform the per-CPU 
vmstats folding remotely.

This fixes the following two problems:

 1. A customer provided some evidence which indicates that
    the idle tick was stopped; albeit, CPU-specific vmstat
    counters still remained populated.

    Thus one can only assume quiet_vmstat() was not
    invoked on return to the idle loop. If I understand
    correctly, I suspect this divergence might erroneously
    prevent a reclaim attempt by kswapd. If the number of
    zone specific free pages are below their per-cpu drift
    value then zone_page_state_snapshot() is used to
    compute a more accurate view of the aforementioned
    statistic.  Thus any task blocked on the NUMA node
    specific pfmemalloc_wait queue will be unable to make
    significant progress via direct reclaim unless it is
    killed after being woken up by kswapd
    (see throttle_direct_reclaim())

 2. With a SCHED_FIFO task that busy loops on a given CPU,
    and kworker for that CPU at SCHED_OTHER priority,
    queuing work to sync per-vmstats will either cause that
    work to never execute, or stalld (i.e. stall daemon)
    boosts kworker priority which causes a latency
    violation

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -2043,6 +2043,23 @@ static void vmstat_shepherd(struct work_
 
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
@@ -2062,6 +2079,7 @@ static void vmstat_shepherd(struct work_
 	schedule_delayed_work(&shepherd,
 		round_jiffies_relative(sysctl_stat_interval));
 }
+#endif
 
 static void __init start_shepherd_timer(void)
 {


