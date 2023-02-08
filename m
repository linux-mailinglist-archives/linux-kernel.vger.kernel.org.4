Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE168E5B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBHB5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBHB5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5B3E601
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D02B6147F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B27DC433D2;
        Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiF-006dPG-25;
        Tue, 07 Feb 2023 20:57:31 -0500
Message-ID: <20230208015731.460057881@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [for-next][PATCH 06/11] samples: ftrace: Make some global variables static
References: <20230208015633.791198913@goodmis.org>
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

From: Tom Rix <trix@redhat.com>

smatch reports this representative issue
samples/ftrace/ftrace-ops.c:15:14: warning: symbol 'nr_function_calls' was not declared. Should it be static?

The nr_functions_calls and several other global variables are only
used in ftrace-ops.c, so they should be static.
Remove the instances of initializing static int to 0.

Link: https://lore.kernel.org/linux-trace-kernel/20230130193708.1378108-1-trix@redhat.com

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-ops.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 0c8da87ff5c3..68d6685c80bd 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -12,7 +12,7 @@
  * Arbitrary large value chosen to be sufficiently large to minimize noise but
  * sufficiently small to complete quickly.
  */
-unsigned int nr_function_calls = 100000;
+static unsigned int nr_function_calls = 100000;
 module_param(nr_function_calls, uint, 0);
 MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee");
 
@@ -21,7 +21,7 @@ MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee"
  * be called directly or whether it's necessary to go via the list func, which
  * can be significantly more expensive.
  */
-unsigned int nr_ops_relevant = 1;
+static unsigned int nr_ops_relevant = 1;
 module_param(nr_ops_relevant, uint, 0);
 MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the relevant tracee");
 
@@ -30,7 +30,7 @@ MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the rel
  * tracers enabled for distinct functions can force the use of the list func
  * and incur overhead for all call sites.
  */
-unsigned int nr_ops_irrelevant = 0;
+static unsigned int nr_ops_irrelevant;
 module_param(nr_ops_irrelevant, uint, 0);
 MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the irrelevant tracee");
 
@@ -38,15 +38,15 @@ MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the i
  * On architectures with DYNAMIC_FTRACE_WITH_REGS, saving the full pt_regs can
  * be more expensive than only saving the minimal necessary regs.
  */
-bool save_regs = false;
+static bool save_regs;
 module_param(save_regs, bool, 0);
 MODULE_PARM_DESC(save_regs, "Register ops with FTRACE_OPS_FL_SAVE_REGS (save all registers in the trampoline)");
 
-bool assist_recursion = false;
+static bool assist_recursion;
 module_param(assist_recursion, bool, 0);
 MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RECURSION");
 
-bool assist_rcu = false;
+static bool assist_rcu;
 module_param(assist_rcu, bool, 0);
 MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
 
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
  * overhead. Sometimes a consistency check using a more expensive tracer is
  * desireable.
  */
-bool check_count = false;
+static bool check_count;
 module_param(check_count, bool, 0);
 MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number of times\n");
 
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number
  * runs, but sometimes it can be useful to leave them registered so that they
  * can be inspected through the tracefs 'enabled_functions' file.
  */
-bool persist = false;
+static bool persist;
 module_param(persist, bool, 0);
 MODULE_PARM_DESC(persist, "Successfully load module and leave ftrace ops registered after test completes\n");
 
@@ -114,8 +114,8 @@ static void ops_func_count(unsigned long ip, unsigned long parent_ip,
 	self->count++;
 }
 
-struct sample_ops *ops_relevant;
-struct sample_ops *ops_irrelevant;
+static struct sample_ops *ops_relevant;
+static struct sample_ops *ops_irrelevant;
 
 static struct sample_ops *ops_alloc_init(void *tracee, ftrace_func_t func,
 					 unsigned long flags, int nr)
@@ -163,8 +163,8 @@ static void ops_check(struct sample_ops *ops, int nr,
 	}
 }
 
-ftrace_func_t tracer_relevant = ops_func_nop;
-ftrace_func_t tracer_irrelevant = ops_func_nop;
+static ftrace_func_t tracer_relevant = ops_func_nop;
+static ftrace_func_t tracer_irrelevant = ops_func_nop;
 
 static int __init ftrace_ops_sample_init(void)
 {
-- 
2.39.1
