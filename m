Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD24749F13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjGFOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGFOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E441BD2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D5161987
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D5C433C7;
        Thu,  6 Jul 2023 14:34:11 +0000 (UTC)
Date:   Thu, 6 Jul 2023 10:34:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mateusz Stachyra <m.stachyra@samsung.com>
Subject: [GIT PULL] tracing: Minor fixes for 6.5
Message-ID: <20230706103410.6499a3cc@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 6.5:

- Fix bad git merge of #endif in arm64 code
  A merge of the arm64 tree caused #endif to go into the wrong place

- Fix crash on lseek of write access to tracefs/error_log
  Opening error_log as write only, and then doing an lseek() causes
  a kernel panic, because the lseek() handle expects a "seq_file"
  to exist (which is not done on write only opens). Use tracing_lseek()
  that tests for this instead of calling the default seq lseek handler.

- Check for negative instead of -E2BIG for error on strscpy() returns
  Instead of testing for -E2BIG from strscpy(), to be more robust,
  check for less than zero, which will make sure it catches any error
  that strscpy() may someday return.


Please pull the latest trace-v6.5-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.5-2

Tag SHA1: 8201ec458c9725804267e4eda962cdaf202e85f1
Head SHA1: fddca7db4a4c17f7333793dfb5308d80c76d2896


Arnd Bergmann (1):
      arm64: ftrace: fix build error with CONFIG_FUNCTION_GRAPH_TRACER=n

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Steven Rostedt (Google) (1):
      tracing/boot: Test strscpy() against less than zero for error

----
 arch/arm64/kernel/asm-offsets.c | 2 +-
 kernel/trace/trace.c            | 2 +-
 kernel/trace/trace_boot.c       | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)
---------------------------
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 757d01a68ffd..5ff1942b04fc 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -213,9 +213,9 @@ int main(void)
   DEFINE(FGRET_REGS_X7,			offsetof(struct fgraph_ret_regs, regs[7]));
   DEFINE(FGRET_REGS_FP,			offsetof(struct fgraph_ret_regs, fp));
   DEFINE(FGRET_REGS_SIZE,		sizeof(struct fgraph_ret_regs));
+#endif
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
   DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
-#endif
 #endif
   return 0;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64a4dde073ef..3d34e6fea6b2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8135,7 +8135,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
 
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 5fe525f1b8cc..7ccc7a8e155b 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 
 	/* Common ftrace options */
 	xbc_node_for_each_array_value(node, "options", anode, p) {
-		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	const char *p;
 
 	xbc_node_for_each_array_value(node, "events", anode, p) {
-		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	p = xbc_node_find_value(enode, "filter", NULL);
 	if (p && *p != '\0') {
-		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
 			pr_err("filter string is too long: %s\n", p);
 		else if (apply_event_filter(file, buf) < 0)
 			pr_err("Failed to apply filter: %s\n", buf);
@@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
 		xbc_node_for_each_array_value(enode, "actions", anode, p) {
-			if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
+			if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
