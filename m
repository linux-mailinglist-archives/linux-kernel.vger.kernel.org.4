Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730C6C83CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjCXRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjCXRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA119681;
        Fri, 24 Mar 2023 10:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0526B82593;
        Fri, 24 Mar 2023 17:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370FBC433EF;
        Fri, 24 Mar 2023 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679680306;
        bh=VTt1KMunBj3bGgIvGPFs64aHDoVxlj73J1yqfBRjYOI=;
        h=From:To:Cc:Subject:Date:From;
        b=L8bz/aycpolR8IDhVvjHMD18pt8aeE/Uu4eq3zgOHzc9SeOgmFcKXaJmToDc7fsUR
         ysnPJ3bmtEqDllWZUMZhq4wDUa9qcCOlijXgP9OGaHhcbbFc35RrplYRqr8/od6Px1
         ON0DL8R7mD0EooC6/K36gi6IfSVIgl2LPrsy0AGOMPIii0MOswuCgrkxr1JMKzX4PX
         oDU6IWk9jn6QE8lfbYbPAiTH0NSN6uJ/xSccP9FcQhblOUGS/aXePOwlWWwCXHtkTR
         JyndVN8X13KbjihpPPK691hHKedWwIUML9cg8hoc8eNxFskmdmIXjBUfbQp65n3/9D
         2eAv2Kkecc+EQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/osnoise: Fix notify new tracing_max_latency
Date:   Fri, 24 Mar 2023 18:51:35 +0100
Message-Id: <c22302a7db3cee6bcabf87462ed22a35dd38690f.1679675521.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timerlat is not reporting a new tracing_max_latency for the thread
latency. Also, the tracer is reporting new max latency on instances
where the tracing is off, creating inconsistencies between the max
reported values in the trace and in the tracing_max_latency. Thus
only report new tracing_max_latency on active tracing instances.

Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 210e1f168392..2a1b337ac643 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1296,7 +1296,7 @@ static void notify_new_max_latency(u64 latency)
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		tr = inst->tr;
-		if (tr->max_latency < latency) {
+		if (tracer_tracing_is_on(tr) && tr->max_latency < latency) {
 			tr->max_latency = latency;
 			latency_fsnotify(tr);
 		}
@@ -1738,6 +1738,8 @@ static int timerlat_main(void *data)
 
 		trace_timerlat_sample(&s);
 
+		notify_new_max_latency(diff);
+
 		timerlat_dump_stack(time_to_us(diff));
 
 		tlat->tracing_thread = false;
-- 
2.38.1

