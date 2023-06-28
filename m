Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3157413FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjF1OoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjF1OoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1920AA2;
        Wed, 28 Jun 2023 07:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 984396134E;
        Wed, 28 Jun 2023 14:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E79C433C0;
        Wed, 28 Jun 2023 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687963446;
        bh=CftGqe7uSHGDIhGMtuKnY6LHqyYkAcjuQD1TCyu0PK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaKcEvpLCTUDffE/nH0JPp2K2Du1tThuKk5BM0oGygHn8wf+QK+vP6yssdtE5LrQQ
         BfCRurBIscWWv+hzIgI6oVxccIse66uxbcdp/oJFz1Ryh+TfrcaR45b26LIbczo+UQ
         nxqgPpKsl9Uy9VL2Mxl7+cl8Sgv01fdwHmTYpnCS4EbigCBFv9o8n8olJ/LtfmCjXH
         GXzGbAQffGUbLDmk7wniU6Gwg5l9SBTaJ8rEfPkiCD4rc4HXWwMHcMr/1IEL2wWj/F
         KdZX8/9b5rIILrUOI8mzMa6Un4sY5RVngrauCz4Ojju8FLEog8WnwgdbtJxsAS4asg
         7K6YmX9KuwpQg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()
Date:   Wed, 28 Jun 2023 23:44:02 +0900
Message-Id: <168796344232.46347.7947681068822514750.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Ensure running fprobe_exit_handler() has finished before
calling rethook_free() in the unregister_fprobe() so that caller can free
the fprobe right after unregister_fprobe().

unregister_fprobe() ensured that all running fprobe_entry/exit_handler()
have finished by calling unregister_ftrace_function() which synchronizes
RCU. But commit 5f81018753df ("fprobe: Release rethook after the ftrace_ops
is unregistered") changed to call rethook_free() after
unregister_ftrace_function(). So call rethook_stop() to make rethook
disabled before unregister_ftrace_function() and ensure it again.

Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is unregistered")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/rethook.h |    1 +
 kernel/trace/fprobe.c   |    3 +++
 kernel/trace/rethook.c  |   13 +++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index c8ac1e5afcd1..bdbe6717f45a 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -59,6 +59,7 @@ struct rethook_node {
 };
 
 struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
+void rethook_stop(struct rethook *rh);
 void rethook_free(struct rethook *rh);
 void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 0121e8c0d54e..75517667b54f 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -364,6 +364,9 @@ int unregister_fprobe(struct fprobe *fp)
 		    fp->ops.saved_func != fprobe_kprobe_handler))
 		return -EINVAL;
 
+	if (fp->rethook)
+		rethook_stop(fp->rethook);
+
 	ret = unregister_ftrace_function(&fp->ops);
 	if (ret < 0)
 		return ret;
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 60f6cb2b486b..468006cce7ca 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -53,6 +53,19 @@ static void rethook_free_rcu(struct rcu_head *head)
 		kfree(rh);
 }
 
+/**
+ * rethook_stop() - Stop using a rethook.
+ * @rh: the struct rethook to stop.
+ *
+ * Stop using a rethook to prepare for freeing it. If you want to wait for
+ * all running rethook handler before calling rethook_free(), you need to
+ * call this first and wait RCU, and call rethook_free().
+ */
+void rethook_stop(struct rethook *rh)
+{
+	WRITE_ONCE(rh->handler, NULL);
+}
+
 /**
  * rethook_free() - Free struct rethook.
  * @rh: the struct rethook to be freed.

