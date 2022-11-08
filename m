Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357D6218C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiKHPuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiKHPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:50:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156515C758;
        Tue,  8 Nov 2022 07:50:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A639061646;
        Tue,  8 Nov 2022 15:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA17C4314C;
        Tue,  8 Nov 2022 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922602;
        bh=MHHslVLlQavpqBMVzMqaHP+31Fg1qy0ktAOkl4B6S/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVLKzFOmK5FuxvbyRCCUUgY60moICzyWNKSZkxSo7BZhvvUDaBrbCDOFNTwj9Crt/
         /ZKyzCDMnssQo5EULcoTOODkCBlyrM8rF/hkDTWlHxnPv1OZMJ9UJ6Lat1R0hdNnDx
         dCi/ny1zmagXr3iueZvaGmlWiFbGPJL2ufnN+Y3/F3XunFVTm7WLMH6GcpZgfLHkW+
         J/ubXcgbQ1BHmjAMLHrm9iX637k2XhEXg59yJ/WMuRP/OQORDX/OZadkFCjb0mnBZE
         9oMtOaVAlQa6WdSSgetaGKoINIqxoDTVuCXyxUAwz82lZ1hjH1Qx/VrlrDFb5ZNmCz
         s+SHkxH5ejMNg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 5/9] fprobe: Skip exit_handler if entry_handler returns !0
Date:   Wed,  9 Nov 2022 00:49:58 +0900
Message-Id: <166792259869.919356.8529453996904377437.stgit@devnote3>
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
index 68c369452680..dadcddb6a429 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2623,12 +2623,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
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
@@ -2754,7 +2765,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
index 976fb3f7cb01..e78176d252ae 100644
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

