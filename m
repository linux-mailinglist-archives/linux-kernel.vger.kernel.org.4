Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECDD6CF37F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC2TqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjC2Tpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673431B8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A518B82433
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EB9C433A4;
        Wed, 29 Mar 2023 19:45:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjx-002Rfp-2V;
        Wed, 29 Mar 2023 15:45:49 -0400
Message-ID: <20230329194549.595038894@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 03/25] fprobe: Add nr_maxactive to specify rethook_node pool size
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

Add nr_maxactive to specify rethook_node pool size. This means
the maximum number of actively running target functions concurrently
for probing by exit_handler. Note that if the running function is
preempted or sleep, it is still counted as 'active'.

Link: https://lkml.kernel.org/r/167526697917.433354.17779774988245113106.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/fprobe.h | 2 ++
 kernel/trace/fprobe.c  | 5 ++++-
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
 
-- 
2.39.1
