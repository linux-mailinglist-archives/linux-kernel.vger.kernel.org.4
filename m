Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0472097B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjFBTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbjFBTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A121B5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685732655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QJoQ4NIFYgqvZuzmyQS3JO7Z0w/EGIPt/606uSPKQ0E=;
        b=Ods2WV5Ha0G3gUcvNOhEpTp2ivI6GXJayzevmgWD58kYDObLEf4dsqlzXvXYXG4yFb7Muw
        cjjyYUP7GSEnTXE13DFI59rHjFJMiFpp9pFivV2b8O3BfpZaSMQsBua44NDiNaE5t2Owrh
        TLHbsrOJUjiTDMhvBQWyLi352aukFOc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-peNUCNUlOFqfgKiEXAwsmw-1; Fri, 02 Jun 2023 15:04:09 -0400
X-MC-Unique: peNUCNUlOFqfgKiEXAwsmw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EB4B3800EAB;
        Fri,  2 Jun 2023 19:04:06 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3859D492B00;
        Fri,  2 Jun 2023 19:04:06 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 1437B403BF03A; Fri,  2 Jun 2023 16:03:42 -0300 (-03)
Message-ID: <20230602190115.521067386@redhat.com>
User-Agent: quilt/0.67
Date:   Fri, 02 Jun 2023 15:57:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 2/3] vmstat: skip periodic vmstat update for nohz full CPUs
References: <20230602185757.110910188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

v2: use cpu_is_isolated		(Michal Hocko)

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -2022,6 +2023,16 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
+		/*
+		 * Skip periodic updates for isolated CPUs.
+		 * Any callers who need precise values should use
+		 * a snapshot of the per-CPU counters, or use the global
+		 * counters with measures to handle errors up to
+		 * thresholds (see calculate_normal_threshold).
+		 */
+		if (cpu_is_isolated(cpu))
+			continue;
+
 		if (!delayed_work_pending(dw) && need_update(cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 


