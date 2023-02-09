Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C189690D14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjBIPew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjBIPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F5D5ACE9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675956804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0xpraGtvv+g3M3VM6y/rVH56xF8i4HGSirYhvlOx/70=;
        b=eFu4e4GvG0Uo7DgVB9GriV6abROJVR//AuPCtuhBgvAO5oaU+TzMaOfj9D9S4w2UA+WA05
        YB+QCLZ2UhWicRIoHb5rrFsmtRSmutM1Et0/gZoWHGP0ViWs3aF+FnENcddF2dsnlqmOv2
        huhVmeYeeujtsxognLot9EEyXDJKgd4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-HYnLzgtyPPihlf6ibXjY4Q-1; Thu, 09 Feb 2023 10:33:19 -0500
X-MC-Unique: HYnLzgtyPPihlf6ibXjY4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 963A72807D72;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C910492B00;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 90B32403CC181; Thu,  9 Feb 2023 12:32:51 -0300 (-03)
Message-ID: <20230209153204.929333982@redhat.com>
User-Agent: quilt/0.67
Date:   Thu, 09 Feb 2023 12:02:01 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 11/11] mm/vmstat: refresh stats remotely instead of via work item
References: <20230209150150.380060673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1865,11 +1865,21 @@ static DEFINE_PER_CPU(struct delayed_wor
 int sysctl_stat_interval __read_mostly = HZ;
 
 #ifdef CONFIG_PROC_FS
+
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+static int refresh_all_vm_stats(void);
+#else
 static void refresh_vm_stats(struct work_struct *work)
 {
 	refresh_cpu_vm_stats();
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
@@ -1889,7 +1899,7 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
+	err = refresh_all_vm_stats();
 	if (err)
 		return err;
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
@@ -2009,7 +2019,7 @@ static DECLARE_DEFERRABLE_WORK(shepherd,
 
 #ifdef CONFIG_HAVE_CMPXCHG_LOCAL
 /* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
-static void vmstat_shepherd(struct work_struct *w)
+static int refresh_all_vm_stats(void)
 {
 	int cpu;
 
@@ -2019,7 +2029,12 @@ static void vmstat_shepherd(struct work_
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


