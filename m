Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0406395C2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 12:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKZLqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 06:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:46:20 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7932E1FCDB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:19 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NK8xG36J7zJnt8;
        Sat, 26 Nov 2022 19:42:58 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 19:46:17 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 19:46:17 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mhiramat@kernel.org>
CC:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <lihuafei1@huawei.com>
Subject: [PATCH] kprobes: Fix check for probe enabled in kill_kprobe()
Date:   Sat, 26 Nov 2022 19:43:16 +0800
Message-ID: <20221126114316.201857-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 3031313eb3d54 ("kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
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
2.17.1

