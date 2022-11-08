Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921366218C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiKHPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiKHPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:50:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D7025E81;
        Tue,  8 Nov 2022 07:50:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71C2F61652;
        Tue,  8 Nov 2022 15:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F996C433D6;
        Tue,  8 Nov 2022 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922628;
        bh=87/lyGR9IWeD+IoOj3R8OVwKVrMqxcqeTsI/Pz131p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mifF5X336aIMdZFwcbjp/lOahDVYpjuR2Ee6gQnY7vfN2iBGGJDn2sserBeQGKl6O
         Fj1PU96oNreEWVw8LBcX09KHQysIc77sYucfB+nYF90Y0kppX+iufyIIr6l2IOzVln
         uOTGhrPVG+9FBB6Z7DSECAkDE7G4sEiNqfuOmib5Y7kd+zJ1jG6K3pAHhSz/kf+vne
         W9qh4ujgw0aDUg2N1yVBOEuLakE5M9wEn/5VKNyiHfnKqSA5FKzL9lgXFbUyKNmvBl
         Mnc/ohp1iBNa4fgKQhLhXw3lY50I+7CkiXy3rAWy1m0GX1p1NHEZhygzJbNr+v3D4/
         f5UVosqaCj1CQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 8/9] fprobe: Pass return address to the handlers
Date:   Wed,  9 Nov 2022 00:50:25 +0900
Message-Id: <166792262501.919356.16676046094403503882.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <166792255429.919356.14116090269057513181.stgit@devnote3>
References: <166792255429.919356.14116090269057513181.stgit@devnote3>
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

Pass return address as 'ret_ip' to the fprobe entry and return handlers.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/fprobe.h          |    6 ++++--
 include/linux/rethook.h         |    2 +-
 kernel/kprobes.c                |    1 +
 kernel/trace/bpf_trace.c        |    6 ++++--
 kernel/trace/fprobe.c           |    6 +++---
 kernel/trace/rethook.c          |    3 ++-
 lib/test_fprobe.c               |   10 +++++++---
 samples/fprobe/fprobe_example.c |    6 ++++--
 8 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 47fefc7f363b..134f0f59ffa8 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -35,9 +35,11 @@ struct fprobe {
 	int			nr_maxactive;
 
 	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     struct pt_regs *regs, void *entry_data);
+			     unsigned long ret_ip, struct pt_regs *regs,
+			     void *entry_data);
 	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     struct pt_regs *regs, void *entry_data);
+			     unsigned long ret_ip, struct pt_regs *regs,
+			     void *entry_data);
 };
 
 /* This fprobe is soft-disabled. */
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index c8ac1e5afcd1..fdf26cd0e742 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -14,7 +14,7 @@
 
 struct rethook_node;
 
-typedef void (*rethook_handler_t) (struct rethook_node *, void *, struct pt_regs *);
+typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
 
 /**
  * struct rethook - The rethook management data structure.
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cd9f5a66a690..61d9eb467cef 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2124,6 +2124,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
 static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
+				      unsigned long ret_addr,
 				      struct pt_regs *regs)
 {
 	struct kretprobe *rp = (struct kretprobe *)data;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dadcddb6a429..44ca58192c31 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2625,7 +2625,8 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 static int
 kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
-			  struct pt_regs *regs, void *data)
+			  unsigned long ret_ip, struct pt_regs *regs,
+			  void *data)
 {
 	struct bpf_kprobe_multi_link *link;
 
@@ -2636,7 +2637,8 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 
 static void
 kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
-			       struct pt_regs *regs, void *data)
+			       unsigned long ret_ip, struct pt_regs *regs,
+			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9abb3905bc8e..973bc664fcc1 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -52,7 +52,7 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	}
 
 	if (fp->entry_handler)
-		ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
+		ret = fp->entry_handler(fp, ip, parent_ip, ftrace_get_regs(fregs), entry_data);
 
 	/* If entry_handler returns !0, nmissed is not counted. */
 	if (rh) {
@@ -81,7 +81,7 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 }
 
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,
-				struct pt_regs *regs)
+				unsigned long ret_ip, struct pt_regs *regs)
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
@@ -91,7 +91,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
-	fp->exit_handler(fp, fpr->entry_ip, regs,
+	fp->exit_handler(fp, fpr->entry_ip, ret_ip, regs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index c69d82273ce7..3f6702b27c85 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -299,7 +299,8 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 			break;
 		handler = READ_ONCE(rhn->rethook->handler);
 		if (handler)
-			handler(rhn, rhn->rethook->data, regs);
+			handler(rhn, rhn->rethook->data,
+				correct_ret_addr, regs);
 
 		if (first == node)
 			break;
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 926d5104b291..addf7db4a191 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -39,7 +39,8 @@ static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
 }
 
 static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
-				     struct pt_regs *regs, void *data)
+				    unsigned long ret_ip,
+				    struct pt_regs *regs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
@@ -57,6 +58,7 @@ static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 }
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
+				    unsigned long ret_ip,
 				    struct pt_regs *regs, void *data)
 {
 	unsigned long ret = regs_return_value(regs);
@@ -78,14 +80,16 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 }
 
 static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
-				     struct pt_regs *regs, void *data)
+				      unsigned long ret_ip,
+				      struct pt_regs *regs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	return 0;
 }
 
 static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
-				    struct pt_regs *regs, void *data)
+				      unsigned long ret_ip,
+				      struct pt_regs *regs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 4efc8feb6277..64e715e7ed11 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -49,6 +49,7 @@ static void show_backtrace(void)
 }
 
 static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
+				unsigned long ret_ip,
 				struct pt_regs *regs, void *data)
 {
 	if (use_trace)
@@ -65,10 +66,11 @@ static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 	return 0;
 }
 
-static void sample_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs,
+static void sample_exit_handler(struct fprobe *fp, unsigned long ip,
+				unsigned long ret_ip, struct pt_regs *regs,
 				void *data)
 {
-	unsigned long rip = instruction_pointer(regs);
+	unsigned long rip = ret_ip;
 
 	if (use_trace)
 		/*

