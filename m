Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAD677C66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjAWNYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C6241C8;
        Mon, 23 Jan 2023 05:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A6DB60EFF;
        Mon, 23 Jan 2023 13:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF69C433EF;
        Mon, 23 Jan 2023 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674480248;
        bh=ArZD+vzGLsVKJI7cX9BEAFuLvKvwj6sORjWsvS6pqDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBqyZ45W9RDORnHHWkcJApD07rBcF6Te6kro7wkwFYiJ6mJb2WXxF4a5i18695iQ0
         s+kkDouQvzHK2jqsjI+hhmRroRIzc2dupO364dDPduQki+DIFqDnbGcjRBv5i7pVrJ
         d+mZfLlj/UJROXrRP1AOEH+W8HrLp8LZfuwOq27kM+LYBB1sWkWUnp3v83hkaJgPju
         Kh1igjcEJsvJLjeQPfA+pKRhHEzFCDuM6b5XCMNb2RS/B3LmYWsO7YUZwA0BU+8aDy
         Nd+dIM87/TBbEHwehBi4LTPD4dYAuCDXOjh0K/u/OreAnWsJVRJTyvOv+eLMPjmF/1
         CdLLUk6EHw38Q==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Pengfei Xu <pengfei.xu@intel.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        heng.su@intel.com, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] kprobes: Fix to handle forcibly unoptimized kprobes on freeing_list
Date:   Mon, 23 Jan 2023 22:24:05 +0900
Message-Id: <167448024501.3253718.13037333683110512967.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <Y8URdIfVr3pq2X8w@xpf.sh.intel.com>
References: <Y8URdIfVr3pq2X8w@xpf.sh.intel.com>
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

Sinec forcibly unoptimized kprobes will be put on the freeing_list directly
in the unoptimize_kprobe(), do_unoptimize_kprobes() must continue to check
the freeing_list even if unoptimizing_list is empty.

This bug can be happen if a kprobe is put in an instruction which is in the
middle of the jump-replaced instruction sequence of an optprobe, *and* the
optprobe is recently unregistered and queued on unoptimizing_list.
In this case, the optprobe will be unoptimized forcibly (means immediately)
and put it into the freeing_list, expecting the optprobe will be handled in
do_unoptimize_kprobe().
But if there is no other optprobes on the unoptimizing_list, current code
returns from the do_unoptimize_kprobe() soon and do not handle the optprobe
which is on the freeing_list, and it will hit the WARN_ON_ONCE() in the
do_free_cleaned_kprobes(), because it is not handled in the latter loop of
the do_unoptimize_kprobe().

To solve this issue, do not return from do_unoptimize_kprobes() immediately
even if unoptimizing_list is empty.

Moreover, this change affects another case. kill_optimized_kprobes() expects
kprobe_optimizer() will just free the optprobe on freeing_list.
So I changed it to just do list_move() to freeing_list if optprobes are on
unoptimizing list. And the do_unoptimize_kprobe() will skip
arch_disarm_kprobe() if the probe on freeing_list has gone flag.

Link: https://lore.kernel.org/all/Y8URdIfVr3pq2X8w@xpf.sh.intel.com/

Fixes: e4add247789e ("kprobes: Fix optimize_kprobe()/unoptimize_kprobe() cancellation logic")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1c18ecf9f98b..73b150fad936 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -555,17 +555,15 @@ static void do_unoptimize_kprobes(void)
 	/* See comment in do_optimize_kprobes() */
 	lockdep_assert_cpus_held();
 
-	/* Unoptimization must be done anytime */
-	if (list_empty(&unoptimizing_list))
-		return;
+	if (!list_empty(&unoptimizing_list))
+		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 
-	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
-	/* Loop on 'freeing_list' for disarming */
+	/* Loop on 'freeing_list' for disarming and removing from kprobe hash list */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-		/* Disarm probes if marked disabled */
-		if (kprobe_disabled(&op->kp))
+		/* Disarm probes if marked disabled and not gone */
+		if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
 			arch_disarm_kprobe(&op->kp);
 		if (kprobe_unused(&op->kp)) {
 			/*
@@ -797,14 +795,13 @@ static void kill_optimized_kprobe(struct kprobe *p)
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 
 	if (kprobe_unused(p)) {
-		/* Enqueue if it is unused */
-		list_add(&op->list, &freeing_list);
 		/*
-		 * Remove unused probes from the hash list. After waiting
-		 * for synchronization, this probe is reclaimed.
-		 * (reclaiming is done by do_free_cleaned_kprobes().)
+		 * Unused kprobe is on unoptimizing or freeing list. We move it
+		 * to freeing_list and let the kprobe_optimizer() removes it from
+		 * the kprobe hash list and frees it.
 		 */
-		hlist_del_rcu(&op->kp.hlist);
+		if (optprobe_queued_unopt(op))
+			list_move(&op->list, &freeing_list);
 	}
 
 	/* Don't touch the code, because it is already freed. */

