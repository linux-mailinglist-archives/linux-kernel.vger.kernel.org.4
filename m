Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE77686AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjBAP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjBAP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:57:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974D76403;
        Wed,  1 Feb 2023 07:56:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 835C6B821CA;
        Wed,  1 Feb 2023 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC7AC433EF;
        Wed,  1 Feb 2023 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675267001;
        bh=uzTNf0cgLlGLZxT0DAIJxvZ2bm17NBEQobBAKutMPqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2Th+4WaQg+nFVcTc1L6/Xuofs64gEdqzrZjHLNqtABoRYizIGhAV+biFniSLR6CI
         kNwUoVLVSVb6bmJ8uVeU2qXmLr6dnK5V+FrCbevvYcDJWNVMrNhikwZENWYYtcsu3I
         9RORQi1wO6HZIKrFjoCF/S81DEzlSLROJR0qwtIjupmAOTn2uEbp/e7NvUBuDF5c9V
         TTfH8XkxI7iauY/eJ4WTk0Nz4lxOtR501a8ZlpinVmjc0RG2+FB1J6IzgKTcm9ApNP
         SCqW3xhurJAOIv8LpyQoHhgw7X053kFRwD3/HWguYvQiqNOdTRytGCzfgvV9J3MTFb
         ZfP04IrYJ8IeA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 05/10] fprobe: Skip exit_handler if entry_handler returns !0
Date:   Thu,  2 Feb 2023 00:56:38 +0900
Message-Id:  <167526699798.433354.10998365726830117303.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167526695292.433354.8949652607331707144.stgit@mhiramat.roam.corp.google.com>
References:  <167526695292.433354.8949652607331707144.stgit@mhiramat.roam.corp.google.com>
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

Skip hooking function return and calling exit_handler if the
entry_handler() returns !0.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/fprobe.h          |    4 ++--
 kernel/trace/bpf_trace.c        |   15 +++++++++++++--
 kernel/trace/fprobe.c           |   14 +++++++++-----
 lib/test_fprobe.c               |    7 +++++--
 samples/fprobe/fprobe_example.c |    5 +++--
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
index 834c0a7efcdb..b2567670ca42 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2647,12 +2647,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
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
@@ -2843,7 +2854,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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

