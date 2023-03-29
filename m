Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9866CF377
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjC2TqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC2Tpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DFB126
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 961DF61E1F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF2AC433AF;
        Wed, 29 Mar 2023 19:45:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjy-002Rgv-0c;
        Wed, 29 Mar 2023 15:45:50 -0400
Message-ID: <20230329194550.004033858@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 05/25] fprobe: Skip exit_handler if entry_handler returns !0
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

Skip hooking function return and calling exit_handler if the
entry_handler() returns !0.

Link: https://lkml.kernel.org/r/167526699798.433354.10998365726830117303.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/fprobe.h          |  4 ++--
 kernel/trace/bpf_trace.c        | 15 +++++++++++++--
 kernel/trace/fprobe.c           | 14 +++++++++-----
 lib/test_fprobe.c               |  7 +++++--
 samples/fprobe/fprobe_example.c |  5 +++--
 5 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 678f741a7b33..47fefc7f363b 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -34,8 +34,8 @@ struct fprobe {
 	size_t			entry_data_size;
 	int			nr_maxactive;
 
-	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
-			      struct pt_regs *regs, void *entry_data);
+	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
+			     struct pt_regs *regs, void *entry_data);
 	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
 			     struct pt_regs *regs, void *entry_data);
 };
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fa403c323501..d804172b709c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2644,12 +2644,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	return err;
 }
 
-static void
+static int
 kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  struct pt_regs *regs, void *data)
 {
 	struct bpf_kprobe_multi_link *link;
 
+	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	return 0;
+}
+
+static void
+kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
+			       struct pt_regs *regs, void *data)
+{
+	struct bpf_kprobe_multi_link *link;
+
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
 }
@@ -2848,7 +2859,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		goto error;
 
 	if (flags & BPF_F_KPROBE_MULTI_RETURN)
-		link->fp.exit_handler = kprobe_multi_link_handler;
+		link->fp.exit_handler = kprobe_multi_link_exit_handler;
 	else
 		link->fp.entry_handler = kprobe_multi_link_handler;
 
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index f222848571f2..9abb3905bc8e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -27,7 +27,7 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit;
+	int bit, ret;
 
 	fp = container_of(ops, struct fprobe, ops);
 	if (fprobe_disabled(fp))
@@ -52,11 +52,15 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	}
 
 	if (fp->entry_handler)
-		fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
-
-	if (rh)
-		rethook_hook(rh, ftrace_get_regs(fregs), true);
+		ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
 
+	/* If entry_handler returns !0, nmissed is not counted. */
+	if (rh) {
+		if (ret)
+			rethook_recycle(rh);
+		else
+			rethook_hook(rh, ftrace_get_regs(fregs), true);
+	}
 out:
 	ftrace_test_recursion_unlock(bit);
 }
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 4b37d7022f35..9fa2ac9eda83 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -37,7 +37,7 @@ static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
 	return nest(value + 2);
 }
 
-static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip,
+static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 				     struct pt_regs *regs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
@@ -51,6 +51,8 @@ static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip,
 			*(u32 *)data = entry_val;
 	} else
 		KUNIT_EXPECT_NULL(current_test, data);
+
+	return 0;
 }
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -74,10 +76,11 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 		KUNIT_EXPECT_NULL(current_test, data);
 }
 
-static notrace void nest_entry_handler(struct fprobe *fp, unsigned long ip,
+static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
 				     struct pt_regs *regs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
+	return 0;
 }
 
 static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index dd794990ad7e..4efc8feb6277 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -48,8 +48,8 @@ static void show_backtrace(void)
 	stack_trace_print(stacks, len, 24);
 }
 
-static void sample_entry_handler(struct fprobe *fp, unsigned long ip,
-				 struct pt_regs *regs, void *data)
+static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
+				struct pt_regs *regs, void *data)
 {
 	if (use_trace)
 		/*
@@ -62,6 +62,7 @@ static void sample_entry_handler(struct fprobe *fp, unsigned long ip,
 	nhit++;
 	if (stackdump)
 		show_backtrace();
+	return 0;
 }
 
 static void sample_exit_handler(struct fprobe *fp, unsigned long ip, struct pt_regs *regs,
-- 
2.39.1
