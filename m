Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306AB63166B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKTUqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKTUqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19151B1FE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:46:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C2B60CF3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31780C433C1;
        Sun, 20 Nov 2022 20:46:47 +0000 (UTC)
Date:   Sun, 20 Nov 2022 15:46:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Huafei <lihuafei1@huawei.com>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Yi Yang <yiyang13@huawei.com>
Subject: [GIT PULL] tracing/probes: Fixes for 6.1
Message-ID: <20221120154645.63d5c899@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Note, Masami started working on top of the trace/urgent branch to
create this branch (part way through). Thus, the trace/urgent branch
needs to be pulled before this one, otherwise the diffstat will not
match.
[ see https://lore.kernel.org/all/20221120201156.868430827@goodmis.org/ ]

tracing/probes: Fixes for v6.1

- Fix possible NULL pointer dereference  on trace_event_file in kprobe_event_gen_test_exit()

- Fix NULL pointer dereference for trace_array in kprobe_event_gen_test_exit()

- Fix memory leak of filter string for eprobes

- Fix a possible memory leak in rethook_alloc()

- Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case
  which can cause a possible use-after-free

- Fix warning in eprobe filter creation

- Fix eprobe filter creation as it picked the wrong event for the fields


Please pull the latest trace-probes-v6.1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-probes-v6.1

Tag SHA1: 0ce1f4b2fe737505f4c48ad637033191789971e1
Head SHA1: 40adaf51cb318131073d1ba8233d473cc105ecbf


Li Huafei (1):
      kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix eprobe filter to make a filter correctly

Rafael Mendonca (2):
      tracing/eprobe: Fix memory leak of filter string
      tracing/eprobe: Fix warning in filter creation

Shang XiaoJing (2):
      tracing: kprobe: Fix potential null-ptr-deref on trace_event_file in kprobe_event_gen_test_exit()
      tracing: kprobe: Fix potential null-ptr-deref on trace_array in kprobe_event_gen_test_exit()

Yi Yang (1):
      rethook: fix a potential memleak in rethook_alloc()

----
 kernel/kprobes.c                     |  8 +++++-
 kernel/trace/kprobe_event_gen_test.c | 48 ++++++++++++++++++++++++------------
 kernel/trace/rethook.c               |  4 ++-
 kernel/trace/trace_eprobe.c          |  5 ++--
 4 files changed, 45 insertions(+), 20 deletions(-)
---------------------------
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cd9f5a66a690..3050631e528d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1766,7 +1766,13 @@ static int __unregister_kprobe_top(struct kprobe *p)
 				if ((list_p != p) && (list_p->post_handler))
 					goto noclean;
 			}
-			ap->post_handler = NULL;
+			/*
+			 * For the kprobe-on-ftrace case, we keep the
+			 * post_handler setting to identify this aggrprobe
+			 * armed with kprobe_ipmodify_ops.
+			 */
+			if (!kprobe_ftrace(ap))
+				ap->post_handler = NULL;
 		}
 noclean:
 		/*
diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index d81f7c51025c..c736487fc0e4 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -73,6 +73,10 @@ static struct trace_event_file *gen_kretprobe_test;
 #define KPROBE_GEN_TEST_ARG3	NULL
 #endif
 
+static bool trace_event_file_is_valid(struct trace_event_file *input)
+{
+	return input && !IS_ERR(input);
+}
 
 /*
  * Test to make sure we can create a kprobe event, then add more
@@ -139,6 +143,8 @@ static int __init test_gen_kprobe_cmd(void)
 	kfree(buf);
 	return ret;
  delete:
+	if (trace_event_file_is_valid(gen_kprobe_test))
+		gen_kprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kprobe_test");
 	goto out;
@@ -202,6 +208,8 @@ static int __init test_gen_kretprobe_cmd(void)
 	kfree(buf);
 	return ret;
  delete:
+	if (trace_event_file_is_valid(gen_kretprobe_test))
+		gen_kretprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kretprobe_test");
 	goto out;
@@ -217,10 +225,12 @@ static int __init kprobe_event_gen_test_init(void)
 
 	ret = test_gen_kretprobe_cmd();
 	if (ret) {
-		WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
-						  "kprobes",
-						  "gen_kretprobe_test", false));
-		trace_put_event_file(gen_kretprobe_test);
+		if (trace_event_file_is_valid(gen_kretprobe_test)) {
+			WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+							  "kprobes",
+							  "gen_kretprobe_test", false));
+			trace_put_event_file(gen_kretprobe_test);
+		}
 		WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
 	}
 
@@ -229,24 +239,30 @@ static int __init kprobe_event_gen_test_init(void)
 
 static void __exit kprobe_event_gen_test_exit(void)
 {
-	/* Disable the event or you can't remove it */
-	WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
-					  "kprobes",
-					  "gen_kprobe_test", false));
+	if (trace_event_file_is_valid(gen_kprobe_test)) {
+		/* Disable the event or you can't remove it */
+		WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+						  "kprobes",
+						  "gen_kprobe_test", false));
+
+		/* Now give the file and instance back */
+		trace_put_event_file(gen_kprobe_test);
+	}
 
-	/* Now give the file and instance back */
-	trace_put_event_file(gen_kprobe_test);
 
 	/* Now unregister and free the event */
 	WARN_ON(kprobe_event_delete("gen_kprobe_test"));
 
-	/* Disable the event or you can't remove it */
-	WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
-					  "kprobes",
-					  "gen_kretprobe_test", false));
+	if (trace_event_file_is_valid(gen_kretprobe_test)) {
+		/* Disable the event or you can't remove it */
+		WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+						  "kprobes",
+						  "gen_kretprobe_test", false));
+
+		/* Now give the file and instance back */
+		trace_put_event_file(gen_kretprobe_test);
+	}
 
-	/* Now give the file and instance back */
-	trace_put_event_file(gen_kretprobe_test);
 
 	/* Now unregister and free the event */
 	WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index c69d82273ce7..32c3dfdb4d6a 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -83,8 +83,10 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
 {
 	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
 
-	if (!rh || !handler)
+	if (!rh || !handler) {
+		kfree(rh);
 		return NULL;
+	}
 
 	rh->data = data;
 	rh->handler = handler;
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5dd0617e5df6..123d2c0a6b68 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -52,6 +52,7 @@ static void trace_event_probe_cleanup(struct trace_eprobe *ep)
 	kfree(ep->event_system);
 	if (ep->event)
 		trace_event_put_ref(ep->event);
+	kfree(ep->filter_str);
 	kfree(ep);
 }
 
@@ -642,7 +643,7 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 	INIT_LIST_HEAD(&trigger->list);
 
 	if (ep->filter_str) {
-		ret = create_event_filter(file->tr, file->event_call,
+		ret = create_event_filter(file->tr, ep->event,
 					ep->filter_str, false, &filter);
 		if (ret)
 			goto error;
@@ -900,7 +901,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 
 static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
 {
-	struct event_filter *dummy;
+	struct event_filter *dummy = NULL;
 	int i, ret, len = 0;
 	char *p;
 
