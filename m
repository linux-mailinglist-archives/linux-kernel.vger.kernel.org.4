Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406F55E9A52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiIZHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiIZHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:18:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A82EF07
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:18:11 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MbYs057hkz1P71t;
        Mon, 26 Sep 2022 15:13:56 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 15:18:09 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 15:18:09 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengyejian1@huawei.com>
Subject: [PATCH] ftrace: Properly unset FTRACE_HASH_FL_MOD
Date:   Mon, 26 Sep 2022 15:20:08 +0000
Message-ID: <20220926152008.2239274-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing following commands like what document said, but the log
"#### all functions enabled ####" was not shown as expect:
  1. Set a 'mod' filter:
    $ echo 'write*:mod:ext3' > /sys/kernel/tracing/set_ftrace_filter
  2. Invert above filter:
    $ echo '!write*:mod:ext3' >> /sys/kernel/tracing/set_ftrace_filter
  3. Read the file:
    $ cat /sys/kernel/tracing/set_ftrace_filter

By some debugging, I found that flag FTRACE_HASH_FL_MOD was not unset
after inversion like above step 2 and then result of ftrace_hash_empty()
is incorrect.

Cc: stable@vger.kernel.org
Fixes: 8c08f0d5c6fb ("ftrace: Have cached module filters be an active filter")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 439e2ab6905e..5a1ec7e1af33 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6081,8 +6081,12 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 		if (filter_hash) {
 			orig_hash = &iter->ops->func_hash->filter_hash;
-			if (iter->tr && !list_empty(&iter->tr->mod_trace))
-				iter->hash->flags |= FTRACE_HASH_FL_MOD;
+			if (iter->tr) {
+				if (list_empty(&iter->tr->mod_trace))
+					iter->hash->flags &= ~FTRACE_HASH_FL_MOD;
+				else
+					iter->hash->flags |= FTRACE_HASH_FL_MOD;
+			}
 		} else
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
-- 
2.25.1

