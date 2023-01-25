Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722E67B6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjAYQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjAYQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:20:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6C5618F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665D56144C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D323FC433AA;
        Wed, 25 Jan 2023 16:20:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKiVO-004MsU-2b;
        Wed, 25 Jan 2023 11:20:10 -0500
Message-ID: <20230125162010.631776115@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 11:18:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Chuang Wang <nashuiliang@gmail.com>
Subject: [for-linus][PATCH 05/11] tracing/osnoise: Use built-in RCU list checking
References: <20230125161824.332648375@goodmis.org>
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

From: Chuang Wang <nashuiliang@gmail.com>

list_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence false lockdep
warning when CONFIG_PROVE_RCU_LIST is enabled.

Execute as follow:

 [tracing]# echo osnoise > current_tracer
 [tracing]# echo 1 > tracing_on
 [tracing]# echo 0 > tracing_on

The trace_types_lock is held when osnoise_tracer_stop() or
timerlat_tracer_stop() are called in the non-RCU read side section.
So, pass lockdep_is_held(&trace_types_lock) to silence false lockdep
warning.

Link: https://lkml.kernel.org/r/20221227023036.784337-1-nashuiliang@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 94c1b5eb1dc0..210e1f168392 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -147,9 +147,8 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	 * register/unregister serialization is provided by trace's
 	 * trace_types_lock.
 	 */
-	lockdep_assert_held(&trace_types_lock);
-
-	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
+	list_for_each_entry_rcu(inst, &osnoise_instances, list,
+				lockdep_is_held(&trace_types_lock)) {
 		if (inst->tr == tr) {
 			list_del_rcu(&inst->list);
 			found = 1;
-- 
2.39.0
