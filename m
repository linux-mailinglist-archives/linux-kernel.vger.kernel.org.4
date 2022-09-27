Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371AF5EC8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiI0QCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiI0QBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813721BB236
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCF361AA0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC71C433D6;
        Tue, 27 Sep 2022 16:01:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2n-00G2vD-10;
        Tue, 27 Sep 2022 12:02:49 -0400
Message-ID: <20220927160248.807986897@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nico Pache <npache@redhat.com>
Subject: [for-next][PATCH 14/20] tracing/osnoise: Fix possible recursive locking in
 stop_per_cpu_kthreads
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nico Pache <npache@redhat.com>

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

Link: https://lkml.kernel.org/r/20220919144932.3064014-1-npache@redhat.com

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Nico Pache <npache@redhat.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.35.1
