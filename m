Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4926CF380
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjC2TqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC2Tpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340F193
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3F68B82437
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D127C4339C;
        Wed, 29 Mar 2023 19:45:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjx-002Rej-1C;
        Wed, 29 Mar 2023 15:45:49 -0400
Message-ID: <20230329194549.186982647@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 01/25] fprobe: Pass entry_data to handlers
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Pass the private entry_data to the entry and exit handlers so that
they can share the context data, something like saved function
arguments etc.
User must specify the private entry_data size by @entry_data_size
field before registering the fprobe.

Link: https://lkml.kernel.org/r/167526696173.433354.17408372048319432574.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/fprobe.h          |  8 ++++++--
 kernel/trace/bpf_trace.c        |  2 +-
 kernel/trace/fprobe.c           | 21 ++++++++++++++-------
 lib/test_fprobe.c               |  6 ++++--
 samples/fprobe/fprobe_example.c |  6 ++++--
 5 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 1c2bde0ead73..e0d4e6136249 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -13,6 +13,7 @@
  * @nmissed: The counter for missing events.
  * @flags: The status flag.
  * @rethook: The rethook data structure. (internal data)
+ * @entry_data_size: The private data storage size.
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  */
@@ -29,9 +30,12 @@ struct fprobe {
 	unsigned long		nmissed;
 	unsigned int		flags;
 	struct rethook		*rethook;
+	size_t			entry_data_size;
 
-	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
-	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
+	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
+			      struct pt_regs *regs, void *entry_data);
+	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
+			     struct pt_regs *regs, void *entry_data);
 };
 
 /* This fprobe is soft-disabled. */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e8da032bb6fc..fa403c323501 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2646,7 +2646,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 static void
 kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
-			  struct pt_regs *regs)
+			  struct pt_regs *regs, void *data)
 {
 	struct bpf_kprobe_multi_link *link;
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index e8143e368074..fa25d09c9d57 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -17,14 +17,16 @@
 struct fprobe_rethook_node {
 	struct rethook_node node;
 	unsigned long entry_ip;
+	char data[];
 };
 
 static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct fprobe_rethook_node *fpr;
-	struct rethook_node *rh;
+	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
+	void *entry_data = NULL;
 	int bit;
 
 	fp = container_of(ops, struct fprobe, ops);
@@ -37,9 +39,6 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 	}
 
-	if (fp->entry_handler)
-		fp->entry_handler(fp, ip, ftrace_get_regs(fregs));
-
 	if (fp->exit_handler) {
 		rh = rethook_try_get(fp->rethook);
 		if (!rh) {
@@ -48,9 +47,16 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
-		rethook_hook(rh, ftrace_get_regs(fregs), true);
+		if (fp->entry_data_size)
+			entry_data = fpr->data;
 	}
 
+	if (fp->entry_handler)
+		fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
+
+	if (rh)
+		rethook_hook(rh, ftrace_get_regs(fregs), true);
+
 out:
 	ftrace_test_recursion_unlock(bit);
 }
@@ -81,7 +87,8 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
-	fp->exit_handler(fp, fpr->entry_ip, regs);
+	fp->exit_handler(fp, fpr->entry_ip, regs,
+			 fp->entry_data_size ? (void *)fpr->data : NULL);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
 
@@ -146,7 +153,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 	for (i = 0; i < size; i++) {
 		struct fprobe_rethook_node *node;
 
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		node = kzalloc(sizeof(*node) + fp->entry_data_size, GFP_KERNEL);
 		if (!node) {
 			rethook_free(fp->rethook);
 			fp->rethook = NULL;
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 1fb56cf5e5ce..e4f65d114ed2 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -30,7 +30,8 @@ static noinline u32 fprobe_selftest_target2(u32 value)
 	return (value / div_factor) + 1;
 }
 
-static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip,
+				     struct pt_regs *regs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
@@ -39,7 +40,8 @@ static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip, struct
 	entry_val = (rand1 / div_factor);
 }
 
-static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
+				    struct pt_regs *regs, void *data)
 {
 	unsigned long ret = regs_return_value(regs);
 
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index e22da8573116..dd794990ad7e 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -48,7 +48,8 @@ static void show_backtrace(void)
 	stack_trace_print(stacks, len, 24);
 }
 
-static void sample_entry_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+static void sample_entry_handler(struct fprobe *fp, unsigned long ip,
+				 struct pt_regs *regs, void *data)
 {
 	if (use_trace)
 		/*
@@ -63,7 +64,8 @@ static void sample_entry_handler(struct fprobe *fp, unsigned long ip, struct pt_
 		show_backtrace();
 }
 
-static void sample_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs)
+static void sample_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs,
+				void *data)
 {
 	unsigned long rip = instruction_pointer(regs);
 
-- 
2.39.1
