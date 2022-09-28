Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3B5ED2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiI1Bpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiI1Bpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:45:47 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77EB21E3E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:45:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 528A11E80D40;
        Wed, 28 Sep 2022 09:41:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1a6pOUBdVnZH; Wed, 28 Sep 2022 09:41:26 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 90A9C1E80D33;
        Wed, 28 Sep 2022 09:41:25 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, mhiramat@kernel.org,
        rostedt@goodmis.org, edumazet@google.com, zhoujie@nfschina.com,
        ahalaney@redhat.com, rdunlap@infradead.org,
        christophe.leroy@csgroup.eu, rppt@kernel.org,
        mark-pk.tsai@mediatek.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] init:Remove unnecessary (void*) conversions
Date:   Wed, 28 Sep 2022 09:45:39 +0800
Message-Id: <20220928014539.11046-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void pointer object can be directly assigned to different structure
objects, it does not need to be cast.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..5494caa24738 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1239,7 +1239,7 @@ __setup("initcall_blacklist=", initcall_blacklist);
 static __init_or_module void
 trace_initcall_start_cb(void *data, initcall_t fn)
 {
-	ktime_t *calltime = (ktime_t *)data;
+	ktime_t *calltime = data;
 
 	printk(KERN_DEBUG "calling  %pS @ %i\n", fn, task_pid_nr(current));
 	*calltime = ktime_get();
@@ -1248,7 +1248,7 @@ trace_initcall_start_cb(void *data, initcall_t fn)
 static __init_or_module void
 trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 {
-	ktime_t rettime, *calltime = (ktime_t *)data;
+	ktime_t rettime, *calltime = data;
 
 	rettime = ktime_get();
 	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
-- 
2.18.2

