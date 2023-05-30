Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4E1716566
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjE3O6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjE3O5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3087CD9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685458616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=B/GSKf6UEn0c42XXKcBB/6CIce6RG7UgO/Nmikr6pJA=;
        b=cl3550E5TrMIT55COM5pcyDmx+KyQ2elGFgZrZEL2btfAnKYoi5F/N+4fkJR/ukopAgeW/
        4i60yL1Q99gF8mS433IohaWbnZip6fQC+jZALgIL8UCD65CErnKZ2fQ2o9OV6YdkG2lKtP
        bkmyg01jsnjYoSpmrPc7Io+TlAQl+i0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-qhAbuYgmMEKTml1kAmu7gA-1; Tue, 30 May 2023 10:56:51 -0400
X-MC-Unique: qhAbuYgmMEKTml1kAmu7gA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28452185A792;
        Tue, 30 May 2023 14:56:51 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7445420A8;
        Tue, 30 May 2023 14:56:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 4E9DA401CFE3F; Tue, 30 May 2023 11:56:33 -0300 (-03)
Message-ID: <20230530145335.828634764@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 30 May 2023 11:52:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 2/4] vmstat: skip periodic vmstat update for nohz full CPUs
References: <20230530145234.968927611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interruption caused by vmstat_update is undesirable 
for certain aplications:

oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...

The example above shows an additional 7us for the

       	oslat -> kworker -> oslat

switches. In the case of a virtualized CPU, and the vmstat_update  
interruption in the host (of a qemu-kvm vcpu), the latency penalty
observed in the guest is higher than 50us, violating the acceptable
latency threshold.

Skip periodic updates for nohz full CPUs. Any callers who
need precise values should use a snapshot of the per-CPU
counters, or use the global counters with measures to 
handle errors up to thresholds (see calculate_normal_threshold).

Suggested by Michal Hocko.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/tick.h>
 
 #include "internal.h"
 
@@ -2022,6 +2023,16 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
+		/*
+		 * Skip periodic updates for nohz full CPUs.
+		 * Any callers who need precise values should use
+		 * a snapshot of the per-CPU counters, or use the global
+		 * counters with measures to handle errors up to
+		 * thresholds (see calculate_normal_threshold).
+		 */
+		if (tick_nohz_full_cpu(cpu))
+			continue;
+
 		if (!delayed_work_pending(dw) && need_update(cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 


