Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626CC6173CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKCBkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCBj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:39:59 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB90211179
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:39:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id EBB771E80D1A;
        Thu,  3 Nov 2022 09:37:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BxzDOGM0ExRa; Thu,  3 Nov 2022 09:37:54 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 470451E80CEE;
        Thu,  3 Nov 2022 09:37:54 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, keescook@chromium.org,
        mhiramat@kernel.org, edumazet@google.com,
        christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] init: main: Remove unnecessary (void*) conversions
Date:   Thu,  3 Nov 2022 09:39:53 +0800
Message-Id: <20221103013953.3203-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 1fe7942f5d4a..6ac4a7f8d034 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1237,7 +1237,7 @@ __setup("initcall_blacklist=", initcall_blacklist);
 static __init_or_module void
 trace_initcall_start_cb(void *data, initcall_t fn)
 {
-	ktime_t *calltime = (ktime_t *)data;
+	ktime_t *calltime = data;
 
 	printk(KERN_DEBUG "calling  %pS @ %i\n", fn, task_pid_nr(current));
 	*calltime = ktime_get();
@@ -1246,7 +1246,7 @@ trace_initcall_start_cb(void *data, initcall_t fn)
 static __init_or_module void
 trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 {
-	ktime_t rettime, *calltime = (ktime_t *)data;
+	ktime_t rettime, *calltime = data;
 
 	rettime = ktime_get();
 	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
-- 
2.18.2

