Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A215BCF86
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiISOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiISOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C488635F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663598984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lDMtAfR0LZ02mjGqfa7lm9WQCroMnLEVGcp1CGyLHps=;
        b=F/Z3FU7l2aPp/6wTNe5K1WAF9DB4fhckdkKRSuMCwdtM5MOFLwIVqIv6SnlGYBxQwBGCgO
        jdlNxCr1bX7pZDjuEPSBe6oZVqGeg3fiLUs/sZOZsUT0GI8dceLHHTe83gn/htvM3sUnpV
        zwEC65MNoWEuF57VywQHVRFWm18pW6M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-Fy_0wzyONo-lDh5wnK8yxQ-1; Mon, 19 Sep 2022 10:49:38 -0400
X-MC-Unique: Fy_0wzyONo-lDh5wnK8yxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46F8C85D534;
        Mon, 19 Sep 2022 14:49:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.33.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0B71140EBF3;
        Mon, 19 Sep 2022 14:49:37 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, bristot@kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH] trace/osnoise: Fix possible recursive locking in stop_per_cpu_kthreads
Date:   Mon, 19 Sep 2022 08:49:32 -0600
Message-Id: <20220919144932.3064014-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a recursive lock on the cpu_hotplug_lock.

In kernel/trace/trace_osnoise.c:<start/stop>_per_cpu_kthreads:
    - start_per_cpu_kthreads calls cpus_read_lock() and if
	start_kthreads returns a error it will call stop_per_cpu_kthreads.
    - stop_per_cpu_kthreads then calls cpus_read_lock() again causing
      deadlock.

Fix this by calling cpus_read_unlock() before calling
stop_per_cpu_kthreads. This behavior can also be seen in commit
f46b16520a08 ("trace/hwlat: Implement the per-cpu mode").

This error was noticed during the LTP ftrace-stress-test:

WARNING: possible recursive locking detected
--------------------------------------------
sh/275006 is trying to acquire lock:
ffffffffb02f5400 (cpu_hotplug_lock){++++}-{0:0}, at: stop_per_cpu_kthreads

but task is already holding lock:
ffffffffb02f5400 (cpu_hotplug_lock){++++}-{0:0}, at: start_per_cpu_kthreads

other info that might help us debug this:
 Possible unsafe locking scenario:

      CPU0
      ----
 lock(cpu_hotplug_lock);
 lock(cpu_hotplug_lock);

 *** DEADLOCK ***

May be due to missing lock nesting notation

3 locks held by sh/275006:
 #0: ffff8881023f0470 (sb_writers#24){.+.+}-{0:0}, at: ksys_write
 #1: ffffffffb084f430 (trace_types_lock){+.+.}-{3:3}, at: rb_simple_write
 #2: ffffffffb02f5400 (cpu_hotplug_lock){++++}-{0:0}, at: start_per_cpu_kthreads

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 313439920a8c..78d536d3ff3d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1786,8 +1786,9 @@ static int start_per_cpu_kthreads(void)
 	for_each_cpu(cpu, current_mask) {
 		retval = start_kthread(cpu);
 		if (retval) {
+			cpus_read_unlock();
 			stop_per_cpu_kthreads();
-			break;
+			return retval;
 		}
 	}
 
-- 
2.37.2

