Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF96648F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLJOHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLJOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:06:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384061BE8D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C526960C24
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 14:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4AEC433F0;
        Sat, 10 Dec 2022 14:03:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40SH-000l4y-0w;
        Sat, 10 Dec 2022 09:03:53 -0500
Message-ID: <20221210140353.153775027@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 09:03:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Huafei <lihuafei1@huawei.com>
Subject: [for-next][PATCH 3/3] kprobes: Fix check for probe enabled in kill_kprobe()
References: <20221210140320.609495935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Huafei <lihuafei1@huawei.com>

In kill_kprobe(), the check whether disarm_kprobe_ftrace() needs to be
called always fails. This is because before that we set the
KPROBE_FLAG_GONE flag for kprobe so that "!kprobe_disabled(p)" is always
false.

The disarm_kprobe_ftrace() call introduced by commit:

  0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")

to fix the NULL pointer reference problem. When the probe is enabled, if
we do not disarm it, this problem still exists.

Fix it by putting the probe enabled check before setting the
KPROBE_FLAG_GONE flag.

Link: https://lore.kernel.org/all/20221126114316.201857-1-lihuafei1@huawei.com/

Fixes: 3031313eb3d54 ("kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3050631e528d..a35074f0daa1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2364,6 +2364,14 @@ static void kill_kprobe(struct kprobe *p)
 
 	lockdep_assert_held(&kprobe_mutex);
 
+	/*
+	 * The module is going away. We should disarm the kprobe which
+	 * is using ftrace, because ftrace framework is still available at
+	 * 'MODULE_STATE_GOING' notification.
+	 */
+	if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
+		disarm_kprobe_ftrace(p);
+
 	p->flags |= KPROBE_FLAG_GONE;
 	if (kprobe_aggrprobe(p)) {
 		/*
@@ -2380,14 +2388,6 @@ static void kill_kprobe(struct kprobe *p)
 	 * the original probed function (which will be freed soon) any more.
 	 */
 	arch_remove_kprobe(p);
-
-	/*
-	 * The module is going away. We should disarm the kprobe which
-	 * is using ftrace, because ftrace framework is still available at
-	 * 'MODULE_STATE_GOING' notification.
-	 */
-	if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
-		disarm_kprobe_ftrace(p);
 }
 
 /* Disable one kprobe */
-- 
2.35.1


