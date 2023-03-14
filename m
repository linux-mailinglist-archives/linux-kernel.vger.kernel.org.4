Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0618B6B9F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjCNTCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCNTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB510C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BjYqqe7MvmRoNdsZ3mRmEvGJpIWPHc0RoB3EQFJD7pE=;
        b=eddE9m5+TpTGAN5AvxHHPb98moV/t54s4o06zqcGCrx04GCu62uR4CQ4Vdw8Ha9iLnSCzX
        N6gQNBN8j6uvq2bI8IXcrPF984cMVzv5amZ/bIzrySLzFYx+DuK4MYRa1vBg6mNIAEft4c
        wYRWR6UF7wkHlMZAWqN/kNzrFUbv/04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-eTB4kV2KNn62pW4FAutmSg-1; Tue, 14 Mar 2023 15:01:07 -0400
X-MC-Unique: eTB4kV2KNn62pW4FAutmSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30F6B18E0046;
        Tue, 14 Mar 2023 19:01:05 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F26262A68;
        Tue, 14 Mar 2023 19:01:04 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7C4E04039C295; Tue, 14 Mar 2023 16:00:44 -0300 (-03)
Message-ID: <20230314185951.804121555@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 14 Mar 2023 15:59:25 -0300
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
Subject: [PATCH v6 11/12] mm/vmstat: refresh stats remotely instead of via work item
References: <20230314185914.836510860@redhat.com>
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

Refresh per-CPU stats remotely, instead of queueing 
work items, for the stat_refresh procfs method.

This fixes sosreport hang (which uses vmstat_refresh) with
spinning SCHED_FIFO process.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -1901,11 +1901,20 @@ static DEFINE_PER_CPU(struct delayed_wor
 int sysctl_stat_interval __read_mostly = HZ;
 
 #ifdef CONFIG_PROC_FS
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+static int refresh_all_vm_stats(void);
+#else
 static void refresh_vm_stats(struct work_struct *work)
 {
 	refresh_cpu_vm_stats(true);
 }
 
+static int refresh_all_vm_stats(void)
+{
+	return schedule_on_each_cpu(refresh_vm_stats);
+}
+#endif
+
 int vmstat_refresh(struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1925,7 +1934,7 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
+	err = refresh_all_vm_stats();
 	if (err)
 		return err;
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
@@ -2045,7 +2054,7 @@ static DECLARE_DEFERRABLE_WORK(shepherd,
 
 #ifdef CONFIG_HAVE_CMPXCHG_LOCAL
 /* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
-static void vmstat_shepherd(struct work_struct *w)
+static int refresh_all_vm_stats(void)
 {
 	int cpu;
 
@@ -2055,7 +2064,12 @@ static void vmstat_shepherd(struct work_
 		cond_resched();
 	}
 	cpus_read_unlock();
+	return 0;
+}
 
+static void vmstat_shepherd(struct work_struct *w)
+{
+	refresh_all_vm_stats();
 	schedule_delayed_work(&shepherd,
 		round_jiffies_relative(sysctl_stat_interval));
 }


