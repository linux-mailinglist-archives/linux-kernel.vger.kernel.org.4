Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F686CED76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjC2Pur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjC2Puc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361F4EE2;
        Wed, 29 Mar 2023 08:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9257761D8F;
        Wed, 29 Mar 2023 15:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FAFC4339B;
        Wed, 29 Mar 2023 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105031;
        bh=LNmrHOHZSXL4IkLvbNsFQtsYFomPWDYEcws5TTYpK8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Styd9QyNRsWH/KQJOV/szMtfVnNCxmZQHrQi44NB3kIkK5VPgUqYjIX8x3fhovfXW
         sLtRs/F3QkDUlqHxGLa5jH8w7o4EOMLP0tu3+UGsCJozJTFbpm9xo3gJd7vFSv/QYk
         KAc4dtE535l+P3aqpcmsxgQsGyCX8TXGiPVqATIJxAjJIHU2QGf/rvYcb+La75a7Rl
         cERP5PX441FRFY7yHRIOU3c6ZDdcJZT5oNdZF7yk6o3wyCtd9LaPHLCzGR7+S/kNdY
         HVrlispeR0n4Zq1Uwv7qLhcWIT48oAXUZRE52jbHNnLvaJXSXPFzw+FMAmQTok9hzA
         nETHrDudcOnaw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH V2 2/2] tracing/osnoise: Fix notify new tracing_max_latency
Date:   Wed, 29 Mar 2023 17:50:16 +0200
Message-Id: <ecd109fde4a0c24ab0f00ba1e9a144ac19a91322.1680104184.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <16e18d61d69073d0192ace07bf61e405cca96e9c.1680104184.git.bristot@kernel.org>
References: <16e18d61d69073d0192ace07bf61e405cca96e9c.1680104184.git.bristot@kernel.org>
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

osnoise/timerlat tracers are reporting new max latency on instances
where the tracing is off, creating inconsistencies between the max
reported values in the trace and in the tracing_max_latency. Thus
only report new tracing_max_latency on active tracing instances.

Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e8116094bed8..4496975f2029 100644
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
-- 
2.38.1

