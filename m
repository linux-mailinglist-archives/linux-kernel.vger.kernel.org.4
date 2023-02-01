Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9864B686AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjBAP4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjBAP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:56:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677E74C27;
        Wed,  1 Feb 2023 07:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70998B821C8;
        Wed,  1 Feb 2023 15:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873C1C433D2;
        Wed,  1 Feb 2023 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675266983;
        bh=uMXIDE3N6tRBHy0qXfA/qokcfkSD+HhNMwAWfevtvoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrydbhvQs+mp9exjo8pOyRlRcGOI2CXEtPJSP8VUccZ7GsBUbb/+ZynCXQKI1gHck
         9wjR8n/hhivo2HeZGxQ8U8uiWlwmoWU7gX9JZQPeiY6t0YtOZhUd3ZR0auhcai7gHx
         1kO1cvzNbAToGya/q+iuwA9wj34LSwXdbBjcOG3Ulpp9QeIyl2sLRehi4WUI7FpdBw
         SXmhqAvLeU+GuqmKAaWwn/LZ0fnqMS+j02k919+rQn/sa/UNoDUhi0TMsdcuaS8R6X
         lY9bKfLNxLpn5IwGqig78TW6Sr193R6VJfUW70JCPwzudLLKPkkbu2BudC6M69S1/p
         hPLviTL/9f3Qw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 03/10] fprobe: Add nr_maxactive to specify rethook_node pool size
Date:   Thu,  2 Feb 2023 00:56:19 +0900
Message-Id:  <167526697917.433354.17779774988245113106.stgit@mhiramat.roam.corp.google.com>
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

Add nr_maxactive to specify rethook_node pool size. This means
the maximum number of actively running target functions concurrently
for probing by exit_handler. Note that if the running function is
preempted or sleep, it is still counted as 'active'.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/fprobe.h |    2 ++
 kernel/trace/fprobe.c  |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index e0d4e6136249..678f741a7b33 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -14,6 +14,7 @@
  * @flags: The status flag.
  * @rethook: The rethook data structure. (internal data)
  * @entry_data_size: The private data storage size.
+ * @nr_maxactive: The max number of active functions.
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  */
@@ -31,6 +32,7 @@ struct fprobe {
 	unsigned int		flags;
 	struct rethook		*rethook;
 	size_t			entry_data_size;
+	int			nr_maxactive;
 
 	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
 			      struct pt_regs *regs, void *entry_data);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fa25d09c9d57..f222848571f2 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -143,7 +143,10 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 	}
 
 	/* Initialize rethook if needed */
-	size = num * num_possible_cpus() * 2;
+	if (fp->nr_maxactive)
+		size = fp->nr_maxactive;
+	else
+		size = num * num_possible_cpus() * 2;
 	if (size < 0)
 		return -E2BIG;
 

