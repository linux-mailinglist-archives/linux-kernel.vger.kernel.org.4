Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D04716564
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjE3O5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjE3O5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7DCA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685458615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zp+6wKN5pw6h0b4P0Mp9cZhOYKe0APjLNDcaJDBGqc0=;
        b=KK44kWQtOd6KwlTRTlwFn57e9430/h84pRMj/h5h7i0+uMBUrpwtXlPyGAdQ4hm25IcuAv
        Un3PZnuk0CFwM9N9we09QX5zwLIeX7J9m7kwueECKzJti3fcQnYUxSaCHEBKSUP9tyRdi5
        nIL+wIuvLNGKaySrXBa4qS5jzvxFqnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-WcYEjc5XOeSOkwHfXbc04Q-1; Tue, 30 May 2023 10:56:53 -0400
X-MC-Unique: WcYEjc5XOeSOkwHfXbc04Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 241BB101A53B;
        Tue, 30 May 2023 14:56:51 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E742BC154D2;
        Tue, 30 May 2023 14:56:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 5C58B401E1522; Tue, 30 May 2023 11:56:33 -0300 (-03)
Message-ID: <20230530145336.155097348@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 30 May 2023 11:52:38 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 4/4] mm/vmstat: do not refresh stats for nohz_full CPUs
References: <20230530145234.968927611@redhat.com>
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

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -1877,12 +1877,31 @@ static void refresh_vm_stats(struct work
 	refresh_cpu_vm_stats(true);
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static inline const cpumask_t *tickless_cpumask(void)
+{
+	return tick_nohz_full_mask;
+}
+#else
+static cpumask_t empty_cpumask;
+static inline const cpumask_t *tickless_cpumask(void)
+{
+	return &empty_cpumask;
+}
+#endif
+
 int vmstat_refresh(struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
 	int err;
 	int i;
+	cpumask_var_t dstmask;
+
+	if (!alloc_cpumask_var(&dstmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_andnot(dstmask, cpu_possible_mask, tickless_cpumask());
 
 	/*
 	 * The regular update, every sysctl_stat_interval, may come later
@@ -1896,7 +1915,9 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
+	err = schedule_on_each_cpumask(refresh_vm_stats, dstmask);
+	free_cpumask_var(dstmask);
+
 	if (err)
 		return err;
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {


