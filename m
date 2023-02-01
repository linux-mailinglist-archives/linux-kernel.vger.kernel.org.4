Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45719683258
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjAaQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAaQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:15:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA47C53E75;
        Tue, 31 Jan 2023 08:15:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95543B81CD9;
        Tue, 31 Jan 2023 16:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024F1C433D2;
        Tue, 31 Jan 2023 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181716;
        bh=xoo+m5nnKJwCHyu3Pdsr89f7T1zFTE7ZqK87QXapMiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kiffb93JpdmNsqrQqXmR/qKIzMxBFs1b/1xGVTa1YPDXQ3GDU88lXebTBIM57jISV
         rRC4A3/BYJuwzsrbh3IIbiS5aOSdpf26kz8GClgrZpahT9B9aLAsoQt189rG5UF5lO
         co0VyHtcBLoVi6bkD5MJlx1Inyq/AJ+qEVnaxB8Xyuczq+WwhERmXnBuHHWI3/En/q
         JSloERMawcPgEcKU8szdgHvA7LyRORwKiphsfxxs7alwtut6ORhCy51DuXJACeSDN4
         I9X9T+DKX6P+UEqaEFMInfcRyvk1UGJPBx9m0H04PjvnNLMyO8Z6dwUsXcNjfiLeXc
         R6iMlaDFf7ZfQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 01/10] fprobe: Pass entry_data to handlers
Date:   Wed,  1 Feb 2023 01:15:12 +0900
Message-Id:  <167518171273.336834.17666863442580618765.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Pass the private entry_data to the entry and exit handlers so that
they can share the context data, something like saved function
arguments etc.
User must specify the private entry_data size by @entry_data_size
field before registering the fprobe.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/fprobe.h          |    8 ++++++--
 kernel/trace/bpf_trace.c        |    2 +-
 kernel/trace/fprobe.c           |   21 ++++++++++++++-------
 lib/test_fprobe.c               |    6 ++++--
 samples/fprobe/fprobe_example.c |    6 ++++--
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
index f47274de012b..834c0a7efcdb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2649,7 +2649,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
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
 

