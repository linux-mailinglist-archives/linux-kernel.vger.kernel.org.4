Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD372097E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjFBTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbjFBTFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C211B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685732659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lJAFxNimyhgGkmw8GXkGsiBNva5tBIiiepv3OQs0cGk=;
        b=AgYcQ6l/D00LoQZ/P/17iIEZ64fZTmBETs1LUX4SoUWh0jj//c526JYE+fLO9wOmOYx9/4
        /KceDumZyikaIc9rJG2Bn7FXcb54rcWl79wREwF5/ykAsrf+PML5g+YJvqr+cu9vikFMRA
        L58Y3LznhmfcOD/XMuNslvmNUkgN/yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-gCOX5Fs8O-Gvp5nPcrtFrw-1; Fri, 02 Jun 2023 15:04:08 -0400
X-MC-Unique: gCOX5Fs8O-Gvp5nPcrtFrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D3998007CE;
        Fri,  2 Jun 2023 19:04:06 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3891EC0297C;
        Fri,  2 Jun 2023 19:04:06 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 1D840403BFA58; Fri,  2 Jun 2023 16:03:42 -0300 (-03)
Message-ID: <20230602190115.545766386@redhat.com>
User-Agent: quilt/0.67
Date:   Fri, 02 Jun 2023 15:58:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 3/3] mm/vmstat: do not refresh stats for nohz_full CPUs
References: <20230602185757.110910188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interruption caused by queueing work on nohz_full CPUs 
is undesirable for certain aplications.

Fix by not refreshing per-CPU stats of nohz_full CPUs. 

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
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


